<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\MyTestEmail;

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


    public function sendTestEmail(Request $request)
    {
        // Optional: You can use request data to customize the email
        $data = [
            'message' => $request->input('message', 'This is a default test message.')
        ];

        // Send the email
        Mail::send([], $data, function ($message) {
            $message->to('recipient@example.com')
                    ->subject('Test Email from TalentHub')
                    ->setBody('Hello, this is a test email from TalentHub.')
                    ->from(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'));
        });

        return response()->json(['status' => 'Email sent successfully!']);
    }

}
