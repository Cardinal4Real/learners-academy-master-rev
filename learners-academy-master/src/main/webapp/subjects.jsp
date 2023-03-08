<%@ page import="java.util.List" %>
<%@ page import="com.learnersacademy.adminportal.entities.Subject" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<body>
<%
    List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
    Subject editSubject = (Subject) request.getAttribute("subject");
    int counter = 0;
%>
<form method="post">
    <% if (editSubject != null) { %>
    <input type="hidden" name="id" value="<%= editSubject.getId() %>">
    <% } %>
    <span>
    <label>Enter Subject Name
      <input type="text" value="<%=editSubject == null? "" : editSubject.getName()%>" name="name" maxlength="100"
             required/>
    </label>
  </span>
    <span>
    <label>Select Description
        <textarea name="description"
                  maxlength="255"><%=editSubject == null ? "" : editSubject.getDescription()%> </textarea>
    </label>
  </span>
    <span>
        <button type="submit">Save</button>
  </span>
</form>

<h1>Subjects</h1>
<% if (subjects == null || subjects.isEmpty()) {%>
<div>No Subjects added yet</div>
<% } else { %>
<table>
    <thead>
    <tr>
        <th>S/N</th>
        <th>Name</th>
        <th>Description</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Subject subject : subjects) { %>
    <tr>
        <td><%= ++counter %>
        </td>
        <td><%= subject.getName() %>
        </td>
        <td><%= subject.getDescription() %>
        </td>
        <td>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="edit">
                <input type="hidden" name="id" value="<%=subject.getId()%>">
                <button type="submit">Edit</button>
            </form>
            <form style="display: inline-block" method="post">
                <input type="hidden" name="method" value="delete">
                <input type="hidden" name="id" value="<%=subject.getId()%>">
                <button class="danger" type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>
</body>
