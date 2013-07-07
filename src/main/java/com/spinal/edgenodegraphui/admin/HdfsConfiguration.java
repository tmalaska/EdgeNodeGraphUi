package com.spinal.edgenodegraphui.admin;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;

import org.apache.hadoop.conf.Configuration;

import com.spinal.edgenodegraphui.servlet.graphdata.HdfsGetServlet;

public class HdfsConfiguration {
  public static Configuration config;
  
  static {
    config = genConfig();
  }
  
  protected static Configuration genConfig() {
    Configuration config = new Configuration();
    
    URL url = HdfsGetServlet.class.getClassLoader().getResource("hdfs.xml");
    //File file = new File(url.getFile());
    System.out.println("url:" + url);
    File file = new File(url.getFile());
    try {
      BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
      config.addResource(input);
      //input.close();
      return config;
    } catch (FileNotFoundException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return null;
  }
}
