/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.filemanager;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.iics.filemanger.FileLocation;
import com.iics.filemanger.PatientFile;
import com.iics.service.GenericClassService;
import com.iics.service.filemanager.Filemanagerservicelocator;
import com.iics.service.filemanager.ManageFileService;
import com.iics.service.filemanager.ManageLocationService;
import com.iics.service.filemanager.UserFileAssignmentService;
import java.text.ParseException;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/patients")
public class ManageFile {

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
  HttpSession session;
   // Filemanagerservicelocator f= Filemanagerservicelocator.getInstance();
    private @Autowired ManageLocationService manageLocationService;
    private @Autowired  UserFileAssignmentService userFileAssignmentService;
    private @Autowired ManageFileService manageFileService;
    
    private @Autowired GenericClassService genericClassService;
    Map<String, Object> fileObjMap = null;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String viewFileMenu(Model model) {
        return "fileManagement/views/managefile/patientfiles";
    }

    @RequestMapping(value = "/filemenu", method = RequestMethod.GET)
    public String viewPatientFiles(Model model) {
        return "fileManagement/views/filelMenu";
    }

    @RequestMapping(value = "/searchfile", method = RequestMethod.POST)
    public String searchFileResults(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        String[] params = {"value", "name", "facilityid"};
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        Object[] paramsValues = {searchValue.toLowerCase() + "%", "%" + searchValue.toLowerCase() + "%", Integer.parseInt(facilityidsession)};
        String[] fields = {"patientid", "othernames", "lastname", "firstname",
            "fileno", "fileid", "staffid", "status", "datecreated"};
        String where = "WHERE (LOWER(firstname) LIKE :value OR LOWER(lastname) LIKE :value OR LOWER(othernames) LIKE :name OR LOWER(fileno) LIKE :value) AND facilityid=:facilityid";
        List<Map> files = manageFileService.searchFile(fields, where, params, paramsValues,genericClassService);
        model.addAttribute("files", files);
        model.addAttribute("name", searchValue);
        return "fileManagement/views/managefile/fileSearchResults";
    }

    @RequestMapping(value = "/patientfiledetails", method = RequestMethod.GET)
    public String viewPatientFiles(HttpServletRequest request,
            @ModelAttribute("staffid") String staffid,
            @ModelAttribute("pname") String pname,
            @ModelAttribute("fileid") String fileid,
            @ModelAttribute("fileno") String fileno,
            @ModelAttribute("statusId") String statusId,
            @ModelAttribute("datecreatedId") String datecreatedId, Model model) {
        boolean searchState = false;
        List<Map> locDetails = null;
        List<Map> assignmentDetails = null;
        List<Map> fu = null;
        session = request.getSession();
        session.setAttribute("fileid", fileid);
        Map staffdetails=manageFileService.getStaffDetail(staffid,genericClassService);
        System.out.println(staffdetails);
        model.addAttribute("staffdetails",staffdetails);
        if (statusId.equalsIgnoreCase("In")) {
             String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
            fu = manageLocationService.getFacilityUnit(Long.parseLong(facilityidsession),genericClassService);
            System.out.println(fileno);
            locDetails = manageLocationService.locationDetails(fileno,genericClassService);
            model.addAttribute("locDetails", locDetails);
          } else {
             String status = "In";
            String[] params = {"fileno", "status"};
            Object[] paramsValues = {fileno.toUpperCase(), status};
            String[] fields = {"issuedbystaffid", "recievedbystaffid", "firstname",
                "othernames", "lastname", "status", "dateassigned", "datereturned",
                "currentlocation", "assignmentid", "fileno", "fileid"};
            String where = "WHERE fileno=:fileno AND status!=:status";
            String userType="manage";
            assignmentDetails = userFileAssignmentService.assignmentDetails(where, fields, params, paramsValues,genericClassService,userType);
           if(assignmentDetails!=null){
            Map assignmentDetail=assignmentDetails.get(0);
            model.addAttribute("assignmentDetails",assignmentDetail);
            System.out.println(assignmentDetail);
           }
         }
        searchState = manageLocationService.isSearchState();
        model.addAttribute("edit", searchState);
        model.addAttribute("pname", pname);
        model.addAttribute("fileno", fileno);
        model.addAttribute("fileid", fileid);
        model.addAttribute("status", statusId);
        model.addAttribute("staffid", staffid);
        model.addAttribute("datecreatedId", datecreatedId);
        model.addAttribute("fu", fu);
        return "fileManagement/views/managefile/fileInformation";
    }
@RequestMapping(value = "/newfile", method = RequestMethod.GET)
    public String getNewPatientFileForm(HttpServletRequest request, Model model, @ModelAttribute("fileSearch") String fileSearch) {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        List<Map> fu = manageLocationService.fetchAllFacilityUnits(Integer.parseInt(facilityidsession),genericClassService);
        String fileno = manageFileService.generateFileId(facilityidsession,genericClassService);
        List<Map> zones = manageLocationService.fetchZones(Long.parseLong(facilityidsession),genericClassService);
        model.addAttribute("zones", zones);
        model.addAttribute("fileSearch",fileSearch);
        model.addAttribute("fileno", fileno);
        return "fileManagement/forms/newFileForm";
    }

