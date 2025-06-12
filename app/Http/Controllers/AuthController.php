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

        //endorser added by admin
        // If not found, try matching by email
        if (!$user) {
            $user = User::where('email', $profile['email'])->first();

            // If user exists but doesn't have google_id linked, update it
            if ($user && !$user->google_id) {
            $user->google_id = $profile['sub'];
            $user->name = $profile['name'];
            // Also update the user's photo if provided
            if (!empty($profile['photo'])) {
                $user->photo = $profile['photo'];
            }
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

        return response()->json(['error' => 'Unauthorized role'], 403);
    }


    public function loginWithGoogle2(Request $request)
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

        // First, check if the email exists in our database
        $emailExists = User::where('email', $profile['email'])->exists();

        // If email doesn't exist, check if it's a personal email
        if (!$emailExists) {
            if ($this->isPersonalEmail($profile['email'])) {
                // Don't allow registration with personal emails
                return response()->json([
                    'error' => 'Personal email addresses are not allowed. Please use your organizational email address.',
                ], 401);
            } else {
                // For non-personal emails, allow creating a new account
                $user = User::create([
                    'google_id' => $profile['sub'],
                    'email' => $profile['email'],
                    'name' => $profile['name'],
                    'photo' => $profile['photo'],
                    'role_id' => 1, // Default to student role
                    'status' => 1,  // Set default status to active
                ]);

                // Log the new user creation
                Log::info('New user created with non-personal email: ' . $profile['email']);
            }
        } else {
            // Email exists 
            // First check if there's a user with matching Google ID and email
            $user = User::where('google_id', $profile['sub'])
                ->where('email', $profile['email'])
                ->first();

            if ($user) {
                // User found by Google ID and email, but we should also verify the name
                if ($user->name !== $profile['name']) {
                    // The name doesn't match - this could be suspicious
                    Log::warning("Login attempt with correct Google ID and email but wrong name. Email: {$profile['email']}, Provided name: {$profile['name']}, Stored name: {$user->name}");

                    return response()->json([
                        'error' => 'Authentication failed. User credentials do not match our records.',
                    ], 401);

                    // Or just update the name if you want to be more flexible:
                    // $user->name = $profile['name'];
                    // $user->save();
                }
            } else {
                // No user found with this Google ID and email
                // Check if the email exists but with a different Google ID
                $emailUser = User::where('email', $profile['email'])->first();

                if ($emailUser) {
                    // Email exists but either with wrong Google ID or no Google ID

                    // Only allow linking if there is no Google ID yet
                    if (!$emailUser->google_id) {
                        // Email exists but no Google ID linked yet, so link it
                        $emailUser->google_id = $profile['sub'];
                        $emailUser->name = $profile['name'];
                        if (!empty($profile['photo'])) {
                            $emailUser->photo = $profile['photo'];
                        }
                        $emailUser->save();

                        $user = $emailUser;
                    } else {
                        // Email exists with a DIFFERENT Google ID - this is suspicious!
                        // Someone might be trying to take over an account
                        Log::warning("Login attempt with wrong Google ID. Email: {$profile['email']}, Provided sub: {$profile['sub']}, Stored sub: {$emailUser->google_id}");

                        return response()->json([
                            'error' => 'Authentication failed. User credentials do not match our records.',
                        ], 401);
                    }
                } else {
                    // This shouldn't happen as we already checked if email exists
                    return response()->json([
                        'error' => 'Authentication error. Please try again.',
                    ], 500);
                }
            }
        }

        // Check if user is banned
        if ($user->status === 0) {
            return response()->json([
                'error' => 'Your account has been suspended. Please contact an administrator.',
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

        return response()->json(['error' => 'Unauthorized role'], 403);
    }
    private function isPersonalEmail($email)
    {
        $domain = strtolower(substr(strrchr($email, "@"), 1));

        $blockedDomains = [
            // Personal email domains
            'gmail.com',
            'yahoo.com',
            'yahoo.co.id',
            'yahoo.co.uk',
            'hotmail.com',
            'outlook.com',
            'aol.com',
            'icloud.com',
            'mail.com',
            'zoho.com',
            'protonmail.com',
            'pm.me',
            'gmx.com',
            'gmx.net',
            'yandex.com',
            'ymail.com',
            'rocketmail.com',
            'live.com',
            'msn.com',
            'hotmail.co.uk',
            'comcast.net',
            'verizon.net',
            'att.net',
            'sbcglobal.net',
            'cox.net',
            'earthlink.net',
            'me.com',
            'mac.com',
            'mail.ru',
            'inbox.com',
            'fastmail.com',
            'fastmail.fm',

            // Cambodian university domains
            'rupp.edu.kh',              // Royal University of Phnom Penh
            'itc.edu.kh',               // Institute of Technology of Cambodia
            'uc.edu.kh',                // The University of Cambodia
            'puc.edu.kh',               // Paññāsāstra University of Cambodia
            'aupp.edu.kh',             // American University of Phnom Penh
            'norton-u.com',            // Norton University
            'num.edu.kh',              // National University of Management
            'rule.edu.kh',             // Royal University of Law and Economics
            'ume.edu.kh',              // University of Management and Economics
            'mekong.edu.kh',           // Cambodian Mekong University
            'beltei.edu.kh',           // BELTEI International University
            'uofnphnompenh.com',       // University of the Nations Cambodia
            'seatech.edu.kh',          // Southeast Asia University of Technology
            'csu.edu.kh',              // Cambodian University for Specialties
            'svu.edu.kh',              // Svay Rieng University
            'tnu.edu.kh',              // The University of Takeo
            'bbu.edu.kh',              // Build Bright University
            'umi.edu.kh',              // University of Management and Innovation
            'cku.edu.kh',              // Chea Sim University of Kamchay Mear
            'kbk.edu.kh',              // Kampong Cham National Institute of Agriculture
            'cpu.edu.kh',              // Cambodian Pacific University
            'nida.edu.kh',             // National Institute of Development Administration
            'hne.edu.kh',              // Human Resource University
            'knu.edu.kh',              // Khemarak University
            'ttc.edu.kh',              // Teacher Training College
            'pa.edu.kh',               // Police Academy of Cambodia
        ];

        return in_array($domain, $blockedDomains);
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
            'id' => $admin->id,
            'email' => $admin->email,
            'name' => $admin->name,
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


    public function checkToken(Request $request)
    {
        // Get the token from the request
        $token = $request->bearerToken();

        if (!$token) {
            return response()->json([
                'success' => false,
                'message' => 'No token provided'
            ], 401);
        }

        // Verify the token (you can implement your own logic here)
        $isValid = $this->verifyToken($token);

        if (!$isValid) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid token'
            ], 401);
        }

        return response()->json([
            'success' => true,
            'message' => 'Token is valid'
        ], 200);
    }
}
