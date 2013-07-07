<%@ page import="com.spinal.edgenodegraphui.dao.MainDao,
				com.spinal.edgenodegraphui.model.*,
				java.util.*" %>
<%
String id = request.getParameter("id");

DashBoardPojo dashBoardPojo;
if (id != null && id.isEmpty() == false) {
	dashBoardPojo = MainDao.getDashBoard(Integer.parseInt(id));
} else {
	dashBoardPojo = new DashBoardPojo();
	dashBoardPojo.setName("New DashBoard");
	dashBoardPojo.setNumberOfGraphs((byte)1);
	dashBoardPojo.setId(0);
	dashBoardPojo.setGraphs(new ArrayList<GraphPojo>());
	
}
ArrayList<GraphPojo> graphs = dashBoardPojo.getGraphs();

%>
<input type="hidden" name="dashBoardId" value="<%= dashBoardPojo.getId()%>"/>
DashBoard Name: <input type="text" name="dashBoardName" value="<%= dashBoardPojo.getName()%>"/>
Number of graphs: <input type="text" name="numberOfGraphs" value="<%= dashBoardPojo.getNumberOfGraphs()%>"/>

<%

GraphPojo graph = null;
for (int i = 0; i < 4; i++) {
	

	if (graphs.size() > i) {
		graph = graphs.get(i);
	} else {
		graph = new GraphPojo();
	}
%>


<span name="graph_<%= (i+1)%>">
Graph <%= (i+1)%>
Graph Title: <input type="text" name="title_<%= (i+1)%>" value="<%= graph.getTitle()%>"/>
Graph Type: <input type="text" name="graphType__<%= (i+1)%>" value="<%= graph.getGraphType()%>"/>
Refresh In Seconds: <input type="text" name="refreshInNSeconds_<%= (i+1)%>" value="<%= graph.getTitle()%>"/>


        
        String sourceType = request.getParameter("sourceType_" + i);
</span>

<%
}
%>


