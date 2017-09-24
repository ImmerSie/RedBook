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
import java.util.ArrayList;
import java.util.Comparator;
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
    private Journal oldJournal;
    //private Journal journal;
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
        int x = 5 + 9;
        this.oldJournal = journal;
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
        Entry e = journal.getEntries().get(journal.getEntries().size() - 1);
        oldJournal.addEntry(e);
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(oldJournal, fout);
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
    
    public ArrayList<Entry> getEntries(){
        return journal.getEntries();
    }
    
    public ArrayList<Entry> getEntriesForJournal(int userID, int journalID){
        ArrayList<Entry> journalEntries = new ArrayList<Entry>();
        for(Entry e : journal.getEntries()){
            if(e.getUserID() == userID && e.getJournalID() == journalID){
                journalEntries.add(e);
            }
        }
        return journalEntries;
    }
    
    public Entry getEntryByID(int entryID){
        Entries journalEntries = new Entries();
        for(Entry e : journal.getEntries()){
            if(e.getEntryID() == entryID){
                return e;
            }
        }
        return null;
    }
    
    /**public Entries getNonHiddenEntries(int userID, int journalID){
        Entries journalEntries = new Entries();
        if(entries.getEntries().size() > 0){
            for(Entry e : entries.getEntries()){
                if(e.getUserID() == userID && e.getJournalID() == journalID && e.getFlag().equals("visible")){
                    journalEntries.addEntry(e);
                }
            }
        }        
        return journalEntries;
    }**/
    
    public Entries getAllEntries(){
        Entries journalEntries = new Entries();
        if(journal.getEntries().size() > 0){
            for(Entry e : journal.getEntries()){
                journalEntries.addEntry(e);
            }
        }
        return journalEntries;
    }
    
    public Entries getHiddenEntries(){
        Entries journalEntries = new Entries();
        if(journal.getEntries().size() > 0){
            for(Entry e : journal.getEntries()){
                if(e.getFlag().equals("hidden")){
                    journalEntries.addEntry(e);
                }
            }
        }
        return journalEntries;
    }
    
    public Entries getNonHiddenEntries(){
        Entries journalEntries = new Entries();
        if(journal.getEntries().size() > 0){
            for(Entry e : journal.getEntries()){
                if(e.getFlag().equals("visible")){
                    journalEntries.addEntry(e);
                }
            }
        }
        return journalEntries;
    }
    
    public Journal getJournal(){
        return this.journal;
    }
    
    public void setJournal(Journal journal){
        this.journal = journal;
    }
        
    public void hideEntry(int entryID){
        Entry entry = getEntryByID(entryID);
        if(entry.getFlag().equals("hidden")){
            entry.setFlag("visible");
        }
        else if(entry.getFlag().equals("visible")){
            entry.setFlag("hidden");
        }
    }
    
    public ArrayList<Entry> sortByTitle(ArrayList<Entry> e){
        e.sort(Comparator.comparing(Entry::getTitleLowercase));
        return e;
    }
    
    public ArrayList<Entry> sortByTitleDesc(ArrayList<Entry> e){
        e.sort(Comparator.comparing(Entry::getTitleLowercase, (s1, s2) -> {
            return s2.compareTo(s1);
        }));
        return e;
    }
}
