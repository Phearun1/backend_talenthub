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

    public function createExperience(Request $request)
    {
        // Get the authenticated user (via the token)
        $user = $request->user();

        // Validate the input data
        $request->validate([
            'portfolio_id' => 'required|integer',
            'company_name' => 'required|string|max:255',
            'work_title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'employment_type' => 'required|string|in:Internship,Part-time,Full-time,Freelance',
            'start_month' => 'required|string|max:255',
            'start_year' => 'required|string|max:255',
            'endorsers' => 'nullable|array', // Optional array of endorser emails
            'endorsers.*' => 'email', // Validate each endorser's email
        ]);

        // Check if the portfolio belongs to the authenticated user
        $portfolio = DB::table('portfolios')->where('id', $request->portfolio_id)->first();

        if (!$portfolio || $portfolio->user_id !== $user->google_id) {
            return response()->json(['error' => 'You are not authorized to create experience for this portfolio.'], 403);
        }

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

        foreach ($endorsers as $email) {
            $user = DB::table('users')->where('email', $email)->first();
            if ($user && $user->role_id == 2) {
                // Insert into experience_endorsers table
                $endorserData[] = [
                    'experience_id' => $experienceId,
                    'user_id' => $user->google_id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];

                // Insert into experience_endorsement_statuses table (set status as 'Pending')
                $endorsementStatusData[] = [
                    'experience_id' => $experienceId,
                    'experience_status_id' => 1, // Pending status
                    'endorser_id' => $user->google_id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            } else {
                $skippedEndorsers[] = $email;
            }
        }

        // Insert endorsers and their endorsement statuses
        if (!empty($endorserData)) {
            DB::table('experience_endorsers')->insert($endorserData);
        }
        if (!empty($endorsementStatusData)) {
            DB::table('experience_endorsement_statuses')->insert($endorsementStatusData);
        }

        // Fetch experience and endorsers
        $experience = DB::table('experiences')
            ->join('companies', 'experiences.company_id', '=', 'companies.id')
            ->where('experiences.id', $experienceId)
            ->select('experiences.*', 'companies.company_name')
            ->first();

        // Fetch endorsers' details
        $endorsersDetails = [];
        foreach ($endorserData as $endorser) {
            $user = DB::table('users')->where('google_id', $endorser['user_id'])->first();
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
                'photo' => $user->photo ?? null,
                'status' => $statusName ?? 'Pending',
                'status_id' => $status->experience_status_id ?? 1,
            ];
        }

        return response()->json([
            'message' => 'Experience and endorsers added successfully!',
            'experience' => $experience,
            'endorsers' => $endorsersDetails,
        ], 200);
    }



    public function updateExperience(Request $request, $id)
    {
        // Get the authenticated user (via the token)
        $user = $request->user();

        // Validate the input data
        $request->validate([
            'work_title' => 'required|string|max:255',
            'description' => 'required|string|max:255',
            'employment_type' => 'required|string|in:Internship,Part-time,Full-time,Freelance',
            'start_month' => 'required|string|max:255',
            'start_year' => 'required|string|max:255',
            'end_month' => 'nullable|string|max:255',
            'end_year' => 'nullable|string|max:255',
            'endorsers' => 'nullable|array',
            'endorsers.*' => 'email',
        ]);

        // Get the existing experience
        $experience = DB::table('experiences')->where('id', $id)->first();

        if (!$experience) {
            return response()->json(['error' => 'Experience not found.'], 404);
        }

        // Ensure the authenticated user is the owner of the portfolio
        $portfolio = DB::table('portfolios')->where('id', $experience->portfolio_id)->first();

        if (!$portfolio || $portfolio->user_id !== $user->google_id) {
            return response()->json(['error' => 'You are not authorized to update this experience.'], 403);
        }

        // Check if the company exists, or create it if not
        $company = DB::table('companies')->where('company_name', $request->company_name)->first();
        $companyId = $company ? $company->id : DB::table('companies')->insertGetId([
            'company_name' => $request->company_name,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Update the experience record
        DB::table('experiences')->where('id', $id)->update([
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

        // Handle endorsers if provided
        $endorsers = $request->input('endorsers', []);
        $endorserGoogleIDs = DB::table('users')->whereIn('email', $endorsers)->pluck('google_id', 'email');
        $validEndorsers = DB::table('users')->whereIn('email', $endorsers)->where('role_id', 2)->pluck('google_id')->toArray();
        $existingEndorsers = DB::table('experience_endorsement_statuses')->where('experience_id', $id)->pluck('experience_status_id', 'endorser_id')->toArray();

        $newEndorsers = [];
        $newStatuses = [];
        $skippedEndorsers = [];

        foreach ($endorsers as $email) {
            $googleId = $endorserGoogleIDs[$email] ?? null;
            if (!$googleId || !in_array($googleId, $validEndorsers)) {
                $skippedEndorsers[] = $email;
                continue;
            }

            if (!array_key_exists($googleId, $existingEndorsers)) {
                $newEndorsers[] = [
                    'experience_id' => $id,
                    'user_id' => $googleId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
                $newStatuses[] = [
                    'experience_id' => $id,
                    'endorser_id' => $googleId,
                    'experience_status_id' => 1, // Pending status
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            } elseif ($existingEndorsers[$googleId] !== 2) {
                DB::table('experience_endorsement_statuses')
                    ->where('experience_id', $id)
                    ->where('endorser_id', $googleId)
                    ->update([
                        'experience_status_id' => 1,
                        'updated_at' => now(),
                    ]);
            }
        }

        // Remove endorsers not included in the current request
        $emailsGoogleIds = array_values($endorserGoogleIDs->toArray());
        $toRemove = array_diff(array_keys($existingEndorsers), $emailsGoogleIds);
        if (!empty($toRemove)) {
            DB::table('experience_endorsers')->where('experience_id', $id)->whereIn('user_id', $toRemove)->delete();
            DB::table('experience_endorsement_statuses')->where('experience_id', $id)->whereIn('endorser_id', $toRemove)->delete();
        }

        if (!empty($newEndorsers)) {
            DB::table('experience_endorsers')->insert($newEndorsers);
        }

        if (!empty($newStatuses)) {
            DB::table('experience_endorsement_statuses')->insert($newStatuses);
        }

        // Fetch the updated experience and endorsers' details
        $experience = DB::table('experiences')
            ->join('companies', 'experiences.company_id', '=', 'companies.id')
            ->where('experiences.id', $id)
            ->select('experiences.*', 'companies.company_name')
            ->first();

        $endorsersDetails = [];
        foreach ($endorserGoogleIDs as $email => $googleId) {
            if (!in_array($googleId, $validEndorsers)) continue;
            $user = DB::table('users')->where('google_id', $googleId)->first();
            $status = DB::table('experience_endorsement_statuses')
                ->where('experience_id', $id)
                ->where('endorser_id', $googleId)
                ->first();

            $statusName = DB::table('endorsement_statuses')
                ->where('id', $status->experience_status_id)
                ->value('status');

            $endorsersDetails[] = [
                'id' => $googleId,
                'name' => $user->name ?? 'Unknown',
                'email' => $user->email ?? 'Unknown',
                'photo' => $user->photo ?? null,
                'status' => $statusName ?? 'Pending',
                'status_id' => $status->experience_status_id ?? 1,
            ];
        }

        return response()->json([
            'message' => 'Experience updated successfully!',
            'experience' => $experience,
            'endorsers' => $endorsersDetails,
            'skipped_endorsers' => $skippedEndorsers
        ], 200);
    }


    public function deleteExperience(Request $request, $id)
    {
        // Get the authenticated user
        $user = $request->user();

        // Check if the experience exists
        $experience = DB::table('experiences')->where('id', $id)->first();

        if (!$experience) {
            return response()->json(['error' => 'Experience not found.'], 404);
        }

        // Get the portfolio to check ownership
        $portfolio = DB::table('portfolios')->where('id', $experience->portfolio_id)->first();

        if (!$portfolio || $portfolio->user_id !== $user->google_id) {
            return response()->json(['error' => 'You are not authorized to delete this experience.'], 403);
        }

        // Delete related endorsers
        DB::table('experience_endorsers')->where('experience_id', $id)->delete();

        // Delete related endorsement statuses
        DB::table('experience_endorsement_statuses')->where('experience_id', $id)->delete();

        // Delete the experience itself
        DB::table('experiences')->where('id', $id)->delete();

        return response()->json(['message' => 'Experience and related data deleted successfully.'], 200);
    }
}
