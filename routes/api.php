<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\AchievementController;
use App\Http\Controllers\PortfolioController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\SkillController;
use App\Http\Controllers\ExperienceController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EducationController;
use Illuminate\Support\Facades\Route;


// Public route for Google login
Route::post('/login_google', [AuthController::class, 'loginWithGoogle']);
Route::post('/admin_login', [AuthController::class, 'adminLogin']);



Route::get('/users', [UserController::class, 'view_all_user']);


// view all projects


Route::middleware([\Fruitcake\Cors\HandleCors::class])->group(function () {

    Route::get('/view_all_portfolio', [PortfolioController::class, 'viewAllPortfolio']);
    Route::get('/view_portfolio_details/{userID}', [PortfolioController::class, 'viewPortfolioDetails']);
    Route::get('/view_project_detail/{id}', [ProjectController::class, 'viewProjectDetail']);
    Route::get('view_achievement_detail/{id}', [AchievementController::class, 'viewAchievementDetail']);
});




Route::middleware('auth:sanctum', 'token.expiration')->group(function () {

    // Protected route for logout (requires authentication via Sanctum)
    Route::post('/logout', [AuthController::class, 'logout']);


    // User route

    Route::middleware('role:1')->post('/create_company', [ExperienceController::class, 'createCompany']);




    //skill

    Route::middleware('auth:sanctum')->post('/create_skill', [SkillController::class, 'createSkill']);  // Create skill
    Route::middleware('auth:sanctum')->put('/update_skill/{id}', [SkillController::class, 'updateSkill']);  // Edit skill
    Route::middleware('auth:sanctum')->delete('/delete_skill/{id}', [SkillController::class, 'deleteSkill']);  // Delete skill



    // project
    Route::middleware('auth:sanctum')->post('/create_project', [ProjectController::class, 'createProject']);
    Route::middleware('auth:sanctum')->put('/update_project/{id}', [ProjectController::class, 'updateProject']);
    Route::middleware('auth:sanctum')->delete('/delete_project/{id}', [ProjectController::class, 'deleteProject']);


    // Achievements 
    Route::middleware('auth:sanctum')->post('/create_achievement', [AchievementController::class, 'createAchievement']);
    Route::middleware('auth:sanctum')->put('/update_achievement/{id}', [AchievementController::class, 'updateAchievement']);
    Route::middleware('auth:sanctum')->delete('/delete_achievement/{id}', [AchievementController::class, 'deleteAchievement']);


    //education
    Route::middleware('auth:sanctum')->post('/create_education', [EducationController::class, 'createEducation']);
    Route::middleware('auth:sanctum')->put('/update_education/{id}', [EducationController::class, 'updateEducation']);
    Route::middleware('auth:sanctum')->delete('/delete_education/{id}', [EducationController::class, 'deleteEducation']);



    // Experience

    Route::post('/create_experience', [ExperienceController::class, 'createExperience']);

    // Edit an existing experience
    Route::put('/update_experience/{id}', [ExperienceController::class, 'updateExperience']);

    // Delete an experience
    Route::delete('/delete_experience/{id}', [ExperienceController::class, 'deleteExperience']);



    // Endorser route






    // Admin route 
    Route::middleware('role:3')->post('/admin/create_admin_account', [AuthController::class, 'addCreateAdminAccount']);
    Route::middleware('role:3')->post('/admin/create_endorser_account', [AuthController::class, 'adminCreateEndorserAccount']);
    Route::middleware('role:3')->post('/admin/logout', [AuthController::class, 'adminLogout']);
});
