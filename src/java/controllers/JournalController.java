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
 *
 * @author Max
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
    
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        JAXBContext jc = JAXBContext.newInstance(User.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        FileInputStream fin = new FileInputStream(filePath);
        user = (User) u.unmarshal(fin);
        fin.close();
    }
    
    public void updateXML(User user, String filePath) throws Exception{
        this.user = user;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(User.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(user, fout);
        fout.close();
    }
    
    public void saveJournals() throws JAXBException, IOException{
        JAXBContext jc = JAXBContext.newInstance(User.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(user, fout);
        fout.close();
    }
    
    public int getNewJournalID(){
        if(user.getJournals().size() > 0){
            int finalID = user.getJournals().get(user.getJournals().size() - 1).getJournalID();
            return finalID + 1;
        }
        else{
            return 1;
        }
    }
    
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
