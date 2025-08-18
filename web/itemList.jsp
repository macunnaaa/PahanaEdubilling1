<%@page import="com.pahanaedu.billing.model.Item"%>
<%@page import="java.util.List"%>
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
    <title>Dashboard - Item Management</title>
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

        .item-card {
            background: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.1);
            transition: all 0.3s ease;
            overflow: hidden; 
        }
        .item-card:hover {
            transform: translateY(-8px);
            background: rgba(255, 255, 255, 0.55);
            box-shadow: 0 10px 35px 0 rgba(31, 38, 135, 0.15);
        }

        .card-img-placeholder {
            background-color: rgba(0, 0, 0, 0.05);
            height: 160px;
            transition: all 0.3s ease;
        }
        .card-img-placeholder i {
            font-size: 4.5rem;
            color: rgba(0, 0, 0, 0.25);
            transition: all 0.3s ease;
        }
        .item-card:hover .card-img-placeholder {
            background-color: rgba(79, 70, 229, 0.1);
        }
        .item-card:hover .card-img-placeholder i {
            color: #4f46e5;
            transform: scale(1.1);
        }
        
        .item-card .card-body { padding: 1.25rem; color: #111827; }
        .item-card .item-name { color: #1a202c; font-weight: 600; }
        .item-card .item-code { color: #4a5568; margin-bottom: 1rem; }
        .item-card .price-tag { font-size: 1.5rem; color: #4f46e5; font-weight: 700; }
        .item-card .card-actions {
            padding-top: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.3);
        }

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

        @keyframes blinkAnimation { 50% { opacity: 0.6; } }
        .modal-icon { font-size: 3rem; color: #dc3545; animation: blinkWarning 1.5s infinite; }
        @keyframes blinkWarning {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(1.1); }
        }
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
                <li class="nav-item mb-2"><a class="nav-link" href="listCustomers"><i class="fas fa-users"></i> Customers</a></li>
                <li class="nav-item mb-2"><a class="nav-link active" href="listItems"><i class="fas fa-graduation-cap"></i> Items</a></li>
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
                    <h4 class="fw-bold mb-0">Books Management</h4>
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
                <div class="d-flex justify-content-between align-items-center my-4">
                    <div>
                        <h2 class="fw-bold">Item Catalog</h2>
                        <p class="text-muted">Explore and manage available books.</p>
                    </div>
                    <a href="addItem.jsp" class="btn btn-primary shadow-sm"><i class="fas fa-plus-circle me-2"></i>Add New Item</a>
                </div>
                
                <div class="input-group mb-4">
                    <input type="text" id="itemSearchInput" class="form-control" placeholder="Search by item name or code...">
                </div>

                <div class="row" id="itemList">
                    <% List<Item> items = (List<Item>) request.getAttribute("allItems"); 
                        if (items != null && !items.isEmpty()) {
                            for (Item item : items) { %>
                                <div class="col-md-6 col-lg-3 mb-4 item-container">
                                    <div class="card h-100 item-card">
                                        <div class="card-img-placeholder d-flex align-items-center justify-content-center">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title item-name"><%= item.getItemName() %></h5>
                                            <p class="card-text item-code small"><%= item.getItemCode() %></p>
                                            
                                            <div class="mt-auto">
                                                <h4 class="price-tag mb-3">₨<%= String.format("%.2f", item.getPrice()) %></h4>
                                                <div class="card-actions d-flex justify-content-end">
                                                    <a href="editItem?id=<%= item.getId() %>" class="btn btn-warning btn-sm me-2">Edit</a>
                                                    <button type="button" class="btn btn-danger btn-sm" onclick="openDeleteModal('<%= item.getId() %>')">Delete</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <% }
                        } else { %>
                             <div class="col-12"><p class="text-center">No items found.</p></div>
                        <% } %>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center py-4">
                    <i class="fas fa-exclamation-triangle modal-icon mb-3"></i>
                    <h4 class="fw-bold">Are you sure?</h4>
                    <p class="text-muted">Do you really want to delete this item? This process cannot be undone.</p>
                </div>
                <div class="modal-footer border-0 justify-content-center">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, Cancel</button>
                    <a id="confirmDeleteBtn" href="#" class="btn btn-danger">Yes, Delete</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('itemSearchInput').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let items = document.querySelectorAll('#itemList .item-container');
            
            items.forEach(function(item) {
                let name = item.querySelector('.item-name').textContent.toLowerCase();
                let code = item.querySelector('.item-code').textContent.toLowerCase();
                if (name.includes(filter) || code.includes(filter)) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        });

        var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        var confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

        function openDeleteModal(itemId) {
            confirmDeleteBtn.href = 'deleteItem?id=' + itemId;
            deleteModal.show();
        }
    </script>
</body>
</html>