package com.spinal.edgenodegraphui.model;

public class GraphPojo {
  public String title;
  public String graphType;
  public HBaseSourcePojo hbaseSourcePojo;
  public HdfsSourcePojo hdfsSourcePojo;
  public int refreshInNSeconds;
  
  public GraphPojo() {
    
  }
  
  public GraphPojo(String title, String graphType, ISourcePojo source, int refreshInNSeconds) {
    super();
    this.title = title;
    this.graphType = graphType;
    
    if (source instanceof HBaseSourcePojo) {
      hbaseSourcePojo = (HBaseSourcePojo)source;
    } else {
      hdfsSourcePojo = (HdfsSourcePojo)source;
    }
    
    this.refreshInNSeconds = refreshInNSeconds;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getGraphType() {
    return graphType;
  }

  public void setGraphType(String graphType) {
    this.graphType = graphType;
  }

  

  public HBaseSourcePojo getHbaseSourcePojo() {
    return hbaseSourcePojo;
  }

  public void setHbaseSourcePojo(HBaseSourcePojo hbaseSourcePojo) {
    this.hbaseSourcePojo = hbaseSourcePojo;
  }

  public HdfsSourcePojo getHdfsSourcePojo() {
    return hdfsSourcePojo;
  }

  public void setHdfsSourcePojo(HdfsSourcePojo hdfsSourcePojo) {
    this.hdfsSourcePojo = hdfsSourcePojo;
  }


  public int getRefreshInNSeconds() {
    return refreshInNSeconds;
  }

  public void setRefreshInNSeconds(int refreshInNSeconds) {
    this.refreshInNSeconds = refreshInNSeconds;
  }




  
  
  
}
