<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome | Sweet Treats Bakery</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome (FOR ICONS) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #ffe6eb, #ffd6e0, #ffc2d1);
            overflow: hidden;
        }

        /* Floating decorations */
        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.6;
        }

        .blob.pink {
            width: 300px;
            height: 300px;
            background: #ff9eb5;
            top: -80px;
            left: -80px;
        }

        .blob.peach {
            width: 350px;
            height: 350px;
            background: #ffb3c6;
            bottom: -120px;
            right: -100px;
        }

        /* Main Card */
        .welcome-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(12px);
            border-radius: 25px;
            padding: 50px 40px;
            width: 100%;
            max-width: 450px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            animation: fadeUp 1s ease;
            z-index: 2;
        }

        h1 {
            color: #e75480;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .tagline {
            color: #7b6f73;
            font-size: 1.1rem;
            margin-bottom: 35px;
        }

        /* Buttons */
        .role-btn {
            width: 100%;
            border: none;
            border-radius: 50px;
            padding: 14px;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
            background: linear-gradient(90deg, #e75480, #f18ca8);
            color: white;
            box-shadow: 0 8px 20px rgba(231, 84, 128, 0.3);
            transition: all 0.3s ease;
        }

        .role-btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px rgba(231, 84, 128, 0.45);
        }

        .role-btn i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        footer {
            margin-top: 30px;
            font-size: 0.95rem;
            color: #9c7b86;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <!-- Background Blobs -->
    <div class="blob pink"></div>
    <div class="blob peach"></div>

    <!-- Welcome Card -->
    <div class="welcome-card">
        <h1>Sweet Treats Bakery</h1>
        <p class="tagline">Choose your role to continue</p>

        <form action="adminLogin.jsp" method="GET">
            <button class="role-btn">
                <i class="fa-solid fa-user-shield"></i> Admin
            </button>
        </form>

        <form action="login.jsp" method="GET">
            <button class="role-btn">
                <i class="fa-solid fa-user"></i> Customer
            </button>
        </form>

        <form action="deliveryLogin.jsp" method="GET">
            <button class="role-btn">
                <i class="fa-solid fa-truck"></i> Delivery
            </button>
        </form>

        <footer>
            Made with Love for Sweet Treats Bakery
        </footer>
    </div>

</body>
</html>
