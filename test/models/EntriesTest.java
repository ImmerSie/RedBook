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
    public void testGetEntries() {
        System.out.println("getEntries");
        
        Date TestDate = new Date();
        Entry E1=new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        Entries EntriesTest = new Entries();
        Entries instance = EntriesTest;
        EntriesTest.addEntry(E1);
        
        ArrayList<Entry> entryList = new ArrayList<Entry>();
        entryList.add(E1);
        ArrayList<Entry> result = instance.getEntries();
        
        assertEquals(result,entryList);
         
   }
    
    
  }
   

 
