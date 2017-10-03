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
public class EntryTest {
    
    public EntryTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getEntryID method, of class Entry.
     */
    @Test
    public void testGetEntryID() {
        System.out.println("getEntryID");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        int expResult = 123;
        int result = instance.getEntryID();
        assertEquals(expResult, result);
      
    }


    /**
     * Test of getUserID method, of class Entry.
     */
    @Test
    public void testGetUserID() {
        System.out.println("getUserID");
          Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        int expResult = 123;
        int result = instance.getUserID();
        assertEquals(expResult, result);
    
    }



    /**
     * Test of getJournalID method, of class Entry.
     */
    @Test
    public void testGetJournalID() {
        System.out.println("getJournalID");
         Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        int expResult = 123;
        int result = instance.getJournalID();
        assertEquals(expResult, result);
    }

 

    /**
     * Test of getContent method, of class Entry.
     */
    @Test
    public void testGetContent() {
        System.out.println("getContent");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        String expResult = "TestContent";
        String result = instance.getContent();
        assertEquals(expResult, result);
    
    }

    /**
     * Test of getContentSnippet method, of class Entry.
     */
    @Test
    public void testGetContentSnippet() {
        System.out.println("getContentSnippet");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        String expResult = "TestContent";
        String result = instance.getContentSnippet();
        assertEquals(expResult, result);
    
    }


    /**
     * Test of getTitle method, of class Entry.
     */
    @Test
    public void testGetTitle() {
        System.out.println("getTitle");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate); 
        String expResult = "TestTitle";
        String result = instance.getTitle();
        assertEquals(expResult, result);

    }

    /**
     * Test of getTitleLowercase method, of class Entry.
     */
    @Test
    public void testGetTitleLowercase() {
        System.out.println("getTitleLowercase");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        String expResult = "testtitle";
        String result = instance.getTitleLowercase();
        assertEquals(expResult, result);
       
    }

   

    /**
     * Test of getDateCreated method, of class Entry.
     */
    @Test
    public void testGetDateCreated() {
        System.out.println("getDateCreated");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        Date expResult = new Date();
        Date result = instance.getDateCreated();
        assertEquals(expResult, result);
         

    }

    /**
     * Test of getDateModified method, of class Entry.
     */
    @Test
    public void testGetDateModified() {
        System.out.println("getDateModified");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        Date expResult = new Date();
        Date result = instance.getDateModified();
        assertEquals(expResult, result);

    }



    /**
     * Test of getFlag method, of class Entry.
     */
    @Test
    public void testGetFlag() {
        System.out.println("getFlag");
      Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        String expResult = "TestFlag";
        String result = instance.getFlag();
        assertEquals(expResult, result);
    }

 


    /**
     * Test of getComments method, of class Entry.
     */
    @Test
    public void testGetComments() {
        System.out.println("getComments");
        Date TestDate = new Date();
        Entry instance = new Entry(123,123,123,"TestTitle","TestContent","TestFlag",TestDate);
        ArrayList<Comment> result = instance.getComments();
         assertEquals(result.size(),0);

    }




    /**
     * Test of getHistory method, of class Entry.
     */
    @Test
    public void testGetHistory() {
        System.out.println("getHistory");
        Entry instance = new Entry(); 
        ArrayList<EntryHistory> history = new ArrayList<EntryHistory>();
        ArrayList<EntryHistory> result = instance.getHistory();
        assertEquals(result.size(),0);
 
    }

    /**
     * Test of getHistoryReverse method, of class Entry.
     */
    @Test
    public void testGetHistoryReverse() {
        System.out.println("getHistoryReverse");
        Entry instance = new Entry();
        ArrayList<EntryHistory> expResult = null;
        ArrayList<EntryHistory> result = instance.getHistoryReverse();
           assertEquals(result.size(),0);
   
    }

 



 
    
}
