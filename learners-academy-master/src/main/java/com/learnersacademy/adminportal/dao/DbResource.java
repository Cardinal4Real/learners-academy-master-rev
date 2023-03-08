package com.learnersacademy.adminportal.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import javax.persistence.FlushModeType;

public class DbResource {

	private static Session session;
	
	private static SessionFactory getSessionFactory() {
		Configuration con = new Configuration();
		con.configure("hibernate.cfg.xml");
		return con.buildSessionFactory();
	}

	public static Session getSession() {
		if(session == null || !session.isOpen() || !session.isConnected()) {
			session = getSessionFactory().openSession();
			session.setFlushMode(FlushModeType.COMMIT);
		}
		return session;
	}
}
