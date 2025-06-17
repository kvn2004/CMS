<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/signin.css">
</head>
<body>
<div class="card">
    <h2>Sign In</h2>
    <form id="signinForm" action="signin" method="post">
        <div class="mb-3">
            <label for="email" class="form-label text-white">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <div id="emailError" class="error">Valid email is required</div>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label text-white">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div id="passwordError" class="error">Password is required</div>
        </div>
        <button type="submit" class="btn btn-primary">Sign In</button>
        <div class="form-text">
            Don't have an account? <a href="signup.jsp">Sign Up</a>
        </div>
    </form>
</div>

<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%--<script>--%>
<%--    $(document).ready(function() {--%>
<%--        $('#signinForm').on('submit', function(e) {--%>
<%--            let valid = true;--%>
<%--            const email = $('#email').val().trim();--%>
<%--            const password = $('#password').val().trim();--%>

<%--            // Reset error messages--%>
<%--            $('.error').hide();--%>

<%--            // Validate email--%>
<%--            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;--%>
<%--            if (!emailPattern.test(email)) {--%>
<%--                $('#emailError').show();--%>
<%--                valid = false;--%>
<%--            }--%>

<%--            // Validate password--%>
<%--            if (password === '') {--%>
<%--                $('#passwordError').show();--%>
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