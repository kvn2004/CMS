<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Signup</title>
</head>
<body>
<h2>Register</h2>
<form action="signup" method="post">
    <label>Username:</label><br>
    <input type="text" name="username"><br>

    <label>Password:</label><br>
    <input type="password" name="password"><br>

    <label>Email:</label><br>
    <input type="email" name="email"><br>

    <label>Role:</label><br>
    <input type="text" name="role"><br><br>

    <input type="submit" value="Register">
</form>

<%-- Show feedback if present --%>
<p style="color:green;"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></p>
</body>
</html>