    @RequestMapping(value = "/searchpatient", method = RequestMethod.POST)
    public String searchPatientResults(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        String[] params = {"value", "name", "facilityid"};
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        Object[] paramsValues = {searchValue.toLowerCase() + "%", "%" + searchValue.toLowerCase() + "%", Integer.parseInt(facilityidsession)};
        String[] fields = {"patientid", "othernames", "lastname", "firstname"};
        String where = "WHERE (LOWER(firstname) LIKE :value OR LOWER(lastname) LIKE :value OR LOWER(othernames) LIKE :name) AND facilityid=:facilityid";
        List<Map> patients = manageFileService.searchPatient(fields, where, params, paramsValues,genericClassService);
        model.addAttribute("patients", patients);
        model.addAttribute("name", searchValue);
        return "fileManagement/views/managefile/patientSearchResults";
    }

    @RequestMapping(value = {"/newfile"}, method = RequestMethod.POST)
    public @ResponseBody String createNewPatientFile(HttpServletRequest request, ModelMap model) throws ParseException {
        String patientId = request.getParameter("patientId");
        String fileNo = request.getParameter("fileNo");
        String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
       
      
        PatientFile file = new PatientFile();
        file.setFileno(fileNo);
        file.setStaffid(Long.parseLong(staffidsession));
        file.setPin(patientId);
        file.setPatientid(Long.parseLong(patientId));
        file.setStatus("In");
        Date date = formatter.parse(formatter.format(new Date()));
        file.setDatecreated(date);
        file = (PatientFile) genericClassService.saveOrUpdateRecordLoadObject(file);
       if(file!=null){
            int cellid = Integer.parseInt(request.getParameter("cellid"));
            int zoneid = Integer.parseInt(request.getParameter("zoneid"));
            FileLocation loc = new FileLocation();
            loc.setZoneid(zoneid);
            loc.setFileno(fileNo);
            loc.setCellid(cellid);
            loc.setDatecreated(new Date());
            loc = (FileLocation) genericClassService.saveOrUpdateRecordLoadObject(loc);
           
            if(loc!=null){
             String action = "Created";
           
            String fileid = String.valueOf(file.getFileid());
            String staffId = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
            userFileAssignmentService.addNewActivity(request, fileid, action, staffId,genericClassService);
          return "success";
            }else{
            return "false";
            }
       }else{
        return "false";
       }
        
    }

    @RequestMapping(value = "/upadatelocation", method = RequestMethod.GET)
    public String updateAssignment(Model model, @ModelAttribute("fileno") String fileno,
            HttpServletRequest request) {
        fileObjMap = new HashMap();
        List<Map> listAssignments = new ArrayList<>();
        String[] params = {"fileno"};
        Object[] paramsValues = {fileno.toUpperCase()};
        String[] fields = {"issuedbystaffid", "recievedbystaffid", "firstname",
            "othernames", "lastname", "status", "dateassigned", "datereturned",
            "currentlocation", "assignmentid", "fileno", "fileid"};
        String where = "WHERE fileno=:fileno";
        String userType="manage";
        listAssignments = userFileAssignmentService.assignmentDetails(where, fields, params, paramsValues,genericClassService,userType);
        model.addAttribute("assignments", listAssignments);
        String[] columns = {"status"};
        Object[] columnValues = {"In"};
        String pk = "assignmentid";
        Object pkValue = Integer.parseInt(session.getAttribute("fileid").toString());
        int id = -1;
        id = genericClassService.updateRecordSQLSchemaStyle(PatientFile.class, columns, columnValues, pk, pkValue, "patient");
        if (id != -1) {
            fileObjMap.put("status", "succes");
            fileObjMap.put("message", "Seccessfully Added new Assignment");
        }
        return "fileManagement/views/manageAssignment/viewUserAssignment";
    }
}
