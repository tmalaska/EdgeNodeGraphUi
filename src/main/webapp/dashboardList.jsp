<%@ page import="com.spinal.edgenodegraphui.dao.MainDao,
				com.spinal.edgenodegraphui.model.*,
				java.util.HashMap" %>
DashBoards:

<table>
 <tr>
  <td>Name</td>
  <td>Num of Graphs</td>
  <td>View</td>
  <td>Edit</td>
  <td>Delete</td>
 </tr>
<%
HashMap<Integer, DashBoardPojo> dashBoardMap = MainDao.getDashBoards();

for (DashBoardPojo dashBoard: dashBoardMap.values()) {
	
%>
<tr>
 <td><%= dashBoard.getName() %></td>
 <td><%= dashBoard.getNumberOfGraphs() %></td>
 <td>View</td>
 <td>Edit</td>
 <td>Delete</td>
</tr>
<%
}
%>

</table>