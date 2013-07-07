<html>

<body>

<form name="myform" action="refreshBarChart.jsp" method="get" >

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
  <tr>
    <td>Refresh Style:</td>
    <td>
    	<input type="radio" name="easeStyle" value="linear" checked="true">linear
 		<input type="radio" name="easeStyle" value="bounce">bounce
 		<input type="radio" name="easeStyle" value="elastic">elastic
 		<input type="radio" name="easeStyle" value="quad">quad
 		<input type="radio" name="easeStyle" value="back">back
    </td>
  </tr>
  <tr>
   <td>Seconds between refresh:</td>
   <td><input type="text" name="refreshSec" value="5"></td>
  </tr>
</table>

<input type="submit" value="Submit">

</form>
</body>

</br></br>
Example Data: <A href="/engui/example/DataValueTestData.tsv">DataValueTestData.tsv</A>


</html>