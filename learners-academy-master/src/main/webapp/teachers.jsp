<%@ page import="java.util.List" %>
<%@ page import="com.learnersacademy.adminportal.entities.Teacher" %>
<%@ page import="com.learnersacademy.adminportal.entities.Classroom" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<body>
<%
    List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
    List<Classroom> classrooms = (List<Classroom>) request.getAttribute("classrooms");
    Teacher editTeacher = (Teacher) request.getAttribute("teacher");
    int counter = 0;
%>
<form method="post">
    <% if (editTeacher != null) { %>
    <input type="hidden" name="id" value="<%= editTeacher.getId() %>">
    <% } %>
    <span>
    <label>Enter Teacher Name
      <input type="text" value="<%=editTeacher == null? "" : editTeacher.getName()%>" name="name" maxlength="100"
             required/>
    </label>
  </span>
    <span>
        <button type="submit">Save</button>
  </span>
</form>

<h1>Teachers</h1>
<% if (teachers == null || teachers.isEmpty()) {%>
<div>No Teachers added yet</div>
<% } else { %>
<table>
    <thead>
    <tr>
        <th>S/N</th>
        <th>Name</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Teacher teacher : teachers) { %>
    <tr>
        <td><%= ++counter %>
        </td>
        <td><%= teacher.getName() %>
        </td>
        <td>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="edit">
                <input type="hidden" name="id" value="<%=teacher.getId()%>">
                <button type="submit">Edit</button>
            </form>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="delete">
                <input type="hidden" name="id" value="<%=teacher.getId()%>">
                <button class="danger" type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>
</body>
