<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\PersonalAccessToken; // Make sure you use the correct model
use Carbon\Carbon;

class CleanupExpiredTokens extends Command
{
    // The name and signature of the console command
    protected $signature = 'tokens:cleanup';

    // The console command description
    protected $description = 'Cleanup expired tokens from the personal_access_tokens table';

    // Execute the console command
    public function handle()
    {
        // Delete expired tokens
        $deleted = PersonalAccessToken::where('expires_at', '<', Carbon::now())->delete();

        $this->info("Expired tokens cleaned up: " . $deleted);
    }
}
