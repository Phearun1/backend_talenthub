<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;

class Admin extends Model
{   
    use HasFactory, HasApiTokens;
    protected $fillable = [
        'email',
        'name',
        'password',
        'role_id',
        'is_super_admin',
    ];
}
