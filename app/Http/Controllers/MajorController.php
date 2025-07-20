<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class MajorController extends Controller
{
    public function viewAllMajors(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        try {
            // Fetch all majors ordered by most recently created
            $majors = DB::table('majors')
                ->select('id', 'major', 'created_at', 'updated_at')
                ->orderBy('created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $majors,
                'count' => $majors->count()
            ]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to retrieve majors'], 500);
        }
    }

    public function createMajor(Request $request)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Validate request
        $validator = Validator::make($request->all(), [
            'major' => 'required|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        try {
            // Check if major already exists
            $existingMajor = DB::table('majors')
                ->where('major', trim($request->major))
                ->first();

            if ($existingMajor) {
                return response()->json(['error' => 'This major already exists'], 400);
            }

            // Create new major
            $majorId = DB::table('majors')->insertGetId([
                'major' => trim($request->major),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Get the created major
            $major = DB::table('majors')
                ->where('id', $majorId)
                ->first();

            return response()->json([
                'success' => true,
                'data' => $major,
                'message' => 'Major created successfully'
            ]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to create major'], 500);
        }
    }

    public function updateMajor(Request $request, $id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        // Validate request
        $validator = Validator::make($request->all(), [
            'major' => 'required|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        try {
            // Find the major
            $major = DB::table('majors')
                ->where('id', $id)
                ->first();

            if (!$major) {
                return response()->json(['error' => 'Major not found'], 404);
            }

            // Check if another major with the same name exists (excluding current major)
            $existingMajor = DB::table('majors')
                ->where('major', trim($request->major))
                ->where('id', '!=', $id)
                ->first();

            if ($existingMajor) {
                return response()->json(['error' => 'This major already exists'], 400);
            }

            // Get the original major name for the response
            $originalMajor = $major->major;

            // Update the major
            DB::table('majors')
                ->where('id', $id)
                ->update([
                    'major' => trim($request->major),
                    'updated_at' => now(),
                ]);

            // Get the updated major
            $updatedMajor = DB::table('majors')
                ->where('id', $id)
                ->first();

            // Return success response with before/after details
            return response()->json([
                'success' => true,
                'data' => $updatedMajor,
                'message' => 'Major updated successfully',
                'original_major' => $originalMajor,
            ]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to update major'], 500);
        }
    }

    public function deleteMajor(Request $request, $id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        try {
            // Find the major
            $major = DB::table('majors')
                ->where('id', $id)
                ->first();

            if (!$major) {
                return response()->json(['error' => 'Major not found'], 404);
            }

            // Check if major is being used in portfolios
            $portfolioCount = DB::table('portfolios')
                ->where('major_id', $id)
                ->count();

            if ($portfolioCount > 0) {
                return response()->json([
                    'error' => 'Cannot delete major. It is currently being used by ' . $portfolioCount . ' portfolio(s).'
                ], 400);
            }

            // Store major name for response
            $majorName = $major->major;

            // Delete the major
            DB::table('majors')
                ->where('id', $id)
                ->delete();

            return response()->json([
                'success' => true,
                'message' => "Major '{$majorName}' deleted successfully"
            ]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to delete major'], 500);
        }
    }

    public function viewMajorDetail(Request $request, $id)
    {
        // Check if the authenticated user is an admin (role_id = 3)
        if ($request->user() && $request->user()->role_id !== 3) {
            return response()->json(['error' => 'Unauthorized. Admin access required.'], 403);
        }

        try {
            // Find the major
            $major = DB::table('majors')
                ->where('id', $id)
                ->first();

            if (!$major) {
                return response()->json(['error' => 'Major not found'], 404);
            }

            // Get portfolio count for this major
            $portfolioCount = DB::table('portfolios')
                ->where('major_id', $id)
                ->count();

            // Get portfolio users using this major
            $portfolioUsers = DB::table('portfolios')
                ->leftJoin('users', 'portfolios.user_id', '=', 'users.google_id')
                ->where('portfolios.major_id', $id)
                ->select('users.name', 'users.email', 'users.google_id')
                ->get();

            return response()->json([
                'success' => true,
                'data' => [
                    'id' => $major->id,
                    'major' => $major->major,
                    'created_at' => $major->created_at,
                    'updated_at' => $major->updated_at,
                    'portfolio_count' => $portfolioCount,
                    'portfolio_users' => $portfolioUsers
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to retrieve major details'], 500);
        }
    }
}