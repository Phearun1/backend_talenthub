<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('achievement_endorsement_statuses', function (Blueprint $table) {
            $table->id();
            $table->integer('achievement_id');
            $table->integer('endorsement_status_id');
            $table->varchar('endorser_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('achievement_endorsement_statuses');
    }
};
