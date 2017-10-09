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
public class EntryHistoryTest {
    
    public EntryHistoryTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getEntryHisID method, of class EntryHistory.
     */
    @Test
    public void testGetEntryHisID() {
        System.out.println("getEntryHisID");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        int expResult = 123;
        int result = instance.getEntryHisID();
        assertEquals(expResult, result);
      
    }

  

    /**
     * Test of getEntryID method, of class EntryHistory.
     */
    @Test
    public void testGetEntryID() {
        System.out.println("getEntryID");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        int expResult = 123;
        int result = instance.getEntryID();
        assertEquals(expResult, result);
     
    }


    /**
     * Test of getJournalID method, of class EntryHistory.
     */
    @Test
    public void testGetJournalID() {
        System.out.println("getJournalID");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        int expResult = 123;
        int result = instance.getJournalID();
        assertEquals(expResult, result);
       
    }

  

    /**
     * Test of getUserID method, of class EntryHistory.
     */
    @Test
    public void testGetUserID() {
        System.out.println("getUserID");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        int expResult = 123;
        int result = instance.getUserID();
        assertEquals(expResult, result);
   
    }


    /**
     * Test of getTitle method, of class EntryHistory.
     */
    @Test
    public void testGetTitle() {
        System.out.println("getTitle");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        String expResult = "TestTitle";
        String result = instance.getTitle();
        assertEquals(expResult, result);
      
    }



    /**
     * Test of getContent method, of class EntryHistory.
     */
    @Test
    public void testGetContent() {
        System.out.println("getContent");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        String expResult = "TestContent";
        String result = instance.getContent();
        assertEquals(expResult, result);
      
    }

 

    /**
     * Test of getDateModified method, of class EntryHistory.
     */
    @Test
    public void testGetDateModified() {
        System.out.println("getDateModified");
        Date TestDate = new Date();
        EntryHistory instance = new EntryHistory(123,123,123,123,"TestTitle","TestContent",TestDate);
        Date result = instance.getDateModified();
        Date expResult = new Date();
        assertEquals(expResult, result);
       
    }



    /**
     * Test of getComments method, of class EntryHistory.
     */
    @Test
    public void testGetComments() {
        System.out.println("getComments");
         Date TestDate = new Date();
       Comment comments = new Comment(123,TestDate,"Comment");
       
        Entry e = new Entry();
        Entry instance = e;
        e.addComment(comments);
        ArrayList<Comment> result = instance.getComments();
        assertEquals(result.size(),1);
  
    }


    
}
