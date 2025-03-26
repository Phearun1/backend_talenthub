<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ExperienceSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('experiences')->insert([
            [
                'portfolio_id' => 1,
                'company_id' => 1,
                'work_title' => 3,
                'description' => 'Imagine yourself together art. Prepare peace believe.',
                'start_date' => '2022-05-12 09:24:41',
                'end_date' => '2023-08-06 05:59:55',
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            // Add 9 more from the JSON you got (copy format above)
        ]);
    }
}
