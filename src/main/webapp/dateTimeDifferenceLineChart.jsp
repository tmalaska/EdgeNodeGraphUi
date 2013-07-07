<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");
String y1name = request.getParameter("y1name");
String y2name = request.getParameter("y2name");
String xname = request.getParameter("xname");

String sourceType = request.getParameter("src");
String tableName = request.getParameter("tn");
String columnFamily = request.getParameter("cf");
String groupName = request.getParameter("gn");
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

.x.axis path {
  display: none;
}

.area.above {
  fill: rgb(252,141,89);
}

.area.below {
  fill: rgb(145,207,96);
}

.line {
  fill: none;
  stroke: #000;
  stroke-width: 1.5px;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var parseDate = d3.time.format("%Y%m%d").parse;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var line = d3.svg.area()
    .interpolate("basis")
    .x(function(d) { return x(d.<%= xname%>); })
    .y(function(d) { return y(d["<%= y1name%>"]); });

var area = d3.svg.area()
    .interpolate("basis")
    .x(function(d) { return x(d.<%= xname%>); })
    .y1(function(d) { return y(d["<%= y1name%>"]); });

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
d3.tsv("HbaseGet.tsv?type=tsv&tn=<%= tableName%>&cf=<%= columnFamily%>&gn=<%= groupName%>&mr=40&keyNm=<%= xname%>", function(error, data) {
<%
}
%>
  data.forEach(function(d) {
    d.<%= xname%> = parseDate(d.<%= xname%>);
    d["<%= y1name%>"]= +d["<%= y1name%>"];
    d["<%= y2name%>"] = +d["<%= y2name%>"];
  });

  x.domain(d3.extent(data, function(d) { return d.<%= xname%>; }));

  y.domain([
    d3.min(data, function(d) { return Math.min(d["<%= y1name%>"], d["<%= y2name%>"]); }),
    d3.max(data, function(d) { return Math.max(d["<%= y1name%>"], d["<%= y2name%>"]); })
  ]);

  svg.datum(data);

  svg.append("clipPath")
      .attr("id", "clip-below")
    .append("path")
      .attr("d", area.y0(height));

  svg.append("clipPath")
      .attr("id", "clip-above")
    .append("path")
      .attr("d", area.y0(0));

  svg.append("path")
      .attr("class", "area above")
      .attr("clip-path", "url(#clip-above)")
      .attr("d", area.y0(function(d) { return y(d["<%= y2name%>"]); }));

  svg.append("path")
      .attr("class", "area below")
      .attr("clip-path", "url(#clip-below)")
      .attr("d", area);

  svg.append("path")
      .attr("class", "line")
      .attr("d", line);

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
      .text("Temperature (ºF)");
});

</script>