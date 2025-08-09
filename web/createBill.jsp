<%@page import="com.pahanaedu.billing.model.Item"%>
<%@page import="com.pahanaedu.billing.model.Customer"%>
<%@page import="java.util.List"%>
<%@page import="com.pahanaedu.billing.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Customer> customers = (List<Customer>) request.getAttribute("allCustomers");
    List<Item> items = (List<Item>) request.getAttribute("allItems");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Create Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { 
            font-family: 'Poppins', sans-serif; 
            background-color: #f8f9fa;
            overflow-x: hidden;
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
            font-weight: 500; 
            color: #adb5bd; 
            border-radius: 0.375rem; 
        }
        .sidebar .nav-link:hover { 
            background-color: #374151; 
            color: white; 
        }
        .sidebar .nav-link.active { 
            background-color: #4f46e5; 
            color: white; 
        }
        .sidebar .nav-link i { 
            margin-right: 12px; 
            width: 20px; 
            text-align: center; 
        }
        .sidebar-header { 
            padding: 1.5rem; 
            color: white; 
            animation: blinkAnimation 2s infinite; 
        }
        .sidebar-footer { 
            font-size: 0.8rem; 
            color: #6c757d; 
        }
        @keyframes blinkAnimation { 50% { opacity: 0.6; } }

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
        .form-card .form-control,
        .form-card .form-select {
            background-color: rgba(255, 255, 255, 0.6);
            border-color: rgba(255, 255, 255, 0.8);
            color: #212529;
            font-weight: 500;
        }
        .form-card .form-control:focus,
        .form-card .form-select:focus {
            background-color: rgba(255, 255, 255, 0.8);
            border-color: #4f46e5;
            box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.25);
        }
        .form-card .table {
            background-color: transparent;
        }
        .form-card .table > thead {
            color: #111827;
            border-bottom: 2px solid rgba(0, 0, 0, 0.1);
        }
        .form-card .table > tbody > tr {
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            vertical-align: middle;
        }
         .form-card .table > tbody > tr:last-child {
            border-bottom: none;
        }

        /* --- ✨ Copyright Shine Animation ✨ --- */
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
        <div class="sidebar d-flex flex-column p-3">
            <div class="sidebar-header d-flex align-items-center justify-content-center mb-3">
                <div class="bg-primary rounded me-2" style="padding: 5px;"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c0 1.7 2.7 3 6 3s6-1.3 6-3v-5"/></svg></div>
                <h4 class="fw-bold mb-0">Pahana Edu</h4>
            </div>
            <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item mb-2"><a class="nav-link" href="listCustomers"><i class="fas fa-users"></i> Customers</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="listItems"><i class="fas fa-book"></i> Items</a></li>
                <li class="nav-item mb-2"><a class="nav-link active" href="prepareBill"><i class="fas fa-file-invoice"></i> Create Bill</a></li>
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
                    <h4 class="fw-bold mb-0">Create New Bill</h4>
                </div>
                <div class="d-flex align-items-center">
                    <i class="fas fa-bell me-4 fs-5 text-muted"></i>
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
                 <div class="mb-4 pt-3">
                    <p class="text-muted">Select a customer and add items to generate a new bill.</p>
                </div>
                <div class="card form-card">
                    <div class="card-body p-4">
                        <form id="billForm" action="saveBill" method="post">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="customerSelect" class="form-label fw-bold">Select Customer</label>
                                    <select id="customerSelect" name="customerId" class="form-select" required>
                                        <option value="" selected disabled>Choose a customer...</option>
                                        <% if (customers != null) { for (Customer c : customers) { %>
                                            <option value="<%= c.getId() %>"><%= c.getName() %> (#<%= c.getAccountNumber() %>)</option>
                                        <% }} %>
                                    </select>
                                </div>
                            </div>
                            
                            <hr style="border-color: rgba(0,0,0,0.1);">

                            <div class="row align-items-end pt-3">
                                <div class="col-md-5"><label class="form-label fw-bold">Select Item</label><select id="itemSelect" class="form-select">
                                    <option value="" selected disabled>Choose an item...</option>
                                    <% if (items != null) { for (Item i : items) { %>
                                        <option value="<%= i.getId() %>" data-price="<%= i.getPrice() %>"><%= i.getItemName() %></option>
                                    <% }} %>
                                </select></div>
                                <div class="col-md-2"><label class="form-label fw-bold">Quantity</label><input type="number" id="quantityInput" class="form-control" value="1" min="1"></div>
                                <div class="col-md-3"><label class="form-label">&nbsp;</label><button type="button" id="addItemBtn" class="btn btn-primary w-100 d-block"><i class="fas fa-plus me-2"></i>Add to Bill</button></div>
                            </div>
                            
                            <h4 class="mt-5 fw-bold">Bill Items</h4>
                            <div class="table-responsive">
                                <table id="billItemsTable" class="table mt-3">
                                    <thead><tr><th>Item Name</th><th class="text-center">Quantity</th><th class="text-end">Unit Price</th><th class="text-end">Total</th><th class="text-center">Action</th></tr></thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            
                            <hr style="border-color: rgba(0,0,0,0.1);">
                            
                            <div class="d-flex justify-content-end align-items-center mt-3">
                                <h3 class="me-4 mb-0">Grand Total: </h3>
                                <h3><span id="grandTotal" class="fw-bold text-primary">$0.00</span></h3>
                            </div>
                            
                            <input type="hidden" id="finalItems" name="itemsData">
                            
                            <div class="d-flex justify-content-end mt-4">
                                <button type="submit" class="btn btn-success btn-lg"><i class="fas fa-save me-2"></i>Save & Generate Bill</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const addItemBtn = document.getElementById('addItemBtn');
            const billItemsTbody = document.querySelector('#billItemsTable tbody');
            const grandTotalSpan = document.getElementById('grandTotal');
            const finalItemsInput = document.getElementById('finalItems');
            const billForm = document.getElementById('billForm');
            let billItems = [];

            addItemBtn.addEventListener('click', function() {
                const itemSelect = document.getElementById('itemSelect');
                const selectedOption = itemSelect.options[itemSelect.selectedIndex];
                const quantityInput = document.getElementById('quantityInput');
                if (!selectedOption || !selectedOption.value) return;

                const item = { 
                    id: selectedOption.value, 
                    name: selectedOption.text, 
                    price: parseFloat(selectedOption.dataset.price), 
                    quantity: parseInt(quantityInput.value) 
                };
                
                const existingItem = billItems.find(i => i.id === item.id);
                if (existingItem) {
                    existingItem.quantity += item.quantity;
                } else {
                    billItems.push(item);
                }
                
                renderTable();
                updateFormAndTotals();
            });
            
            function renderTable() {
                billItemsTbody.innerHTML = '';
                billItems.forEach((item, index) => {
                    const row = billItemsTbody.insertRow(); 

                    const nameCell = row.insertCell();
                    nameCell.textContent = item.name;

                    const qtyCell = row.insertCell();
                    qtyCell.textContent = item.quantity;
                    qtyCell.className = 'text-center';

                    const priceCell = row.insertCell();
                    priceCell.textContent = '$' + item.price.toFixed(2);
                    priceCell.className = 'text-end';

                    const totalCell = row.insertCell();
                    const total = item.price * item.quantity;
                    totalCell.textContent = '$' + total.toFixed(2);
                    totalCell.className = 'text-end fw-bold';

                    const actionCell = row.insertCell();
                    actionCell.className = 'text-center';
                    const removeBtn = document.createElement('button');
                    removeBtn.type = 'button';
                    removeBtn.className = 'btn btn-danger btn-sm';
                    removeBtn.innerHTML = '<i class="fas fa-trash-alt"></i>';
                    removeBtn.onclick = function() {
                        removeItem(index);
                    };
                    actionCell.appendChild(removeBtn);
                });
            }

            function updateFormAndTotals() {
                let total = 0;
                billItems.forEach(item => { total += item.price * item.quantity; });
                grandTotalSpan.textContent = '$' + total.toFixed(2);
                
                const itemsData = billItems.map(item => `${item.id}:${item.quantity}`).join(',');
                finalItemsInput.value = itemsData;
            }
            
            billForm.addEventListener('submit', function(event) {
                const customerSelect = document.getElementById('customerSelect');
                if (!customerSelect.value) {
                    alert('Please select a customer.');
                    event.preventDefault();
                    return;
                }
                if (billItems.length === 0) {
                    alert('Please add at least one item to the bill.');
                    event.preventDefault();
                }
            });

            window.removeItem = function(index) {
                billItems.splice(index, 1);
                renderTable();
                updateFormAndTotals();
            }
        });
    </script>
</body>
</html>