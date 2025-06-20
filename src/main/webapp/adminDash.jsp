<%--
  Created by IntelliJ IDEA.
  User: KVN2004
  Date: 6/20/2025
  Time: 9:36 PM
  To change this template use File | Settings | File Templates.
--%>
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
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            font-family: 'Arial', sans-serif;
            color: #ffffff;
        }
        .container {
            max-width: 1000px;
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
        .form-control, .form-select {
            background-color: #2a2a2a;
            border: 1px solid #FF014F;
            color: #ffffff;
        }
        .form-control:focus, .form-select:focus {
            background-color: #2a2a2a;
            border-color: #FF014F;
            box-shadow: 0 0 5px rgba(255, 1, 79, 0.5);
            color: #ffffff;
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
        .btn-success {
            background-color: #ffffff;
            color: #FF014F;
            border: 1px solid #FF014F;
        }
        .btn-success:hover {
            background-color: #FF014F;
            color: #ffffff;
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
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h3>Admin Dashboard</h3>
        </div>
        <div class="card-body">
            <!-- Complaint Management Section -->
            <h4 class="mb-3" style="color: #FF014F;">Complaint Management</h4>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Sample complaint data - replace with actual data from database
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
                    <td>
                        <select class="form-select" name="status_<%= complaint.get("id") %>" onchange="updateStatus('<%= complaint.get("id") %>', this.value)">
                            <option value="Pending" <%= "Pending".equals(complaint.get("status")) ? "selected" : "" %>>Pending</option>
                            <option value="Resolved" <%= "Resolved".equals(complaint.get("status")) ? "selected" : "" %>>Resolved</option>
                        </select>
                    </td>
                    <td>
                        <a href="deleteComplaint?id=<%= complaint.get("id") %>" class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>