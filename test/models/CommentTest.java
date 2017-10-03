/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.Date;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author cancancan
 */
public class CommentTest {
    
    public CommentTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of getCommentID method, of class Comment.
     */
    @Test
    public void testGetCommentID() {
        System.out.println("getCommentID");
        Date TestDate = new Date();
        Comment instance = new Comment(123,TestDate,"Test");
        int expResult = 123;
        int result = instance.getCommentID();
        assertEquals(expResult, result);
       
    }

  

    /**
     * Test of getDateCreated method, of class Comment.
     */
    @Test
    public void testGetDateCreated() {
        System.out.println("getDateCreated");
        Date TestDate = new Date();
        Comment instance = new Comment(123,TestDate,"Test");
        Date result = instance.getDateCreated();
        Date expResult = new Date();
        assertEquals(expResult, result);
      
    }

    /**
     * Test of getContent method, of class Comment.
     */
    @Test
    public void testGetContent() {
        System.out.println("getContent");
        Date TestDate = new Date();
        Comment instance = new Comment(123,TestDate,"Test");
        String expResult = "Test";
        String result = instance.getContent();
        assertEquals(expResult, result);
       
    }

   
    
}
