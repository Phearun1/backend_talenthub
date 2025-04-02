<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PortfolioController extends Controller
{



    public function viewAllPortfolio()
    {
        $portfolios = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id',
                'portfolios.major_id as major', // ✅ rename column label
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'portfolios.status',
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as name',
                'users.email',
                'users.photo',
                'users.role_id as role'
            )
            ->get();

        return response()->json($portfolios);
    }


    public function viewPortfolioDetails($userID)
    {
        // Retrieve the specific portfolio with user info
        $portfolio = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id',
                'portfolios.major_id as major',
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'portfolios.status',
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

        // Get the real portfolio ID
        $portfolioId = $portfolio->id;

        // Get related data
        $projects = DB::table('projects')->where('portfolio_id', $portfolioId)->get();
        $education = DB::table('education')->where('portfolio_id', $portfolioId)->get();
        $achievements = DB::table('achievements')->where('portfolio_id', $portfolioId)->get();
        $skills = DB::table('skills')->where('portfolio_id', $portfolioId)->get();
        $experiences = DB::table('experiences')->where('portfolio_id', $portfolioId)->get();

        // Add experience data and endorsers
        foreach ($experiences as $experience) {
            // Get company name (if exists)
            $company = DB::table('companies')->where('id', $experience->company_id)->first();
            $experience->company_name = $company ? $company->company_name : 'Unknown';
            unset($experience->company_id); // Remove company_id from the response

            // Add endorsers for each experience
            $experience->endorsers = DB::table('experience_endorsers')
                ->join('users', 'experience_endorsers.user_id', '=', 'users.google_id')
                ->join('experience_endorsement_statuses', 'experience_endorsers.experience_id', '=', 'experience_endorsement_statuses.experience_id')
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
        }

        // Add achievement endorsers
        foreach ($achievements as $achievement) {
            // Retrieve endorsers for the achievement
            $achievement->endorsers = DB::table('achievement_endorsers')
                ->join('users', 'achievement_endorsers.user_id', '=', 'users.google_id')
                ->join('achievement_endorsement_statuses', 'achievement_endorsers.achievement_id', '=', 'achievement_endorsement_statuses.achievement_id')
                ->join('endorsement_statuses', 'achievement_endorsement_statuses.endorsement_status_id', '=', 'endorsement_statuses.id')
                ->select('users.google_id as id', 'users.name', 'users.email', 'endorsement_statuses.status as status', 'endorsement_statuses.id as status_id')
                ->where('achievement_endorsers.achievement_id', $achievement->id)
                ->get();
        }

        // Add skill endorsers with endorsement statuses
        foreach ($skills as $skill) {
            // From skill_endorsement_statuses
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
                ->get();
        }

        // Return the portfolio details, including experiences, skills, achievements, and education without endorsers for education
        return response()->json([
            'portfolio' => $portfolio,
            'projects' => $projects,
            'education' => $education, // Return education data without endorsers
            'achievements' => $achievements,
            'skills' => $skills,
            'experiences' => $experiences,
        ]);
    }



    public function updatePortfolio(Request $request, $id)
    {
        // Validate input fields
        $request->validate([
            'major_id' => 'nullable|integer',
            'phone_number' => 'nullable|string|max:255',
            'about' => 'nullable|string|max:255',
            'working_status' => 'nullable|integer',
            'photo' => 'nullable|string|max:255',
        ]);

        // Find the portfolio by ID
        $portfolio = DB::table('portfolios')->where('id', $id)->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Get the user_id from the portfolio
        $userId = $portfolio->user_id;

        // Update the portfolio details
        DB::table('portfolios')->where('id', $id)->update([
            'major_id' => $request->input('major_id'),
            'phone_number' => $request->input('phone_number'),
            'about' => $request->input('about'),
            'working_status' => $request->input('working_status'),
            'status' => 1, // Setting status to '1' (active) as per your schema
            'updated_at' => now(),
        ]);

        // Update the user's photo if provided
        if ($request->has('photo')) {
            DB::table('users')->where('google_id', $userId)->update([
                'photo' => $request->input('photo'),
                'updated_at' => now(),
            ]);
        }

        // Fetch the updated portfolio
        $updatedPortfolio = DB::table('portfolios')->where('id', $id)->first();

        // Fetch the updated user details
        $updatedUser = DB::table('users')->where('google_id', $userId)->first();

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
            'status' => $updatedPortfolio->status,
            'photo' => $updatedUser->photo
        ], 200);
    }

    public function deletePortfolio($id)
    {
        $portfolio = DB::table('portfolios')->where('id', $id)->delete();
        return response()->json($portfolio);
    }
}
