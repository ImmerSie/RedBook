/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import models.Journal;
import models.User;
import java.util.Date;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class JournalControllerTest {
    
    public JournalControllerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

 

 


    /**
     * Test of getNewJournalID method, of class JournalController.
     */
    @Test
    public void testGetNewJournalID() {
        System.out.println("getNewJournalID");
        String filePath = "TestfilePath";
        User u=new User(123,"Testname","Test@test.com","password");
        JournalController instance = new JournalController(filePath,u);
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal j1 = new Journal(123,123,dateCreated,lastModified,"title","description");
        u.addJournal(j1);
        int expResult = 123;
        int result = instance.getNewJournalID();
        assertEquals(expResult+1, result);
     
    }

    /**
     * Test of getJournalFromID method, of class JournalController.
     */
    @Test
    public void testGetJournalFromID() {
        System.out.println("getJournalFromID");
        int journalID = 123;
        String filePath = "TestfilePath";
        User u=new User(123,"Testname","Test@test.com","password");
        JournalController instance = new JournalController(filePath,u);
        Date dateCreated = new Date();
        Date lastModified = new Date();
        Journal j1 = new Journal(123,123,dateCreated,lastModified,"title","description");
        Journal j2 = new Journal(123,124,dateCreated,lastModified,"title","description");
        u.addJournal(j1);
        u.addJournal(j2);
        Journal expResult = j1;
        Journal result = instance.getJournalFromID(journalID);
        assertEquals(expResult, result);

    }

    /**
     * Test of getUser method, of class JournalController.
     */
    @Test
    public void testGetUser() {
        System.out.println("getUser");
        String filePath = "TestfilePath";
        User u=new User(123,"Testname","Test@test.com","password");
        JournalController instance = new JournalController(filePath,u);
        User expResult =  u;
        User result = instance.getUser();
        assertEquals(expResult, result);
     
    }

    
}
