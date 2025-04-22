<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TalentHub Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            font-size: 12px;
            color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Welcome to TalentHub!</h1>
        </div>
        
        <p>Hello {{ $user['name'] }},</p>
        
        <p>Thank you for joining TalentHub. Your account has been successfully created.</p>
        
        <p>You can now log in and start building your professional portfolio.</p>
        
        <p>If you have any questions or need assistance, please don't hesitate to contact our support team.</p>
        
        <p>Best regards,<br>The TalentHub Team</p>
        
        <div class="footer">
            <p>This is an automated message, please do not reply to this email.</p>
            <p>© 2025 TalentHub. All rights reserved.</p>
        </div>
    </div>
</body>
</html>