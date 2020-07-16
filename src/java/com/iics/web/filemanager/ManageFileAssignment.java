/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.filemanager;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.filemanger.PatientFile;
import com.iics.filemanger.UserFileAssignment;
import com.iics.service.GenericClassService;
import com.iics.service.filemanager.Filemanagerservicelocator;
import com.iics.service.filemanager.UserFileAssignmentService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
@RequestMapping("/fileassignment")
public class ManageFileAssignment {
    private @Autowired GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    Map<String, Object> fileObjMap = null;
    HttpSession session;
   //Filemanagerservicelocator f= Filemanagerservicelocator.getInstance();
    private @Autowired UserFileAssignmentService userFileAssignmentService;
    @RequestMapping(value = "/searchstaffreturnfile", method = RequestMethod.GET)
    public String viewFileAssignments(HttpServletRequest request,
            @ModelAttribute("fileno") String fileno,
             @ModelAttribute("fileid") String fileid, Model model) {
         model.addAttribute("fileno", fileno);
         session = request.getSession();
         session.setAttribute("fileid",fileid);
        return "fileManagement/forms/searchStaffFileAssigment";
    }
    @RequestMapping(value = "/searchstaffs", method = RequestMethod.POST)
    public String searchstaffs(HttpServletRequest request, Model model,
            @ModelAttribute("searchValue") String searchValue) {
        String[] params = {"value", "currentfacility"};
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        Object[] paramsValues = {"%" + searchValue.toLowerCase() + "%", Integer.parseInt(facilityidsession)};
        String[] fields = {"staffid", "staffno", "firstname", "lastname"};
        String where = "WHERE currentfacility=:currentfacility AND (LOWER(firstname) LIKE :value OR LOWER(lastname) LIKE :value)ORDER BY staffno DESC";
        List<Map> staff = userFileAssignmentService.searchStaff(fields, where, params, paramsValues,genericClassService);
        model.addAttribute("staff", staff);
        model.addAttribute("name", searchValue);
        return "fileManagement/views/manageAssignment/staffSearchResults";
    }

    @RequestMapping(value = "/retrievestaffdetails", method = RequestMethod.GET)
    public String getStaffDetails(Model model, @ModelAttribute("staffid") String staffid,
            HttpServletRequest request) {
        List<Map> staffDetails = new ArrayList<>();
        session = request.getSession();
        session.setAttribute("recepientStaffid",staffid);
         String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        String[] params = {"currFacility", "staffid"};
        Object[] paramsValues = {Integer.parseInt(facilityidsession),Long.parseLong(staffid)};
        
        String[] fields = {"firstname", "othernames", "lastname", "staffno","personid","designationid","currentfacility","staffid"};
        String where = "WHERE currentfacility=:currFacility AND staffid=:staffid";
        staffDetails = userFileAssignmentService.getStaffDetails(fields, where, params, paramsValues,genericClassService);
        model.addAttribute("staffDetails", staffDetails);
        return "fileManagement/views/manageAssignment/StaffDetails";
    }

    @RequestMapping(value = "/saveassignment", method = RequestMethod.POST)
    public @ResponseBody String assignFileToUser(Model model, HttpServletRequest request,
            @ModelAttribute("recepientStaffid") String recepientStaffid,
            @ModelAttribute("fileno") String fileno,
            @ModelAttribute("returnDateValue") String returnDateValue,
            @ModelAttribute("fileid") String fileid,
            @ModelAttribute("facilityunitid") String facilityunitid) {
        String issuererStaffid = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        //inserts assignments into db
        session = request.getSession();
        session.setAttribute("fileno",fileno);
        session.setAttribute("fileid",fileid);
        session.setAttribute("returnDateValue", returnDateValue);
        session.setAttribute("issuererStaffid", issuererStaffid);
        session.setAttribute("currentLocation", facilityunitid);
         return "success";
    }

