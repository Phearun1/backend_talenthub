<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\AchievementController;
use App\Http\Controllers\ExperienceController;
use App\Http\Controllers\PortfolioController;
use Illuminate\Support\Facades\Route;


// Public route for Google login
Route::post('/login_google', [AuthController::class, 'loginWithGoogle']);
Route::post('/admin_login', [AuthController::class, 'adminLogin']);




//view achievement
Route::get('view_achievement/{id}', [AchievementController::class, 'viewAchievement']);

// View a specific experience by ID
Route::get('/view_experience/{id}', [ExperienceController::class, 'viewExperience']);

// View all portfolios
Route::get('/view_all_portfolio', [PortfolioController::class, 'viewAllPortfolio']);
Route::get('/view_portfolio_details', [PortfolioController::class, 'viewPortfolioDetails']);




Route::middleware('auth:sanctum', 'token.expiration')->group(function () {
    
    // Protected route for logout (requires authentication via Sanctum)
    Route::post('/logout', [AuthController::class, 'logout']);
    

    // User route

    Route::middleware('role:1')->post('/create_company', [ExperienceController::class, 'createCompany']);

    // Create an experience
    Route::middleware('role:1')->post('/create_experience', [ExperienceController::class, 'createExperience']);

    






    // Achievements
    // Create Achievement
    Route::post('/create_achievement', [AchievementController::class, 'createAchievement']);

    // Update Achievement by ID
    Route::put('/update_achievement/{id}', [AchievementController::class, 'updateAchievement']);

    // Delete Achievement by ID
    Route::delete('/delete_achievement/{id}', [AchievementController::class, 'deleteAchievement']);








    // Endorser route
    





    // Admin route 
    Route::middleware('role:3')->post('/admin/create_admin_account', [AuthController::class, 'addCreateAdminAccount']);
    Route::middleware('role:3')->post('/admin/create_endorser_account', [AuthController::class, 'adminCreateEndorserAccount']);
    Route::middleware('role:3')->post('/admin/logout', [AuthController::class, 'adminLogout']);

});
