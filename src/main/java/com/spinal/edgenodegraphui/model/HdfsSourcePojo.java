package com.spinal.edgenodegraphui.model;

public class HdfsSourcePojo implements ISourcePojo {
  public String fileName;

  public HdfsSourcePojo() {
    
  }
  
  public HdfsSourcePojo(String fileName) {
    super();
    this.fileName = fileName;
  }

  public String getFileName() {
    return fileName;
  }

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }
}
