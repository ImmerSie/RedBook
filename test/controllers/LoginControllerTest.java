/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;
import models.User;
import models.Users;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class LoginControllerTest {
    
    
    public LoginControllerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

  




    /**
     * Test of getNewUserID method, of class LoginController.
     */
    @Test
    public void testGetNewUserID() {
        System.out.println("getNewUserID");
        User u=new User(123,"Testname","Test@test.com","password");
        Users users=new Users();
        users.addUser(u);
        LoginController instance = new LoginController("testPath",users);
        int expResult = 123;
        int result = instance.getNewUserID();
        assertEquals(expResult+1, result);
       
    }

    /**
     * Test of getUsers method, of class LoginController.
     */
    @Test
    public void testGetUsers() {
        System.out.println("getUsers");
        User u=new User(123,"Testname","Test@test.com","password");
        Users users=new Users();
        users.addUser(u);
        LoginController instance = new LoginController("testPath",users);
        Users expResult = users;
        Users result = instance.getUsers();
        assertEquals(expResult, result);
           
    
    }

 
    
}
