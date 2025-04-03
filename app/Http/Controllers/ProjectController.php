<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class ProjectController extends Controller
{
    // public function createProject(Request $request)
    // {
    //     // Validate the incoming request data
    //     $request->validate([
    //         'portfolio_id' => 'required|integer',
    //         'title' => 'required|string|max:255',
    //         'description' => 'required|string|max:255',
    //         'instruction' => 'required|string|max:255',
    //         'link' => 'nullable|string|max:255',
    //         'file' => 'nullable|string|max:255',
    //         'programming_language_id' => 'required|integer',
    //         'project_visibility_status' => 'required|integer',
    //     ]);

    //     // Get the authenticated user's ID
    //     $userId = $request->user()->google_id;

    //     // Log the authenticated user's ID
    //     Log::info('Authenticated User ID: ' . $userId);

    //     // Check if the portfolio belongs to the authenticated user
    //     $portfolio = DB::table('portfolios')->where('id', $request->input('portfolio_id'))->first();

    //     // Log the portfolio details
    //     Log::info('Portfolio Details: ', (array) $portfolio);

    //     if (!$portfolio || $portfolio->user_id != $userId) {
    //         return response()->json(['error' => 'You are not authorized to create a project for this portfolio.'], 403);
    //     }

    //     // Insert the project into the database and get the ID
    //     $projectId = DB::table('projects')->insertGetId([
    //         'portfolio_id' => $request->input('portfolio_id'),
    //         'title' => $request->input('title'),
    //         'description' => $request->input('description'),
    //         'instruction' => $request->input('instruction'),
    //         'link' => $request->input('link'),
    //         'file' => $request->input('file'),
    //         'programming_language_id' => $request->input('programming_language_id'),
    //         'project_visibility_status' => $request->input('project_visibility_status'),
    //         'created_at' => now(),
    //         'updated_at' => now(),
    //     ]);

    //     // Return a success response
    //     return response()->json([
    //         'message' => 'Project created successfully.',
    //         'project' => $projectId,
    //     ], 200);
    // }


    public function createProject(Request $request)
{
    // Validate the incoming request data
    $request->validate([
        'portfolio_id' => 'required|integer',
        'title' => 'required|string|max:255',
        'description' => 'required|string|max:255',
        'instruction' => 'required|string|max:255',
        'link' => 'nullable|string|max:255',
        'file' => 'nullable|file|mimes:jpeg,png,jpg,gif,svg,zip|max:2048',  // Validate file
        'programming_language_id' => 'required|integer',
        'project_visibility_status' => 'required|integer',
    ]);

    // Get the authenticated user's ID
    $userId = $request->user()->google_id;

    // Log the authenticated user's ID
    Log::info('Authenticated User ID: ' . $userId);

    // Check if the portfolio belongs to the authenticated user
    $portfolio = DB::table('portfolios')->where('id', $request->input('portfolio_id'))->first();

    // Log the portfolio details
    Log::info('Portfolio Details: ', (array) $portfolio);

    if (!$portfolio || $portfolio->user_id != $userId) {
        return response()->json(['error' => 'You are not authorized to create a project for this portfolio.'], 403);
    }

    // Handle file upload if a file is provided
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
        'programming_language_id' => $request->input('programming_language_id'),
        'project_visibility_status' => $request->input('project_visibility_status'),
        'created_at' => now(),
        'updated_at' => now(),
    ]);

    // Return a success response
    return response()->json([
        'message' => 'Project created successfully.',
        'project' => $projectId,
        'file_path' => $filePath ? Storage::url($filePath) : null, // Optionally return file URL
    ], 200);
}



    public function viewProjectDetail($projectId)
    {
        // Retrieve the project details
        $project = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
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
            )
            ->where('projects.id', $projectId)
            ->first();

        // Log the query result for debugging
        Log::info('Project Query Result: ', (array) $project);

        // Check if the project exists
        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Return the project details
        return response()->json($project);
    }

    
    public function updateProject(Request $request, $id)
    {
        // Validate the incoming request data (remove portfolio_id from validation)
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'instruction' => 'required|string|max:255',
            'link' => 'nullable|string|max:255',
            'file' => 'nullable|string|max:255',
            'programming_language_id' => 'required|integer',
            'project_visibility_status' => 'required|integer',
        ]);

        // Check if the project exists
        $project = DB::table('projects')->where('id', $id)->first();

        if (!$project) {
            return response()->json(['error' => 'Project not found.'], 404);
        }

        // Ensure that the project belongs to the authenticated user and their portfolio
        $portfolio = DB::table('portfolios')->where('id', $project->portfolio_id)->first();
        $userId = $request->user()->google_id;

        if (!$portfolio || $portfolio->user_id != $userId) {
            return response()->json(['error' => 'You are not authorized to update this project.'], 403);
        }

        // Update the project in the database, excluding portfolio_id
        DB::table('projects')->where('id', $id)->update([
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'instruction' => $request->input('instruction'),
            'link' => $request->input('link'),
            'file' => $request->input('file'),
            'programming_language_id' => $request->input('programming_language_id'),
            'project_visibility_status' => $request->input('project_visibility_status'),
            'updated_at' => now(),
        ]);

        // Fetch the updated project
        $updatedProject = DB::table('projects')->where('id', $id)->first();

        // Return a success response
        return response()->json([
            'message' => 'Project updated successfully.',
            'project' => $updatedProject,
        ], 200);
    }

    public function deleteProject($id)
    {
        $project = DB::table('projects')->where('id', $id)->delete();
        return response()->json(['message' => 'Project deleted successfully.'], 200);
    }
}
