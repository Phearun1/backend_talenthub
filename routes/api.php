<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\AchievementController;
use App\Http\Controllers\PortfolioController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\SkillController;
use App\Http\Controllers\ExperienceController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EducationController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\MajorController;
use Illuminate\Support\Facades\Route;


// Public route for Google login
Route::post('/login_google', [AuthController::class, 'loginWithGoogle']);
Route::post('/login_google2', [AuthController::class, 'loginWithGoogle2']);
Route::post('/admin_login', [AuthController::class, 'adminLogin']);

Route::get('/view_all_companies', [ExperienceController::class, 'viewAllCompanies']);

Route::post('/send-email', [NotificationController::class, 'sendTestEmail']);

Route::post('/send-welcome-email', [NotificationController::class, 'sendWelcomeEmail']);
Route::get('/download_project/{id}', [ProjectController::class, 'downloadProject']);
Route::post('/become_endorser', [AuthController::class, 'becomeEndorser']); // become endorser
Route::get('/search_portfolio', [PortfolioController::class, 'searchPortfolio']); // search portfolio
Route::post('/send_contact', [ContactController::class, 'sendContact']);
// Check token validity
// view all projects


Route::middleware([\Fruitcake\Cors\HandleCors::class])->group(function () {

    Route::get('/view_all_portfolio', [PortfolioController::class, 'viewAllPortfolio']);
    Route::get('/view_portfolio_details/{userID}', [PortfolioController::class, 'viewPortfolioDetails']);

    Route::get('view_achievement_detail/{id}', [AchievementController::class, 'viewAchievementDetail']);
});

 Route::get('/view_all_majors', [MajorController::class, 'viewAllMajors']);
// portfolio
Route::post('/view_project_detail/{projectId}', [ProjectController::class, 'viewProjectDetail']);




