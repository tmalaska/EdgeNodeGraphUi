package com.spinal.edgenodegraphui.servlet.graphdata;

import java.util.ArrayList;
import java.util.HashSet;

public class GraphDataBuilder {

  public static void genValue(ArrayList<GraphNode> nodes, ArrayList<GraphLink> links) {
    nodes.clear();
    links.clear();
    
    for (int i = 0; i < 80; i++) {
      GraphNode node = new GraphNode("Foo_" + i, (int)Math.abs(Math.random() * 10));
      nodes.add(node);
      
      int numOfLinks = 1;
      if (i < 2) { numOfLinks = (int)(20 * Math.random()); }
      else if (i < 3) { numOfLinks = (int)(10 * Math.random() + 1); }
      else if (i < 20) { numOfLinks = 2; }
      
      HashSet<Integer> targetSet = new HashSet<Integer>();
      targetSet.add(i);
      
      for (int j = 0; j < numOfLinks; j++) {
        
        int target = (int)Math.abs(Math.random() * 79);
        if (targetSet.add(target)) {
          GraphLink link = new GraphLink(i, target, (int)Math.abs(Math.random() * 9) + 1);
          links.add(link);
        }
      }
    }
  }
  
  public static class GraphNode {
    String name;
    int groupNum;
    
    public GraphNode(String name, int groupNum) {
      super();
      this.name = name;
      this.groupNum = groupNum;
    }

    public String getName() {
      return name;
    }

    public void setName(String name) {
      this.name = name;
    }

    public int getGroupNum() {
      return groupNum;
    }

    public void setGroupNum(int groupNum) {
      this.groupNum = groupNum;
    } 
  }
  
  public static class GraphLink {
    int source;
    int target;
    int value;
    
    public GraphLink(int source, int target, int value) {
      super();
      this.source = source;
      this.target = target;
      this.value = value;
    }

    public int getSource() {
      return source;
    }

    public void setSource(int source) {
      this.source = source;
    }

    public int getTarget() {
      return target;
    }

    public void setTarget(int target) {
      this.target = target;
    }

    public int getValue() {
      return value;
    }

    public void setValue(int value) {
      this.value = value;
    }
    
    
  }
}
