<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
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

        // Verify the portfolio exists
        $portfolio = DB::table('portfolios')
            ->where('id', $portfolioId)
            ->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        $user = $request->user();

        // Retrieve all projects for the specified portfolio
        $projectsQuery = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'projects.project_visibility_status'
            )
            ->where('projects.portfolio_id', $portfolioId);

        // If user is not the owner, only show public projects
        if (!$user || $user->google_id !== $portfolio->user_id) {
            $projectsQuery->where('projects.project_visibility_status', 0); // Only public
        }

        $projects = $projectsQuery->get();

        // Return the projects data
        return response()->json([
            'projects' => $projects->map(function ($project) {
                return [
                    'portfolio_id' => $project->portfolio_id,
                    'project_id' => $project->project_id,
                    'title' => $project->title,
                    'project_visibility_status' => $project->project_visibility_status
                ];
            })
        ]);
    }


    // public function viewProjectDetail($projectId, Request $request)
    // {
    //     // Retrieve the project details with user's Google ID
    //     $project = DB::table('projects')
    //         ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
    //         ->join('users', 'portfolios.user_id', '=', 'users.google_id')
    //         ->select(
    //             'portfolios.id as portfolio_id',
    //             'projects.id as project_id',
    //             'projects.title',
    //             'users.google_id',
    //             'projects.project_visibility_status'
    //         )
    //         ->where('projects.id', $projectId)
    //         ->first();

    //     // Check if the project exists
    //     if (!$project) {
    //         return response()->json(['error' => 'Project not found.'], 404);
    //     }

    //     // Check if the project is public or if the authenticated user is the owner
    //     $isPublic = ($project->project_visibility_status == 0);
    //     $isOwner = false;

    //     // Check if user is authenticated and is the owner
    //     if ($request->user()) {
    //         $isOwner = ($request->user()->google_id == $project->google_id);
    //     }

    //     // If project is not public and user is not the owner, return limited info
    //     if (!$isPublic && !$isOwner) {
    //         return response()->json([
    //             'error' => 'This project is not public.',
    //             'project_visibility_status' => $project->project_visibility_status
    //         ], 403);
    //     }

    //     // For public projects or if user is owner, return full details
    //     $fullProject = DB::table('projects')
    //         ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
    //         ->join('users', 'portfolios.user_id', '=', 'users.google_id')
    //         ->select(
    //             'portfolios.id as portfolio_id',
    //             'projects.id as project_id',
    //             'projects.title',
    //             'projects.description',
    //             'projects.instruction',
    //             'projects.link',
    //             DB::raw("CASE
    //                 WHEN projects.file IS NOT NULL 
    //                 THEN CONCAT('https://talenthub.newlinkmarketing.com/storage/', projects.file)
    //                 ELSE NULL
    //             END as file"),
    //             'projects.project_visibility_status',
    //             'projects.created_at',
    //             'projects.updated_at',
    //             'users.google_id'
    //         )
    //         ->where('projects.id', $projectId)
    //         ->first();

    //     // Get all programming languages for this project
    //     $programmingLanguages = DB::table('project_languages')
    //         ->join('programming_languages', 'project_languages.programming_language_id', '=', 'programming_languages.id')
    //         ->where('project_languages.project_id', $projectId)
    //         ->select('programming_languages.id', 'programming_languages.programming_language')
    //         ->get()
    //         ->map(function ($language) {
    //             return [
    //                 'id' => $language->id,
    //                 'name' => $language->programming_language
    //             ];
    //         })
    //         ->toArray();

    //     // Get project images
    //     $images = DB::table('project_images')
    //         ->where('project_id', $projectId)
    //         ->get()
    //         ->map(function ($image) {
    //             return [
    //                 'id' => $image->id,
    //                 'url' => 'https://talenthub.newlinkmarketing.com/storage/' . $image->image
    //             ];
    //         });

    //     // Get project endorsers with their endorsement status
    //     $endorsers = DB::table('project_endorsers')
    //         ->join('users', 'project_endorsers.user_id', '=', 'users.google_id')
    //         ->leftJoin('project_endorsement_statuses', function ($join) use ($projectId) {
    //             $join->on('project_endorsers.user_id', '=', 'project_endorsement_statuses.endorser_id')
    //                 ->where('project_endorsement_statuses.project_id', '=', DB::raw('project_endorsers.project_id'));
    //         })
    //         ->where('project_endorsers.project_id', $projectId)
    //         ->select(
    //             'users.id',
    //             'users.google_id',
    //             'users.name',
    //             'users.email',
    //             'project_endorsement_statuses.endorsement_status_id',

    //         )
    //         ->get()
    //         ->map(function ($endorser) {
    //             return [
    //                 'id' => $endorser->id,
    //                 'google_id' => $endorser->google_id,
    //                 'name' => $endorser->name,
    //                 'email' => $endorser->email,
    //                 'endorsement_status' => $endorser->endorsement_status_id ?? 0, // Default to 0 if null
    //             ];
    //         })
    //         ->toArray();

    //     // Get project collaborators with their invitation status
    //     $collaborators = DB::table('project_collaborators')
    //         ->join('users', 'project_collaborators.user_id', '=', 'users.google_id')
    //         ->leftJoin('project_collaborator_invitation_statuses', function ($join) use ($projectId) {
    //             $join->on('project_collaborators.user_id', '=', 'project_collaborator_invitation_statuses.collaborator_id')
    //                 ->where('project_collaborator_invitation_statuses.project_id', '=', DB::raw('project_collaborators.project_id'));
    //         })
    //         ->where('project_collaborators.project_id', $projectId)
    //         ->select(
    //             'users.id',
    //             'users.google_id',
    //             'users.name',
    //             'users.email',
    //             'project_collaborator_invitation_statuses.project_collab_status_id',
    //         )
    //         ->get()
    //         ->map(function ($collaborator) {
    //             return [
    //                 'id' => $collaborator->id,
    //                 'google_id' => $collaborator->google_id,
    //                 'name' => $collaborator->name,
    //                 'email' => $collaborator->email,
    //                 'collaboration_status' => $collaborator->project_collab_status_id ?? 0, // Default to 0 if null
    //             ];
    //         })
    //         ->toArray();



    //     // Combine project details with images, languages, endorsers and collaborators
    //     $response = (array) $fullProject;
    //     $response['programming_languages'] = $programmingLanguages;
    //     $response['images'] = $images;
    //     $response['endorsers'] = $endorsers;
    //     $response['collaborators'] = $collaborators;

    //     // Return the project details
    //     return response()->json($response, 200, [], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    // }




    // public function viewProjectDetail($projectId, Request $request)
    // {
    //     // Retrieve the project details with user's Google ID
    //     $project = DB::table('projects')
    //         ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
    //         ->join('users', 'portfolios.user_id', '=', 'users.google_id')
    //         ->select(
    //             'portfolios.id as portfolio_id',
    //             'projects.id as project_id',
    //             'projects.title',
    //             'users.google_id',
    //             'projects.project_visibility_status'
    //         )
    //         ->where('projects.id', $projectId)
    //         ->first();

    //     // Check if the project exists
    //     if (!$project) {
    //         return response()->json(['error' => 'Project not found.'], 404);
    //     }

    //     // Check if the project is public
    //     if ($project->project_visibility_status == 0) {
    //         // Public project: No need for Bearer token, just return full details
    //         return $this->getFullProjectDetails($projectId);
    //     }

    //     // If project is private, we need to check for Bearer token in the body
    //     $bearerToken = $request->input('bearer');

    //     // If no Bearer token is provided, return an error
    //     if (!$bearerToken) {
    //         return response()->json(['error' => 'Bearer token required for private projects.'], 401);
    //     }

    //     // Verify the Bearer token by checking if it belongs to the user and matches the project owner
    //     try {
    //         $user = JWT::decode($bearerToken, env('JWT_SECRET'), ['HS256']); // Replace with your JWT library's decode method

    //         // Check if the decoded token's Google ID matches the project owner
    //         if ($user->google_id != $project->google_id) {
    //             return response()->json(['error' => 'This project is private.'], 403);
    //         }

    //         // If the user is the owner, return full project details
    //         return $this->getFullProjectDetails($projectId);

    //     } catch (\Exception $e) {
    //         return response()->json(['error' => 'Invalid or expired token.'], 401);
    //     }
    // }

    // // Method to return full project details
    // private function getFullProjectDetails($projectId)
    // {
    //     // Get full project details (the rest of your original logic)
    //     $fullProject = DB::table('projects')
    //         ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
    //         ->join('users', 'portfolios.user_id', '=', 'users.google_id')
    //         ->select(
    //             'portfolios.id as portfolio_id',
    //             'projects.id as project_id',
    //             'projects.title',
    //             'projects.description',
    //             'projects.instruction',
    //             'projects.link',
    //             DB::raw("CASE
    //                 WHEN projects.file IS NOT NULL 
    //                 THEN CONCAT('https://talenthub.newlinkmarketing.com/storage/', projects.file)
    //                 ELSE NULL
    //             END as file"),
    //             'projects.project_visibility_status',
    //             'projects.created_at',
    //             'projects.updated_at',
    //             'users.google_id'
    //         )
    //         ->where('projects.id', $projectId)
    //         ->first();

    //     // Get all programming languages for this project
    //     $programmingLanguages = DB::table('project_languages')
    //         ->join('programming_languages', 'project_languages.programming_language_id', '=', 'programming_languages.id')
    //         ->where('project_languages.project_id', $projectId)
    //         ->select('programming_languages.id', 'programming_languages.programming_language')
    //         ->get()
    //         ->map(function ($language) {
    //             return [
    //                 'id' => $language->id,
    //                 'name' => $language->programming_language
    //             ];
    //         })
    //         ->toArray();

    //     // Get project images
    //     $images = DB::table('project_images')
    //         ->where('project_id', $projectId)
    //         ->get()
    //         ->map(function ($image) {
    //             return [
    //                 'id' => $image->id,
    //                 'url' => 'https://talenthub.newlinkmarketing.com/storage/' . $image->image
    //             ];
    //         });

    //     // Get project endorsers with their endorsement status
    //     $endorsers = DB::table('project_endorsers')
    //         ->join('users', 'project_endorsers.user_id', '=', 'users.google_id')
    //         ->leftJoin('project_endorsement_statuses', function ($join) use ($projectId) {
    //             $join->on('project_endorsers.user_id', '=', 'project_endorsement_statuses.endorser_id')
    //                 ->where('project_endorsement_statuses.project_id', '=', DB::raw('project_endorsers.project_id'));
    //         })
    //         ->where('project_endorsers.project_id', $projectId)
    //         ->select(
    //             'users.id',
    //             'users.google_id',
    //             'users.name',
    //             'users.email',
    //             'project_endorsement_statuses.endorsement_status_id'
    //         )
    //         ->get()
    //         ->map(function ($endorser) {
    //             return [
    //                 'id' => $endorser->id,
    //                 'google_id' => $endorser->google_id,
    //                 'name' => $endorser->name,
    //                 'email' => $endorser->email,
    //                 'endorsement_status' => $endorser->endorsement_status_id ?? 0, // Default to 0 if null
    //             ];
    //         })
    //         ->toArray();

    //     // Get project collaborators with their invitation status
    //     $collaborators = DB::table('project_collaborators')
    //         ->join('users', 'project_collaborators.user_id', '=', 'users.google_id')
    //         ->leftJoin('project_collaborator_invitation_statuses', function ($join) use ($projectId) {
    //             $join->on('project_collaborators.user_id', '=', 'project_collaborator_invitation_statuses.collaborator_id')
    //                 ->where('project_collaborator_invitation_statuses.project_id', '=', DB::raw('project_collaborators.project_id'));
    //         })
    //         ->where('project_collaborators.project_id', $projectId)
    //         ->select(
    //             'users.id',
    //             'users.google_id',
    //             'users.name',
    //             'users.email',
    //             'project_collaborator_invitation_statuses.project_collab_status_id'
    //         )
    //         ->get()
    //         ->map(function ($collaborator) {
    //             return [
    //                 'id' => $collaborator->id,
    //                 'google_id' => $collaborator->google_id,
    //                 'name' => $collaborator->name,
    //                 'email' => $collaborator->email,
    //                 'collaboration_status' => $collaborator->project_collab_status_id ?? 0, // Default to 0 if null
    //             ];
    //         })
    //         ->toArray();

    //     // Combine project details with images, languages, endorsers and collaborators
    //     $response = (array) $fullProject;
    //     $response['programming_languages'] = $programmingLanguages;
    //     $response['images'] = $images;
    //     $response['endorsers'] = $endorsers;
    //     $response['collaborators'] = $collaborators;

    //     // Return the project details
    //     return response()->json($response, 200, [], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    // }



    public function viewProjectDetail($projectId, Request $request)
    {
        // Retrieve the project details with user's authentication token
        $project = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id') // Use users.id for authentication
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'users.id as user_id',
                'projects.project_visibility_status'
            )
            ->where('projects.id', $projectId)
            ->first();

        // Check if the project exists
        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
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

        // Check if the authenticated user matches the project owner (compare user_id)
        if ($user->id != $project->user_id) {
            return response()->json(['error' => 'This project is private.'], 403);
        }

        // If the user is the owner, return full project details
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
                'projects.created_at',
                'projects.updated_at',
                'users.google_id as google_id'
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
                'project_endorsement_statuses.endorsement_status_id'
            )
            ->get()
            ->map(function ($endorser) {
                return [
                    'id' => $endorser->id,
                    'name' => $endorser->name,
                    'email' => $endorser->email,
                    'google_id' => $endorser->google_id,
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
            'description' => 'required|string|max:255',
            'instruction' => 'required|string|max:255',
            'link' => 'nullable|string|max:255',
            'file' => 'nullable|file',  // Validate file
            'image' => 'nullable|array',  // Ensure image is an array for multiple upload
            'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg', // Validate each image in array
            'programming_languages' => 'required|array', // Changed to array of languages
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
                // Log::info('Created new programming language: ' . $languageName . ' with ID: ' . $languageId);
                $programmingLanguageIds[] = $languageId;
            } else {
                $programmingLanguageIds[] = $language->id;
                // Log::info('Using existing programming language: ' . $languageName . ' with ID: ' . $language->id);
            }
        }

        // Use the first language as the primary language for the project
        $primaryLanguageId = !empty($programmingLanguageIds) ? $programmingLanguageIds[0] : null;

        if (!$primaryLanguageId) {
            return response()->json(['error' => 'At least one programming language is required.'], 422);
        }

        // Handle file upload (for project file)
        $filePath = null;
        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $filePath = $file->store('projects', 'public'); // Store file in 'projects' folder, 'public' disk
            // Log::info('Project file uploaded: ' . $filePath);
        }

        // Handle multiple image uploads
        $imagePaths = [];
        if ($request->hasFile('image')) {
            $images = $request->file('image');
            Log::info('Multiple images detected: ' . count($images));

            foreach ($images as $image) {
                try {
                    if ($image->isValid()) {
                        $imagePath = $image->store('project_images', 'public');
                        $imagePaths[] = $imagePath;
                        // Log::info('Image uploaded: ' . $imagePath);
                    } else {
                        // Log::error('Invalid image file: ' . $image->getClientOriginalName());
                    }
                } catch (\Exception $e) {
                    // Log::error('Error uploading image: ' . $e->getMessage());
                }
            }
        }

        // Insert the project into the database and get the ID
        $projectId = DB::table('projects')->insertGetId([
            'portfolio_id' => $request->input('portfolio_id'),
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'instruction' => $request->input('instruction'),
            'link' => $request->input('link'),
            'file' => $filePath, // Store the file path
            'programming_language_id' => $primaryLanguageId, // Use the first language as primary
            'project_visibility_status' => 0,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Log::info('Project created with ID: ' . $projectId);

        // Create relationships in project_languages table for all languages
        foreach ($programmingLanguageIds as $languageId) {
            DB::table('project_languages')->insert([
                'project_id' => $projectId,
                'programming_language_id' => $languageId,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            // Log::info('Created project-language relationship: Project ID ' . $projectId . ' -> Language ID ' . $languageId);
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

                    // Log::info('Inserted image into project_images: ' . $imagePath);
                } catch (\Exception $e) {
                    // Log::error('Error inserting image into project_images: ' . $e->getMessage());
                }
            }
        }

        // Base URL for accessing the files
        $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
        $fileUrl = $filePath ? $baseUrl . $filePath : null;

        // Get all languages for this project
        $projectLanguages = DB::table('project_languages')
            ->join('programming_languages', 'project_languages.programming_language_id', '=', 'programming_languages.id')
            ->where('project_id', $projectId)
            ->pluck('programming_languages.programming_language')
            ->toArray();

        // Return the full URLs for both the file and images
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
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'instruction' => 'required|string|max:255',
            'link' => 'nullable|string|max:255',
            'file' => 'nullable|mimes:zip',
            'image' => 'nullable',
            'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg',
            'programming_languages' => 'required|array',
            'programming_languages.*' => 'string|max:255',
            'project_visibility_status' => 'required|integer',
        ]);

        $project = DB::table('projects')->where('id', $id)->first();
        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
        $userId = $request->user()->google_id;

        if (!$portfolio || $portfolio->user_id != $userId) {
            return response()->json(['error' => 'Unauthorized.'], 403);
        }

        // Handle programming languages
        $programmingLanguageIds = [];
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

        $primaryLanguageId = $programmingLanguageIds[0] ?? null;
        if (!$primaryLanguageId) {
            return response()->json(['error' => 'At least one programming language is required.'], 422);
        }

        // Handle file upload (with old file deletion using unlink)
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
                // Log::error('File upload failed: ' . $e->getMessage());
                return response()->json(['error' => 'File upload failed'], 500);
            }
        }


        // Handle image upload
        if ($request->hasFile('image')) {
            foreach ($request->file('image') as $image) {
                if ($image->isValid()) {
                    $imagePath = $image->store('project_images', 'public');
                    DB::table('project_images')->insert([
                        'project_id' => $id,
                        'image' => $imagePath,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
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
            'project_visibility_status' => $request->input('project_visibility_status'),
            'updated_at' => now(),
        ]);

        // Sync languages
        DB::table('project_languages')->where('project_id', $id)->delete();
        foreach ($programmingLanguageIds as $languageId) {
            DB::table('project_languages')->insert([
                'project_id' => $id,
                'programming_language_id' => $languageId,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // Response
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

        // Delete image from storage
        $imagePath = storage_path('app/public/' . $image->image);
        if (file_exists($imagePath)) {
            unlink($imagePath);
            // Log::info('Deleted image from storage: ' . $imagePath);
        }

        // Remove DB record
        DB::table('project_images')->where('id', $imageId)->delete();

        return response()->json(['message' => 'Project image deleted successfully.']);
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
        Log::info('downloadProject request:', [
            'project_id' => $id,
            'portfolio_id' => $portfolioId
        ]);

        // First verify the project exists independently
        $projectExists = DB::table('projects')
            ->where('id', $id)
            ->exists();

        if (!$projectExists) {
            Log::error('Project not found with ID: ' . $id);
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Then verify the portfolio exists
        $portfolioExists = DB::table('portfolios')
            ->where('id', $portfolioId)
            ->exists();

        if (!$portfolioExists) {
            Log::error('Portfolio not found with ID: ' . $portfolioId);
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
            Log::error('Project ' . $id . ' does not belong to portfolio ' . $portfolioId);
            return response()->json(['error' => 'Project does not belong to the specified portfolio.'], 404);
        }

        // Check if project is public (project_visibility_status = 0)
        if ($project->project_visibility_status != 0) {
            Log::error('Project ' . $id . ' is not public. Visibility status: ' . $project->project_visibility_status);
            return response()->json(['error' => 'Project is not available for download.'], 403);
        }

        // Check if project has a file
        if (empty($project->file)) {
            return response()->json(['error' => 'Project has no downloadable file.'], 404);
        }

        // Return the file URL in the requested format
        $fileUrl = 'https://talenthub.newlinkmarketing.com/storage/' . $project->file;

        Log::info('Project download response prepared with file URL: ' . $fileUrl);
        return response()->json([
            'file' => $fileUrl
        ]);
    }

    public function addEndorserToProject(Request $request, $projectId)
    {
        // Validate the request data - only emails are required now
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
        if (!$portfolio || $portfolio->user_id !== $request->user()->google_id) {
            return response()->json(['error' => 'You are not authorized to add endorsers to this project.'], 403);
        }
    
        $addedEndorsers = [];
        $existingEndorsers = [];
        $notFoundUsers = [];
        $notEndorserRoleUsers = []; // New array to track users without endorser role
    
        // Set the default endorsement status to 1 (pending)
        $endorsementStatusId = 1; // Pending status
    
        foreach ($request->input('emails') as $email) {
            // Find user by email
            $user = DB::table('users')->where('email', $email)->first();
    
            if (!$user) {
                $notFoundUsers[] = $email;
                continue;
            }
    
            // Check if user has role_id = 2 (endorser role)
            $hasEndorserRole = DB::table('user_roles')
                ->where('user_id', $user->google_id)
                ->where('role_id', 2) // Endorser role ID
                ->exists();
    
            if (!$hasEndorserRole) {
                $notEndorserRoleUsers[] = [
                    'email' => $email,
                    'name' => $user->name
                ];
                continue;
            }
    
            // Check if the endorser already exists for this project
            $existingEndorser = DB::table('project_endorsers')
                ->where('project_id', $projectId)
                ->where('user_id', $user->google_id)
                ->first();
    
            if ($existingEndorser) {
                $existingEndorsers[] = [
                    'email' => $email,
                    'name' => $user->name
                ];
                continue;
            }
    
            // Insert the new endorser into the database using google_id
            DB::table('project_endorsers')->insert([
                'project_id' => $projectId,
                'user_id' => $user->google_id,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
    
            // Insert the endorsement status into the database with default status pending (1)
            DB::table('project_endorsement_statuses')->insert([
                'project_id' => $projectId,
                'endorser_id' => $user->google_id,
                'endorsement_status_id' => $endorsementStatusId, // Always set to pending (1)
                'created_at' => now(),
                'updated_at' => now(),
            ]);
    
            // Get the status name for the response
            $statusName = DB::table('endorsement_statuses')
                ->where('id', $endorsementStatusId)
                ->value('status') ?? 'Pending';
    
            $addedEndorsers[] = [
                'id' => $user->id,
                'email' => $email,
                'name' => $user->name,
                'google_id' => $user->google_id,
                'endorsement_status' => [
                    'id' => $endorsementStatusId,
                    'name' => $statusName
                ]
            ];
        }
    
        return response()->json([
            'message' => 'Endorsers added successfully',
            'added' => $addedEndorsers,
            'existing' => $existingEndorsers,
            'not_found' => $notFoundUsers,
            'not_endorser_role' => $notEndorserRoleUsers // Include users without endorser role
        ]);
    }

    public function addCollaboratorToProject(Request $request, $projectId)
    {
        // Validate the request data
        $request->validate([
            'collaborator_id' => 'required|string|max:255',
            'collaboration_status_id' => 'required|integer',
        ]);

        // Check if the project exists
        $project = DB::table('projects')->where('id', $projectId)->first();
        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Check if the collaborator already exists for this project
        $existingCollaborator = DB::table('project_collaborators')
            ->where('project_id', $projectId)
            ->where('user_id', $request->input('collaborator_id'))
            ->first();

        if ($existingCollaborator) {
            return response()->json(['error' => 'Collaborator already exists for this project.'], 409);
        }

        // Insert the new collaborator into the database
        DB::table('project_collaborators')->insert([
            'project_id' => $projectId,
            'user_id' => $request->input('collaborator_id'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Insert the collaboration status into the database
        DB::table('project_collaborator_invitation_statuses')->insert([
            'project_id' => $projectId,
            'collaborator_id' => $request->input('collaborator_id'),
            'collaboration_status_id' => $request->input('collaboration_status_id'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json(['message' => 'Collaborator added successfully.']);
    }
}
