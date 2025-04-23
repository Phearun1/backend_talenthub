<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

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

        // Retrieve all projects for the specified portfolio with only the required fields
        $projects = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title'
            )
            ->where('projects.portfolio_id', $portfolioId)
            ->get();

        // Return the projects data
        return response()->json([
            'portfolio_id' => $portfolioId,
            'projects' => $projects
        ]);
    }

    public function viewProjectDetail($projectId)
    {
        // Retrieve the project details with user's Google ID
        $project = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'projects.description',
                'projects.instruction',
                'projects.link',
                'projects.file',
                'projects.programming_language_id',
                'projects.project_visibility_status',
                'projects.created_at',
                'projects.updated_at',
                'users.google_id'
            )
            ->where('projects.id', $projectId)
            ->first();

        // Check if the project exists
        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Return the project details
        return response()->json($project, 200, [], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
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
            'file' => 'nullable|file|mimes:zip',  // Validate file
            'image' => 'nullable|array',  // Ensure image is an array for multiple upload
            'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg', // Validate each image in array
            'programming_language' => 'required|string|max:255', // Changed from ID to name
            'project_visibility_status' => 'required|integer',
        ]);
    
        // Get the authenticated user's ID
        $userId = $request->user()->google_id;
    
        // Check if the portfolio belongs to the authenticated user
        $portfolio = DB::table('portfolios')->where('id', $request->input('portfolio_id'))->first();
    
        if (!$portfolio || $portfolio->user_id != $userId) {
            return response()->json(['error' => 'You are not authorized to create a project for this portfolio.'], 403);
        }
    
        // Handle programming language - check if it exists or create new one
        $programmingLanguageName = $request->input('programming_language');
        $programmingLanguage = DB::table('programming_languages')
            ->where('programming_language', $programmingLanguageName)
            ->first();
    
        if (!$programmingLanguage) {
            // Create a new programming language
            $programmingLanguageId = DB::table('programming_languages')->insertGetId([
                'programming_language' => $programmingLanguageName,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            
            // Log::info('Created new programming language: ' . $programmingLanguageName . ' with ID: ' . $programmingLanguageId);
        } else {
            $programmingLanguageId = $programmingLanguage->id;
            // Log::info('Using existing programming language: ' . $programmingLanguageName . ' with ID: ' . $programmingLanguageId);
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
            // Log::info('Multiple images detected: ' . count($images));
    
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
            'programming_language_id' => $programmingLanguageId, // Use the resolved language ID
            'project_visibility_status' => $request->input('project_visibility_status'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    
        // Log project ID after insertion
        // Log::info('Project created with ID: ' . $projectId);
        
        // Create the relationship in project_languages table
        DB::table('project_languages')->insert([
            'project_id' => $projectId,
            'programming_language_id' => $programmingLanguageId,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        
        // Log::info('Created project-language relationship: Project ID ' . $projectId . ' -> Language ID ' . $programmingLanguageId);
    
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
    
        // Return the full URLs for both the file and images
        // Fetch the complete project details to return
        $projectDetails = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('programming_languages', 'projects.programming_language_id', '=', 'programming_languages.id')
            ->select(
                'portfolios.id as portfolio_id',
                'projects.id as project_id',
                'projects.title',
                'projects.description',
                'projects.instruction',
                'projects.link',
                'programming_languages.programming_language as programming_language'
            )
            ->where('projects.id', $projectId)
            ->first();
    
        return response()->json([
            'message' => 'Project created successfully.',
            'project' => $projectDetails,
            'file_url' => $fileUrl,
            'image_urls' => $imageUrls, // Array of image URLs
        ], 200);
    }

    // public function updateProject(Request $request, $id)
    // {
    //     // Validate the incoming request data
    //     $request->validate([
    //         'title' => 'required|string|max:255',
    //         'description' => 'required|string|max:255',
    //         'instruction' => 'required|string|max:255',
    //         'link' => 'nullable|string|max:255',
    //         'file' => 'nullable|file|mimes:zip',  // Validate file
    //         'image' => 'nullable|array',  // Ensure image is an array for multiple upload
    //         'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg', // Validate each image in array
    //         'programming_language' => 'required|string|max:255', // Changed from ID to name
    //         'project_visibility_status' => 'required|integer',
    //     ]);
    
    //     // Check if the project exists
    //     $project = DB::table('projects')->where('id', $id)->first();
    
    //     if (!$project) {
    //         return response()->json(['error' => 'Project not found.'], 404);
    //     }
    
    //     // Ensure that the project belongs to the authenticated user and their portfolio
    //     $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
    //     $userId = $request->user()->google_id;
    
    //     if (!$portfolio || $portfolio->user_id != $userId) {
    //         return response()->json(['error' => 'You are not authorized to update this project.'], 403);
    //     }
    
    //     // Handle programming language - check if it exists or create new one
    //     $programmingLanguageName = $request->input('programming_language');
    //     $programmingLanguage = DB::table('programming_languages')
    //         ->where('programming_language', $programmingLanguageName)
    //         ->first();
    
    //     if (!$programmingLanguage) {
    //         // Create a new programming language
    //         $programmingLanguageId = DB::table('programming_languages')->insertGetId([
    //             'programming_language' => $programmingLanguageName,
    //             'created_at' => now(),
    //             'updated_at' => now(),
    //         ]);
            
    //         Log::info('Created new programming language: ' . $programmingLanguageName . ' with ID: ' . $programmingLanguageId);
    //     } else {
    //         $programmingLanguageId = $programmingLanguage->id;
    //         Log::info('Using existing programming language: ' . $programmingLanguageName . ' with ID: ' . $programmingLanguageId);
    //     }
    
    //     // Process file upload if a new file is provided
    //     $filePath = $project->file; // Default to current file path
    //     if ($request->hasFile('file')) {
    //         // Delete the old file if it exists using unlink
    //         if ($project->file) {
    //             $oldFilePath = storage_path('app/public/' . $project->file);
    //             if (file_exists($oldFilePath)) {
    //                 unlink($oldFilePath);
    //                 Log::info('Deleted old project file using unlink: ' . $oldFilePath);
    //             }
    //         }
    
    //         // Store the new file
    //         $file = $request->file('file');
    //         $filePath = $file->store('projects', 'public');
    //         Log::info('New project file uploaded: ' . $filePath);
    //     }
    
    //     // Handle the case where image[] is explicitly set to null (delete all existing images)
    //     if ($request->has('image') && ($request->input('image') === null || $request->input('image') === 'null')) {
    //         // Get all current images for the project
    //         $existingImages = DB::table('project_images')->where('project_id', $id)->get();
            
    //         // Delete each image file and its database record
    //         foreach ($existingImages as $image) {
    //             $imagePath = storage_path('app/public/' . $image->image);
    //             if (file_exists($imagePath)) {
    //                 unlink($imagePath);
    //                 Log::info('Deleted project image using unlink: ' . $imagePath);
    //             }
                
    //             // Delete the database record
    //             DB::table('project_images')->where('id', $image->id)->delete();
    //             Log::info('Deleted project image record with ID: ' . $image->id);
    //         }
            
    //         Log::info('All images deleted for project ID: ' . $id);
    //     }
    
    //     // Handle new image uploads
    //     $newImageUrls = [];
    //     if ($request->hasFile('image')) {
    //         $images = $request->file('image');
    //         Log::info('New images detected: ' . count($images));
    
    //         foreach ($images as $image) {
    //             try {
    //                 if ($image->isValid()) {
    //                     // Generate a unique filename
    //                     $filename = time() . '_' . $image->getClientOriginalName();
    //                     $imagePath = $image->storeAs('project_images', $filename, 'public');
    
    //                     // Insert into project_images table
    //                     $imageId = DB::table('project_images')->insertGetId([
    //                         'project_id' => $id,
    //                         'image' => $imagePath,
    //                         'created_at' => now(),
    //                         'updated_at' => now(),
    //                     ]);
    
    //                     // Build image URL
    //                     $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
    //                     $newImageUrls[] = [
    //                         'id' => $imageId,
    //                         'url' => $baseUrl . $imagePath
    //                     ];
    
    //                     Log::info('New image uploaded and inserted: ' . $imagePath);
    //                 } else {
    //                     Log::error('Invalid image file: ' . $image->getClientOriginalName());
    //                 }
    //             } catch (\Exception $e) {
    //                 Log::error('Error processing new image: ' . $e->getMessage());
    //             }
    //         }
    //     }
    
    //     // Update the project in the database
    //     DB::table('projects')->where('id', $id)->update([
    //         'title' => $request->input('title'),
    //         'description' => $request->input('description'),
    //         'instruction' => $request->input('instruction'),
    //         'link' => $request->input('link'),
    //         'file' => $filePath,
    //         'programming_language_id' => $programmingLanguageId,
    //         'project_visibility_status' => $request->input('project_visibility_status'),
    //         'updated_at' => now(),
    //     ]);
    
    //     // Update the project_languages relationship - First remove existing relationship
    //     DB::table('project_languages')->where('project_id', $id)->delete();
        
    //     // Then create the new relationship
    //     DB::table('project_languages')->insert([
    //         'project_id' => $id,
    //         'programming_language_id' => $programmingLanguageId,
    //         'created_at' => now(),
    //         'updated_at' => now(),
    //     ]);
        
    //     Log::info('Updated project-language relationship: Project ID ' . $id . ' -> Language ID ' . $programmingLanguageId);
    
    //     // Get all current images for the project
    //     $allImages = DB::table('project_images')
    //         ->where('project_id', $id)
    //         ->get()
    //         ->map(function ($image) {
    //             $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
    //             return [
    //                 'id' => $image->id,
    //                 'url' => $baseUrl . $image->image
    //             ];
    //         });
    
    //     // Base URL for accessing the files
    //     $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
    //     $fileUrl = $filePath ? $baseUrl . $filePath : null;
    
    //     // Fetch the updated project details
    //     $projectDetails = DB::table('projects')
    //         ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
    //         ->join('programming_languages', 'projects.programming_language_id', '=', 'programming_languages.id')
    //         ->select(
    //             'portfolios.id as portfolio_id',
    //             'projects.id as project_id',
    //             'projects.title',
    //             'projects.description',
    //             'projects.instruction',
    //             'projects.link',
    //             'programming_languages.programming_language as programming_language',
    //             'projects.project_visibility_status'
    //         )
    //         ->where('projects.id', $id)
    //         ->first();
    
    //     // Return a success response
    //     return response()->json([
    //         'message' => 'Project updated successfully.',
    //         'project' => $projectDetails,
    //         'file_url' => $fileUrl,
    //         'images' => $allImages,
    //     ], 200);
    // }

//     public function updateProject(Request $request, $id)
// {
//     // Validate the incoming request data
//     $request->validate([
//         'title' => 'required|string|max:255',
//         'description' => 'required|string|max:255',
//         'instruction' => 'required|string|max:255',
//         'link' => 'nullable|string|max:255',
//         'file' => 'nullable|file|mimes:zip',
//         'image' => 'nullable|array',
//         'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg',
//         'programming_language' => 'required|string|max:255',
//         'project_visibility_status' => 'required|integer',
//     ]);

//     $project = DB::table('projects')->where('id', $id)->first();
//     if (!$project) {
//         return response()->json(['error' => 'Project not found.'], 404);
//     }

//     $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
//     $userId = $request->user()->google_id;

//     if (!$portfolio || $portfolio->user_id != $userId) {
//         return response()->json(['error' => 'You are not authorized to update this project.'], 403);
//     }

//     // Handle programming language
//     $languageName = $request->input('programming_language');
//     $language = DB::table('programming_languages')->where('programming_language', $languageName)->first();
//     if (!$language) {
//         $languageId = DB::table('programming_languages')->insertGetId([
//             'programming_language' => $languageName,
//             'created_at' => now(),
//             'updated_at' => now(),
//         ]);
//     } else {
//         $languageId = $language->id;
//     }

//     // Handle new file
//     $filePath = $project->file;
//     if ($request->hasFile('file')) {
//         if ($project->file) {
//             $oldFilePath = storage_path('app/public/' . $project->file);
//             if (file_exists($oldFilePath)) {
//                 unlink($oldFilePath);
//             }
//         }

//         $file = $request->file('file');
//         $filePath = $file->store('projects', 'public');
//     }

//     // If 'image' is explicitly null (client sent "null"), delete all current images
//     if ($request->has('image') && $request->input('image') === null) {
//         $existingImages = DB::table('project_images')->where('project_id', $id)->get();
//         foreach ($existingImages as $img) {
//             $imgPath = storage_path('app/public/' . $img->image);
//             if (file_exists($imgPath)) {
//                 unlink($imgPath);
//             }
//             DB::table('project_images')->where('id', $img->id)->delete();
//         }
//     }

//     // Upload new images
//     $newImageUrls = [];
//     if ($request->hasFile('image')) {
//         foreach ($request->file('image') as $img) {
//             if ($img->isValid()) {
//                 $filename = time() . '_' . $img->getClientOriginalName();
//                 $storedPath = $img->storeAs('project_images', $filename, 'public');

//                 $imgId = DB::table('project_images')->insertGetId([
//                     'project_id' => $id,
//                     'image' => $storedPath,
//                     'created_at' => now(),
//                     'updated_at' => now(),
//                 ]);

//                 $newImageUrls[] = [
//                     'id' => $imgId,
//                     'url' => asset('storage/' . $storedPath)
//                 ];
//             }
//         }
//     }

//     // Update the main project record
//     DB::table('projects')->where('id', $id)->update([
//         'title' => $request->input('title'),
//         'description' => $request->input('description'),
//         'instruction' => $request->input('instruction'),
//         'link' => $request->input('link'),
//         'file' => $filePath,
//         'programming_language_id' => $languageId,
//         'project_visibility_status' => $request->input('project_visibility_status'),
//         'updated_at' => now(),
//     ]);

//     // Update project_languages relationship
//     DB::table('project_languages')->where('project_id', $id)->delete();
//     DB::table('project_languages')->insert([
//         'project_id' => $id,
//         'programming_language_id' => $languageId,
//         'created_at' => now(),
//         'updated_at' => now(),
//     ]);

//     // Get all current image URLs
//     $allImages = DB::table('project_images')->where('project_id', $id)->get()->map(function ($image) {
//         return [
//             'id' => $image->id,
//             'url' => asset('storage/' . $image->image)
//         ];
//     });

//     $fileUrl = $filePath ? asset('storage/' . $filePath) : null;

//     $projectDetails = DB::table('projects')
//         ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
//         ->join('programming_languages', 'projects.programming_language_id', '=', 'programming_languages.id')
//         ->select(
//             'portfolios.id as portfolio_id',
//             'projects.id as project_id',
//             'projects.title',
//             'projects.description',
//             'projects.instruction',
//             'projects.link',
//             'programming_languages.programming_language as programming_language',
//             'projects.project_visibility_status'
//         )
//         ->where('projects.id', $id)
//         ->first();

//     return response()->json([
//         'message' => 'Project updated successfully.',
//         'project' => $projectDetails,
//         'file_url' => $fileUrl,
//         'images' => $allImages,
//     ]);
// }

public function updateProject(Request $request, $id)
{
    $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'required|string|max:255',
        'instruction' => 'required|string|max:255',
        'link' => 'nullable|string|max:255',
        'file' => 'nullable|mimes:zip', // Removed the 'file' validation which can cause issues
        'image' => 'nullable', // Changed to allow any format (array or null)
        'image.*' => 'image|mimes:jpeg,png,jpg,gif,svg',
        'programming_language' => 'required|string|max:255',
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

    // Handle programming language
    $languageName = $request->input('programming_language');
    $language = DB::table('programming_languages')->where('programming_language', $languageName)->first();
    $languageId = $language
        ? $language->id
        : DB::table('programming_languages')->insertGetId([
            'programming_language' => $languageName,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

    // FILE: Handle file upload with improved error handling
    $filePath = $project->file;
    
    // Debug information
    Log::info('File upload request details: ', [
        'has_file' => $request->hasFile('file'),
        'file_key_exists' => $request->has('file')
    ]);
    
    // Check if request wants to explicitly delete the file
    if ($request->has('file') && $request->input('file') === null) {
        if ($project->file) {
            $oldFilePath = storage_path('app/public/' . $project->file);
            if (file_exists($oldFilePath)) unlink($oldFilePath);
            Log::info('File deleted because request set file=null');
        }
        $filePath = null;
    } 
    // Check if there's a new file upload
    elseif ($request->hasFile('file')) {
        try {
            $file = $request->file('file');
            
            // Detailed logging for debugging
            Log::info('File upload object received: ', [
                'original_name' => $file->getClientOriginalName(),
                'mime_type' => $file->getMimeType(),
                'size' => $file->getSize(),
                'error' => $file->getError()
            ]);
            
            // Basic attempt to store the file directly
            try {
                // Generate unique filename
                $filename = time() . '_' . $file->getClientOriginalName();
                
                // Direct file storage without validation
                $filePath = 'projects/' . $filename;
                $success = Storage::disk('public')->put($filePath, file_get_contents($file->getRealPath()));
                $filePath = $success ? $filePath : null;
                Log::info('Direct file storage attempt result: ' . ($success ? 'success' : 'failed'));
                
                // Double check file exists
                if (Storage::disk('public')->exists($filePath)) {
                    Log::info('File found at path: ' . $filePath . ' with size: ' . Storage::disk('public')->size($filePath));
                } else {
                    Log::error('File not found after direct storage attempt');
                }
            } catch (\Exception $e) {
                Log::error('Direct storage exception: ' . $e->getMessage());
            }
            
            // If direct storage failed, try another approach
            if (empty($filePath)) {
                // Create storage directory if it doesn't exist
                $uploadPath = storage_path('app/public/projects');
                if (!file_exists($uploadPath)) {
                    mkdir($uploadPath, 0777, true);
                    Log::info('Created storage directory: ' . $uploadPath);
                }
                
                // Generate unique filename
                $filename = time() . '_' . $file->getClientOriginalName();
                $destinationPath = 'projects/' . $filename;
                
                // Move file manually
                $success = $file->move(storage_path('app/public/projects'), $filename);
                if ($success) {
                    $filePath = $destinationPath;
                    Log::info('Manual file move successful: ' . $filePath);
                } else {
                    Log::error('Manual file move failed');
                }
            }
            
            // Final check - if we still have no file path, report the error
            if (empty($filePath)) {
                Log::error('All file upload methods failed');
                return response()->json(['error' => 'File upload failed after multiple attempts'], 500);
            }
            
        } catch (\Exception $e) {
            Log::error('File upload exception: ' . $e->getMessage(), [
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json(['error' => 'File upload failed: ' . $e->getMessage()], 500);
        }
    }

    // Update project
    DB::table('projects')->where('id', $id)->update([
        'title' => $request->input('title'),
        'description' => $request->input('description'),
        'instruction' => $request->input('instruction'),
        'link' => $request->input('link'),
        'file' => $filePath,
        'programming_language_id' => $languageId,
        'project_visibility_status' => $request->input('project_visibility_status'),
        'updated_at' => now(),
    ]);

    // Update project_languages table
    DB::table('project_languages')->where('project_id', $id)->delete();
    DB::table('project_languages')->insert([
        'project_id' => $id,
        'programming_language_id' => $languageId,
        'created_at' => now(),
        'updated_at' => now(),
    ]);

    // Gather response data
    $fileUrl = $filePath ? asset('storage/' . $filePath) : null;
    $allImages = DB::table('project_images')->where('project_id', $id)->get()->map(function ($image) {
        return [
            'id' => $image->id,
            'url' => asset('storage/' . $image->image),
        ];
    });

    $projectDetails = DB::table('projects')
        ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
        ->join('programming_languages', 'projects.programming_language_id', '=', 'programming_languages.id')
        ->select(
            'portfolios.id as portfolio_id',
            'projects.id as project_id',
            'projects.title',
            'projects.description',
            'projects.instruction',
            'projects.link',
            'programming_languages.programming_language as programming_language',
            'projects.project_visibility_status'
        )
        ->where('projects.id', $id)
        ->first();

    return response()->json([
        'message' => 'Project updated successfully.',
        'project' => $projectDetails,
        'file_url' => $fileUrl,
        'images' => $allImages,
    ]);
}



    public function removeProjectImage(Request $request, $imageId)
    {
        // Find the image
        $image = DB::table('project_images')->where('id', $imageId)->first();

        if (!$image) {
            return response()->json(['error' => 'Image not found.'], 404);
        }

        // Find the associated project
        $project = DB::table('projects')->where('id', $image->project_id)->first();

        if (!$project) {
            return response()->json(['error' => 'Associated project not found.'], 404);
        }

        // Check if user owns the project
        $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
        $userId = $request->user()->google_id;

        if (!$portfolio || $portfolio->user_id != $userId) {
            return response()->json(['error' => 'You are not authorized to remove this image.'], 403);
        }

        // Delete the image file using unlink
        $imagePath = storage_path('app/public/' . $image->image);
        if (file_exists($imagePath)) {
            unlink($imagePath);
            Log::info('Deleted project image using unlink: ' . $imagePath);
        }

        // Delete the database record
        DB::table('project_images')->where('id', $imageId)->delete();
        Log::info('Deleted project image record with ID: ' . $imageId);

        return response()->json([
            'message' => 'Project image removed successfully.',
            'image_id' => $imageId
        ], 200);
    }

    public function removeProjectFile(Request $request, $projectId)
    {
        // Find the project
        $project = DB::table('projects')->where('id', $projectId)->first();

        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Check if the project has a file
        if (!$project->file) {
            return response()->json(['error' => 'This project has no file to remove.'], 404);
        }

        // Ensure user owns the project
        $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
        $userId = $request->user()->google_id;

        if (!$portfolio || $portfolio->user_id != $userId) {
            return response()->json(['error' => 'You are not authorized to remove this file.'], 403);
        }

        // Delete the file
        $filePath = storage_path('app/public/' . $project->file);
        if (file_exists($filePath)) {
            unlink($filePath);
            Log::info('Deleted project file using unlink: ' . $filePath);
        }

        // Update the project record to remove the file reference
        DB::table('projects')->where('id', $projectId)->update([
            'file' => null,
            'updated_at' => now()
        ]);

        return response()->json([
            'message' => 'Project file removed successfully.',
            'project_id' => $projectId
        ], 200);
    }


    public function deleteProject($id)
    {
        $project = DB::table('projects')->where('id', $id)->delete();
        return response()->json(['message' => 'Project deleted successfully.'], 200);
    }


    public function downloadProject($id, Request $request)
    {
        // Validate the query parameter
        $request->validate([
            'portfolio_id' => 'required|integer',
        ]);

        $portfolioId = $request->query('portfolio_id');

        // Find the project with improved query
        $project = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->select(
                'projects.id',
                'projects.title', 
                'projects.link',
                'projects.file'
            )
            ->where('portfolios.id', $portfolioId)
            ->where('projects.id', $id)
            ->first();

        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Check if project has a link or file
        if (empty($project->link) && empty($project->file)) {
            return response()->json(['error' => 'Project has no downloadable content.'], 404);
        }

        // Prepare the response data
        $responseData = [
            'project_id' => $project->id,
            'title' => $project->title,
        ];

        // Add link if exists
        if (!empty($project->link)) {
            $responseData['link'] = $project->link;
        }

        // Add file URL if exists
        if (!empty($project->file)) {
            $responseData['file_url'] = asset('storage/' . $project->file);
        }

        return response()->json($responseData);
    }
}
