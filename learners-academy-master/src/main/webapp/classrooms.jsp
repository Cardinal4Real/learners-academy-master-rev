<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.learnersacademy.adminportal.entities.*" %>
<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<body>
<%
    List<Classroom> classrooms = (List<Classroom>) request.getAttribute("classrooms");
    List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
    List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");

    Classroom editClassroom = (Classroom) request.getAttribute("classroom");
    System.out.println("EDit classroom is " + editClassroom);
    int counter = 0;
%>
<form method="post">
    <% if (editClassroom != null) { %>
    <input type="hidden" name="id" value="<%= editClassroom.getId() %>">
    <% } %>
    <span>
    <label>Enter Classroom Name
      <input type="text" value="<%=editClassroom == null? "" : editClassroom.getName()%>" name="name" maxlength="100"
             required/>
    </label>
  </span>
    <span>
        <button type="submit">Save</button>
  </span>
</form>

<%if(Boolean.parseBoolean(Optional.ofNullable(request.getAttribute("reports")).orElse("").toString()) && editClassroom != null) {
    List<TeacherSubject> teacherSubjects = editClassroom.getTeacherSubject();
    List<Student> students = (List<Student>) request.getAttribute("classStudents");
    Set<Teacher> teachers1 = new HashSet<>();
    Set<Subject> subjects1 = new HashSet<>();
    for (TeacherSubject ts: teacherSubjects) {
        teachers1.add(ts.getTeacher());
        subjects1.add(ts.getSubject());
    }
    request.setAttribute("reports", null);
%>
<h1>Reports</h1>

<h3>Total Teachers: <%=teachers1.size()%> </h3>
<h3>Total Subjects: <%=subjects1.size()%>  </h3>
<h3>Total Students: <%= students != null ? students.size() : 0%>  </h3>

<table>
    <thead>
    <tr>
        <th>Teachers/Subjects</th>
        <th>Students</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
            <%for (TeacherSubject ts : teacherSubjects) {%>
            <div><%= ts.getTeacher().getName() %> (<%=ts.getSubject().getName()%>)
                <span>
                        <form style="display: inline-block; margin: 0" method="post">
                            <input type="hidden" name="method" value="deleteTeacherSubject">
                            <input type="hidden" name="id" value="<%=ts.getId()%>">
                            <button class="danger" style="padding: 2px 8px; margin: 0; min-height: unset" type="submit">x</button>
                        </form>
                    </span>
            </div>
            <%}%>
        </td>
        <td>
            <%if(students != null) { for (Student ts : students) {%>
            <div><%= ts.getName() %></div>
            <%}}%>
        </td>

    </tr>
    <tr></tr>
    </tbody>
</table>
<%%>
<%%>
<%}%>

<h1>Classrooms</h1>
<% if (classrooms == null || classrooms.isEmpty()) {%>
<div>No Classrooms added yet</div>
<% } else { %>
<table>
    <thead>
    <tr>
        <th>S/N</th>
        <th>Name</th>
        <th>Add Subject/Teacher</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Classroom classroom : classrooms) { %>
    <tr>
        <td><%= ++counter %>
        </td>
        <td><%= classroom.getName() %>
        </td>
        <td>
<%--            <%if(classroom.getTeacherSubject() !=null) {--%>
<%--                for(TeacherSubject ts: classroom.getTeacherSubject()) {--%>
<%--            %>--%>
<%--                <div>--%>
<%--                    <%= ts.getTeacher().getName() + " teaches " + ts.getSubject().getName()%>--%>
<%--                    <span>--%>
<%--                        <form style="display: inline-block" method="post">--%>
<%--                            <input type="hidden" name="method" value="deleteTeacherSubject">--%>
<%--                            <input type="hidden" name="id" value="<%=ts.getId()%>">--%>
<%--                            <button class="danger" style="padding: 2px; margin: 0; min-height: unset" type="submit">x</button>--%>
<%--                        </form>--%>
<%--                    </span>--%>
<%--                </div>--%>
<%--            <%}}%>--%>
            <form method="post">
                <input type="hidden" name="method" value="createTeacherSubject">
                <input type="hidden" name="id" value="<%=classroom.getId()%>">
                <label>
                    Teacher
                    <select required name="teacher">
                        <option hidden>Select One...</option>
                        <%if (teachers != null) {%>
                        <%for (Teacher teacher : teachers) {%>
                        <option value="<%=teacher.getId()%>"><%=teacher.getName()%>
                        </option>
                        <%}%>
                        <%}%>
                    </select>
                </label>
                <label>
                    Subject
                    <select required name="subject">
                        <option hidden>Select One...</option>
                        <%if (subjects != null) {%>
                        <%for (Subject subject : subjects) {%>
                        <option value="<%=subject.getId()%>"><%=subject.getName()%>
                        </option>
                        <%}%>
                        <%}%>
                    </select> </label>
                <button type="submit">Add</button>
            </form>
        </td>
        <td>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="edit">
                <input type="hidden" name="id" value="<%=classroom.getId()%>">
                <button type="submit">Edit</button>
            </form>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="delete">
                <input type="hidden" name="id" value="<%=classroom.getId()%>">
                <button class="danger" type="submit">Delete</button>
            </form>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="reports">
                <input type="hidden" name="id" value="<%=classroom.getId()%>">
                <button type="submit">View Reports</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>
</body>
