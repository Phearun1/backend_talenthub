<?php

use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;


// Public route for Google login
Route::post('/login_google', [AuthController::class, 'loginWithGoogle']);
Route::post('/admin_login', [AuthController::class, 'adminLogin']);

Route::middleware('auth:sanctum')->group(function () {
    
    // Protected route for logout (requires authentication via Sanctum)
    Route::post('/logout', [AuthController::class, 'logout']);
    


    // User route








    // Endorser route
    





    // Admin route 
    Route::middleware('role:3')->post('/admin/create_admin_account', [AuthController::class, 'addCreateAdminAccount']);
    Route::middleware('role:3')->post('/admin/create_endorser_account', [AuthController::class, 'adminCreateEndorserAccount']);
    Route::middleware('role:3')->post('/admin/logout', [AuthController::class, 'adminLogout']);

});
