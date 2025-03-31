<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EndorsementStatusSeeder extends Seeder
{
    public function run(): void
    {
        $statuses = ['Pending', 'Approved', 'Declined', 'Banned'];

        foreach ($statuses as $status) {
            DB::table('endorsement_statuses')->insert([
                'status' => $status,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ]);
        }
    }
}
