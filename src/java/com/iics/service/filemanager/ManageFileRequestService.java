/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

import com.iics.domain.Contactdetails;
import com.iics.domain.Personview;
import com.iics.domain.Searchstaff;
import com.iics.filemanger.FileAssignmentActivity;
import com.iics.filemanger.FileRequisition;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author IICS
 */
@Service("manageFileRequestService ")
public class ManageFileRequestService {

    @Autowired
    ManageLocationService manageLocationService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public List<Map> assignmentDetails(String where, String[] fields, String[] params, Object[] paramsValues, String userType, GenericClassService genericClassService) {
        List<Map> assignmentlist = new ArrayList<>();
        Map<String, Object> assignmentObject;
        List<Object[]> bayObjList = (List<Object[]>) genericClassService.fetchRecord(ViewUserAssignmentDetails.class, fields, where, params, paramsValues);
        if (bayObjList != null) {
            for (Object[] x : bayObjList) {
                assignmentObject = new HashMap();
                long recievedbystaffid = Long.parseLong(x[1].toString());
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {recievedbystaffid};
                String[] fields2 = {"personid", "firstname", "othernames", "lastname", "staffno", "facilityunitname", "designationname", "username", "active", "facilityunitid"};
                String where2 = "WHERE staffid=:staffid";
                List<Map> staffDetails = getStaffDetails(fields2, where2, params2, paramsValues2, genericClassService);
                assignmentObject.put("issuedbystaffid", x[0]);
                assignmentObject.put("recievedbystaffid", x[1]);
                assignmentObject.put("firstname", x[2]);
                assignmentObject.put("othernames", x[3]);
                assignmentObject.put("lastname", x[4]);
                assignmentObject.put("status", x[5]);
                assignmentObject.put("dateassigned", formatter.format(x[6]));
                assignmentObject.put("datereturned", formatter.format(x[7]));
                List<Map> facilties = manageLocationService.getFacilityUnit(Long.parseLong(x[8].toString()), genericClassService);
                Map faciltyname = facilties.get(0);
                assignmentObject.put("faciltyname", faciltyname.get("facilityunitname"));
                if (x[5].toString().equals("Out")) {
                    System.out.println("Out:" + x[5].toString());
                    Map date = computeDays(formatter.format(x[7]));
                    assignmentObject.put("daystate", date.get("daystate"));
                    assignmentObject.put("days", date.get("days"));
                } else if (x[5].toString().equals("Recalled")) {
                    String[] params3 = {"assignmentaction", "assignmentid"};
                    Object[] paramsValues3 = {x[5].toString(), Long.parseLong(String.valueOf(x[9]))};
                    String[] fields3 = {"actionDate", "assignmentaction"};
                    String where3 = "WHERE assignmentaction=:assignmentaction AND assignmentid=:assignmentid";
                    Map activityDetails = null;
                    activityDetails = getActivityDate(fields3, where3, params3, paramsValues3, genericClassService);
                    String actualDate = activityDetails.get("activityDate").toString();
                    Map date = computeDays(actualDate);
                    Map date2 = computeDays(formatter.format(x[7]));
                    assignmentObject.put("daystate2", date2.get("daystate"));
                    assignmentObject.put("days2", date2.get("days"));
                    assignmentObject.put("daystate", date.get("daystate"));
                    assignmentObject.put("days", date.get("days"));
                    assignmentObject.put("activityDate", actualDate);
                } else if (x[5].toString().equals("Requested")) {

                    String[] params3 = {"status", "assignmentid"};
                    Object[] paramsValues3 = {x[5].toString(), Long.parseLong(String.valueOf(x[9]))};
                    String[] fields3 = {"requestid","requestedby", "requesteddate", "requestdate"};
                    String where3 = "WHERE status=:status AND assignmentid=:assignmentid";
                    Map requestDetails = null;
                    requestDetails = getRequestDate(fields3, where3, params3, paramsValues3, genericClassService);
                    if (userType=="issuer") {
                        String actualDate = requestDetails.get("requesteddate").toString();
                        Map date = null;
                        if (!actualDate.isEmpty() || actualDate != null) {
                            assignmentObject.put("requestid", requestDetails.get("requestid").toString());
                            date = computeDays(actualDate);
                            assignmentObject.put("daystate", date.get("daystate"));
                            assignmentObject.put("days", date.get("days"));
                        }
                    } else{
                        String actualDate = requestDetails.get("requestdate").toString();
                        Map date = null;
                        if (!actualDate.isEmpty() || actualDate != null) {
                            assignmentObject.put("requestid", requestDetails.get("requestid").toString());
                            date = computeDays(actualDate);
                            assignmentObject.put("daystate", date.get("daystate"));
                            assignmentObject.put("days", date.get("days"));
                        }
                    }
                    assignmentObject.put("requestdate", requestDetails.get("requestdate").toString());
                    assignmentObject.put("requesteddate", requestDetails.get("requesteddate").toString());

                } else {
                }
                assignmentObject.put("staffDetails", staffDetails);
                assignmentObject.put("assignmentid", String.valueOf(x[9]));
                assignmentObject.put("fileno", String.valueOf(x[10]));
                assignmentObject.put("fileid", String.valueOf(x[11]));
                assignmentlist.add(assignmentObject);
            }
        }
        return assignmentlist;
    }

