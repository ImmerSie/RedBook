/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.ArrayList;
import java.util.Date;
import models.Entry;
import models.Journal;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class EntryControllerTest {
    
    public EntryControllerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

  

 

 
    /**
     * Test of getNewEntryID method, of class EntryController.
     */
    @Test
    public void testGetNewEntryID() {
        System.out.println("getNewEntryID");
        String filePath = "TestfilePath";
     
        
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
       
        
       EntryController instance = new EntryController(filePath,j);
        
        
        
        int expResult = 123;
        int result = instance.getNewEntryID();
        assertEquals(expResult+1, result);
      
    }

    /**
     * Test of getEntries method, of class EntryController.
     */
    @Test
    public void testGetEntries() {
        System.out.println("getEntries");
       
        String filePath = "TestfilePath";
     
        
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
       
        
        EntryController instance = new EntryController(filePath,j);
        ArrayList<Entry> result = instance.getEntries();
        assertEquals(result.size(),1);
       
    }

    /**
     * Test of getEntriesForJournal method, of class EntryController.
     */
    @Test
    public void testGetEntriesForJournal() {
        System.out.println("getEntriesForJournal");
        int userID = 123;
        int journalID = 123;
        String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.getEntriesForJournal(userID, journalID);
        assertEquals(expResult, result);
    
    }

    /**
     * Test of getEntryByID method, of class EntryController.
     */
    @Test
    public void testGetEntryByID() {
        System.out.println("getEntryByID");
        int entryID = 123;
        
        String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
        Entry expResult = E1;
        Entry result = instance.getEntryByID(entryID);
        assertEquals(expResult, result);
      
    }

    /**
     * Test of getByDate method, of class EntryController.
     */
    @Test
    public void testGetByDate() {
        System.out.println("getByDate");
        Date date = new Date();
        String filePath = "TestfilePath";
        
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
       
        
        ArrayList<Entry> expResult = entries;
    
        ArrayList<Entry> result = instance.getByDate(date);
        assertEquals(expResult, result);
   
    }

    /**
     * Test of getByTitle method, of class EntryController.
     */
    @Test
    public void testGetByTitle() {
        System.out.println("getByTitle");
        String title = "TestTitle";
        
        String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
       
        
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.getByTitle(title);
        assertEquals(expResult, result);
   
    }

    /**
     * Test of getAllEntries method, of class EntryController.
     */
    @Test
    public void testGetAllEntries() {
        System.out.println("getAllEntries");
        String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
       
        
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.getAllEntries();
        assertEquals(expResult, result);
        
    }

    /**
     * Test of getHiddenEntries method, of class EntryController.
     */
    @Test
    public void testGetHiddenEntries() {
        System.out.println("getHiddenEntries");
       String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","hidden",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
       
        
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.getHiddenEntries();
        assertEquals(expResult, result);
       
    }

    /**
     * Test of getNonHiddenEntries method, of class EntryController.
     */
    @Test
    public void testGetNonHiddenEntries() {
        System.out.println("getNonHiddenEntries");
       String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","visible",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
       
        
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.getNonHiddenEntries();
        assertEquals(expResult, result);

    }

    /**
     * Test of getJournal method, of class EntryController.
     */
    @Test
    public void testGetJournal() {
        System.out.println("getJournal");
        String filePath = "TestfilePath";
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal j = new Journal(123,123,dateCreated,lastModified,"title","description");
        EntryController instance = new EntryController(filePath,j);
        Journal expResult = j;
        Journal result = instance.getJournal();
        assertEquals(expResult, result);
     
    }

 



    /**
     * Test of sortByTitle method, of class EntryController.
     */
    @Test
    public void testSortByTitle() {
        System.out.println("sortByTitle");
      String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","visible",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.sortByTitle(entries);
        assertEquals(expResult, result);
      
    }

    /**
     * Test of sortByTitleDesc method, of class EntryController.
     */
    @Test
    public void testSortByTitleDesc() {
        System.out.println("sortByTitleDesc");
         String filePath = "TestfilePath";
      
       Date TestDate = new Date();
       Entry E1 = new Entry(123,123,123,"TestTitle","TestContent","visible",TestDate);
       ArrayList<Entry> entries = new ArrayList<Entry>();
       entries.add(E1);
       
       Journal j = new Journal();
       j.setEntries(entries);
        
       
        EntryController instance = new EntryController(filePath,j);
        ArrayList<Entry> expResult = entries;
        ArrayList<Entry> result = instance.sortByTitleDesc(entries);
        assertEquals(expResult, result);
     
    }
    
}
