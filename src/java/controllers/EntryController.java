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
import models.Entries;
import models.Entry;
import models.Journal;

/**
 *
 * @author Max
 */
public class EntryController implements Serializable{
    private String filePath;
    //private Journal journal;
    private Entries entries;
    
    public EntryController() {
    }

    public EntryController(String filePath, Entries entries) {
        super();
        this.filePath = filePath;
        this.entries = entries;
    }
    
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        JAXBContext jc = JAXBContext.newInstance(Entries.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        FileInputStream fin = new FileInputStream(filePath);
        entries = (Entries) u.unmarshal(fin);
        int x = 5 + 9;
        fin.close();
    }
    
    public void updateXML(Entries entries, String filePath) throws Exception{
        this.entries = entries;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Entries.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(entries, fout);
        fout.close();
    }
    
    public void saveEntries() throws JAXBException, IOException{
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(entries, fout);
        fout.close();
    }
    
    public int getNewEntryID(){
        if(entries.getEntries().size() > 0){
            int finalID = entries.getEntries().get(entries.getEntries().size() - 1).getEntryID();
            return finalID + 1;
        }
        else{
            return 1;
        }
    }
    
    public Entries getEntries(){
        return entries;
    }
    
    public Entries getEntriesForJournal(int userID, int journalID){
        Entries journalEntries = new Entries();
        for(Entry e : entries.getEntries()){
            if(e.getUserID() == userID && e.getJournalID() == journalID){
                journalEntries.addEntry(e);
            }
        }
        return journalEntries;
    }
    
    public Entry getEntryByID(int entryID){
        Entries journalEntries = new Entries();
        for(Entry e : entries.getEntries()){
            if(e.getEntryID() == entryID){
                return e;
            }
        }
        return null;
    }
    
    public Entries getNonHiddenEntries(int userID, int journalID){
        Entries journalEntries = new Entries();
        if(entries.getEntries().size() > 0){
            for(Entry e : entries.getEntries()){
                if(e.getUserID() == userID && e.getJournalID() == journalID && e.getFlag().equals("visible")){
                    journalEntries.addEntry(e);
                }
            }
        }        
        return journalEntries;
    }
    
    public Entries getNonHiddenEntries(){
        Entries journalEntries = new Entries();
        if(entries.getEntries().size() > 0){
            for(Entry e : entries.getEntries()){
                if(e.getFlag().equals("visible")){
                    journalEntries.addEntry(e);
                }
            }
        }
        return journalEntries;
    }
    
    public void setEntries(Entries entries){
        this.entries = entries;
    }
        
    public void hideEntry(int entryID){
        Entry entry = getEntryByID(entryID);
        entry.setFlag("hidden");
        System.out.println("Hidden");
    }
}
