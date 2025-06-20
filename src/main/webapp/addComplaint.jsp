<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color:whitesmoke;
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
        .form-label{
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
        .btn-danger {
            background-color: #ffffff;
            color: #FF014F;
            border: 1px solid #FF014F;
        }
        .btn-danger:hover {
            background-color: #FF014F;
            color: #ffffff;
        }
        .btn-warning {
            background-color: #ffffff;
            color: #FF014F;
            border: 1px solid #FF014F;
        }
        .btn-warning:hover {
            background-color: #FF014F;
            color: #ffffff;
        }
    </style>
</head>
<body>
<%@ page import="lk.vihanganimsara.cms.dto.UserDto" %>
<%
    UserDto user = (UserDto) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
    int userId = user.getId();
%>

<div class="container">
    <form action="logout" method="post" style="text-align: right;">
        <button class="btn btn-danger btn-sm">Logout</button>
    </form>

    <div class="card">
        <div class="card-header">
            <h3>Complaint Management</h3>
        </div>
        <div class="card-body">
            <!-- New Complaint Form -->
            <h4 class="mb-3" style="color: #FF014F;">Submit New Complaint</h4>
            <form id="complaintForm" action="submitComplaint" method="post">
                <div class="mb-3">
                    <label for="uid" class="form-label">UserID</label>
                    <input type="text" class="form-control" id="uid" name="uid" value="<%= userId %>" readonly>

                    <div id="uidError" class="text-danger" style="display: none;">id is required</div>
                </div> <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                    <div id="titleError" class="text-danger" style="display: none;">Title is required</div>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    <div id="descriptionError" class="text-danger" style="display: none;">Description is required</div>
                </div>
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
            </form>

            <!-- Complaint List -->
            <h4 class="mt-4 mb-3" style="color: #FF014F;">Your Complaints</h4>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Sample data - replace with actual data from database
                    List<Map<String, String>> complaints = new ArrayList<>();
                    complaints.add(new HashMap<String, String>() {{ put("id", "1"); put("title", "Issue 1"); put("description", "First issue description"); put("status", "Pending"); }});
                    complaints.add(new HashMap<String, String>() {{ put("id", "2"); put("title", "Issue 2"); put("description", "Second issue description"); put("status", "Resolved"); }});
                    complaints.add(new HashMap<String, String>() {{ put("id", "3"); put("title", "Issue 3"); put("description", "Third issue description"); put("status", "Pending"); }});
                    for (Map<String, String> complaint : complaints) {
                %>
                <tr>
                    <td><%= complaint.get("id") %></td>
                    <td><%= complaint.get("title") %></td>
                    <td><%= complaint.get("description") %></td>
                    <td><%= complaint.get("status") %></td>
                    <td>
                        <% if ("Pending".equals(complaint.get("status"))) { %>
                        <a href="editComplaint?id=<%= complaint.get("id") %>" class="btn btn-warning btn-sm me-2">Edit</a>
                        <a href="deleteComplaint?id=<%= complaint.get("id") %>" class="btn btn-danger btn-sm">Delete</a>
                        <% } else { %>
                        <span class="text-muted">N/A</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        $('#complaintForm').on('submit', function(e) {
            let valid = true;
            const title = $('#title').val().trim();
            const description = $('#description').val().trim();

            $('.text-danger').hide();

            if (!title) {
                $('#titleError').show();
                valid = false;
            }
            if (!description) {
                $('#descriptionError').show();
                valid = false;
            }

            if (!valid) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>