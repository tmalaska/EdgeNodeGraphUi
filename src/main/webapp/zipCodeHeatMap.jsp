<%@ page import="java.util.*" %>

<%
String fileName = request.getParameter("fn");

String sourceType = request.getParameter("src");
String tableName = request.getParameter("tn");
String columnFamily = request.getParameter("cf");
String groupName = request.getParameter("gn");
%>

<!DOCTYPE html>
<meta charset="utf-8">
<style>

.counties {
  fill: none;
}

.states {
  fill: none;
  stroke: #fff;
  stroke-linejoin: round;
}

.q0-9 { fill:rgb(247,251,255); }
.q1-9 { fill:rgb(222,235,247); }
.q2-9 { fill:rgb(198,219,239); }
.q3-9 { fill:rgb(158,202,225); }
.q4-9 { fill:rgb(107,174,214); }
.q5-9 { fill:rgb(66,146,198); }
.q6-9 { fill:rgb(33,113,181); }
.q7-9 { fill:rgb(8,81,156); }
.q8-9 { fill:rgb(8,48,107); }


</style>
<body><a href="/engui/hdfsTsvServlet.tsv?fn=<%= fileName%>">Data File</a>
</body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://d3js.org/queue.v1.min.js"></script>
<script src="http://d3js.org/topojson.v1.min.js"></script>
<script>

var width = 960,
    height = 500;

var rateById = d3.map();

var quantize = d3.scale.quantize()
    .domain([0, 1])
    .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

var path = d3.geo.path();

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

queue()
    .defer(d3.json, "utils/us.json")<%
if (sourceType != null && sourceType.equals("hdfs")) {
%>
    .defer(d3.tsv, "hdfsTsvServlet.tsv?fn=<%= fileName%>", function(d) { rateById.set(d.id, +d.rate); })
    <%
} else { 
%>
    .defer(d3.tsv, "HbaseGet.tsv?type=tsv&tn=<%= tableName%>&cf=<%= columnFamily%>&gn=<%= groupName%>&mr=80000&keyNm=id", function(d) { rateById.set(d.id, +d.rate); })
<%
}
%>
    .await(ready);

function ready(error, us) {
  svg.append("g")
      .attr("class", "counties")
    .selectAll("path")
      .data(topojson.feature(us, us.objects.counties).features)
    .enter().append("path")
      .attr("class", function(d) { return quantize(rateById.get(d.id)); })
      .attr("d", path);

  svg.append("path")
      .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
      .attr("class", "states")
      .attr("d", path);
}

</script>
