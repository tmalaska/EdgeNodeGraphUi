<html>
<body>

<form name="myform" action="/engui/HbaseGet.tsv" >

<h1>Hbase Get Test</h1>
 <table>
  <tr>
   <td>Type:</td>
   <td><input type="text" name="type" value="tsv"></td>
  </tr>
  <tr>
   <td>Table:</td>
   <td><input type="text" name="tn" value="engui_samples"></td>
  </tr>
  <tr>
   <td>Column Family:</td>
   <td><input type="text" name="cf" value="c"></td>
  </tr>
  <tr>
   <td>Graph:</td>
   <td><input type="text" name="gn" value="date"></td>
  </tr>
  <tr>
   <td>Max Records:</td>
   <td><input type="text" name="mr" value="20"></td>
  </tr>
  <tr>
   <td>Key Field Name:</td>
   <td><input type="text" name="keyNm" value="date"></td>
  </tr>
 </table>
 <input type="submit" value="Submit">

</form>
</body>

</html>