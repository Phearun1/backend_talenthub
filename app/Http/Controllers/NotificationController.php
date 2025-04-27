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
        $userData = [
            'name' => $request->input('name'),
            'email' => $request->input('email'),
        ];

        // Convert array to object for the email template
        $userObject = (object) $userData;

        try {
            Mail::to($userData['email'])->send(new MyTestEmail($userObject));

            return response()->json([
                'message' => 'Email sent successfully',
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Email could not be sent',
                'error' => $e->getMessage(),
            ], 500);
        }
    }


    public function sendTestEmail()
{
    // Create a new instance of your Mailable class
    $email = new MyTestEmail((object)[
        'plainText' => 'Your plain text email body content here',
        'htmlContent' => '<p>Your <strong>HTML</strong> email content here</p>'
    ]);

    // Send the email
    Mail::to('khansrey6600@gmail.com')->send($email);
}
}
