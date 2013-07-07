<html>
<body>

<form name="myform" action="pieGridChart.jsp" >

<h1>Pie Grid Chart Form</h1>
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
    <td>HDFS File: </td>
    <td><input type="text" name="fn" value="/tmp/pieSample.tsv"></td>
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
    <td><input type="text" name="gn" value="pie"></td>
  </tr>
  <tr>
  <tr>
   <td>Label Field Name:</td>
   <td><input type="text" name="label" value="part"></td>
  </tr>
  <tr>
   <td>Value1 Field Name:</td>
   <td><input type="text" name="value" value="spend"></td>
  </tr>
    <tr>
   <td>Value2 Field Name:</td>
   <td><input type="text" name="value2" value="units"></td>
  </tr>
  <tr>
    <td>Style:</td>
    <td>
    	<input type="radio" name="raduis" value="off" checked="true">Pie
 		<input type="radio" name="raduis" value="on">Donut
    </td>
  </tr>
  <tr>
    <td>Amazing:</td>
    <td>
    	<input type="radio" name="amazing" value="on" checked="true">No
 		<input type="radio" name="amazing" value="yes">Yes
    </td>
  </tr>
 </table>
 <input type="submit" value="Submit">

</form>
</body>

</br></br>
Example Data: <A href="example/PieTestData.tsv">PieTestData.tsv</A>


</html>