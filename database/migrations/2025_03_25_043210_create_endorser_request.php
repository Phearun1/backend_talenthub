<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('endorser_request', function (Blueprint $table) {
            $table->id();
            $table->string('name', 255);
            $table->string('contact', 255);
            $table->string('email', 255);
            $table->string('company', 255);
            $table->string('working_position', 255);
            $table->text('student_name'); // Store as JSON string
            $table->string('image', 255);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('endorser_request');
    }
};