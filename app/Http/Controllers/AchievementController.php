<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
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
        DB::beginTransaction();

        try {
            // Validation
            $validator = Validator::make($request->all(), [
                'portfolio_id' => 'required|integer',
                'title' => 'required|string|max:255',
                'issued_by' => 'required|string|max:255',
                'issue_date' => 'required|date',
                'description' => 'nullable|string|max:255',
                'image' => 'required|string|max:255',
                'endorsers' => 'nullable|array', // Array of endorser emails
                'endorsers.*' => 'email', // Validate each email in the array
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 400);
            }

            // Insert into the achievements table
            $achievementId = DB::table('achievements')->insertGetId([
                'portfolio_id' => $request->portfolio_id,
                'title' => $request->title,
                'issued_by' => $request->issued_by,
                'issue_date' => $request->issue_date,
                'description' => $request->description,
                'image' => $request->image,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Handle endorsers if provided
            $endorsers = $request->input('endorsers', []);
            $endorserData = [];
            $endorsementStatusData = [];

            foreach ($endorsers as $email) {
                // Find the user by email
                $user = DB::table('users')->where('email', $email)->first();

                if ($user && $user->google_id) {
                    // Log user info
                    Log::info("Processing endorser: {$email}, Google ID: {$user->google_id}");

                    // Prepare data for achievement_endorsers table
                    $endorserData[] = [
                        'achievement_id' => $achievementId,
                        'user_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];

                    // Prepare data for achievement_endorsement_statuses table (default to Pending)
                    $endorsementStatusData[] = [
                        'achievement_id' => $achievementId,
                        'endorsement_status_id' => 1, // Pending
                        'endorser_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                } else {
                    Log::warning("Skipped endorser: {$email} — user not found or missing google_id.");
                }
            }

            // Insert endorsers into achievement_endorsers
            if (!empty($endorserData)) {
                DB::table('achievement_endorsers')->insert($endorserData);
                Log::info('Inserted into achievement_endorsers:', $endorserData);
            }

            // Insert endorsement statuses into achievement_endorsement_statuses
            if (!empty($endorsementStatusData)) {
                DB::table('achievement_endorsement_statuses')->insert($endorsementStatusData);
                Log::info('Inserted into achievement_endorsement_statuses:', $endorsementStatusData);
            }

            // Commit the transaction
            DB::commit();

            return response()->json(['message' => 'Achievement created successfully'], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating achievement: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
        }
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
