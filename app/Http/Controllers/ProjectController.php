<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use Laravel\Sanctum\PersonalAccessToken;

class ProjectController extends Controller
{

    public function viewAllProjects(Request $request)
    {
        // Validate the request
        $request->validate([
            'portfolio_id' => 'required|integer',
        ]);

        $portfolioId = $request->input('portfolio_id');

        // Verify the portfolio exists and user is active
        $portfolio = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select('portfolios.*', 'users.status as user_status', 'users.name as owner_name', 'users.google_id as owner_google_id')
            ->where('portfolios.id', $portfolioId)
            ->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Only continue if user is active (status = 1)
        if ($portfolio->user_status !== 1) {
            return response()->json(['error' => 'Portfolio not available.'], 200);
        }

        $user = $request->user();

        // Retrieve all projects for the specified portfolio
        $projectsQuery = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'projects.project_visibility_status',
                'users.id as owner_id',
                'users.name as owner_name',
                'users.google_id as owner_google_id'
            )
            ->where('projects.portfolio_id', $portfolioId)
            ->where('users.status', 1); // Only include projects where user_status = 1

        // If user is not the owner, only show public projects
        if (!$user || $user->google_id !== $portfolio->user_id) {
            $projectsQuery->where('projects.project_visibility_status', 0); // Only public
        }

        $projects = $projectsQuery->get();

        // Get collaborator information for each project
        $projectsWithCollaborators = $projects->map(function ($project) {
            // Get collaborators for this project
            $collaborators = DB::table('project_collaborators')
                ->join('users', 'project_collaborators.user_id', '=', 'users.google_id')
                ->leftJoin('project_collaborator_invitation_statuses', function ($join) use ($project) {
                    $join->on('project_collaborators.user_id', '=', 'project_collaborator_invitation_statuses.collaborator_id')
                        ->where('project_collaborator_invitation_statuses.project_id', '=', DB::raw("'{$project->project_id}'"));
                })
                ->where('project_collaborators.project_id', $project->project_id)
                ->select(
                    'users.id',
                    'users.name',
                    'users.google_id',
                    'project_collaborator_invitation_statuses.project_collab_status_id'
                )
                ->where(function ($query) {
                    // Only include accepted collaborators (status 2) or null for backwards compatibility
                    $query->where('project_collaborator_invitation_statuses.project_collab_status_id', 2)
                        ->orWhereNull('project_collaborator_invitation_statuses.project_collab_status_id');
                })
                ->get()
                ->map(function ($collaborator) {
                    return [
                        'id' => $collaborator->id,
                        'name' => $collaborator->name,
                        'google_id' => $collaborator->google_id,
                        'is_owner' => 1
                    ];
                })
                ->toArray();

            // Add the owner as the first collaborator
            $allCollaborators = array_merge([[
                'id' => $project->owner_id,
                'name' => $project->owner_name,
                'google_id' => $project->owner_google_id,
                'is_owner' => 0
            ]], $collaborators);

            return [
                'portfolio_id' => $project->portfolio_id,
                'project_id' => $project->project_id,
                'title' => $project->title,
                'project_visibility_status' => $project->project_visibility_status,
                'collaborators' => $allCollaborators
            ];
        });

