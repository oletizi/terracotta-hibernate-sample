package org.hibernate.tutorial;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import java.util.*;

import org.hibernate.tutorial.domain.Event;
import org.hibernate.tutorial.util.HibernateUtil;

public class EventManager {

  private final SessionFactory sessionFactory;

  public EventManager() {
    // XXX: This should be removed in favor of an application-startup-time resource manager.
    this(HibernateUtil.getSessionFactory());
  }

  public EventManager(final SessionFactory s) {
    this.sessionFactory = s;
  }

  public Event getEventById(Long id) {
    final Session session = getSession();
    final Transaction transaction = session.beginTransaction();
    final Event event = (Event)session.get(Event.class, id);
    transaction.commit();
    return event;
  }

  public List listEvents() {
    Session session = sessionFactory.getCurrentSession();
    session.beginTransaction();
    List result = session.createQuery("from Event").list();
    session.getTransaction().commit();
    return result;
  }
  
  /**
   * Adds 10 new events to initially populate the datase.
   */
  public int insertSampleData() {
    final int count = 10;
    Session session = sessionFactory.getCurrentSession();
    session.beginTransaction();
    for (int i=0; i<count; i++) {
      session.save(prepareEvent("My Event", new Date()));
    }
    session.getTransaction().commit();
    return count;
  }

  public void createAndStoreEvent(String title, Date theDate) {
    Session session = sessionFactory.getCurrentSession();
    session.beginTransaction();
    session.save(prepareEvent(title, theDate));
    session.getTransaction().commit();
  }

  private Event prepareEvent(final String title, final Date theDate) {
    Event event = new Event();
    event.setTitle(title);
    event.setDate(theDate);
    return event;
  }

  private Session getSession() {
    return sessionFactory.getCurrentSession();
  }

  public static void main(String[] args) {
    final SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    final EventManager mgr = new EventManager(sessionFactory);
    
    if (args[0].equals("store")) {
      mgr.createAndStoreEvent("My Event", new Date());
    }
    else if (args[0].equals("list")) {
      List events = mgr.listEvents();
      for (int i = 0; i < events.size(); i++) {
	Event theEvent = (Event) events.get(i);
	System.out.println(
	  "Event: " + theEvent.getTitle() + " Time: " + theEvent.getDate()
	  );
      }
    }
    HibernateUtil.getSessionFactory().close();
  }



}