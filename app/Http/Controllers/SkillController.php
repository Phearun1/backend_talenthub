<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class SkillController extends Controller
{
    // Create a new skill
    public function createSkill(Request $request)
    {
        // Validate the incoming request
        $request->validate([
            'portfolio_id' => 'required|integer',
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
        ]);

        // Insert new skill into the database
        $skill = DB::table('skills')->insertGetId([
            'portfolio_id' => $request->input('portfolio_id'),
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Return the created skill as a response
        return response()->json([
            'message' => 'Skill created successfully.',
            'skill_id' => $skill
        ], 201);
    }

    // Edit a skill
    public function editSkill(Request $request, $id)
    {
        // Validate the incoming request
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
        ]);

        // Update the skill in the database
        $updated = DB::table('skills')->where('id', $id)->update([
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'updated_at' => now(),
        ]);

        if ($updated) {
            return response()->json(['message' => 'Skill updated successfully.'], 200);
        } else {
            return response()->json(['error' => 'Skill not found.'], 404);
        }
    }

    // Delete a skill
    public function deleteSkill($id)
    {
        $deleted = DB::table('skills')->where('id', $id)->delete();

        if ($deleted) {
            return response()->json(['message' => 'Skill deleted successfully.'], 200);
        } else {
            return response()->json(['error' => 'Skill not found.'], 404);
        }
    }
}

