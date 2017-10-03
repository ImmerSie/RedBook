/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;
import java.lang.reflect.Field;
import java.util.ArrayList;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
i m
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class UsersTest {
      
    
    
        
    
    public UsersTest() {
        
    }
    
    @BeforeClass
    public static void setUpClass() {
       
 
        
    }
    
    @AfterClass
    public static void tearDownClass() {
        
    }
    
    
  

    /**
     * Test of getUsers method, of class Users.
     * @throws java.lang.Exception
     */
    @Test
    public void testGetUsers() throws Exception {
        System.out.println("getUsers");
        
        User u=new User(123,"Testname","Test@test.com","password");
        Users users=new Users();
        ArrayList<User> userList = new ArrayList<User>();
        userList.add(u);
        Users instance = users;
      
        ArrayList<User> result = instance.getUsers();

         assertEquals(result.size(),0);
      

    }

    /**

    /**
     * Test of getUser method, of class Users.
     */
    @Test
    public void testGetUser() {
        System.out.println("getUser");
        String email = "Test@test.com";
        User u=new User(123,"Testname","Test@test.com","password");
        Users users=new Users();
        users.addUser(u);
 
        
        User expResult = null;
        Users instance = new Users();
        User result = instance.getUser(email);
        assertEquals(expResult, result);
     
    }

    /**
     * Test of login method, of class Users.
     */
    @Test
    public void testLogin() {
        System.out.println("login");
        User u=new User(123,"Testname","Test@test.com","password");
        Users users=new Users();
        users.addUser(u);
        String email = "123";
        String password = "123";
        User expResult = null;
        User result = users.login(email, password);
        assertEquals(expResult, result);
       
    }
    
}
