/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.ArrayList;
import java.util.Date;
import models.Entry;
import models.EntryHistory;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class EntryHistoryControllerTest {
    
    public EntryHistoryControllerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

 


 

    /**
     * Test of getEntry method, of class EntryHistoryController.
     */
    @Test
    public void testGetEntry() {
        System.out.println("getEntry");
        String filePath = "TestfilePath";
        Date TestDate = new Date();
        Entry EntryTest = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        EntryHistoryController instance = new EntryHistoryController(filePath,EntryTest);
        Entry expResult = EntryTest;
        Entry result = instance.getEntry();
        assertEquals(expResult, result);
     
    }



    /**
     * Test of getEntryHisFromID method, of class EntryHistoryController.
     */
    @Test
    public void testGetEntryHisFromID() {
        System.out.println("getEntryHisFromID");
        int hisID = 123;
        Date TestDate1 = new Date();
        EntryHistory eh = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate1);
        
        ArrayList<EntryHistory> history = new ArrayList<EntryHistory>();
       history.add(eh);
        
        String filePath = "TestfilePath";
        Date TestDate = new Date();
        Entry EntryTest = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        EntryHistoryController instance = new EntryHistoryController(filePath,EntryTest);
        
        
        EntryHistory expResult = null;
        EntryHistory result = instance.getEntryHisFromID(hisID);
        assertEquals(expResult, result);
 
    }
    
}