        // Return the projects data
        return response()->json([
            'projects' => $projectsWithCollaborators
        ]);
    }

    public function viewProjectDetail($projectId, Request $request)
    {
        // Retrieve the project details with user's authentication token
        $project = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id') // Use users.google_id for authentication
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'users.google_id as user_id',
                'projects.project_visibility_status',
                'users.status as user_status' // Added user_status field
            )
            ->where('projects.id', $projectId)
            ->first();

        // Check if the project exists
        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Check if user has been banned (status = 0)
        if ($project->user_status === 0) {
            return response()->json([
                'error' => 'The user portfolio has been banned.',
                'user_status' => 0
            ], 200);
        }

        // Check if the project is public
        if ($project->project_visibility_status == 0) {
            return $this->getFullProjectDetails($projectId);
        }

        // Instead of using $request->user(), we get token from body
        $token = $request->input('token'); // <-- Get token from body

        if (!$token) {
            return response()->json(['error' => 'Authentication token required.'], 401);
        }

        // Manually authenticate user using the token
        $user = \Laravel\Sanctum\PersonalAccessToken::findToken($token)?->tokenable;

        if (!$user) {
            return response()->json(['error' => 'Invalid token.'], 401);
        }

        // Check if the authenticated user is either the project owner or a collaborator
        $isOwner = ($user->google_id == $project->user_id);

        if (!$isOwner) {
            // Check if user is a collaborator with accepted status (2)
            $isCollaborator = DB::table('project_collaborators')
                ->join('project_collaborator_invitation_statuses', function ($join) use ($projectId) {
                    $join->on('project_collaborators.user_id', '=', 'project_collaborator_invitation_statuses.collaborator_id')
                        ->where('project_collaborator_invitation_statuses.project_id', '=', $projectId);
                })
                ->where('project_collaborators.project_id', $projectId)
                ->where('project_collaborators.user_id', $user->google_id)
                ->where('project_collaborator_invitation_statuses.project_collab_status_id', 2) // 2 = Accepted status
                ->exists();

            if (!$isCollaborator) {
                return response()->json(['error' => 'This project is private.'], 403);
            }
        }

        // If the user is the owner or an accepted collaborator, return full project details
        return $this->getFullProjectDetails($projectId);
    }


    // Method to return full project details
    private function getFullProjectDetails($projectId)
    {
        // Get full project details (the rest of your original logic)
        $fullProject = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id') // Use users.id for authentication
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'projects.description',
                'projects.instruction',
                'projects.link',
                DB::raw("CASE
                WHEN projects.file IS NOT NULL 
                THEN CONCAT('https://talenthub.newlinkmarketing.com/storage/', projects.file)
                ELSE NULL
            END as file"),
                'projects.project_visibility_status',
                'users.name as owner_name',
                'users.photo as owner_photo',
                'users.google_id as google_id',
                'users.status as user_status'
            )
            ->where('projects.id', $projectId)
            ->first();

        // Get all programming languages for this project
        $programmingLanguages = DB::table('project_languages')
            ->join('programming_languages', 'project_languages.programming_language_id', '=', 'programming_languages.id')
            ->where('project_languages.project_id', $projectId)
            ->select('programming_languages.id', 'programming_languages.programming_language')
            ->get()
            ->map(function ($language) {
                return [
                    'id' => $language->id,
                    'name' => $language->programming_language
                ];
            })
            ->toArray();

        // Get project images
        $images = DB::table('project_images')
            ->where('project_id', $projectId)
            ->get()
            ->map(function ($image) {
                return [
                    'id' => $image->id,
                    'url' => 'https://talenthub.newlinkmarketing.com/storage/' . $image->image
                ];
            });



        // Get project endorsers with their endorsement status
        $endorsers = DB::table('project_endorsers')
            ->join('users', 'project_endorsers.user_id', '=', 'users.google_id') // Use users.id for authentication
            ->leftJoin('project_endorsement_statuses', function ($join) use ($projectId) {
                $join->on('project_endorsers.user_id', '=', 'project_endorsement_statuses.endorser_id')
                    ->where('project_endorsement_statuses.project_id', '=', DB::raw('project_endorsers.project_id'));
            })
            ->where('project_endorsers.project_id', $projectId)
            ->select(
                'users.id',
                'users.name',
                'users.email',
                'users.google_id',
                'users.photo',
                'project_endorsement_statuses.endorsement_status_id'
            )
            ->get()
            ->map(function ($endorser) {
                return [
                    'id' => $endorser->id,
                    'name' => $endorser->name,
                    'email' => $endorser->email,
                    'google_id' => $endorser->google_id,
                    'photo' => $endorser->photo,
                    'endorsement_status' => $endorser->endorsement_status_id ?? 0, // Default to 0 if null
                ];
            })
            ->toArray();

        // Get project collaborators with their invitation status
        $collaborators = DB::table('project_collaborators')
            ->join('users', 'project_collaborators.user_id', '=', 'users.google_id') // Use users.id for authentication
            ->leftJoin('project_collaborator_invitation_statuses', function ($join) use ($projectId) {
                $join->on('project_collaborators.user_id', '=', 'project_collaborator_invitation_statuses.collaborator_id')
                    ->where('project_collaborator_invitation_statuses.project_id', '=', DB::raw('project_collaborators.project_id'));
            })
            ->where('project_collaborators.project_id', $projectId)
            ->select(
                'users.id',
                'users.name',
                'users.email',
                'users.photo',
                'users.google_id',
                'project_collaborator_invitation_statuses.project_collab_status_id'
            )
            ->get()
            ->map(function ($collaborator) {
                return [
                    'id' => $collaborator->id,
                    'name' => $collaborator->name,
                    'email' => $collaborator->email,
                    'google_id' => $collaborator->google_id,
                    'photo' => $collaborator->photo,
                    'collaboration_status' => $collaborator->project_collab_status_id ?? 0, // Default to 0 if null
                ];
            })
            ->toArray();

        // Combine project details with images, languages, endorsers and collaborators
        $response = (array) $fullProject;
        $response['programming_languages'] = $programmingLanguages;
        $response['images'] = $images;
        $response['endorsers'] = $endorsers;
        $response['collaborators'] = $collaborators;

        // Return the project details
        return response()->json($response, 200, [], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    }





    public function createProject(Request $request)
    {
        // Validate the incoming request data
        $request->validate([
            'portfolio_id' => 'required|integer',
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'instruction' => 'nullable|string',
            'link' => 'nullable|string|max:255',
            'file' => 'nullable|file',  // Validate file
            'image' => 'nullable|array',  // Ensure image is an array for multiple upload
            'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg', // Validate each image in array
            'programming_languages' => 'nullable|array', // Changed to nullable array of languages
            'programming_languages.*' => 'string|max:255', // Validate each language
        ]);

        // Get the authenticated user's ID
        $userId = $request->user()->google_id;

        // Check if the portfolio belongs to the authenticated user
        $portfolio = DB::table('portfolios')->where('id', $request->input('portfolio_id'))->first();

        if (!$portfolio || $portfolio->user_id != $userId) {
            return response()->json(['error' => 'You are not authorized to create a project for this portfolio.'], 403);
        }

        // Process languages - create any that don't exist and collect IDs
        $programmingLanguageIds = [];
        $primaryLanguageId = null;

        if ($request->has('programming_languages') && is_array($request->input('programming_languages'))) {
            $programmingLanguageNames = $request->input('programming_languages');

            foreach ($programmingLanguageNames as $languageName) {
                // Check if the language already exists
                $language = DB::table('programming_languages')
                    ->where('programming_language', $languageName)
                    ->first();

                if (!$language) {
                    // Create a new programming language
                    $languageId = DB::table('programming_languages')->insertGetId([
                        'programming_language' => $languageName,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                    $programmingLanguageIds[] = $languageId;
                } else {
                    $programmingLanguageIds[] = $language->id;
                }
            }

            // Use the first language as the primary language for the project
            $primaryLanguageId = !empty($programmingLanguageIds) ? $programmingLanguageIds[0] : null;
        }

        // Handle file upload (for project file)
        $filePath = null;
        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $filePath = $file->store('projects', 'public'); // Store file in 'projects' folder, 'public' disk
        }

        // Insert the project into the database and get the ID
        $projectId = DB::table('projects')->insertGetId([
            'portfolio_id' => $request->input('portfolio_id'),
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'instruction' => $request->input('instruction'),
            'link' => $request->input('link'),
            'file' => $filePath, // Store the file path
            'programming_language_id' => $primaryLanguageId, // Use the first language as primary or null
            'project_visibility_status' => 0,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Create relationships in project_languages table for all languages
        if (!empty($programmingLanguageIds)) {
            foreach ($programmingLanguageIds as $languageId) {
                DB::table('project_languages')->insert([
                    'project_id' => $projectId,
                    'programming_language_id' => $languageId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        // Handle multiple image uploads with a maximum of 6 images
        $imagePaths = [];
        if ($request->hasFile('image')) {
            $images = $request->file('image');

            // Check if the number of images exceeds the limit (6)
            if (count($images) > 6) {
                return response()->json([
                    'error' => 'Maximum of 6 images allowed per project.',
                ], 422);
            }

            foreach ($images as $image) {
                try {
                    if ($image->isValid()) {
                        $imagePath = $image->store('project_images', 'public');
                        $imagePaths[] = $imagePath;
                    } else {
                        // Log error for invalid image
                    }
                } catch (\Exception $e) {
                    // Log error for upload failure
                }
            }
        }

        // Insert images into the project_images table
        $imageUrls = [];
        if (!empty($imagePaths)) {
            foreach ($imagePaths as $imagePath) {
                try {
                    DB::table('project_images')->insert([
                        'project_id' => $projectId,
                        'image' => $imagePath,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);

                    // Build image URL
                    $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
                    $imageUrls[] = $baseUrl . $imagePath;
                } catch (\Exception $e) {
                    // Log error for database insertion failure
                }
            }
        }

        // Base URL for accessing the files
        $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
        $fileUrl = $filePath ? $baseUrl . $filePath : null;

        // Get all languages for this project (if any)
        $projectLanguages = [];
        if (!empty($programmingLanguageIds)) {
            $projectLanguages = DB::table('project_languages')
                ->join('programming_languages', 'project_languages.programming_language_id', '=', 'programming_languages.id')
                ->where('project_id', $projectId)
                ->pluck('programming_languages.programming_language')
                ->toArray();
        }

        // Fetch the complete project details to return
        $projectDetails = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'projects.description',
                'projects.instruction',
                'projects.link'
            )
            ->where('projects.id', $projectId)
            ->first();

        // Add the languages to the response
        $projectDetailsArray = (array)$projectDetails;
        $projectDetailsArray['programming_languages'] = $projectLanguages;

        return response()->json([
            'message' => 'Project created successfully.',
            'project' => $projectDetailsArray,
            'file_url' => $fileUrl,
            'image_urls' => $imageUrls, // Array of image URLs
        ], 200);
    }


    public function updateProject(Request $request, $id)
    {
        try {
            // Validate request
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'instruction' => 'nullable|string',
                'link' => 'nullable|string|max:255',
                'file' => 'nullable|mimes:zip',
                'image' => 'nullable',
                'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg',
                'programming_languages' => 'nullable|array',
                'programming_languages.*' => 'string|max:255',
            ]);

            // Fetch project
            $project = DB::table('projects')->where('id', $id)->first();
            if (!$project) {
                return response()->json(['error' => 'Project not found.'], 404);
            }

            // Check authorization
            $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
            $userId = $request->user()->google_id;

            if (!$portfolio || $portfolio->user_id != $userId) {
                return response()->json(['error' => 'Unauthorized.'], 403);
            }

            // Check image count
            if ($request->hasFile('image')) {
                $newImageCount = count($request->file('image'));

                // Count existing images
                $existingImageCount = DB::table('project_images')
                    ->where('project_id', $id)
                    ->count();

                if ($existingImageCount + $newImageCount > 6) {
                    return response()->json([
                        'error' => 'Maximum of 6 images allowed per project.',
                    ], 422);
                }
            }

            // Handle programming languages
            $programmingLanguageIds = [];
            if ($request->has('programming_languages') && is_array($request->input('programming_languages'))) {
                foreach ($request->input('programming_languages') as $languageName) {
                    $language = DB::table('programming_languages')
                        ->where('programming_language', $languageName)
                        ->first();

                    if (!$language) {
                        $languageId = DB::table('programming_languages')->insertGetId([
                            'programming_language' => $languageName,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                        $programmingLanguageIds[] = $languageId;
                    } else {
                        $programmingLanguageIds[] = $language->id;
                    }
                }
            }

            // Set primary language ID or null if no languages provided
            $primaryLanguageId = !empty($programmingLanguageIds) ? $programmingLanguageIds[0] : null;

            // Handle file upload
            $filePath = $project->file;
            if ($request->hasFile('file')) {
                try {
                    // Delete old file if it exists
                    $oldFilePath = public_path('storage/' . $project->file);
                    if ($project->file && file_exists($oldFilePath)) {
                        unlink($oldFilePath);
                    }

                    // Store new file
                    $file = $request->file('file');
                    $filename = time() . '_' . $file->getClientOriginalName();
                    $destinationPath = public_path('storage/projects');
                    if (!file_exists($destinationPath)) {
                        mkdir($destinationPath, 0755, true);
                    }
                    $file->move($destinationPath, $filename);
                    $filePath = 'projects/' . $filename;
                } catch (\Exception $e) {
                    return response()->json(['error' => 'File upload failed', 'message' => $e->getMessage()], 500);
                }
            }

            // Handle image upload
            if ($request->hasFile('image')) {
                foreach ($request->file('image') as $index => $image) {
                    try {
                        if ($image->isValid()) {
                            $imagePath = $image->store('project_images', 'public');

                            DB::table('project_images')->insert([
                                'project_id' => $id,
                                'image' => $imagePath,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                        }
                    } catch (\Exception $e) {
                        // Continue with other images even if one fails
                    }
                }
            }

            // Update project record
            DB::table('projects')->where('id', $id)->update([
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'instruction' => $request->input('instruction'),
                'link' => $request->input('link'),
                'file' => $filePath,
                'programming_language_id' => $primaryLanguageId,
                'updated_at' => now(),
            ]);

            // Sync languages
            DB::table('project_languages')->where('project_id', $id)->delete();

            // Only insert languages if we have any
            if (!empty($programmingLanguageIds)) {
                foreach ($programmingLanguageIds as $languageId) {
                    DB::table('project_languages')->insert([
                        'project_id' => $id,
                        'programming_language_id' => $languageId,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                }
            }

            // Prepare response
            $fileUrl = $filePath ? asset('storage/' . $filePath) : null;
            $allImages = DB::table('project_images')->where('project_id', $id)->get()->map(function ($image) {
                return [
                    'id' => $image->id,
                    'url' => asset('storage/' . $image->image),
                ];
            });

            $programmingLanguages = DB::table('project_languages')
                ->join('programming_languages', 'project_languages.programming_language_id', '=', 'programming_languages.id')
                ->where('project_languages.project_id', $id)
                ->select('programming_languages.id', 'programming_languages.programming_language')
                ->get()
                ->map(function ($lang) {
                    return [
                        'id' => $lang->id,
                        'name' => $lang->programming_language,
                    ];
                });

            $projectDetails = DB::table('projects')
                ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
                ->select(
                    'portfolios.id as portfolio_id',
                    'projects.id as project_id',
                    'projects.title',
                    'projects.description',
                    'projects.instruction',
                    'projects.link',
                    'projects.project_visibility_status'
                )
                ->where('projects.id', $id)
                ->first();

            $projectDetailsArray = (array) $projectDetails;
            $projectDetailsArray['programming_languages'] = $programmingLanguages;

            return response()->json([
                'message' => 'Project updated successfully.',
                'project' => $projectDetailsArray,
                'file_url' => $fileUrl,
                'images' => $allImages,
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['error' => 'Validation failed', 'errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating the project.',
                'message' => $e->getMessage()
            ], 500);
        }
    }



    public function removeProjectImage(Request $request, $imageId)
    {
        $image = DB::table('project_images')->where('id', $imageId)->first();

        if (!$image) {
            return response()->json(['error' => 'Image not found.'], 404);
        }

        // Authorization: Ensure user owns the project
        $project = DB::table('projects')->where('id', $image->project_id)->first();
        $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();

        if (!$portfolio || $portfolio->user_id !== $request->user()->google_id) {
            return response()->json(['error' => 'Unauthorized.'], 403);
        }

        // Check if this is the only remaining image for the project
        $imageCount = DB::table('project_images')
            ->where('project_id', $image->project_id)
            ->count();

        // if ($imageCount <= 1) {
        //     return response()->json([
        //         'error' => 'Cannot delete the last image. Projects must have at least one image.',
        //     ], 422);
        // }

        // Delete image from storage
        $imagePath = storage_path('app/public/' . $image->image);
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        // Remove DB record
        DB::table('project_images')->where('id', $imageId)->delete();

        return response()->json([
            'message' => 'Project image deleted successfully.',
            'remaining_count' => $imageCount - 1
        ]);
    }
    public function removeProjectFile(Request $request, $projectId)
    {
        $project = DB::table('projects')->where('id', $projectId)->first();

        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Authorization: Ensure user owns the project
        $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
        if (!$portfolio || $portfolio->user_id !== $request->user()->google_id) {
            return response()->json(['error' => 'Unauthorized.'], 403);
        }

        // Delete the file from storage
        if ($project->file) {
            $filePath = storage_path('app/public/' . $project->file);
            if (file_exists($filePath)) {
                unlink($filePath);
                // Log::info('Deleted file from storage: ' . $filePath);
            }
        }

        // Update project to remove file reference
        DB::table('projects')->where('id', $projectId)->update([
            'file' => null,
            'updated_at' => now(),
        ]);

        return response()->json(['message' => 'Project file deleted successfully.']);
    }



    public function deleteProject($id)
    {
        $project = DB::table('projects')->where('id', $id)->first();

        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Delete project file from storage
        if ($project->file) {
            $filePath = storage_path('app/public/' . $project->file);
            if (file_exists($filePath)) {
                unlink($filePath);
                // Log::info('Deleted project file: ' . $filePath);
            }
        }

        // Delete associated images from storage
        $images = DB::table('project_images')->where('project_id', $id)->get();
        foreach ($images as $image) {
            $imagePath = storage_path('app/public/' . $image->image);
            if (file_exists($imagePath)) {
                unlink($imagePath);
                // Log::info('Deleted project image: ' . $imagePath);
            }
        }

        // Delete image records
        DB::table('project_images')->where('project_id', $id)->delete();

        // Delete the project
        DB::table('projects')->where('id', $id)->delete();

        return response()->json(['message' => 'Project and associated files/images deleted successfully.']);
    }


    public function downloadProject($id, Request $request)
    {
        // Validate the query parameter
        $request->validate([
            'portfolio_id' => 'required|integer',
        ]);

        $portfolioId = $request->query('portfolio_id');

        // Log the input parameters for debugging
        // Log::info('downloadProject request:', [
        //     'project_id' => $id,
        //     'portfolio_id' => $portfolioId
        // ]);

        // First verify the project exists independently
        $projectExists = DB::table('projects')
            ->where('id', $id)
            ->exists();

        if (!$projectExists) {
            // Log::error('Project not found with ID: ' . $id);
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Then verify the portfolio exists
        $portfolioExists = DB::table('portfolios')
            ->where('id', $portfolioId)
            ->exists();

        if (!$portfolioExists) {
            // Log::error('Portfolio not found with ID: ' . $portfolioId);
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Now find the project with the correct portfolio relationship and check visibility status
        $project = DB::table('projects')
            ->select(
                'projects.id',
                'projects.title',
                'projects.link',
                'projects.file',
                'projects.portfolio_id',
                'projects.project_visibility_status'
            )
            ->where('id', $id)
            ->first();

        // Verify the project belongs to the specified portfolio
        if ($project->portfolio_id != $portfolioId) {
            // Log::error('Project ' . $id . ' does not belong to portfolio ' . $portfolioId);
            return response()->json(['error' => 'Project does not belong to the specified portfolio.'], 404);
        }

        // Check if project is public (project_visibility_status = 0)
        if ($project->project_visibility_status != 0) {
            // Log::error('Project ' . $id . ' is not public. Visibility status: ' . $project->project_visibility_status);
            return response()->json(['error' => 'Project is not available for download.'], 403);
        }

        // Check if project has a file
        if (empty($project->file)) {
            return response()->json(['error' => 'Project has no downloadable file.'], 404);
        }

        // Return the file URL in the requested format
        $fileUrl = 'https://talenthub.newlinkmarketing.com/storage/' . $project->file;

        // Log::info('Project download response prepared with file URL: ' . $fileUrl);
        return response()->json([
            'file' => $fileUrl
        ]);
    }



    public function deleteEndorserRequest(Request $request, $projectId)
    {
        try {
            // Validate the request to ensure user_google_id is provided
            $request->validate([
                'user_google_id' => 'required|string',
            ]);

            $userGoogleId = $request->input('user_google_id');

            // Check if the project exists
            $project = DB::table('projects')->where('id', $projectId)->first();

            if (!$project) {
                return response()->json(['error' => 'Project not found.'], 404);
            }

            // Check if the authenticated user is the project owner
            $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();

            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            // Verify user has permission to delete this endorser
            if ($portfolio->user_id !== auth()->user()->google_id) {
                return response()->json(['error' => 'You are not authorized to delete this endorser request.'], 403);
            }

            // Get the endorser record using project_id and user_google_id
            $endorser = DB::table('project_endorsers')
                ->where('project_id', $projectId)
                ->where('user_id', $userGoogleId)
                ->first();

            if (!$endorser) {
                return response()->json(['error' => 'Endorser request not found for this project.'], 404);
            }

            // Begin database transaction
            DB::beginTransaction();

            try {
                // Delete endorsement status record
                $statusDeleted = DB::table('project_endorsement_statuses')
                    ->where('project_id', $projectId)
                    ->where('endorser_id', $userGoogleId)
                    ->delete();

                // Delete endorser record
                $endorserDeleted = DB::table('project_endorsers')
                    ->where('project_id', $projectId)
                    ->where('user_id', $userGoogleId)
                    ->delete();

                // Delete any collaboration invitation statuses (if they exist)
                $collabStatusDeleted = DB::table('project_collaborator_invitation_statuses')
                    ->where('project_id', $projectId)
                    ->where('collaborator_id', $userGoogleId)
                    ->delete();

                // Commit the transaction
                DB::commit();

                return response()->json([
                    'message' => 'Endorser request deleted successfully.',

                ], 200);
            } catch (\Exception $e) {
                // If any part fails, roll back the entire transaction
                DB::rollBack();
                throw $e;
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while deleting the endorser request.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function deleteCollaboratorRequest(Request $request, $projectId)
    {
        try {
            // Validate the request to ensure user_google_id is provided
            $request->validate([
                'user_google_id' => 'required|string',
            ]);

            $userGoogleId = $request->input('user_google_id');

            // Check if the project exists
            $project = DB::table('projects')->where('id', $projectId)->first();

            if (!$project) {
                return response()->json(['error' => 'Project not found.'], 404);
            }

            // Check if the authenticated user is the project owner
            $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();

            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            // Verify user has permission to delete this collaborator
            if ($portfolio->user_id !== auth()->user()->google_id) {
                return response()->json(['error' => 'You are not authorized to delete this collaborator request.'], 403);
            }

            // Get the collaborator record using project_id and user_google_id
            $collaborator = DB::table('project_collaborators')
                ->where('project_id', $projectId)
                ->where('user_id', $userGoogleId)
                ->first();

            if (!$collaborator) {
                return response()->json(['error' => 'Collaborator request not found for this project.'], 404);
            }

            // Begin database transaction
            DB::beginTransaction();

            try {
                // Delete collaboration status record
                $statusDeleted = DB::table('project_collaborator_invitation_statuses')
                    ->where('project_id', $projectId)
                    ->where('collaborator_id', $userGoogleId)
                    ->delete();

                // Delete collaborator record
                $collaboratorDeleted = DB::table('project_collaborators')
                    ->where('project_id', $projectId)
                    ->where('user_id', $userGoogleId)
                    ->delete();

                // Commit the transaction
                DB::commit();

                return response()->json([
                    'message' => 'Collaborator request deleted successfully.',

                ], 200);
            } catch (\Exception $e) {
                // If any part fails, roll back the entire transaction
                DB::rollBack();
                throw $e;
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while deleting the collaborator request.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    // public function addEndorserToProject(Request $request, $projectId)
    // {
    //     try {
    //         // Log::info('addEndorserToProject called', [
    //         //     'project_id' => $projectId, 
    //         //     'emails' => $request->input('emails')
    //         // ]);

    //         // Validate the request data - only emails are required now
    //         $request->validate([
    //             'emails' => 'required|array',
    //             'emails.*' => 'email|max:255',
    //         ]);

    //         // Check if the project exists
    //         $project = DB::table('projects')->where('id', $projectId)->first();
    //         if (!$project) {
    //             // Log::error('Project not found', ['project_id' => $projectId]);
    //             return response()->json(['error' => 'Project not found.'], 404);
    //         }

    //         // Check if the authenticated user is the project owner
    //         $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
    //         if (!$portfolio) {
    //             // Log::error('Portfolio not found', ['portfolio_id' => $project->portfolio_id]);
    //             return response()->json(['error' => 'Portfolio not found.'], 404);
    //         }

    //         if ($portfolio->user_id !== $request->user()->google_id) {
    //             // Log::error('Unauthorized access attempt', [
    //             //     'user_id' => $request->user()->google_id,
    //             //     'portfolio_user_id' => $portfolio->user_id
    //             // ]);
    //             return response()->json(['error' => 'You are not authorized to add endorsers to this project.'], 403);
    //         }

    //         $endorser = [];
    //         $notFoundUsers = [];
    //         $notEndorserRoleUsers = []; // Array to track users without endorser role

    //         // Set the default endorsement status to 1 (pending)
    //         $endorsementStatusId = 1; // Pending status
    //         $rejectedStatusId = 3;   // Rejected status

    //         foreach ($request->input('emails') as $email) {
    //             // Log::info('Processing email', ['email' => $email]);

    //             // Find user by email
    //             $user = DB::table('users')->where('email', $email)->first();

    //             if (!$user) {
    //                 Log::info('User not found', ['email' => $email]);
    //                 $notFoundUsers[] = $email;
    //                 continue;
    //             }

    //             // Log::info('User found', [
    //             //     'email' => $email,
    //             //     'user_id' => $user->id,
    //             //     'google_id' => $user->google_id
    //             // ]);

    //             // Check if user has role_id = 2 (endorser role)
    //             $hasEndorserRole = $user->role_id === 2;

    //             if (!$hasEndorserRole) {
    //                 // Log::info('User does not have endorser role', [
    //                 //     'email' => $email,
    //                 //     'role_id' => $user->role_id
    //                 // ]);

    //                 $notEndorserRoleUsers[] = [
    //                     'email' => $email,
    //                     'name' => $user->name
    //                 ];
    //                 continue;
    //             }

    //             // Check if the endorser already exists for this project
    //             $existingEndorser = DB::table('project_endorsers')
    //                 ->where('project_id', $projectId)
    //                 ->where('user_id', $user->google_id)
    //                 ->first();

    //             $isNewEndorser = !$existingEndorser;

    //             // Check if this endorser previously rejected the request
    //             $existingStatus = DB::table('project_endorsement_statuses')
    //                 ->where('project_id', $projectId)
    //                 ->where('endorser_id', $user->google_id)
    //                 ->first();

    //             $wasRejected = $existingStatus && $existingStatus->endorsement_status_id === $rejectedStatusId;

    //             // If endorser already exists but previously rejected, allow a new request
    //             if (!$isNewEndorser && !$wasRejected) {
    //                 // Log::info('Endorser already exists and did not reject', [
    //                 //     'email' => $email,
    //                 //     'project_id' => $projectId,
    //                 //     'status' => $existingStatus ? $existingStatus->endorsement_status_id : 'none'
    //                 // ]);

    //                 // Get current status info for response
    //                 $currentStatus = $existingStatus;
    //             } else {
    //                 // This is either a new endorser or one who previously rejected

    //                 if ($wasRejected) {
    //                     // Log::info('Endorser previously rejected, creating new request', [
    //                     //     'email' => $email,
    //                     //     'project_id' => $projectId
    //                     // ]);
    //                 } else {
    //                     // Log::info('Adding new endorser', [
    //                     //     'email' => $email,
    //                     //     'project_id' => $projectId,
    //                     //     'user_id' => $user->google_id
    //                     // ]);

    //                     // Only add to project_endorsers if they don't exist already
    //                     if ($isNewEndorser) {
    //                         DB::table('project_endorsers')->insert([
    //                             'project_id' => $projectId,
    //                             'user_id' => $user->google_id,
    //                             'created_at' => now(),
    //                             'updated_at' => now(),
    //                         ]);
    //                     }
    //                 }

    //                 // Update or insert endorsement status
    //                 if ($wasRejected) {
    //                     // Update existing record if it was rejected
    //                     DB::table('project_endorsement_statuses')
    //                         ->where('project_id', $projectId)
    //                         ->where('endorser_id', $user->google_id)
    //                         ->update([
    //                             'endorsement_status_id' => $endorsementStatusId, // Set back to pending
    //                             'updated_at' => now(),
    //                         ]);
    //                 } else if (!$existingStatus) {
    //                     // Insert new record if none exists
    //                     DB::table('project_endorsement_statuses')->insert([
    //                         'project_id' => $projectId,
    //                         'endorser_id' => $user->google_id,
    //                         'endorsement_status_id' => $endorsementStatusId,
    //                         'created_at' => now(),
    //                         'updated_at' => now(),
    //                     ]);
    //                 }

    //                 // Get updated status for response
    //                 $currentStatus = DB::table('project_endorsement_statuses')
    //                     ->where('project_id', $projectId)
    //                     ->where('endorser_id', $user->google_id)
    //                     ->first();
    //             }

    //             // Get the status name for the response
    //             $statusName = DB::table('endorsement_statuses')
    //                 ->where('id', $currentStatus ? $currentStatus->endorsement_status_id : $endorsementStatusId)
    //                 ->value('status') ?? 'Pending';

    //             $endorser[] = [
    //                 'id' => $user->id,
    //                 'email' => $email,
    //                 'name' => $user->name,
    //                 'google_id' => $user->google_id,
    //                 'endorsement_status' => [
    //                     'id' => $currentStatus ? $currentStatus->endorsement_status_id : $endorsementStatusId,
    //                     'name' => $statusName
    //                 ],
    //             ];

    //             if ($isNewEndorser) {
    //                 // Log::info('Endorser successfully added', ['email' => $email]);
    //             } else if ($wasRejected) {
    //                 // Log::info('Rejected endorsement request renewed', ['email' => $email]);
    //             } else {
    //                 // Log::info('Existing endorser returned', ['email' => $email]);
    //             }
    //         }

    //         // Log::info('addEndorserToProject completed', [
    //         //     'endorser_count' => count($endorser),
    //         //     'not_found_count' => count($notFoundUsers),
    //         //     'not_endorser_role_count' => count($notEndorserRoleUsers)
    //         // ]);

    //         return response()->json([
    //             'message' => 'Endorsers processed successfully',
    //             'endorser' => $endorser,

    //         ], 200);
    //     } catch (\Exception $e) {
    //         // Log::error('Exception in addEndorserToProject', [
    //         //     'error' => $e->getMessage(),
    //         //     'trace' => $e->getTraceAsString(),
    //         //     'project_id' => $projectId
    //         // ]);

    //         return response()->json([
    //             'error' => 'An error occurred while adding endorsers.',
    //             'message' => $e->getMessage()
    //         ], 500);
    //     }
    // }

    // public function addCollaboratorToProject(Request $request, $projectId)
    // {
    //     try {
    //         // Validate the request data - only emails are required now
    //         $request->validate([
    //             'emails' => 'required|array',
    //             'emails.*' => 'email|max:255',
    //         ]);

    //         // Check if the project exists
    //         $project = DB::table('projects')->where('id', $projectId)->first();
    //         if (!$project) {
    //             return response()->json(['error' => 'Project not found.'], 404);
    //         }

    //         // Check if the authenticated user is the project owner
    //         $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
    //         if (!$portfolio) {
    //             return response()->json(['error' => 'Portfolio not found.'], 404);
    //         }

    //         if ($portfolio->user_id !== $request->user()->google_id) {
    //             return response()->json(['error' => 'You are not authorized to add collaborators to this project.'], 403);
    //         }

    //         // Get the project owner's name for the email
    //         $projectOwner = DB::table('users')
    //             ->where('google_id', $portfolio->user_id)
    //             ->first();

    //         if (!$projectOwner) {
    //             return response()->json(['error' => 'Project owner information not found.'], 404);
    //         }

    //         $collaborator = [];
    //         $notFoundUsers = [];

    //         // Set the default collaboration status to 1 (pending)
    //         $collaborationStatusId = 1; // Pending status
    //         $rejectedStatusId = 3;     // Rejected status

    //         foreach ($request->input('emails') as $email) {
    //             // Find user by email
    //             $user = DB::table('users')->where('email', $email)->first();

    //             if (!$user) {
    //                 $notFoundUsers[] = $email;
    //                 continue;
    //             }

    //             // Check if the collaborator already exists for this project
    //             $existingCollaborator = DB::table('project_collaborators')
    //                 ->where('project_id', $projectId)
    //                 ->where('user_id', $user->google_id)
    //                 ->first();

    //             $isNewCollaborator = !$existingCollaborator;

    //             // Check if this collaborator previously rejected the request
    //             $existingStatus = DB::table('project_collaborator_invitation_statuses')
    //                 ->where('project_id', $projectId)
    //                 ->where('collaborator_id', $user->google_id)
    //                 ->first();

    //             $wasRejected = $existingStatus && $existingStatus->project_collab_status_id === $rejectedStatusId;

    //             // If collaborator already exists but previously rejected, allow a new request
    //             if (!$isNewCollaborator && !$wasRejected) {
    //                 // Collaborator already exists and did not reject
    //                 // Get current status info for response
    //                 $currentStatus = $existingStatus;
    //             } else {
    //                 // This is either a new collaborator or one who previously rejected

    //                 if ($wasRejected) {
    //                     // Collaborator previously rejected, creating new request
    //                 } else {
    //                     // Only add to project_collaborators if they don't exist already
    //                     if ($isNewCollaborator) {
    //                         DB::table('project_collaborators')->insert([
    //                             'project_id' => $projectId,
    //                             'user_id' => $user->google_id,
    //                             'created_at' => now(),
    //                             'updated_at' => now(),
    //                         ]);
    //                     }
    //                 }

    //                 // Update or insert collaboration status
    //                 if ($wasRejected) {
    //                     // Update existing record if it was rejected
    //                     DB::table('project_collaborator_invitation_statuses')
    //                         ->where('project_id', $projectId)
    //                         ->where('collaborator_id', $user->google_id)
    //                         ->update([
    //                             'project_collab_status_id' => $collaborationStatusId, // Set back to pending
    //                             'updated_at' => now(),
    //                         ]);
    //                 } else if (!$existingStatus) {
    //                     // Insert new record if none exists
    //                     DB::table('project_collaborator_invitation_statuses')->insert([
    //                         'project_id' => $projectId,
    //                         'collaborator_id' => $user->google_id,
    //                         'project_collab_status_id' => $collaborationStatusId,
    //                         'created_at' => now(),
    //                         'updated_at' => now(),
    //                     ]);
    //                 }

    //                 // // Send email notification for new or renewed requests
    //                 // $this->sendCollaborationInvitationEmail(
    //                 //     $email,
    //                 //     $user->name,
    //                 //     $projectOwner->name,
    //                 //     $project->title,
    //                 //     $projectId
    //                 // );

    //                 // Get updated status for response
    //                 $currentStatus = DB::table('project_collaborator_invitation_statuses')
    //                     ->where('project_id', $projectId)
    //                     ->where('collaborator_id', $user->google_id)
    //                     ->first();
    //             }

    //             // Get the status name for the response using the correct field name
    //             $statusName = DB::table('project_collaboration_statuses')
    //                 ->where('id', $currentStatus ? $currentStatus->project_collab_status_id : $collaborationStatusId)
    //                 ->value('status') ?? 'Pending';

    //             $collaborator[] = [
    //                 'id' => $user->id,
    //                 'email' => $email,
    //                 'name' => $user->name,
    //                 'google_id' => $user->google_id,
    //                 'collaboration_status' => [
    //                     'id' => $currentStatus ? $currentStatus->project_collab_status_id : $collaborationStatusId,
    //                     'name' => $statusName
    //                 ]
    //             ];
    //         }

    //         return response()->json([
    //             'message' => 'Collaborators processed successfully',
    //             'collaborator' => $collaborator,
    //         ], 200);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'error' => 'An error occurred while adding collaborators.',
    //             'message' => $e->getMessage()
    //         ], 500);
    //     }
    // }


    public function addEndorserToProject(Request $request, $projectId)
    {
        try {
            // Validate the request data
            $request->validate([
                'emails' => 'required|array',
                'emails.*' => 'email|max:255',
            ]);

            // Check if the project exists
            $project = DB::table('projects')->where('id', $projectId)->first();
            if (!$project) {
                return response()->json(['error' => 'Project not found.'], 404);
            }

            // Check if the authenticated user is the project owner
            $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            if ($portfolio->user_id !== $request->user()->google_id) {
                return response()->json(['error' => 'You are not authorized to add endorsers to this project.'], 403);
            }

            // Get project owner's email to filter it out
            $ownerEmail = $request->user()->email;

            $endorser = [];
            $notFoundUsers = [];
            $notEndorserRoleUsers = [];
            $selfAddAttempt = false;

            // Set the default endorsement status to 1 (pending)
            $endorsementStatusId = 1; // Pending status
            $rejectedStatusId = 3;   // Rejected status

            foreach ($request->input('emails') as $email) {
                // Check if owner is trying to add themselves
                if (strtolower($email) === strtolower($ownerEmail)) {
                    $selfAddAttempt = true;
                    continue; // Skip this email
                }

                // Find user by email
                $user = DB::table('users')->where('email', $email)->first();

                if (!$user) {
                    $notFoundUsers[] = $email;
                    continue;
                }

                // Check if user has role_id = 2 (endorser role)
                $hasEndorserRole = $user->role_id === 2;

                if (!$hasEndorserRole) {
                    $notEndorserRoleUsers[] = [
                        'email' => $email,
                        'name' => $user->name
                    ];
                    continue;
                }

                // Rest of your existing code for processing valid endorsers
                // Check if the endorser already exists for this project
                $existingEndorser = DB::table('project_endorsers')
                    ->where('project_id', $projectId)
                    ->where('user_id', $user->google_id)
                    ->first();

                $isNewEndorser = !$existingEndorser;

                // Check if this endorser previously rejected the request
                $existingStatus = DB::table('project_endorsement_statuses')
                    ->where('project_id', $projectId)
                    ->where('endorser_id', $user->google_id)
                    ->first();

                $wasRejected = $existingStatus && $existingStatus->endorsement_status_id === $rejectedStatusId;

                // If endorser already exists but previously rejected, allow a new request
                if (!$isNewEndorser && !$wasRejected) {
                    // Get current status info for response
                    $currentStatus = $existingStatus;
                } else {
                    // This is either a new endorser or one who previously rejected

                    if ($wasRejected) {
                        // Endorser previously rejected, creating new request
                    } else {
                        // Only add to project_endorsers if they don't exist already
                        if ($isNewEndorser) {
                            DB::table('project_endorsers')->insert([
                                'project_id' => $projectId,
                                'user_id' => $user->google_id,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                        }
                    }

                    // Update or insert endorsement status
                    if ($wasRejected) {
                        // Update existing record if it was rejected
                        DB::table('project_endorsement_statuses')
                            ->where('project_id', $projectId)
                            ->where('endorser_id', $user->google_id)
                            ->update([
                                'endorsement_status_id' => $endorsementStatusId, // Set back to pending
                                'updated_at' => now(),
                            ]);
                    } else if (!$existingStatus) {
                        // Insert new record if none exists
                        DB::table('project_endorsement_statuses')->insert([
                            'project_id' => $projectId,
                            'endorser_id' => $user->google_id,
                            'endorsement_status_id' => $endorsementStatusId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }

                    // Get updated status for response
                    $currentStatus = DB::table('project_endorsement_statuses')
                        ->where('project_id', $projectId)
                        ->where('endorser_id', $user->google_id)
                        ->first();
                }

                // Get the status name for the response
                $statusName = DB::table('endorsement_statuses')
                    ->where('id', $currentStatus ? $currentStatus->endorsement_status_id : $endorsementStatusId)
                    ->value('status') ?? 'Pending';

                $endorser[] = [
                    'id' => $user->id,
                    'email' => $email,
                    'name' => $user->name,
                    'google_id' => $user->google_id,
                    'endorsement_status' => [
                        'id' => $currentStatus ? $currentStatus->endorsement_status_id : $endorsementStatusId,
                        'name' => $statusName
                    ],
                ];
            }

            // Prepare response with warning if owner tried to add themselves
            $response = [
                'message' => 'Endorsers processed successfully',
                'endorser' => $endorser,
            ];

            if ($selfAddAttempt) {
                $response['warning'] = 'You cannot add yourself as an endorser to your own project.';
            }

            if (count($notFoundUsers) > 0) {
                $response['not_found'] = $notFoundUsers;
            }

            if (count($notEndorserRoleUsers) > 0) {
                $response['not_endorsers'] = $notEndorserRoleUsers;
            }

            return response()->json($response, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while adding endorsers.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function addCollaboratorToProject(Request $request, $projectId)
    {
        try {
            // Validate the request data
            $request->validate([
                'emails' => 'required|array',
                'emails.*' => 'email|max:255',
            ]);

            // Check if the project exists
            $project = DB::table('projects')->where('id', $projectId)->first();
            if (!$project) {
                return response()->json(['error' => 'Project not found.'], 404);
            }

            // Check if the authenticated user is the project owner
            $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            if ($portfolio->user_id !== $request->user()->google_id) {
                return response()->json(['error' => 'You are not authorized to add collaborators to this project.'], 403);
            }

            // Get the project owner's email and name for comparison and emails
            $projectOwner = DB::table('users')
                ->where('google_id', $portfolio->user_id)
                ->first();

            if (!$projectOwner) {
                return response()->json(['error' => 'Project owner information not found.'], 404);
            }

            $collaborator = [];
            $notFoundUsers = [];
            $selfAddAttempt = false;

            // Set the default collaboration status to 1 (pending)
            $collaborationStatusId = 1; // Pending status
            $rejectedStatusId = 3;     // Rejected status

            foreach ($request->input('emails') as $email) {
                // Check if owner is trying to add themselves
                if (strtolower($email) === strtolower($projectOwner->email)) {
                    $selfAddAttempt = true;
                    continue; // Skip this email
                }

                // Find user by email
                $user = DB::table('users')->where('email', $email)->first();

                if (!$user) {
                    $notFoundUsers[] = $email;
                    continue;
                }

                // Rest of your existing code for processing valid collaborators
                // Check if the collaborator already exists for this project
                $existingCollaborator = DB::table('project_collaborators')
                    ->where('project_id', $projectId)
                    ->where('user_id', $user->google_id)
                    ->first();

                $isNewCollaborator = !$existingCollaborator;

                // Check if this collaborator previously rejected the request
                $existingStatus = DB::table('project_collaborator_invitation_statuses')
                    ->where('project_id', $projectId)
                    ->where('collaborator_id', $user->google_id)
                    ->first();

                $wasRejected = $existingStatus && $existingStatus->project_collab_status_id === $rejectedStatusId;

                // If collaborator already exists but previously rejected, allow a new request
                if (!$isNewCollaborator && !$wasRejected) {
                    // Collaborator already exists and did not reject
                    // Get current status info for response
                    $currentStatus = $existingStatus;
                } else {
                    // This is either a new collaborator or one who previously rejected

                    if ($wasRejected) {
                        // Collaborator previously rejected, creating new request
                    } else {
                        // Only add to project_collaborators if they don't exist already
                        if ($isNewCollaborator) {
                            DB::table('project_collaborators')->insert([
                                'project_id' => $projectId,
                                'user_id' => $user->google_id,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                        }
                    }

                    // Update or insert collaboration status
                    if ($wasRejected) {
                        // Update existing record if it was rejected
                        DB::table('project_collaborator_invitation_statuses')
                            ->where('project_id', $projectId)
                            ->where('collaborator_id', $user->google_id)
                            ->update([
                                'project_collab_status_id' => $collaborationStatusId, // Set back to pending
                                'updated_at' => now(),
                            ]);
                    } else if (!$existingStatus) {
                        // Insert new record if none exists
                        DB::table('project_collaborator_invitation_statuses')->insert([
                            'project_id' => $projectId,
                            'collaborator_id' => $user->google_id,
                            'project_collab_status_id' => $collaborationStatusId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }

                    // // Send email notification for new or renewed requests
                    // $this->sendCollaborationInvitationEmail(
                    //     $email,
                    //     $user->name,
                    //     $projectOwner->name,
                    //     $project->title,
                    //     $projectId
                    // );

                    // Get updated status for response
                    $currentStatus = DB::table('project_collaborator_invitation_statuses')
                        ->where('project_id', $projectId)
                        ->where('collaborator_id', $user->google_id)
                        ->first();
                }

                // Get the status name for the response using the correct field name
                $statusName = DB::table('project_collaboration_statuses')
                    ->where('id', $currentStatus ? $currentStatus->project_collab_status_id : $collaborationStatusId)
                    ->value('status') ?? 'Pending';

                $collaborator[] = [
                    'id' => $user->id,
                    'email' => $email,
                    'name' => $user->name,
                    'google_id' => $user->google_id,
                    'collaboration_status' => [
                        'id' => $currentStatus ? $currentStatus->project_collab_status_id : $collaborationStatusId,
                        'name' => $statusName
                    ]
                ];
            }

            // Prepare response with warning if owner tried to add themselves
            $response = [
                'message' => 'Collaborators processed successfully',
                'collaborator' => $collaborator,
            ];

            if ($selfAddAttempt) {
                $response['warning'] = 'You cannot add yourself as a collaborator to your own project.';
            }

            if (count($notFoundUsers) > 0) {
                $response['not_found'] = $notFoundUsers;
            }

            return response()->json($response, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while adding collaborators.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    // private function sendCollaborationInvitationEmail($recipientEmail, $recipientName, $ownerName, $projectTitle, $projectId)
    // {
    //     try {
    //         $apikey = env('BREVO_API_KEY');

    //         if (!$apikey) {
    //             Log::error('Brevo API key not found in environment variables');
    //             return;
    //         }

    //         // Extract first name for personalization
    //         $firstName = explode(' ', $recipientName)[0];

    //         // Build the link to the project/notification page
    //         $projectLink = env('FRONTEND_URL', 'https://talenthub.newlinkmarketing.com') . '/notifications';

    //         // Create email content
    //         $htmlContent = "<h1>Project Collaboration Invitation</h1>
    //                         <p>Hello {$firstName},</p>
    //                         <p>{$ownerName} has invited you to collaborate on the project <strong>{$projectTitle}</strong>.</p>
    //                         <p>You can accept or decline this invitation by visiting your notifications page.</p>
    //                         <p><a href='{$projectLink}'>View Invitation</a></p>
    //                         <p>Best regards,<br>The TalentHub Team</p>";

    //         $plainContent = "Project Collaboration Invitation\n\nHello {$firstName},\n\n{$ownerName} has invited you to collaborate on the project '{$projectTitle}'.\n\nYou can accept or decline this invitation by visiting your notifications page.\n\nView Invitation: {$projectLink}\n\nBest regards,\nThe TalentHub Team";

    //         // Prepare the email data
    //         $emailData = [
    //             'sender' => [
    //                 'name' => 'TalentHub',
    //                 'email' => 'talenthub.paragoniu@gmail.com'
    //             ],
    //             'to' => [
    //                 [
    //                     'email' => $recipientEmail,
    //                     'name' => $recipientName
    //                 ]
    //             ],
    //             'subject' => 'Project Collaboration Invitation: ' . $projectTitle,
    //             'htmlContent' => $htmlContent,
    //             'textContent' => $plainContent
    //         ];

    //         // Send the email
    //         $response = Http::withHeaders([
    //             'api-key' => $apikey,
    //             'accept' => 'application/json',
    //             'content-type' => 'application/json'
    //         ])->post('https://api.brevo.com/v3/smtp/email', $emailData);

    //         if ($response->successful()) {
    //             Log::info('Collaboration invitation email sent', [
    //                 'recipient' => $recipientEmail,
    //                 'project_id' => $projectId,
    //                 'message_id' => $response->json('messageId')
    //             ]);
    //         } else {
    //             Log::error('Failed to send collaboration invitation email', [
    //                 'recipient' => $recipientEmail,
    //                 'project_id' => $projectId,
    //                 'status' => $response->status(),
    //                 'response' => $response->body()
    //             ]);
    //         }
    //     } catch (\Exception $e) {
    //         Log::error('Exception while sending collaboration invitation email: ' . $e->getMessage(), [
    //             'trace' => $e->getTraceAsString(),
    //             'recipient' => $recipientEmail,
    //             'project_id' => $projectId
    //         ]);
    //     }
    // }

    public function changeEndorsementCollaborationRequest(Request $request)
    {
        try {
            // Get request data
            $receiverGoogleId = $request->input('receiver_google_id');
            $recordId = $request->input('id'); // ID from status tables, not portfolio ID
            $type = $request->input('type'); // 1 = Collaboration, 2 = Endorsement
            $endorsementType = $request->input('endorsement_type'); // Only if type is 2
            $status = $request->input('status'); // 2 = Approved, 3 = Declined

            // Log::info('changeEndorsementCollaborationRequest called', [
            //     'id' => $recordId,
            //     'receiver_google_id' => $receiverGoogleId,
            //     'type' => $type,
            //     'endorsement_type' => $endorsementType,
            //     'status' => $status
            // ]);

            // Verify that the receiver_google_id in the request matches the authenticated user
            if ($receiverGoogleId !== auth()->user()->google_id) {
                // Log::error('Mismatched receiver ID', [
                //     'request_receiver_id' => $receiverGoogleId,
                //     'auth_user_id' => auth()->user()->google_id
                // ]);
                return response()->json([
                    'error' => 'The receiver ID in the request does not match your account.',
                    'provided_id' => $receiverGoogleId,
                    'your_id' => auth()->user()->google_id
                ], 403);
            }

            // Validate endorsement_type based on type
            if ($type === 2 && !in_array($endorsementType, [1, 2, 3, 4])) {
                // Log::error('Invalid endorsement type', [
                //     'type' => $type,
                //     'endorsement_type' => $endorsementType
                // ]);
                return response()->json([
                    'error' => 'Invalid endorsement type. Expected values are: 1 (Skill), 2 (Project), 3 (Experience), or 4 (Achievement).',
                    'provided_endorsement_type' => $endorsementType
                ], 400);
            }

            // Determine the correct table based on type and endorsement_type
            $table = match (true) {
                $type === 1 => 'project_collaborator_invitation_statuses',
                $type === 2 && $endorsementType === 1 => 'skill_endorsement_statuses',
                $type === 2 && $endorsementType === 2 => 'project_endorsement_statuses',
                $type === 2 && $endorsementType === 3 => 'experience_endorsement_statuses',
                $type === 2 && $endorsementType === 4 => 'achievement_endorsement_statuses',
                default => null,
            };

            if (!$table) {
                return response()->json(['error' => 'Invalid type or endorsement type provided.'], 400);
            }

            // Find the record by its ID
            $record = DB::table($table)->where('id', $recordId)->first();

            if (!$record) {
                return response()->json([
                    'error' => 'Record not found.',
                    'table' => $table,
                    'id' => $recordId
                ], 404);
            }

            // Verify this record belongs to the current user
            $fieldToCheck = $type === 1 ? 'collaborator_id' : 'endorser_id';

            if ($record->$fieldToCheck !== auth()->user()->google_id) {
                return response()->json([
                    'error' => 'You are not authorized to update this request.',
                    'user_id' => auth()->user()->google_id,
                    'record_id' => $recordId
                ], 403);
            }

            // Verify the status value is valid (2 = Approved, 3 = Declined)
            if (!in_array($status, [2, 3])) {
                return response()->json([
                    'error' => 'Invalid status value. Expected 2 (Approved) or 3 (Declined).',
                    'provided_status' => $status
                ], 400);
            }

            // Begin transaction
            DB::beginTransaction();

            // Determine the correct column to update based on table and type
            $column = match ($table) {
                'project_collaborator_invitation_statuses' => 'project_collab_status_id',
                'skill_endorsement_statuses' => 'endorsement_status_id',
                'project_endorsement_statuses' => 'endorsement_status_id',
                'experience_endorsement_statuses' => 'experience_status_id',
                'achievement_endorsement_statuses' => 'endorsement_status_id',
                default => null,
            };

            if (!$column) {
                DB::rollBack();
                return response()->json(['error' => 'Invalid table or column mapping.'], 400);
            }

            // Perform the update - only update the record with the matching ID
            $updated = DB::table($table)
                ->where('id', $recordId)
                ->update([
                    $column => $status,
                    'updated_at' => now(),
                ]);

            DB::commit();

            if ($updated) {
                return response()->json([
                    'message' => 'Request status updated successfully.',
                    'status' => $status,
                ], 200);
            } else {
                return response()->json([
                    'error' => 'Failed to update the record.'
                ], 500);
            }
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::error('Error in changeEndorsementCollaborationRequest', [
            //     'error' => $e->getMessage(),
            //     'trace' => $e->getTraceAsString()
            // ]);

            return response()->json([
                'error' => 'An error occurred while processing the request.',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function updateProjectVisibility(Request $request, $projectId)
    {
        try {
            // Validate the request data
            $request->validate([
                'visibility_status' => 'required|integer|in:0,1', // 0 = public, 1 = private
            ]);

            // Check if the project exists
            $project = DB::table('projects')->where('id', $projectId)->first();

            if (!$project) {
                return response()->json(['error' => 'Project not found.'], 404);
            }

            // Check if the authenticated user is the project owner
            $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();

            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            if ($portfolio->user_id !== auth()->user()->google_id) {
                return response()->json(['error' => 'You are not authorized to update this project.'], 403);
            }

            // Update the project visibility - use visibility_status which is what you're validating
            DB::table('projects')
                ->where('id', $projectId)
                ->update([
                    'project_visibility_status' => $request->input('visibility_status'),
                    'updated_at' => now(),
                ]);

            return response()->json([
                'message' => 'Project visibility updated successfully.',
                'project' => DB::table('projects')->where('id', $projectId)->first()
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating project visibility.',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
