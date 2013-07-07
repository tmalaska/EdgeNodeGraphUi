<html>

<body>

<form name="myform" action="barChart.jsp" method="get" >

<h1>Bar Chart Form</h1>

<table>
  <tr>
   <td>Name: </td>
   <td><input type="text" name="chartName"></td>
  </tr>
  <tr>
    <td>Source Type: </td>
    <td>
    	<input type="radio" name="src" value="hbase" checked="true"><span class="small">HBase</span>
 		<input type="radio" name="src" value="hdfs"><span class="small">HDFS</span>
    </td>
  </tr>
  <tr>
    <td>HDFS File: </td>
    <td><input type="text" name="fn"  value="/tmp/dateSample.tsv"></td>
  </tr>
  <tr>
    <td>HBase Table Name: </td>
    <td><input type="text" name="tn" value="engui_samples"></td>
  </tr>
  <tr>
    <td>HBase Column Family: </td>
    <td><input type="text" name="cf" value="c"></td>
  </tr>
  <tr>
    <td>HBase Graph Name: </td>
    <td><input type="text" name="gn" value="date"></td>
  </tr>
  <tr>
    <td>X Column</td>
    <td><input type="text" name="xname" value="date"></td>
  </tr>
  <tr>
    <td>Y Column</td>
    <td><input type="text" name="yname" value="dog"></td>
  </tr>
</table>

<input type="submit" value="Submit">

</form>
</body>

</br></br>
Example Data: <A href="/engui/example/DataValueTestData.tsv">DataValueTestData.tsv</A>


</html>