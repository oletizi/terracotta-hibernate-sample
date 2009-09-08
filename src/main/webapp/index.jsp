<html>
  <head><title>Terracotta Hibernate Sample</title></head>
  <body>
  <%
org.hibernate.tutorial.EventManager mgr = new org.hibernate.tutorial.EventManager();
java.util.List events = mgr.listEvents();
%>
<h1>Terracotta Hibernate Sample</h1>
<p>This is a sample of using Terracotta to cluster Hibernate's second-level cache.</p>
<hr>
<h2>Events</h2>
<p>When this application first starts, the database contains no event data, click
   the link below to add sample events, then come back here to the index to see
   the events that have been added.</p>
<p>Once you have added the sample data, this page will display a list of all
   the events in the database.  The database call to retrieve the list of all events is an HQL Query (see
   org.hibernate.tutorial.EventManager for details).  The second-level doesn't
   cache the results of HQL queries, so this page does not use the second-level
   cache.  For a good discussion of why query caching is not necessarily
   advisable, see Alex Miller's excellent blog topic on the subject: <a
   href="http://tech.puredanger.com/2009/07/10/hibernate-query-cache/">http://tech.puredanger.com/2009/07/10/hibernate-query-cache/</a></p>
<p>To see the Hibernate cache in action, click on a specific event.</p>
</p>
<% if (events.size() > 0) {%>
  <ol>
    <% for (java.util.Iterator<org.hibernate.tutorial.domain.Event> i = events.iterator(); i.hasNext();) {
    org.hibernate.tutorial.domain.Event event = i.next();
    %>
    <li><%="Event: " + event.getId() + ": " + event.getTitle()%> <a
        href="show-event.jsp?id=<%=event.getId()%>">Show event details</a></li>
    <% } %>
  </ol>
<% } else { %>
  <p>There are no events to view.</p>
<%}%>
  <p><a href="create-sample-data.jsp">Add sample events &raquo;</a></p>
</body>
</html>
