<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\MyTestEmail;

class NotificationController extends Controller
{
    public function sendCollaborationNotification(){

    }

    public function sendWelcomeEmail(Request $request)
    {
        $userData = [
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            // Add other user data as needed
        ];
        
        try {
            Mail::to($userData['email'])->send(new MyTestEmail($userData));
            
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


}
