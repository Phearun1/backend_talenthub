<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use App\Mail\MyTestEmail;



class NotificationController extends Controller
{
    public function sendCollaborationNotification() {}



    public function viewNotification(Request $request)
    {
        try {
            $request->validate([
                'user_google_id' => 'required|string',
                'page' => 'nullable|integer|min:1',
            ]);
    
            $userGoogleId = $request->query('user_google_id');
            $page = $request->query('page', 1); // Default to page 1 if not specified
            $perPage = 10; // 15 notifications per page
           
    
            if (!$userGoogleId) {
                return response()->json([
                    'error' => 'User not authenticated or Google ID not found'
                ], 400);
            }
    
            $notifications = [];
    
            $getUserInfo = function ($googleId) {
                return DB::table('users')->where('google_id', $googleId)->first(['id', 'name', 'google_id']);
            };
    
            $currentUser = $getUserInfo($userGoogleId);
    
            // --- NOTIFICATIONS AS RECEIVER (PENDING REQUESTS) ---
    
            // Project endorsement requests (where user is the endorser)
            $projectRequests = DB::table('project_endorsement_statuses as pes')
                ->join('projects as p', 'p.id', '=', 'pes.project_id')
                ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->where('pes.endorser_id', '=', $userGoogleId)
                ->where('pes.endorsement_status_id', '=', 1) // Only pending requests
                ->orderBy('pes.created_at', 'desc')
                ->select(
                    'pes.id',
                    'p.id as project_id',
                    'pes.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    'p.title as project_title'
                )
                ->get();
    
            foreach ($projectRequests as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'project_id' => $row->project_id,
                    'owner_google_id' => $row->requestor_google_id, // Owner is the requester
                    'receiver_google_id' => $userGoogleId,
                    'owner_name' => $row->requestor_name,
                    'receiver_name' => $currentUser->name,
                    'type' => 2, // Endorsement request
                    'endorsement_type' => 2, // Project
                    'status' => 1, // Pending
                    'title' => $row->project_title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Experience endorsement requests
            $experienceRequests = DB::table('experience_endorsement_statuses as ees')
                ->join('experiences as e', 'e.id', '=', 'ees.experience_id')
                ->join('portfolios as port', 'port.id', '=', 'e.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->join('companies as c', 'c.id', '=', 'e.company_id')
                ->where('ees.endorser_id', '=', $userGoogleId)
                ->where('ees.experience_status_id', '=', 1) // Only pending requests
                ->orderBy('ees.created_at', 'desc')
                ->select(
                    'ees.id',
                    'ees.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    'e.work_title',
                    'c.company_name'
                )
                ->get();
    
            foreach ($experienceRequests as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'owner_google_id' => $row->requestor_google_id, // Owner is the requester
                    'receiver_google_id' => $userGoogleId,
                    'owner_name' => $row->requestor_name,
                    'receiver_name' => $currentUser->name,
                    'type' => 2, // Endorsement request
                    'endorsement_type' => 3, // Experience
                    'status' => 1, // Pending
                    'title' => $row->work_title . ' at ' . $row->company_name,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Skill endorsement requests
            $skillRequests = DB::table('skill_endorsement_statuses as ses')
                ->join('skills as s', 's.id', '=', 'ses.skill_id')
                ->join('portfolios as port', 'port.id', '=', 's.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->where('ses.endorser_id', '=', $userGoogleId)
                ->where('ses.endorsement_status_id', '=', 1) // Only pending requests
                ->orderBy('ses.created_at', 'desc')
                ->select(
                    'ses.id',
                    'ses.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    's.title as skill_title'
                )
                ->get();
    
            foreach ($skillRequests as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'owner_google_id' => $row->requestor_google_id, // Owner is the requester
                    'receiver_google_id' => $userGoogleId,
                    'owner_name' => $row->requestor_name,
                    'receiver_name' => $currentUser->name,
                    'type' => 2, // Endorsement request
                    'endorsement_type' => 1, // Skill
                    'status' => 1, // Pending
                    'title' => $row->skill_title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Achievement endorsement requests
            $achievementRequests = DB::table('achievement_endorsement_statuses as aes')
                ->join('achievements as a', 'a.id', '=', 'aes.achievement_id')
                ->join('portfolios as port', 'port.id', '=', 'a.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->where('aes.endorser_id', '=', $userGoogleId)
                ->where('aes.endorsement_status_id', '=', 1) // Only pending requests
                ->orderBy('aes.created_at', 'desc')
                ->select(
                    'aes.id',
                    'aes.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    'a.title as achievement_title',
                    'a.issued_by'
                )
                ->get();
    
            foreach ($achievementRequests as $row) {
                $title = $row->achievement_title;
                if ($row->issued_by) {
                    $title .= ' from ' . $row->issued_by;
                }
    
                $notifications[] = [
                    'id' => $row->id,
                    'owner_google_id' => $row->requestor_google_id, // Owner is the requester
                    'receiver_google_id' => $userGoogleId,
                    'owner_name' => $row->requestor_name,
                    'receiver_name' => $currentUser->name,
                    'type' => 2, // Endorsement request
                    'endorsement_type' => 4, // Achievement
                    'status' => 1, // Pending
                    'title' => $title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Collaboration requests
            $collaborationRequests = DB::table('project_collaborator_invitation_statuses as pcis')
                ->join('projects as p', 'p.id', '=', 'pcis.project_id')
                ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
                ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
                ->where('pcis.collaborator_id', '=', $userGoogleId)
                ->where('pcis.project_collab_status_id', '=', 1) // Only pending requests
                ->orderBy('pcis.created_at', 'desc')
                ->select(
                    'pcis.id',
                    'p.id as project_id',
                    'pcis.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    'p.title as project_title'
                )
                ->get();
    
            foreach ($collaborationRequests as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'project_id' => $row->project_id,
                    'owner_google_id' => $row->requestor_google_id, // Owner is the project owner
                    'receiver_google_id' => $userGoogleId,
                    'owner_name' => $row->requestor_name,
                    'receiver_name' => $currentUser->name,
                    'type' => 1, // Collaboration request
                    'endorsement_type' => null,
                    'status' => 1, // Pending
                    'title' => $row->project_title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // --- NOTIFICATIONS AS OWNER (ACCEPTED/REJECTED REQUESTS) ---
    
            // Project endorsement responses (where user is the requestor)
            $projectResponses = DB::table('project_endorsement_statuses as pes')
                ->join('projects as p', 'p.id', '=', 'pes.project_id')
                ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
                ->join('users as endorser', 'endorser.google_id', '=', 'pes.endorser_id')
                ->whereIn('pes.endorsement_status_id', [2, 3]) // Only accepted or rejected
                ->where('port.user_id', '=', $userGoogleId)
                ->orderBy('pes.updated_at', 'desc')
                ->select(
                    'pes.id',
                    'p.id as project_id',
                    'pes.updated_at as created_at',
                    'endorser.google_id as endorser_google_id',
                    'endorser.name as endorser_name',
                    'p.title as project_title',
                    'pes.endorsement_status_id'
                )
                ->get();
    
            foreach ($projectResponses as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'project_id' => $row->project_id,	
                    'owner_google_id' => $userGoogleId, // User is the owner
                    'receiver_google_id' => $row->endorser_google_id,
                    'owner_name' => $currentUser->name,
                    'receiver_name' => $row->endorser_name,
                    'type' => 2, // Endorsement
                    'endorsement_type' => 2, // Project
                    'status' => $row->endorsement_status_id, // 2 = Accepted, 3 = Rejected
                    'title' => $row->project_title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Experience endorsement responses
            $experienceResponses = DB::table('experience_endorsement_statuses as ees')
                ->join('experiences as e', 'e.id', '=', 'ees.experience_id')
                ->join('portfolios as port', 'port.id', '=', 'e.portfolio_id')
                ->join('users as endorser', 'endorser.google_id', '=', 'ees.endorser_id')
                ->join('companies as c', 'c.id', '=', 'e.company_id')
                ->whereIn('ees.experience_status_id', [2, 3]) // Only accepted or rejected
                ->where('port.user_id', '=', $userGoogleId)
                ->orderBy('ees.updated_at', 'desc')
                ->select(
                    'ees.id',
                    'ees.updated_at as created_at',
                    'endorser.google_id as endorser_google_id',
                    'endorser.name as endorser_name',
                    'e.work_title',
                    'c.company_name',
                    'ees.experience_status_id as endorsement_status_id'
                )
                ->get();
    
            foreach ($experienceResponses as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'owner_google_id' => $userGoogleId, // User is the owner
                    'receiver_google_id' => $row->endorser_google_id,
                    'owner_name' => $currentUser->name,
                    'receiver_name' => $row->endorser_name,
                    'type' => 2, // Endorsement
                    'endorsement_type' => 3, // Experience
                    'status' => $row->endorsement_status_id, // 2 = Accepted, 3 = Rejected
                    'title' => $row->work_title . ' at ' . $row->company_name,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Skill endorsement responses
            $skillResponses = DB::table('skill_endorsement_statuses as ses')
                ->join('skills as s', 's.id', '=', 'ses.skill_id')
                ->join('portfolios as port', 'port.id', '=', 's.portfolio_id')
                ->join('users as endorser', 'endorser.google_id', '=', 'ses.endorser_id')
                ->whereIn('ses.endorsement_status_id', [2, 3]) // Only accepted or rejected
                ->where('port.user_id', '=', $userGoogleId)
                ->orderBy('ses.updated_at', 'desc')
                ->select(
                    'ses.id',
                    'ses.updated_at as created_at',
                    'endorser.google_id as endorser_google_id',
                    'endorser.name as endorser_name',
                    's.title as skill_title',
                    'ses.endorsement_status_id'
                )
                ->get();
    
            foreach ($skillResponses as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'owner_google_id' => $userGoogleId, // User is the owner
                    'receiver_google_id' => $row->endorser_google_id,
                    'owner_name' => $currentUser->name,
                    'receiver_name' => $row->endorser_name,
                    'type' => 2, // Endorsement
                    'endorsement_type' => 1, // Skill
                    'status' => $row->endorsement_status_id, // 2 = Accepted, 3 = Rejected
                    'title' => $row->skill_title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Achievement endorsement responses
            $achievementResponses = DB::table('achievement_endorsement_statuses as aes')
                ->join('achievements as a', 'a.id', '=', 'aes.achievement_id')
                ->join('portfolios as port', 'port.id', '=', 'a.portfolio_id')
                ->join('users as endorser', 'endorser.google_id', '=', 'aes.endorser_id')
                ->whereIn('aes.endorsement_status_id', [2, 3]) // Only accepted or rejected
                ->where('port.user_id', '=', $userGoogleId)
                ->orderBy('aes.updated_at', 'desc')
                ->select(
                    'aes.id',
                    'aes.updated_at as created_at',
                    'endorser.google_id as endorser_google_id',
                    'endorser.name as endorser_name',
                    'a.title as achievement_title',
                    'a.issued_by',
                    'aes.endorsement_status_id'
                )
                ->get();
    
            foreach ($achievementResponses as $row) {
                $title = $row->achievement_title;
                if ($row->issued_by) {
                    $title .= ' from ' . $row->issued_by;
                }
    
                $notifications[] = [
                    'id' => $row->id,
                    'owner_google_id' => $userGoogleId, // User is the owner
                    'receiver_google_id' => $row->endorser_google_id,
                    'owner_name' => $currentUser->name,
                    'receiver_name' => $row->endorser_name,
                    'type' => 2, // Endorsement
                    'endorsement_type' => 4, // Achievement
                    'status' => $row->endorsement_status_id, // 2 = Accepted, 3 = Rejected
                    'title' => $title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Collaboration responses
            $collaborationResponses = DB::table('project_collaborator_invitation_statuses as pcis')
                ->join('projects as p', 'p.id', '=', 'pcis.project_id')
                ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
                ->join('users as collaborator', 'collaborator.google_id', '=', 'pcis.collaborator_id')
                ->whereIn('pcis.project_collab_status_id', [2, 3]) // Only accepted or rejected
                ->where('port.user_id', '=', $userGoogleId)
                ->orderBy('pcis.updated_at', 'desc')
                ->select(
                    'pcis.id',
                    'p.id as project_id',
                    'pcis.updated_at as created_at',
                    'collaborator.google_id as collaborator_google_id',
                    'collaborator.name as collaborator_name',
                    'p.title as project_title',
                    'pcis.project_collab_status_id'
                )
                ->get();
    
            foreach ($collaborationResponses as $row) {
                $notifications[] = [
                    'id' => $row->id,
                    'project_id' => $row->project_id,
                    'owner_google_id' => $userGoogleId, // User is the project owner
                    'receiver_google_id' => $row->collaborator_google_id,
                    'owner_name' => $currentUser->name,
                    'receiver_name' => $row->collaborator_name,
                    'type' => 1, // Collaboration
                    'endorsement_type' => null,
                    'status' => $row->project_collab_status_id, // 2 = Accepted, 3 = Rejected
                    'title' => $row->project_title,
                    'created_at' => $row->created_at,
                ];
            }
    
            // Sort all notifications by created_at (most recent first)
            usort($notifications, fn($a, $b) => strtotime($b['created_at']) <=> strtotime($a['created_at']));
    
            // Get the total count of notifications for pagination info
            $totalCount = count($notifications);
            
            // Apply pagination - skip previous pages and limit to perPage items
            $notifications = array_slice($notifications, ($page - 1) * $perPage, $perPage);
    
            return response()->json($notifications);
        } catch (\Exception $e) {
            // Log::error('Error fetching notifications: ' . $e->getMessage(), [
            //     'trace' => $e->getTraceAsString()
            // ]);
    
            return response()->json([
                'error' => 'An error occurred while fetching notifications.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

       
}
