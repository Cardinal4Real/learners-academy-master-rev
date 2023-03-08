package com.learnersacademy.adminportal.dao;

import com.learnersacademy.adminportal.entities.Classroom;
import com.learnersacademy.adminportal.entities.Student;

import javax.persistence.TypedQuery;
import java.util.List;

public class StudentDao extends Dao<Student, Long> {
    public StudentDao() {
        super(Student.class);
    }

    public List<Student> findAllByClassroom(Classroom classroom) {
        TypedQuery<Student> tq = DbResource.getSession().createQuery("select e from Student e where e.classroom=:classroom ");
		tq.setParameter("classroom", classroom);
        return tq.getResultList();
    }
}