Route::middleware('auth:sanctum', 'token.expiration')->group(function () {

    // Protected route for logout (requires authentication via Sanctum)
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::post('/check_token', [AuthController::class, 'checkToken']);
    // User route

    Route::middleware('role:1')->post('/create_company', [ExperienceController::class, 'createCompany']);

    Route::post('/update_portfolio/{id}', [PortfolioController::class, 'updatePortfolio']); // Edit portfolio


    //skill

    Route::post('/create_skill', [SkillController::class, 'createSkill']);  // Create skill
    Route::put('/update_skill/{id}', [SkillController::class, 'updateSkill']);  // Edit skill
    Route::delete('/delete_skill/{id}', [SkillController::class, 'deleteSkill']);  // Delete skill



    // project

    Route::get('/view_all_projects', [ProjectController::class, 'viewAllProjects']);
    Route::post('/create_project', [ProjectController::class, 'createProject']);
    Route::post('/update_project/{id}', [ProjectController::class, 'updateProject']);

    Route::delete('/remove_project_file/{projectId}', [ProjectController::class, 'removeProjectFile']);
    Route::delete('/remove_project_images/{imageId}', [ProjectController::class, 'removeProjectImage']);


    Route::delete('/delete_project/{id}', [ProjectController::class, 'deleteProject']);


    Route::post('/add_endorser_to_project/{projectId}', [ProjectController::class, 'addEndorserToProject']);
    Route::delete('/delete_endorser_request/{projectId}', [ProjectController::class, 'deleteEndorserRequest']);
    Route::post('/add_collaborator_to_project/{projectId}', [ProjectController::class, 'addCollaboratorToProject']);
    Route::delete('/delete_collaborator_request/{projectId}', [ProjectController::class, 'deleteCollaboratorRequest']);


    // Achievements 
    Route::post('/create_achievement', [AchievementController::class, 'createAchievement']);
    Route::post('/update_achievement/{id}', [AchievementController::class, 'updateAchievement']);
    Route::delete('/delete_achievement/{id}', [AchievementController::class, 'deleteAchievement']);


    //education
    Route::post('/create_education', [EducationController::class, 'createEducation']);
    Route::put('/update_education/{id}', [EducationController::class, 'updateEducation']);
    Route::delete('/delete_education/{id}', [EducationController::class, 'deleteEducation']);


    //remove endorserment

    Route::delete('/remove_endorsement', [PortfolioController::class, 'removeEndorsement']);
    // Experience

    Route::post('/create_experience', [ExperienceController::class, 'createExperience']);

    // Edit an existing experience
    Route::put('/update_experience/{id}', [ExperienceController::class, 'updateExperience']);

    // Delete an experience
    Route::delete('/delete_experience/{id}', [ExperienceController::class, 'deleteExperience']);



    Route::post('/change_endorsement_collaboration_request', [ProjectController::class, 'changeEndorsementCollaborationRequest']);

    // notification

    Route::get('/view_notification', [NotificationController::class, 'viewNotification']);

    Route::post('/update_project_visibility/{projectId}', [ProjectController::class, 'updateProjectVisibility']);




    // POST /api/contacts/view - Get contact information by google_id
    Route::get('/view_incoming_contact', [ContactController::class, 'viewIncomingContact']);
    Route::delete('/delete_contact/{id}', [ContactController::class, 'deleteContact']);
    // Admin route 
    Route::middleware('role:3')->post('/admin/create_admin_account', [AdminController::class, 'adminCreateAdminAccount']);
    Route::middleware('role:3')->post('/admin/create_endorser_account', [AdminController::class, 'adminCreateEndorserAccount']);


    // User Management

    Route::middleware('role:3')->get('/admin_view_all_portfolio', [AdminController::class, 'adminViewAllPortfolio']);
    Route::middleware('role:3')->get('/admin_view_all_project', [AdminController::class, 'adminViewAllProject']);
    Route::middleware('role:3')->get('/users', [AdminController::class, 'viewAllUser']);
    Route::middleware('role:3')->post('/update_user_role/{google_id}', [AdminController::class, 'updateUserRole']);
    Route::middleware('role:3')->post('/admin_change_password', [AdminController::class, 'adminChangePassword']);
    Route::middleware('role:3')->put('/ban_user/{google_id}', [AdminController::class, 'banUser']);
    Route::middleware('role:3')->get('/admin_search_portfolio/{name}', [AdminController::class, 'adminSearchPortfolio']);
    Route::middleware('role:3')->post('/admin/logout', [AuthController::class, 'adminLogout']);
    Route::middleware('role:3')->get('/admin_view_employment_rate', [AdminController::class, 'viewEmploymentRate']);
    Route::middleware('role:3')->get('/admin_view_top_10_job_title', [AdminController::class, 'viewTop10JobTitle']);
    Route::middleware('role:3')->get('/admin_view_top_10_companies', [AdminController::class, 'viewTop10Companies']);

    Route::middleware('role:3')->get('/admin_view_project_detail/{project_id}', [AdminController::class, 'viewProjectDetail']);
    Route::middleware('role:3')->get('/admin_view_portfolio_detail/{google_id}', [AdminController::class, 'viewPortfolioDetail']);
    Route::middleware('role:3')->get('/admin_search_portfolio', [AdminController::class, 'adminSearchPortfolio']);
    Route::middleware('role:3')->get('/admin_search_project', [AdminController::class, 'adminSearchProject']);
    Route::middleware('role:3')->get('/admin_search_user', [AdminController::class, 'adminSearchUser']);

    Route::middleware('role:3')->get('/admin_view_all_endorser_request', [AdminController::class, 'viewAllEndorserRequest']);
    Route::middleware('role:3')->get('/admin_view_endorser_request_detail/{id}', [AdminController::class, 'viewEndorserRequestDetail']);
    Route::middleware('role:3')->put('/admin_update_endorser_request/{id}', [AdminController::class, 'updateEndorserRequest']);


    Route::middleware('role:3')->get('/view_all_admin', [AdminController::class, 'viewAllAdmin']);
    Route::middleware('role:3')->delete('/remove_admin/{id}', [AdminController::class, 'removeAdmin']);

   
    Route::middleware('role:3')->post('/create_major', [MajorController::class, 'createMajor']);
    Route::middleware('role:3')->put('/update_major/{id}', [MajorController::class, 'updateMajor']);
    Route::middleware('role:3')->delete('/delete_major/{id}', [MajorController::class, 'deleteMajor']);
});
