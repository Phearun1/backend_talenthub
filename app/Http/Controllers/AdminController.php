<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Models\Admin;
use App\Models\User;

class AdminController extends Controller
{
    
    public function adminCreateEndorserAccount(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid or existing email'], 400);
        }

        $user = User::create([
            'email' => $request->email,
            'name' => null, // No name initially
            'photo' => null,
            'google_id' => null,
            'role_id' => 2, // Endorser role
        ]);

        return response()->json(['message' => 'Success', 'user' => $user]);
    }

   
    public function adminCreateAdminAccount(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
    
        // Validate the admin input for the admin email
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:admins,email',
            'name' => 'required|string|max:255',
            'password' => 'required|string|min:8',
            'password_confirmation' => 'required|same:password',
        ]);
    
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }
    
        // Create the admin with email and password
        $admin = Admin::create([
            'email' => $request->email,
            'name' => $request->name,
            'password' => Hash::make($request->password), // Hash the provided password
            'role_id' => 3, // Admin role
            'photo' => null, // Default photo is set to null
        ]);
    

        return response()->json([
            'message' => 'Admin account created successfully',
            'admin' => [
                'id' => $admin->id,
                'email' => $admin->email,
                'name' => $admin->name,
                'role_id' => $admin->role_id,
            ]
        ], 201);
    }

    public function adminChangePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'old_password' => 'required|string',
            'new_password' => 'required|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid password'], 400);
        }

        $admin = $request->user();
        if (!Hash::check($request->old_password, $admin->password)) {
            return response()->json(['error' => 'Old password is incorrect'], 400);
        }

        $admin->password = Hash::make($request->new_password);
        $admin->save();

        return response()->json(['message' => 'Password changed successfully']);
    }

    public function viewAllUser(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 10; // Fixed number of users per page

        // Fetch users with pagination
        $users = DB::table('users')
            ->leftJoin('portfolios', 'users.google_id', '=', 'portfolios.user_id')
            ->select(
                'users.id',
                'users.email',
                'users.name',
                'users.photo',
                'users.google_id',
                'users.role_id',
                'users.status',
                'portfolios.phone_number',
                'portfolios.about',
                'users.created_at',
                'users.updated_at'
            )
            ->orderBy('users.created_at', 'desc') // Order by most recently created
            ->skip(($page - 1) * $perPage) // Skip previous pages
            ->take($perPage) // Take only perPage number of records
            ->get();

        return response()->json($users);
    }

    public function updateUserRole(Request $request, $google_id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Validate request
        $validator = Validator::make($request->all(), [
            'role_id' => 'required|integer|in:1,2,3', // Only allow valid role IDs (1=Student, 2=Endorser, 3=Admin)
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Get the user by Google ID instead of internal ID
        $user = User::where('google_id', $google_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Get the original role for the response
        $originalRole = $user->role_id;

        // Map role IDs to role names for the response
        $roleNames = [
            1 => 'Student',
            2 => 'Endorser',
            3 => 'Admin'
        ];

        // Update the role
        $user->role_id = $request->role_id;
        $user->save();

        // Return success response with before/after details
        return response()->json([
            'message' => 'User role updated successfully',
            'id' => $user->id,
            'google_id' => $user->google_id,
            'name' => $user->name,
            'email' => $user->email,
            'role_id' => $user->role_id,
        ]);
    }


    public function banUser(Request $request, $google_id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Find the user by Google ID instead of internal ID
        $user = User::where('google_id', $google_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Ban the user by setting their status to 0 (banned)
        $user->status = 0;
        $user->save();

        return response()->json([
            'message' => 'User banned successfully',
            'id' => $user->id,
            'google_id' => $user->google_id,
            'email' => $user->email,
            'name' => $user->name,
            'status' => $user->status
        ]);
    }

    public function adminSearchPortfolio(Request $request)
    {
        $searchTerm = $request->input('name');

        $portfolios = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id',
                'portfolios.major_id as major',
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'users.status as status',
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as name',
                'users.email',
                'users.role_id as role',
                'users.photo'
            )
            ->where('users.name', 'LIKE', '%' . $searchTerm . '%')
            ->get();

        return response()->json($portfolios);
    }



    public function adminViewAllPortfolio(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
    
        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 2; // Fixed number of portfolios per page
    
        // Fetch portfolios with pagination
        $portfolios = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id',
                'portfolios.major_id as major',
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'users.status as status',
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as name',
                'users.email',
                'users.photo',
                'users.role_id as role'
            )
            ->orderBy('portfolios.updated_at', 'desc') // Order by most recently updated
            ->skip(($page - 1) * $perPage) // Skip previous pages
            ->take($perPage) // Take only perPage number of records
            ->get();
    
        return response()->json($portfolios);
    }
    
   
    public function adminViewAllProject(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
    
        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 2; // Fixed number of projects per page
    
        // Fetch projects with pagination
        $projects = DB::table('projects')
            ->join('portfolios', 'projects.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'projects.id as project_id',
                'projects.portfolio_id',
                'projects.title',
                'projects.description',
                'projects.project_visibility_status',
                'projects.created_at',
                'projects.updated_at',
                'users.name as user_name',
                'users.google_id as user_google_id',
                'users.email as user_email'
            )
            ->orderBy('projects.updated_at', 'desc')
            ->skip(($page - 1) * $perPage)
            ->take($perPage)
            ->get();
        
        // Get all project IDs
        $projectIds = $projects->pluck('project_id')->toArray();
        
        // Fetch images for these projects
        $projectImages = DB::table('project_images')
            ->whereIn('project_id', $projectIds)
            ->select('id', 'project_id', 'image')
            ->get()
            ->groupBy('project_id');
        
        // Attach images to their respective projects
        $projectsWithImages = $projects->map(function($project) use ($projectImages) {
            $projectId = $project->project_id;
            $project->images = $projectImages->get($projectId, collect([]))->map(function($image) {
                return [
                    'id' => $image->id,
                    'image_url' => $image->image
                ];
            })->values();
            
            return $project;
        });
    
        return response()->json($projectsWithImages);
    }




    public function viewEmploymentRate()
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if (auth()->user() && auth()->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Get number of employed students (working_status = 1) who are not banned (status = 1)
        $employedUsers = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->where('portfolios.working_status', 1)
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->count();

        // Get number of unemployed students (working_status = 2) who are not banned (status = 1)
        $unemployedUsers = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->where('portfolios.working_status', 2)
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->count();

        // Return data in exactly the requested format
        return response()->json([
            ['name' => 'Employed', 'value' => $employedUsers],
            ['name' => 'Unemployed', 'value' => $unemployedUsers]
        ]);
    }


    public function viewTop10JobTitle()
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if (auth()->user() && auth()->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Query to get top 10 job titles and count of students 
        $topJobTitles = DB::table('experiences')
            ->join('portfolios', 'experiences.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'experiences.work_title as title',  // Changed from 'experiences.title' to 'experiences.work_title'
                DB::raw('COUNT(DISTINCT portfolios.user_id) as students')
            )
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->whereNotNull('experiences.work_title')  // Changed from 'experiences.title' to 'experiences.work_title'
            ->groupBy('experiences.work_title')  // Changed from 'experiences.title' to 'experiences.work_title'
            ->orderBy('students', 'desc')
            ->take(10)
            ->get()
            ->map(function ($item) {
                return [
                    'title' => $item->title,
                    'students' => (int)$item->students  // Ensure students is returned as an integer
                ];
            });

        return response()->json($topJobTitles);
    }

    public function viewTop10Companies()
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if (auth()->user() && auth()->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Query to get top 10 companies and count of students
        $topCompanies = DB::table('experiences')
            ->join('companies', 'experiences.company_id', '=', 'companies.id')
            ->join('portfolios', 'experiences.portfolio_id', '=', 'portfolios.id')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'companies.company_name as title',
                DB::raw('COUNT(DISTINCT portfolios.user_id) as students')
            )
            ->where('users.role_id', 1) // Only include students (role_id = 1)
            ->where('users.status', 1)  // Only include unbanned students
            ->groupBy('companies.company_name')
            ->orderBy('students', 'desc')
            ->take(10)
            ->get()
            ->map(function ($item) {
                return [
                    'title' => $item->title,
                    'students' => (int)$item->students  // Ensure students is returned as an integer
                ];
            });

        return response()->json($topCompanies);
    }

    public function viewPortfolioDetail(Request $request, $google_id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }
    
        // Find the user by Google ID
        $user = User::where('google_id', $google_id)->first();
    
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }
    
        $portfolio = DB::table('portfolios')
            ->join('users', 'portfolios.user_id', '=', 'users.google_id')
            ->select(
                'portfolios.id',
                'portfolios.user_id as google_id',
                'portfolios.major_id as major',
                'portfolios.phone_number',
                'portfolios.about',
                'portfolios.working_status',
                'users.status as status',
                'portfolios.created_at',
                'portfolios.updated_at',
                'users.name as user_name',
                'users.email',
                'users.photo',
                'users.role_id'
            )
            ->where('portfolios.user_id', $google_id)
            ->first();
    
        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }
    
        // Check if user has been banned (status = 0)
        // if ($portfolio->status === 0) {
        //     return response()->json([
        //         'error' => 'The user portfolio has been banned.',
        //         'status' => 0
        //     ], 200);
        // }
    
        $portfolioId = $portfolio->id;
    
        // Get projects that the user owns
        $ownedProjects = DB::table('projects')
            ->select(
                'projects.id as project_id',
                'projects.portfolio_id',
                'projects.title',
                'projects.project_visibility_status'
            )
            ->where('projects.portfolio_id', $portfolioId)
            ->get()
            ->map(function ($project) {
                return [
                    'project_id' => $project->project_id,
                    'portfolio_id' => $project->portfolio_id,
                    'title' => $project->title,
                    'project_visibility_status' => $project->project_visibility_status,
                    'is_owner' => 0  // User is the owner
                ];
            })
            ->toArray();
    
        // Get projects where the user is a collaborator
        $collaboratedProjects = DB::table('project_collaborators')
            ->join('projects', 'project_collaborators.project_id', '=', 'projects.id')
            ->leftJoin('project_collaborator_invitation_statuses', function ($join) use ($google_id) {
                $join->on('project_collaborator_invitation_statuses.project_id', '=', 'projects.id')
                    ->where('project_collaborator_invitation_statuses.collaborator_id', '=', $google_id);
            })
            ->where('project_collaborators.user_id', $google_id)
            ->where(function ($query) {
                // Only include projects where the invitation was accepted (status 2) or null (for backwards compatibility)
                $query->where('project_collaborator_invitation_statuses.project_collab_status_id', 2)
                    ->orWhereNull('project_collaborator_invitation_statuses.project_collab_status_id');
            })
            ->select(
                'projects.id as project_id',
                'projects.portfolio_id',
                'projects.title',
                'projects.project_visibility_status'
            )
            ->distinct()
            ->get()
            ->map(function ($project) {
                return [
                    'project_id' => $project->project_id,
                    'portfolio_id' => $project->portfolio_id,
                    'title' => $project->title,
                    'project_visibility_status' => $project->project_visibility_status,
                    'is_owner' => 1  // User is a collaborator
                ];
            })
            ->toArray();
    
        // Merge the owned and collaborated projects
        $projects = array_merge($ownedProjects, $collaboratedProjects);
    
        // Get other related data like education, achievements, skills, etc.
        $education = DB::table('education')->where('portfolio_id', $portfolioId)->get();
        $achievements = DB::table('achievements')->where('portfolio_id', $portfolioId)->get();
        $skills = DB::table('skills')->where('portfolio_id', $portfolioId)->get();
        $experiences = DB::table('experiences')->where('portfolio_id', $portfolioId)->get();
    
        // Modify experiences and achievements if needed, as done earlier
        foreach ($experiences as $experience) {
            $company = DB::table('companies')->where('id', $experience->company_id)->first();
            $experience->company_name = $company ? $company->company_name : 'Unknown';
            unset($experience->company_id);
    
            $rawEndorsers = DB::table('experience_endorsers')
                ->join('users', 'experience_endorsers.user_id', '=', 'users.google_id')
                ->join('experience_endorsement_statuses', function ($join) use ($experience) {
                    $join->on('experience_endorsement_statuses.endorser_id', '=', 'experience_endorsers.user_id')
                        ->where('experience_endorsement_statuses.experience_id', '=', $experience->id);
                })
                ->join('endorsement_statuses', 'experience_endorsement_statuses.experience_status_id', '=', 'endorsement_statuses.id')
                ->select(
                    'users.google_id as id',
                    'users.name',
                    'users.email',
                    'users.photo',
                    'endorsement_statuses.status as status',
                    'endorsement_statuses.id as status_id'
                )
                ->where('experience_endorsers.experience_id', $experience->id)
                ->get();
    
            $experience->endorsers = collect($rawEndorsers)
                ->unique('id')
                ->values();
        }
    
        foreach ($achievements as $achievement) {
            $achievement->endorsers = DB::table('achievement_endorsers')
                ->join('users', 'achievement_endorsers.user_id', '=', 'users.google_id')
                ->join('achievement_endorsement_statuses', function ($join) use ($achievement) {
                    $join->on('achievement_endorsement_statuses.endorser_id', '=', 'achievement_endorsers.user_id')
                        ->where('achievement_endorsement_statuses.achievement_id', '=', $achievement->id);
                })
                ->join('endorsement_statuses', 'achievement_endorsement_statuses.endorsement_status_id', '=', 'endorsement_statuses.id')
                ->select('users.google_id as id', 'users.name', 'users.email', 'users.photo', 'endorsement_statuses.status as status', 'endorsement_statuses.id as status_id')
                ->distinct()
                ->get();
        }
    
        // Add skill endorsers with endorsement statuses
        foreach ($skills as $skill) {
            $skill->endorsers = DB::table('skill_endorsement_statuses')
                ->join('users', 'skill_endorsement_statuses.endorser_id', '=', 'users.google_id')
                ->join('endorsement_statuses', 'skill_endorsement_statuses.endorsement_status_id', '=', 'endorsement_statuses.id')
                ->select(
                    'users.google_id as id',
                    'users.name as name',
                    'users.email as email',
                    'users.photo',
                    'endorsement_statuses.id as status_id',
                    'endorsement_statuses.status as status'
                )
                ->where('skill_endorsement_statuses.skill_id', $skill->id)
                ->distinct()  // Ensure distinct records
                ->get();
        }
    
        // Return the response with all the data
        return response()->json([
            'portfolio' => $portfolio,
            'projects' => $projects,
            'education' => $education,
            'achievements' => $achievements,
            'skills' => $skills,
            'experiences' => $experiences,
        ]);
    }

    public function viewProjectDetail(Request $request, $project_id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Fetch the project details
        $project = DB::table('projects')
            ->where('id', $project_id)
            ->first();

        if (!$project) {
            return response()->json(['error' => 'Project not found'], 404);
        }

        return response()->json($project);


        


        
    }
}
