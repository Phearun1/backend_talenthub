<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\Portfolio;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;



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


        <?php
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
            // Check if it's a personal email for new user creation
            if ($this->isPersonalEmail($profile['email'])) {
                return response()->json([
                    'error' => 'Personal email addresses are not allowed for new registrations'
                ], 422);
            }
    
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
        try {
            // Debug: Log the incoming token
            $authHeader = $request->header('Authorization');
            // Log::info('Authorization header: ' . $authHeader);

            // Get the authenticated user from the token
            $user = $request->user();
            // Log::info('User from token: ' . ($user ? $user->id : 'null'));

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid or expired token'
                ], 401);
            }

            // Check if the token has expired (if you're using expires_at)
            $currentToken = $user->currentAccessToken();
            // Log::info('Current token: ' . ($currentToken ? $currentToken->id : 'null'));
            // Log::info('Token expires at: ' . ($currentToken && $currentToken->expires_at ? $currentToken->expires_at : 'null'));

            if ($currentToken && $currentToken->expires_at && $currentToken->expires_at->isPast()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Token has expired'
                ], 401);
            }

            // Check if user is banned
            if ($user->status === 0) {
                return response()->json([
                    'success' => false,
                    'message' => 'Account has been suspended'
                ], 401);
            }

            return response()->json([
                'success' => true,
                'message' => 'Token is valid',
            ], 200);
        } catch (\Exception $e) {
            // Log::error('Token check error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Invalid token',
                'error' => $e->getMessage()
            ], 401);
        }
    }

    public function becomeEndorser(Request $request)
    {
        try {
            // Validate the request
            $request->validate([
                'name' => 'required|string|max:255',
                'contact' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'company' => 'required|string|max:255',
                'working_position' => 'required|string|max:255',
                'student_name' => 'nullable|array', // Made nullable
                'student_name.*' => 'required|string|max:255', // Each element must be string if array exists
                'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:4096',
            ]);

            // Check if email already exists in endorser requests
            $existingRequest = DB::table('endorser_request')
                ->where('email', $request->input('email'))
                ->first();

            if ($existingRequest) {
                return response()->json([
                    'success' => false,
                    'message' => 'An endorser request with this email already exists'
                ], 409); // Conflict status code
            }

            // Handle image upload
            $imagePath = null;
            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $imagePath = $image->store('endorser_images', 'public');
            }

            // Handle student_name - can be null or array
            $studentNameJson = null;
            if ($request->has('student_name') && $request->input('student_name') !== null) {
                $studentNameJson = json_encode($request->input('student_name'));
            }

            // Create endorser request
            $endorserRequestId = DB::table('endorser_request')->insertGetId([
                'name' => $request->input('name'),
                'contact' => $request->input('contact'),
                'email' => $request->input('email'),
                'company' => $request->input('company'),
                'working_position' => $request->input('working_position'),
                'student_name' => $studentNameJson, // Can be null
                'image' => $imagePath,
                'status' => 0, // Default status is 0 (pending)
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Get the created record
            $endorserRequest = DB::table('endorser_request')
                ->where('id', $endorserRequestId)
                ->first();

            // Parse student_name back to array for response (handle null case)
            $studentNames = null;
            if ($endorserRequest->student_name) {
                $studentNames = json_decode($endorserRequest->student_name, true);
            }

            // Build full image URL
            $baseUrl = 'https://talenthub.newlinkmarketing.com/storage/';
            $imageUrl = $imagePath ? $baseUrl . $imagePath : null;

            return response()->json([
                'success' => true,
                'message' => 'Endorser request submitted successfully. Your application will be reviewed.',
                'data' => [
                    'id' => $endorserRequest->id,
                    'name' => $endorserRequest->name,
                    'contact' => $endorserRequest->contact,
                    'email' => $endorserRequest->email,
                    'company' => $endorserRequest->company,
                    'working_position' => $endorserRequest->working_position,
                    'student_name' => $studentNames, // Will be null or array
                    // 'image' => $endorserRequest->image,
                    'image_url' => $imageUrl,
                    'created_at' => $endorserRequest->created_at,
                    'updated_at' => $endorserRequest->updated_at
                ]
            ], 200);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while submitting endorser request',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
