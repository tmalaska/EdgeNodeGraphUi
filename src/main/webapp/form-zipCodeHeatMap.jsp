<html>
<body>

<form name="myform" action="/engui/zipCodeHeatMap.jsp" >

<h1>Zip Code Heat Map Form</h1>
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
    <td><input type="text" name="fn" value="/tmp/zipSample.tsv"></td>
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
    <td><input type="text" name="gn" value="zip"></td>
  </tr>
  <tr>
 </table>
 <input type="submit" value="Submit">

</form>

</br></br>
Example Data: <A href="/engui/example/ZipCodeTestData.tsv">ZipCodeTestData.tsv</A>
</body>

</html>