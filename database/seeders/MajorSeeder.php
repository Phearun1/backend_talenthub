<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class MajorSeeder extends Seeder
{
    public function run(): void
    {
        $now = Carbon::now();

        $majors = [
            ['major' => 'Computer Science', 'created_at' => $now, 'updated_at' => $now],
            ['major' => 'Management of Information System', 'created_at' => $now, 'updated_at' => $now],
            ['major' => 'Digital Arts and Design', 'created_at' => $now, 'updated_at' => $now],
        ];

        DB::table('majors')->insert($majors);
    }
}

