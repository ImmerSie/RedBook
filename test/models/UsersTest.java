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
      
       
        Users instance = users;
        instance.addUser(u);
      
        ArrayList<User> userList = new ArrayList<User>();
        userList.add(u);
        ArrayList<User> result = instance.getUsers();
        
         assertEquals(result,userList);
      

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
         Users instance = users;
        instance.addUser(u);
 
        
        User expResult = u;

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
        String email = "Test@test.com";
        String password = "password";
        User expResult = u;
        User result = users.login(email, password);
        assertEquals(expResult, result);
       
    }
    
}
