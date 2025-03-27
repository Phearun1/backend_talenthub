<?php


namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    // Method to view all users
    public function view_all_user()
    {
        // Fetch all users from the 'users' table
        $users = DB::table('users')->get();	

        // Return the list of users as a JSON response
        return response()->json($users);
    }
}
