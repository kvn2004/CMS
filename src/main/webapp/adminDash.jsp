<%--
  Created by IntelliJ IDEA.
  User: KVN2004
  Date: 6/20/2025
  Time: 9:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="lk.vihanganimsara.cms.dto.ComplainDto" %>
<%
    List<ComplainDto> complaints = (List<ComplainDto>) request.getAttribute("complaints");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
        .form-select {
            background-color: #2a2a2a;
            border: 1px solid #FF014F;
            color: #ffffff;
        }
        .form-select:focus {
            background-color: #2a2a2a;
            border-color: #FF014F;
            box-shadow: 0 0 5px rgba(255, 1, 79, 0.5);
            color: #ffffff;
        }
        .btn-success, .btn-danger {
            background-color: #ffffff;
            color: #FF014F;
            border: 1px solid #FF014F;
        }
        .btn-success:hover, .btn-danger:hover {
            background-color: #FF014F;
            color: #ffffff;
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
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h3>Admin Dashboard</h3>
        </div>
        <div class="card-body">
            <h4 class="mb-3" style="color: #FF014F;">Complaint Management</h4>
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
                <% if (complaints != null && !complaints.isEmpty()) {
                    for (ComplainDto complaint : complaints) { %>
                <tr>
                    <td><%= complaint.getId() %></td>
                    <td><%= complaint.getTitle() %></td>
                    <td><%= complaint.getDescription() %></td>
                    <td>
                        <form action="adminDashboard" method="post" style="display: inline-block;">
                            <input type="hidden" name="mode" value="update" />
                            <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                            <select class="form-select form-select-sm" name="status" onchange="this.form.submit()">
                                <option value="Pending" <%= "Pending".equalsIgnoreCase(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="Resolved" <%= "Resolved".equalsIgnoreCase(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                            </select>
                        </form>
                    </td>
                    <td>
                        <form action="adminDashboard" method="post" style="display:inline;">
                            <input type="hidden" name="mode" value="delete" />
                            <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
                <%  }
                } else { %>
                <tr>
                    <td colspan="5" class="text-center">No complaints found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
