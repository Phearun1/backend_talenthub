<!-- resources/views/emails/welcome.blade.php -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to TalentHub</title>
</head>
<body>
    <p>Hello, {{ $userData->name ?? 'Guest' }}</p> <!-- Safely accessing name with fallback to 'Guest' -->
    <p>Welcome to TalentHub! We're excited to have you on board.</p>

    <!-- You can add more content here -->
</body>
</html>
