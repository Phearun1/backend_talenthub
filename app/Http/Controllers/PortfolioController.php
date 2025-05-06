<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PortfolioController extends Controller
{

    public function viewAllPortfolio(Request $request)
    {
        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 1; // Items per page
        $offset = ($page - 1) * $perPage; // Calculate the offset

        $portfolios = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id',
                'portfolios.major_id as major', // ✅ rename column label
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'users.status as status', // Changed from status to user_status
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as name',
                'users.email',
                'users.photo',
                'users.role_id as role'
            )
            ->where('users.status', '=', 1) // Only show active users (status = 1)
            ->skip($offset)
            ->take($perPage)
            ->get();

        return response()->json($portfolios);
    }

    public function viewPortfolioDetails($userID)
    {
        $portfolio = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id as google_id',
                'portfolios.major_id as major',
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'users.status as status', // Changed from user_status to status
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as user_name',
                'users.email',
                'users.photo',
                'users.role_id'
            )
            ->where('portfolios.user_id', $userID)
            ->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Check if user has been banned (status = 0)
        if ($portfolio->status === 0) {
            return response()->json([
                'error' => 'The user portfolio has been banned.',
                'status' => 0
            ], 200);
        }

        $portfolioId = $portfolio->id;

        // Get only the specific fields from projects related to the portfolio
        $projects = DB::table('projects')
            ->select('id as project_id', 'portfolio_id', 'title', 'project_visibility_status')
            ->where('portfolio_id', $portfolioId)
            ->get();

        // Get other related data like education, achievements, skills, etc.
        $education = DB::table('education')->where('portfolio_id', $portfolioId)->get();
        $achievements = DB::table('achievements')->where('portfolio_id', $portfolioId)->get();
        $skills = DB::table('skills')->where('portfolio_id', $portfolioId)->get();
        $experiences = DB::table('experiences')->where('portfolio_id', $portfolioId)->get();

        // Modify experiences and achievements if needed, as done earlier
        foreach ($experiences as $experience) {
            $company = DB::table('companies')->where('id', $experience->company_id)->first();
            $experience->company_name = $company ? $company->company_name : 'Unknown';
            unset($experience->company_id);

            $rawEndorsers = DB::table('experience_endorsers')
                ->join('users', 'experience_endorsers.user_id', '=', 'users.google_id')
                ->join('experience_endorsement_statuses', function ($join) use ($experience) {
                    $join->on('experience_endorsement_statuses.endorser_id', '=', 'experience_endorsers.user_id')
                        ->where('experience_endorsement_statuses.experience_id', '=', $experience->id);
                })
                ->join('endorsement_statuses', 'experience_endorsement_statuses.experience_status_id', '=', 'endorsement_statuses.id')
                ->select(
                    'users.google_id as id',
                    'users.name',
                    'users.email',
                    'endorsement_statuses.status as status',
                    'endorsement_statuses.id as status_id'
                )
                ->where('experience_endorsers.experience_id', $experience->id)
                ->get();

            $experience->endorsers = collect($rawEndorsers)
                ->unique('id')
                ->values();
        }

        foreach ($achievements as $achievement) {
            $achievement->endorsers = DB::table('achievement_endorsers')
                ->join('users', 'achievement_endorsers.user_id', '=', 'users.google_id')
                ->join('achievement_endorsement_statuses', function ($join) use ($achievement) {
                    $join->on('achievement_endorsement_statuses.endorser_id', '=', 'achievement_endorsers.user_id')
                        ->where('achievement_endorsement_statuses.achievement_id', '=', $achievement->id);
                })
                ->join('endorsement_statuses', 'achievement_endorsement_statuses.endorsement_status_id', '=', 'endorsement_statuses.id')
                ->select('users.google_id as id', 'users.name', 'users.email', 'endorsement_statuses.status as status', 'endorsement_statuses.id as status_id')
                ->distinct()
                ->get();
        }

        // Add skill endorsers with endorsement statuses
        foreach ($skills as $skill) {
            $skill->endorsers = DB::table('skill_endorsement_statuses')
                ->join('users', 'skill_endorsement_statuses.endorser_id', '=', 'users.google_id')
                ->join('endorsement_statuses', 'skill_endorsement_statuses.endorsement_status_id', '=', 'endorsement_statuses.id')
                ->select(
                    'users.google_id as id',
                    'users.name as name',
                    'users.email as email',
                    'endorsement_statuses.id as status_id',
                    'endorsement_statuses.status as status'
                )
                ->where('skill_endorsement_statuses.skill_id', $skill->id)
                ->distinct()  // Ensure distinct records
                ->get();
        }

        // Return the response with all the data
        return response()->json([
            'portfolio' => $portfolio,
            'projects' => $projects,
            'education' => $education,
            'achievements' => $achievements,
            'skills' => $skills,
            'experiences' => $experiences,
        ]);
    }



    public function updatePortfolio(Request $request, $id)
    {
        // Log the raw input data for debugging
        // Log::info('Raw Request Data: ', $request->all());

        // Validate input fields
        $request->validate([
            'major_id' => 'nullable|integer',
            'phone_number' => 'nullable|string|max:255',
            'about' => 'nullable|string|max:255',
            'working_status' => 'nullable|integer',
            'photo' => 'nullable|image', // Validate photo as an image
        ]);

        // Get the authenticated user (via the token)
        $user = $request->user();  // This will return the authenticated user based on the token

        // Find the portfolio by ID
        $portfolio = DB::table('portfolios')->where('id', $id)->first();

        if (!$portfolio) {
            // Log::error('Portfolio not found for ID: ' . $id);
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Ensure the authenticated user is the owner of the portfolio
        if ($portfolio->user_id !== $user->google_id) {
            // Log::error('Unauthorized access attempt for portfolio ID: ' . $id);
            return response()->json(['error' => 'You are not authorized to update this portfolio.'], 403);
        }

        // Log the user_id for tracking
        // Log::info('User ID for the portfolio: ' . $user->google_id);

        // Prepare fields to update in the portfolios table
        $updateFields = [
            'major_id' => $request->input('major_id', $portfolio->major_id),
            'phone_number' => $request->input('phone_number', $portfolio->phone_number),
            'about' => $request->input('about', $portfolio->about),
            'working_status' => $request->input('working_status', $portfolio->working_status),
            'updated_at' => now(),
        ];

        // Log the fields being updated
        // Log::info('Updating portfolio with the following fields: ', $updateFields);

        // Update the portfolio details
        DB::table('portfolios')->where('id', $id)->update($updateFields);

        // Log after portfolio update
        // Log::info('Portfolio updated successfully for ID: ' . $id);

        // Handle photo update if provided
        $photoUrl = null;
        if ($request->hasFile('photo')) {
            $photo = $request->file('photo');

            // Check if the file is uploaded and valid
            if ($photo->isValid()) {
                // Log the photo upload process
                // Log::info('Photo uploaded: ' . $photo->getClientOriginalName());

                // Delete the old image if it exists
                if ($user->photo) {  // Check if the user already has a photo
                    $oldPhotoPath = str_replace(asset('storage/'), 'public/', $user->photo);  // Convert URL to file path
                    $oldFilePath = storage_path('app/' . $oldPhotoPath);

                    // Delete the old image if it exists
                    if (file_exists($oldFilePath)) {
                        unlink($oldFilePath); // Delete the old file
                        // Log::info('Deleted old photo from storage: ' . $oldFilePath);
                    } else {
                        Log::warning('Old photo not found for deletion: ' . $oldFilePath);
                    }
                }

                // Store the new photo in 'photos' folder under 'public' disk
                $photoPath = $photo->store('photos', 'public');

                // Base URL for accessing the photo
                $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';

                // Construct the photo URL
                $photoUrl = $baseUrl . 'photos/' . basename($photoPath);

                // Log the photo URL
                // Log::info('New Photo URL: ' . $photoUrl);

                // Update the user's photo in the users table
                DB::table('users')->where('google_id', $user->google_id)->update([
                    'photo' => $photoUrl,
                    'updated_at' => now(),
                ]);

                // Log user photo update
                // Log::info('User photo updated for user ID: ' . $user->google_id);
            } else {
                Log::error('Uploaded photo is not valid.');
            }
        }

        // Fetch the updated portfolio
        $updatedPortfolio = DB::table('portfolios')->where('id', $id)->first();

        // Fetch the updated user details
        $updatedUser = DB::table('users')->where('google_id', $user->google_id)->first();

        // Log the updated portfolio and user details
        // Log::info('Updated Portfolio: ', (array) $updatedPortfolio);
        // Log::info('Updated User: ', (array) $updatedUser);

        // Return only the desired fields (portfolio and user) without additional structure
        return response()->json([
            'id' => $updatedPortfolio->id,
            'google_id' => $updatedPortfolio->user_id,
            'name' => $updatedUser->name,
            'email' => $updatedUser->email,
            'major_id' => $updatedPortfolio->major_id,
            'phone_number' => $updatedPortfolio->phone_number,
            'about' => $updatedPortfolio->about,
            'working_status' => $updatedPortfolio->working_status,
            'status' => $updatedUser->status, // Changed from portfolio status to user status
            'photo' => $photoUrl ? $photoUrl : $updatedUser->photo // Return updated photo URL
        ], 200);
    }





    public function deletePortfolio($id)
    {
        $portfolio = DB::table('portfolios')->where('id', $id)->delete();
        return response()->json($portfolio);
    }


    public function searchPortfolio(Request $request)
    {
        $searchTerm = $request->input('name');

        $portfolios = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id',
                'portfolios.major_id as major',
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'users.status as status',
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as name',
                'users.email',
                'users.photo'
            )
            ->where('users.name', 'LIKE', '%' . $searchTerm . '%')
            ->where('users.status', '=', 1) // Only show active users
            ->get();

        return response()->json($portfolios);
    }



}
