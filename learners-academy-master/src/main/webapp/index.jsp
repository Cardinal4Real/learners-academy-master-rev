<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="styles/main.css">
    <link rel="stylesheet" href="styles/login.css">
</head>
<body>
<div class="container">
    <h1>Learners' Academy</h1>
    <div class="error"><%= request.getAttribute("error") == null ? "" : request.getAttribute("error") %></div>
    <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="email">
            <label for="username">Username</label>
            <div class="sec-2">
                <input type="text" id="username" name="username" placeholder="" required />
            </div>
        </div>
        <div class="password">
            <label for="password">Password</label>
            <div class="sec-2">
                <input id="password" class="pas" type="password" name="password" placeholder="" required />
            </div>
        </div>
        <button class="login">Login</button>
    </form>
    <% request.removeAttribute("error"); %>
</div>
</body>
</html>
