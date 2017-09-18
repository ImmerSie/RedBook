/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="entries")
public class Entries implements Serializable{
    @XmlElement(name="entry")
    private ArrayList<Entry> entryList = new ArrayList<Entry>();

    public ArrayList<Entry> getEntries() {
        return entryList;
    }

    public void addEntry(Entry entry){
        entryList.add(entry);
    }
    
}
