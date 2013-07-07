<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");
String label = request.getParameter("label");
String value = request.getParameter("value");

String sourceType = request.getParameter("src");
String tableName = request.getParameter("tn");
String columnFamily = request.getParameter("cf");
String groupName = request.getParameter("gn");
String easeStyle = request.getParameter("easeStyle");
String raduis = request.getParameter("raduis");

int refreshSec = Integer.parseInt(request.getParameter("refreshSec"));


refreshSec = Math.min(refreshSec, 5);


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
    .outerRadius(radius - 10)<% if (raduis != null && raduis.equals("on")) { %>
    .innerRadius(radius - 80);
    <% } else { %>
    .innerRadius(0);
    <% } %>
    

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.<%= value%>; });
    

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

var originData;


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
	
	originData = data;
	
  data.forEach(function(d) {
    d.<%= value%> = +d.<%= value%>;
  });

  var g = svg.selectAll(".arc")
      .data(pie(data))
    .enter().append("g")
      .attr("class", "arc");

  g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.<%= label%>); });

  g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.<%= label%>; });

});

var timeout = setTimeout(function() {
	refreshDataFromSource();
	}, <%= refreshSec%>000);

var newData;

function refreshDataFromSource() {
	var debug2 = "*";
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


	  paths = svg.selectAll("path");
		
	  data.forEach(function(d) {
	    d.<%= value%> = +d.<%= value%>;
	    
	    
	  });
	  
	  newData = data;
	  
	  newPie = pie(data);
	  
	  for (var pi = 0; pi < newPie.length; pi++) {
		  p = newPie[pi];
		  for (var i = 0; i < paths[0].length; i++) {
	    	  if (paths[0][i].__data__.data.<%= label%> == p.data.<%= label%>) {
	    		  
	    		  paths[0][i].__data__.data.oldSA = paths[0][i].__data__.startAngle;
	    		  paths[0][i].__data__.data.oldEA = paths[0][i].__data__.endAngle;
	    		  
	    		  paths[0][i].__data__.startAngle = p.startAngle;
	    		  paths[0][i].__data__.endAngle = p.endAngle;
	    		  paths[0][i].__data__.value = p.value;
	    		  paths[0][i].__data__.data.<%= value%> = p.value;
	    	  }
	      }
	   }
		


	  var g = svg.selectAll(".arc");
	  

	  g.select("text").remove();
      
	  g.selectAll("path").transition()
	    .ease("<%= easeStyle%>")
  		.duration(1000).attrTween("d", tweenPie);
	  
	 function tweenPie(b) {
			b.innerRadius = 0;
			var i = d3.interpolate({startAngle: b.data.oldSA, endAngle: b.data.oldEA}, b);
			return function(t) { return arc(i(t)); };
		}
	  
	  
	  
	  g.append("text")
	      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
	      .attr("dy", ".35em")
	      .style("text-anchor", "middle")
	      .text(function(d) { return d.data.<%= label%>; });
	  
	  originData = newData;
	  
	  
	});

	timeout = setTimeout(function() {
		refreshDataFromSource();
		}, <%= refreshSec%>500);
	
}

</script>