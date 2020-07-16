/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.filemanager;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.service.GenericClassService;
import com.iics.service.filemanager.ManageFileRequestService;
import com.iics.service.filemanager.UserFileAssignmentService;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/filerequest")
public class ManageFileRequest {
     private @Autowired GenericClassService genericClassService;
    private  @Autowired UserFileAssignmentService userFileAssignmentService;
    private @Autowired ManageFileRequestService manageFileRequestService;
   @RequestMapping(value = "/requestassignment", method = RequestMethod.POST)
    public @ResponseBody
    String reQuestAssignment(HttpServletRequest request,
            Model model) {
        String res = "";
        String action = "Requested";
        try {
            List<Map> assignmentids = (ArrayList) new ObjectMapper().readValue(request.getParameter("assignmentids"), List.class);
            String staffId = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
            staffId = "2";
            res = manageFileRequestService.requestFiles(request, assignmentids, action, staffId,genericClassService);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return res;
    }

    @RequestMapping(value = "/approveassignment", method = RequestMethod.POST)
    public @ResponseBody
    String ApproveAssignmentRequest(HttpServletRequest request, Model model) {
        String res = "";
        String action = "Approved";
        try {
            List<Map> assignmentids = (ArrayList) new ObjectMapper().readValue(request.getParameter("assignmentids"), List.class);
            String staffId = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
           res = manageFileRequestService.requestFiles(request, assignmentids, action, staffId,genericClassService);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return res;
    }

    @RequestMapping(value = "/denyassignment", method = RequestMethod.POST)
    public @ResponseBody
    String denyAssignmentRequest(HttpServletRequest request, Model model) {
       String res = "";
       String action = "Denied";
        try {
            List<Map> assignmentids = (ArrayList) new ObjectMapper().readValue(request.getParameter("assignmentids"), List.class);
            
            String staffId = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
            res = manageFileRequestService.requestFiles(request, assignmentids, action, staffId,genericClassService);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return res;
    }

    @RequestMapping(value = "/myfilelist", method = RequestMethod.GET)
    public String getMyFilelist(HttpServletRequest request, Model model) {
       List<Map> listAssignments = new ArrayList<>();
        String staffId = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        String[] params = {"recievedbystaffid", "status"};
        staffId = "2";
        String status="In";
        Object[] paramsValues = {Long.parseLong(staffId),status};
        String[] fields = {"issuedbystaffid", "recievedbystaffid", "firstname",
            "othernames", "lastname", "status", "dateassigned", "datereturned",
            "currentlocation", "assignmentid", "fileno", "fileid"};
        String where = "WHERE recievedbystaffid=:recievedbystaffid AND status!=:status";
        String userType = "borrower";
        listAssignments = manageFileRequestService.assignmentDetails(where,fields,params,paramsValues,userType,genericClassService);
        model.addAttribute("assignments", listAssignments);
        return "fileManagement/views/manageAssignment/myFileList";
    }
@RequestMapping(value = "/listassigmenthistory", method = RequestMethod.GET)
    public String assignmentHistory(HttpServletRequest request, @ModelAttribute("fileid") String fileid,Model model) {
       List<Map> listHistory= new ArrayList<>();
        String[] params3 = {"fileid"};
        Object[] paramsValues3 = {Long.parseLong(fileid)};
        String[] fields3 = {"activityid","staffid","actionDate","assignmentaction"};
        String where3 = "WHERE fileid=:fileid";
         String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        listHistory= manageFileRequestService.getAllAssignmentHistroy(fields3,where3,params3, paramsValues3,facilityidsession,genericClassService,userFileAssignmentService);
        model.addAttribute("assignmentHistory",listHistory);
        return "fileManagement/views/manageAssignment/asignmenthistory";
    }
    @RequestMapping(value = "/listpendingfilerequest", method = RequestMethod.GET)
    public String getPendingFileRequest(Model model) {
        List<Map> listAssignments = new ArrayList<>();
        String[] params = {"status"};
        String status = "Requested";
        Object[] paramsValues = {status};
        String[] fields = {"issuedbystaffid", "recievedbystaffid", "firstname",
            "othernames", "lastname", "status", "dateassigned", "datereturned",
            "currentlocation", "assignmentid", "fileno", "fileid"};
        String where = "WHERE  status=:status";
        String userType = "issuer";
        listAssignments = manageFileRequestService.assignmentDetails(where, fields, params, paramsValues,userType,genericClassService);
        model.addAttribute("assignments", listAssignments);
        return "fileManagement/views/manageAssignment/pendingFileRequest";
    }
  /*  public void sortListMap (List<Map> datalist){
        Collections.sort(datalist, new Comparator<Map>() {
    @Override
    public int compare(Map row1, Map row2) {
        Timestamp createDate1 = (Timestamp) row1.get("Creation Date");
        Timestamp createDate2 = (Timestamp) row2.get("Creation Date");
        return createDate1.compareTo(createDate2);
    }
});
    }*/
}
