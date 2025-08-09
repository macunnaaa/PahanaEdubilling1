<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pahana Edu - Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-image: url('https://images.unsplash.com/photo-1532012197267-da84d127e765?q=80&w=1887&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            position: relative;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(10, 10, 20, 0.7);
            backdrop-filter: blur(8px);
        }
        .login-container {
            position: relative;
            z-index: 2;
            max-width: 450px;
            width: 100%;
        }
        .login-card {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: 1rem;
        }
        .form-control {
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
        }
        .form-control:focus {
            background-color: rgba(255, 255, 255, 0.3);
            color: white;
            box-shadow: none;
        }
        .form-floating > label {
            color: #ccc;
        }
        /* Animation for the Button */
        @keyframes jello-horizontal {
            0% { transform: scale3d(1, 1, 1); }
            30% { transform: scale3d(1.25, 0.75, 1); }
            40% { transform: scale3d(0.75, 1.25, 1); }
            50% { transform: scale3d(1.15, 0.85, 1); }
            65% { transform: scale3d(0.95, 1.05, 1); }
            75% { transform: scale3d(1.05, 0.95, 1); }
            100% { transform: scale3d(1, 1, 1); }
        }
        .signin-btn.animate-on-load {
            animation: jello-horizontal 2s ease-in-out;
        }
        .signin-btn:hover {
            animation: jello-horizontal 2s ease-in-out;
        }
        /* Blinking Animation for  Logo */
        @keyframes coin-blink {
            0%, 100% {
                box-shadow: 0 0 8px rgba(59, 130, 246, 0.5);
                opacity: 0.9;
            }
            50% {
                box-shadow: 0 0 25px rgba(59, 130, 246, 1);
                opacity: 1;
            }
        }
        .logo-circle {
            animation: coin-blink 3s ease-in-out infinite;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="text-center mb-4">
            
            <!-- A new class has been added for animation. -->
            <div class="bg-primary rounded-circle mx-auto mb-3 logo-circle" style="width: 72px; height: 72px; display: flex; align-items: center; justify-content: center;">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c0 1.7 2.7 3 6 3s6-1.3 6-3v-5"/></svg>
            </div>
            <h2 class="fw-bold text-white">Pahana Edu Billing System</h2>
            <p class="text-white-50">Bookshop Billing & Management Portal</p>
        </div>

        <div class="card shadow-lg login-card">
            <div class="card-body p-4 p-sm-5">
                <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger text-center">Invalid username or password.</div>
                <% } %>
                
                <form action="login" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" name="username" class="form-control" id="floatingInput" placeholder="admin" value="admin" required>
                        <label for="floatingInput">Username</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password" value="1234" required>
                        <label for="floatingPassword">Password</label>
                    </div>
                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-primary btn-lg rounded-pill signin-btn animate-on-load">Sign In</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
