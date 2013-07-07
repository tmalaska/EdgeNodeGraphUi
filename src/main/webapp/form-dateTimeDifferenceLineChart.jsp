<html>
<body>

<form name="myform" action="dateTimeDifferenceLineChart.jsp" >

<h1>Date Time Difference Line Chart Form</h1>
 <table>
  <tr>
   <td>Chart Name:</td>
   <td><input type="text" name="chartName"></td>
  </tr>
  <tr>
    <td>Source Type: </td>
    <td>
    	<input type="radio" name="src" value="hbase"><span class="small">HBase</span>
 		<input type="radio" name="src" value="hdfs" checked="true"><span class="small">HDFS</span>
    </td>
  </tr>
  <tr>
   <td>HDFS File Name:</td>
   <td><input type="text" name="fn" value="/tmp/dateSample.tsv"></td>
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
   <td>X Field Name:</td>
   <td><input type="text" name="xname" value="date"></td>
  </tr>
  <tr>
   <td>Y1 Field Name:</td>
   <td><input type="text" name="y1name" value="dog"></td>
  </tr>
  <tr>
   <td>Y2 Field Name:</td>
   <td><input type="text" name="y2name" value="cat"></td>
  </tr>
 </table>
 <input type="submit" value="Submit">

</form>
</body>

</br></br>
Example Data: <A href="/engui/example/DataValueTestData.tsv">DataValueTestData.tsv</A>


</html>