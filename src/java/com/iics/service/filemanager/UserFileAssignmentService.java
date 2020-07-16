/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Designation;
import com.iics.domain.Facilityunit;
import com.iics.domain.Searchstaff;
import com.iics.domain.Systemuser;
import com.iics.filemanger.FileAssignmentActivity;
import com.iics.filemanger.FileRequisition;
import com.iics.filemanger.PatientFile;
import com.iics.filemanger.UserFileAssignment;
import com.iics.filemanger.ViewUserAssignmentDetails;
import com.iics.service.GenericClassService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;



/**
 *
 * @author user
 */
@Service("userFileAssignmentService")
public class UserFileAssignmentService {

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public List<Map> searchStaff(String[] fields, String where, String[] params, Object[] paramsValues, GenericClassService genericClassService) {
        List<Map> staff = new ArrayList<>();
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        if (found != null) {
            Map<String, Object> staffRow;
            for (Object[] f : found) {
                staffRow = new HashMap<>();
                staffRow.put("staffid", String.valueOf(f[0]));
                staffRow.put("staffno", (String) f[1]);
                staffRow.put("firstname", (String) f[2]);
                staffRow.put("lastname", (String) f[3]);
                staff.add(staffRow);
            }
        }
        return staff;
    }

    public void AcceptFileReturn(String fileId, Integer assignmentId, GenericClassService genericClassService) {
        String[] columns = {"status"};
        Object[] columnValues = {"In"};
        String pk = "fileid";
        Object pkValue = Integer.parseInt(fileId);
        int id = -1;
        id = genericClassService.updateRecordSQLSchemaStyle(PatientFile.class, columns, columnValues, pk, pkValue, "patient");
        if (id != -1) {
            String[] columns2 = {"status"};
            Object[] columnValues2 = {"In"};
            String pk2 = "fileid";
            Object pkValue2 = Integer.parseInt(fileId);
            int id2 = -1;
            id2 = genericClassService.updateRecordSQLSchemaStyle(PatientFile.class, columns2, columnValues2, pk2, pkValue2, "patient");
            if (id2 != -1) {
                // fileObjMap.put("status", "succes");
                // fileObjMap.put("message", "Seccessfully Added new Assignment");
            }
        }
    }

    public List<Map> getStaffDetails(String[] fields, String where, String[] params, Object[] paramsValues, GenericClassService genericClassService) {
        List<Map> staffDetails = new ArrayList<>();
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        Map<String, Object> details;

        if (found
                != null) {
            for (Object[] req : found) {
                details = new HashMap<>();
                details.put("firstname", (String) req[0]);
                details.put("othernames", (String) req[1]);
                details.put("lastname", (String) req[2]);
                details.put("staffno", (String) req[3]);
                details.put("personid", req[4]);
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {Long.parseLong(req[7].toString())};
                String[] fields2 = {"facilityunitid", "stafffacilityunitid"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {
                    Object[] facilityunit = found2.get(0);
                    details.put("facilityunitid", facilityunit[0]);
                    details.put("staffid", req[7]);
                    Map faciltyname = getFacilityUnit(Long.parseLong(facilityunit[0].toString()), genericClassService);
                    details.put("facilityunitname", faciltyname.get("facilityunitname"));
                }
                details.put("designationname", getDesignationName(Integer.parseInt(req[5].toString()), genericClassService));
                staffDetails.add(details);
            }
        }
        return staffDetails;
    }

    public boolean confirmFileReciept(String[] fields, String where, String[] params, Object[] paramsValues, boolean status, String password, GenericClassService genericClassService) {
        List<Object[]> users = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields, where, params, paramsValues);
        if (users != null) {
            status = true;
        } else {
            status = false;
        }
        return status;
    }

