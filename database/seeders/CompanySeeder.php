<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class CompanySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $now = Carbon::now();
        
        $companies = [
            ['company_name' => 'Microsoft Corporation', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Google LLC', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Amazon Web Services', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Apple Inc.', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Meta Platforms', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Tesla, Inc.', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Netflix, Inc.', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'IBM Corporation', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Oracle Corporation', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Salesforce, Inc.', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Adobe Inc.', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Cisco Systems', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Intel Corporation', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'NVIDIA Corporation', 'created_at' => $now, 'updated_at' => $now],
            ['company_name' => 'Samsung Electronics', 'created_at' => $now, 'updated_at' => $now]
        ];
        
        DB::table('companies')->insert($companies);
    }
}