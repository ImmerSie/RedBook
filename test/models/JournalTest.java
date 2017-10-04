/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

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
public class JournalTest {
    
    
    public JournalTest() {
        
        
    }
    
    @BeforeClass
    public static void setUpClass() {
        
        
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getUserID method, of class Journal.
     */
    @Test
    public void testGetUserID() {
        System.out.println("getUserID");
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        int expResult = 123;
        int result = instance.getUserID();
        assertEquals(expResult, result);

    }

   
 

    /**
     * Test of getDateCreated method, of class Journal.
     */
    @Test
    public void testGetDateCreated() {
        System.out.println("getDateCreated");
         Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        Date expResult = new Date();
        Date result = instance.getDateCreated();
        assertEquals(expResult, result);
 
    }


    /**
     * Test of getDescription method, of class Journal.
     */
    @Test
    public void testGetDescription() {
        System.out.println("getDescription");
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        String expResult = "description";
        String result = instance.getDescription();
        assertEquals(expResult, result);

    }

  

    /**
     * Test of getLastModified method, of class Journal.
     */
    @Test
    public void testGetLastModified() {
        System.out.println("getLastModified");
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        Date expResult = new Date();
        Date result = instance.getLastModified();
        assertEquals(expResult, result);

    }

 

    /**
     * Test of getTitle method, of class Journal.
     */
    @Test
    public void testGetTitle() {
        System.out.println("getTitle");
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        String expResult = "title";
        String result = instance.getTitle();
        assertEquals(expResult, result);
    }

 

    /**
     * Test of getJournalID method, of class Journal.
     */
    @Test
    public void testGetJournalID() {
        System.out.println("getJournalID");
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        int expResult = 123;
        int result = instance.getJournalID();
        assertEquals(expResult, result);
 
    }

 

    /**
     * Test of getEntries method, of class Journal.
     */
    @Test
    public void testGetEntries() {
        System.out.println("getEntries");
       
        Date TestDate = new Date();
        Entry E1=new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
  
    
        Journal j = new Journal();
        Journal instance = j;
        j.addEntry(E1);
        
        ArrayList<Entry> entries = new ArrayList<Entry>();
        entries.add(E1);
        
        ArrayList<Entry> result = instance.getEntries();
        assertEquals(result,entries);

    }

    /**
     * Test of getEntry method, of class Journal.
     */
    @Test
    public void testGetEntry() {
        System.out.println("getEntry");
        int entryID = 123;
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal instance = new Journal(123,123,dateCreated,lastModified,"title","description");
        Entry expResult = null;
        Entry result = instance.getEntry(entryID);
        assertEquals(expResult, result);
 
    }


  
    
}
