<!-- resources/views/emails/welcome.blade.php -->

<!DOCTYPE html>
<html>
<head>
    <title>Welcome to TalentHub</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #4a86e8;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 5px 5px 0 0;
        }
        .content {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 0 0 5px 5px;
        }
        .button {
            display: inline-block;
            background-color: #4a86e8;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 12px;
            color: #777;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Welcome to TalentHub!</h1>
    </div>
    
    <div class="content">
        <h2>Hello, {{ $name }}</h2>
        
        <p>{{ $plainText }}</p>
        
        <div>{!! $htmlContent !!}</div>
        
        <p>If you have any questions or need assistance, please don't hesitate to contact our support team.</p>
        
        <a href="https://talenthub.newlinkmarketing.com" class="button">Visit TalentHub</a>
    </div>
    
    <div class="footer">
        <p>© {{ date('Y') }} TalentHub. All rights reserved.</p>
        <p>This is an automated email, please do not reply to this message.</p>
    </div>
</body>
</html>
