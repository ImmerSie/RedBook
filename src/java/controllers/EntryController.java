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

/**
 *
 * @author Max
 */
public class EntryController implements Serializable{
    private String filePath;
    private Journal journal;

    public EntryController() {
    }

    public EntryController(String filePath, Journal journal) {
        super();
        this.filePath = filePath;
        this.journal = journal;
    }
    
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        FileInputStream fin = new FileInputStream(filePath);
        journal = (Journal) u.unmarshal(fin);
        fin.close();
    }
    
    public void updateXML(Journal journal, String filePath) throws Exception{
        this.journal = journal;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(journal, fout);
        fout.close();
    }
    
    public void saveEntries() throws JAXBException, IOException{
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(journal, fout);
        fout.close();
    }
    
    public int getNewEntryID(){
        if(journal.getEntries().size() > 0){
            int finalID = journal.getEntries().get(journal.getEntries().size() - 1).getEntryID();
            return finalID + 1;
        }
        else{
            return 1;
        }
    }
    
    public Journal getJournal(){
        return journal;
    }
    
    public void setJournal(Journal journal){
        this.journal = journal;
    }
}
