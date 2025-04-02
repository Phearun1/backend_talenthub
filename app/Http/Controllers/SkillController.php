<?php

namespace App\Http\Controllers;

use App\Models\Portfolio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;


class SkillController extends Controller
{
    public function createSkill(Request $request)
    {
        DB::beginTransaction();

        try {
            // Validate the incoming request
            $request->validate([
                'portfolio_id' => 'required|integer',
                'title' => 'required|string|max:255',
                'description' => 'required|string|max:255',
                'endorsers' => 'nullable|array', // Optional array of endorser emails
                'endorsers.*' => 'email', // Validate each email in the array
            ]);

            // Get the portfolio owner's details
            $portfolio = DB::table('portfolios')
                ->join('users', 'portfolios.user_id', '=', 'users.google_id')
                ->select('users.email as owner_email')
                ->where('portfolios.id', $request->input('portfolio_id'))
                ->first();

            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            // Insert new skill into the database
            $skillId = DB::table('skills')->insertGetId([
                'portfolio_id' => $request->input('portfolio_id'),
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Prepare endorsers
            $endorsers = $request->input('endorsers', []);
            $endorserLinkData = [];
            $endorsementStatusData = [];
            $skippedEndorsers = [];

            foreach ($endorsers as $email) {
                // Skip if the endorser is the portfolio owner (self-endorsement)
                if ($email === $portfolio->owner_email) {
                    $skippedEndorsers[] = $email;
                    Log::warning("Skipped self-endorsement: {$email}");
                    continue;
                }

                $user = DB::table('users')->where('email', $email)->first();

                if ($user && $user->google_id) {
                    // Check if user has role_id = 2 (endorser role)
                    if ($user->role_id != 2) {
                        $skippedEndorsers[] = $email;
                        Log::warning("Skipped user with email {$email} as they don't have role_id = 2.");
                        continue;
                    }

                    // Prepare data for skill_endorsers table
                    $endorserLinkData[] = [
                        'skill_id' => $skillId,
                        'user_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];

                    // Prepare data for skill_endorsement_statuses table
                    $endorsementStatusData[] = [
                        'skill_id' => $skillId,
                        'endorser_id' => $user->google_id,
                        'endorsement_status_id' => 1, // Pending
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                } else {
                    $skippedEndorsers[] = $email;
                    Log::warning("User with email {$email} not found or missing google_id.");
                }
            }

            // Insert into skill_endorsers
            if (!empty($endorserLinkData)) {
                DB::table('skill_endorsers')->insert($endorserLinkData);
                Log::info('Inserted into skill_endorsers:', $endorserLinkData);
            }

            // Insert into skill_endorsement_statuses
            if (!empty($endorsementStatusData)) {
                DB::table('skill_endorsement_statuses')->insert($endorsementStatusData);
                Log::info('Inserted into skill_endorsement_statuses:', $endorsementStatusData);
            }

            DB::commit();

            // Fetch detailed information for endorsers
            $endorsersDetails = [];
            foreach ($endorserLinkData as $endorser) {
                // Fetch user details
                $user = DB::table('users')->where('google_id', $endorser['user_id'])->first();

                // Fetch endorsement status
                $status = DB::table('skill_endorsement_statuses')
                    ->where('skill_id', $skillId)
                    ->where('endorser_id', $endorser['user_id'])
                    ->first();

                // Fetch endorsement status name from the 'endorsement_statuses' table
                $statusName = DB::table('endorsement_statuses')
                    ->where('id', $status->endorsement_status_id)
                    ->value('status');

                $endorsersDetails[] = [
                    'id' => $endorser['user_id'],
                    'name' => $user->name ?? 'Unknown',
                    'email' => $user->email ?? 'Unknown',
                    'status' => $statusName ?? 'Pending', // Default to 'Pending' if status not found
                    'status_id' => $status->endorsement_status_id ?? 1, // Default to 'Pending' status ID
                ];
            }

            return response()->json([
                'message' => 'Skill created successfully.',
                'skill_id' => $skillId,
                'portfolio_id' => $request->input('portfolio_id'),
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'endorsers' => $endorsersDetails, // Detailed endorser data
                'skipped_endorsers' => $skippedEndorsers
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating skill: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.', 'error' => $e->getMessage()], 500);
        }
    }


    // Edit a skill
    // public function updateSkill(Request $request, $id)
    // {
    //     DB::beginTransaction();

    //     try {
    //         // Validate the incoming request
    //         $request->validate([
    //             'title' => 'required|string|max:255',
    //             'description' => 'required|string|max:255',
    //             'endorsers' => 'nullable|array',
    //             'endorsers.*' => 'email',
    //         ]);

    //         // Check if skill exists
    //         $skill = DB::table('skills')->where('id', $id)->first();

    //         if (!$skill) {
    //             return response()->json(['error' => 'Skill not found.'], 404);
    //         }

    //         // Get the portfolio owner's details
    //         $portfolio = DB::table('portfolios')
    //             ->join('users', 'portfolios.user_id', '=', 'users.google_id')
    //             ->select('users.email as owner_email')
    //             ->where('portfolios.id', $skill->portfolio_id)
    //             ->first();

    //         if (!$portfolio) {
    //             return response()->json(['error' => 'Portfolio not found.'], 404);
    //         }

    //         // Log the incoming request data
    //         Log::info('EditSkill Request:', $request->all());

    //         // Update the skill in the database
    //         DB::table('skills')->where('id', $id)->update([
    //             'title' => $request->input('title'),
    //             'description' => $request->input('description'),
    //             'updated_at' => now(),
    //         ]);

    //         // Handle new endorsers
    //         $endorsers = $request->input('endorsers', []);
    //         $endorserLinkData = [];
    //         $endorsementStatusData = [];
    //         $skippedEndorsers = [];

    //         $emails = $endorsers;  // Array of emails from the request
    //         $getGoogleIDs = DB::table('users')
    //             ->whereIn('email', $emails) // This fetches the google_id for all emails
    //             ->pluck('google_id', 'email') // Plucks google_id using email as the key
    //             ->toArray();

    //         // Get the existing endorsers for the skill
    //         $existingEndorsers = DB::table('skill_endorsement_statuses')
    //             ->where('skill_id', $id)
    //             ->pluck('endorser_id')
    //             ->toArray();

    //         foreach ($emails as $email) {
    //             if (isset($getGoogleIDs[$email])) {
    //                 $getGoogleID = $getGoogleIDs[$email];  // Fetch google_id for the current email

    //                 // Fetch user details for the current email
    //                 $user = DB::table('users')->where('google_id', $getGoogleID)->first();

    //                 // Check if the user exists and has role_id = 2
    //                 if ($user && $user->role_id == 2) {
    //                     // If the endorser already exists in the list of existing endorsers, just update
    //                     if (in_array($getGoogleID, $existingEndorsers)) {
    //                         // Update the endorsement status if already exists
    //                         DB::table('skill_endorsement_statuses')
    //                             ->where('skill_id', $id)
    //                             ->where('endorser_id', $getGoogleID)
    //                             ->update([
    //                                 'endorsement_status_id' => 1, // Set status to Pending or any other update logic
    //                                 'updated_at' => now(),
    //                             ]);
    //                         Log::info("Updated endorser status for: {$email}, Google ID: {$getGoogleID}");
    //                     } else {
    //                         // If the endorser does not exist, proceed to add new endorser
    //                         $endorserLinkData[] = [
    //                             'skill_id' => $id,
    //                             'user_id' => $getGoogleID,
    //                             'created_at' => now(),
    //                             'updated_at' => now(),
    //                         ];

    //                         $endorsementStatusData[] = [
    //                             'skill_id' => $id,
    //                             'endorser_id' => $getGoogleID,
    //                             'endorsement_status_id' => 1, // Pending status
    //                             'created_at' => now(),
    //                             'updated_at' => now(),
    //                         ];

    //                         // Log the addition of the new endorser
    //                         Log::info("Added new endorser: {$email}, Google ID: {$getGoogleID}");
    //                     }
    //                 } else {
    //                     // If the user doesn't have role_id = 2, skip the insertion
    //                     $skippedEndorsers[] = $email;
    //                     Log::warning("Skipped user with email {$email} — not role_id = 2.");
    //                 }
    //             } else {
    //                 Log::warning("Endorser with email {$email} not found in the database.");
    //             }
    //         }


    //         // Insert new endorsers into skill_endorsers
    //         if (!empty($endorserLinkData)) {
    //             DB::table('skill_endorsers')->insert($endorserLinkData);
    //             Log::info('Updated skill_endorsers:', $endorserLinkData);
    //         }

    //         // Insert new endorsement statuses into skill_endorsement_statuses
    //         if (!empty($endorsementStatusData)) {
    //             DB::table('skill_endorsement_statuses')->insert($endorsementStatusData);
    //             Log::info('Updated skill_endorsement_statuses:', $endorsementStatusData);
    //         }

    //         // Commit the transaction
    //         DB::commit();

    //         // Fetch detailed information for endorsers
    //         $endorsersDetails = [];
    //         foreach ($endorsers as $email) {
    //             // Skip if the endorser is the portfolio owner (self-endorsement)
    //             if ($email === $portfolio->owner_email) {
    //                 $skippedEndorsers[] = $email;
    //                 Log::warning("Skipped self-endorsement: {$email}");
    //                 continue;
    //             }

    //             $user = DB::table('users')->where('email', $email)->first();

    //             if ($user && $user->google_id) {
    //                 // Add endorser details
    //                 $endorsersDetails[] = [
    //                     'id' => $user->google_id,
    //                     'name' => $user->name ?? 'Unknown',
    //                     'email' => $user->email ?? 'Unknown',
    //                     'status' => 'Pending',  // Default to 'Pending' (it can be fetched based on your requirement)
    //                     'status_id' => 1, // Default status ID (Pending)
    //                 ];
    //             } else {
    //                 $skippedEndorsers[] = $email;
    //                 Log::warning("Skipped endorser: {$email} — user not found or missing google_id.");
    //             }
    //         }

    //         return response()->json([
    //             'message' => 'Skill updated successfully.',
    //             'skill_id' => $id,
    //             'portfolio_id' => $request->input('portfolio_id'),
    //             'title' => $request->input('title'),
    //             'description' => $request->input('description'),
    //             'endorsers' => $endorsersDetails, // Detailed endorser data
    //             'skipped_endorsers' => $skippedEndorsers
    //         ], 200);
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         Log::error('Error updating skill: ' . $e->getMessage());
    //         return response()->json(['message' => 'Something went wrong.', 'error' => $e->getMessage()], 500);
    //     }
    // }

    public function updateSkill(Request $request, $id)
{
    DB::beginTransaction();

    try {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'endorsers' => 'nullable|array',
            'endorsers.*' => 'email',
        ]);

        $skill = DB::table('skills')->where('id', $id)->first();
        if (!$skill) return response()->json(['error' => 'Skill not found.'], 404);

        $portfolio = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select('users.email as owner_email')
            ->where('portfolios.id', $skill->portfolio_id)
            ->first();
        if (!$portfolio) return response()->json(['error' => 'Portfolio not found.'], 404);

        DB::table('skills')->where('id', $id)->update([
            'title' => $request->title,
            'description' => $request->description,
            'updated_at' => now(),
        ]);

        $emails = $request->input('endorsers', []);
        $users = DB::table('users')->whereIn('email', $emails)->get();

        $validEndorsers = $users->filter(function ($user) use ($portfolio) {
            return $user->role_id == 2 && $user->email !== $portfolio->owner_email;
        });

        $newGoogleIDs = $validEndorsers->pluck('google_id')->toArray();

        // Current endorsers in the database
        $existingEndorsers = DB::table('skill_endorsement_statuses')
            ->where('skill_id', $id)
            ->pluck('endorser_id')
            ->toArray();

        $toRemove = array_diff($existingEndorsers, $newGoogleIDs);
        $toKeep = array_intersect($existingEndorsers, $newGoogleIDs);
        $toConsiderAdding = array_diff($newGoogleIDs, $existingEndorsers);

        // Remove those no longer in request
        if (!empty($toRemove)) {
            DB::table('skill_endorsers')->where('skill_id', $id)->whereIn('user_id', $toRemove)->delete();
            DB::table('skill_endorsement_statuses')->where('skill_id', $id)->whereIn('endorser_id', $toRemove)->delete();
        }

        // Try to find soft-existing rows to update instead of creating new
        foreach ($toConsiderAdding as $googleId) {
            // Check if a row for this user_id and skill_id exists (soft-deleted or previously not linked)
            $endorserRow = DB::table('skill_endorsers')
                ->where('user_id', $googleId)
                ->where('skill_id', $id)
                ->first();

            $statusRow = DB::table('skill_endorsement_statuses')
                ->where('endorser_id', $googleId)
                ->where('skill_id', $id)
                ->first();

            // Only update if record already existed (no new insert)
            if ($endorserRow && $statusRow) {
                DB::table('skill_endorsers')->where('id', $endorserRow->id)->update([
                    'updated_at' => now(),
                ]);

                DB::table('skill_endorsement_statuses')->where('id', $statusRow->id)->update([
                    'endorsement_status_id' => 1,
                    'updated_at' => now(),
                ]);
            } else {
                // Skip adding if not found (no new row allowed)
                Log::info("Skipping new row creation for Google ID: {$googleId} as it didn't exist before.");
            }
        }

        DB::commit();

        // Return final list of endorsers
        $endorsersDetails = [];
        foreach ($newGoogleIDs as $googleId) {
            $user = $users->firstWhere('google_id', $googleId);
            $status = DB::table('skill_endorsement_statuses')
                ->where('skill_id', $id)
                ->where('endorser_id', $googleId)
                ->first();

            $statusName = DB::table('endorsement_statuses')
                ->where('id', $status->endorsement_status_id ?? 1)
                ->value('status');

            $endorsersDetails[] = [
                'id' => $googleId,
                'name' => $user->name ?? 'Unknown',
                'email' => $user->email ?? 'Unknown',
                'status' => $statusName ?? 'Pending',
                'status_id' => $status->endorsement_status_id ?? 1,
            ];
        }

        return response()->json([
            'message' => 'Skill updated successfully.',
            'skill_id' => $id,
            'portfolio_id' => $skill->portfolio_id,
            'title' => $request->title,
            'description' => $request->description,
            'endorsers' => $endorsersDetails
        ], 200);
    } catch (\Exception $e) {
        DB::rollBack();
        Log::error('Error updating skill: ' . $e->getMessage());
        return response()->json(['message' => 'Something went wrong.', 'error' => $e->getMessage()], 500);
    }
}


    // Delete a skill

    public function deleteSkill($id)
    {
        DB::beginTransaction();

        try {
            // First, delete all the endorsers and endorsement statuses associated with the skill
            DB::table('skill_endorsers')->where('skill_id', $id)->delete();
            DB::table('skill_endorsement_statuses')->where('skill_id', $id)->delete();

            // Then, delete the skill itself
            $deleted = DB::table('skills')->where('id', $id)->delete();

            if ($deleted) {
                DB::commit();
                return response()->json(['message' => 'Skill and its endorsers deleted successfully.'], 200);
            } else {
                DB::rollBack();
                return response()->json(['error' => 'Skill not found.'], 404);
            }
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error deleting skill: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
        }
    }
}
