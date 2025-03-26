<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Carbon\Carbon;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $now = Carbon::now();
        $users = [];

        for ($i = 1; $i <= 10; $i++) {
            $users[] = [
                'email' => 'user' . $i . '@example.com',
                'name' => 'User ' . $i,
                'photo' => 'https://randomuser.me/api/portraits/lego/' . $i . '.jpg',
                'google_id' => 'google_id_' . Str::random(10),
                'role_id' => rand(1, 3), // Example role ids
                'created_at' => $now,
                'updated_at' => $now,
            ];
        }

        DB::table('users')->insert($users);
    }
}
