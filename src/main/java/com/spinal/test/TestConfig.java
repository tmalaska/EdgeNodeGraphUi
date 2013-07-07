package com.spinal.test;

import java.util.Map.Entry;

import org.apache.hadoop.conf.Configuration;

public class TestConfig {
  public static void main(String[] args) {
    Configuration config = new Configuration();
    for (Entry<String, String> e: config) {
      System.out.println("k:" + e.getKey() + " v:" + e.getValue() + "<br>");
    }
  }
}
