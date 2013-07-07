<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");
String xname = request.getParameter("xname");
String yname = request.getParameter("yname");

String sourceType = request.getParameter("src");
String tableName = request.getParameter("tn");
String columnFamily = request.getParameter("cf");
String groupName = request.getParameter("gn");
String easeStyle = request.getParameter("easeStyle");

int refreshSec = Integer.parseInt(request.getParameter("refreshSec"));


refreshSec = Math.min(refreshSec, 5);


%>

<!DOCTYPE html>
<meta charset="utf-8">
<style>

body {
  font: 10px sans-serif;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.bar {
  fill: steelblue;
}

.x.axis path {
  display: none;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var formatPercent = d3.format(".0%");

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var y = d3.scale.linear()
    .range([height, 0]);
    
var xOld = d3.scale.ordinal()
.rangeRoundBands([0, width], .1);

var yOld = d3.scale.linear()
.range([height, 0]);    

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(formatPercent);

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

<%
if (sourceType != null && sourceType.equals("hdfs")) {
%>
d3.tsv("hdfsTsvServlet.tsv?fn=<%= fileName%>", function(error, data) {
<%
} else { 
%>
d3.tsv("HbaseGet.tsv?type=tsv&tn=<%= tableName%>&cf=<%= columnFamily%>&gn=<%= groupName%>&mr=10&keyNm=<%= xname%>", function(error, data) {
<%
}
%>	

  data.forEach(function(d) {
    d.<%= yname%> = +d.<%= yname%>;
  });

  x.domain(data.map(function(d) { return d.<%= xname%>; }));
  y.domain([0, d3.max(data, function(d) { return d.<%= yname%>; })]);

  xOld.domain(data.map(function(d) { return d.<%= xname%>; }));
  yOld.domain([0, d3.max(data, function(d) { return d.<%= yname%>; })]);
  
  
  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("<%= yname%>");

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.<%= xname%>); })
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.<%= yname%>); })
      .attr("height", function(d) { return height - y(d.<%= yname%>); });


});

var timeout = setTimeout(function() {
	  refreshData();
	}, <%= refreshSec%>000);

var newData;

function refreshData() {
	<%
	if (sourceType != null && sourceType.equals("hdfs")) {
	%>
	d3.tsv("hdfsTsvServlet.tsv?fn=<%= fileName%>", function(error, data) {
	<%
	} else { 
	%>
	d3.tsv("HbaseGet.tsv?type=tsv&tn=<%= tableName%>&cf=<%= columnFamily%>&gn=<%= groupName%>&mr=10&keyNm=<%= xname%>", function(error, data) {
	<%
	}
	%>	

		  newData = data;
		  
		  data.forEach(function(d) {
		    d.<%= yname%> = +d.<%= yname%>;
		  });

		  
		  
		  x.domain(data.map(function(d) { return d.<%= xname%>; }));
		  y.domain([0, d3.max(data, function(d) { return d.<%= yname%>; })]);

		  svg.select("g").remove();
		  svg.selectAll("y axis").remove();
		  svg.selectAll("text").remove();
		  //svg.selectAll(".bar").remove();
		  
		  svg.append("g")
	      .attr("class", "x axis")
	      .attr("transform", "translate(0," + height + ")")
	      .call(xAxis);
		  
		  svg.append("g")
	      .attr("class", "y axis")
	      .call(yAxis)
	      .append("text")
	      .attr("transform", "rotate(-90)")
	      .attr("y", 6)
	      .attr("dy", ".71em")
	      .style("text-anchor", "end")
	      .text("<%= yname%>");

		  
		  var bars = svg.selectAll("rect");
		  
		  bars.transition().ease("<%= easeStyle%>")
  		  .duration(1000).attrTween("height", tweenHeight).attrTween("y", tweenY);
  		  
  		  function tweenY(d) {
  			  
  			for (var i = 0; i < data.length; i++) {
  			  if (data[i].<%= xname%> == d.<%= xname%>) {
  			  	
  				var oldPop = d.<%= yname%>;
  		  		
  			    var interpolate = d3.interpolate(yOld(oldPop), y(data[i].<%= yname%>));
  			    
  			    d.<%= yname%> = data[i].<%= yname%>;
  			  
  			    return interpolate;
  			  }
  		  	}
  		  }
  		  
  		function tweenHeight(d) {
			  
  			for (var i = 0; i < data.length; i++) {
  			  if (data[i].<%= xname%> == d.<%= xname%>) {
  			  	
  				var oldPop = d.<%= yname%>;
  		  		
  			    var interpolate = d3.interpolate(height - yOld(oldPop), height - y(data[i].<%= yname%>));
  			    
  			    //d.<%= yname%> = data[i].<%= yname%>;
  			  
  			    return interpolate;
  			  }
  		  	}
  		  }
		  
  		  setTimeout(function() {
  			xOld.domain(newData.map(function(d) { return d.<%= xname%>; }));
    		yOld.domain([0, d3.max(newData, function(d) { return d.<%= yname%>; })]);;
    		refreshData();
  		  }, <%= refreshSec%>000);
  		  

  		  
	  });

}

</script>