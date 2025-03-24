<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function loginWithGoogle(Request $request)
    {
        // Validate the profile data sent by frontend
        $validator = Validator::make($request->all(), [
            'profile' => 'required|array',
            'profile.sub' => 'required|string',
            'profile.email' => 'required|email',
            'profile.name' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid profile data'], 400);
        }

        // Extract the profile data from the request
        $profile = $request->input('profile');

        // Check if the user already exists or create a new one using DB query
        $user = DB::table('users')->where('google_id', $profile['sub'])->first();

        if (!$user) {
            // If user does not exist, create a new user in the database
            DB::table('users')->insert([
                'google_id' => $profile['sub'],
                'email' => $profile['email'],
                'name' => $profile['name'],
                'photo' => null, // Default photo is set to null
                'role_id' => 1,  // Default role_id is 1
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Fetch the newly created user
            $user = DB::table('users')->where('google_id', $profile['sub'])->first();
        }

        // Issue a Sanctum token for the user
        $token = $user ? $user->createToken('API Token')->plainTextToken : null;

        return response()->json([
            'token' => $token,
            'user' => $user
        ]);
    }

    public function logout(Request $request)
    {
        // Revoke the user's current token (this will log them out)
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Successfully logged out']);
    }
}