    public List<Map> assignmentDetails(String where, String[] fields, String[] params, Object[] paramsValues, GenericClassService genericClassService, String userType) {
        List<Map> assignmentlist = new ArrayList<>();
        Map<String, Object> assignmentObject;
        List<Object[]> bayObjList = (List<Object[]>) genericClassService.fetchRecord(ViewUserAssignmentDetails.class, fields, where, params, paramsValues);
        if (bayObjList != null) {
            for (Object[] x : bayObjList) {
                assignmentObject = new HashMap();
                long recievedbystaffid = Long.parseLong(x[1].toString());
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {recievedbystaffid};
                String[] fields2 = {"firstname", "othernames", "lastname", "staffno", "personid", "designationid", "currentfacility", "staffid"};
                String where2 = "WHERE  staffid=:staffid";
                List<Map> staffDetails = getStaffDetails(fields2, where2, params2, paramsValues2, genericClassService);
                Map staffDetail = staffDetails.get(0);
                assignmentObject.put("issuedbystaffid", x[0]);
                assignmentObject.put("recievedbystaffid", x[1]);
                assignmentObject.put("firstname", x[2]);
                assignmentObject.put("othernames", x[3]);
                assignmentObject.put("lastname", x[4]);
                assignmentObject.put("status", x[5]);
                assignmentObject.put("dateassigned", formatter.format(x[6]));

                assignmentObject.put("assignmentid", String.valueOf(x[9]));
                assignmentObject.put("fileno", String.valueOf(x[10]));
                assignmentObject.put("fileid", String.valueOf(x[11]));
                if (x[5].toString().equals("Out") || x[5].toString().equals("Denied")) {
                    assignmentObject.put("datereturned", formatter.format(x[7]));
                    Map date = computeDays(formatter.format(x[7]));
                    assignmentObject.put("daystate", date.get("daystate"));
                    assignmentObject.put("days", date.get("days"));
                    assignmentObject.put("assignstatus", "Out");

                } else if (x[5].toString().equals("Requested")) {
                    assignmentObject.put("datereturned", formatter.format(x[7]));
                    if (userType.equals("manage")) {
                        Map date = computeDays(formatter.format(x[7]));
                        assignmentObject.put("assignstatus", "Requested");
                        assignmentObject.put("days", date.get("days"));
                    } else {
                        String[] params3 = {"status", "assignmentid"};
                        Object[] paramsValues3 = {x[5].toString(), Long.parseLong(String.valueOf(x[9]))};
                        String[] fields3 = {"requestedby", "requesteddate", "requestdate"};
                        String where3 = "WHERE status=:status AND assignmentid=:assignmentid";
                        Map requestDetails = null;
                        requestDetails = getRequestDate(fields3, where3, params3, paramsValues3, genericClassService);
                        if (requestDetails != null) {
                            assignmentObject.put("requestdate", requestDetails.get("requestdate").toString());
                        } else {
                            assignmentObject.put("requestdate", "");
                        }
                        Map date = computeDays(requestDetails.get("requestdate").toString());
                        assignmentObject.put("daystate", date.get("daystate"));
                        assignmentObject.put("days", date.get("days"));
                    }
                } else if (x[5].toString().equals("Recalled")) {
                    if (userType.equals("manage")) {
                        Map date = computeDays(formatter.format(x[7]));
                        assignmentObject.put("days", date.get("days"));
                        assignmentObject.put("assignstatus", "Recalled");
                    } else {
                        assignmentObject.put("datereturned", formatter.format(x[7]));
                        String[] params3 = {"assignmentaction", "assignmentid"};
                        Object[] paramsValues3 = {x[5].toString(), Long.parseLong(String.valueOf(x[9]))};
                        String[] fields3 = {"actionDate", "assignmentaction"};
                        String where3 = "WHERE assignmentaction=:assignmentaction AND assignmentid=:assignmentid";
                        Map activityDetails = null;
                        activityDetails = getActivityDate(fields3, where3, params3, paramsValues3, genericClassService);
                        String actualDate = activityDetails.get("activityDate").toString();
                        // Map date = computeDays(actualDate);
                        Map date = computeDays(formatter.format(x[7]));
                        assignmentObject.put("days", date.get("days"));
                        assignmentObject.put("datereturned", formatter.format(x[7]));
                        assignmentObject.put("activityDate", actualDate);
                    }
                } else {
                }
                assignmentObject.put("staffDetails", staffDetail);
                System.out.println(staffDetail);

                assignmentlist.add(assignmentObject);
            }
        }
        return assignmentlist;
    }

    private Map getActivityDate(String[] fields, String where, String[] params, Object[] paramsValues, GenericClassService genericClassService) {
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(FileAssignmentActivity.class, fields, where, params, paramsValues);
        Map activityDetails = new HashMap();
        if (found != null) {
            for (Object[] x : found) {
                System.out.println(x[0]);
                activityDetails.put("activityDate", String.valueOf(formatter.format(x[0])));
            }
        }
        return activityDetails;
    }

    private Map getRequestDate(String[] fields, String where, String[] params, Object[] paramsValues, GenericClassService genericClassService) {
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(FileRequisition.class, fields, where, params, paramsValues);
        Map requestDetails = new HashMap();
        if (found != null) {
            for (Object[] x : found) {
                System.out.println(x[0]);
                System.out.println(x[1]);
                requestDetails.put("requesteddate", String.valueOf(formatter.format(x[1])));
                requestDetails.put("requestid", String.valueOf(x[0]));
                requestDetails.put("requestdate", String.valueOf(formatter.format(x[2])));
            }
        }
        return requestDetails;
    }

