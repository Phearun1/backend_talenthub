<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Laravel\Sanctum\PersonalAccessToken;

class CheckTokenExpiration
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Retrieve the token from the request
        $token = $request->bearerToken();

        if (!$token) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        // Check if the token is expired
        $accessToken = PersonalAccessToken::where('token', hash('sha256', $token))->first();
        
        if ($accessToken && Carbon::now()->greaterThan($accessToken->expires_at)) {
            return response()->json(['error' => 'Token has expired'], 401);
        }

        return $next($request);
    }
}
