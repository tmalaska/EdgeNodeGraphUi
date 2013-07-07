package com.spinal.edgenodegraphui.servlet.graphdata;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.CommonConfigurationKeys;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.FSDataInputStream;

import com.spinal.edgenodegraphui.admin.HdfsConfiguration;

public class HdfsGetServlet extends HttpServlet {

  
  
  
  
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String fileName = request.getParameter("fn");
    
    PrintWriter out = response.getWriter();
    
    if (fileName.endsWith(".tsv") || fileName.endsWith(".json")) {
      
      FileSystem hdfs = FileSystem.get(HdfsConfiguration.config);
      FSDataInputStream inputStream = hdfs.open(new Path(fileName));
      BufferedInputStream bufferedInputStream = new BufferedInputStream(inputStream);
      byte[] bytes = new byte[1000];
      int read;
      while ((read = bufferedInputStream.read(bytes)) > 0) {
        out.append((new String(bytes)).subSequence(0, read));
      }
      bufferedInputStream.close();
      hdfs.close();
      
    } else {
      out.append("File name:" + fileName + " is not valid tsv file");
    }
  }

}
