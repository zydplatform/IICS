/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

import com.iics.domain.Person;
import com.iics.domain.Staff;
import com.iics.filemanger.PatientFile;
import com.iics.filemanger.SearchPatientFile;
import com.iics.patient.Searchpatient;
import com.iics.service.GenericClassService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;





/**
 *
 * @author user
 */
@Service("manageFileService ")
public class ManageFileService {
     @Autowired  ManageLocationService manageLocationService; 
      
     SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    public List<Map> searchFile(String[] fields,String where,String[] params,Object[] paramsValues,GenericClassService genericClassService){
      List<Map> files = new ArrayList<>();
      List<Object[]> objfile = (List<Object[]>)genericClassService.fetchRecord(SearchPatientFile.class, fields, where, params, paramsValues);
      Map<String, Object> file; 
       if (objfile != null) {
        for (Object[] fileobj : objfile) {
                file = new HashMap<>();
                file.put("patientid",  String.valueOf(fileobj[0]));
                file.put("othernames", (String) fileobj[1]);
                file.put("lastname", (String) fileobj[2]);
                file.put("firstname", (String) fileobj[3]);
                file.put("fileno", (String) fileobj[4]);
                file.put("fileid",  fileobj[5]);
                file.put("staffid", (String) fileobj[6]);
                file.put("status", String.valueOf(fileobj[7]));
                System.out.println(fileobj[2]);
                file.put("datecreated",formatter.format(fileobj[8]));
                files.add(file);
        }   
       }
       return files;
    }
    
  public boolean checkIfFileExist(String[] fields,String where,String[] params,Object[] paramsValues,GenericClassService genericClassService){
    List<Object[]> objfile = (List<Object[]>)genericClassService.fetchRecord(SearchPatientFile.class, fields, where, params, paramsValues);
    boolean newFileSttus=false;   
    if (objfile != null) {
         newFileSttus=true;
       }
       return newFileSttus;
    }
    public List<Map> searchPatient(String[] fields,String where,String[] params,Object[] paramsValues,GenericClassService genericClassService){
       List<Map> files = new ArrayList<>();
       List<Object[]> objfile = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, where, params, paramsValues);
      Map<String, Object> file; 
       if (objfile != null) {
        for (Object[] fileobj : objfile) {
                file = new HashMap<>();
                file.put("patientid",  String.valueOf(fileobj[0]));
                file.put("othernames", (String) fileobj[1]);
                file.put("lastname", (String) fileobj[2]);
                file.put("firstname", (String) fileobj[3]);
                files.add(file);
        }
       }
       return files;
    }
   public String generateFileId(String facilityid,GenericClassService genericClassService){
        Map facility= manageLocationService.getFaciltyName(facilityid,genericClassService);
       String facilityname= facility.get("facilityname").toString();
       System.out.println(facilityname);
        String pattern =facilityname.substring(0,3);
        String fileno="";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        facilityid=formatterlength(facilityid,facilityid.length(),4);
         pattern += "/" + f.format(new Date()) + "/";
        String[] params = {};
        Object[] paramsValues = {};
         String[] fields = {"fileid"};
        String where = "";
        int results= genericClassService.fetchRecordCount(PatientFile.class,where, params, paramsValues); 
        String idlength=String.valueOf(results+1);
         idlength=formatterlength(idlength,idlength.length(),6);
        pattern+=idlength;
       fileno=pattern;
        return fileno;
 }
   private String formatterlength(String actualString,int stringLength,int stringMaxLength){
     int n=stringMaxLength-stringLength;
      for(int i=0; i<n; i++){
            actualString="0"+actualString;
       }
       return actualString;
   }   
public Map getStaffDetail(String staffid,GenericClassService genericClassService){
        String[] params = {"staffid"};
        String where = "WHERE staffid=:staffid";
        Object[] paramsValues = {Long.parseLong(staffid)};
        String[] fields = {"staffid", "personid.personid","staffno"};
       Map staffDetails = new HashMap<>();
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);
        if (found != null) {
            String[] params1 = {"personid"};
             System.out.println("got person id no"+String.valueOf(found.get(0)[1]));
            Object[] paramsValues1 = {(Long) (found.get(0)[1])};
            String[] fields111 = {"firstname", "lastname", "othernames"};
            String where1 = "WHERE personid=:personid";
            List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields111, where1, params1, paramsValues1);
            if (found1 != null) {
                Object[] f = found1.get(0);
                staffDetails.put("firstname",  String.valueOf(f[0]));
                staffDetails.put("lastname", String.valueOf(f[1]));
                staffDetails.put("othernames", String.valueOf(f[2]));
                System.out.println("got person id no");
                staffDetails.put("staffno", String.valueOf(found.get(0)[2]));
                System.out.println("othername"+String.valueOf(found.get(0)[1]));
            }
}
        return staffDetails;
}
}

