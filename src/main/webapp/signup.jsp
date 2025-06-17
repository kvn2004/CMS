<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/signup.css">
</head>
<body>
<div class="card">
    <h2>Sign Up</h2>
    <form id="signupForm" action="signup" method="post">
        <div class="mb-3">
            <label for="username" class="form-label text-white">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
            <div id="usernameError" class="error">Username is required</div>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label text-white">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <div id="emailError" class="error">Valid email is required</div>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label text-white">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div id="passwordError" class="error">Password must be at least 6 characters</div>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label text-white">Role</label>
            <select class="form-select" id="role" name="role" required>
                <option value="" disabled selected>Select a role</option>
                <option value="EMPLOYEE">EMPLOYEE</option>
                <option value="ADMIN">ADMIN</option>
            </select>
            <div id="roleError" class="error">Role is required</div>
        </div>
        <button type="submit" class="btn btn-primary">Sign Up</button>
        <div class="form-text">
            Already have an account? <a href="signin.jsp">Sign In</a>
        </div>
    </form>
</div>
<% if (request.getAttribute("message") != null) { %>
<script>
    alert("<%= request.getAttribute("message") %>");
</script>
<% } %>
<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%--<script>--%>
<%--    $(document).ready(function() {--%>
<%--        $('#signupForm').on('submit', function(e) {--%>
<%--            let valid = true;--%>
<%--            const username = $('#username').val().trim();--%>
<%--            const email = $('#email').val().trim();--%>
<%--            const password = $('#password').val().trim();--%>
<%--            const role = $('#role').val();--%>

<%--            // Reset error messages--%>
<%--            $('.error').hide();--%>

<%--            // Validate username--%>
<%--            if (username === '') {--%>
<%--                $('#usernameError').show();--%>
<%--                valid = false;--%>
<%--            }--%>

<%--            // Validate email--%>
<%--            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;--%>
<%--            if (!emailPattern.test(email)) {--%>
<%--                $('#emailError').show();--%>
<%--                valid = false;--%>
<%--            }--%>

<%--            // Validate password--%>
<%--            if (password.length < 6) {--%>
<%--                $('#passwordError').show();--%>
<%--                valid = false;--%>
<%--            }--%>

<%--            // Validate role--%>
<%--            if (!role || role === '') {--%>
<%--                $('#roleError').show();--%>
<%--                valid = false;--%>
<%--            }--%>

<%--            if (!valid) {--%>
<%--                e.preventDefault();--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>