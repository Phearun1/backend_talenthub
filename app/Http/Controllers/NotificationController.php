<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\MyTestEmail;
use App\Mail\WelcomeEmail;

class NotificationController extends Controller
{
    public function sendCollaborationNotification(){

    }

    // public function sendWelcomeEmail(Request $request)
    // {
    //     $userData = [
    //         'name' => $request->input('name'),
    //         'email' => $request->input('email'),
    //         // Add other user data as needed
    //     ];
        
    //     try {
    //         Mail::to($userData['email'])->send(new MyTestEmail($userData));
            
    //         return response()->json([
    //             'message' => 'Email sent successfully',
    //         ], 200);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Email could not be sent',
    //             'error' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    public function sendWelcomeEmail()
    {
        $user = new \stdClass();
        $user->name = "Sal Duong";
        $user->email = "phearun6600@gmail.com";
    
        // Send the email to the specified email address
        Mail::to($user->email)->send(new MyTestEmail($user));
    
        return 'Email sent successfully!';
    }


}
