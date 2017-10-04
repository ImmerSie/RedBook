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
import models.Entry;
import models.EntryHistory;

/**
 * An application that allows for the CRUD involving an entry's history
 * 
 * <p>Held in page data, for the viewEntries.jsp page</p>
 * 
 * @author Max
 */
public class EntryHistoryController implements Serializable{
    private String filePath;
    private Entry entry;
    
    public EntryHistoryController() {
    }

    public EntryHistoryController(String filePath, Entry entry) {
        super();
        this.filePath = filePath;
        this.entry = entry;
    }
    
    /**
     * Perform initial retrieval of data from the entriesHistory.xml file
     * 
     * @param filePath The filepath to entriesHistory.xml
     * @throws Exception 
     */
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        // Sets up helper methods
        JAXBContext jc = JAXBContext.newInstance(Entry.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        // Streams the xml data into the model
        FileInputStream fin = new FileInputStream(filePath);
        entry = (Entry) u.unmarshal(fin);
        fin.close();
    }
    
    /**
     * Explicit form of saving entry history data; used when the application hasn't been set up
     * 
     * @param entry The collection of entry history data to be persisted (within the entry object)
     * @param filePath The path to the entriesHistory.xml file
     * @throws Exception 
     */
    public void updateXML(Entry entry, String filePath) throws Exception{
        this.entry = entry;
        this.filePath = filePath;
        
        // Sets up the helper methods
        JAXBContext jc = JAXBContext.newInstance(Entry.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the entry history data into the xml file
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(entry, fout);
        fout.close();
    }
    
    /**
     * Less explicit way of saving the entry history data to the entriesHistory.xml file
     * 
     * @throws JAXBException
     * @throws IOException 
     */
    public void saveEntryHistory() throws JAXBException, IOException{
        // Sets up helper methods
        JAXBContext jc = JAXBContext.newInstance(Entry.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
        // Streams the entry history data to the xml
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(entry, fout);
        fout.close();
    }

    public Entry getEntry() {
        return entry;
    }

    public void setEntry(Entry entry) {
        this.entry = entry;
    }
    
    /**
     * Retrieves the entry history record from the id
     * 
     * @param hisID The unique (for the entry) id for the entry history record
     * @return The associated entry history record
     */
    public EntryHistory getEntryHisFromID(int hisID){
        for(EntryHistory eh : entry.getHistory()){
            if(eh.getEntryHisID() == hisID){
                return eh;
            }
        }
        return null;
    }
        
}
