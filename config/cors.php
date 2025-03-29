<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie', '/api/login_google'],  // Include paths you need CORS for

    'allowed_methods' => ['*'],  // Allow all HTTP methods (GET, POST, PUT, DELETE, etc.)

    'allowed_origins' => ['*'],  // Allow all origins (you can restrict this to your frontend domain later)

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],  // Allow all headers, including Authorization

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => false,  // Set to true if you're using cookies for authentication
];
