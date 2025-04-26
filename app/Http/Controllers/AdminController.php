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
    
    // Method to view all users with specific fields
    public function viewAllUser(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Fetch all users from the 'users' table with only specific fields
        $users = DB::table('users')
            ->select('id', 'email', 'name', 'photo', 'google_id', 'role_id')
            ->get();

        // Return the list of users as a JSON response
        return response()->json($users);
    }

    public function updateUserRole(Request $request, $id)
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

        // Get the user
        $user = User::find($id);

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
            'name' => $user->name,
            'email' => $user->email,
            'role_id' => $user->role_id,
        ]);
    }
}
