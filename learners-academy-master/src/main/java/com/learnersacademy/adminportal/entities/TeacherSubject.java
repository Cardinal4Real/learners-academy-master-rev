package com.learnersacademy.adminportal.entities;

import javax.persistence.*;

@Entity
@Table(name="teacher_subjects")
public class TeacherSubject {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @OneToOne
    private Teacher teacher;
    @OneToOne
    private Subject subject;
    @Column(name = "classroom_id")
    private Long classroomId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public Long getClassroomId() {
        return classroomId;
    }

    public void setClassroomId(Long classroomId) {
        this.classroomId = classroomId;
    }

    @Override
    public String toString() {
        return "TeacherSubject{" +
                "id=" + id +
                ", teacher=" + teacher +
                ", subject=" + subject +
                ", classroom=" + classroomId +
                '}';
    }
}