    private Map computeDays(String datereturned) {
        Date currentDate;
        Map datestate = new HashMap();
        try {
            currentDate = formatter.parse(formatter.format(new Date()));
            Date returnDate = formatter.parse(datereturned);
            long difference = currentDate.getTime() - returnDate.getTime();
            float daysBetween = (difference / (1000 * 60 * 60 * 24));
            int days = (int) daysBetween;
            if (days >= 0) {
                datestate.put("days", Math.abs(days));
                datestate.put("daystate", true);
            } else {
                datestate.put("days", Math.abs(days));
                datestate.put("daystate", false);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return datestate;
    }

    public boolean addNewActivity(HttpServletRequest request, String assignmentid, String action, String staffId, GenericClassService genericClassService) {
        FileAssignmentActivity newAssignmentActivity = new FileAssignmentActivity();
        Date dateassigned = null;
        try {
            dateassigned = formatter.parse(formatter.format(new Date()));
        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }
        newAssignmentActivity.setActionDate(dateassigned);
        newAssignmentActivity.setAssignmentaction(action);
        newAssignmentActivity.setAssignmentid(Long.parseLong(assignmentid));
        newAssignmentActivity.setStaffid(Long.parseLong(staffId));
        newAssignmentActivity = (FileAssignmentActivity) genericClassService.saveOrUpdateRecordLoadObject(newAssignmentActivity);
        if (newAssignmentActivity != null) {
            return true;
        } else {
            return false;
        }
    }

    public List<Map> getAllAssignmentIds(GenericClassService genericClassService) {
        List<Map> assignmentIdlist = new ArrayList<>();
        String status = "Out";
        String[] params = {"datereturned","status"};
        Object[] paramsValues = {new Date(),status};
        String[] fields = {"assignmentid","status"};
        String where = "where status=:status AND datereturned<:datereturned";
        Map<String, String> assignmentIdObject;
        List<Object> bayObjList = (List<Object>) genericClassService.fetchRecord(ViewUserAssignmentDetails.class, fields, where, params, paramsValues);
        if (bayObjList != null) {
            for (Object x : bayObjList) {
                assignmentIdObject = new HashMap();
                assignmentIdObject.put("assignmentid", x.toString());
                System.out.println("this is id no:\n" + x.toString());
            }
        }
        return assignmentIdlist;
    }

    public String recallMultipleFiles(HttpServletRequest request, List<Map> assignmentids, String action, String staffId, GenericClassService genericClassService) {
        String results = "";
        String[] columns = {"status"};
        String pk = "assignmentid";
        for (Map assignmentObj : assignmentids) {
            String assignmentid = assignmentObj.get("assignmentid").toString();
            if (addNewActivity(request, assignmentid, action, staffId, genericClassService)) {
                Object[] columnValues = {action};
                Object pkValue = Long.parseLong(assignmentid);
                int upadetLocationStatusid = -1;
                upadetLocationStatusid = genericClassService.updateRecordSQLSchemaStyle(UserFileAssignment.class, columns, columnValues, pk, pkValue, "patient");
                if (upadetLocationStatusid != -1) {
                    results = "success";
                } else {
                    results = "Failed";
                }
            }
        }
        return results;
    }

    /*public String recallMultipleFiles(HttpServletRequest request,List<Map> assignmentids,String action,String staffId,GenericClassService genericClassService){
   String results="";
  
   for (Map assignmentObj : assignmentids) {
    }
   return results;
   }*/
    public Map getFacilityUnit(long facilityunitid, GenericClassService genericClassService) {
        Map<String, Object> facilityunitObject = new HashMap();
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {facilityunitid};
        String[] fields = {"facilityunitid", "facilityunitname"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> facilityunitlist = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
        if (facilityunitlist != null) {
            Object[] x = facilityunitlist.get(0);
            facilityunitObject.put("facilityunitid", x[0]);
            facilityunitObject.put("facilityunitname", x[1]);

        }
        return facilityunitObject;
    }

    public String getDesignationName(int designationid, GenericClassService genericClassService) {
        String[] params3 = {"designationid"};
        Object[] paramsValues3 = {designationid};
        String[] fields3 = {"designationname"};
        String where3 = "WHERE designationid=:designationid";
        String f = "";
        List<String> founddesignation = (List<String>) genericClassService.fetchRecord(Designation.class, fields3, where3, params3, paramsValues3);
        if (founddesignation != null) {
            f = founddesignation.get(0);
        }
        return f;
    }
}
