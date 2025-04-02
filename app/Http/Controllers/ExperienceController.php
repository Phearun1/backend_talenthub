<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ExperienceController extends Controller
{
    public function createCompany(Request $request)
    {

        // Validate the incoming request data
        $request->validate([
            'company_name' => 'required|string|max:255',
        ]);

        if (!$request) {
            return response()->json(['error' => 'Invalid request data'], 400);
        }

        $company = DB::table('companies')->insert([
            'company_name' => $request->company_name,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json(['message' => 'Company created successfully'], 201);
    }

    public function viewAllCompanies()
    {
        // Fetch only the company_name from the companies table
        $companies = DB::table('companies')->pluck('company_name');

        // Return the list of company names as a JSON response
        return response()->json($companies, 200);
    }



    // public function createExperience(Request $request)
    // {
    //     // Validate the input data
    //     $request->validate([
    //         'portfolio_id' => 'required|integer',
    //         'company_id' => 'required|integer',
    //         'work_title' => 'required|string|max:255',
    //         'description' => 'required|string|max:255',
    //         'employment_type' => 'required|string|in:Internship,Part-time,Full-time,Freelance',
    //         'start_month' => 'required|string|max:255',
    //         'start_year' => 'required|string|max:255',
    //         'end_month' => 'nullable|string|max:255',
    //         'end_year' => 'nullable|string|max:255',
    //         'endorsers' => 'nullable|array', // Optional array of endorser emails
    //         'endorsers.*' => 'email', // Validate each endorser's email
    //     ]);

    //     // Insert new experience record
    //     $experienceId = DB::table('experiences')->insertGetId([
    //         'portfolio_id' => $request->portfolio_id,
    //         'company_id' => $request->company_id,
    //         'work_title' => $request->work_title,
    //         'description' => $request->description,
    //         'employment_type' => $request->employment_type,
    //         'start_month' => $request->start_month,
    //         'start_year' => $request->start_year,
    //         'end_month' => $request->end_month,
    //         'end_year' => $request->end_year,
    //         'created_at' => now(),
    //         'updated_at' => now(),
    //     ]);

    //     // Handle endorsers if provided
    //     $endorsers = $request->input('endorsers', []);
    //     $endorserData = [];
    //     $endorsementStatusData = [];
    //     $skippedEndorsers = [];

    //     // Loop through each endorser's email and get their user_id
    //     foreach ($endorsers as $email) {
    //         $user = DB::table('users')->where('email', $email)->first();

    //         // Check if the user exists and if they have role_id = 2 (endorser)
    //         if ($user && $user->role_id == 2) {
    //             // Insert into experience_endorsers table
    //             $endorserData[] = [
    //                 'experience_id' => $experienceId,
    //                 'user_id' => $user->id,
    //                 'created_at' => now(),
    //                 'updated_at' => now(),
    //             ];

    //             // Insert into experience_endorsement_statuses table (set status as 'Pending' by default)
    //             $endorsementStatusData[] = [
    //                 'experience_id' => $experienceId,
    //                 'experience_status_id' => 1, // Assuming 1 is 'Pending'
    //                 'endorser_id' => $user->id,
    //                 'created_at' => now(),
    //                 'updated_at' => now(),
    //             ];
    //         } else {
    //             $skippedEndorsers[] = $email;
    //             Log::warning("User with email {$email} is not an endorser (role_id != 2).");
    //         }
    //     }

    //     // Insert endorsers into experience_endorsers
    //     if (!empty($endorserData)) {
    //         DB::table('experience_endorsers')->insert($endorserData);
    //     }

    //     // Insert endorsement statuses into experience_endorsement_statuses
    //     if (!empty($endorsementStatusData)) {
    //         DB::table('experience_endorsement_statuses')->insert($endorsementStatusData);
    //     }

    //     // Fetch the experience details
    //     $experience = DB::table('experiences')->where('id', $experienceId)->first();

    //     // Fetch the endorsers and their details
    //     $endorsersDetails = [];
    //     foreach ($endorserData as $endorser) {
    //         $user = DB::table('users')->where('id', $endorser['user_id'])->first();
    //         $status = DB::table('experience_endorsement_statuses')
    //             ->where('experience_id', $experienceId)
    //             ->where('endorser_id', $endorser['user_id'])
    //             ->first();

    //         $statusName = DB::table('endorsement_statuses')
    //             ->where('id', $status->experience_status_id)
    //             ->value('status');

    //         $endorsersDetails[] = [
    //             'id' => $endorser['user_id'],
    //             'name' => $user->name ?? 'Unknown',
    //             'email' => $user->email ?? 'Unknown',
    //             'status' => $statusName ?? 'Pending', // Default to 'Pending' if status not found
    //             'status_id' => $status->experience_status_id ?? 1, // Default to 'Pending' status ID
    //         ];
    //     }

    //     // Return the full experience details along with endorsers
    //     return response()->json([
    //         'message' => 'Experience and endorsers added successfully!',
    //         'experience' => $experience, // Return full experience details
    //         'endorsers' => $endorsersDetails,  // Return detailed endorser data

    //     ], 200);
    // }

    public function createExperience(Request $request)
    {
        // Validate the input data
        $request->validate([
            'portfolio_id' => 'required|integer',
            'company_name' => 'required|string|max:255',
            'work_title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'employment_type' => 'required|string|in:Internship,Part-time,Full-time,Freelance',
            'start_month' => 'required|string|max:255',
            'start_year' => 'required|string|max:255',
            'end_month' => 'nullable|string|max:255',
            'end_year' => 'nullable|string|max:255',
            'endorsers' => 'nullable|array', // Optional array of endorser emails
            'endorsers.*' => 'email', // Validate each endorser's email
        ]);

        // Check if the company already exists, otherwise create it
        $company = DB::table('companies')->where('company_name', $request->company_name)->first();
        if (!$company) {
            $companyId = DB::table('companies')->insertGetId([
                'company_name' => $request->company_name,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        } else {
            $companyId = $company->id;
        }

        // Insert new experience record
        $experienceId = DB::table('experiences')->insertGetId([
            'portfolio_id' => $request->portfolio_id,
            'company_id' => $companyId,
            'work_title' => $request->work_title,
            'description' => $request->description,
            'employment_type' => $request->employment_type,
            'start_month' => $request->start_month,
            'start_year' => $request->start_year,
            'end_month' => $request->end_month,
            'end_year' => $request->end_year,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Handle endorsers if provided
        $endorsers = $request->input('endorsers', []);
        $endorserData = [];
        $endorsementStatusData = [];
        $skippedEndorsers = [];

        // Loop through each endorser's email and get their user_id
        foreach ($endorsers as $email) {
            $user = DB::table('users')->where('email', $email)->first();

            // Check if the user exists and if they have role_id = 2 (endorser)
            if ($user && $user->role_id == 2) {
                // Insert into experience_endorsers table
                $endorserData[] = [
                    'experience_id' => $experienceId,
                    'user_id' => $user->google_id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];

                // Insert into experience_endorsement_statuses table (set status as 'Pending' by default)
                $endorsementStatusData[] = [
                    'experience_id' => $experienceId,
                    'experience_status_id' => 1, // Assuming 1 is 'Pending'
                    'endorser_id' => $user->google_id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            } else {
                $skippedEndorsers[] = $email;
                Log::warning("User with email {$email} is not an endorser (role_id != 2).");
            }
        }

        // Insert endorsers into experience_endorsers
        if (!empty($endorserData)) {
            DB::table('experience_endorsers')->insert($endorserData);
        }

        // Insert endorsement statuses into experience_endorsement_statuses
        if (!empty($endorsementStatusData)) {
            DB::table('experience_endorsement_statuses')->insert($endorsementStatusData);
        }

        // Fetch the experience details
        $experience = DB::table('experiences')
            ->join('companies', 'experiences.company_id', '=', 'companies.id')
            ->where('experiences.id', $experienceId)
            ->select('experiences.*', 'companies.company_name')
            ->first();

        // Fetch the endorsers and their details
        $endorsersDetails = [];
        foreach ($endorserData as $endorser) {
            $user = DB::table('users')->where('id', $endorser['user_id'])->first();
            $status = DB::table('experience_endorsement_statuses')
                ->where('experience_id', $experienceId)
                ->where('endorser_id', $endorser['user_id'])
                ->first();

            $statusName = DB::table('endorsement_statuses')
                ->where('id', $status->experience_status_id)
                ->value('status');

            $endorsersDetails[] = [
                'id' => $endorser['user_id'],
                'name' => $user->name ?? 'Unknown',
                'email' => $user->email ?? 'Unknown',
                'status' => $statusName ?? 'Pending', // Default to 'Pending' if status not found
                'status_id' => $status->experience_status_id ?? 1, // Default to 'Pending' status ID
            ];
        }

        // Return the full experience details along with endorsers
        return response()->json([
            'message' => 'Experience and endorsers added successfully!',
            'experience' => [
                'id' => $experience->id,
                'portfolio_id' => $experience->portfolio_id,
                'company_name' => $experience->company_name,
                'work_title' => $experience->work_title,
                'description' => $experience->description,
                'employment_type' => $experience->employment_type,
                'start_month' => $experience->start_month,
                'start_year' => $experience->start_year,
                'end_month' => $experience->end_month,
                'end_year' => $experience->end_year,
            ],
            'endorsers' => $endorsersDetails,  // Return detailed endorser data
        ], 200);
    }


    public function updateExperience(Request $request, $id)
    {
        // Validate the input data
        $request->validate([
            'work_title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'employment_type' => 'required|string|in:Internship,Part-time,Full-time,Freelance',
            'start_month' => 'required|string|max:255',
            'start_year' => 'required|string|max:255',
            'end_month' => 'nullable|string|max:255',
            'end_year' => 'nullable|string|max:255',
            'endorsers' => 'nullable|array', // Optional array of endorser emails
            'endorsers.*' => 'email', // Validate each endorser's email
        ]);

        // Check if the experience exists
        $experience = DB::table('experiences')->where('id', $id)->first();

        if (!$experience) {
            return response()->json(['error' => 'Experience not found.'], 404);
        }

        // Check if the company exists, otherwise create it
        $company = DB::table('companies')->where('company_name', $request->company_name)->first();
        if (!$company) {
            $companyId = DB::table('companies')->insertGetId([
                'company_name' => $request->company_name,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        } else {
            $companyId = $company->id;
        }

        // Update the existing experience record
        $updated = DB::table('experiences')->where('id', $id)->update([
            'company_id' => $companyId,
            'work_title' => $request->work_title,
            'description' => $request->description,
            'employment_type' => $request->employment_type,
            'start_month' => $request->start_month,
            'start_year' => $request->start_year,
            'end_month' => $request->end_month,
            'end_year' => $request->end_year,
            'updated_at' => now(),
        ]);

        if (!$updated) {
            return response()->json(['error' => 'Failed to update experience.'], 400);
        }

        // Handle updating endorsers if provided
        $endorsers = $request->input('endorsers', []);
        $endorserData = [];
        $endorsementStatusData = [];
        $skippedEndorsers = [];

        // Loop through each endorser's email and update their user_id
        foreach ($endorsers as $email) {
            $user = DB::table('users')->where('email', $email)->first();

            if ($user) {
                // Check if the endorser has role_id = 2
                if ($user->role_id == 2) {
                    // Insert or update into experience_endorsers table
                    $endorserData[] = [
                        'experience_id' => $id,
                        'user_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];

                    // Insert or update into experience_endorsement_statuses table (set status as 'Pending' by default)
                    $endorsementStatusData[] = [
                        'experience_id' => $id,
                        'experience_status_id' => 1, // Assuming 1 is 'Pending'
                        'endorser_id' => $user->google_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                } else {
                    // Add the email to skipped endorsers if the user doesn't have role_id = 2
                    $skippedEndorsers[] = $email;
                }
            } else {
                $skippedEndorsers[] = $email;
            }
        }

        // Insert new endorsers into experience_endorsers
        if (!empty($endorserData)) {
            DB::table('experience_endorsers')->insert($endorserData);
        }

        // Insert new endorsement statuses into experience_endorsement_statuses
        if (!empty($endorsementStatusData)) {
            DB::table('experience_endorsement_statuses')->insert($endorsementStatusData);
        }

        // Fetch the updated experience details
        $experience = DB::table('experiences')
            ->join('companies', 'experiences.company_id', '=', 'companies.id')
            ->where('experiences.id', $id)
            ->select('experiences.*', 'companies.company_name')
            ->first();

        // Fetch the updated endorsers and their details
        $endorsersDetails = [];
        foreach ($endorserData as $endorser) {
            $user = DB::table('users')->where('id', $endorser['user_id'])->first();
            $status = DB::table('experience_endorsement_statuses')
                ->where('experience_id', $id)
                ->where('endorser_id', $endorser['user_id'])
                ->first();

            $statusName = DB::table('endorsement_statuses')
                ->where('id', $status->experience_status_id)
                ->value('status');

            $endorsersDetails[] = [
                'id' => $endorser['user_id'],
                'name' => $user->name ?? 'Unknown',
                'email' => $user->email ?? 'Unknown',
                'status' => $statusName ?? 'Pending', // Default to 'Pending' if status not found
                'status_id' => $status->experience_status_id ?? 1, // Default to 'Pending' status ID
            ];
        }

        // Return the updated experience details along with endorsers
        return response()->json([
            'message' => 'Experience updated successfully!',
            'experience' => [
                'id' => $experience->id,
                'portfolio_id' => $experience->portfolio_id,
                'company_name' => $experience->company_name,
                'work_title' => $experience->work_title,
                'description' => $experience->description,
                'employment_type' => $experience->employment_type,
                'start_month' => $experience->start_month,
                'start_year' => $experience->start_year,
                'end_month' => $experience->end_month,
                'end_year' => $experience->end_year,
            ],
            'endorsers' => $endorsersDetails, // Updated endorsers details
            'skipped_endorsers' => $skippedEndorsers // List of skipped endorsers
        ], 200);
    }


    public function deleteExperience($id)
    {
        // Check if the experience exists
        $experience = DB::table('experiences')->where('id', $id)->first();

        if (!$experience) {
            return response()->json(['error' => 'Experience not found.'], 404);
        }

        // Delete related endorsers from experience_endorsers table
        DB::table('experience_endorsers')->where('experience_id', $id)->delete();

        // Delete related endorsement statuses from experience_endorsement_statuses table
        DB::table('experience_endorsement_statuses')->where('experience_id', $id)->delete();

        // Delete the experience itself
        DB::table('experiences')->where('id', $id)->delete();

        return response()->json(['message' => 'Experience and related data deleted successfully.'], 200);
    }
}
