<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\Portfolio;

class AuthController extends Controller
{

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

        // ✅ First, try finding user by Google ID
        $user = User::where('google_id', $profile['sub'])->first();

        // ✅ If not found, try matching by email
        if (!$user) {
            $user = User::where('email', $profile['email'])->first();

            // If user exists but doesn't have google_id linked, update it
            if ($user && !$user->google_id) {
                $user->google_id = $profile['sub'];
                $user->save();
            }
        }

        // ✅ If user doesn't exist at all, create new
        if (!$user) {
            $roleId = $this->assignRoleBasedOnEmail($profile['email']);

            if ($roleId === null) {
                return response()->json(['error' => 'Invalid email domain (Gmail accounts are not allowed).'], 400);
            }

            $user = User::create([
                'google_id' => $profile['sub'],
                'email' => $profile['email'],
                'name' => $profile['name'],
                'photo' => null,
                'role_id' => $roleId,
            ]);
        }

        // 🔥 Auto-create portfolio only if not already created
        $existingPortfolio = Portfolio::where('user_id', $user->google_id)->first();
        if (!$existingPortfolio) {
            Portfolio::create([
                'user_id' => $user->google_id, // ✅ Use the correct user ID
                'major_id' => null,
                'phone_number' => '',
                'about' => '',
                'working_status' => 2,
                'status' => 1,
            ]);
        }

        // ✅ Token & role check
        $roleId = $user->role_id;
        if ($roleId === 1 || $roleId === 2) {
            $expiresAt = Carbon::now()->addWeeks(2);
            $token = $user->createToken('API Token')->plainTextToken;

            $user->tokens->last()->update([
                'expires_at' => $expiresAt,
            ]);

            return response()->json([
                'token' => $token,
                'role_id' => $roleId,
            ]);
        }

        return response()->json(['error' => 'Unauthorized role'], 403);
    }


    public function loginWithGoogleTest(Request $request)
{
    // Validate query parameters
    $validator = Validator::make($request->all(), [
        'sub' => 'required|string',
        'email' => 'required|email',
        'name' => 'required|string',
    ]);

    if ($validator->fails()) {
        return response()->json(['error' => 'Invalid profile data'], 400);
    }

    // Retrieve parameters directly from query string
    $profile = [
        'sub' => $request->query('sub'),
        'email' => $request->query('email'),
        'name' => $request->query('name'),
    ];

    // ✅ First, try finding user by Google ID
    $user = User::where('google_id', $profile['sub'])->first();

    // ✅ If not found, try matching by email
    if (!$user) {
        $user = User::where('email', $profile['email'])->first();

        // If user exists but doesn't have google_id linked, update it
        if ($user && !$user->google_id) {
            $user->google_id = $profile['sub'];
            $user->save();
        }
    }

    // ✅ If user doesn't exist at all, create new
    if (!$user) {
        $roleId = $this->assignRoleBasedOnEmail($profile['email']);

        if ($roleId === null) {
            return response()->json(['error' => 'Invalid email domain (Gmail accounts are not allowed).'], 400);
        }

        $user = User::create([
            'google_id' => $profile['sub'],
            'email' => $profile['email'],
            'name' => $profile['name'],
            'photo' => null,
            'role_id' => $roleId,
        ]);
    }

    // 🔥 Auto-create portfolio only if not already created
    $existingPortfolio = Portfolio::where('user_id', $user->google_id)->first();
    if (!$existingPortfolio) {
        Portfolio::create([
            'user_id' => $user->google_id, // ✅ Use the correct user ID
            'major_id' => null,
            'phone_number' => '',
            'about' => '',
            'working_status' => 2,
            'status' => 1,
        ]);
    }

    // ✅ Token & role check
    $roleId = $user->role_id;
    if ($roleId === 1 || $roleId === 2) {
        $expiresAt = Carbon::now()->addWeeks(2);
        $token = $user->createToken('API Token')->plainTextToken;

        $user->tokens->last()->update([
            'expires_at' => $expiresAt,
        ]);

        return response()->json([
            'token' => $token,
            'role_id' => $roleId,
        ]);
    }

    return response()->json(['error' => 'Unauthorized role'], 403);
}


    /**
     * Dynamically assign a role based on email or other business logic
     */
    private function assignRoleBasedOnEmail($email)
    {
        // Check if the email is from Gmail
        if (strpos($email, '@gmail.com') !== false) {
            return null; // Reject Gmail emails by returning null
        }
        // If it's not a Gmail email, assign role_id = 1 (student)
        return 1; // Default to student if no other condition matches
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
            'role_id' => 3, // Admin role
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
