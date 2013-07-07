package com.spinal.edgenodegraphui.servlet.graphdata;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;

public class HbaseSampleGen extends HttpServlet {
  
  static final String tableName = "engui_samples";
  
  static Configuration hConfig = HBaseConfiguration.create();
  static HBaseAdmin admin; 
  
  static {
    try {
      admin = new HBaseAdmin(hConfig);  
    } catch (Exception e) {
      throw new RuntimeException("Unable to create HBase admin", e);
    }
    
  }
  
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String type = request.getParameter("type");
    
    if (type.equals("date")) {
      createDateExample(response);
    } else if (type.equals("pie")) {
      createPieExample(response);
    } else if (type.equals("zip")) {
      createZipCodeExample(response);
    } else if (type.equals("graph")) {
      createGraphExample(response);
    }
    
  }
  
public void createPieExample(HttpServletResponse response) throws IOException {
    
    PrintWriter out = response.getWriter();
    byte numberOfRecordsToCreate = 7;
    String columnFamily = "c";
    String graphName = "pie";
    
    HTable hTable = null;
    if (admin.tableExists(Bytes.toBytes(tableName)) == false) {
      HTableDescriptor newTable = new HTableDescriptor(); 
      newTable.setName(Bytes.toBytes(tableName));
      
      newTable.addFamily(new HColumnDescriptor(columnFamily));
      admin.createTable(newTable); 
    }
    hTable = new HTable(hConfig, tableName);
    ArrayList<Put> puts = new ArrayList<Put>();
    
    out.append("<html><body>");
    out.append("<h1>Table: " + tableName + "</h1>");
    
    for (int i = 0; i < numberOfRecordsToCreate; i++) {
        Put put = new Put(Bytes.toBytes(graphName + "_Part" + Integer.toString(i)));
        
        String val = Integer.toString((int)(Math.random() * 20) + 1);
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("spend"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(20130101 + i) + ", " + columnFamily + ", spend, " + val + "</br>");
        
        val = Integer.toString((int)(Math.random() * 98)+ 1);
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("units"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(20130101 + i) + ", " + columnFamily + ", units, " + val + "</br>");
        
        
        puts.add(put);
    }
    
    
    hTable.put(puts);
    hTable.close();
    
    out.append("Done");
    out.append("</body></html>");
  }
  
  public void createDateExample(HttpServletResponse response) throws IOException {
    
    PrintWriter out = response.getWriter();
    byte numberOfRecordsToCreate = 30;
    String columnFamily = "c";
    String graphName = "date";
    
    HTable hTable = null;
    if (admin.tableExists(Bytes.toBytes(tableName)) == false) {
      HTableDescriptor newTable = new HTableDescriptor(); 
      newTable.setName(Bytes.toBytes(tableName));
      
      newTable.addFamily(new HColumnDescriptor(columnFamily));
      admin.createTable(newTable); 
    }
    hTable = new HTable(hConfig, tableName);
    ArrayList<Put> puts = new ArrayList<Put>();
    
    out.append("<html><body>");
    out.append("<h1>Table: " + tableName + "</h1>");
    
    for (int i = 0; i < numberOfRecordsToCreate; i++) {
        Put put = new Put(Bytes.toBytes(graphName + "_" + Integer.toString(20130101 + i)));
        
        String val = Integer.toString((int)(Math.random() * 20) + 1);
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("cat"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(20130101 + i) + ", " + columnFamily + ", cat, " + val + "</br>");
        
        val = Integer.toString((int)(Math.random() * 20)+ 1);
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("dog"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(20130101 + i) + ", " + columnFamily + ", dog, " + val + "</br>");
        
        val = Integer.toString((int)(Math.random() * 20)+ 1);
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("cow"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(20130101 + i) + ", " + columnFamily + ", cow, " + val + "</br>");
        
        val = Integer.toString((int)(Math.random() * 20)+ 1);
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("pig"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(20130101 + i) + ", " + columnFamily + ", pig, " + val + "</br>");
        
        puts.add(put);
    }
    
    
    hTable.put(puts);
    hTable.close();
    
    out.append("Done");
    out.append("</body></html>");
  }
  
  public void createGraphExample(HttpServletResponse response) throws IOException {
    
    PrintWriter out = response.getWriter();
    
    //TODO
  }
  
  public void createZipCodeExample(HttpServletResponse response) throws IOException {

    PrintWriter out = response.getWriter();
    
    int numberOfRecordsToCreate = 72153;
    String columnFamily = "c";
    String graphName = "zip";
    
    HTable hTable = null;
    if (admin.tableExists(Bytes.toBytes(tableName)) == false) {
      HTableDescriptor newTable = new HTableDescriptor(); 
      newTable.setName(Bytes.toBytes(tableName));
      
      newTable.addFamily(new HColumnDescriptor(columnFamily));
      admin.createTable(newTable); 
    }
    hTable = new HTable(hConfig, tableName);
     
    ArrayList<Put> puts = new ArrayList<Put>();
    

    out.append("<html><body>");
    out.append("<h1>Table: " + tableName + "</h1>");
    
    for (int i = 1001; i < numberOfRecordsToCreate; i++) {
        Put put = new Put(Bytes.toBytes(graphName + "_" + Integer.toString(i)));
        
        String val = Double.toString((Math.random() * 1));
        put.add(Bytes.toBytes(columnFamily), Bytes.toBytes("rate"), Bytes.toBytes(val));
        out.append(graphName + "_" + Integer.toString(i) + ", " + columnFamily + ", rate, " + val + "</br>");
        puts.add(put);
    }
    
    hTable.put(puts);
    hTable.close();
    
    out.append("Done");

    out.append("Done");
    out.append("</body></html>");
  }
}
