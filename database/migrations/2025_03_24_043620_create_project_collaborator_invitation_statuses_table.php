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
        Schema::create('project_collaborator_invitation_statuses', function (Blueprint $table) {
            $table->id();
            $table->integer('project_id');
            $table->integer('collaborator_id');
            $table->integer('project_collab_status_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('project_collaborator_invitation_statuses');
    }
};
