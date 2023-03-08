package com.learnersacademy.adminportal.dao;

import com.learnersacademy.adminportal.entities.Classroom;

public class ClassroomDao extends Dao<Classroom, Long> {
    public ClassroomDao() {
        super(Classroom.class);
    }
}
