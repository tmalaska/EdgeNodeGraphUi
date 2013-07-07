package com.spinal.edgenodegraphui.servlet.graphdata;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

import com.spinal.edgenodegraphui.admin.HdfsConfiguration;
import com.spinal.edgenodegraphui.servlet.graphdata.GraphDataBuilder.GraphLink;
import com.spinal.edgenodegraphui.servlet.graphdata.GraphDataBuilder.GraphNode;

public class HdfsSampleGen extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String type = request.getParameter("type");
    
    if (type.equals("date")) {
      genDateSample(response);
    } else if (type.equals("pie")) {
      genPieSample(response);
    } else if (type.equals("zip")) {
      genZipSample(response);
    } else if (type.equals("graph")) {
      createGraphSample(response);
    }
  }

  private void createGraphSample(HttpServletResponse response) throws IOException {
    String ls = System.getProperty("line.separator");
    
    PrintWriter out = response.getWriter();
    
    Configuration config = HdfsConfiguration.config;
    FileSystem hdfs = FileSystem.get(config);
    
    Path path = new Path("/tmp/graphSample.tsv");

    FSDataOutputStream outputStream = hdfs.create(path, true);
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(outputStream));
    
    ArrayList<GraphNode> nodes = new ArrayList<GraphNode>(); 
    ArrayList<GraphLink> links = new ArrayList<GraphLink>();
    
    GraphDataBuilder.genValue(nodes, links);
    
    out.append("{" + ls + "\"nodes\":[" + ls );
    writer.write("{" + ls + "\"nodes\":[" + ls );
    boolean firstNode = true;
    
    for (GraphNode node: nodes) {
      if (firstNode) {
        firstNode = false;
      } else {
        out.append("," + ls);
        writer.write("," + ls);
      }
      
      int nodeSize = (int)(Math.random() * 10 + 3);
      
      out.append("{\"name\":\"" + node.getName() + "\",\"group\":" + node.getGroupNum() + ",\"radus\":" + nodeSize + "}");
      writer.write("{\"name\":\"" + node.getName() + "\",\"group\":" + node.getGroupNum() + ",\"radus\":" + nodeSize + "}");
    }
    
    out.append("], " + ls + "\"links\":[");
    writer.write("], " + ls + "\"links\":[");
    
    boolean firstLink = true;
    
    for (GraphLink link: links) {
      if (firstLink) {
        firstLink = false;
      } else {
        out.append("," + ls);
        writer.write("," + ls);
      }
      out.append("{\"source\":" + link.getSource() + ",\"target\":" + link.getTarget() + ",\"value\":" + link.getValue()+ "}");
      writer.write("{\"source\":" + link.getSource() + ",\"target\":" + link.getTarget() + ",\"value\":" + link.getValue()+ "}");
    }
    writer.write("]" + ls + "}");
    writer.close();
  }

  private void genZipSample(HttpServletResponse response) throws IOException {
    String ls = System.getProperty("line.separator");
    
    PrintWriter out = response.getWriter();
  
    Configuration config = HdfsConfiguration.config;
    FileSystem hdfs = FileSystem.get(config);
    
    Path path = new Path("/tmp/zipSample.tsv");
    
    FSDataOutputStream outputStream = hdfs.create(path, true);
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(outputStream));
  
    out.append("id\trate" + ls);
    writer.write("id\trate" + ls);
    
    int numberOfRecordsToCreate = 72153;
    for (int i = 1001; i < numberOfRecordsToCreate; i++) {
      
      String rate = Double.toString((Math.random()));
      
      out.append( i + "\t" + rate + ls);
      writer.write(i + "\t" + rate + ls);
    }
    writer.close();
  }
  
  private void genDateSample(HttpServletResponse response) throws IOException {
    String ls = System.getProperty("line.separator");
    
    PrintWriter out = response.getWriter();
  
    Configuration config = HdfsConfiguration.config;
    FileSystem hdfs = FileSystem.get(config);
    
    Path path = new Path("/tmp/dateSample.tsv");
    
    FSDataOutputStream outputStream = hdfs.create(path, true);
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(outputStream));
  
    out.append("date\tcat\tdog\tcow\tpig" + ls);
    writer.write("date\tcat\tdog\tcow\tpig" + ls);
    
    int numberOfRecordsToCreate = 30;
    for (int i = 0; i < numberOfRecordsToCreate; i++) {
      
      String cat = Integer.toString((int)(Math.random() * 20) + 2);
      String dog = Integer.toString((int)(Math.random() * 20) + 2);
      String cow = Integer.toString((int)(Math.random() * 20) + 2);
      String pig = Integer.toString((int)(Math.random() * 20) + 2);
      
      out.append(Integer.toString(20130101 + i) + "\t" + cat + "\t" + dog + "\t" + cow + "\t" + pig + ls);
      writer.write(Integer.toString(20130101 + i) + "\t" + cat + "\t" + dog + "\t" + cow + "\t" + pig + ls);
    }
    writer.close();
  }
  
  private void genPieSample(HttpServletResponse response) throws IOException {
    String ls = System.getProperty("line.separator");
    
    PrintWriter out = response.getWriter();
  
    Configuration config = HdfsConfiguration.config;
    FileSystem hdfs = FileSystem.get(config);
    
    Path path = new Path("/tmp/pieSample.tsv");
    
    FSDataOutputStream outputStream = hdfs.create(path, true);
    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(outputStream));
  
    out.append("part\tspend\tunits" + ls);
    writer.write("part\tspend\tunits" + ls);
    
    int numberOfRecordsToCreate = 7;
    for (int i = 0; i < numberOfRecordsToCreate; i++) {
      
      String spend = Integer.toString((int)(Math.random() * 20) + 2);
      String units = Integer.toString((int)(Math.random() * 98) + 2);
      
      out.append("Part_" + Integer.toString( i) + "\t" + spend + "\t" + units  + ls);
      writer.write("Part_" + Integer.toString( i) + "\t" + spend + "\t" + units + ls);
    }
    writer.close();
  }

}

