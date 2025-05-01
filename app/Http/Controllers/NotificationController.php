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
        // Get the user's Google ID from the request
        $request->validate([
            'user_google_id' => 'required|string',
        ]);

        $userGoogleId = $request->input('user_google_id');

        if (!$userGoogleId) {
            return response()->json([
                'error' => 'User not authenticated or Google ID not found'
            ], 400);
        }
        
        // Get latest 10 pending PROJECT endorsement requests where this user is the endorser
        $projectEndorsementRequests = DB::table('project_endorsement_statuses as pes')
            ->join('projects as p', 'p.id', '=', 'pes.project_id')
            ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
            ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
            ->join('endorsement_statuses as es', 'es.id', '=', 'pes.endorsement_status_id')
            ->select(
                'pes.id as status_id',
                'pes.project_id',
                'pes.endorsement_status_id',
                'es.status as status_name',
                'p.title as project_name',
                // 'p.description as project_description',
                'requestor.id as requestor_id',
                'requestor.name as requestor_name',
                'requestor.google_id as requestor_google_id',
                'pes.created_at',
            )
            ->where('pes.endorser_id', '=', $userGoogleId)
            ->where('pes.endorsement_status_id', '=', 1) // 1 = Pending
            ->orderBy('pes.created_at', 'desc')
            ->limit(10)
            ->get();
            
        // Get latest 10 pending EXPERIENCE endorsement requests where this user is the endorser
        $experienceEndorsementRequests = DB::table('experience_endorsement_statuses as ees')
            ->join('experiences as e', 'e.id', '=', 'ees.experience_id')
            ->join('portfolios as port', 'port.id', '=', 'e.portfolio_id')
            ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
            ->join('endorsement_statuses as es', 'es.id', '=', 'ees.experience_status_id')
            ->join('companies as c', 'c.id', '=', 'e.company_id')  // Add join with companies table
            ->select(
                'ees.id as status_id',
                'ees.experience_id',
                'ees.experience_status_id',
                'es.status as status_name',
                'e.work_title as experience_title',
                // 'e.description as experience_description',
                'c.company_name',
                'requestor.id as requestor_id',
                'requestor.name as requestor_name',
                'requestor.google_id as requestor_google_id',
                'ees.created_at',
            )
            ->where('ees.endorser_id', '=', $userGoogleId)
            ->where('ees.experience_status_id', '=', 1) // 1 = Pending
            ->orderBy('ees.created_at', 'desc')
            ->limit(10)
            ->get();
        // Get latest 10 pending SKILL endorsement requests where this user is the endorser
        $skillEndorsementRequests = DB::table('skill_endorsement_statuses as ses')
            ->join('skills as s', 's.id', '=', 'ses.skill_id')
            ->join('portfolios as port', 'port.id', '=', 's.portfolio_id')
            ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
            ->join('endorsement_statuses as es', 'es.id', '=', 'ses.endorsement_status_id')
            ->select(
                'ses.id as status_id',
                'ses.skill_id',
                'ses.endorsement_status_id',
                'es.status as status_name',
                's.title as skill_title',
                // 's.description as skill_description',
                'requestor.id as requestor_id',
                'requestor.name as requestor_name',
                'requestor.google_id as requestor_google_id',
                'ses.created_at',
            )
            ->where('ses.endorser_id', '=', $userGoogleId)
            ->where('ses.endorsement_status_id', '=', 1) // 1 = Pending
            ->orderBy('ses.created_at', 'desc')
            ->limit(10)
            ->get();
            
        // Get latest 10 pending ACHIEVEMENT endorsement requests where this user is the endorser
        $achievementEndorsementRequests = DB::table('achievement_endorsement_statuses as aes')
            ->join('achievements as a', 'a.id', '=', 'aes.achievement_id')
            ->join('portfolios as port', 'port.id', '=', 'a.portfolio_id')
            ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
            ->join('endorsement_statuses as es', 'es.id', '=', 'aes.endorsement_status_id')
            ->select(
                'aes.id as status_id',
                'aes.achievement_id',
                'aes.endorsement_status_id',
                'es.status as status_name',
                'a.title as achievement_title',
                // 'a.description as achievement_description',
                'a.issued_by',
                'a.issue_month',
                'a.issue_year',
                'requestor.id as requestor_id',
                'requestor.name as requestor_name',
                'requestor.google_id as requestor_google_id',
                'aes.created_at',
            )
            ->where('aes.endorser_id', '=', $userGoogleId)
            ->where('aes.endorsement_status_id', '=', 1) // 1 = Pending
            ->orderBy('aes.created_at', 'desc')
            ->limit(10)
            ->get();
            
        // Get latest 10 pending collaboration requests where this user is the collaborator
        $collaborationRequests = DB::table('project_collaborator_invitation_statuses as pcis')
            ->join('projects as p', 'p.id', '=', 'pcis.project_id')
            ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
            ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
            ->join('project_collaboration_statuses as pcs', 'pcs.id', '=', 'pcis.project_collab_status_id')
            ->select(
                'pcis.id as status_id',
                'pcis.project_id',
                'pcis.project_collab_status_id',
                'pcs.status as status_name',
                'p.title as project_name',
                // 'p.description as project_description',
                'requestor.id as requestor_id',
                'requestor.name as requestor_name',
                'requestor.google_id as requestor_google_id',
                'pcis.created_at',
            )
            ->where('pcis.collaborator_id', '=', $userGoogleId)
            ->where('pcis.project_collab_status_id', '=', 1) // 1 = Pending
            ->orderBy('pcis.created_at', 'desc')
            ->limit(10)
            ->get();
            
        // Count total pending notifications (not limited to 10)
        $totalProjectEndorsementRequests = DB::table('project_endorsement_statuses')
            ->where('endorser_id', $userGoogleId)
            ->where('endorsement_status_id', 1)
            ->count();
            
        $totalExperienceEndorsementRequests = DB::table('experience_endorsement_statuses')
            ->where('endorser_id', $userGoogleId)
            ->where('experience_status_id', 1)
            ->count();
            
        $totalSkillEndorsementRequests = DB::table('skill_endorsement_statuses')
            ->where('endorser_id', $userGoogleId)
            ->where('endorsement_status_id', 1)
            ->count();
            
        $totalAchievementEndorsementRequests = DB::table('achievement_endorsement_statuses')
            ->where('endorser_id', $userGoogleId)
            ->where('endorsement_status_id', 1)
            ->count();
            
        $totalCollaborationRequests = DB::table('project_collaborator_invitation_statuses')
            ->where('collaborator_id', $userGoogleId)
            ->where('project_collab_status_id', 1)
            ->count();
            
        $totalPending = $totalProjectEndorsementRequests + $totalExperienceEndorsementRequests + 
                        $totalSkillEndorsementRequests + $totalAchievementEndorsementRequests + 
                        $totalCollaborationRequests;
        
        return response()->json([
            'total_pending' => $totalPending,
            'project_endorsement_requests' => $projectEndorsementRequests,
            'experience_endorsement_requests' => $experienceEndorsementRequests,
            'skill_endorsement_requests' => $skillEndorsementRequests,
            'achievement_endorsement_requests' => $achievementEndorsementRequests,
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
