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
                'portfolios.major_id as major', // alias
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'portfolios.status',
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as user_name',
                'users.email',
                'users.role_id'
            )
            ->where('portfolios.user_id', $userID)
            ->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Get the real portfolio ID to fetch related records
        $portfolioId = $portfolio->id;

        // Retrieve related data using portfolio_id
        $projects = DB::table('projects')->where('portfolio_id', $portfolioId)->get();
        $education = DB::table('education')->where('portfolio_id', $portfolioId)->get();
        $achievements = DB::table('achievements')->where('portfolio_id', $portfolioId)->get();
        $skills = DB::table('skills')->where('portfolio_id', $portfolioId)->get();
        $experiences = DB::table('experiences')->where('portfolio_id', $portfolioId)->get();

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
        // Validate input fields
        $request->validate([
            'user_id' => 'required|string',
            'major_id' => 'nullable|integer',
            'phone_number' => 'nullable|string|max:255',
            'about' => 'nullable|string|max:255',
            'working_status' => 'nullable|integer',
            'status' => 'required|integer',
            'photo' => 'nullable|string|max:255',
        ]);

        // Find the portfolio by ID
        $portfolio = DB::table('portfolios')->where('id', $id)->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Update the portfolio
        DB::table('portfolios')->where('id', $id)->update([
            'user_id' => $request->input('user_id'),
            'major_id' => $request->input('major_id'),
            'phone_number' => $request->input('phone_number'),
            'about' => $request->input('about'),
            'working_status' => $request->input('working_status'),
            'status' => $request->input('status'),
            'updated_at' => now(), 
        ]);

        // Update the user's photo if provided
        if ($request->has('photo')) {
            DB::table('users')->where('id', $request->input('user_id'))->update([
                'photo' => $request->input('photo'),
                'updated_at' => now(),
            ]);
        }

        // Fetch the updated portfolio
        $updatedPortfolio = DB::table('portfolios')->where('id', $id)->first();

        // Fetch the updated user
        $updatedUser = DB::table('users')->where('id', $request->input('user_id'))->first();

        // Return the updated portfolio and user
        return response()->json([
            'message' => 'Portfolio and user photo updated successfully.',
            'portfolio' => $updatedPortfolio,
            'user' => $updatedUser,
        ], 200);
    }


    public function deletePortfolio($id)
    {
        $portfolio = DB::table('portfolios')->where('id', $id)->delete();
        return response()->json($portfolio);
    }


}
