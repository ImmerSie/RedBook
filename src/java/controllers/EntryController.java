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
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import models.Entry;
import models.Journal;

/**
 * The application which handles CRUD for the entries
 * 
 * <p>Held in session context </p>
 * 
 * @author Sarah
 */
public class EntryController implements Serializable{
    private String filePath;
    private Journal oldJournal;
    private Journal journal;
    
    public EntryController() {
    }

    /**
     * Constructs the Entry controller with file path and the journal
     * 
     * @param filePath The path to where the xml is located (entries.xml)
     * @param journal The journal, the entry will be located in
     */
    public EntryController(String filePath, Journal journal) {
        super();
        this.filePath = filePath;
        this.journal = journal;
    }
    
    /**
     * Perform initial retrieval of data from the entries.xml file
     * 
     * @param filePath The path to the entries.xml file
     * @throws Exception if file path is invalid or does not exist
     */
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        // Sets up the helper methods
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        // Streams the xml data into the data object
        FileInputStream fin = new FileInputStream(filePath);
        journal = (Journal) u.unmarshal(fin);
        this.oldJournal = journal;
        fin.close();
    }
    
    /**
     * Explicit form of saving entry data; used when the application hasn't been set up
     * 
     * @param journal The collection of entry data to be persisted (within the journal object)
     * @param filePath The path to the entries.xml file
     * @throws Exception 
     */
    public void updateXML(Journal journal, String filePath) throws Exception{
        this.journal = journal;
        this.filePath = filePath;
        
        // Set up helper method
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the xml data into the journal object
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(journal, fout);
        fout.close();
    }
    
    /**
     * Less explicit way of saving the entries data to the entries.xml file
     * 
     * @throws JAXBException
     * @throws IOException 
     */
    public void saveEntries() throws JAXBException, IOException{
        // Prevents replication of entries upon modification; checks each new record against old records
        for(Entry e : journal.getEntries()){
            if(oldJournal.getEntries().contains(e)){
                for(Entry o : oldJournal.getEntries()){
                    if(o.getUserID() == e.getUserID() && o.getJournalID() == e.getJournalID() && o.getEntryID() == e.getEntryID()){
                        o.replaceEntry(e);
                    }
                }
            }
            else{
                oldJournal.addEntry(e);
            }
           
        }
        
        // Sets up helper methods
        JAXBContext jc = JAXBContext.newInstance(Journal.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams entry data into the xml file
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(oldJournal, fout);
        fout.close();
    }
    
    /**
     * Gets a new id for the entries by incrementing the id of the latest entry
     * 
     * @return The unique (for the journal) id for the entry
     */
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
    
    /**
     * Gets only the entries linked with a journal
     * 
     * @param userID The identifier for the user (required for the journalID to be unique)
     * @param journalID The identifier for the journal (required for the entryID to be unique)
     * @return 
     */
    public ArrayList<Entry> getEntriesForJournal(int userID, int journalID){
        ArrayList<Entry> journalEntries = new ArrayList<>();
        for(Entry e : journal.getEntries()){
            if(e.getUserID() == userID && e.getJournalID() == journalID){
                journalEntries.add(e);
            }
        }
        return journalEntries;
    }
    
    /**
     * Uses the controller fields to get an entry from the entry's id
     * 
     * @param entryID The id for the entry (unique for the journal)
     * @return 
     */
    public Entry getEntryByID(int entryID){
        ArrayList<Entry> journalEntries = new ArrayList<>();
        for(Entry e : journal.getEntries()){
            if(e.getEntryID() == entryID){
                return e;
            }
        }
        return null;
    }
    
    /**
     * Gets any entries created on a specified day
     * 
     * @param date The date which the user specifies to get entries from
     * @return 
     */
    public ArrayList<Entry> getByDate(Date date){
        // Sets up variables to be used as comparators (c1 is the specified date)
        Calendar c1 = Calendar.getInstance();
        c1.setTime(date);
        Calendar c2 = Calendar.getInstance();
        ArrayList<Entry> dateEntries = new ArrayList<>();
        
        // Iterates through the entries, adding all created on the specifies date
        for(Entry e : journal.getEntries()){
            c2.setTime(e.getDateCreated());
            if(c1.get(Calendar.YEAR) == c2.get(Calendar.YEAR) && c1.get(Calendar.DAY_OF_YEAR) == c2.get(Calendar.DAY_OF_YEAR)){
                dateEntries.add(e);
            }
        }
        return dateEntries;
    }
    
    /**
     * Gets the entries which title contains a given string input
     * 
     * @param title The input which the user is searching in the title for
     * @return A list of entries, where the title contains the given string input
     */
    public ArrayList<Entry> getByTitle(String title){
        ArrayList<Entry> titleEntries = new ArrayList<>();
        for(Entry e : journal.getEntries()){
            if(e.getTitle().contains(title)){
                titleEntries.add(e);
            }
        }
        return titleEntries;
    }
    
    /**
     * Gets all entries, regardless of whether they're flagged hidden or deleted
     * 
     * @return A list representing all the entries for a given journal
     */
    public ArrayList<Entry> getAllEntries(){
        ArrayList<Entry> journalEntries = journal.getEntries();
        /*ArrayList<Entry> journalEntries = new ArrayList<>();
        ArrayList<Entry> entriesList = sortByDate(journal.getEntries());
        if(entriesList.size() > 0){
            for(Entry e : entriesList){
                journalEntries.add(e);
            }
        }*/
        return journalEntries;
    }
    
    /**
     * Gets all the entries that are flagged hidden
     * 
     * @return A list representing all the entries that have been flagged hidden
     */
    public ArrayList<Entry> getHiddenEntries(){
        ArrayList<Entry> journalEntries = new ArrayList<>();
        ArrayList<Entry> entriesList = getAllEntries();
        if(entriesList.size() > 0){
            for(Entry e : entriesList){
                if(e.getFlag().equals("hidden")){
                    journalEntries.add(e);
                }
            }
        }
        return journalEntries;
    }
    
    public ArrayList<Entry> getDeletedEntries(){
        ArrayList<Entry> journalEntries = new ArrayList<>();
        ArrayList<Entry> entriesList = getAllEntries();
        if(entriesList.size() > 0){
            for(Entry e : entriesList){
                if(e.getFlag().equals("deleted")){
                    journalEntries.add(e);
                }
            }
        }
        return journalEntries;
    } 
    
    /**
     * Gets all the entries that are not flagged hidden
     * 
     * @return A list representing all the entries that are not flagged hidden
     */
    public ArrayList<Entry> getVisibleEntries(){
        ArrayList<Entry> journalEntries = new ArrayList<>();
        ArrayList<Entry> entriesList = getAllEntries();
        if(entriesList.size() > 0){
            for(Entry e : entriesList){
                if(e.getFlag().equals("visible")){
                    journalEntries.add(e);
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
        
    /**
     * Changes an entries flag to hidden (if visible) or visible (if hidden)
     * 
     * @param entryID The id of the entry whose flag must be changed
     */
    public void changeEntryVisibility(int entryID){
        Entry entry = getEntryByID(entryID);
        if(entry.getFlag().equals("hidden")){
            entry.setFlag("visible");
        }
        else if(entry.getFlag().equals("visible")){
            entry.setFlag("hidden");
        }
    }
    
    public void hideEntry(Entry entry){
        if(entry.getFlag().equals("visible")){
            entry.setFlag("hidden");
        }
    }
    
    public void deleteEntry(Entry entry){
        entry.setFlag("deleted");
    }
    
    public void visibleEntry(Entry entry){
        if(entry.getFlag().equals("hidden")){
            entry.setFlag("visible");
        }
    }
    
    /**
     * Sorts a given list of entries, by the title, alphabetically
     * 
     * @param e The list of entries to be sorted
     * @return 
     */
    public ArrayList<Entry> sortByTitle(ArrayList<Entry> e){
        e.sort(Comparator.comparing(Entry::getTitleLowercase));
        return e;
    }
    
    /**
     * Sorts a given list of entries, by the title, reverse alphabetically
     * 
     * @param e The list of entries to be sorted
     * @return 
     */
    public ArrayList<Entry> sortByTitleDesc(ArrayList<Entry> e){
        e.sort(Comparator.comparing(Entry::getTitleLowercase, (s1, s2) -> {
            return s2.compareTo(s1);
        }));
        return e;
    }
    
    public ArrayList<Entry> sortByDate(ArrayList<Entry> e){
        e.sort(Comparator.comparing(Entry::getDateCreated, (s1, s2) -> {
            return s2.compareTo(s1);
        }));
        return e;
    }
}