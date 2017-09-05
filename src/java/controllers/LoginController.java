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
    
    public void setFilePath(String filePath) throws Exception{
        this.filePath = filePath;
        
        JAXBContext jc = JAXBContext.newInstance(Users.class);
        Unmarshaller u = jc.createUnmarshaller();
        
        FileInputStream fin = new FileInputStream(filePath);
        users = (Users) u.unmarshal(fin);
        fin.close();
    }
    
    public void updateXML(Users users, String filePath) throws Exception{
        this.users = users;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Users.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(users, fout);
        fout.close();
    }
    
    public void saveUsers() throws JAXBException, IOException{
        JAXBContext jc = JAXBContext.newInstance(Users.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(users, fout);
        fout.close();
    }
    
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
