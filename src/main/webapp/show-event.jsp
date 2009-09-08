<html>
  <head><title>Terracotta Hibernate Sample: Show Event</title></head>
  <body>
    <%
       final org.hibernate.tutorial.EventManager mgr = new org.hibernate.tutorial.EventManager();
       final String idString = request.getParameter("id");
       // XXX: Production code would do some more interesting input validation than this.  And, also
       // not have this kind of default behavior.
       final Long id = idString == null ? new Long(1) : new Long(idString);
       final org.hibernate.tutorial.domain.Event event = mgr.getEventById(id);
     %>
    <h1>Terracotta Hibernate Sample: Show Event</h1>
    <strong>Current Time:</strong> <%=new java.util.Date()%><br>
    <strong>Event</strong>: <%=event.getId()%><br>
    <strong>Title:</strong> <%=event.getTitle()%><br>
    <strong>Date:</strong> <%=event.getDate()%><br>

    <p><a href="index.jsp">&laquo; Back to Index</a></p>
  </body>
</html>
