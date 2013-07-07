package com.spinal.edgenodegraphui.model;

import java.util.ArrayList;

import org.json.JSONObject;



public class DashBoardPojo {
  private int id;
  private String name;
  private byte numberOfGraphs;
  private ArrayList<GraphPojo> graphs = new ArrayList<GraphPojo>();
  
  public DashBoardPojo() {
    
  }
  
  public DashBoardPojo(int id, String name, byte numberOfGraphs, ArrayList<GraphPojo> graphs) {
    super();
    this.id = id;
    this.name = name;
    this.numberOfGraphs = numberOfGraphs;
    this.graphs = graphs;
  }

  
  
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public byte getNumberOfGraphs() {
    return numberOfGraphs;
  }

  public void setNumberOfGraphs(byte numberOfGraphs) {
    this.numberOfGraphs = numberOfGraphs;
  }

  public ArrayList<GraphPojo> getGraphs() {
    return graphs;
  }

  public void setGraphs(ArrayList<GraphPojo> graphs) {
    this.graphs = graphs;
  }
  
  
}
