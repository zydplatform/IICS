/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facility;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Locations;
import com.iics.domain.Person;
import com.iics.domain.Searchstaff;
import com.iics.patient.Internalreferral;
import com.iics.patient.Patientmedicalissue;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Searchpatient;
import com.iics.patient.Triage;
import com.iics.patient.Triagevalidationskip;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
 * @author HP
 */
@Controller
@RequestMapping("/triage")
public class TriageController {

    @Autowired
    GenericClassService genericClassService;
    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/clinictriagehome.htm", method = RequestMethod.GET)
    public String clinicTriageHome(Model model, HttpServletRequest request) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            String keyid = "0";
            Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            //
            int facilityId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            //

            String[] paramstriageid = {"servicekey"};
            Object[] paramsValuestriageid = {"key_htdm"};
            String[] fieldstriageid = {"serviceid"};
            List<Integer> htdmService = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
            if (htdmService != null) {
                String[] params = {"serviceid", "facilityunit"};
                Object[] paramValues = {htdmService.get(0), facilityunitId};
                String[] fields = {"facilityunitserviceid"};
                String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramValues);
                if (serviceid != null) {
                    keyid = serviceid.get(0).toString();
                }
            }
            model.addAttribute("keyid", keyid);
            model.addAttribute("facilityid", facilityId);
            return "patientsManagement/triage/triagehomepage";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/savePatientTriage", method = RequestMethod.POST)
    public @ResponseBody
    String savePatientTriage(Model model, HttpServletRequest request) {
        Triage triage = new Triage();
        String patientWeight = request.getParameter("patientWeight");
        String patientTemperature = request.getParameter("patientTemperature");
        String patientHeight = request.getParameter("patientHeight");
        String patientPressureSystolic = request.getParameter("patientPressureSystolic");
        String patientPressureDiastolic = request.getParameter("patientPressureDiastolic");
        String patientPulse = request.getParameter("patientPressureDiastolic");
        String patientHeadCircum = request.getParameter("patientHeadCircum");

        String patientBodySurfaceArea = request.getParameter("patientBodySurfaceArea");
        String patientRespirationRate = request.getParameter("patientRespirationRate");
        String patientTriageNotes = request.getParameter("patientTriageNotes");
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        if (!"".equals(patientTemperature)) {
            triage.setTemperature(Double.parseDouble(patientTemperature));
        }
        if (!"".equals(patientPressureSystolic)) {
            triage.setPatientpressuresystolic(Long.parseLong(patientPressureSystolic));
        }
        if (!"".equals(patientPressureDiastolic)) {
            triage.setPatientpressurediastolic(Long.parseLong(patientPressureDiastolic));
        }
        if (!"".equals(patientPulse)) {
            triage.setPulse(Integer.parseInt(patientPulse));
        }
        if (!"".equals(patientHeadCircum)) {
            triage.setHeadcircum(Double.parseDouble(patientHeadCircum));
        }
        if (!"".equals(patientBodySurfaceArea)) {
            triage.setBodysurfacearea(Double.parseDouble(patientBodySurfaceArea));
        }
        if (!"".equals(patientRespirationRate)) {
            triage.setRespirationrate(Integer.parseInt(patientRespirationRate));
        }
        if (!"".equals(patientTriageNotes)) {
            triage.setNotes(patientTriageNotes);
        }
        if (!"".equals(patientHeight)) {
            triage.setHeight(Double.parseDouble(patientHeight));
        }
        if (!"".equals(patientWeight)) {
            triage.setWeight(Double.parseDouble(patientWeight));
        }
        triage.setAddedby(currStaffId);
        triage.setDateadded(new Date());
        triage.setPatientvisitid(Long.parseLong(request.getParameter("patientVisitationId")));
        genericClassService.saveOrUpdateRecordLoadObject(triage);
        return "";
    }

    @RequestMapping(value = "/triagepatientinqueuedetails.htm", method = RequestMethod.GET)
    public String triagepatientinqueuedetails(Model model, HttpServletRequest request) {

        String[] paramsbasicinfo = {"patientid"};
        Object[] paramsValuesbasicinfo = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fieldsbasicinfo = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin", "currentaddress"};
        List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fieldsbasicinfo, "WHERE patientid=:patientid", paramsbasicinfo, paramsValuesbasicinfo);
        if (patientsvisitsbasicinfo != null) {
            String[] params5basicinfo = {"personid"};
            Object[] paramsValues5basicinfo = {patientsvisitsbasicinfo.get(0)[0]};
            String[] fields5basicinfo = {"dob", "estimatedage", "gender"};
            List<Object[]> objpatientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5basicinfo, "WHERE personid=:personid", params5basicinfo, paramsValues5basicinfo);

            if (patientsvisitsbasicinfo.get(0)[3] != null || patientsvisitsbasicinfo.get(0)[3] != "") {
                model.addAttribute("name", patientsvisitsbasicinfo.get(0)[1] + " " + patientsvisitsbasicinfo.get(0)[2] + " " + patientsvisitsbasicinfo.get(0)[3]);
            } else {
                model.addAttribute("name", patientsvisitsbasicinfo.get(0)[1] + " " + patientsvisitsbasicinfo.get(0)[2]);
            }
            model.addAttribute("patientno", patientsvisitsbasicinfo.get(0)[4]);
            model.addAttribute("telephone", patientsvisitsbasicinfo.get(0)[5]);
            model.addAttribute("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
            model.addAttribute("dob", formatter.format((Date) objpatientdetails.get(0)[0]));

            model.addAttribute("gender", objpatientdetails.get(0)[2]);

            String year = formatter.format((Date) objpatientdetails.get(0)[0]);
            String currentyear = formatter.format(new Date());
            SimpleDateFormat myFormat = new SimpleDateFormat("dd MM yyyy");
            try {
                Date dateBefore = formatter.parse(year);
                Date dateAfter = formatter.parse(currentyear);
                long difference = dateAfter.getTime() - dateBefore.getTime();
                float daysBetween = (difference / (1000 * 60 * 60 * 24));
                model.addAttribute("estimatedage", computeAge2(Math.round(daysBetween)));
            } catch (Exception e) {
                System.out.println(e);
            }

            String[] paramsresidence = {"villageid"};
            Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
            String[] fieldsresidence = {"villagename"};
            List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
            if (patientsvisitsresidence != null) {
                model.addAttribute("village", patientsvisitsresidence.get(0));
            }
            Map<String, Object> refDetails = null;
            try {
                List<Object[]> referralDetails = (List<Object[]>) genericClassService.fetchRecord(Internalreferral.class, new String [] { "internalreferralid", "referralunitid", "patientvisitid", "referringunitid", "addedby", "dateadded", "iscomplete", "referralnotes", "referredto", "specialty", "unitserviceid" }, "WHERE patientvisitid=:patientvisitid ORDER BY internalreferralid DESC", new  String [] { "patientvisitid" }, new Object [] { BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))) });
                if(referralDetails != null){
                    Object[] detail = referralDetails.get(0);
                    refDetails = new HashMap<>();
                        refDetails.put("internalreferralid", detail[0]);
                        refDetails.put("referralunitid", detail[1]);
                        refDetails.put("patientvisitid", (detail[2] == null) ? request.getParameter("patientvisitid") : detail[2]);
                        String referringUnit = ((List<String>)genericClassService.fetchRecord(Facilityunit.class, new String[]{ "facilityunitname" }, "WHERE facilityunitid=:referringunitid", new String [] { "referringunitid" }, new Object[]{ detail[3] })).get(0);
                        refDetails.put("referringUnit", referringUnit);
                        List<Object[]> addedby = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, new String[] {"staffid", "firstname", "lastname", "othernames"}, "WHERE staffid=:staffid", new String[] {"staffid"}, new Object [] { detail[4] }));
                        if(addedby != null){
                            if (addedby.get(0)[3] != null) {
                                    refDetails.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2] + " " + (String) addedby.get(0)[3]);
                            } else {
                                    refDetails.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2]);
                            }
                        }
                        refDetails.put("dateadded", detail[5]);
                        refDetails.put("iscomplete", detail[6]);
                        refDetails.put("referralnotes", detail[7]);
                }
                model.addAttribute("referralDetails", refDetails);
            }catch(Exception ex) {
                ex.printStackTrace();
            }
            //

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }
        return "patientsManagement/triage/views/patientBasicInfoTriage";
    }

    @RequestMapping(value = "/patientPreviousVitals.htm", method = RequestMethod.GET)
    public String patientPreviousVitals(Model model, HttpServletRequest request) {

        List<Map> previousTriageList = new ArrayList<>();

        String[] paramsPatientVisits = {"patientid"};
        Object[] paramsValuesPatientVisits = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fieldsPatientVisits = {"patientvisitid", "dateadded", "facilityid"};
        String wherePatientVisits = "WHERE patientid=:patientid";
        List<Object[]> objPatientVisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsPatientVisits, wherePatientVisits, paramsPatientVisits, paramsValuesPatientVisits);
        if (objPatientVisits != null) {
            Map<String, Object> unitMap;
            for (Object[] visits : objPatientVisits) {
                unitMap = new HashMap<>();
                unitMap.put("dateadded", formatter.format((Date) visits[1]));

                String[] paramsPatientTriageInfo = {"patientvisitid"};
                Object[] paramsValuesPatientTriageInfo = {visits[0]};
                String[] fieldsPatientTriageInfo = {"triageid", "weight", "temperature", "height", "pulse", "headcircum", "bodysurfacearea", "respirationrate", "notes", "patientpressuresystolic", "patientpressurediastolic"};
                String wherePatientTriageInfo = "WHERE patientvisitid=:patientvisitid";
                List<Object[]> objPatientTriageInfo = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fieldsPatientTriageInfo, wherePatientTriageInfo, paramsPatientTriageInfo, paramsValuesPatientTriageInfo);
                if (objPatientTriageInfo != null) {
                    for (Object[] triage : objPatientTriageInfo) {
                        unitMap.put("weight", triage[1]);
                        unitMap.put("temperature", triage[2]);
                        unitMap.put("height", triage[3]);
                        unitMap.put("pulse", triage[4]);
                        unitMap.put("headcircum", triage[5]);
                        unitMap.put("bodysurfacearea", triage[6]);
                        unitMap.put("respirationrate", triage[7]);
                        unitMap.put("notes", triage[8]);
                        unitMap.put("patientpressuresystolic", triage[9]);
                        unitMap.put("patientpressurediastolic", triage[10]);
                    }
                }

                String[] paramsPatientVisitFacility = {"facilityid"};
                Object[] paramsValuesPatientVisitFacility = {visits[2]};
                String[] fieldsPatientVisitFacility = {"facilityname"};
                String wherePatientVisitFacility = "WHERE facilityid=:facilityid";
                List<String> objPatientVisitFacility = (List<String>) genericClassService.fetchRecord(Facility.class, fieldsPatientVisitFacility, wherePatientVisitFacility, paramsPatientVisitFacility, paramsValuesPatientVisitFacility);
                if (objPatientVisitFacility != null) {
                    unitMap.put("facilityname", objPatientVisitFacility.get(0));
                }
                previousTriageList.add(unitMap);
            }
        }
        model.addAttribute("previousTriageList", previousTriageList);
        return "patientsManagement/triage/views/patientPrevoiusTriagedetails";
    }

    @RequestMapping(value = "/getPatientMedicalIssues.htm", method = RequestMethod.GET)
    public String getPatientMedicalIssues(Model model, HttpServletRequest request,
            @ModelAttribute("patientid") String pid) {
        List<Map> medicalIssues = new ArrayList<>();
        BigInteger patientid = BigInteger.valueOf(Long.valueOf(pid));

        //Get Patient Issues
        String[] params = {"patientid"};
        Object[] paramsValues = {patientid};
        String[] fields = {"medicalissue.medicalissueid", "medicalissuestate"};
        String where = "WHERE patientid=:patientid";
        List<Object[]> issues = (List<Object[]>) genericClassService.fetchRecord(Patientmedicalissue.class, fields, where, params, paramsValues);
        if (issues != null) {
            Map<String, Object> issue;
            for (Object[] sue : issues) {
                issue = new HashMap<>();
                issue.put("id", sue[0]);
                issue.put("key", sue[1]);
                medicalIssues.add(issue);
            }
        }

        String issueKeys = "[]";
        try {
            issueKeys = new ObjectMapper().writeValueAsString(medicalIssues);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("issueKeys", issueKeys);
        return "patientsManagement/triage/forms/allergies";
    }
    //
    @RequestMapping(value="/savetriagevalidationskip", method=RequestMethod.POST)
    public @ResponseBody String saveTriagevalidationskip(HttpServletRequest request, @ModelAttribute("field") String field,
            @ModelAttribute("reason") String reason, @ModelAttribute("patientvisitid") String patientVisitId){
        String result = "";
        try{
            Triagevalidationskip triageValidationSkip = new Triagevalidationskip();
            long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
            long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            triageValidationSkip.setSkippedfield(field);
            triageValidationSkip.setReason(reason);
            triageValidationSkip.setPatientvisitid(Long.parseLong(patientVisitId));
            triageValidationSkip.setAddedby(staffId);
            triageValidationSkip.setDateadded(new Date());
            triageValidationSkip.setFacilityunitid(facilityUnitId);
            Object saved = genericClassService.saveOrUpdateRecordLoadObject(triageValidationSkip);
            if(saved != null){
                result = "success";
            }else{
                result = "failure";
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return result;
    }
    //

    public static long compareTwoTimeStamps(java.sql.Timestamp timeOut, java.sql.Timestamp timeIn) {
        long milliseconds1 = timeIn.getTime();
        long milliseconds2 = timeOut.getTime();

        long diff = milliseconds2 - milliseconds1;
        long diffMinutes = diff / (60 * 1000);

        return diffMinutes;
    }

    public String computeAge2(int days) {
        if (days >= 364) {
            Integer years = days / 365;
            if (years == 1) {
                return "1 Year.";
            } else {
                return years + " Years";
            }
        } else {
            if (days >= 30) {
                Integer months = days / 30;
                if (months == 1) {
                    return "1 Month.";
                } else {
                    return months + " Months";
                }
            } else {
                if (days == 1) {
                    return "1 Day";
                }
                if (days < 1) {
                    return "-";
                }
                return days + " Days";
            }
        }
    }
}
