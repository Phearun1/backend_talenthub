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


    // public function viewNotification(Request $request)
    // {
    //     try {
    //         // Get the user's Google ID from the request
    //         $request->validate([
    //             'user_google_id' => 'required|string',
    //         ]);

    //         $userGoogleId = $request->input('user_google_id');

    //         if (!$userGoogleId) {
    //             return response()->json([
    //                 'error' => 'User not authenticated or Google ID not found'
    //             ], 400);
    //         }

    //         // Get latest 10 pending PROJECT endorsement requests where this user is the endorser
    //         $projectEndorsementRequests = DB::table('project_endorsement_statuses as pes')
    //             ->join('projects as p', 'p.id', '=', 'pes.project_id')
    //             ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('endorsement_statuses as es', 'es.id', '=', 'pes.endorsement_status_id')
    //             ->select(
    //                 'pes.id as status_id',
    //                 'pes.project_id',
    //                 'pes.endorsement_status_id',
    //                 'es.status as status_name',
    //                 'p.title as project_name',
    //                 // 'p.description as project_description',
    //                 'requestor.id as requestor_id',
    //                 'requestor.name as requestor_name',
    //                 'requestor.google_id as requestor_google_id',
    //                 'pes.created_at',
    //             )
    //             ->where('pes.endorser_id', '=', $userGoogleId)
    //             ->where('pes.endorsement_status_id', '=', 1) // 1 = Pending
    //             ->orderBy('pes.created_at', 'desc')
    //             ->limit(10)
    //             ->get();

    //         // Get latest 10 pending EXPERIENCE endorsement requests where this user is the endorser
    //         $experienceEndorsementRequests = DB::table('experience_endorsement_statuses as ees')
    //             ->join('experiences as e', 'e.id', '=', 'ees.experience_id')
    //             ->join('portfolios as port', 'port.id', '=', 'e.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('endorsement_statuses as es', 'es.id', '=', 'ees.experience_status_id')
    //             ->join('companies as c', 'c.id', '=', 'e.company_id')  // Add join with companies table
    //             ->select(
    //                 'ees.id as status_id',
    //                 'ees.experience_id',
    //                 'ees.experience_status_id',
    //                 'es.status as status_name',
    //                 'e.work_title as experience_title',
    //                 // 'e.description as experience_description',
    //                 'c.company_name',
    //                 'requestor.id as requestor_id',
    //                 'requestor.name as requestor_name',
    //                 'requestor.google_id as requestor_google_id',
    //                 'ees.created_at',
    //             )
    //             ->where('ees.endorser_id', '=', $userGoogleId)
    //             ->where('ees.experience_status_id', '=', 1) // 1 = Pending
    //             ->orderBy('ees.created_at', 'desc')
    //             ->limit(10)
    //             ->get();
    //         // Get latest 10 pending SKILL endorsement requests where this user is the endorser
    //         $skillEndorsementRequests = DB::table('skill_endorsement_statuses as ses')
    //             ->join('skills as s', 's.id', '=', 'ses.skill_id')
    //             ->join('portfolios as port', 'port.id', '=', 's.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('endorsement_statuses as es', 'es.id', '=', 'ses.endorsement_status_id')
    //             ->select(
    //                 'ses.id as status_id',
    //                 'ses.skill_id',
    //                 'ses.endorsement_status_id',
    //                 'es.status as status_name',
    //                 's.title as skill_title',
    //                 // 's.description as skill_description',
    //                 'requestor.id as requestor_id',
    //                 'requestor.name as requestor_name',
    //                 'requestor.google_id as requestor_google_id',
    //                 'ses.created_at',
    //             )
    //             ->where('ses.endorser_id', '=', $userGoogleId)
    //             ->where('ses.endorsement_status_id', '=', 1) // 1 = Pending
    //             ->orderBy('ses.created_at', 'desc')
    //             ->limit(10)
    //             ->get();

    //         // Get latest 10 pending ACHIEVEMENT endorsement requests where this user is the endorser
    //         $achievementEndorsementRequests = DB::table('achievement_endorsement_statuses as aes')
    //             ->join('achievements as a', 'a.id', '=', 'aes.achievement_id')
    //             ->join('portfolios as port', 'port.id', '=', 'a.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('endorsement_statuses as es', 'es.id', '=', 'aes.endorsement_status_id')
    //             ->select(
    //                 'aes.id as status_id',
    //                 'aes.achievement_id',
    //                 'aes.endorsement_status_id',
    //                 'es.status as status_name',
    //                 'a.title as achievement_title',
    //                 // 'a.description as achievement_description',
    //                 'a.issued_by',
    //                 'a.issue_month',
    //                 'a.issue_year',
    //                 'requestor.id as requestor_id',
    //                 'requestor.name as requestor_name',
    //                 'requestor.google_id as requestor_google_id',
    //                 'aes.created_at',
    //             )
    //             ->where('aes.endorser_id', '=', $userGoogleId)
    //             ->where('aes.endorsement_status_id', '=', 1) // 1 = Pending
    //             ->orderBy('aes.created_at', 'desc')
    //             ->limit(10)
    //             ->get();

    //         // Get latest 10 pending collaboration requests where this user is the collaborator
    //         $collaborationRequests = DB::table('project_collaborator_invitation_statuses as pcis')
    //             ->join('projects as p', 'p.id', '=', 'pcis.project_id')
    //             ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('project_collaboration_statuses as pcs', 'pcs.id', '=', 'pcis.project_collab_status_id')
    //             ->select(
    //                 'pcis.id as status_id',
    //                 'pcis.project_id',
    //                 'pcis.project_collab_status_id',
    //                 'pcs.status as status_name',
    //                 'p.title as project_name',
    //                 // 'p.description as project_description',
    //                 'requestor.id as requestor_id',
    //                 'requestor.name as requestor_name',
    //                 'requestor.google_id as requestor_google_id',
    //                 'pcis.created_at',
    //             )
    //             ->where('pcis.collaborator_id', '=', $userGoogleId)
    //             ->where('pcis.project_collab_status_id', '=', 1) // 1 = Pending
    //             ->orderBy('pcis.created_at', 'desc')
    //             ->limit(10)
    //             ->get();

    //         // Count total pending notifications (not limited to 10)
    //         $totalProjectEndorsementRequests = DB::table('project_endorsement_statuses')
    //             ->where('endorser_id', $userGoogleId)
    //             ->where('endorsement_status_id', 1)
    //             ->count();

    //         $totalExperienceEndorsementRequests = DB::table('experience_endorsement_statuses')
    //             ->where('endorser_id', $userGoogleId)
    //             ->where('experience_status_id', 1)
    //             ->count();

    //         $totalSkillEndorsementRequests = DB::table('skill_endorsement_statuses')
    //             ->where('endorser_id', $userGoogleId)
    //             ->where('endorsement_status_id', 1)
    //             ->count();

    //         $totalAchievementEndorsementRequests = DB::table('achievement_endorsement_statuses')
    //             ->where('endorser_id', $userGoogleId)
    //             ->where('endorsement_status_id', 1)
    //             ->count();

    //         $totalCollaborationRequests = DB::table('project_collaborator_invitation_statuses')
    //             ->where('collaborator_id', $userGoogleId)
    //             ->where('project_collab_status_id', 1)
    //             ->count();

    //         $totalPending = $totalProjectEndorsementRequests + $totalExperienceEndorsementRequests + 
    //                         $totalSkillEndorsementRequests + $totalAchievementEndorsementRequests + 
    //                         $totalCollaborationRequests;

    //         return response()->json([
    //             'total_pending' => $totalPending,
    //             'project_endorsement_requests' => $projectEndorsementRequests,
    //             'experience_endorsement_requests' => $experienceEndorsementRequests,
    //             'skill_endorsement_requests' => $skillEndorsementRequests,
    //             'achievement_endorsement_requests' => $achievementEndorsementRequests,
    //             'collaboration_requests' => $collaborationRequests,
    //         ]);

    //     } catch (\Exception $e) {
    //         Log::error('Error fetching notifications: ' . $e->getMessage(), [
    //             'trace' => $e->getTraceAsString()
    //         ]);

    //         return response()->json([
    //             'error' => 'An error occurred while fetching notifications.',
    //             'message' => $e->getMessage()
    //         ], 500);
    //     }
    // }


    // public function viewNotification(Request $request)
    // {
    //     try {
    //         $request->validate([
    //             'user_google_id' => 'required|string',
    //         ]);

    //         $userGoogleId = $request->input('user_google_id');

    //         if (!$userGoogleId) {
    //             return response()->json([
    //                 'error' => 'User not authenticated or Google ID not found'
    //             ], 400);
    //         }

    //         $notifications = [];

    //         // Helper to fetch user info
    //         $getUserInfo = function ($googleId) {
    //             return DB::table('users')->where('google_id', $googleId)->first(['id', 'name', 'google_id']);
    //         };

    //         $endorser = $getUserInfo($userGoogleId);

    //         // PROJECT ENDORSEMENTS
    //         $projects = DB::table('project_endorsement_statuses as pes')
    //             ->join('projects as p', 'p.id', '=', 'pes.project_id')
    //             ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('pes.endorser_id', '=', $userGoogleId)
    //             ->where('pes.endorsement_status_id', '=', 1)
    //             ->orderBy('pes.created_at', 'desc')
    //             ->select('pes.id', 'pes.created_at', 'requestor.google_id as requestor_google_id', 'p.title as project_title')
    //             ->get();

    //         foreach ($projects as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 2,
    //                 'status' => 1,
    //                 'title' => $row->project_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // EXPERIENCE ENDORSEMENTS
    //         $experiences = DB::table('experience_endorsement_statuses as ees')
    //             ->join('experiences as e', 'e.id', '=', 'ees.experience_id')
    //             ->join('portfolios as port', 'port.id', '=', 'e.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('companies as c', 'c.id', '=', 'e.company_id')
    //             ->where('ees.endorser_id', '=', $userGoogleId)
    //             ->where('ees.experience_status_id', '=', 1)
    //             ->orderBy('ees.created_at', 'desc')
    //             ->select('ees.id', 'ees.created_at', 'requestor.google_id as requestor_google_id', 
    //                     'e.work_title', 'c.company_name')
    //             ->get();

    //         foreach ($experiences as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 3,
    //                 'status' => 1,
    //                 'title' => $row->work_title,
    //                 'company_name' => $row->company_name,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // SKILL ENDORSEMENTS
    //         $skills = DB::table('skill_endorsement_statuses as ses')
    //             ->join('skills as s', 's.id', '=', 'ses.skill_id')
    //             ->join('portfolios as port', 'port.id', '=', 's.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('ses.endorser_id', '=', $userGoogleId)
    //             ->where('ses.endorsement_status_id', '=', 1)
    //             ->orderBy('ses.created_at', 'desc')
    //             ->select('ses.id', 'ses.created_at', 'requestor.google_id as requestor_google_id', 's.title as skill_title')
    //             ->get();

    //         foreach ($skills as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 1,
    //                 'status' => 1,
    //                 'title' => $row->skill_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // ACHIEVEMENT ENDORSEMENTS
    //         $achievements = DB::table('achievement_endorsement_statuses as aes')
    //             ->join('achievements as a', 'a.id', '=', 'aes.achievement_id')
    //             ->join('portfolios as port', 'port.id', '=', 'a.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('aes.endorser_id', '=', $userGoogleId)
    //             ->where('aes.endorsement_status_id', '=', 1)
    //             ->orderBy('aes.created_at', 'desc')
    //             ->select('aes.id', 'aes.created_at', 'requestor.google_id as requestor_google_id', 
    //                     'a.title as achievement_title', 'a.issued_by')
    //             ->get();

    //         foreach ($achievements as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 4,
    //                 'status' => 1,
    //                 'title' => $row->achievement_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // COLLABORATIONS
    //         $collaborations = DB::table('project_collaborator_invitation_statuses as pcis')
    //             ->join('projects as p', 'p.id', '=', 'pcis.project_id')
    //             ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('pcis.collaborator_id', '=', $userGoogleId)
    //             ->where('pcis.project_collab_status_id', '=', 1)
    //             ->orderBy('pcis.created_at', 'desc')
    //             ->select('pcis.id', 'pcis.created_at', 'requestor.google_id as requestor_google_id', 'p.title as project_title')
    //             ->get();

    //         foreach ($collaborations as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $requestor->google_id,
    //                 'receiver_google_id' => $endorser->google_id,
    //                 'owner_name' => $requestor->name,
    //                 'receiver_name' => $endorser->name,
    //                 'type' => 1,
    //                 'endorsement_type' => null,
    //                 'status' => 1,
    //                 'title' => $row->project_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // Sort all notifications by created_at (most recent first)
    //         usort($notifications, function ($a, $b) {
    //             return strtotime($b['created_at']) <=> strtotime($a['created_at']);
    //         });

    //         // Return only the latest 10
    //         $notifications = array_slice($notifications, 0, 10);

    //         return response()->json($notifications);
    //     } catch (\Exception $e) {
    //         Log::error('Error fetching notifications: ' . $e->getMessage(), [
    //             'trace' => $e->getTraceAsString()
    //         ]);

    //         return response()->json([
    //             'error' => 'An error occurred while fetching notifications.',
    //             'message' => $e->getMessage()
    //         ], 500);
    //     }
    // }


    // public function viewNotification(Request $request)
    // {
    //     try {
    //         $request->validate([
    //             'user_google_id' => 'required|string',
    //             'limit' => 'nullable|integer|min:1|max:100',
    //         ]);

    //         $userGoogleId = $request->query('user_google_id');
    //         $limit = $request->query('limit', 10); // default to 10 if not specified

    //         if (!$userGoogleId) {
    //             return response()->json([
    //                 'error' => 'User not authenticated or Google ID not found'
    //             ], 400);
    //         }

    //         $notifications = [];

    //         $getUserInfo = function ($googleId) {
    //             return DB::table('users')->where('google_id', $googleId)->first(['id', 'name', 'google_id']);
    //         };

    //         $endorser = $getUserInfo($userGoogleId);

    //         // --- Collect project endorsements ---
    //         $projects = DB::table('project_endorsement_statuses as pes')
    //             ->join('projects as p', 'p.id', '=', 'pes.project_id')
    //             ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('pes.endorser_id', '=', $userGoogleId)
    //             ->where('pes.endorsement_status_id', '=', 1)
    //             ->orderBy('pes.created_at', 'desc')
    //             ->select('pes.id', 'pes.created_at', 'requestor.google_id as requestor_google_id', 'p.title as project_title')
    //             ->get();

    //         foreach ($projects as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 2,
    //                 'status' => 1,
    //                 'title' => $row->project_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // --- Experience Endorsements ---
    //         $experiences = DB::table('experience_endorsement_statuses as ees')
    //             ->join('experiences as e', 'e.id', '=', 'ees.experience_id')
    //             ->join('portfolios as port', 'port.id', '=', 'e.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->join('companies as c', 'c.id', '=', 'e.company_id')
    //             ->where('ees.endorser_id', '=', $userGoogleId)
    //             ->where('ees.experience_status_id', '=', 1)
    //             ->orderBy('ees.created_at', 'desc')
    //             ->select('ees.id', 'ees.created_at', 'requestor.google_id as requestor_google_id', 'e.work_title', 'c.company_name')
    //             ->get();

    //         foreach ($experiences as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 3,
    //                 'status' => 1,
    //                 'title' => $row->work_title,
    //                 'company_name' => $row->company_name,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // --- Skill Endorsements ---
    //         $skills = DB::table('skill_endorsement_statuses as ses')
    //             ->join('skills as s', 's.id', '=', 'ses.skill_id')
    //             ->join('portfolios as port', 'port.id', '=', 's.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('ses.endorser_id', '=', $userGoogleId)
    //             ->where('ses.endorsement_status_id', '=', 1)
    //             ->orderBy('ses.created_at', 'desc')
    //             ->select('ses.id', 'ses.created_at', 'requestor.google_id as requestor_google_id', 's.title as skill_title')
    //             ->get();

    //         foreach ($skills as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 1,
    //                 'status' => 1,
    //                 'title' => $row->skill_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // --- Achievement Endorsements ---
    //         $achievements = DB::table('achievement_endorsement_statuses as aes')
    //             ->join('achievements as a', 'a.id', '=', 'aes.achievement_id')
    //             ->join('portfolios as port', 'port.id', '=', 'a.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('aes.endorser_id', '=', $userGoogleId)
    //             ->where('aes.endorsement_status_id', '=', 1)
    //             ->orderBy('aes.created_at', 'desc')
    //             ->select('aes.id', 'aes.created_at', 'requestor.google_id as requestor_google_id', 'a.title as achievement_title', 'a.issued_by')
    //             ->get();

    //         foreach ($achievements as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $endorser->google_id,
    //                 'receiver_google_id' => $requestor->google_id,
    //                 'owner_name' => $endorser->name,
    //                 'receiver_name' => $requestor->name,
    //                 'type' => 2,
    //                 'endorsement_type' => 4,
    //                 'status' => 1,
    //                 'title' => $row->achievement_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // --- Collaborations ---
    //         $collaborations = DB::table('project_collaborator_invitation_statuses as pcis')
    //             ->join('projects as p', 'p.id', '=', 'pcis.project_id')
    //             ->join('portfolios as port', 'port.id', '=', 'p.portfolio_id')
    //             ->join('users as requestor', 'requestor.google_id', '=', 'port.user_id')
    //             ->where('pcis.collaborator_id', '=', $userGoogleId)
    //             ->where('pcis.project_collab_status_id', '=', 1)
    //             ->orderBy('pcis.created_at', 'desc')
    //             ->select('pcis.id', 'pcis.created_at', 'requestor.google_id as requestor_google_id', 'p.title as project_title')
    //             ->get();

    //         foreach ($collaborations as $row) {
    //             $requestor = $getUserInfo($row->requestor_google_id);
    //             $notifications[] = [
    //                 'id' => $row->id,
    //                 'owner_google_id' => $requestor->google_id,
    //                 'receiver_google_id' => $endorser->google_id,
    //                 'owner_name' => $requestor->name,
    //                 'receiver_name' => $endorser->name,
    //                 'type' => 1,
    //                 'endorsement_type' => null,
    //                 'status' => 1,
    //                 'title' => $row->project_title,
    //                 'created_at' => $row->created_at,
    //             ];
    //         }

    //         // --- Final sorting and limiting ---
    //         usort($notifications, fn($a, $b) => strtotime($b['created_at']) <=> strtotime($a['created_at']));
    //         $notifications = array_slice($notifications, 0, $limit);

    //         return response()->json($notifications);
    //     } catch (\Exception $e) {
    //         Log::error('Error fetching notifications: ' . $e->getMessage(), [
    //             'trace' => $e->getTraceAsString()
    //         ]);

    //         return response()->json([
    //             'error' => 'An error occurred while fetching notifications.',
    //             'message' => $e->getMessage()
    //         ], 500);
    //     }
    // }


    public function viewNotification(Request $request)
    {
        try {
            $request->validate([
                'user_google_id' => 'required|string',
                'limit' => 'nullable|integer|min:1|max:100',
            ]);

            $userGoogleId = $request->query('user_google_id');
            $limit = $request->query('limit', 10); // default to 10 if not specified

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
                    'pes.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    'p.title as project_title'
                )
                ->get();

            foreach ($projectRequests as $row) {
                $notifications[] = [
                    'id' => $row->id,
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
                    'pcis.created_at',
                    'requestor.google_id as requestor_google_id',
                    'requestor.name as requestor_name',
                    'p.title as project_title'
                )
                ->get();

            foreach ($collaborationRequests as $row) {
                $notifications[] = [
                    'id' => $row->id,
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

            // Return only the requested number
            $notifications = array_slice($notifications, 0, $limit);

            return response()->json($notifications);
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
        try {
            // Validate incoming request
            $request->validate([
                'subject' => 'required|string|max:255',
                'email' => 'required|email',
                'name' => 'nullable|string',
                'html_content' => 'required|string',
                'plain_content' => 'nullable|string',
            ]);
    
            $apikey = env('BREVO_API_KEY');
    
            if (!$apikey) {
                Log::error('Brevo API key not found in environment variables');
                return response()->json([
                    'error' => 'Email service configuration missing'
                ], 500);
            }
    
            // Prepare the transactional email data
            $emailData = [
                'sender' => [
                    'name' => 'TalentHub',
                    'email' => 'talenthub.paragoniu@gmail.com'
                ],
                'to' => [
                    [
                        'email' => $request->input('email'),
                        'name' => $request->input('name', '')
                    ]
                ],
                'subject' => $request->input('subject'),
                'htmlContent' => $request->input('html_content'),
            ];
    
            // Add plain text content if provided
            if ($request->has('plain_content')) {
                $emailData['textContent'] = $request->input('plain_content');
            }
    
            // Send the email immediately using Brevo's transactional email API
            $response = Http::withHeaders([
                'api-key' => $apikey,
                'accept' => 'application/json',
                'content-type' => 'application/json'
            ])->post('https://api.brevo.com/v3/smtp/email', $emailData);
    
            // Handle response
            if ($response->successful()) {
                $messageId = $response->json('messageId');
                
                Log::info('Email sent successfully', [
                    'message_id' => $messageId,
                    'recipient' => $request->input('email')
                ]);
    
                return response()->json([
                    'message' => 'Email sent successfully',
                    'message_id' => $messageId
                ], 200);
            } else {
                Log::error('Failed to send email', [
                    'status' => $response->status(),
                    'response' => $response->body()
                ]);
    
                return response()->json([
                    'error' => 'Failed to send email',
                    'details' => $response->json()
                ], $response->status());
            }
        } catch (\Exception $e) {
            Log::error('Exception while sending email: ' . $e->getMessage(), [
                'trace' => $e->getTraceAsString()
            ]);
    
            return response()->json([
                'error' => 'An error occurred while sending email',
                'message' => $e->getMessage()
            ], 500);
        }
    }


    // public function sendWelcomeEmail(Request $request)
    //     {
    //         // Validate the request data
    //         $request->validate([
    //             'name' => 'required|string',
    //             'email' => 'required|email',
    //         ]);

    //         $userData = [
    //             'name' => $request->input('name'),
    //             'email' => $request->input('email'),
    //             'plainText' => $request->input('plainText', 'Welcome to TalentHub!'),
    //             'htmlContent' => $request->input('htmlContent', '<p>Thank you for joining our platform.</p>')
    //         ];

    //         // Convert array to object for the email template
    //         $userObject = (object) $userData;

    //         try {
    //             // Log the attempt
    //             Log::info('Attempting to send welcome email to: ' . $userData['email']);

    //             Mail::to($userData['email'])->send(new MyTestEmail($userObject));

    //             // Log success
    //             Log::info('Email sent successfully to: ' . $userData['email']);

    //             return response()->json([
    //                 'message' => 'Email sent successfully',
    //             ], 200);
    //         } catch (\Exception $e) {
    //             // Log detailed error information
    //             Log::error('Failed to send email: ' . $e->getMessage(), [
    //                 'trace' => $e->getTraceAsString(),
    //                 'email' => $userData['email']
    //             ]);

    //             return response()->json([
    //                 'message' => 'Email could not be sent',
    //                 'error' => $e->getMessage(),
    //             ], 500);
    //         }
    //     }
}
