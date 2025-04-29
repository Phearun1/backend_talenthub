<?php

namespace App\Http\Controllers;

use Google_Client;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\Portfolio;
use Illuminate\Support\Facades\Log;



class AuthController extends Controller
{

    public function loginWithGoogle(Request $request)
    {
        // Validate query parameters
        $validator = Validator::make($request->all(), [
            'sub' => 'required|string',
            'email' => 'required|email',
            'name' => 'required|string',
            'photo' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid profile data'], 400);
        }

        // Retrieve parameters directly from query string
        $profile = [
            'sub' => $request->query('sub'),
            'email' => $request->query('email'),
            'name' => $request->query('name'),
            'photo' => $request->query('photo'),
        ];

        // First, try finding user by Google ID
        $user = User::where('google_id', $profile['sub'])->first();

        // If not found, try matching by email
        if (!$user) {
            $user = User::where('email', $profile['email'])->first();

            // If user exists but doesn't have google_id linked, update it
            if ($user && !$user->google_id) {
                $user->google_id = $profile['sub'];
                $user->save();
            }
        }

        // If user doesn't exist at all, create new
        if (!$user) {
            // Assign role_id = 1 (student) for all users
            $roleId = 1;

            $user = User::create([
                'google_id' => $profile['sub'],
                'email' => $profile['email'],
                'name' => $profile['name'],
                'photo' => $profile['photo'],
                'role_id' => $roleId,
                'status' => 1, // Set default status to active (1)
            ]);
        }

        // Check if user is banned
        if ($user->status === 0) {
            return response()->json([
            'error' => 'Your account has been suspended. Please contact an administrator.',
            'user_status' => 0
            ], 200);
        }

        // Auto-create portfolio only if not already created
        $existingPortfolio = Portfolio::where('user_id', $user->google_id)->first();
        if (!$existingPortfolio) {
            Portfolio::create([
                'user_id' => $user->google_id,
                'major_id' => null,
                'phone_number' => '',
                'about' => '',
                'working_status' => 2,
            ]);
        }

        // Token & role check
        $roleId = $user->role_id;
        if ($roleId === 1 || $roleId === 2) {
            $expiresAt = Carbon::now()->addMonth();
            $token = $user->createToken('API Token')->plainTextToken;

            $user->tokens->last()->update([
                'expires_at' => $expiresAt,
            ]);

            return response()->json([
                'token' => $token,
                'role_id' => $roleId,
                'photo' => $user->photo,
                'google_id' => $user->google_id,
            ]);
        }

        return response()->json(['error' => 'Unauthorized role'], 200);
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

        // Set expiration date to 2 weeks from now
        $expiresAt = Carbon::now()->addWeeks(2);

        // Create the token
        $token = $admin->createToken('API Token')->plainTextToken;

        // Store the expiration date in the personal_access_tokens table
        $admin->tokens->last()->update([
            'expires_at' => $expiresAt,
        ]);

        return response()->json([
            'token' => $token,
            'role_id' => $admin->role_id,
        ]);
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
     * Admin Logout
     */
    public function adminLogout(Request $request)
    {
        // Revoke the admin's current token (this will log them out)
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Admin successfully logged out']);
    }
}
