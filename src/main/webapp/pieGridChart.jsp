<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");
String label = request.getParameter("label");
String value = request.getParameter("value");
String value2 = request.getParameter("value2");

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
  background: #333;
}

.arc path {
  stroke: #fff;
    stroke-width: 2px;
}

.arc grid {
    stroke: #fff;
    stroke-width: 1;
    stroke-dasharray: 5,5;
}

.arc text {
    fill:#fff;
    font-size:12px;
    font-weight:bold;
}

.arc line {
  stroke: #fff;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var width = 960,
    height = 500,
    radius = Math.min(width, height) / 2 - 10,
    numTicks = 5,
    sdat = [];

var color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var arc = d3.svg.arc()
    .outerRadius(function(d) { return 50 + (radius - 50) * d.data.<%= value2%> / 100; })
    .innerRadius(20);

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.<%= value%>; });

var grid = d3.svg.area.radial()
    .radius(150);

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

for (i=0; i<=numTicks; i++) {
    sdat[i] = 20 + ((radius/numTicks) * i);
}

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
    d.<%= value2%> = d.<%= value2%>;
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

    addCircleAxes();
});

addCircleAxes = function() {
    var circleAxes, i;
        
    svg.selectAll('.circle-ticks').remove();
        
    circleAxes = svg.selectAll('.circle-ticks')
      .data(sdat)
      .enter().append('svg:g')
      .attr("class", "circle-ticks");

    circleAxes.append("svg:circle")
      .attr("r", String)
      .attr("class", "circle")
      .style("stroke", "#CCC")
      .style("opacity", 0.5)
      .style("fill", "none");

    circleAxes.append("svg:text")
      .attr("text-anchor", "center")
      .attr("dy", function(d) { return d - 5 })
      .style("fill", "#fff")
      .text(function(d,i) { return i * (100/numTicks) });

};

</script>
