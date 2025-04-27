<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to TalentHub!</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f6f6f6;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header img {
            width: 120px;
            margin-bottom: 10px;
        }
        .content {
            font-size: 16px;
            line-height: 1.8;
        }
        .button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            background-color: #007BFF;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            font-size: 12px;
            color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <!-- Replace src with your real logo URL -->
            <img src="https://your-website.com/logo.png" alt="TalentHub Logo">
            <h1>Welcome to TalentHub!</h1>
        </div>

        <div class="content">
            <p>Hi {{ $userData->name }},</p>

            <p>Thank you for joining <strong>TalentHub</strong>! Your account has been successfully created. We’re excited to have you on board.</p>

            <p>You can now log in and start building your professional portfolio, showcase your skills, and connect with exciting opportunities.</p>

            <p style="text-align: center;">
                <a href="https://your-website.com/login" class="button">Log In to Your Account</a>
            </p>

            <p>If you have any questions or need assistance, feel free to contact our support team at 
                <a href="mailto:support@talenthub.com">support@talenthub.com</a>.
            </p>

            <p>Best regards,<br>The TalentHub Team</p>
        </div>

        <div class="footer">
            <p>TalentHub, Phnom Penh, Cambodia</p>
            <p>Website: <a href="https://your-website.com" style="color: #777;">www.talenthub.com</a></p>
            <p>This is an automated message. Please do not reply.</p>
            <p>© 2025 TalentHub. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