    @RequestMapping(value = "/confirmassignment", method = RequestMethod.GET)
    public @ResponseBody
    String userConfirmFileReciept(Model model,
            @ModelAttribute("username") String username,
            @ModelAttribute("password") String password,
            HttpServletRequest request) {
        boolean status = false;
        String[] params = {"username","password"};
        Object[] paramsValues = {username,password};
        String where = "WHERE username=:username AND password=:password";
        String[] fields = {"active", "password"};
        status = userFileAssignmentService.confirmFileReciept(fields, where, params, paramsValues, status, password,genericClassService);
        String message;
        String result = "";
        fileObjMap = new HashMap();
        if (status) {
            HttpSession session = request.getSession();
            String recievedbystaffid = session.getAttribute("recepientStaffid").toString();
            String fileno = session.getAttribute("fileno").toString();
            String fileid = session.getAttribute("fileid").toString();
            String datereturned = session.getAttribute("returnDateValue").toString();
            String issuedbystaffid = session.getAttribute("issuererStaffid").toString();
            String currentLocation = session.getAttribute("currentLocation").toString();
            Date dateassigned = null;
            UserFileAssignment newAssignment = new UserFileAssignment();
            try {
                dateassigned = formatter.parse(formatter.format(new Date()));
                newAssignment.setReturnDate(formatter.parse(datereturned.replaceAll("/", "-")));
            } catch (Exception e) {
                System.out.println(e.getMessage().toString());
            }
            newAssignment.setIssueDate(dateassigned);
            newAssignment.setIssuerid(Long.parseLong(issuedbystaffid));
            newAssignment.setRecieverid(Long.parseLong(recievedbystaffid));
            newAssignment.setFileno(fileno.toUpperCase());
            newAssignment.setCurrentlocation(Long.parseLong(currentLocation));
            newAssignment.setFilestatus("Out");
            newAssignment = (UserFileAssignment) genericClassService.saveOrUpdateRecordLoadObject(newAssignment);
         if (newAssignment != null) {
         String[] columns = {"status"};
         Object[] columnValues = {"Out"};
         String pk = "fileid";
         Object pkValue =Integer.parseInt(session.getAttribute("fileid").toString());
       int id=-1;
        id=genericClassService.updateRecordSQLSchemaStyle(PatientFile.class, columns, columnValues, pk, pkValue, "patient");
         if (id!=-1) {
           String action="Issued";
           String staffId=request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
          userFileAssignmentService.addNewActivity(request,fileid,action,staffId,genericClassService);
           String action2="Recieved";
          userFileAssignmentService.addNewActivity(request,fileid,action2,recievedbystaffid,genericClassService);
           fileObjMap.put("status", "success");
           fileObjMap.put("message", "Seccessfully Assigned A File");
        }
      } 
        }else {
                fileObjMap.put("status", "failed");
            }
            try {
                result = new ObjectMapper().writeValueAsString(fileObjMap);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
             return result;
    } 
 
    /* Active Assignment Tab--> Start*/
    //list all active assignments
   @RequestMapping(value = "/listassignments", method = RequestMethod.GET)
    public String getAssignmentlist(HttpServletRequest request,Model model) {
        List<Map> listAssignments = new ArrayList<>();
        String[] params = {"status","status2"};
        String status="Recalled";
        String status2="In";
       Object[] paramsValues = {status,status2};
        String[] fields = {"issuedbystaffid","recievedbystaffid", "firstname",
            "othernames","lastname","status","dateassigned","datereturned",
            "currentlocation","assignmentid","fileno","fileid"};
       String where = "WHERE  status!=:status OR status!=:status2";
       String userType="Assignment";
       listAssignments =userFileAssignmentService.assignmentDetails(where,fields,params,paramsValues,genericClassService,userType);
       model.addAttribute("assignments", listAssignments);
        userFileAssignmentService.getAllAssignmentIds(genericClassService);
        return "fileManagement/views/manageAssignment/manageAssignment";
    }
    
     // handover files 
     @RequestMapping(value = "/handoverfiles", method = RequestMethod.POST)
    public @ResponseBody String handOverFiles(Model model,HttpServletRequest request) {
        String res="";
        try{
       List<Map> assignmentids= (ArrayList) new ObjectMapper().readValue(request.getParameter("assignmentids"), List.class);
       String assignmentStatus =request.getParameter("assignmentStatus"); 
        session = request.getSession();
        session.setAttribute("assignmentids",assignmentids);
        session.setAttribute("assignmentStatus",assignmentStatus);
         res="success";
      }catch(Exception e){
     System.out.println(e.getMessage());
    }
    return res;
    }
    // handover files 
   @RequestMapping(value = "/recallfiles", method = RequestMethod.POST)
    public @ResponseBody String recallFiles(Model model,HttpServletRequest request) {
        String res="";
        String action="Recalled";
         System.out.println(action);
        try{
       List<Map> assignmentids= (ArrayList) new ObjectMapper().readValue(request.getParameter("assignmentids"), List.class);
       String staffId=request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
       res=userFileAssignmentService.recallMultipleFiles(request,assignmentids,action,staffId,genericClassService);
       }catch(Exception e){
    System.out.println(e.getMessage());
    }
    return res;
    }
     //confirm file handover  
    @RequestMapping(value = "/confirmfilehandover", method = RequestMethod.GET)
    public @ResponseBody String confirmFilesHandOver(Model model,
            @ModelAttribute("username") String username,
            @ModelAttribute("password") String password,
            HttpServletRequest request) {
         boolean status = false;
        String[] params = {"username"};
        Object[] paramsValues = {username};
        String where = "WHERE username=:username";
        String[] fields = {"active", "password"};
       status = userFileAssignmentService.confirmFileReciept(fields, where, params, paramsValues, status, password,genericClassService);
       String result = "";
       fileObjMap = new HashMap();
      if (status) {
          String[] columns = {"status"};
         Object[] columnValues = {session.getAttribute("assignmentStatus").toString()};
         String pk = "assignmentid";
         List<Map> assignmentids=(ArrayList)session.getAttribute("assignmentids");
         for (Map assignmentObj : assignmentids) {
         Object pkValue =Long.parseLong(assignmentObj.get("assignmentid").toString());
         String fileid=assignmentObj.get("fielid").toString();
         int upadetLocationStatusid=-1;
         upadetLocationStatusid=genericClassService.updateRecordSQLSchemaStyle(UserFileAssignment.class, columns, columnValues, pk, pkValue, "patient");
         if (upadetLocationStatusid!=-1) {
         String[] columns2 = {"status"};
         Object[] columnValues2 = {"In"};
         String pk2 = "fileid";
         Object pkValue2 =Long.parseLong(fileid);
         int upadetFileStatusid=-1;
        upadetFileStatusid=genericClassService.updateRecordSQLSchemaStyle(PatientFile.class, columns2, columnValues2, pk2, pkValue2, "patient");
        if (upadetFileStatusid!=-1) {
            String action="In";
            String staffId=request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
            userFileAssignmentService.addNewActivity(request,fileid,action,staffId,genericClassService);
           fileObjMap.put("status", "success");
       }
        }
         else {
                fileObjMap.put("status", "failed");
            }
       }
       }
        try {
                result = new ObjectMapper().writeValueAsString(fileObjMap);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
             return result;
    }
    /* OverDued Assignment Tab--> Stop*/
    
    @RequestMapping(value = "/listrecalledassignments", method = RequestMethod.GET)
    public String getRecalledAssignmentlist(Model model) {
        List<Map> listAssignments = new ArrayList<>();
        String[] params = {"status"};
        String status="Recalled";
        Object[] paramsValues = {status};
        String[] fields = {"issuedbystaffid","recievedbystaffid", "firstname",
            "othernames","lastname","status","dateassigned","datereturned",
            "currentlocation","assignmentid","fileno","fileid"};
       String where = "WHERE status=:status";
        String userType="Assignment";
       listAssignments =userFileAssignmentService.assignmentDetails(where,fields,params,paramsValues,genericClassService,userType );
        model.addAttribute("assignments", listAssignments);
        return "fileManagement/views/manageAssignment/recalledFileAssignment";
    }
   
  @RequestMapping(value = "/updateassignment", method = RequestMethod.GET)
   public @ResponseBody String updateAssignment(
           Model model,@ModelAttribute("returnDateValue")String returnDateValue,
           @ModelAttribute("assignmentid") long assignmentid,
        HttpServletRequest request) {
        String results = "";
         String[] columns = {"datereturned"};
         Date returnDate=null;
         try {
              returnDate=formatter.parse(returnDateValue.replaceAll("/", "-"));
            } catch (Exception e) {
                System.out.println(e.getMessage().toString());
            }
         Object[] columnValues = {returnDate};
         String pk = "assignmentid";
         Object pkValue =assignmentid;
         int upadetLocationStatusid=-1;
        upadetLocationStatusid=genericClassService.updateRecordSQLSchemaStyle(UserFileAssignment.class, columns, columnValues, pk, pkValue, "patient");
         if (upadetLocationStatusid!=-1) {
         return results="Success";
        }else{
         return "Failed";
       }
        
    }
 
    
   @RequestMapping(value = "/recallassignment", method = RequestMethod.POST)
   public @ResponseBody String reCallAssignment(HttpServletRequest request,
           Model model) {
       String res="";
        String action="Recalled";
        try{
       List<Map> assignmentids= (ArrayList) new ObjectMapper().readValue(request.getParameter("assignmentids"), List.class);
        String staffId=request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        res=userFileAssignmentService.recallMultipleFiles(request,assignmentids,action,staffId,genericClassService);
      }catch(Exception e){
       System.out.println(e.getMessage());
    }
    return res;
    }

 // previous things done
 @RequestMapping(value = "/returnfile", method = RequestMethod.GET)
    public @ResponseBody String handOverSingleFile(Model model, HttpServletRequest request,
            @ModelAttribute("assignmentid") String assignmentid,
            @ModelAttribute("fileno") String fileno,
            @ModelAttribute("fileid") String fileid) {
        session = request.getSession();
        session.setAttribute("assignmentid", assignmentid);
        session.setAttribute("fileid", fileid);
        session.setAttribute("fileno",fileno);
        return "success";
    }
   @RequestMapping(value = "/confirmfilereturn", method = RequestMethod.GET)
    public @ResponseBody String confirmFileHandOver(Model model,
            @ModelAttribute("username") String username,
            @ModelAttribute("password") String password,
            HttpServletRequest request) {
        System.out.println(username);
        System.out.println(session.getAttribute("assignmentid").toString());
        System.out.println(password);
         boolean status = false;
        String[] params = {"username"};
        Object[] paramsValues = {username};
        String where = "WHERE username=:username";
        String[] fields = {"active", "password"};
        status = userFileAssignmentService.confirmFileReciept(fields, where, params, paramsValues, status, password,genericClassService);
       String result = "";
       if (status) {
          String[] columns = {"status"};
         Object[] columnValues = {"In"};
         String pk = "assignmentid";
         Object pkValue =Long.parseLong(session.getAttribute("assignmentid").toString());
         int upadetLocationStatusid=-1;
        upadetLocationStatusid=genericClassService.updateRecordSQLSchemaStyle(UserFileAssignment.class, columns, columnValues, pk, pkValue, "patient");
         if (upadetLocationStatusid!=-1) {
         String[] columns2 = {"status"};
         Object[] columnValues2 = {"In"};
         String pk2 = "fileid";
         Object pkValue2 =Long.parseLong(session.getAttribute("fileid").toString());
         int upadetFileStatusid=-1;
        upadetFileStatusid=genericClassService.updateRecordSQLSchemaStyle(PatientFile.class, columns2, columnValues2, pk2, pkValue2, "patient");
         if (upadetFileStatusid!=-1) {
             result = "success";
        }else{
         result="failed";
         }
        }
        }
        else {
           result="failed";
            }
           
             return result;
    }
   
}
