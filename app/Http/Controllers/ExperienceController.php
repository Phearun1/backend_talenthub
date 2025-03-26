<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ExperienceController extends Controller
{
    public function createCompany(Request $request){
        
        // Validate the incoming request data
        $request->validate([
            'company_name' => 'required|string|max:255',
        ]);

        if(!$request) {
            return response()->json(['error' => 'Invalid request data'], 400);
        }   

        $company = DB::table('companies')->insert([
            'company_name' => $request->company_name,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json(['message' => 'Company created successfully'], 201);
    }



    public function createExperience(Request $request)
    {
        // Validate the incoming request data
        $request->validate([
            'portfolio_id' => 'required|integer',
            'work_title' => 'required|string|max:255', 
            'company_id' => 'required|integer',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'description' => 'nullable|string|max:255',
        ]);

        if(!$request) {
            return response()->json(['error' => 'Invalid request data'], 400);
        }

        // Insert the experience into the database
        $experience = DB::table('experiences')->insert([
            'portfolio_id' => $request->portfolio_id,
            'work_title' => $request->work_title, // Corrected column name
            'company_id' => $request->company_id,
            'start_date' => $request->start_date,
            'end_date' => $request->end_date,
            'description' => $request->description,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Return a success response
        return response()->json(['message' => 'Experience created successfully'], 201);
    }

    // public function viewAllExperience(){
    //     // Fetch all experiences from the database
    //     $experiences = DB::table('experiences')->get();

    //     // Return the experiences
    //     return response()->json($experiences, 200);
    // }

    public function viewExperience($id)
    {
        // Fetch the experience from the database
        $experience = DB::table('experiences')->where('id', $id)->first();

        // Check if the experience exists
        if (!$experience) {
            return response()->json(['error' => 'Experience not found'], 404);
        }

        // Return the experience
        return response()->json($experience, 200);
    }




}
