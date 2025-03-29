<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\AchievementController;
use App\Http\Controllers\ExperienceController;
use App\Http\Controllers\PortfolioController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\SkillController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EducationController;
use Illuminate\Support\Facades\Route;


// Public route for Google login
Route::post('/login_google_test', [AuthController::class, 'loginWithGoogleTest']);
Route::post('/login_google', [AuthController::class, 'loginWithGoogle']);

Route::post('/admin_login', [AuthController::class, 'adminLogin']);



Route::get('/users', [UserController::class, 'view_all_user']);


//view achievement detail
Route::get('view_achievement_detail/{id}', [AchievementController::class, 'viewAchievementDetail']);

// View a specific experience by ID
Route::get('/view_experience/{id}', [ExperienceController::class, 'viewExperience']);

// View all portfolios
// Route::get('/view_all_portfolio', [PortfolioController::class, 'viewAllPortfolio']);
// Route::get('/view_portfolio_details/{userID}', [PortfolioController::class, 'viewPortfolioDetails']);

// view all projects
Route::get('/view_project_detail/{projectId}', [ProjectController::class, 'viewProjectDetail']);


Route::get('/view_education_detail/{id}', [EducationController::class, 'viewEducationDetail']);

Route::middleware(['cors'])->get('/view_all_portfolio', [PortfolioController::class, 'viewAllPortfolio']);
Route::middleware(['cors'])->get('/view_portfolio_details/{userID}', [PortfolioController::class, 'viewPortfolioDetails']);


Route::middleware('auth:sanctum', 'token.expiration')->group(function () {

    // Protected route for logout (requires authentication via Sanctum)
    Route::post('/logout', [AuthController::class, 'logout']);


    // User route

    Route::middleware('role:1')->post('/create_company', [ExperienceController::class, 'createCompany']);

    // Create an experience
    Route::middleware('role:1')->post('/create_experience', [ExperienceController::class, 'createExperience']);



    //skill

    Route::middleware('auth:sanctum')->post('/create_skill', [SkillController::class, 'createSkill']);  // Create skill
    Route::middleware('auth:sanctum')->put('/update_skill/{id}', [SkillController::class, 'editSkill']);  // Edit skill
    Route::middleware('auth:sanctum')->delete('/delete_skill/{id}', [SkillController::class, 'deleteSkill']);  // Delete skill


    Route::middleware('auth:sanctum')->post('/create_project', [ProjectController::class, 'createProject']);
    Route::middleware('auth:sanctum')->put('/update_project/{id}', [ProjectController::class, 'updateProject']);
    Route::middleware('auth:sanctum')->delete('/delete_project/{id}', [ProjectController::class, 'deleteProject']);


    // Achievements
    // Create Achievement
    Route::middleware('auth:sanctum')->post('/create_achievement', [AchievementController::class, 'createAchievement']);

    // Update Achievement by ID
    Route::middleware('auth:sanctum')->post('/update_achievement/{id}', [AchievementController::class, 'updateAchievement']);
    // Delete Achievement by ID
    Route::middleware('auth:sanctum')->delete('/delete_achievement/{id}', [AchievementController::class, 'deleteAchievement']);



    Route::middleware('auth:sanctum')->post('/create_education', [EducationController::class, 'createEducation']);

    Route::middleware('auth:sanctum')->put('/update_education/{id}', [EducationController::class, 'updateEducation']);
    Route::middleware('auth:sanctum')->delete('/delete_education/{id}', [EducationController::class, 'deleteEducation']);






    // Endorser route






    // Admin route 
    Route::middleware('role:3')->post('/admin/create_admin_account', [AuthController::class, 'addCreateAdminAccount']);
    Route::middleware('role:3')->post('/admin/create_endorser_account', [AuthController::class, 'adminCreateEndorserAccount']);
    Route::middleware('role:3')->post('/admin/logout', [AuthController::class, 'adminLogout']);
});
