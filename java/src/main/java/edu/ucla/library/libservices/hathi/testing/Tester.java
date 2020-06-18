package edu.ucla.library.libservices.hathi.testing;

import edu.ucla.library.libservices.hathi.beans.HathiData;
import edu.ucla.library.libservices.hathi.generators.HathiDataGenerator;

import java.util.List;

public class Tester
{
  public Tester()
  {
    super();
  }

  public static void main(String[] args)
  {
    HathiDataGenerator tester;
    List<HathiData> items;
    
    tester = new HathiDataGenerator();
    tester.setBibIDs("100107");
    tester.setDbName("dbName");
    items = tester.getTestItems();
    
    items.stream().forEach(System.out::println);
    //for ( HathiData theItem : items )
      //System.out.println(theItem.toString());
  }
}
