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
import models.Journal;
import models.User;

/**
 * Application that enables the CRUD for a users journals to be performed
 * 
 * <p>Held in the session data for a specific session</p>
 * 
 * @author Sarah
 */
public class JournalController implements Serializable{
    private String filePath;
    private User user;

    public JournalController() {
    }

    public JournalController(String filePath, User user) {
        super();
        this.filePath = filePath;
        this.user = user;
    }
    
    /**
     * Perform initial retrieval of data from the journals.xml file
     * 
     * @param filePath The filepath to journals.xml
     * @throws Exception 
     */
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        // Sets up helper classes
        JAXBContext jc = JAXBContext.newInstance(User.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        // Streams the xml data into the user object
        FileInputStream fin = new FileInputStream(filePath);
        user = (User) u.unmarshal(fin);
        fin.close();
    }
    
    /**
     * Explicit form of saving journal data; used when the application hasn't been set up
     * 
     * @param user The collection of journal data to be persisted (within the user object)
     * @param filePath The path to the journal.xml file
     * @throws Exception 
     */
    public void updateXML(User user, String filePath) throws Exception{
        this.user = user;
        this.filePath = filePath;
        
        // Sets up the helper classes
        JAXBContext jc = JAXBContext.newInstance(User.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the journal data into the xml file
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(user, fout);
        fout.close();
    }
    
    /**
     * Less explicit way of saving the journal data to the journals.xml file
     * 
     * @throws JAXBException
     * @throws IOException 
     */
    public void saveJournals() throws JAXBException, IOException{
        // Sets up helper methods
        JAXBContext jc = JAXBContext.newInstance(User.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the journal data into the xml file
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(user, fout);
        fout.close();
    }
    
    /**
     * Gets a journal id that is unique for the users set of journals
     * 
     * @return The new unique id
     */
    public int getNewJournalID(){
        if(user.getJournals().size() > 0){
            int finalID = user.getJournals().get(user.getJournals().size() - 1).getJournalID();
            return finalID + 1;
        }
        else{
            return 1;
        }
    }
    
    /**
     * Retrieves a single journal record from its id (requisite userID gotten from class fields)
     * 
     * @param journalID The id required to identify the users journal
     * @return The journal with the associated id
     */
    public Journal getJournalFromID(int journalID){
        for(Journal j : user.getJournals()){
            if(j.getJournalID() == journalID){
                return j;
            }
        }
        return null;
    }
    
    public User getUser(){
        return user;
    }
    
    public void setUser(User user){
        this.user = user;
    }
}
