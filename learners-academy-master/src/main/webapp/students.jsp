<%@ page import="java.util.List" %>
<%@ page import="com.learnersacademy.adminportal.entities.Student" %>
<%@ page import="com.learnersacademy.adminportal.entities.Classroom" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<body>
<%
    List<Student> students = (List<Student>) request.getAttribute("students");
    List<Classroom> classrooms = (List<Classroom>) request.getAttribute("classrooms");
    Student editStudent = (Student) request.getAttribute("student");
    int counter = 0;
%>
<form method="post">
    <% if (editStudent != null) { %>
    <input type="hidden" name="id" value="<%= editStudent.getId() %>">
    <% } %>
    <span>
    <label>Enter Student Name
      <input type="text" value="<%=editStudent == null? "" : editStudent.getName()%>" name="name" maxlength="100"
             required/>
    </label>
  </span>
    <span>
    <label>Enter Student Classroom
      <select name="classroom" required>
          <% if (classrooms != null) {
              for (Classroom classroom : classrooms) { %>
                <option <%=editStudent == null || editStudent.getClassroom() == null ? "" : editStudent.getClassroom().getId()%>
                        value="<%=classroom.getId()%>"><%=classroom.getName()%></option>
          <%
                  }
              }
          %>
      </select>
    </label>
  </span>
    <span>
        <button type="submit">Save</button>
  </span>
</form>

<h1>Students</h1>
<% if (students == null || students.isEmpty()) {%>
<div>No Students added yet</div>
<% } else { %>
<table>
    <thead>
    <tr>
        <th>S/N</th>
        <th>Name</th>
        <th>Class</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Student student : students) { %>
    <tr>
        <td><%= ++counter %>
        </td>
        <td><%= student.getName() %>
        </td>
        <td><%= student.getClassroom() != null ? student.getClassroom().getName() : "No class assigned" %>
        </td>
        <td>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="edit">
                <input type="hidden" name="id" value="<%=student.getId()%>">
                <button type="submit">Edit</button>
            </form>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="delete">
                <input type="hidden" name="id" value="<%=student.getId()%>">
                <button class="danger" type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>
</body>
