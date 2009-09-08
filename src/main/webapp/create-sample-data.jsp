<html>
 <head><title>Terracotta Hibernate Sample</title></head>
 <body>
   <%
      org.hibernate.tutorial.EventManager mgr = new org.hibernate.tutorial.EventManager();
      int count = mgr.insertSampleData();
    %>
    <h1>Terracotta Hibernate Sample: Create Sample Data</h1>
    <strong>Events Created: </strong> <%=count%>.

    <p><a href="index.jsp">&laquo; Back to Index</a></p>
    </p>
 </body>
</html>