    public boolean addNewRequest(HttpServletRequest request, String fileid, String action, String staffId, String requestedDate, GenericClassService genericClassService) {
        FileRequisition fileRequisition = new FileRequisition();
        Date requested = null;
        Date current = null;
        try {
            current = formatter.parse(formatter.format(new Date()));
            requested = formatter.parse(requestedDate.replaceAll("/", "-"));
        } catch (Exception e) {
            System.out.println(e.getMessage().toString());
        }
        fileRequisition.setRequesteddate(requested);
        fileRequisition.setRequeststatus(action);
        fileRequisition.setApproveddate(current);
        fileRequisition.setRequestedby(Long.parseLong(staffId));
        fileRequisition.setAssignmentid(Long.parseLong(fileid));
        fileRequisition.setRequestdate(current);
        fileRequisition.setApprovedbystaffid(0);
        fileRequisition = (FileRequisition) genericClassService.saveOrUpdateRecordLoadObject(fileRequisition);
        if (fileRequisition != null) {
            return true;
        } else {
            return false;
        }
    }

    private boolean approveOrDenyRequest(String requestid, String action, String staffId, GenericClassService genericClassService) {
        boolean results = false;
        String[] columns2 = {"status", "approvedby", "approveddate"};
        String pk2 = "requestid";
        Date currentDate = null;
        try {
            currentDate = formatter.parse(formatter.format(new Date()));
        } catch (Exception e) {
        }
        Object[] columnValues2 = {action, Long.parseLong(staffId), currentDate};
        Object pkValue2 = Long.parseLong(requestid);
        int upadetRequestStatusid = -1;
        upadetRequestStatusid = genericClassService.updateRecordSQLSchemaStyle(FileRequisition.class, columns2, columnValues2, pk2, pkValue2, "patient");
        if (upadetRequestStatusid != -1) {
            results = true;
        } else {
            results = false;
        }
        return results;
    }

