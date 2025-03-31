<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;



class SkillController extends Controller
{
    // Create a new skill
    public function createSkill(Request $request)
    {
        try {
            // Validate the incoming request
            $request->validate([
                'portfolio_id' => 'required|integer',
                'title' => 'required|string|max:255',
                'description' => 'required|string|max:255',
                'endorsers' => 'nullable|array', 
                'endorsers.*' => 'email', 
            ]);

            $skillId = DB::table('skills')->insertGetId([
                'portfolio_id' => $request->input('portfolio_id'),
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $endorsers = $request->input('endorsers', []); 
            $endorserIds = [];

            foreach ($endorsers as $email) {
                $user = DB::table('users')->where('email', $email)->first();

                if ($user) {
                    $endorserIds[] = [
                        'skill_id' => $skillId,
                        'user_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                } else {
                    // Log or handle the case where the email does not match any user
                    Log::warning("User with email {$email} not found.");
                }
            }

            // Insert endorsers into the skill_endorsers table
            if (!empty($endorserIds)) {
                DB::table('skill_endorsers')->insert($endorserIds);
            }

            return response()->json([
                'message' => 'Skill created successfully.',
                'skill_id' => $skillId,
                'endorser_name'=> $user->name,
                'endorser_email'=> $user->email,
                'endorser_id'=> $user->google_id,
                'endorsers_added' => count($endorserIds),
            ], 201);
        } catch (\Exception $e) {
            // Log the error and return a generic error message
            Log::error('Error creating skill: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
        }
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
