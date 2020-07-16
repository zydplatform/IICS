/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

import com.iics.filemanger.Filepage;
import com.iics.filemanger.PatientFile;
import com.iics.filemanger.UserFileAssignment;
import com.iics.filemanger.ViewFilePage;
import com.iics.service.GenericClassService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

/**
 *
 * @author IICS
 */
@Service("manageDocumentService")
public class ManageDocumentService {

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    String docPages = "0";
    int counter = 0;
    int filelength = 1;

    public List<Map> fetchFilePages(String fileno, GenericClassService genericClassService) {
        List<Map> pages = new ArrayList<>();
        Map<String, Object> filePageObject;
        String[] params = {"fileno"};
        Object[] paramsValues = {fileno};
        String[] fields = {"documentid", "description", "datecreated", "firstname", "lastname"};

        String where = "WHERE fileno=:fileno ORDER BY documentid ASC";

        
        List<Object[]> filePageObjList = (List<Object[]>) genericClassService.fetchRecord(ViewFilePage.class, fields, where, params, paramsValues);
        if (filePageObjList != null) {
            int counter = 1;
            docPages = "0";
            for (Object[] x : filePageObjList) {
                filePageObject = new HashMap();
                List<Map> pageNo = fetchPageDetails(String.valueOf(x[0]), genericClassService);
                filePageObject.put("documentid", x[0]);
                filePageObject.put("pageNo", docPages);
                filePageObject.put("description", x[1]);
                filePageObject.put("datecreated", formatter.format(x[2]));
                filePageObject.put("staffdetails", x[3] + "\t\t\t" + x[4]);
                pages.add(filePageObject);
            }
        }
        return pages;
    }

    public void getAllAssignmentIds(GenericClassService genericClassService) {
    String status = "Out";
        String[] params = {"status"};
        Object[] paramsValues = {status};
        String[] fields = {"fileno", "fileid"};
        String where = "WHERE status=:status";
        List<Object[]> objfile = (List<Object[]>) genericClassService.fetchRecord(PatientFile.class, fields, where, params, paramsValues);
        if (objfile != null) {
            for (Object[] fileobj : objfile) {
                System.out.println("gat File No:" + (String) fileobj[0]);
                String[] params1 = {"datereturned", "status","status1", "fileno"};
                String status1 = "Requested";
                String status2 = "Recalled";
                Object[] paramsValues1 = {new Date(),status1,status2,(String) fileobj[0]};
                String[] fields1 = {"assignmentid", "currentlocation"};
                System.out.println();
                String where1 = "where datereturned<:datereturned AND (status!=:status AND status!=:status1) AND fileno=:fileno";
                List<Object[]> assignmentIdlist = (List<Object[]>) genericClassService.fetchRecord(UserFileAssignment.class, fields1, where1, params1, paramsValues1);
                if (assignmentIdlist != null) {
                    for (Object[] x : assignmentIdlist) {
                        System.out.println(x);
                        Object[] columnValues = {"Recalled"};
                        String[] columns = {"status"};
                        String pk = "assignmentid";
                        Object pkValue = Long.parseLong(x[0].toString());
                        int upadetLocationStatusid = -1;
                        upadetLocationStatusid = genericClassService.updateRecordSQLSchemaStyle(UserFileAssignment.class, columns, columnValues, pk, pkValue, "patient");
                        if(upadetLocationStatusid!=-1){
                        //update patient file
                        }
                    }
                }

            }
        }
    }

    public String getfileLength() {
        return docPages;
    }

public List<Map> fetchPageDetails(String doctumentid, GenericClassService genericClassService) {
        List<Map> pageDetailList = new ArrayList<>();
        Map<String, Object> filePageDetailObject;
        String[] params = {"doctumentid"};
        Object[] paramsValues = {Long.parseLong(doctumentid)};
        String[] fields = {"pageid", "link", "pagenumber"};
        String where = "WHERE  doctumentid=:doctumentid";

        List<Object[]> filePageObjList = (List<Object[]>) genericClassService.fetchRecord(Filepage.class, fields, where, params, paramsValues);
        String[] params2 = {};
        Object[] paramsValues2 = {};
        String where2 = "";
        int results = genericClassService.fetchRecordCount(Filepage.class, where2, params2, paramsValues2);
        if (filePageObjList != null) {


            counter = 1;

            for (Object[] x : filePageObjList) {
                filePageDetailObject = new HashMap();
                filePageDetailObject.put("pageid", x[0]);
                filePageDetailObject.put("link", x[1]);
                filePageDetailObject.put("filename", x[1]);
                filePageDetailObject.put("counter", x[0]);
                filePageDetailObject.put("pagenumber", String.valueOf(x[2]));


                docPages = String.valueOf(Integer.parseInt(docPages) + 1);

             counter++;
                pageDetailList.add(filePageDetailObject);
            }
        }
        return pageDetailList;
    }
}
