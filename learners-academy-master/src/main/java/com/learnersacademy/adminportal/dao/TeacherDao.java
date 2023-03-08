package com.learnersacademy.adminportal.dao;

import com.learnersacademy.adminportal.entities.Teacher;

public class TeacherDao extends Dao<Teacher, Long> {
    public TeacherDao() {
        super(Teacher.class);
    }
}
