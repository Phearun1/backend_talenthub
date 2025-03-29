<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie', '/api/login_google'],  // Include API paths you need

    'allowed_methods' => ['*'],  // Allow all HTTP methods (GET, POST, etc.)

    'allowed_origins' => ['*'],  // Allow all origins to access your API (you can specify domains here if you want)

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],  // Allow all headers, including Authorization

    'exposed_headers' => [],  // No exposed headers

    'max_age' => 0,  // Cache for preflight requests (set to 0 for no caching)

    'supports_credentials' => false,  // Disable credentials (cookies, etc.) unless required
];
