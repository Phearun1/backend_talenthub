<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  ...$roles
     * @return \Illuminate\Http\Response
     */
    public function handle(Request $request, Closure $next, ...$roles)
    {
        // Get the current authenticated user
        $user = Auth::user();

        // Check if the user's role matches the required role(s)
        if (!$user || !in_array($user->role_id, $roles)) {
            return response()->json(['error' => 'Forbidden'], 403); // Forbidden access
        }

        return $next($request);
    }
}
