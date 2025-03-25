<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    /**
     * Login or Register using Google OAuth.
     */
    public function loginWithGoogle(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'profile' => 'required|array',
            'profile.sub' => 'required|string',
            'profile.email' => 'required|email',
            'profile.name' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid profile data'], 400);
        }

        $profile = $request->input('profile');

        // Check if the user already exists or create a new one using Eloquent
        $user = User::where('google_id', $profile['sub'])->first();

        if (!$user) {
            $user = User::create([
                'google_id' => $profile['sub'],
                'email' => $profile['email'],
                'name' => $profile['name'],
                'photo' => null,
                'role_id' => 1,  // Default role_id is 1 (student)
            ]);
        }

        $token = $user->createToken('API Token')->plainTextToken;

        return response()->json(['token' => $token]);
    }

    /**
     * Admin login
     */
    public function adminLogin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid email or password'], 400);
        }

        $admin = Admin::where('email', $request->email)->first();
        if (!$admin || !Hash::check($request->password, $admin->password)) {
            return response()->json(['error' => 'Admin not found or incorrect password'], 400);
        }

        $token = $admin->createToken('API Token')->plainTextToken;

        return response()->json(['token' => $token]);
    }

    /**
     * Logout the user.
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Successfully logged out']);
    }

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
            'role_id' => 2, // Endorser role
            'name' => null, // No name initially
            'photo' => null,
        ]);

        return response()->json(['message' => 'Success', 'user' => $user]);
    }

    /**
     * Admin creates a new admin account (with email and password)
     */
    public function addCreateAdminAccount(Request $request)
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
            'photo' => null, // Default photo is set to null
        ]);

        return response()->json(['message' => 'Success', 'admin' => $admin]);
    }

    /**
     * Admin Logout
     */
    public function adminLogout(Request $request)
    {
        // Revoke the admin's current token (this will log them out)
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Admin successfully logged out']);
    }
}
