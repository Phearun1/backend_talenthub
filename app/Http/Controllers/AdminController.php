<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
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


}
