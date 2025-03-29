<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;  // Use Authenticatable class
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable  // Extend Authenticatable
{
    use HasApiTokens;

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
