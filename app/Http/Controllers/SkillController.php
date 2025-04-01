<?php

namespace App\Http\Controllers;

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
                    // Log user info
                    Log::info("Processing endorser: {$email}, Google ID: {$user->google_id}");

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

            return response()->json([
                'message' => 'Skill created successfully.',
                'skill_id' => $skillId,
                'portfolio_id' => $request->input('portfolio_id'),
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'endorsers' => $request->input('endorsers', []),
                'skipped_endorsers' => $skippedEndorsers
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating skill: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
        }
    }

    // Edit a skill
    public function updateSkill(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            // Validate the incoming request
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'required|string|max:255',
                'endorsers' => 'nullable|array',
                'endorsers.*' => 'email',
            ]);

            // Check if skill exists
            $skill = DB::table('skills')->where('id', $id)->first();

            if (!$skill) {
                return response()->json(['error' => 'Skill not found.'], 404);
            }

            // Get the portfolio owner's details
            $portfolio = DB::table('portfolios')
                ->join('users', 'portfolios.user_id', '=', 'users.google_id')
                ->select('users.email as owner_email')
                ->where('portfolios.id', $skill->portfolio_id)
                ->first();

            if (!$portfolio) {
                return response()->json(['error' => 'Portfolio not found.'], 404);
            }

            // Log the incoming request data
            Log::info('EditSkill Request:', $request->all());

            // Update the skill in the database
            DB::table('skills')->where('id', $id)->update([
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'updated_at' => now(),
            ]);

            // Clear existing endorsers and endorsements for the skill
            DB::table('skill_endorsers')->where('skill_id', $id)->delete();
            DB::table('skill_endorsement_statuses')->where('skill_id', $id)->delete();

            // Handle new endorsers
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
                    // Log user info
                    Log::info("Processing updated endorser: {$email}, Google ID: {$user->google_id}");

                    // For skill_endorsers
                    $endorserLinkData[] = [
                        'skill_id' => $id,
                        'user_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];

                    // For skill_endorsement_statuses
                    $endorsementStatusData[] = [
                        'skill_id' => $id,
                        'endorser_id' => $user->google_id,
                        'endorsement_status_id' => 1, // Pending
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                } else {
                    $skippedEndorsers[] = $email;
                    Log::warning("Skipped endorser: {$email} — user not found or missing google_id.");
                }
            }

            // Insert new endorsers into skill_endorsers
            if (!empty($endorserLinkData)) {
                DB::table('skill_endorsers')->insert($endorserLinkData);
                Log::info('Updated skill_endorsers:', $endorserLinkData);
            }

            // Insert new endorsement statuses into skill_endorsement_statuses
            if (!empty($endorsementStatusData)) {
                DB::table('skill_endorsement_statuses')->insert($endorsementStatusData);
                Log::info('Updated skill_endorsement_statuses:', $endorsementStatusData);
            }

            // Commit the transaction
            DB::commit();

            return response()->json([
                
                'skill_id' => $id,
                'portfolio_id' => $request->input('portfolio_id'),
                'title' => $request->input('title'),
                'description' => $request->input('description'),
                'endorsers' => $request->input('endorsers', []),
                'skipped_endorsers' => $skippedEndorsers
                
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error updating skill: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
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
