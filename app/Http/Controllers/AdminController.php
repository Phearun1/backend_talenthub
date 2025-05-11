<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Models\Admin;
use App\Models\User;

class AdminController extends Controller
{
    /**
     * Admin creates a new endorser account (with email only)
     */
    public function adminCreateEndorserAccount(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid or existing email'], 400);
        }

        $user = User::create([
            'email' => $request->email,
            'name' => null, // No name initially
            'photo' => null,
            'google_id' => null,
            'role_id' => 2, // Endorser role
        ]);

        return response()->json(['message' => 'Success', 'user' => $user]);
    }

    /**
     * Admin creates a new admin account (with email and password)
     */
    public function adminCreateAdminAccount(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Validate the admin input for the admin email
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:admins,email',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid or existing email'], 400);
        }

        // Set a default password
        $defaultPassword = '12345678';

        // Create the admin with email and default password
        $admin = Admin::create([
            'email' => $request->email,
            'password' => Hash::make($defaultPassword), // Hash the default password
            'role_id' => 3, // Admin role
            'photo' => null, // Default photo is set to null
        ]);

        return response()->json(['message' => 'Success', 'admin' => $admin]);
    }


    public function adminChangePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'old_password' => 'required|string',
            'new_password' => 'required|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid password'], 400);
        }

        $admin = $request->user();
        if (!Hash::check($request->old_password, $admin->password)) {
            return response()->json(['error' => 'Old password is incorrect'], 400);
        }

        $admin->password = Hash::make($request->new_password);
        $admin->save();

        return response()->json(['message' => 'Password changed successfully']);
    }

    public function viewAllUser(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 10; // Fixed number of users per page

        // Fetch users with pagination
        $users = DB::table('users')
            ->leftJoin('portfolios', 'users.google_id', '=', 'portfolios.user_id')
            ->select(
                'users.id',
                'users.email',
                'users.name',
                'users.photo',
                'users.google_id',
                'users.role_id',
                'users.status',
                'portfolios.phone_number',
                'portfolios.about',
                'users.created_at',
                'users.updated_at'
            )
            ->orderBy('users.created_at', 'desc') // Order by most recently created
            ->skip(($page - 1) * $perPage) // Skip previous pages
            ->take($perPage) // Take only perPage number of records
            ->get();

        return response()->json($users);
    }

    public function updateUserRole(Request $request, $google_id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Validate request
        $validator = Validator::make($request->all(), [
            'role_id' => 'required|integer|in:1,2,3', // Only allow valid role IDs (1=Student, 2=Endorser, 3=Admin)
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Get the user by Google ID instead of internal ID
        $user = User::where('google_id', $google_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Get the original role for the response
        $originalRole = $user->role_id;

        // Map role IDs to role names for the response
        $roleNames = [
            1 => 'Student',
            2 => 'Endorser',
            3 => 'Admin'
        ];

        // Update the role
        $user->role_id = $request->role_id;
        $user->save();

        // Return success response with before/after details
        return response()->json([
            'message' => 'User role updated successfully',
            'id' => $user->id,
            'google_id' => $user->google_id,
            'name' => $user->name,
            'email' => $user->email,
            'role_id' => $user->role_id,
        ]);
    }


    public function banUser(Request $request, $google_id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Find the user by Google ID instead of internal ID
        $user = User::where('google_id', $google_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Ban the user by setting their status to 0 (banned)
        $user->status = 0;
        $user->save();

        return response()->json([
            'message' => 'User banned successfully',
            'id' => $user->id,
            'google_id' => $user->google_id,
            'email' => $user->email,
            'name' => $user->name,
            'status' => $user->status
        ]);
    }

    public function adminSearchPortfolio(Request $request)
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
                'users.role_id as role',
                'users.photo'
            )
            ->where('users.name', 'LIKE', '%' . $searchTerm . '%')
            ->get();

        return response()->json($portfolios);
    }


    public function adminViewAllPortfolio(Request $request)
    {
        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 2; // Fixed number of portfolios per page

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
                'users.photo',
                'users.role_id as role'
            )
            // ->where('users.status', '=', 1) // Only show active users (status = 1)
            ->orderBy('portfolios.updated_at', 'desc') // Order by most recently updated
            ->skip(($page - 1) * $perPage) // Skip previous pages
            ->take($perPage) // Take only perPage number of records
            ->get();

        return response()->json($portfolios);
    }


    public function viewEmploymentRate()
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if (auth()->user() && auth()->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
    
        // Get number of employed students (working_status = 1) who are not banned (status = 1)
        $employedUsers = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->where('portfolios.working_status', 1)
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->count();
    
        // Get number of unemployed students (working_status = 2) who are not banned (status = 1)
        $unemployedUsers = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->where('portfolios.working_status', 2)
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->count();
    
        // Return data in exactly the requested format
        return response()->json([
            ['name' => 'Employed', 'value' => $employedUsers],
            ['name' => 'Unemployed', 'value' => $unemployedUsers]
        ]);
    }


    public function viewTop10JobTitle()
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if (auth()->user() && auth()->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
        
        // Query to get top 10 job titles and count of students 
        $topJobTitles = DB::table('experiences')
            ->join('portfolios', 'experiences.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'experiences.work_title as title',  // Changed from 'experiences.title' to 'experiences.work_title'
                DB::raw('COUNT(DISTINCT portfolios.user_id) as students')
            )
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->whereNotNull('experiences.work_title')  // Changed from 'experiences.title' to 'experiences.work_title'
            ->groupBy('experiences.work_title')  // Changed from 'experiences.title' to 'experiences.work_title'
            ->orderBy('students', 'desc')
            ->take(10)
            ->get()
            ->map(function($item) {
                return [
                    'title' => $item->title,
                    'students' => (int)$item->students  // Ensure students is returned as an integer
                ];
            });
                
        return response()->json($topJobTitles);
    }

    public function viewTop10Companies()
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if (auth()->user() && auth()->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
        
        // Query to get top 10 companies and count of students
        $topCompanies = DB::table('experiences')
            ->join('companies', 'experiences.company_id', '=', 'companies.id')
            ->join('portfolios', 'experiences.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'companies.company_name as title',
                DB::raw('COUNT(DISTINCT portfolios.user_id) as students')
            )
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->groupBy('companies.company_name')
            ->orderBy('students', 'desc')
            ->take(10)
            ->get()
            ->map(function($item) {
                return [
                    'title' => $item->title,
                    'students' => (int)$item->students  // Ensure students is returned as an integer
                ];
            });
        
        return response()->json($topCompanies);
    }
}
