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
public class EntryHistoryController implements Serializable{
    private String filePath;
    //private Journal journal;
    private Entry entry;
    
    public EntryHistoryController() {
    }

    public EntryHistoryController(String filePath, Entry entry) {
        super();
        this.filePath = filePath;
        this.entry = entry;
    }
    
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        JAXBContext jc = JAXBContext.newInstance(Entry.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        FileInputStream fin = new FileInputStream(filePath);
        entry = (Entry) u.unmarshal(fin);
        fin.close();
    }
    
    public void updateXML(Entry entry, String filePath) throws Exception{
        this.entry = entry;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Entry.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(entry, fout);
        fout.close();
    }
    
    public void saveEntryHistory() throws JAXBException, IOException{
        JAXBContext jc = JAXBContext.newInstance(Entry.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
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
    
    
}