    public String requestFiles(HttpServletRequest request, List<Map> assignmentids, String action, String staffId, GenericClassService genericClassService) {
        String results = "";
        String pk = "assignmentid";
        for (Map assignmentObj : assignmentids) {
            String assignmentid = assignmentObj.get("assignmentid").toString();
            boolean processRequest = false;
            if (action == "Requested") {
                String requestedDate = assignmentObj.get("requestedDate").toString();
                processRequest = addNewRequest(request, assignmentid, action, staffId, requestedDate, genericClassService);
                if (processRequest) {
                    String[] columns = {"status"};
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
            } else if (action == "Approved") {
                  String requestid = assignmentObj.get("requestid").toString();
                    action = "Out";
                   processRequest = approveOrDenyRequest(requestid, action, staffId, genericClassService);
                    if (processRequest) {
                        String[] columns = {"status"};
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
              else if(action == "Denied") {
                    action = "Denied";
                    String requestid = assignmentObj.get("requestid").toString();
                    processRequest = approveOrDenyRequest(requestid, action, staffId, genericClassService);
                    if (processRequest) {
                        String[] columns = {"status"};
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
            
        }
        return results;
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

    public List<Map> getStaffDetails(String[] fields, String where, String[] params, Object[] paramsValues, GenericClassService genericClassService) {
        List<Map> staffDetails = new ArrayList<>();
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Personview.class, fields, where, params, paramsValues);
        Map<String, Object> details;

        if (found != null) {
            for (Object[] req : found) {
                details = new HashMap<>();
                details.put("personid", req[0]);
                details.put("firstname", (String) req[1]);
                details.put("othernames", (String) req[2]);
                details.put("lastname", (String) req[3]);
                details.put("staffno", (String) req[4]);
                details.put("facilityunitname", (String) req[5]);
                details.put("designationname", (String) req[6]);
                details.put("username", (String) req[7]);
                details.put("active", (String) req[8].toString());
                details.put("facilityunitid", (String) req[9].toString());
                staffDetails.add(details);

            }
        }
        return staffDetails;
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
                String[] fields3 = {"requestedby", "requesteddate", "requestdate"};
                requestDetails.put("requesteddate", String.valueOf(formatter.format(x[2])));
                requestDetails.put("requestid", String.valueOf(x[0]));
                requestDetails.put("requestdate", String.valueOf(formatter.format(x[3])));
                requestDetails.put("requestedby", String.valueOf(x[1]));

            }
        }
        return requestDetails;
    }

    public List<Map> getAllAssignmentHistroy(String[] fields, String where, String[] params, Object[] paramsValues, String facilityidsession, GenericClassService genericClassService, UserFileAssignmentService userFileAssignmentService) {
        List<Map> allhistory = new ArrayList<>();
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(FileAssignmentActivity.class, fields, where, params, paramsValues);
        Map activityDetails;
        if (found != null) {
            for (Object[] x : found) {
                activityDetails = new HashMap();
                activityDetails.put("activityid", x[0]);
                activityDetails.put("staffid", String.valueOf(x[1]));
                activityDetails.put("actionDate", String.valueOf(formatter.format(x[2])));
                activityDetails.put("assignmentaction", String.valueOf(x[3]));
                activityDetails.put("ContactDetails", getStaffContactDetails(Long.parseLong(String.valueOf(x[1])), facilityidsession, genericClassService, userFileAssignmentService));
                allhistory.add(activityDetails);
            }
        }
        return allhistory;
    }

    public Map getStaffContactDetails(long staffid, String facilityidsession, GenericClassService genericClassService, UserFileAssignmentService userFileAssignmentService) {
        String[] params2 = {"staffid", "currFacility"};
        Object[] paramsValues2 = {staffid, Long.parseLong(facilityidsession)};
        Map contactDetails = new HashMap();
        String[] fields2 = {"firstname", "othernames", "lastname", "personid"};
        String where2 = "WHERE currentfacility=:currFacility AND staffid=:staffid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
        if (found != null) {
            System.out.println(found.get(0)[1].toString());
            System.out.println(found.get(0)[1].toString());
            contactDetails.put("firstname", found.get(0)[0].toString());
            contactDetails.put("othernames", found.get(0)[1].toString());
            contactDetails.put("lastname", found.get(0)[2].toString());
            contactDetails.put("personid", found.get(0)[3].toString());

        }
        // contact details
        String[] params4 = {"personid"};
        Object[] paramsValues4 = {Long.parseLong(found.get(0)[3].toString())};
        String[] fields4 = {"contactvalue", "contacttype"};
        String where4 = "WHERE personid=:personid";
        List<Object[]> objContactDetails = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, fields4, where4, params4, paramsValues4);
        if (objContactDetails != null) {
            for (Object[] x : objContactDetails) {
                contactDetails.put("contactvalue", String.valueOf(x[0]));
                contactDetails.put("contacttype", String.valueOf(x[1]));
                System.out.println(String.valueOf(x[1]));
                System.out.println(String.valueOf(x[0]));
            }
        }

        return contactDetails;
    }
}
