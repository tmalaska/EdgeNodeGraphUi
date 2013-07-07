package com.spinal.edgenodegraphui.servlet.graphdata;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.log4j.Logger;

public class HBaseGetServlet extends HttpServlet {

  Logger log = Logger.getLogger(HBaseGetServlet.class);

  HashMap<String, HTable> tableMap = new HashMap<String, HTable>();
  static Configuration hConfig = HBaseConfiguration.create();
  static String newline = System.getProperty("line.separator");

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    String type = request.getParameter("type");
    
    String tableName = request.getParameter("tn");
    String graphName = request.getParameter("gn");
    String columnFamily = request.getParameter("cf");
    String numOfRecords = request.getParameter("mr");
    String keyName = request.getParameter("keyNm");
    
    int numberOfRecordsToReturn = 0;
    byte numberOfColumns = 1;

    if (numOfRecords == null || numOfRecords.isEmpty()) {
      numberOfRecordsToReturn = 10;
    } else {
      
      numberOfRecordsToReturn = Integer.parseInt(numOfRecords);
    }

    if (columnFamily == null || columnFamily.isEmpty()) {
      columnFamily = "c";
    }
    
    String keyColumnName = request.getParameter("keyNm");

    if (type != null && type.equals("tsv")) {
     
      HTable hTable = new HTable(hConfig, tableName);
      

      Scan scan = new Scan();
      scan.setMaxVersions(1);
      scan.setBatch(10000);
      scan.setCaching(10000);
      scan.setCacheBlocks(true);
      scan.setStartRow(Bytes.toBytes(graphName + "_"));
      scan.setStopRow(Bytes.toBytes(graphName + "_~"));
      ResultScanner rs = hTable.getScanner(scan);
      try {

        BufferedWriter out = new BufferedWriter(response.getWriter());

        int values = 0;
        returnRawResults(keyName, columnFamily, numberOfRecordsToReturn, numberOfColumns, rs, out, values);
        
      } finally {
        rs.close(); // always close the ResultScanner!
      }
    }
  }


  private void returnRawResults(String keyName, String columnFamily, int numberOfRecordsToScan, byte numberOfColumns, ResultScanner rs, BufferedWriter out, int values) throws IOException {
    
    boolean isFirst = true;
    int prexIndex = 0;
    for (Result r = rs.next(); r != null; r = rs.next()) {
      
      
      if (isFirst) {
        isFirst = false;
        
        out.append(keyName);
        
        for (KeyValue kv: r.list()) {
          
          out.append("\t"+ Bytes.toString(kv.getQualifier()));
        }
        String row = Bytes.toString(r.getRow());
        prexIndex = row.indexOf("_") + 1;
      }
      
      out.append(newline);
      if (values < numberOfRecordsToScan + 1) {
        String row = Bytes.toString(r.getRow());
        
        out.append(row.substring(prexIndex));

        for (KeyValue kv: r.list()) {
          out.append("\t" + Bytes.toString(kv.getValue()));
          
        }
      } 
      values++;
    }
    out.flush();
  }

  public void finalize() {
    for (HTable hTable : tableMap.values()) {
      try {
        hTable.close();
      } catch (Exception e) {
        log.warn("Error closing HTable", e);
      }
    }
  }
}
