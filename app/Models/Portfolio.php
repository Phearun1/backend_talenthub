<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Portfolio extends Model
{
    protected $fillable = [
        'user_id',
        'major_id',
        'phone_number',
        'about',
        'working_status',
        'status',
    ];
}
