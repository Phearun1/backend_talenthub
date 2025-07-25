<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class PortfolioController extends Controller
{

    public function viewAllPortfolio(Request $request)
    {
        $page = $request->input('page', 1); // Default page to 1 if not provided
        $perPage = 20; // Fixed number of portfolios per page

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
            ->where('users.status', '=', 1) // Only show active users (status = 1)
            ->orderBy('portfolios.updated_at', 'desc') // Order by most recently updated
            ->skip(($page - 1) * $perPage) // Skip previous pages
            ->take($perPage) // Take only perPage number of records
            ->get();

        return response()->json($portfolios);
    }


    public function viewPortfolioDetails($userID)
    {
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
            ->where('portfolios.user_id', $userID)
            ->first();

        if (!$portfolio) {
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Check if user has been banned (status = 0)
        if ($portfolio->status === 0) {
            return response()->json([
                'error' => 'The user portfolio has been banned.',
                'status' => 0
            ], 200);
        }

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
            ->leftJoin('project_collaborator_invitation_statuses', function ($join) use ($userID) {
                $join->on('project_collaborator_invitation_statuses.project_id', '=', 'projects.id')
                    ->where('project_collaborator_invitation_statuses.collaborator_id', '=', $userID);
            })
            ->where('project_collaborators.user_id', $userID)
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



    public function updatePortfolio(Request $request, $id)
    {
        // Log the raw input data for debugging
        // Log::info('Raw Request Data: ', $request->all());

        // Validate input fields
        $request->validate([
            'major_id' => 'nullable|integer',
            'phone_number' => 'nullable|string|max:255',
            'about' => 'nullable|string',
            'working_status' => 'nullable|integer',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:4096', // Validate photo as an image
        ]);

        // Get the authenticated user (via the token)
        $user = $request->user();  // This will return the authenticated user based on the token

        // Find the portfolio by ID
        $portfolio = DB::table('portfolios')->where('id', $id)->first();

        if (!$portfolio) {
            // Log::error('Portfolio not found for ID: ' . $id);
            return response()->json(['error' => 'Portfolio not found.'], 404);
        }

        // Ensure the authenticated user is the owner of the portfolio
        if ($portfolio->user_id !== $user->google_id) {
            // Log::error('Unauthorized access attempt for portfolio ID: ' . $id);
            return response()->json(['error' => 'You are not authorized to update this portfolio.'], 403);
        }

        // Log the user_id for tracking
        // Log::info('User ID for the portfolio: ' . $user->google_id);

        // Prepare fields to update in the portfolios table
        $updateFields = [
            'major_id' => $request->input('major_id', $portfolio->major_id),
            'phone_number' => $request->input('phone_number', $portfolio->phone_number),
            'about' => $request->input('about', $portfolio->about),
            'working_status' => $request->input('working_status', $portfolio->working_status),
            'updated_at' => now(),
        ];

        // Log the fields being updated
        // Log::info('Updating portfolio with the following fields: ', $updateFields);

        // Update the portfolio details
        DB::table('portfolios')->where('id', $id)->update($updateFields);

        // Log after portfolio update
        // Log::info('Portfolio updated successfully for ID: ' . $id);

        // Handle photo update if provided
        $photoUrl = null;
        if ($request->hasFile('photo')) {
            $photo = $request->file('photo');

            // Check if the file is uploaded and valid
            if ($photo->isValid()) {
                // Log the photo upload process
                // Log::info('Photo uploaded: ' . $photo->getClientOriginalName());

                // Delete the old image if it exists
                if ($user->photo) {  // Check if the user already has a photo
                    $oldPhotoPath = str_replace(asset('storage/'), 'public/', $user->photo);  // Convert URL to file path
                    $oldFilePath = storage_path('app/' . $oldPhotoPath);

                    // Delete the old image if it exists
                    if (file_exists($oldFilePath)) {
                        unlink($oldFilePath); // Delete the old file
                        // Log::info('Deleted old photo from storage: ' . $oldFilePath);
                    } else {
                        // Log::warning('Old photo not found for deletion: ' . $oldFilePath);
                    }
                }

                // Store the new photo in 'photos' folder under 'public' disk
                $photoPath = $photo->store('photos', 'public');

                // Base URL for accessing the photo
                $baseUrl = 'https://api-talenthub.paragoniu.app/storage/';

                // Construct the photo URL
                $photoUrl = $baseUrl . 'photos/' . basename($photoPath);

                // Log the photo URL
                // Log::info('New Photo URL: ' . $photoUrl);

                // Update the user's photo in the users table
                DB::table('users')->where('google_id', $user->google_id)->update([
                    'photo' => $photoUrl,
                    'updated_at' => now(),
                ]);

                // Log user photo update
                // Log::info('User photo updated for user ID: ' . $user->google_id);
            } else {
                // Log::error('Uploaded photo is not valid.');
            }
        }

        // Fetch the updated portfolio
        $updatedPortfolio = DB::table('portfolios')->where('id', $id)->first();

        // Fetch the updated user details
        $updatedUser = DB::table('users')->where('google_id', $user->google_id)->first();

        // Log the updated portfolio and user details
        // Log::info('Updated Portfolio: ', (array) $updatedPortfolio);
        // Log::info('Updated User: ', (array) $updatedUser);

        // Return only the desired fields (portfolio and user) without additional structure
        return response()->json([
            'id' => $updatedPortfolio->id,
            'google_id' => $updatedPortfolio->user_id,
            'name' => $updatedUser->name,
            'email' => $updatedUser->email,
            'major_id' => $updatedPortfolio->major_id,
            'phone_number' => $updatedPortfolio->phone_number,
            'about' => $updatedPortfolio->about,
            'working_status' => $updatedPortfolio->working_status,
            'status' => $updatedUser->status, // Changed from portfolio status to user status
            'photo' => $photoUrl ? $photoUrl : $updatedUser->photo // Return updated photo URL
        ], 200);
    }





    public function deletePortfolio($id)
    {
        $portfolio = DB::table('portfolios')->where('id', $id)->delete();
        return response()->json($portfolio);
    }


    public function searchPortfolio(Request $request)
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
            ->where('users.status', '=', 1) // Only show active users
            ->get();

        return response()->json($portfolios);
    }

    public function removeEndorsement(Request $request)
    {
        try {
            // Get authenticated user from bearer token
            $authenticatedUser = $request->user();
            if (!$authenticatedUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized. Please provide a valid bearer token.'
                ], 401);
            }
    
            // Check if user is endorser (role_id = 2)
            if ($authenticatedUser->role_id != 2) {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. Endorser privileges required.'
                ], 403);
            }
    
            // Validate the request
            $request->validate([
                'type' => 'required|integer|in:1,2,3,4', // 1=skill, 2=experience, 3=achievement, 4=project
                'id' => 'required|integer|min:1'
            ]);
    
            $type = $request->input('type');
            $itemId = $request->input('id');
            $endorserUserId = $authenticatedUser->google_id; // Using google_id as user identifier
    
            // Determine table configurations based on type
            $tableMap = [
                1 => [
                    'endorser_table' => 'skill_endorsers',
                    'status_table' => 'skill_endorsement_statuses',
                    'item_column' => 'skill_id',
                    'type_name' => 'skill'
                ],
                2 => [
                    'endorser_table' => 'experience_endorsers',
                    'status_table' => 'experience_endorsement_statuses',
                    'item_column' => 'experience_id',
                    'type_name' => 'experience'
                ],
                3 => [
                    'endorser_table' => 'achievement_endorsers',
                    'status_table' => 'achievement_endorsement_statuses',
                    'item_column' => 'achievement_id',
                    'type_name' => 'achievement'
                ],
                4 => [
                    'endorser_table' => 'project_endorsers',
                    'status_table' => 'project_endorsement_statuses',
                    'item_column' => 'project_id',
                    'type_name' => 'project'
                ]
            ];
    
            $tableInfo = $tableMap[$type];
            $endorserTable = $tableInfo['endorser_table'];
            $statusTable = $tableInfo['status_table'];
            $itemColumn = $tableInfo['item_column'];
            $typeName = $tableInfo['type_name'];
    
            // Use database transaction
            DB::beginTransaction();
    
            try {
                // Check if endorser record exists
                $endorserRecord = DB::table($endorserTable)
                    ->where($itemColumn, $itemId)
                    ->where('user_id', $endorserUserId)
                    ->first();
    
                if (!$endorserRecord) {
                    DB::rollBack();
                    return response()->json([
                        'success' => false,
                        'message' => "You have not endorsed this {$typeName}"
                    ], 404);
                }
    
                // Remove from endorser table
                $deletedFromEndorser = DB::table($endorserTable)
                    ->where($itemColumn, $itemId)
                    ->where('user_id', $endorserUserId)
                    ->delete();
    
                // Remove from status table (using the correct column name for each type)
                $statusColumnMap = [
                    1 => 'endorsement_status_id', // skill
                    2 => 'experience_status_id',  // experience  
                    3 => 'endorsement_status_id', // achievement
                    4 => 'endorsement_status_id'  // project
                ];
    
                $statusColumn = $statusColumnMap[$type];
    
                $deletedFromStatus = DB::table($statusTable)
                    ->where($itemColumn, $itemId)
                    ->where('endorser_id', $endorserUserId)
                    ->delete();
    
                DB::commit();
    
                if ($deletedFromEndorser || $deletedFromStatus) {
                    return response()->json([
                        'success' => true,
                        'message' => "Endorsement for {$typeName} removed successfully",
                    ], 200);
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => "No endorsement records found to remove"
                    ], 404);
                }
    
            } catch (\Exception $e) {
                DB::rollBack();
                throw $e;
            }
    
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            \Log::error('Remove endorsement error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while removing endorsement',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    
}



