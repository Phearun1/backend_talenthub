<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;

class User extends Model
{
    use HasFactory, HasApiTokens;

    // Define the fillable fields (columns that can be mass-assigned)
    protected $fillable = [
        'google_id', // for google authentication
        'email',
        'name',
        'photo', // optional, can be null if no photo provided
        'role_id', // role assignment (default is 1)
    ];

    // Optionally, if you are using timestamps manually, you can set:
    public $timestamps = true;
}
