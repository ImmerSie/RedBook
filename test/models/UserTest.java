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
public class UserTest {
    
    public UserTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getUserID method, of class User.
     */
    @Test
    public void testGetUserID() {
        System.out.println("getUserID");
        User instance = new User(123,"Testname","Test@test.com","Password");
        int expResult = 123;
        int result = instance.getUserID();
        assertEquals(expResult, result);
     
    }

  

    /**
     * Test of getDateCreated method, of class User.
     */
    @Test
    public void testGetDateCreated() {
        System.out.println("getDateCreated");
        User instance = new User(123,"Testname","Test@test.com","Password"); 
        Date expResult = new Date();
        Date result = instance.getDateCreated();
        assertEquals(expResult, result);
    
    }

    /**
     * Test of getEmail method, of class User.
     */
    @Test
    public void testGetEmail() {
        System.out.println("getEmail");
        User instance = new User(123,"Testname","Test@test.com","Password");
        String expResult = "Test@test.com";
        String result = instance.getEmail();
        assertEquals(expResult, result);
        
    }

    /**
     * Test of getName method, of class User.
     */
    @Test
    public void testGetName() {
        System.out.println("getName");
        User instance = new User(123,"Testname","Test@test.com","Password");
        String expResult = "Testname";
        String result = instance.getName();
        assertEquals(expResult, result);
       
    }

    /**
     * Test of getPassword method, of class User.
     */
    @Test
    public void testGetPassword() {
        System.out.println("getPassword");
        User instance = new User(123,"Testname","Test@test.com","Password");
        String expResult = "Password";
        String result = instance.getPassword();
        assertEquals(expResult, result);

    }

   





    /**
     * Test of getJournals method, of class User.
     */
    @Test
    public void testGetJournals() {
        System.out.println("getJournals");
        User instance = new User();
        ArrayList<Journal> result = instance.getJournals();
        assertEquals(result.size(),0);
    
    }


    /**
     * Test of getJournal method, of class User.
     */
    @Test
    public void testGetJournal() {
        System.out.println("getJournal");
        int journalID = 123;
        User instance = new User(123,"Testname","Test@test.com","Password");
        Journal expResult = null;
        Journal result = instance.getJournal(journalID);
        assertEquals(expResult, result);
     
    }
    
}
