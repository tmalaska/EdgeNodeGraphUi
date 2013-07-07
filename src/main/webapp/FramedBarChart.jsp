<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");
String yname = request.getParameter("yname");
String xname = request.getParameter("xname");
%>

<html>

<FRAMESET cols="50%, 50%">
	<FRAME src="/engui/barChart.jsp?fn=<%= fileName%>&yname=<%= yname%>&xname=<%= xname%>">
	<FRAME src="/engui/stackedBarChart.jsp?fn=<%= fileName%>&yname=<%= yname%>&xname=<%= xname%>">
</FRAMESET>

</html>