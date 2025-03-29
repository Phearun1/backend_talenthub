<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AchievementController extends Controller
{

    // View Single Achievement by ID
    public function viewAchievementDetail($id)
    {
        $achievement = DB::table('achievements')->where('id', $id)->first();
        if (!$achievement) {
            return response()->json(['error' => 'Achievement not found'], 404);
        }
        return response()->json($achievement);
    }


    // Create New Achievement
    public function createAchievement(Request $request)
    {
        // Validation
        $validator = Validator::make($request->all(), [
            'portfolio_id' => 'required|integer',
            'title' => 'required|string|max:255',
            'issued_by' => 'required|string|max:255',
            'issue_date' => 'required|date',
            'description' => 'nullable|string|max:255',
            'image' => 'required|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Insert into database
        $achievement = DB::table('achievements')->insert([
            'portfolio_id' => $request->portfolio_id,
            'title' => $request->title,
            'issued_by' => $request->issued_by,
            'issue_date' => $request->issue_date,
            'description' => $request->description,
            'image' => $request->image,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json(['message' => 'Achievement created successfully']);
    }

    // Update Achievement by ID
    public function updateAchievement(Request $request, $id)
    {
        // Validation
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'issued_by' => 'nullable|string|max:255',
            'issue_date' => 'nullable|date',
            'description' => 'nullable|string|max:255',
            'image' => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Check if the achievement exists
        $achievement = DB::table('achievements')->where('id', $id)->first();

        if (!$achievement) {
            return response()->json(['error' => 'Achievement not found'], 404);
        }

        // Update the achievement
        DB::table('achievements')->where('id', $id)->update([
            'title' => $request->title,
            'issued_by' => $request->issued_by,
            'issue_date' => $request->issue_date,
            'description' => $request->description,
            'image' => $request->image,
            'updated_at' => now(),
        ]);

        return response()->json(['message' => 'Achievement updated successfully']);
    }
    

    // Delete Achievement by ID
    public function deleteAchievement($id)
    {
        // Delete achievement
        $deleted = DB::table('achievements')->where('id', $id)->delete();

        if (!$deleted) {
            return response()->json(['error' => 'Achievement not found'], 404);
        }

        return response()->json(['message' => 'Achievement deleted successfully']);
    }
}
