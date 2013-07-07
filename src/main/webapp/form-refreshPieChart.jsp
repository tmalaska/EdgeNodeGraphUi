<html>
<body>

<form name="myform" action="refreshPieChart.jsp" >

<h1>Refresh Pie Chart Form</h1>
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
   <td>Value Field Name:</td>
   <td><input type="text" name="value" value="spend"></td>
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
    <td>Style:</td>
    <td>
    	<input type="radio" name="raduis" value="off" checked="true">Pie
 		<input type="radio" name="raduis" value="on">Donut
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
Example Data: <A href="example/PieTestData.tsv">PieTestData.tsv</A>


</html>