<%@page import="com.pahanaedu.billing.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Add Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            overflow-x: hidden;
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .sidebar {
            width: 280px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #111827;
            z-index: 10; /* Ensure sidebar is on top */
        }
        .main-content {
            margin-left: 280px;
            flex-grow: 1;
            min-height: 100vh;
            background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
        }
        .sidebar .nav-link {
            font-weight: 500; color: #adb5bd; border-radius: 0.375rem;
        }
        .sidebar .nav-link:hover { background-color: #374151; color: white; }
        .sidebar .nav-link.active { background-color: #4f46e5; color: white; }
        .sidebar .nav-link i { margin-right: 12px; width: 20px; text-align: center; }
        .sidebar-header { 
            padding: 1.5rem; 
            color: white;
            animation: blinkAnimation 2s infinite;
        }
        .sidebar-footer { font-size: 0.8rem; color: #6c757d; }
        
        /*  Glass UI Styles  */
        .top-nav {
            position: sticky;
            top: 0;
            z-index: 5;
            background-color: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .form-card {
            background: rgba(255, 255, 255, 0.45);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.1);
        }
        .form-card .form-control {
            background-color: rgba(255, 255, 255, 0.6);
            border-color: rgba(255, 255, 255, 0.8);
            color: #212529;
            font-weight: 500;
        }
        .form-card .form-control:focus {
            background-color: rgba(255, 255, 255, 0.8);
            border-color: #4f46e5;
            box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.25);
        }
        
        /*  General Animations  */
        @keyframes blinkAnimation { 50% { opacity: 0.6; } }
        
        /*   Copyright Shine Animation   */
        .sidebar-footer p {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }
        .sidebar-footer p::after {
            content: '';
            position: absolute;
            top: 0;
            left: -150%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            animation: shine 4s infinite;
        }
        @keyframes shine {
            0% { left: -150%; }
            50% { left: 150%; }
            100% { left: 150%; }
        }
    </style>
</head>
<body>

    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar d-flex flex-column p-3">
            <div class="sidebar-header d-flex align-items-center justify-content-center mb-3">
                <div class="bg-primary rounded me-2" style="padding: 5px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c0 1.7 2.7 3 6 3s6-1.3 6-3v-5"/></svg>
                </div>
                <h4 class="fw-bold mb-0">Pahana Edu</h4>
            </div>
            
            <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item mb-2"><a class="nav-link" href="listCustomers"><i class="fas fa-users"></i> Customers</a></li>
                <li class="nav-item mb-2"><a class="nav-link active" href="listItems"><i class="fas fa-book"></i> Items</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="prepareBill"><i class="fas fa-file-invoice"></i> Create Bill</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
            </ul>
            <hr class="text-secondary">
            <div class="sidebar-footer text-center mt-auto">
                <p class="mb-0">&copy; 2025 PhanaEduBill System</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Top Navigation Bar -->
            <nav class="top-nav d-flex justify-content-between align-items-center">
                 <div>
                    <h4 class="fw-bold mb-0">Add New Item</h4>
                </div>
                <div class="d-flex align-items-center">
                    <i class="fas fa-bell me-4 fs-5 text-muted"></i>
                    <div class="d-flex align-items-center">
                        <img src="https://placehold.co/40x40/4F46E5/FFFFFF?text=A" class="rounded-circle me-3" alt="Admin">
                        <div>
                            <span class="fw-bold">Admin User</span><br>
                            <small class="text-muted">Admin</small>
                        </div>
                    </div>
                    <a href="logout" class="btn btn-outline-danger ms-4">Logout</a>
                </div>
            </nav>

            <div class="p-4">
                <div class="mb-4 pt-3">
                    <p class="text-muted">Fill in the details below to add a new book to the catalog.</p>
                </div>
                
                <div class="card form-card">
                    <div class="card-body p-4 p-md-5">
                        <form action="addItem" method="post">
                            <div class="mb-3">
                                <label for="itemCode" class="form-label fw-bold">Item Code</label>
                                <input type="text" id="itemCode" name="itemCode" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="itemName" class="form-label fw-bold">Item Name</label>
                                <input type="text" id="itemName" name="itemName" class="form-control" required>
                            </div>
                            <div class="mb-4">
                                <label for="price" class="form-label fw-bold">Price(₨)</label>
                                <input type="text" id="price" name="price" class="form-control" required pattern="[0-9]+(\.[0-9]{1,2})?" title="Enter a valid price (e.g., 150.50)">
                            </div>
                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary shadow-sm"><i class="fas fa-save me-2"></i>Save Item</button>
                                <a href="listItems" class="btn btn-secondary shadow-sm">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>