package com.learnersacademy.adminportal.controllers;

import com.learnersacademy.adminportal.dao.*;
import com.learnersacademy.adminportal.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {

    private TeacherDao teacherDao;
    private ClassroomDao classroomDao;
    private SubjectDao subjectDao;
    private StudentDao studentDao;
    private TeacherSubjectDao teacherSubjectDao;

    public void init() {
        teacherDao = new TeacherDao();
        classroomDao = new ClassroomDao();
        subjectDao = new SubjectDao();
        studentDao = new StudentDao();
        teacherSubjectDao = new TeacherSubjectDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String page = Optional.ofNullable(req.getParameter("page")).orElse("");
            switch (page) {
                case "classrooms":
                    handleClassroomAction(req, resp);
                    break;
                case "students":
                    handleStudentAction(req, resp);
                    break;
                case "subjects":
                    handleSubjectAction(req, resp);
                    break;
                case "teachers":
                    handleTeacherAction(req, resp);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            System.out.println("Error occurred " + e.getLocalizedMessage());
            req.setAttribute("error", e.getLocalizedMessage());
        }
        doGet(req, resp);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String page = Optional.ofNullable(req.getParameter("page")).orElse("");
        List<Teacher> teachers = null;
        List<Student> students = null;
        List<Subject> subjects = null;
        List<Classroom> classrooms = null;

        switch (page) {
            case "students":
                students = studentDao.findAll();
                classrooms = classroomDao.findAll();
                break;
            case "classrooms":
                teachers = teacherDao.findAll();//dont break;
            case "subjects":
                subjects = subjectDao.findAll();
                classrooms = classroomDao.findAll();
                break;
            case "teachers":
                teachers = teacherDao.findAll();
                break;
            default:
                break;
        }
        req.setAttribute("students", students);
        req.setAttribute("classrooms", classrooms);
        req.setAttribute("subjects", subjects);
        req.setAttribute("teachers", teachers);

        req.getRequestDispatcher("/dashboard.jsp?page=" + page).forward(req, resp);
    }

    private void handleClassroomAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        String subject = req.getParameter("subject");
        String teacher = req.getParameter("teacher");
        String method = Optional.ofNullable(req.getParameter("method")).orElse("create");

        switch (method) {
            case "edit":
                Classroom classroom = classroomDao.findOne(Long.parseLong(id));
                req.setAttribute("classroom", classroom);
                break;
            case "delete":
                System.out.println("Deleting item with id " + Long.parseLong(id));
                classroomDao.deleteOne(Long.parseLong(id));
                break;
            case "deleteTeacherSubject":
                System.out.println("Deleting teacher subject mapping with id " + Long.parseLong(id));
                teacherSubjectDao.deleteOne(Long.parseLong(id));
                break;
            case "createTeacherSubject":
                TeacherSubject teacherSubject = new TeacherSubject();
                try {
                    teacherSubject.setSubject(subjectDao.findOne(Long.parseLong(subject)));
                } catch (NumberFormatException ignored) {}
                try {
                    teacherSubject.setTeacher(teacherDao.findOne(Long.parseLong(teacher)));
                } catch (NumberFormatException ignored) {}
                try {
                    teacherSubject.setClassroomId(Long.parseLong(id));
                } catch (NumberFormatException ignored) {}
                teacherSubjectDao.save(teacherSubject);
                break;
            case "reports":
                classroom = classroomDao.findOne(Long.parseLong(id));
                req.setAttribute("classroom", classroom);
                req.setAttribute("reports", true);
                req.setAttribute("classStudents", studentDao.findAllByClassroom(classroom));
//                System.out.println("Classroom is " + classroom);
                System.out.println("Students are " + req.getAttribute("students"));
                break;
            default:
                try {
                    classroom = classroomDao.findOne(Long.parseLong(id));
//                    System.out.println("Editing " + classroom);
                } catch (Exception e) {
                    classroom = new Classroom();
                }
                classroom.setName(name);
                classroomDao.save(classroom);
                break;
        }
    }

    private void handleStudentAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String classroom = req.getParameter("classroom");
        String id = req.getParameter("id");
        String method = Optional.ofNullable(req.getParameter("method")).orElse("create");

        switch (method) {
            case "edit":
                Student student = studentDao.findOne(Long.parseLong(id));
                req.setAttribute("student", student);
                doGet(req, resp);
                break;
            case "delete":
                System.out.println("Deleting item with id " + Long.parseLong(id));
                studentDao.deleteOne(Long.parseLong(id));
                break;
            default:
                try {
                    student = studentDao.findOne(Long.parseLong(id));
                    System.out.println("Editing " + student);
                } catch (Exception e) {
                    student = new Student();
                }
                try {
                    student.setClassroom(classroomDao.findOne(Long.parseLong(classroom)));
                } catch (Exception ignored) {}
                student.setName(name);
                studentDao.save(student);
                break;
        }
    }

    private void handleSubjectAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        String id = req.getParameter("id");
        String method = Optional.ofNullable(req.getParameter("method")).orElse("create");

        switch (method) {
            case "edit":
                Subject subject = subjectDao.findOne(Long.parseLong(id));
                req.setAttribute("subject", subject);
                req.setAttribute("subjects", subjectDao.findAll());
                req.setAttribute("classrooms", classroomDao.findAll());
                doGet(req, resp);
                break;
            case "delete":
                System.out.println("Deleting item with id " + Long.parseLong(id));
                subjectDao.deleteOne(Long.parseLong(id));
                break;
            default:
                try {
                    subject = subjectDao.findOne(Long.parseLong(id));
                    System.out.println("Editing " + subject);
                }
                catch (Exception e) {
                    subject = new Subject();
                }
                subject.setName(name);
                subject.setDescription(desc);
                subjectDao.save(subject);
                break;
        }
    }

    private void handleTeacherAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String id = req.getParameter("id");
        String method = Optional.ofNullable(req.getParameter("method")).orElse("create");

        switch (method) {
            case "edit":
                Teacher teacher = teacherDao.findOne(Long.parseLong(id));
                req.setAttribute("teacher", teacher);
                req.setAttribute("teachers", teacherDao.findAll());
                doGet(req, resp);
                break;
            case "delete":
                System.out.println("Deleting item with id " + Long.parseLong(id));
                teacherDao.deleteOne(Long.parseLong(id));
                break;
            default:
                try {
                    teacher = teacherDao.findOne(Long.parseLong(id));
                    System.out.println("Editing " + teacher);
                }
                catch (Exception e) {
                    teacher = new Teacher();
                }
                teacher.setName(name);
                teacherDao.save(teacher);
                break;
        }
    }

}