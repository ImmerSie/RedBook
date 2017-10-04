/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import models.Users;

/**
 * An application allowing users to be created, retrieved and modified.
 * 
 * <p>The application is held in application context, and provides the
 * functionality that enables the securing of journals.</p>
 * 
 * @author Max
 */
public class LoginController implements Serializable{
    private String filePath;
    private Users users;

    public LoginController() {
    }

    public LoginController(String filePath, Users users) {
        super();
        this.filePath = filePath;
        this.users = users;
    }
    
    /**
     * Perform initial retrieval of data from the users.xml file
     * 
     * @param filePath The filepath to users.xml
     * @throws Exception 
     */
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(Users.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        // Streams the xml file into the users object
        FileInputStream fin = new FileInputStream(filePath);
        users = (Users) u.unmarshal(fin);
        fin.close();
    }
    
    /**
     * Explicit form of saving user data; used when the application hasn't been set up
     * 
     * @param users The collection of user data to be persisted
     * @param filePath The path to the users.xml file
     * @throws Exception 
     */
    public void updateXML(Users users, String filePath) throws Exception{
        this.users = users;
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(Users.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the user data into the xml file
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(users, fout);
        fout.close();
    }
    
    /**
     * Less explicit way of saving the user data to the users.xml file
     * 
     * @throws JAXBException
     * @throws IOException 
     */
    public void saveUsers() throws JAXBException, IOException{
        // Sets up helper classes
        JAXBContext jc = JAXBContext.newInstance(Users.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the user data into the xml file
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(users, fout);
        fout.close();
    }
    
    /**
     * Gets a unique id by incrementing the last user record by 1
     * 
     * @return The new, unique id for a user
     */
    public int getNewUserID(){
        if(users.getUsers().size() > 0){
            int finalID = users.getUsers().get(users.getUsers().size() - 1).getUserID();
            return finalID + 1;
        }
        else{
            return 1;
        }
    }
    
    public Users getUsers(){
        return users;
    }
    
    public void setUsers(Users users){
        this.users = users;
    }
}
