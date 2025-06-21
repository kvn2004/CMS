<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.vihanganimsara.cms.dto.UserDto" %>
<%@ page import="lk.vihanganimsara.cms.dto.ComplainDto" %>
<%
    UserDto user = (UserDto) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    int userId = user.getId();
    List<ComplainDto> complaints = (List<ComplainDto>) request.getAttribute("complaints");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: whitesmoke;
            font-family: 'Arial', sans-serif;
            color: #ffffff;
        }

        .container {
            max-width: 800px;
            margin-top: 2rem;
        }

        .card {
            background-color: #1a1a1a;
            border: 1px solid #FF014F;
            border-radius: 10px;
            padding: 1.5rem;
        }

        .card-header {
            background-color: #FF014F;
            color: #ffffff;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }

        .form-label {
            color: whitesmoke;
        }

        .form-control {
            background-color: #ffffff;
            border: 1px solid #FF014F;
            color: #000000;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: #FF014F;
            box-shadow: 0 0 5px rgba(255, 1, 79, 0.5);
            color: #000000;
        }

        .btn-primary {
            background-color: #FF014F;
            border: none;
        }

        .btn-primary:hover {
            background-color: #e60045;
        }

        .table {
            background-color: #ffffff;
            color: #121212;
        }

        .table th {
            background-color: #FF014F;
            color: #ffffff;
        }

        .table td {
            vertical-align: middle;
        }

        .btn-danger, .btn-warning {
            background-color: #ffffff;
            color: #FF014F;
            border: 1px solid #FF014F;
        }

        .btn-danger:hover, .btn-warning:hover {
            background-color: #FF014F;
            color: #ffffff;
        }
    </style>
</head>
<body>

<div class="container">
    <form action="logout" method="post" style="text-align: right;">
        <button class="btn btn-danger btn-sm">Logout</button>
    </form>

    <div class="card">
        <div class="card-header">
            <h3>Complaint Management</h3>
            <p>Welcome, <%= user.getUsername() %>!</p>


        </div>
        <div class="card-body">
            <!-- Complaint Form -->
            <h4 class="mb-3" style="color: #FF014F;">Submit New Complaint</h4>
            <form id="complaintForm" action="usercomplaint" method="post">
                <!-- Hidden User ID -->
                <input type="hidden" name="uid" value="<%= userId %>">

                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" name="cTitle" required>
                    <div id="titleError" class="text-danger" style="display: none;">Title is required</div>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="cDescription" rows="3" required></textarea>
                    <div id="descriptionError" class="text-danger" style="display: none;">Description is required</div>
                </div>
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
            </form>

            <!-- Complaint List -->
            <h4 class="mt-4 mb-3" style="color: #FF014F;">Your Complaints</h4>
            <div class="card-body">
                <%

                    System.out.println("JSP: Complaints list size = " + (complaints != null ? complaints.size() : "null"));
                    if (complaints != null && !complaints.isEmpty()) {
                %>
                <p style="color: gray;">You have <strong><%= complaints.size() %>
                </strong> complaints.</p>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Complaint ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (ComplainDto complaint : complaints) { %>
                    <tr>
                        <td><%= complaint.getId() %>
                        </td>
                        <td><%= complaint.getTitle() %>
                        </td>
                        <td><%= complaint.getDescription() %>
                        </td>
                        <td><%= complaint.getStatus() %>
                        </td>
                        <td>
                            <% if ("PENDING".equalsIgnoreCase(complaint.getStatus())) { %>
                            <form action="usercomplaint" method="post" style="display:inline;">
                                <input type="hidden" name="mode" value="delete" />
                                <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                            <form action="usercomplaint" method="post" style="display:inline;">
                                <input type="hidden" name="mode" value="update" />
                                <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                                <input type="hidden" name="cTitle" value="<%= complaint.getTitle() %>" />
                                <input type="hidden" name="cDescription" value="<%= complaint.getDescription() %>" />
                                <input type="hidden" name="status" value="UPDATED" />
                                <button type="submit" class="btn btn-warning btn-sm me-2">Quick Update</button>
                            </form>

                            <% } else { %>
                            <span class="text-muted">N/A</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p style="color: gray;">You have no complaints submitted yet.</p>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Complaint ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td colspan="5">No complaints found.</td>
                    </tr>
                    </tbody>
                </table>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- JS for validation -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</script>
</body>
</html>
