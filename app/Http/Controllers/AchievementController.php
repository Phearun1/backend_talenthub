<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class AchievementController extends Controller
{
    /**
     * View Single Achievement by ID
     */
    public function viewAchievementDetail($id)
    {
        // Retrieve the achievement details
        $achievement = DB::table('achievements')
            ->where('id', $id)
            ->first();

        if (!$achievement) {
            return response()->json(['error' => 'Achievement not found'], 404);
        }

        // Retrieve related endorsers and their endorsement statuses
        $endorsers = DB::table('achievement_endorsers')
            ->join('users', 'achievement_endorsers.user_id', '=', 'users.google_id')
            ->join('achievement_endorsement_statuses', 'achievement_endorsers.achievement_id', '=', 'achievement_endorsement_statuses.achievement_id')
            ->join('endorsement_statuses', 'achievement_endorsement_statuses.endorsement_status_id', '=', 'endorsement_statuses.id')
            ->select(
                'users.name as name',
                'users.email as email',
                'endorsement_statuses.id as status_id',
                'endorsement_statuses.status as status'
            )
            ->where('achievement_endorsers.achievement_id', $id)
            ->distinct() // Ensures no duplicates for endorsers
            ->get();

        // Include endorsers in the response
        $achievement->endorsers = $endorsers;

        return response()->json($achievement);
    }

    /**
     * Create a new Achievement entry
     */
    // public function createAchievement(Request $request)
    // {
    //     DB::beginTransaction();

    //     try {
    //         // Get the authenticated user (via the token)
    //         $user = $request->user();  // This will return the authenticated user based on the token

    //         // Validation
    //         $validator = Validator::make($request->all(), [
    //             'portfolio_id' => 'required|integer',
    //             'title' => 'required|string|max:255',
    //             'issued_by' => 'required|string|max:255',
    //             'issue_date' => 'required|date',
    //             'description' => 'nullable|string|max:255',
    //             'image' => 'required|string|max:255',
    //             'endorsers' => 'nullable|array', // Array of endorser emails
    //             'endorsers.*' => 'email', // Validate each email in the array
    //         ]);

    //         if ($validator->fails()) {
    //             return response()->json(['error' => $validator->errors()], 400);
    //         }

    //         // Check if the portfolio belongs to the authenticated user
    //         $portfolio = DB::table('portfolios')->where('id', $request->portfolio_id)->first();

    //         if (!$portfolio || $portfolio->user_id !== $user->google_id) {
    //             return response()->json(['error' => 'You are not authorized to create achievement for this portfolio.'], 403);
    //         }

    //         // Insert into the achievements table
    //         $achievementId = DB::table('achievements')->insertGetId([
    //             'portfolio_id' => $request->portfolio_id,
    //             'title' => $request->title,
    //             'issued_by' => $request->issued_by,
    //             'issue_date' => $request->issue_date,
    //             'description' => $request->description,
    //             'image' => $request->image,
    //             'created_at' => now(),
    //             'updated_at' => now(),
    //         ]);

    //         // Handle endorsers if provided
    //         $endorsers = $request->input('endorsers', []);
    //         $endorserData = [];
    //         $endorsementStatusData = [];

    //         foreach ($endorsers as $email) {
    //             // Find the user by email
    //             $user = DB::table('users')->where('email', $email)->first();

    //             if ($user && $user->google_id) {
    //                 // Check if the user has role_id = 2
    //                 if ($user->role_id != 2) {
    //                     Log::warning("Skipped user: {$email} — they do not have role_id = 2.");
    //                     continue;
    //                 }

    //                 // Prepare data for achievement_endorsers table
    //                 $endorserData[] = [
    //                     'achievement_id' => $achievementId,
    //                     'user_id' => $user->google_id,
    //                     'created_at' => now(),
    //                     'updated_at' => now(),
    //                 ];

    //                 // Prepare data for achievement_endorsement_statuses table (default to Pending)
    //                 $endorsementStatusData[] = [
    //                     'achievement_id' => $achievementId,
    //                     'endorsement_status_id' => 1, // Pending
    //                     'endorser_id' => $user->google_id,
    //                     'created_at' => now(),
    //                     'updated_at' => now(),
    //                 ];
    //             } else {
    //                 Log::warning("Skipped endorser: {$email} — user not found or missing google_id.");
    //             }
    //         }

    //         // Insert endorsers into achievement_endorsers
    //         if (!empty($endorserData)) {
    //             DB::table('achievement_endorsers')->insert($endorserData);
    //             Log::info('Inserted into achievement_endorsers:', $endorserData);
    //         }

    //         // Insert endorsement statuses into achievement_endorsement_statuses
    //         if (!empty($endorsementStatusData)) {
    //             DB::table('achievement_endorsement_statuses')->insert($endorsementStatusData);
    //             Log::info('Inserted into achievement_endorsement_statuses:', $endorsementStatusData);
    //         }

    //         // Commit the transaction
    //         DB::commit();

    //         return response()->json(['message' => 'Achievement created successfully'], 200);
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         Log::error('Error creating achievement: ' . $e->getMessage());
    //         return response()->json(['message' => 'Something went wrong.'], 500);
    //     }
    // }


    public function createAchievement(Request $request)
    {
        DB::beginTransaction();

        try {
            // Get the authenticated user (via the token)
            $user = $request->user();  // This will return the authenticated user based on the token

            // Validation
            $validator = Validator::make($request->all(), [
                'portfolio_id' => 'required|integer',
                'title' => 'required|string|max:255',
                'issued_by' => 'nullable|string|max:255', // This can be NULL
                'issue_month' => 'nullable|string|max:255', // Month of issue
                'issue_year' => 'nullable|string|max:255', // Year of issue
                'description' => 'nullable|string|max:255', // Description is now optional
                'image' => 'nullable|image', // Image should be a valid file with specific mime types and size limit
                'endorsers' => 'nullable|array', // Array of endorser emails
                'endorsers.*' => 'email', // Validate each email in the array
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 400);
            }

            // Check if the portfolio belongs to the authenticated user
            $portfolio = DB::table('portfolios')->where('id', $request->portfolio_id)->first();

            if (!$portfolio || $portfolio->user_id !== $user->google_id) {
                return response()->json(['error' => 'You are not authorized to create achievement for this portfolio.'], 403);
            }

            // Handle image upload if an image is provided
            $imageUrl = null;
            if ($request->hasFile('image')) {
                $image = $request->file('image');

                // Store the image in the 'achievements' folder under 'public' disk
                $imagePath = $image->store('achievements', 'public');

                // Generate the public URL for the uploaded image
                $baseUrl = asset('storage/'); // Base URL for accessing files
                $imageUrl = $baseUrl . '/' . $imagePath; // Full URL for the image
            }

            // Insert into the achievements table
            $achievementId = DB::table('achievements')->insertGetId([
                'portfolio_id' => $request->portfolio_id,
                'title' => $request->title,
                'issued_by' => $request->issued_by,
                'issue_month' => $request->issue_month,
                'issue_year' => $request->issue_year,
                'description' => $request->description,
                'image' => $imageUrl, // Store the image URL in the database
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
                    // Check if the user has role_id = 2
                    if ($user->role_id != 2) {
                        Log::warning("Skipped user: {$email} — they do not have role_id = 2.");
                        continue;
                    }

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

            return response()->json([
                'message' => 'Achievement created successfully',
                'achievement_id' => $achievementId,
                'title' => $request->title,
                'issued_by' => $request->issued_by,
                'issue_month' => $request->issue_month,
                'issue_year' => $request->issue_year,
                'description' => $request->description,
                'photo' => $imageUrl
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating achievement: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
        }
    }



    /**
     * Update Achievement entry
     */
    public function updateAchievement(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            // Get the authenticated user (via the token)
            $user = $request->user();  // This will return the authenticated user based on the token

            // Validation
            $validator = Validator::make($request->all(), [
                'title' => 'required|string|max:255',
                'issued_by' => 'nullable|string|max:255',
                'issue_month' => 'nullable|string|max:255',
                'issue_year' => 'nullable|string|max:255',
                'description' => 'nullable|string|max:255',
                'image' => 'nullable|image',  // Image should be optional (nullable)
                'endorsers' => 'nullable|array', // Array of endorser emails
                'endorsers.*' => 'email', // Validate each email in the array
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 400);
            }

            // Check if the achievement exists
            $achievement = DB::table('achievements')->where('id', $id)->first();

            if (!$achievement) {
                return response()->json(['error' => 'Achievement not found'], 404);
            }

            // Ensure the authenticated user is the owner of the portfolio
            $portfolio = DB::table('portfolios')->where('id', $achievement->portfolio_id)->first();
            if (!$portfolio || $portfolio->user_id !== $user->google_id) {
                return response()->json(['error' => 'You are not authorized to update this achievement record.'], 403);
            }

            // Prepare the data for the achievement update
            $updateData = [
                'title' => $request->title,
                'issued_by' => $request->issued_by,
                'issue_month' => $request->issue_month,
                'issue_year' => $request->issue_year,
                'description' => $request->description,
                'updated_at' => now(),
            ];

            // If a new image is uploaded, handle it and update the image URL
            if ($request->hasFile('image')) {
                // First, remove the old image if it exists
                if ($achievement->image) {
                    $oldImagePath = public_path('storage/achievements/' . basename($achievement->image));
                    if (file_exists($oldImagePath)) {
                        unlink($oldImagePath); // Delete the old image
                        Log::info('Deleted old image: ' . $oldImagePath);
                    }
                }

                // Handle the new image upload
                $image = $request->file('image');
                $imagePath = $image->store('achievements', 'public');
                $baseUrl = asset('storage/'); // Get base URL for accessing files
                $updateData['image'] = $baseUrl . '/' . $imagePath; // Set the new image URL in the update data
            }

            // Update the achievement record in the database
            DB::table('achievements')->where('id', $id)->update($updateData);

            // Handle endorsers if provided
            $endorsers = $request->input('endorsers', []);
            $endorserData = [];
            $endorsementStatusData = [];

            // Remove existing endorsers and endorsement statuses before adding new ones
            DB::table('achievement_endorsers')->where('achievement_id', $id)->delete();
            DB::table('achievement_endorsement_statuses')->where('achievement_id', $id)->delete();

            // Insert new endorsers and their endorsement statuses
            foreach ($endorsers as $email) {
                // Find the user by email
                $user = DB::table('users')->where('email', $email)->first();

                if ($user && $user->google_id) {
                    // Check if the user has role_id = 2
                    if ($user->role_id != 2) {
                        Log::warning("Skipped user: {$email} — they do not have role_id = 2.");
                        continue;
                    }

                    // Prepare data for achievement_endorsers table
                    $endorserData[] = [
                        'achievement_id' => $id,
                        'user_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];

                    // Prepare data for achievement_endorsement_statuses table (default to Pending)
                    $endorsementStatusData[] = [
                        'achievement_id' => $id,
                        'endorsement_status_id' => 1, // Pending
                        'endorser_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                } else {
                    Log::warning("Skipped endorser: {$email} — user not found or missing google_id.");
                }
            }

            // Insert endorsers into achievement_endorsers table
            if (!empty($endorserData)) {
                DB::table('achievement_endorsers')->insert($endorserData);
                Log::info('Updated achievement_endorsers:', $endorserData);
            }

            // Insert endorsement statuses into achievement_endorsement_statuses table
            if (!empty($endorsementStatusData)) {
                DB::table('achievement_endorsement_statuses')->insert($endorsementStatusData);
                Log::info('Updated achievement_endorsement_statuses:', $endorsementStatusData);
            }

            // Commit the transaction
            DB::commit();

            return response()->json([
                'message' => 'Achievement updated successfully',
                'achievement_id' => $id,
                'title' => $request->title,
                'issued_by' => $request->issued_by,
                'issue_month' => $request->issue_month,
                'issue_year' => $request->issue_year,
                'description' => $request->description,
                'photo' => $updateData['image'] ?? $achievement->image // Return the new image URL or the old one if not updated


            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error updating achievement: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong.'], 500);
        }
    }



    /**
     * Delete Achievement by ID
     */
    public function deleteAchievement(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            // Get the authenticated user (via the token)
            $user = $request->user();  // This will return the authenticated user based on the token

            // Check if the achievement exists
            $achievement = DB::table('achievements')->where('id', $id)->first();

            if (!$achievement) {
                return response()->json(['error' => 'Achievement not found'], 404);
            }

            // Ensure the authenticated user is the owner of the portfolio
            $portfolio = DB::table('portfolios')->where('id', $achievement->portfolio_id)->first();
            if (!$portfolio || $portfolio->user_id !== $user->google_id) {
                return response()->json(['error' => 'You are not authorized to delete this achievement record.'], 403);
            }

            // Delete endorsers and endorsement statuses related to the achievement
            DB::table('achievement_endorsers')->where('achievement_id', $id)->delete();
            DB::table('achievement_endorsement_statuses')->where('achievement_id', $id)->delete();

            // Delete the image from the file system if it exists
            if ($achievement->image) {
                // Assuming the image is stored under 'storage/app/public/achievements'
                $imagePath = str_replace(asset('storage/'), 'public/', $achievement->image);

                // Check if the file exists and unlink (delete) the file
                $fullPath = storage_path('app/' . $imagePath); // Get the full path to the file
                if (file_exists($fullPath)) {
                    unlink($fullPath); // Delete the image
                    Log::info('Deleted image from storage: ' . $fullPath);
                } else {
                    Log::warning('Image not found for deletion: ' . $fullPath);
                }
            }

            // Delete the achievement itself
            $deleted = DB::table('achievements')->where('id', $id)->delete();

            if ($deleted) {
                DB::commit();
                return response()->json(['message' => 'Achievement and its endorsers deleted successfully']);
            } else {
                DB::rollBack();
                return response()->json(['error' => 'Error deleting achievement'], 500);
            }
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error deleting achievement: ' . $e->getMessage());
            return response()->json(['message' => 'Something went wrong'], 500);
        }
    }
}
