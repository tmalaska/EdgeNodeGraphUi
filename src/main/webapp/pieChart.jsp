<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");
String label = request.getParameter("label");
String value = request.getParameter("value");

String sourceType = request.getParameter("src");
String tableName = request.getParameter("tn");
String columnFamily = request.getParameter("cf");
String groupName = request.getParameter("gn");
String raduis = request.getParameter("raduis");
String amazing = request.getParameter("amazing");

%>

<!DOCTYPE html>
<meta charset="utf-8">
<style>

body {
  font: 10px sans-serif;
}

.arc path {
  stroke: #fff;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var width = 960,
    height = 500,
    radius = Math.min(width, height) / 2;

var color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var arc = d3.svg.arc()
    .outerRadius(radius - 10)<% if (raduis != null && raduis.equals("off")) { %>
    .innerRadius(0);
    <% } else { %>
    .innerRadius(radius - 60);
    <% } %>
    

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.<%= value%>; });

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

<%
if (sourceType != null && sourceType.equals("hdfs")) {
%>
d3.tsv("hdfsTsvServlet.tsv?fn=<%= fileName%>", function(error, data) {
<%
} else { 
%>
d3.tsv("HbaseGet.tsv?type=tsv&tn=<%= tableName%>&cf=<%= columnFamily%>&gn=<%= groupName%>&mr=10&keyNm=<%= label%>", function(error, data) {
<%
}
%>

  data.forEach(function(d) {
    d.<%= value%> = +d.<%= value%>;
  });

  var g = svg.selectAll(".arc")
      .data(pie(data))
    .enter().append("g")
      .attr("class", "arc");

  g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.<%= label%>); })<%
      if (amazing != null && amazing.equals("yes")) { %>
  	.transition()
  		.ease("bounce")
  		.duration(2000)
  		.attrTween("d", tweenPie);
	

	function tweenPie(b) {
		b.innerRadius = 0;
		var i = d3.interpolate({startAngle: 0, endAngle: 0}, b);
		return function(t) { return arc(i(t)); };
	}

	
<% } else { %>;<% } %>
  
  g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.<%= label%>; });

});

</script>