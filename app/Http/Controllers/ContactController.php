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

            // Find contact by google_id using raw database query - sorted by newest first
            $contact = DB::table('contact')
                ->select('id', 'google_id', 'email', 'phone_number', 'created_at', 'updated_at')
                ->where('google_id', $googleId)
                ->orderBy('created_at', 'desc') // Newest first
                ->get();

            if ($contact->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Contact not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $contact
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while retrieving contact',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function deleteContact(Request $request, $contactId)
    {
        try {
            // Get authenticated user from bearer token
            $authenticatedUser = $request->user();
            if (!$authenticatedUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized. Please provide a valid bearer token.'
                ], 401);
            }

            // Validate contact ID
            if (!$contactId || !is_numeric($contactId)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid contact ID provided'
                ], 400);
            }

            $userGoogleId = $authenticatedUser->google_id;

            // Find the contact by ID and check ownership
            $contact = DB::table('contact')
                ->where('id', $contactId)
                ->first();

            if (!$contact) {
                return response()->json([
                    'success' => false,
                    'message' => 'Contact not found'
                ], 404);
            }

            // Check if the authenticated user's google_id matches the contact's google_id
            if ($contact->google_id !== $userGoogleId) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. You do not own this contact.'
                ], 403);
            }

            // Store contact details for response before deletion
            $deletedContactData = [
                'id' => $contact->id,
                'google_id' => $contact->google_id,
                'email' => $contact->email,
                'phone_number' => $contact->phone_number,
                'created_at' => $contact->created_at,
                'updated_at' => $contact->updated_at
            ];

            // Delete the contact
            $deleted = DB::table('contact')
                ->where('id', $contactId)
                ->where('google_id', $userGoogleId) // Double-check ownership
                ->delete();

            if ($deleted) {
                return response()->json([
                    'success' => true,
                    'message' => 'Contact deleted successfully',

                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to delete contact'
                ], 500);
            }
        } catch (\Exception $e) {
            \Log::error('Delete contact error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while deleting the contact',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
