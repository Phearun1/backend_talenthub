<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class EducationController extends Controller
{
    /**
     * View Education Detail
     */
    public function viewEducationDetail($id)
    {
        // Retrieve the education details for a specific portfolio
        $education = DB::table('education')->where('id', $id)->first();

        if (!$education) {
            return response()->json(['error' => 'Education not found.'], 404);
        }

        return response()->json($education);
    }

    /**
     * Create a new Education entry
     */
    public function createEducation(Request $request)
    {
        // Get the authenticated user (via the token)
        $user = $request->user();  // This will return the authenticated user based on the token

        // Validate the input data
        $request->validate([
            'portfolio_id' => 'required|integer',
            'education_center' => 'required|string|max:255',
            'field_of_study' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'start_month' => 'required|string|max:255',
            'end_month' => 'nullable|string|max:255',
            'start_year' => 'required|string|max:255',
            'end_year' => 'nullable|string|max:255',
        ]);

        // Check if the portfolio belongs to the authenticated user
        $portfolio = DB::table('portfolios')->where('id', $request->portfolio_id)->first();

        if (!$portfolio || $portfolio->user_id !== $user->google_id) {
            return response()->json(['error' => 'You are not authorized to create education for this portfolio.'], 403);
        }

        // Insert new education record and get the ID
        $educationId = DB::table('education')->insertGetId([
            'portfolio_id' => $request->portfolio_id,
            'education_center' => $request->education_center,
            'field_of_study' => $request->field_of_study,
            'description' => $request->description,
            'start_month' => $request->start_month,
            'end_month' => $request->end_month,
            'start_year' => $request->start_year,
            'end_year' => $request->end_year,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Retrieve the full education details
        $education = DB::table('education')->where('id', $educationId)->first();

        return response()->json([
            'message' => 'Education created successfully!',
            'education' => $education, // Returning the full education record
        ], 200);
    }

    /**
     * Update Education entry
     */
    public function updateEducation(Request $request, $id)
    {
        // Get the authenticated user (via the token)
        $user = $request->user();  // This will return the authenticated user based on the token

        // Validate the input data
        $request->validate([
            'education_center' => 'required|string|max:255',
            'field_of_study' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'start_year' => 'required|string|max:255',
            'end_year' => 'nullable|string|max:255',
        ]);

        // Find the education entry by ID
        $education = DB::table('education')->where('id', $id)->first();

        if (!$education) {
            return response()->json(['error' => 'Education not found.'], 404);
        }

        // Ensure the authenticated user is the owner of the portfolio
        $portfolio = DB::table('portfolios')->where('id', $education->portfolio_id)->first();
        if (!$portfolio || $portfolio->user_id !== $user->google_id) {
            return response()->json(['error' => 'You are not authorized to update this education record.'], 403);
        }

        // Update the existing education record
        $educationUpdated = DB::table('education')->where('id', $id)->update([
            'education_center' => $request->education_center,
            'field_of_study' => $request->field_of_study,
            'description' => $request->description,
            'start_year' => $request->start_year,
            'end_year' => $request->end_year,
            'updated_at' => now(),
        ]);

        if ($educationUpdated) {
            // Retrieve the updated education details
            $education = DB::table('education')->where('id', $id)->first();

            return response()->json([
                'message' => 'Education updated successfully!',
                'education' => $education, // Returning the full updated education record
            ], 200);
        }

        return response()->json(['error' => 'Education not found.'], 404);
    }

    /**
     * Delete Education entry
     */
    public function deleteEducation(Request $request, $id)
    {
        // Get the authenticated user (via the token)
        $user = $request->user();  // This will return the authenticated user based on the token

        // Find the education entry by ID
        $education = DB::table('education')->where('id', $id)->first();

        if (!$education) {
            return response()->json(['error' => 'Education not found.'], 404);
        }

        // Ensure the authenticated user is the owner of the portfolio
        $portfolio = DB::table('portfolios')->where('id', $education->portfolio_id)->first();
        if (!$portfolio || $portfolio->user_id !== $user->google_id) {
            return response()->json(['error' => 'You are not authorized to delete this education record.'], 403);
        }

        // Delete the education record by ID
        $educationDeleted = DB::table('education')->where('id', $id)->delete();

        if ($educationDeleted) {
            return response()->json(['message' => 'Education deleted successfully!'], 200);
        }

        return response()->json(['error' => 'Education not found.'], 404);
    }
}
