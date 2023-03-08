package com.learnersacademy.adminportal.dao;

import com.learnersacademy.adminportal.entities.Subject;

public class SubjectDao extends Dao<Subject, Long> {
    public SubjectDao() {
        super(Subject.class);
    }
}
