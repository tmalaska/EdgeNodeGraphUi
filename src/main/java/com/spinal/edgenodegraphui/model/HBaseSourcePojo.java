package com.spinal.edgenodegraphui.model;

public class HBaseSourcePojo implements ISourcePojo{
  public String tableName;
  public String graphName;
  public String columnFamily;
  public byte numberOfValuesToScan;
  public byte numberOfColumns;
  public byte numberOfValuesToReturn;
  public boolean sort;
  
  public HBaseSourcePojo() {
    
  }
  
  public HBaseSourcePojo(String tableName, String graphName, String columnFamily, byte numberOfValuesToScan, byte numberOfColumns) {
    super();
    this.tableName = tableName;
    this.graphName = graphName;
    this.columnFamily = columnFamily;
    this.numberOfValuesToScan = numberOfValuesToScan;
    this.numberOfColumns = numberOfColumns;
    this.numberOfValuesToReturn = numberOfValuesToScan;
    this.sort = false;
  }
  
  public HBaseSourcePojo(String tableName, String graphName, String columnFamily, byte numberOfValuesToScan, byte numberOfColumns, byte numberOfValuesToReturn, boolean sort) {
    super();
    this.tableName = tableName;
    this.graphName = graphName;
    this.columnFamily = columnFamily;
    this.numberOfValuesToScan = numberOfValuesToScan;
    this.numberOfColumns = numberOfColumns;
    this.numberOfValuesToReturn = numberOfValuesToReturn;
    this.sort = sort;
  }
  
  public String getTableName() {
    return tableName;
  }
  public void setTableName(String tableName) {
    this.tableName = tableName;
  }
  public String getGraphName() {
    return graphName;
  }
  public void setGraphName(String graphName) {
    this.graphName = graphName;
  }
  public String getColumnFamily() {
    return columnFamily;
  }
  public void setColumnFamily(String columnFamily) {
    this.columnFamily = columnFamily;
  }
  public byte getNumberOfValuesToScan() {
    return numberOfValuesToScan;
  }
  public void setNumberOfValuesToScan(byte numberOfValuesToScan) {
    this.numberOfValuesToScan = numberOfValuesToScan;
  }
  public byte getNumberOfColumns() {
    return numberOfColumns;
  }
  public void setNumberOfColumns(byte numberOfColumns) {
    this.numberOfColumns = numberOfColumns;
  }
  public byte getNumberOfValuesToReturn() {
    return numberOfValuesToReturn;
  }
  public void setNumberOfValuesToReturn(byte numberOfValuesToReturn) {
    this.numberOfValuesToReturn = numberOfValuesToReturn;
  }
  public boolean isSort() {
    return sort;
  }
  public void setSort(boolean sort) {
    this.sort = sort;
  }
  
  
}