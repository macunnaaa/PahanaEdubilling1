<%@page import="java.util.List"%>
<%@page import="com.pahanaedu.billing.model.Customer"%>
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard - Customer Management</title>
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
            z-index: 10;
        }
        .main-content {
            margin-left: 280px;
            flex-grow: 1;
            min-height: 100vh;
            /* New background to make the glass effect visible */
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

        /* --- ✨ Updated Top Navigation Bar Style ✨ --- */
        .top-nav {
            position: sticky;
            top: 0;
            z-index: 5;
            background-color: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            /* New border and shadow for a floating effect */
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        /* --- ✨ New Glassmorphism Card Style ✨ --- */
        .customer-card {
            background: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.1);
            transition: all 0.3s ease;
        }
        .customer-card:hover {
            transform: translateY(-8px);
            background: rgba(255, 255, 255, 0.55);
            box-shadow: 0 10px 35px 0 rgba(31, 38, 135, 0.15);
        }
        .customer-card .card-title {
            font-weight: 600;
            color: #1a202c;
        }
        .customer-card .card-text {
             color: #2d3748;
        }
        .customer-card .card-actions {
            border-top: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        /* --- General Animations & Other Styles --- */
        @keyframes blinkAnimation { 50% { opacity: 0.6; } }
        .modal-icon {
            font-size: 3rem; color: #dc3545; animation: blinkWarning 1.5s infinite;
        }
        @keyframes blinkWarning {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(1.1); }
        }
        @keyframes alarm-shake {
            0%{transform:rotate(0)}10%{transform:rotate(15deg)}20%{transform:rotate(-15deg)}30%{transform:rotate(10deg)}40%{transform:rotate(-10deg)}50%{transform:rotate(0)}100%{transform:rotate(0)}
        }
        .shake-on-load { animation: alarm-shake 1s ease-in-out; }
        .top-nav .fa-bell:hover { animation: alarm-shake 1s ease-in-out; cursor: pointer; }
        .sidebar-footer p { position: relative; overflow: hidden; display: inline-block; }
        .sidebar-footer p::after {
            content: ''; position: absolute; top: 0; left: -150%; width: 100%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            animation: shine 4s infinite;
        }
        @keyframes shine { 0% { left: -150%; } 50% { left: 150%; } 100% { left: 150%; } }
    </style>
</head>
<body>

    <div class="d-flex">
        <div class="sidebar d-flex flex-column p-3">
            <div class="sidebar-header d-flex align-items-center justify-content-center mb-3">
                <div class="bg-primary rounded me-2" style="padding: 5px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c0 1.7 2.7 3 6 3s6-1.3 6-3v-5"/></svg>
                </div>
                <h4 class="fw-bold mb-0">Pahana Edu</h4>
            </div>
            <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item mb-2"><a class="nav-link active" href="listCustomers"><i class="fas fa-users"></i> Customers</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="listItems"><i class="fas fa-book"></i> Items</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="prepareBill"><i class="fas fa-file-invoice"></i> Create Bill</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
            </ul>
            <hr class="text-secondary">
            <div class="sidebar-footer text-center mt-auto">
                <p class="mb-0">&copy; 2025 PhanaEduBill System</p>
            </div>
        </div>

        <div class="main-content">
            <nav class="top-nav d-flex justify-content-between align-items-center">
                <div>
                    <h4 class="fw-bold mb-0">Customer Management</h4>
                </div>
                <div class="d-flex align-items-center">
                    <i class="fas fa-bell me-4 fs-5 text-muted shake-on-load"></i>
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                            <i class="fas fa-user"></i>
                        </div>
                        <div>
                            <span class="fw-bold"><%= loggedInUser.getUsername() %></span><br>
                            <small class="text-muted">Admin</small>
                        </div>
                    </div>
                    <a href="logout" class="btn btn-outline-danger ms-4">Logout</a>
                </div>
            </nav>

            <div class="p-4">
                <div class="d-flex justify-content-between align-items-center my-4">
                    <div>
                        <h2 class="fw-bold">All Registered Customers</h2>
                        <p class="text-muted"> add, edit,update, or delete customers.</p>
                    </div>
                    <a href="addCustomer.jsp" class="btn btn-primary shadow-sm"><i class="fas fa-plus-circle me-2"></i>Add New Customer</a>
                </div>
                
                <div class="row">
                    <% List<Customer> customers = (List<Customer>) request.getAttribute("allCustomers"); 
                        if (customers != null && !customers.isEmpty()) {
                            for (Customer cust : customers) { 
                                String firstLetter = "?";
                                if (cust.getName() != null && !cust.getName().isEmpty()) {
                                    firstLetter = cust.getName().substring(0, 1).toUpperCase();
                                }
                    %>
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card h-100 customer-card">
                                        <div class="card-body d-flex flex-column">
                                            <div class="d-flex align-items-center mb-3">
                                                <div class="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                                    <%= firstLetter %>
                                                </div>
                                                <div>
                                                    <h5 class="card-title mb-0"><%= cust.getName() %></h5>
                                                    <p class="card-text text-muted small">Acc. No: <%= cust.getAccountNumber() %></p>
                                                </div>
                                            </div>
                                            <p class="card-text small mb-auto">
                                                <i class="fas fa-map-marker-alt me-2 text-muted"></i><%= cust.getAddress() %><br>
                                                <i class="fas fa-phone me-2 text-muted"></i><%= cust.getTelephoneNumber() %>
                                            </p>
                                            <div class="d-flex justify-content-end pt-3 card-actions">
                                                <a href="editCustomer?id=<%= cust.getId() %>" class="btn btn-warning btn-sm me-2">Edit</a>
                                                <button type="button" class="btn btn-danger btn-sm" onclick="initiateDelete('<%= cust.getId() %>')">Delete</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <% }
                        } else { %>
                             <div class="col-12"><p class="text-center">No customers found.</p></div>
                        <% } %>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered"><div class="modal-content">
            <div class="modal-header border-0"><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body text-center py-4">
                <i class="fas fa-exclamation-triangle modal-icon mb-3"></i>
                <h4 class="fw-bold">Are you sure?</h4>
                <p class="text-muted">Do you really want to delete this record? This process cannot be undone.</p>
            </div>
            <div class="modal-footer border-0 justify-content-center">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, Cancel</button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-danger">Yes, Delete</a>
            </div>
        </div></div>
    </div>
    <div class="modal fade" id="authModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Authentication Required</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>To delete this customer, please enter your password to confirm.</p>
                    <input type="password" id="authPassword" class="form-control" placeholder="Enter your password...">
                    <input type="hidden" id="deleteIdHolder">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAuthAndDelete()">Confirm</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        var authModal = new bootstrap.Modal(document.getElementById('authModal'));
        var confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        var deleteIdHolder = document.getElementById('deleteIdHolder');
        function initiateDelete(customerId) {
            deleteIdHolder.value = customerId;
            authModal.show();
        }
        function confirmAuthAndDelete() {
            var password = document.getElementById('authPassword').value;
            if (password) {
                authModal.hide();
                openDeleteConfirmation();
            } else {
                alert('Please enter your password.');
            }
        }
        function openDeleteConfirmation() {
            confirmDeleteBtn.href = 'deleteCustomer?id=' + deleteIdHolder.value;
            deleteModal.show();
        }
    </script>
</body>
</html>