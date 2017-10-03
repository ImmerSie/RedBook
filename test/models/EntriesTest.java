/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class EntriesTest {
     
    public EntriesTest() {
       
    
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getEntries method, of class Entries.
     */
    @Test
    public void testGetEntries() throws IllegalArgumentException, IllegalAccessException {
        System.out.println("getEntries");
        
        Date TestDate = new Date();
        Entry E1=new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        ArrayList<Entry> entryList= new ArrayList<Entry>();
        entryList.add(E1);
         
   
        
        Field [] fa = EntriesTest.class.getDeclaredFields();   
      for(Field f :fa){
          int entryID;
   if(f.getName().equals("entryList"))
   {
    f.setAccessible(true);
    Entries t = new Entries();
    
   /**  ArrayList<Entry> entryList1 = ( ArrayList<Entry>)(f.get(t)); **/
     
        entryID = (int)(f.get(t));
        assertEquals(1245656566,entryID);
   }
    
    
  }
   
    
       

  } 
     

        
    }

    
}
