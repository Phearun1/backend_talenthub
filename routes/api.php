<?php

use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

Route::middleware('api')->group(function () {
    // Public route for Google login
    Route::post('/login_google', [AuthController::class, 'loginWithGoogle']);
    
    // Protected route for logout (requires authentication via Sanctum)
    Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);
});
