<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Mail\MyTestEmail;
use Symfony\Component\Mime\Part\TextPart;
use Symfony\Component\Mime\Email;

class NotificationController extends Controller
{
    public function sendCollaborationNotification() {}

    public function sendWelcomeEmail(Request $request)
    {
        // Validate the request data
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
        ]);

        $userData = [
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            'plainText' => $request->input('plainText', 'Welcome to TalentHub!'),
            'htmlContent' => $request->input('htmlContent', '<p>Thank you for joining our platform.</p>')
        ];

        // Convert array to object for the email template
        $userObject = (object) $userData;

        try {
            // Log the attempt
            Log::info('Attempting to send welcome email to: ' . $userData['email']);
            
            Mail::to($userData['email'])->send(new MyTestEmail($userObject));

            // Log success
            Log::info('Email sent successfully to: ' . $userData['email']);

            return response()->json([
                'message' => 'Email sent successfully',
            ], 200);
        } catch (\Exception $e) {
            // Log detailed error information
            Log::error('Failed to send email: ' . $e->getMessage(), [
                'trace' => $e->getTraceAsString(),
                'email' => $userData['email']
            ]);
            
            return response()->json([
                'message' => 'Email could not be sent',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
