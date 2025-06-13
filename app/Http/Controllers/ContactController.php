<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class ContactController extends Controller
{
    public function sendContact(Request $request)
    {
        try {
            // Validate request data
            $validatedData = $request->validate([
                'google_id' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'phone_number' => 'required|string|max:255'
            ]);

            // Check if contact already exists for this google_id and email combination
            $existingContact = DB::table('contact')
                ->where('google_id', $validatedData['google_id'])
                ->where('email', $validatedData['email'])
                ->first();

            if ($existingContact) {
                // Update existing contact
                $updated = DB::table('contact')
                    ->where('google_id', $validatedData['google_id'])
                    ->update([
                        'email' => $validatedData['email'],
                        'phone_number' => $validatedData['phone_number'],
                        'updated_at' => now()
                    ]);
                
                // Get updated contact data
                $contact = DB::table('contact')
                    ->where('google_id', $validatedData['google_id'])
                    ->first();
                
                return response()->json([
                    'success' => true,
                    'message' => 'Contact sent successfully',
                    'contact' => $contact
                ], 200);
            } else {
                // Create new contact
                $contactId = DB::table('contact')->insertGetId([
                    'google_id' => $validatedData['google_id'],
                    'email' => $validatedData['email'],
                    'phone_number' => $validatedData['phone_number'],
                    'created_at' => now(),
                    'updated_at' => now()
                ]);

                // Get newly created contact
                $contact = DB::table('contact')->where('id', $contactId)->first();

                return response()->json([
                    'success' => true,
                    'message' => 'Contact sent successfully',
                    'contact' => $contact
                ], 201);
            }

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while saving contact',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function viewIncomingContact(Request $request)
    {
        try {
            // Get authenticated user's google_id from bearer token
            $authenticatedUser = $request->user();
            if (!$authenticatedUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized. Please provide a valid bearer token.'
                ], 401);
            }

            $googleId = $authenticatedUser->google_id;

            // Find contact by google_id using raw database query
            $contact = DB::table('contact')
                ->select('id', 'google_id', 'email', 'phone_number', 'created_at', 'updated_at')
                ->where('google_id', $googleId)
                ->get();

            if (!$contact) {
                return response()->json([
                    'success' => false,
                    'message' => 'Contact not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                $contact
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while retrieving contact',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
