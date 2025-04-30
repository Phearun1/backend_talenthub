<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use App\Mail\MyTestEmail;



class NotificationController extends Controller
{
    public function sendCollaborationNotification() {}


    public function viewNotification(Request $request)
    {
        try {
            // Get the authenticated user's Google ID
            $userGoogleId = $request->user()->google_id;
            
            if (!$userGoogleId) {
                return response()->json([
                    'error' => 'User not authenticated or Google ID not found'
                ], 400);
            }
            
            // Get pending endorsement requests where this user is the endorser
            $endorsementRequests = DB::table('project_endorsement_statuses as pes')
                ->join('projects as p', 'p.id', '=', 'pes.project_id')
                ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->join('endorsement_statuses as es', 'es.id', '=', 'pes.endorsement_status_id')
                ->select(
                    'pes.id as status_id',
                    'pes.project_id',
                    'pes.endorsement_status_id',
                    'es.status as status_name',
                    'p.name as project_name',
                    'p.description as project_description',
                    'requestor.id as requestor_id',
                    'requestor.name as requestor_name',
                    'requestor.email as requestor_email',
                    'requestor.google_id as requestor_google_id',
                )
                ->where('pes.endorser_id', '=', $userGoogleId)
                ->where('pes.endorsement_status_id', '=', 1) // 1 = Pending
                ->get();
                
            // Get pending collaboration requests where this user is the collaborator
            $collaborationRequests = DB::table('project_collaborator_invitation_statuses as pcis')
                ->join('projects as p', 'p.id', '=', 'pcis.project_id')
                ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->join('project_collaboration_statuses as pcs', 'pcs.id', '=', 'pcis.project_collab_status_id')
                ->select(
                    'pcis.id as status_id',
                    'pcis.project_id',
                    'pcis.project_collab_status_id as status_id',
                    'pcs.status as status_name',
                    'p.name as project_name', 
                    'p.description as project_description',
                    'requestor.id as requestor_id',
                    'requestor.name as requestor_name',
                    'requestor.email as requestor_email',
                    'requestor.google_id as requestor_google_id',
                )
                ->where('pcis.collaborator_id', '=', $userGoogleId)
                ->where('pcis.project_collab_status_id', '=', 1) // 1 = Pending
                ->get();
                
            // Count total pending notifications
            $totalPending = $endorsementRequests->count() + $collaborationRequests->count();
            
            return response()->json([
                'total_pending' => $totalPending,
                'endorsement_requests' => $endorsementRequests,
                'collaboration_requests' => $collaborationRequests,
            ]);
            
        } catch (\Exception $e) {
            Log::error('Error fetching notifications: ' . $e->getMessage(), [
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'error' => 'An error occurred while fetching notifications.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

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
