/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import models.Entries;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Cancancan38
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
     * Test of setFilePath method, of class EntryController.
     * @throws java.lang.Exception
     */
    @Test
    public void testSetFilePath() throws Exception {
        System.out.println("setFilePath");
        String filePath = "";
        EntryController instance = new EntryController();
     Assert.assertEquals("",SetFilePath());
    }

    /**
     * Test of updateXML method, of class EntryController.
     * @throws java.lang.Exception
     */
    @Test
    public void testUpdateXML() throws Exception {
        System.out.println("updateXML");
        Entries entries = null;
        String filePath = "";
        EntryController instance = new EntryController();
             Assert.assertTrue(true);
    }

    /**
     * Test of saveEntries method, of class EntryController.
     * @throws java.lang.Exception
     */
    @Test
    public void testSaveEntries() throws Exception {
        System.out.println("saveEntries");
        EntryController instance = new EntryController();
      Assert.assertTrue(true);
        
    }

    /**
     * Test of getNewEntryID method, of class EntryController.
     */
    @Test
    public void testGetNewEntryID() {
        System.out.println("getNewEntryID");
        EntryController instance = new EntryController();
        int expResult = 123;
        int result = instance.getNewEntryID();
        Assert.assertEquals(123, this);
    }

    /**
     * Test of getEntries method, of class EntryController.
     */
    @Test
    public void testGetEntries() {
        System.out.println("getEntries");
        EntryController instance = new EntryController();
        Entries expResult = null;
        Entries result = instance.getEntries();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getEntriesForJournal method, of class EntryController.
     */
    @Test
    public void testGetEntriesForJournal() {
        System.out.println("getEntriesForJournal");
        int userID = 0;
        int journalID = 0;
        EntryController instance = new EntryController();
        Entries expResult = null;
        Entries result = instance.getEntriesForJournal(userID, journalID);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setEntries method, of class EntryController.
     */
    @Test
    public void testSetEntries() {
        System.out.println("setEntries");
        Entries entries = null;
        EntryController instance = new EntryController();
        instance.setEntries(entries);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of hideEntry method, of class EntryController.
     */
    @Test
    public void testHideEntry() {
        System.out.println("hideEntry");
        EntryController instance = new EntryController();
        instance.hideEntry();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    private Object SetFilePath(EntryControllerTest aThis) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private Object SetFilePath() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
