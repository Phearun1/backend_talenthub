<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ProjectController extends Controller
{
public function createProject(Request $request)
{
    // Validate the incoming request data
    $request->validate([
        'portfolio_id' => 'required|integer',
        'title' => 'required|string|max:255',
        'description' => 'required|string|max:255',
        'instruction' => 'required|string|max:255',
        'link' => 'nullable|string|max:255',
        'file' => 'nullable|string|max:255',
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

    // Insert the project into the database
    $project = DB::table('projects')->insert([
        'portfolio_id' => $request->input('portfolio_id'),
        'title' => $request->input('title'),
        'description' => $request->input('description'),
        'instruction' => $request->input('instruction'),
        'link' => $request->input('link'),
        'file' => $request->input('file'),
        'programming_language_id' => $request->input('programming_language_id'),
        'project_visibility_status' => $request->input('project_visibility_status'),
        'created_at' => now(),
        'updated_at' => now(),
    ]);

    // Return a success response
    return response()->json([
        'message' => 'Project created successfully.',
        'project' => $project,
    ], 201);
}
}
