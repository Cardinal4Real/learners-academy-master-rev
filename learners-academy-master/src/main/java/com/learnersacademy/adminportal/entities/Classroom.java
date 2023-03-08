package com.learnersacademy.adminportal.entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="classrooms")
public class Classroom {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "classroom_id")
    private List<TeacherSubject> teacherSubject;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<TeacherSubject> getTeacherSubject() {
        return teacherSubject;
    }

    public void setTeacherSubject(List<TeacherSubject> teacherSubject) {
        this.teacherSubject = teacherSubject;
    }

    @Override
    public String toString() {
        return "Classroom{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", teacherSubject=" + teacherSubject +
                '}';
    }
}
