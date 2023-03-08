<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="styles/main.css">
    <link rel="stylesheet" href="styles/dashboard.css">
</head>
<body>

<div class="dashboard">
    <aside>
        <nav>
            <h1>Menu</h1>
            <a href="${pageContext.request.contextPath}/dashboard?page=classrooms">Classrooms</a>
            <a href="${pageContext.request.contextPath}/dashboard?page=students">Students</a>
            <a href="${pageContext.request.contextPath}/dashboard?page=teachers">Teachers</a>
            <a href="${pageContext.request.contextPath}/dashboard?page=subjects">Subjects</a>
        </nav>
    </aside>

    <main>
        <div class="error"><%= request.getAttribute("error") == null ? "" : request.getAttribute("error") %></div>
        <% if (request.getParameter("page") != null) { %>
            <% try { %>
                <jsp:include page="${param.page}.jsp"/>
            <% } catch (Exception e) { e.printStackTrace();%>
            <h3>Error Loading page <%=e.getLocalizedMessage()%></h3>
        <% }
        } %>
    </main>
</div>

</body>
</html>
