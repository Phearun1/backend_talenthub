<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Carbon\Carbon;

class PortfolioSeeder extends Seeder
{
    public function run(): void
    {
        $now = Carbon::now();
        $portfolios = [];

        for ($i = 1; $i <= 20; $i++) {
            $portfolios[] = [
                'user_id' => rand(1, 10),
                'major_id' => rand(1, 3),
                'phone_number' => '0123456' . str_pad($i, 2, '0', STR_PAD_LEFT),
                'about' => 'This is a short bio for user ' . $i,
                'working_status' => rand(1, 2),
                'status' => rand(0, 1),
                'created_at' => $now,
                'updated_at' => $now,
            ];
        }

        DB::table('portfolios')->insert($portfolios);
    }
}
