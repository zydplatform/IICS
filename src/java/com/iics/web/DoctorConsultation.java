/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Contactdetails;
import com.iics.domain.Facility;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Facilityunitservicesview;
import com.iics.domain.Locations;
import com.iics.domain.Person;
import com.iics.domain.Searchstaff;
import com.iics.patient.Disease;
import com.iics.patient.Diseasecategory;
import com.iics.patient.Diseasesymptom;
import com.iics.patient.Internalreferral;
import com.iics.patient.Issuedprescriptionitemsview;
import com.iics.patient.Laboratoryrequest;
import com.iics.patient.Laboratoryrequesttest;
import com.iics.patient.Laboratorytest;
import com.iics.patient.Labtestclassification;
import com.iics.patient.Newprescriptionitems;
import com.iics.patient.Patientcomplaint;
import com.iics.patient.Patientinterimdiagnosis;
import com.iics.patient.Patientobservation;
import com.iics.patient.Patientpause;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Patientvisit;
import com.iics.patient.Patientvisits;
import com.iics.patient.Prescription;
import com.iics.patient.Prescriptionitems;
import com.iics.patient.Searchpatient;
import com.iics.patient.Servicequeue;
import com.iics.patient.Specialinstructions;
import com.iics.patient.Symptom;
import com.iics.patient.Triage;
import com.iics.patient.Triagevalidationskip;
import com.iics.service.GenericClassService;
import com.iics.store.Itemcategories;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import static com.iics.web.Stock.loadFileAsBytesArray;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;
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
@RequestMapping("/doctorconsultation")
public class DoctorConsultation {

    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    DateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatterwithtime = new SimpleDateFormat("E, dd MMM yyyy hh:mm aa");
    @Autowired
    GenericClassService genericClassService;

    SimpleDateFormat formatterwithtime2 = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();

    @RequestMapping(value = "/doctorconsultationhome.htm", method = RequestMethod.GET)
    public String doctorconsultationhome(Model model, HttpServletRequest request) {
        Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        model.addAttribute("unit", facilityunitId);

        int facilityId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

        String[] params = {"addedby", "dateadded", "paused", "facilityunit"};
        Object[] paramsValues = {BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")), new Date(), true, (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"patientvisitid", "patientpauseid"};
        List<Object[]> pausedpatients = (List<Object[]>) genericClassService.fetchRecord(Patientpause.class, fields, "WHERE addedby=:addedby AND dateadded=:dateadded AND paused=:paused AND facilityunit=:facilityunit", params, paramsValues);
        if (pausedpatients != null) {
            model.addAttribute("size", pausedpatients.size());
            model.addAttribute("patientvisitid", pausedpatients.get(0)[0]);
            model.addAttribute("patientpauseid", pausedpatients.get(0)[1]);

            String[] params5 = {"patientvisitid"};
            Object[] paramsValues5 = {pausedpatients.get(0)[0]};
            String[] fields5 = {"fullnames"};
            List<String> patientdetails = (List<String>) genericClassService.fetchRecord(Patientvisits.class, fields5, "WHERE patientvisitid=:patientvisitid", params5, paramsValues5);
            if (patientdetails != null) {
                model.addAttribute("patientdetails", patientdetails.get(0));
            }
        } else {
            model.addAttribute("size", 0);
            model.addAttribute("patientvisitid", 0);
            model.addAttribute("patientpauseid", 0);
        }
        model.addAttribute("facilityid", facilityId);
        model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
        return "doctorConsultations/doctorConsultationsHome";
    }

    @RequestMapping(value = "/patientinqueuedetails.htm", method = RequestMethod.GET)
    public String patientinqueuedetails(Model model, HttpServletRequest request) {

        String[] params = {"patientid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fields = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin"};
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
        if (patientsvisits != null) {
            String[] params5 = {"personid"};
            Object[] paramsValues5 = {patientsvisits.get(0)[0]};
            String[] fields5 = {"dob", "estimatedage", "gender"};
            List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5, "WHERE personid=:personid", params5, paramsValues5);

            model.addAttribute("name", patientsvisits.get(0)[1] + " " + patientsvisits.get(0)[3] + " " + patientsvisits.get(0)[2]);
            model.addAttribute("patientno", patientsvisits.get(0)[4]);
            model.addAttribute("telephone", patientsvisits.get(0)[5]);
            model.addAttribute("nextofkin", patientsvisits.get(0)[6]);
            model.addAttribute("dob", formatter.format((Date) patientdetails.get(0)[0]));
            model.addAttribute("gender", patientdetails.get(0)[2]);

            SimpleDateFormat df = new SimpleDateFormat("yyyy");
//            int year = Integer.parseInt(df.format((Date) patientdetails.get(0)[0]));
//            int currentyear = Integer.parseInt(df.format(new Date()));
            //
            String year = formatter.format((Date) patientdetails.get(0)[0]);
            String currentyear = formatter.format(new Date());
            try {
                Date dateBefore = formatter.parse(year);
                Date dateAfter = formatter.parse(currentyear);
                long difference = dateAfter.getTime() - dateBefore.getTime();
                float daysBetween = (difference / (1000 * 60 * 60 * 24));
                model.addAttribute("estimatedage", computeAge2(Math.round(daysBetween)));
            } catch (Exception e) {
                System.out.println(e);
            }
            //
//            model.addAttribute("estimatedage", currentyear - year);            

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }

        String[] params1 = {"patientvisitid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields1 = {"weight", "temperature", "height", "pulse", "headcircum", "bodysurfacearea", "respirationrate", "patientpressuresystolic", "patientpressurediastolic"};
        String where1 = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patienttriages = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields1, where1, params1, paramsValues1);
        if (patienttriages != null) {
            if (patienttriages.get(0)[0] != null) {
                model.addAttribute("weight", patienttriages.get(0)[0]);
            } else {
                model.addAttribute("weight", 0);
            }
            if (patienttriages.get(0)[1] != null) {
                model.addAttribute("temperature", patienttriages.get(0)[1]);
            } else {
                model.addAttribute("temperature", 0);
            }
            if (patienttriages.get(0)[2] != null) {
                model.addAttribute("height", patienttriages.get(0)[2]);
            } else {
                model.addAttribute("height", 0);
            }
            if (patienttriages.get(0)[3] != null) {
                model.addAttribute("pulse", patienttriages.get(0)[3]);
            } else {
                model.addAttribute("pulse", 0);
            }
            if (patienttriages.get(0)[4] != null) {
                model.addAttribute("headcircum", patienttriages.get(0)[4]);
            } else {
                model.addAttribute("headcircum", 0);
            }
            if (patienttriages.get(0)[5] != null) {
                model.addAttribute("bodysurfacearea", patienttriages.get(0)[5]);
            } else {
                model.addAttribute("bodysurfacearea", 0);
            }
            if (patienttriages.get(0)[6] != null) {
                model.addAttribute("respirationrate", patienttriages.get(0)[6]);
            } else {
                model.addAttribute("respirationrate", 0);
            }
            if (patienttriages.get(0)[7] != null) {
                model.addAttribute("systolic", patienttriages.get(0)[7]);
            } else {
                model.addAttribute("systolic", 0);
            }
            if (patienttriages.get(0)[8] != null) {
                model.addAttribute("diastolic", patienttriages.get(0)[8]);
            } else {
                model.addAttribute("diastolic", 0);
            }
            if (patienttriages.get(0)[2] != null && patienttriages.get(0)[0] != null) {
                model.addAttribute("bmi", String.format("%.02f", (Double) patienttriages.get(0)[0] / ((((Double) patienttriages.get(0)[2]) * 0.01) * (((Double) patienttriages.get(0)[2]) * 0.01))) + " " + "");
            } else {
                model.addAttribute("bmi", "pending");
            }
        } else {
            model.addAttribute("bmi", "pending");
            model.addAttribute("systolic", 0);
            model.addAttribute("diastolic", 0);
            model.addAttribute("respirationrate", 0);
            model.addAttribute("bodysurfacearea", 0);
            model.addAttribute("headcircum", 0);
            model.addAttribute("pulse", 0);
            model.addAttribute("height", 0);
            model.addAttribute("temperature", 0);
            model.addAttribute("weight", 0);
        }

        params = new String[]{"patientvisitid"};
        paramsValues = new Object[]{Long.parseLong(request.getParameter("patientvisitid"))};
        fields = new String[]{"triagevalidationskipid", "skippedfield", "reason",
            "patientvisitid", "addedby", "dateadded", "facilityunitid"};
        String where = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> validationSkips = (List<Object[]>) genericClassService.fetchRecord(Triagevalidationskip.class, fields, where, params, paramsValues);
        if (validationSkips != null) {
            for (Object[] skip : validationSkips) {
                String skippedfield = skip[1].toString().toLowerCase();
                if (skippedfield.equalsIgnoreCase("Weight")) {
                    model.addAttribute("weightReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Height")) {
                    model.addAttribute("HeightReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Temperature")) {
                    model.addAttribute("TempReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Respiration Rate")) {
                    model.addAttribute("RespirationReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Blood Pressure")) {
                    model.addAttribute("PressureReason", skip[2]);
                }
            }
            model.addAttribute("reasonAdded", formatter.format(((Date) validationSkips.get(0)[5])));
            params = new String[]{"facilityunitid"};
            paramsValues = new Object[]{validationSkips.get(0)[6]};
            fields = new String[]{"facilityunitname"};
            List<String> units = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields, "WHERE facilityunitid=:facilityunitid", params, paramsValues);
            if (units != null) {
                model.addAttribute("reasonUnit", units.get(0));
            }
            params = new String[]{"staffid"};
            paramsValues = new Object[]{BigInteger.valueOf((Long) validationSkips.get(0)[4])};
            fields = new String[]{"firstname", "lastname", "othernames", "personid"};
            List<Object[]> staffList = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, "WHERE staffid=:staffid", params, paramsValues);
            if (staffList != null) {
                Object[] staff = staffList.get(0);
                if (staff[2] != null) {
                    model.addAttribute("reasonBy", staff[0] + " " + staff[1] + " " + staff[2]);
                } else {
                    model.addAttribute("reasonBy", staff[0] + " " + staff[1]);
                }
                List<Object[]> contacts = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, new String[]{"contactvalue", "contacttype"}, "WHERE personid=:personid", new String[]{"personid"}, new Object[]{staff[3]});
                if (contacts != null) {
                    String tel = "";
                    for (Object[] contact : contacts) {
                        if (contact[0].toString().equalsIgnoreCase("EMAIL")) {
                            model.addAttribute("email", contact[1]);
                        } else if (contact[0].toString().equalsIgnoreCase("PRIMARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        } else if (contact[0].toString().equalsIgnoreCase("SECONDARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        }
                    }
                    model.addAttribute("contacts", tel);
                }
            }
        }

        Map<String, Object> refDetails = null;
        List<Object[]> referralDetails = (List<Object[]>) genericClassService.fetchRecord(Internalreferral.class, new String[]{"internalreferralid", "referralunitid", "patientvisitid", "referringunitid", "addedby", "dateadded", "iscomplete", "referralnotes", "referredto", "specialty", "unitserviceid"}, "WHERE patientvisitid=:patientvisitid ORDER BY internalreferralid DESC", new String[]{"patientvisitid"}, new Object[]{BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid")))});
        if (referralDetails != null) {
            Object[] detail = referralDetails.get(0);
            refDetails = new HashMap<>();
            refDetails.put("internalreferralid", detail[0]);
            refDetails.put("referralunitid", detail[1]);
            refDetails.put("patientvisitid", (detail[2] == null) ? request.getParameter("patientvisitid") : detail[2]);
            String referringUnit = ((List<String>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitname"}, "WHERE facilityunitid=:referringunitid", new String[]{"referringunitid"}, new Object[]{detail[3]})).get(0);
            refDetails.put("referringUnit", referringUnit);
            List<Object[]> addedby = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, new String[]{"staffid", "firstname", "lastname", "othernames"}, "WHERE staffid=:staffid", new String[]{"staffid"}, new Object[]{detail[4]}));
            if (addedby != null) {
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
        //
        int prevousvisits = 0;
        model.addAttribute("prevousvisits", prevousvisits);

        final long patientvit = Long.parseLong(request.getParameter("patientvisitid"));

        // pause picked patient from the queue.
        if ("a".equals(request.getParameter("act"))) {
            final long addedby = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            final int facilityunit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    String[] params = {"addedby", "dateadded", "paused", "facilityunit"};
                    Object[] paramsValues = {BigInteger.valueOf(addedby), new Date(), true, facilityunit};
                    String[] fields = {"patientpauseid"};
                    List<Integer> pausedpatient = (List<Integer>) genericClassService.fetchRecord(Patientpause.class, fields, "WHERE addedby=:addedby AND dateadded=:dateadded AND paused=:paused AND facilityunit=:facilityunit", params, paramsValues);
                    if (pausedpatient != null) {

                        String[] columns = {"patientvisitid"};
                        Object[] columnValues = {BigInteger.valueOf(patientvit)};
                        String pk = "patientpauseid";
                        Object pkValue = pausedpatient.get(0);
                        int result = genericClassService.updateRecordSQLSchemaStyle(Patientpause.class, columns, columnValues, pk, pkValue, "patient");

                    } else {
                        Patientpause patientpause = new Patientpause();
                        patientpause.setAddedby(BigInteger.valueOf(addedby));
                        patientpause.setDateadded(new Date());
                        patientpause.setPaused(true);
                        patientpause.setPatientvisitid(BigInteger.valueOf(patientvit));
                        patientpause.setFacilityunit(facilityunit);
                        genericClassService.saveOrUpdateRecordLoadObject(patientpause);
                    }

                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();
        }
        return "doctorConsultations/views/patientVitals";
    }

    //
    @RequestMapping(value = "/pausepickedpatient", method = RequestMethod.POST)
    public @ResponseBody
    String pausePickedPatient(HttpServletRequest request,
            @ModelAttribute("patientvisitid") String patientvisitid) {
        final String[] results = new String[1];
        final long addedby = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        final int facilityunit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        final long patientVisitId = Long.parseLong(patientvisitid);
        Runnable myRunnable = new Runnable() {
            @Override
            public void run() {
                String[] params = {"addedby", "dateadded", "paused", "facilityunit"};
                Object[] paramsValues = {BigInteger.valueOf(addedby), new Date(), true, facilityunit};
                String[] fields = {"patientpauseid"};
                List<Integer> pausedpatient = (List<Integer>) genericClassService.fetchRecord(Patientpause.class, fields, "WHERE addedby=:addedby AND dateadded=:dateadded AND paused=:paused AND facilityunit=:facilityunit", params, paramsValues);
                if (pausedpatient != null) {

                    String[] columns = {"patientvisitid"};
                    Object[] columnValues = {BigInteger.valueOf(patientVisitId)};
                    String pk = "patientpauseid";
                    Object pkValue = pausedpatient.get(0);
                    int result = genericClassService.updateRecordSQLSchemaStyle(Patientpause.class, columns, columnValues, pk, pkValue, "patient");
                    if (result > 0) {
                        results[0] = "success";
                    } else {
                        results[0] = "failure";
                    }

                } else {
                    Patientpause patientpause = new Patientpause();
                    patientpause.setAddedby(BigInteger.valueOf(addedby));
                    patientpause.setDateadded(new Date());
                    patientpause.setPaused(true);
                    patientpause.setPatientvisitid(BigInteger.valueOf(patientVisitId));
                    patientpause.setFacilityunit(facilityunit);
                    Object saved = genericClassService.saveOrUpdateRecordLoadObject(patientpause);
                    if (saved != null) {
                        results[0] = "success";
                    } else {
                        results[0] = "failure";
                    }
                }

            }
        };
        Thread thread = new Thread(myRunnable);
        thread.start();
        return results[0];
    }

    //
    @RequestMapping(value = "/lattestsearchresults.htm", method = RequestMethod.GET)
    public String lattestsearchresults(Model model, HttpServletRequest request) {
        List<Map> labTestsList = new ArrayList<>();
        String[] params = {"labtestclassificationid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("labtestclassificationid"))};
        String[] fields = {"laboratorytestid", "testname", "parentid"};
        String where = "WHERE labtestclassificationid=:labtestclassificationid ORDER BY testname ASC";
        List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields, where, params, paramsValues);
        if (labtests != null) {
            Map<String, Object> labaratoryclassificationsRow;
            for (Object[] labtest : labtests) {
                labaratoryclassificationsRow = new HashMap<>();
                labaratoryclassificationsRow.put("laboratorytestid", labtest[0]);
                labaratoryclassificationsRow.put("testname", labtest[1]);
                labaratoryclassificationsRow.put("labtestclassificationname", request.getParameter("classificationname"));
                labTestsList.add(labaratoryclassificationsRow);

            }
        }
        model.addAttribute("labTestsList", labTestsList);
        return "doctorConsultations/forms/searchResults";
    }

    @RequestMapping(value = "/prescriptionhome.htm", method = RequestMethod.GET)
    public String prescriptionhome(Model model, HttpServletRequest request) {
        int prevousPrescriptions = 0;
        long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        String[] params = {"patientid", "patientvisitid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid"))), BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid")))};
        String[] fields = {"patientvisitid", "visitnumber"};
        String where = "WHERE patientid=:patientid AND patientvisitid!=:patientvisitid";
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Patientvisits.class, fields, where, params, paramsValues);
        if (patientsvisits != null) {
            for (Object[] patientsvisit : patientsvisits) {

                String[] params6 = {"patientvisitid"};
                Object[] paramsValues6 = {patientsvisit[0]};
                String where6 = "WHERE patientvisitid=:patientvisitid";
                int prescriptions = genericClassService.fetchRecordCount(Prescription.class, where6, params6, paramsValues6);

                prevousPrescriptions = prevousPrescriptions + prescriptions;

            }
        }
        model.addAttribute("prevousPrescriptions", prevousPrescriptions);
        String results_view = "";

        String[] params7 = {"patientvisitid", "addedby", "dateprescribed", "status"};
        Object[] paramsValues7 = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginStaffid"), new Date(), "SENT"};
        String[] fields7 = {"prescriptionid", "destinationunitid", "addedby", "dateprescribed"};
//        String where7 = "WHERE patientvisitid =:patientvisitid AND addedby=:addedby AND dateprescribed=:dateprescribed AND status=:status";
        String where7 = "WHERE patientvisitid =:patientvisitid AND addedby=:addedby AND DATE(dateprescribed)=:dateprescribed AND status=:status";
        List<Object[]> patientsvisitprescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields7, where7, params7, paramsValues7);
        if (patientsvisitprescriptions != null) {

            List<Map> prescriptionsFound = new ArrayList<>();
            model.addAttribute("prescriptionid", patientsvisitprescriptions.get(0)[0]);

            String[] params2 = {"prescriptionid"};
            Object[] paramsValues2 = {patientsvisitprescriptions.get(0)[0]};
            String[] fields2 = {"prescriptionitemsid", "itemid", "dosage", "days", "daysname", "notes", "dose"};
            String where2 = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields2, where2, params2, paramsValues2);
            if (prescriptions != null) {
                Map<String, Object> itemsRow;
                for (Object[] prescription : prescriptions) {
                    itemsRow = new HashMap<>();

                    String[] params4 = {"itemid"};
                    Object[] paramsValues4 = {BigInteger.valueOf((Long) prescription[1])};
                    String[] fields4 = {"genericname"};
                    String where4 = "WHERE itemid=:itemid";
                    List<String> prescribedItems = (List<String>) genericClassService.fetchRecord(Itemcategories.class, fields4, where4, params4, paramsValues4);
                    if (prescribedItems != null) {
                        itemsRow.put("fullname", prescribedItems.get(0));
                    }
                    itemsRow.put("dosage", prescription[2]);
                    itemsRow.put("days", prescription[3]);
                    itemsRow.put("daysname", prescription[4]);

                    if (prescription[5] != null) {
                        itemsRow.put("notes", prescription[5]);
                    } else {
                        itemsRow.put("notes", "----------");
                    }
                    if (prescription[6] != null) {
                        itemsRow.put("dose", prescription[6]);
                    } else {
                        itemsRow.put("dose", "----------");
                    }

                    prescriptionsFound.add(itemsRow);
                }
            } else {
                params = new String[]{"prescriptionid"};
                paramsValues = new Object[]{patientsvisitprescriptions.get(0)[0]};
                fields = new String[]{"newprescriptionitemsid", "itemname", "dosage", "days", "daysname", "notes", "dose"};
                where = "WHERE prescriptionid=:prescriptionid";
                List<Object[]> newPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
                if (newPrescriptions != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] newPrescription : newPrescriptions) {
                        itemsRow = new HashMap<>();
                        itemsRow.put("fullname", newPrescription[1].toString());
                        itemsRow.put("dosage", newPrescription[2]);
                        itemsRow.put("days", newPrescription[3]);
                        itemsRow.put("daysname", newPrescription[4]);
                        if (newPrescription[5] != null) {
                            itemsRow.put("notes", newPrescription[5]);
                        } else {
                            itemsRow.put("notes", "----------");
                        }
                        if (newPrescription[6] != null) {
                            itemsRow.put("dose", newPrescription[6]);
                        } else {
                            itemsRow.put("dose", "----------");
                        }
                        prescriptionsFound.add(itemsRow);
                    }
                }
            }

            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {patientsvisitprescriptions.get(0)[1]};
            String[] fields4 = {"facilityunitname"};
            String where4 = "WHERE facilityunitid=:facilityunitid";
            List<String> destinationunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
            if (destinationunit != null) {
                model.addAttribute("facilityunitname", destinationunit.get(0));
            }
            String[] params6 = {"staffid"};
            Object[] paramsValues6 = {patientsvisitprescriptions.get(0)[2]};
            String[] fields6 = {"firstname", "othernames", "lastname"};
            String where6 = "WHERE staffid=:staffid";
            List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields6, where6, params6, paramsValues6);
            if (addedby != null) {
                model.addAttribute("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
            }
            model.addAttribute("date", formatter.format((Date) patientsvisitprescriptions.get(0)[3]));

            model.addAttribute("prescriptionsFound", prescriptionsFound);

            results_view = "doctorConsultations/views/patientPrescriptions";

        } else {
            results_view = "doctorConsultations/forms/prescription";
        }
        model.addAttribute("facilityid", facilityId);
        return results_view;
    }

    @RequestMapping(value = "/prescriptionform.htm", method = RequestMethod.GET)
    public String prescriptionform(Model model, HttpServletRequest request) {
        List<Map> doctorprescriptionHomesFound = new ArrayList<>();
        List<Map<String, Object>> specialInstructions = new ArrayList<>(); //Jim
        try {
            if ("a".equals(request.getParameter("act"))) {
                String[] params = {"issupplies"};
                Object[] paramsValues = {Boolean.FALSE};
//                String[] fields = {"itemid", "fullname"};
//                String where = "WHERE issupplies=:issupplies";
//                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                String[] fields = {"genericname"};
                String where = "WHERE issupplies=:issupplies GROUP BY genericname";
                List<Object> items = (List<Object>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                if (items != null) {
                    Map<String, Object> itemsRow;
//                    for (Object[] item : items) {
                    for (Object item : items) {
                        itemsRow = new HashMap<>();
//                        itemsRow.put("itemid", item[0]);
//                        itemsRow.put("fullname", item[1]);
                        itemsRow.put("itemid", item.toString());
                        itemsRow.put("fullname", item.toString());
                        doctorprescriptionHomesFound.add(itemsRow);
                    }
                }
            } else {
//                Set<Long> items = new HashSet<>();
                Set<String> items = new HashSet<>();
//                List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescribedItems"), List.class);
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescribedItems"), List.class);
                for (String itemid : item) {
//                    items.add(Long.parseLong(String.valueOf(itemid)));
                    items.add(itemid);
                }
                String[] params = {"issupplies"};
                Object[] paramsValues = {Boolean.FALSE};
//                String[] fields = {"itemid", "genericname"};
//                String where = "WHERE issupplies=:issupplies";
//                List<Object[]> itemss = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                String[] fields = {"genericname"};
                String where = "WHERE issupplies=:issupplies GROUP BY genericname";
                List<Object> itemss = (List<Object>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                if (itemss != null) {
                    Map<String, Object> itemsRow;
//                    for (Object[] itemz : itemss) {
                    for (Object itemz : itemss) {
                        itemsRow = new HashMap<>();
//                        if (items.isEmpty() || !items.contains(((BigInteger) itemz[0]).longValue())) {
//                            itemsRow.put("itemid", itemz[0]);
//                            itemsRow.put("fullname", itemz[1]);
//                            doctorprescriptionHomesFound.add(itemsRow);
//                        }
//                        if (items.isEmpty() || !items.contains((itemz).toString().replaceAll("[^a-zA-Z0-9]", ""))) {
                        if (items.isEmpty() || !items.contains((itemz).toString())) {
                            itemsRow.put("itemid", itemz.toString());
                            itemsRow.put("fullname", itemz.toString());
                            if (!doctorprescriptionHomesFound.contains(itemsRow)) {
                                doctorprescriptionHomesFound.add(itemsRow);
                            }
                        }
                    }
                }
            }
            //
            String[] fields = {"specialinstructionsid", "specialinstruction"};
            String where = "";
            String[] params = null;
            Object[] paramsValues = null;
            List<Object[]> instructions = (List<Object[]>) genericClassService.fetchRecord(Specialinstructions.class, fields, where, params, paramsValues);
            if (instructions != null) {
                Map<String, Object> specialInstruction;
                for (Object[] instruction : instructions) {
                    specialInstruction = new HashMap<>();
                    specialInstruction.put("specialinstructionsid", instruction[0]);
                    specialInstruction.put("specialinstruction", instruction[1].toString());
                    specialInstructions.add(specialInstruction);
                }
            }
            //

        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::" + e);
        }

        model.addAttribute("ItemsFound", doctorprescriptionHomesFound);
        model.addAttribute("specialInstructions", specialInstructions);
        return "doctorConsultations/forms/prescriptionform";
    }

    @RequestMapping(value = "/sendpatienttothelabaratory.htm", method = RequestMethod.GET)
    public String sendpatienttothelabaratory(Model model, HttpServletRequest request) {
        List<Map> labTestsClassificationsFound = new ArrayList<>();

        long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        Integer facilityUnitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        String[] params = {"isactive"};
        Object[] paramsValues = {Boolean.TRUE};
        String[] fields = {"labtestclassificationid", "labtestclassificationname"};
        String where = "WHERE isactive=:isactive AND parentid IS NULL";
        List<Object[]> labtestsclassifications = (List<Object[]>) genericClassService.fetchRecord(Labtestclassification.class, fields, where, params, paramsValues);
        if (labtestsclassifications != null) {
            Map<String, Object> testsRow;
            for (Object[] labtestsclassification : labtestsclassifications) {
                testsRow = new HashMap<>();
                testsRow.put("labtestclassificationid", labtestsclassification[0]);
                testsRow.put("labtestclassificationname", labtestsclassification[1]);
                labTestsClassificationsFound.add(testsRow);
            }
        }
        model.addAttribute("labTestsClassificationsFound", labTestsClassificationsFound);

        int prevoiusvisitsCount = 0;
        String[] params8 = {"patientvisitid", "patientid"};
        Object[] paramsValues8 = {Long.parseLong(request.getParameter("patientvisitid")), Long.parseLong(request.getParameter("patientid"))};
        String[] fields8 = {"patientvisitid"};
        String where8 = "WHERE patientvisitid!=:patientvisitid AND patientid=:patientid";
        List<Long> patientvisits = (List<Long>) genericClassService.fetchRecord(Patientvisit.class, fields8, where8, params8, paramsValues8);
        if (patientvisits != null) {
            for (Long patientvisit : patientvisits) {
                String[] params2 = {"patientvisitid"};
                Object[] paramsValues2 = {patientvisit};
                String where2 = "WHERE patientvisitid=:patientvisitid";
                int prevoiusvisitsCount2 = genericClassService.fetchRecordCount(Laboratoryrequest.class, where2, params2, paramsValues2);
                prevoiusvisitsCount = prevoiusvisitsCount + prevoiusvisitsCount2;
            }
        }
        model.addAttribute("prevoiusvisitsCount", prevoiusvisitsCount);
        model.addAttribute("facilityid", facilityId);
        model.addAttribute("facilityunitid", facilityUnitId);
        return "doctorConsultations/forms/labRequest";
    }

    @RequestMapping(value = "/sendpatientlabaratoryrequest.htm")
    public @ResponseBody
    String sendpatientlabaratoryrequest(HttpServletRequest request) {
        String results = "";
        try {
            Long sess = Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")));
            Laboratoryrequest laboratoryrequest = new Laboratoryrequest();
            laboratoryrequest.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            laboratoryrequest.setDateadded(new Date());
            laboratoryrequest.setOriginunit(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            laboratoryrequest.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
            laboratoryrequest.setStatus("SENT");
            laboratoryrequest.setDestinationunit(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            laboratoryrequest.setLaboratoryrequestnumber(generatefacilitylabrequestno("00" + sess, sess));
            Object save = genericClassService.saveOrUpdateRecordLoadObject(laboratoryrequest);
            if (save != null) {
                List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (Integer item1 : item) {
                    Laboratoryrequesttest laboratoryrequesttest = new Laboratoryrequesttest();
                    laboratoryrequesttest.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                    laboratoryrequesttest.setDateadded(new Date());
                    laboratoryrequesttest.setIscompleted(Boolean.FALSE);
                    laboratoryrequesttest.setLaboratoryrequestid(laboratoryrequest.getLaboratoryrequestid());
                    laboratoryrequesttest.setLaboratorytestid(Long.parseLong(String.valueOf(item1)));
                    genericClassService.saveOrUpdateRecordLoadObject(laboratoryrequesttest);
                }
            }
        } catch (Exception e) {
            System.out.println("com.iics.web.DoctorConsultation.sendpatientlabaratoryrequest()::" + e);
        }
        return results;
    }

    private String generatefacilitylabrequestno(String facilityunit, Long originunit) {
        String name = facilityunit + "/";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String pattern = name + f.format(new Date()) + "/%";
        String laboratoryrequestnum = "";

        String[] params = {"originunit", "laboratoryrequestnumber"};
        Object[] paramsValues = {originunit, pattern};
        String[] fields = {"laboratoryrequestnumber"};
        String where = "WHERE originunit=:originunit AND laboratoryrequestnumber LIKE :laboratoryrequestnumber ORDER BY laboratoryrequestnumber DESC LIMIT 1";
        List<String> laboratoryrequestnumber = (List<String>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, where, params, paramsValues);
        if (laboratoryrequestnumber == null) {
            laboratoryrequestnum = name + f.format(new Date()) + "/0001";
            return laboratoryrequestnum;
        } else {
            try {
                int lastNo = Integer.parseInt(laboratoryrequestnumber.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        laboratoryrequestnum = name + f.format(new Date()) + "/000" + newNo;
                        break;
                    case 2:
                        laboratoryrequestnum = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 3:
                        laboratoryrequestnum = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        laboratoryrequestnum = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return laboratoryrequestnum;
    }

//    @RequestMapping(value = "/savepatientsprescriptions.htm")
//    public @ResponseBody
//    String savepatientsprescriptions(HttpServletRequest request) {
//        String results = "";
//
//        List<Map> prescriptionunitsFound = new ArrayList<>();
//        try {
//            List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescriptions"), List.class);
//
//            Prescription prescription = new Prescription();
//            prescription.setDateprescribed(new Date());
//            prescription.setDestinationunitid(Long.parseLong(request.getParameter("dispensingUnitid")));
//            prescription.setOriginunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
//            prescription.setPatientvisitid(Long.parseLong(request.getParameter("patientVisitsid")));
//            prescription.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
//            prescription.setStatus("SENT");
//            //
//            prescription.setReferencenumber(getPrescriptionRefrenceNumber(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));
//            //
//            Object save = genericClassService.saveOrUpdateRecordLoadObject(prescription);
//            if (save != null) {
//                for (Map item1 : item) {
//                    Map<String, Object> map = (HashMap) item1;
////                    Prescriptionitems prescriptionitems = new Prescriptionitems();
////                    prescriptionitems.setDateadded(new Date());
////                    prescriptionitems.setPrescriptionid(prescription.getPrescriptionid());
////                    prescriptionitems.setItemid(Long.parseLong((String) map.get("itemid")));
////                    prescriptionitems.setDosage((String) map.get("dosage"));
////                    prescriptionitems.setDays(Integer.parseInt((String) map.get("days")));
////                    prescriptionitems.setDaysname((String) map.get("daysname"));
////                    prescriptionitems.setNotes((String) map.get("comment"));
////                    prescriptionitems.setDose((String) map.get("dose"));
//                    //
//                    Newprescriptionitems prescriptionitems = new Newprescriptionitems();
//                    prescriptionitems.setPrescriptionid(prescription.getPrescriptionid());
//                    prescriptionitems.setItemname(map.get("itemid").toString());
//                    prescriptionitems.setDosage(map.get("dosage").toString());
//                    prescriptionitems.setDays(Integer.parseInt(map.get("days").toString()));
//                    prescriptionitems.setDaysname(map.get("daysname").toString());
//                    prescriptionitems.setNotes(map.get("comment").toString());
//                    prescriptionitems.setDose(map.get("dose").toString());
//                    prescriptionitems.setIsapproved(Boolean.FALSE);
//                    prescriptionitems.setIsissued(Boolean.FALSE);
//
//                    genericClassService.saveOrUpdateRecordLoadObject(prescriptionitems);
//                    
//                    //
//                    String [] fields = { "specialinstructionsid", "specialinstruction" };
//                    String where = "WHERE LOWER(specialinstruction)=:specialinstruction";
//                    String [] params = { "specialinstruction" };
//                    Object [] paramsValues = { map.get("comment").toString().toLowerCase() };
//                    List<Object[]> instructions = (List<Object[]>) genericClassService.fetchRecord(Specialinstructions.class, fields, where, params, paramsValues);
//                    if (instructions == null && !(map.get("comment").toString().isEmpty())) {
//                        long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
//                        Specialinstructions instruction = new Specialinstructions();
//                        instruction.setSpecialinstruction(capitalize(map.get("comment").toString()));
//                        instruction.setAddedby(staffId);
//                        instruction.setDateadded(new Date());
//                        Object saved = genericClassService.saveOrUpdateRecordLoadObject(instruction);
//                    }
//                    //
//
//                }
//            }
//
//            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
//            String[] params = {"facilityunitid", "status", "servicekey"};
//            Object[] paramsValues = {Long.parseLong(request.getParameter("dispensingUnitid")), Boolean.TRUE, "key_dispensing"};
//            String[] fields = {"facilityunitserviceid", "facilityservices.serviceid", "facilityservices.servicename", "facilityservices.servicekey"};
//            String where = "WHERE r.facilityunit.facilityunitid=:facilityunitid AND status=:status AND servicekey=:servicekey";
//            List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
//            Map<String, Object> resultsRow = new HashMap<>();
//            if (facilityunitservices != null) {
//                resultsRow.put("facilityunitservicesid", facilityunitservices.get(0)[0]);
//            }
//            resultsRow.put("prescriptionid", prescription.getPrescriptionid());
//            resultsRow.put("staffid", staffid);
//            resultsRow.put("unit", prescription.getDestinationunitid());
//            resultsRow.put("date", formatter.format(prescription.getDateprescribed()));
//            //
//            resultsRow.put("facilityunitid", Long.parseLong(request.getParameter("dispensingUnitid")));
//            //
//
//            prescriptionunitsFound.add(resultsRow);
//
//            results = new ObjectMapper().writeValueAsString(prescriptionunitsFound);
//
//        } catch (IOException | NumberFormatException e) {
//            System.out.println("::::::::::::::::::::::::::::::::::::::::::::" + e);
//        }
//
//        return results;
//    }
    @RequestMapping(value = "/savepatientsprescriptions.htm")
    public @ResponseBody
    String savepatientsprescriptions(HttpServletRequest request) {
        String results = "";
        final Map<String, Object> resultsRow = new HashMap<>();
        final List<Map> prescriptionunitsFound = new ArrayList<>();
        try {
            List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescriptions"), List.class);

            final long dispensingUnitId = Long.parseLong(request.getParameter("dispensingUnitid"));
            final Long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
            final long facilityUnitServicesId = Long.parseLong(request.getParameter("facilityunitserviceid"));

            Prescription prescription = new Prescription();
            prescription.setDateprescribed(new Date());
            prescription.setDestinationunitid(Long.parseLong(request.getParameter("dispensingUnitid")));
            prescription.setOriginunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            prescription.setPatientvisitid(Long.parseLong(request.getParameter("patientVisitsid")));
            prescription.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            prescription.setStatus("SENT");
            //
            prescription.setReferencenumber(getPrescriptionRefrenceNumber(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));
            //
            Object save = genericClassService.saveOrUpdateRecordLoadObject(prescription);
            if (save != null) {
                item.stream().map((item1) -> (HashMap) item1).forEachOrdered((map) -> {
                    Object result = null;
                    Newprescriptionitems prescriptionitems = new Newprescriptionitems();
                    prescriptionitems.setPrescriptionid(prescription.getPrescriptionid());
                    prescriptionitems.setItemname(map.get("itemid").toString());
                    prescriptionitems.setDosage(map.get("dosage").toString());
                    prescriptionitems.setDays(Integer.parseInt(map.get("days").toString()));
                    prescriptionitems.setDaysname(map.get("daysname").toString());
                    prescriptionitems.setNotes(map.get("comment").toString());
                    prescriptionitems.setDose(map.get("dose").toString());
                    prescriptionitems.setIsapproved(Boolean.FALSE);
                    prescriptionitems.setIsissued(Boolean.FALSE);
                    result = genericClassService.saveOrUpdateRecordLoadObject(prescriptionitems);
                    if (result != null) {
                        //
                        String[] fields = {"specialinstructionsid", "specialinstruction"};
                        String where = "WHERE LOWER(specialinstruction)=:specialinstruction";
                        String[] params = {"specialinstruction"};
                        Object[] paramsValues = {map.get("comment").toString().toLowerCase()};
                        List<Object[]> instructions = (List<Object[]>) genericClassService.fetchRecord(Specialinstructions.class, fields, where, params, paramsValues);
                        //
                        if (instructions == null && !(map.get("comment").toString().isEmpty())) {
                            long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
                            Specialinstructions instruction = new Specialinstructions();
                            instruction.setSpecialinstruction(capitalize(map.get("comment").toString()));
                            instruction.setAddedby(staffId);
                            instruction.setDateadded(new Date());
                            Object saved = genericClassService.saveOrUpdateRecordLoadObject(instruction);
                        }
                    }
                });
            }
            resultsRow.put("facilityunitservicesid", facilityUnitServicesId);
            resultsRow.put("prescriptionid", prescription.getPrescriptionid());
            resultsRow.put("staffid", staffid);
            resultsRow.put("unit", prescription.getDestinationunitid());
            resultsRow.put("date", formatter.format(prescription.getDateprescribed()));
            //
            resultsRow.put("facilityunitid", dispensingUnitId);
            //

            prescriptionunitsFound.add(resultsRow);

            results = new ObjectMapper().writeValueAsString(prescriptionunitsFound);

        } catch (IOException | NumberFormatException e) {
            System.out.println("::::::::::::::::::::::::::::::::::::::::::::" + e);
        }

        return results;
    }

//    @RequestMapping(value = "/getdispensingunits.htm", method = RequestMethod.GET)
//    public String getdispensingunits(Model model, HttpServletRequest request) {
//        List<Map> dispensingunitsFound = new ArrayList<>();
//
//        String[] params2 = {"servicekey", "status", "facilityunitid"};
//        Object[] paramsValues2 = {"key_dispensing", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
//        String[] fields2 = {"facilityunitserviceid", "facilityunit.facilityunitid"};
//        String where2 = "WHERE r.facilityservices.servicekey=:servicekey AND status=:status AND facilityunitid=:facilityunitid";
//        List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields2, where2, params2, paramsValues2);
//        if (units != null) {
//            String[] params = {"facilityunitid"};
//            Object[] paramsValues = {units.get(0)[1]};
//            String[] fields = {"facilityunitid", "facilityunitname"};
//            String where = "WHERE facilityunitid=:facilityunitid";
//            List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
//            if (facilityunits != null) {
//                model.addAttribute("type", "notnull");
//                model.addAttribute("facilityunitid", units.get(0)[1]);
//                model.addAttribute("facilityunitname", facilityunits.get(0)[1]);
//            } else {
//                model.addAttribute("type", "null");
//            }
//        }
//
//        //key_dispensing
//        String[] params3 = {"servicekey", "status", "facilityid"};
//        Object[] paramsValues3 = {"key_dispensing", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacility")};
//        String[] fields3 = {"facilityunitserviceid", "facilityunit.facilityunitid"};
//        String where3 = "WHERE r.facilityservices.servicekey=:servicekey AND status=:status AND r.facilityunit.facilityid=:facilityid";
//        List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields3, where3, params3, paramsValues3);
//        if (facilityunitservices != null) {
//            Map<String, Object> unitservice;
//            for (Object[] facilityunitservice : facilityunitservices) {
//                unitservice = new HashMap<>();
//                if (((Long) facilityunitservice[1]).intValue() != ((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))) {
//                    String[] params = {"facilityunitid"};
//                    Object[] paramsValues = {facilityunitservice[1]};
//                    String[] fields = {"facilityunitid", "facilityunitname"};
//                    String where = "WHERE facilityunitid=:facilityunitid";
//                    List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
//                    if (facilityunits != null) {
//                        unitservice.put("facilityunitid", facilityunitservice[1]);
//                        unitservice.put("facilityunitname", facilityunits.get(0)[1]);
//                        dispensingunitsFound.add(unitservice);
//                    }
//                }
//            }
//        }
//        model.addAttribute("dispensingunitsFound", dispensingunitsFound);
//        return "doctorConsultations/forms/dispensingUnits";
//    }
    @RequestMapping(value = "/getdispensingunits.htm", method = RequestMethod.GET)
    public String getdispensingunits(Model model, HttpServletRequest request) {
        final List<Map> dispensingunitsFound = new ArrayList<>();
        final long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
        try {
            // Current unit key_dispensing
            String[] params = {"servicekey", "status", "facilityunitid"};
            Object[] paramsValues = {"key_dispensing", Boolean.TRUE, facilityUnitId};
            String[] fields = {"facilityunitid", "facilityunitname", "facilityunitserviceid"};
            String where = "WHERE TRIM(servicekey)=:servicekey AND status=:status AND facilityunitid=:facilityunitid";
            List<Object[]> facilityUnits = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservicesview.class, fields, where, params, paramsValues);
            if (facilityUnits != null) {
                Object[] facilityUnit = facilityUnits.get(0);
                model.addAttribute("type", "notnull");
                model.addAttribute("facilityunitid", facilityUnit[0]);
                model.addAttribute("facilityunitname", facilityUnit[1]);
                model.addAttribute("facilityunitserviceid", facilityUnit[2]);
            } else {
                model.addAttribute("type", "null");
            }

            // Other units key_dispensing
            params = new String[]{"servicekey", "status", "facilityid"};
            paramsValues = new Object[]{"key_dispensing", Boolean.TRUE, facilityId};
            fields = new String[]{"facilityunitid", "facilityunitname", "facilityunitserviceid"};
            where = "WHERE TRIM(servicekey)=:servicekey AND status=:status AND facilityid=:facilityid";
            facilityUnits = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservicesview.class, fields, where, params, paramsValues);
            if (facilityUnits != null) {
                Map<String, Object> unitService;
                for (Object[] facilityUnit : facilityUnits) {
                    unitService = new HashMap<>();
                    if (facilityUnitId != Long.parseLong(facilityUnit[0].toString())) {
                        unitService.put("facilityunitid", facilityUnit[0]);
                        unitService.put("facilityunitname", facilityUnit[1]);
                        unitService.put("facilityunitserviceid", facilityUnit[2]);
                        dispensingunitsFound.add(unitService);
                    }
                }
            }
            model.addAttribute("dispensingunitsFound", dispensingunitsFound);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        model.addAttribute("dispensingunitsFound", dispensingunitsFound);
        return "doctorConsultations/forms/dispensingUnits";
    }

    @RequestMapping(value = "/queuepatienttootherservice.htm", method = RequestMethod.GET)
    public String queuepatienttootherservice(Model model, HttpServletRequest request) {
        List<Map> unitsFound = new ArrayList<>();
        Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
        Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        String[] params2 = {"facilityid"};
        Object[] paramsValues2 = {facilityId};
        String[] fields2 = {"facilityunitid", "facilityunitname"};
        String where2 = "WHERE facilityid=:facilityid";
        List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2, where2, params2, paramsValues2);
        if (units != null) {
            Map<String, Object> unit;
            for (Object[] u : units) {
                unit = new HashMap<>();
                if (facilityUnit != ((Long) u[0]).intValue()) {
                    String[] params = {"facilityunitid", "status"};
                    Object[] paramsValues = {u[0], Boolean.TRUE};
                    String[] fields = {"facilityunitserviceid", "dateadded"};
                    String where = "WHERE r.facilityunit.facilityunitid=:facilityunitid AND status=:status";
                    List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                    if (facilityunitservices != null) {
                        unit.put("id", u[0]);
                        unit.put("name", u[1]);
                        unitsFound.add(unit);
                    }
                }
            }
        }
        model.addAttribute("unitsFound", unitsFound);

        List<Map> unitServicesFound = new ArrayList<>();
        String[] params = {"facilityunitid", "status"};
        Object[] paramsValues = {facilityUnit, Boolean.TRUE};
        String[] fields = {"facilityunitserviceid", "facilityservices.serviceid", "facilityservices.servicename", "facilityservices.servicekey"};
        String where = "WHERE r.facilityunit.facilityunitid=:facilityunitid AND status=:status";
        List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
        if (facilityunitservices != null) {
            Map<String, Object> unitServices;
            for (Object[] facilityunitservice : facilityunitservices) {
                unitServices = new HashMap<>();
//                if (!"key_triage".equals((String) facilityunitservice[3]) && !"key_htdm".equals((String) facilityunitservice[3])) {
                if (!"key_triage".equals((String) facilityunitservice[3]) && !"key_htdm".equals((String) facilityunitservice[3])
                        && !"key_dispensing".equalsIgnoreCase(facilityunitservice[3].toString())
                        && !"key_counselling".equalsIgnoreCase(facilityunitservice[3].toString())) {
                    unitServices.put("facilityunitserviceid", facilityunitservice[0]);
                    unitServices.put("servicename", facilityunitservice[2]);
                    unitServices.put("servicekey", facilityunitservice[3]);
                    unitServicesFound.add(unitServices);
                }
            }
        }
        model.addAttribute("unitServicesFound", unitServicesFound);
        Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        model.addAttribute("staffid", staffid);

        String[] paramsu = {"facilityunitid"};
        Object[] paramsValuesu = {facilityUnit};
        String[] fieldsu = {"facilityunitname"};
        String whereu = "WHERE facilityunitid=:facilityunitid";
        List<String> facilityunitname = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsu, whereu, paramsu, paramsValuesu);
        if (facilityunitname != null) {
            model.addAttribute("facilityunitname", facilityunitname.get(0));
            model.addAttribute("facilityunitid", facilityUnit);
        }
        return "patientsManagement/triage/forms/unitsServices";
    }

    @RequestMapping(value = "/facilityUnitServices.htm")
    public @ResponseBody
    String facilityUnitServices(HttpServletRequest request) {
        String results = "";
        try {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> unitServicesFound = new ArrayList<>();

            String[] params = {"facilityunitid", "status"};
            Object[] paramsValues = {new Facilityunit(Long.parseLong(request.getParameter("facilityunit"))), Boolean.TRUE};
            String[] fields = {"facilityunitserviceid", "facilityservices.serviceid", "facilityservices.servicename", "facilityservices.servicekey"};
            String where = "WHERE r.facilityunit.facilityunitid=:facilityunitid AND status=:status";
            List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
            if (facilityunitservices != null) {
                Map<String, Object> unitServices;
                for (Object[] facilityunitservice : facilityunitservices) {
                    unitServices = new HashMap<>();
                    if (!"key_triage".equals((String) facilityunitservice[3]) && Long.parseLong(String.valueOf(facilityUnit)) == Long.parseLong(request.getParameter("facilityunit"))) {
                        unitServices.put("facilityunitserviceid", facilityunitservice[0]);
                        unitServices.put("servicename", facilityunitservice[2]);
                        unitServices.put("servicekey", facilityunitservice[3]);

                        unitServicesFound.add(unitServices);

                    } else if (Long.parseLong(String.valueOf(facilityUnit)) != Long.parseLong(request.getParameter("facilityunit"))) {
                        unitServices.put("facilityunitserviceid", facilityunitservice[0]);
                        unitServices.put("servicename", facilityunitservice[2]);
                        unitServices.put("servicekey", facilityunitservice[3]);

                        unitServicesFound.add(unitServices);
                    }
                }
            }
            results = new ObjectMapper().writeValueAsString(unitServicesFound);

        } catch (Exception e) {
        }
        return results;
    }

    @RequestMapping(value = "/viewlaboratoryClassificationtests.htm")
    public @ResponseBody
    String viewlaboratoryClassificationtests(HttpServletRequest request) {
        String results = "";
        try {
            List<Map> classificationsFound = new ArrayList<>();

            String[] params = {"parentid", "isactive"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("labtestclassificationid")), Boolean.TRUE};
            String[] fields = {"labtestclassificationid", "labtestclassificationname"};
            String where = "WHERE parentid=:parentid AND isactive=:isactive";
            List<Object[]> classifications = (List<Object[]>) genericClassService.fetchRecord(Labtestclassification.class, fields, where, params, paramsValues);
            if (classifications != null) {
                Map<String, Object> classificationsRows;
                for (Object[] classification : classifications) {
                    classificationsRows = new HashMap<>();
                    classificationsRows.put("labtestclassificationid", classification[0]);
                    classificationsRows.put("labtestclassificationname", classification[1]);
                    classificationsFound.add(classificationsRows);
                }
            }
            results = new ObjectMapper().writeValueAsString(classificationsFound);

        } catch (Exception e) {

        }

        return results;
    }

    @RequestMapping(value = "/subCategoryLabTests.htm", method = RequestMethod.GET)
    public String subCategoryLabTests(Model model, HttpServletRequest request) {
        List<Map> labTestsFound = new ArrayList<>();
        String[] params = {"labtestclassificationid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("labtestclassificationid")), Boolean.TRUE};
        String[] fields = {"laboratorytestid", "testname"};
        String where = "WHERE labtestclassificationid=:labtestclassificationid";
        List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields, where, params, paramsValues);
        if (labtests != null) {
            Map<String, Object> classificationsRows;
            for (Object[] labtest : labtests) {
                classificationsRows = new HashMap<>();
                classificationsRows.put("laboratorytestid", labtest[0]);
                classificationsRows.put("testname", labtest[1]);
                labTestsFound.add(classificationsRows);
            }
        }
        model.addAttribute("labTestsFound", labTestsFound);
        return "doctorConsultations/forms/labTestsList";
    }

    @RequestMapping(value = "/patientPrescriptionPrintOut.htm", method = RequestMethod.GET)
    public String unitRegisterPrintOut(HttpServletRequest request, Model model, @ModelAttribute("unitid") Integer facilityUnit, @ModelAttribute("unit") String unit, @ModelAttribute("patientVisitsid") String patientVisitsid, @ModelAttribute("facility") String facility, @ModelAttribute("patientid") String patientid, @ModelAttribute("prescriptionid") String prescriptionid) {
        try {
            String[] params = {"patientid"};
            Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(patientid))};
            String[] fields = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin"};
            List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
            if (patientsvisits != null) {
                String[] params5 = {"personid"};
                Object[] paramsValues5 = {patientsvisits.get(0)[0]};
                String[] fields5 = {"dob", "estimatedage", "gender", "currentaddress.villageid"};
                List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5, "WHERE personid=:personid", params5, paramsValues5);

                model.addAttribute("name", patientsvisits.get(0)[1] + " " + patientsvisits.get(0)[3] + " " + patientsvisits.get(0)[2]);
                model.addAttribute("patientno", patientsvisits.get(0)[4]);
                model.addAttribute("telephone", patientsvisits.get(0)[5]);
                model.addAttribute("nextofkin", patientsvisits.get(0)[6]);
                model.addAttribute("dob", formatter.format((Date) patientdetails.get(0)[0]));

                model.addAttribute("gender", patientdetails.get(0)[2]);

                model.addAttribute("date", formatter.format(new Date()));

                SimpleDateFormat df = new SimpleDateFormat("yyyy");
                int year = Integer.parseInt(df.format((Date) patientdetails.get(0)[0]));
                int currentyear = Integer.parseInt(df.format(new Date()));
                model.addAttribute("estimatedage", currentyear - year);

                model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
                model.addAttribute("visitnumber", request.getParameter("visitnumber"));
                model.addAttribute("patientid", request.getParameter("patientid"));

                String[] params2 = {"villageid"};
                Object[] paramsValues2 = {patientdetails.get(0)[3]};
                String[] fields2 = {"villagename", "subcountyname", "districtname"};
                String where2 = "WHERE villageid=:villageid";
                List<Object[]> addresses = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fields2, where2, params2, paramsValues2);
                if (addresses != null) {
                    model.addAttribute("villagename", addresses.get(0)[0]);
                    model.addAttribute("subcountyname", addresses.get(0)[1]);
                    model.addAttribute("districtname", addresses.get(0)[2]);

                }
            }
            List<Map> prescriptionsFound = new ArrayList<>();
            String[] params2 = {"prescriptionid"};
            Object[] paramsValues2 = {Long.parseLong(prescriptionid)};
            String[] fields2 = {"itemid", "dosage", "daysname", "notes", "days", "dose"};
            String where2 = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields2, where2, params2, paramsValues2);
            if (prescriptions != null) {
                Map<String, Object> itemsRows;
                for (Object[] prescription : prescriptions) {
                    itemsRows = new HashMap<>();

                    String[] params3 = {"itemid"};
                    Object[] paramsValues3 = {prescription[0]};
                    String[] fields3 = {"genericname"};
                    String where3 = "WHERE itemid=:itemid";
                    List<String> prescriptionitems = (List<String>) genericClassService.fetchRecord(Itemcategories.class, fields3, where3, params3, paramsValues3);
                    if (prescriptionitems != null) {
                        itemsRows.put("fullname", prescriptionitems.get(0));
                        itemsRows.put("activedose", prescription[5]);
                        itemsRows.put("dosage", prescription[1]);
                        itemsRows.put("days", prescription[4] + " " + prescription[2]);
                        if (prescription[3] != null) {
                            itemsRows.put("comment", prescription[3]);
                        } else {
                            itemsRows.put("comment", "--------");
                        }
                        prescriptionsFound.add(itemsRows);
                    }
                }
            } else {
                fields = new String[]{"itemname", "dosage", "daysname", "notes", "days", "dose"};
                params = new String[]{"prescriptionid"};
                paramsValues = new Object[]{Long.parseLong(prescriptionid)};
                String where = "WHERE prescriptionid=:prescriptionid";
                List<Object[]> newPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
                if (newPrescriptions != null) {
                    Map<String, Object> itemsRows;
                    for (Object[] newPrescription : newPrescriptions) {
                        itemsRows = new HashMap<>();
                        itemsRows.put("fullname", newPrescription[0].toString());
                        itemsRows.put("activedose", newPrescription[5]);
                        itemsRows.put("dosage", newPrescription[1]);
                        itemsRows.put("days", newPrescription[4] + " " + newPrescription[2]);
                        if (newPrescription[3] != null) {
                            itemsRows.put("comment", newPrescription[3]);
                        } else {
                            itemsRows.put("comment", "--------");
                        }
                        prescriptionsFound.add(itemsRows);
                    }
                }
            }
            model.addAttribute("prescriptionsFound", prescriptionsFound);
            model.addAttribute("unit", unit.replace("@--@", " "));
            model.addAttribute("facility", facility.replace("@--@", " "));
            return "doctorConsultations/forms/patientPrescriptionsPrintOut";
        } catch (Exception e) {
            return "patientsManagement/unitRegister/dateError";
        }
    }

    @RequestMapping(value = "/printPatientPrescription", method = RequestMethod.GET)
    public @ResponseBody
    String createDiscrepancyReportPDF(HttpServletRequest request, Model model, @ModelAttribute("patientVisitsid") String patientVisitsid, @ModelAttribute("patientid") String patientid, @ModelAttribute("prescriptionid") String prescriptionid) {
        String baseEncode = "";
        String facility = ((Facility) request.getSession().getAttribute("sessionActiveLoginFacilityObj")).getFacilityname();
        String unit = ((Facilityunit) request.getSession().getAttribute("sessionActiveLoginFacilityUnitObj")).getFacilityunitname();
        Integer unitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        String url = IICS.BASE_URL + "doctorconsultation/patientPrescriptionPrintOut.htm?unitid=" + unitid + "&unit=" + unit + "&patientVisitsid=" + patientVisitsid + "&facility=" + facility + "&patientid=" + patientid + "&prescriptionid=" + prescriptionid;
        String path = getUnitRegisterPath() + unitid + patientVisitsid + ".pdf";
        PdfWriter pdfWriter;
        Document document = new Document();
        try {
            pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
            document.setPageSize(PageSize.A4);
            document.open();

            URL myWebPage = new URL(url.replaceAll(" ", "@--@"));
            InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
            XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
            worker.parseXHtml(pdfWriter, document, fis);

            document.close();
            pdfWriter.close();
            File pdf = new File(path);
            if (pdf.exists()) {
                baseEncode = Base64.getEncoder().encodeToString(loadFileAsBytesArray(path));
                pdf.delete();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return baseEncode;
    }

    public String getUnitRegisterPath() {
        File file;
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                file = new File("C:/iicsReports/patients/prescriptions");
                path = "C:/iicsReports/patients/prescriptions/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/patients/prescriptions");
                path = "/home/iicsReports/patients/prescriptions/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/patients/prescriptions");
                path = "/Users/iicsReports/patients/prescriptions/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
    }

    @RequestMapping(value = "/viewprevouspatientsprescriptions.htm", method = RequestMethod.GET)
    public String viewprevouspatientsprescriptions(Model model, HttpServletRequest request) {
        List<Map> prescriptionsFound = new ArrayList<>();
        String[] params = {"patientid", "patientvisitid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid"))), BigInteger.valueOf(Long.parseLong(request.getParameter("patientVisitsid")))};
        String[] fields = {"patientvisitid", "visitnumber"};
        String where = "WHERE patientid=:patientid AND patientvisitid!=:patientvisitid";
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Patientvisits.class, fields, where, params, paramsValues);
        if (patientsvisits != null) {
            Map<String, Object> prescriptionsRows;
            for (Object[] patientsvisit : patientsvisits) {
                prescriptionsRows = new HashMap<>();
                int prescriptionitemsCount = 0;

                String[] params3 = {"patientvisitid"};
                Object[] paramsValues3 = {patientsvisit[0]};
                String[] fields3 = {"prescriptionid", "dateprescribed", "addedby", "originunitid"};
                List<Object[]> prevousprescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields3, "WHERE patientvisitid=:patientvisitid", params3, paramsValues3);
                if (prevousprescriptions != null) {

                    String[] params6 = {"prescriptionid"};
                    Object[] paramsValues6 = {prevousprescriptions.get(0)[0]};
                    String where6 = "WHERE prescriptionid=:prescriptionid";
                    int prescriptions = genericClassService.fetchRecordCount(Prescriptionitems.class, where6, params6, paramsValues6);
                    if (prescriptions == 0) {
                        prescriptions = genericClassService.fetchRecordCount(Newprescriptionitems.class, where6, params6, paramsValues6);
                    }
                    prescriptionitemsCount = prescriptionitemsCount + prescriptions;
                    prescriptionsRows.put("prescriptionitemsCount", prescriptionitemsCount);
                    prescriptionsRows.put("visitnumber", patientsvisit[1]);
                    prescriptionsRows.put("prescriptionid", prevousprescriptions.get(0)[0]);
                    prescriptionsRows.put("dateprescribed", formatter.format((Date) prevousprescriptions.get(0)[1]));

                    String[] params2 = {"facilityunitid"};
                    Object[] paramsValues2 = {prevousprescriptions.get(0)[3]};
                    String[] fields2 = {"facilityunitname", "facilityid"};
                    List<Object[]> facilityunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2, "WHERE facilityunitid=:facilityunitid", params2, paramsValues2);
                    if (facilityunit != null) {
                        String[] params4 = {"facilityid"};
                        Object[] paramsValues4 = {facilityunit.get(0)[1]};
                        String[] fields4 = {"facilityname"};
                        List<Object[]> facilitydetails = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields4, "WHERE facilityid=:facilityid", params4, paramsValues4);

                        prescriptionsRows.put("facilityname", facilitydetails.get(0));
                        prescriptionsRows.put("facilityunitname", facilityunit.get(0)[0]);
                    }
                    prescriptionsFound.add(prescriptionsRows);
                }
            }
        }
        model.addAttribute("prescriptionsFound", prescriptionsFound);
        return "doctorConsultations/views/prevousPrescriptions";
    }

    @RequestMapping(value = "/viewPrescribeddrugs.htm", method = RequestMethod.GET)
    public String viewPrescribeddrugs(Model model, HttpServletRequest request) {
        List<Map> prescriptiondrugsFound = new ArrayList<>();

        String[] params = {"prescriptionid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("prescriptionid"))};
        String[] fields = {"itemid", "dosage", "daysname", "days"};
        String where = "WHERE prescriptionid=:prescriptionid";
        List<Object[]> prescriptionitems = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields, where, params, paramsValues);
        if (prescriptionitems != null) {
            Map<String, Object> prescriptionitemsRows;
            for (Object[] prescriptionitem : prescriptionitems) {
                prescriptionitemsRows = new HashMap<>();
                String[] params2 = {"itemid"};
                Object[] paramsValues2 = {prescriptionitem[0]};
                String[] fields2 = {"genericname"};
                List<Object[]> fullname = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields2, "WHERE itemid=:itemid", params2, paramsValues2);
                if (fullname != null) {
                    prescriptionitemsRows.put("fullname", fullname.get(0));
                    prescriptionitemsRows.put("dosage", prescriptionitem[1]);
                    prescriptionitemsRows.put("days", prescriptionitem[3] + " " + prescriptionitem[2]);
                    prescriptiondrugsFound.add(prescriptionitemsRows);
                }
            }
        } else {
            fields = new String[]{"itemname", "dosage", "daysname", "days"};
            params = new String[]{"prescriptionid"};
            paramsValues = new Object[]{Long.parseLong(request.getParameter("prescriptionid"))};
            where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> newPrescriptionitems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (newPrescriptionitems != null) {
                Map<String, Object> prescriptionitemsRows;
                for (Object[] newPrescriptionitem : newPrescriptionitems) {
                    prescriptionitemsRows = new HashMap<>();
                    prescriptionitemsRows.put("fullname", newPrescriptionitem[0]);
                    prescriptionitemsRows.put("dosage", newPrescriptionitem[1]);
                    prescriptionitemsRows.put("days", newPrescriptionitem[3] + " " + newPrescriptionitem[2]);
                    prescriptiondrugsFound.add(prescriptionitemsRows);
                }
            }
        }
        model.addAttribute("prescriptiondrugsFound", prescriptiondrugsFound);
        return "doctorConsultations/views/drugs";
    }

    @RequestMapping(value = "/laboratoryhome.htm", method = RequestMethod.GET)
    public String laboratoryHome(Model model, HttpServletRequest request) {
        try {
            Set<Integer> tests = new HashSet<>();
            List<Map> laboratorytestclassificationsList = new ArrayList<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("tests"), List.class);
            if (!item.isEmpty()) {
                for (Integer test : item) {
                    tests.add(test);
                }
            }

            String[] params = {"parentid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("labtestclassificationid"))};
            String[] fields = {"labtestclassificationid", "labtestclassificationname", "description"};
            List<Object[]> labaratoryclassifications = (List<Object[]>) genericClassService.fetchRecord(Labtestclassification.class, fields, "WHERE parentid=:parentid", params, paramsValues);
            if (labaratoryclassifications != null) {
                Map<String, Object> labaratoryclassificationsRow;
                for (Object[] labaratoryclassification : labaratoryclassifications) {
                    labaratoryclassificationsRow = new HashMap<>();

                    labaratoryclassificationsRow.put("labtestclassificationid", labaratoryclassification[0]);
                    labaratoryclassificationsRow.put("labtestclassificationname", labaratoryclassification[1]);
                    labaratoryclassificationsRow.put("description", labaratoryclassification[2]);

                    List<Map> laboratorytestsList = new ArrayList<>();
                    String[] params3 = {"labtestclassificationid"};
                    Object[] paramsValues3 = {labaratoryclassification[0]};
                    String[] fields3 = {"laboratorytestid", "testname", "description", "testrange", "unitofmeasure"};
                    List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields3, "WHERE labtestclassificationid=:labtestclassificationid", params3, paramsValues3);

                    if (labtests != null) {
                        Map<String, Object> labaratorytestsRow;
                        for (Object[] labtest : labtests) {
                            labaratorytestsRow = new HashMap<>();
                            labaratorytestsRow.put("laboratorytestid", labtest[0]);
                            labaratorytestsRow.put("testname", labtest[1]);
                            labaratorytestsRow.put("description", labtest[2]);
                            labaratorytestsRow.put("testrange", labtest[3]);
                            labaratorytestsRow.put("unitofmeasure", labtest[4]);
                            laboratorytestsList.add(labaratorytestsRow);
                        }
                    }
                    labaratoryclassificationsRow.put("labaratorytestsList", laboratorytestsList);
                    labaratoryclassificationsRow.put("size", laboratorytestsList.size());

                    laboratorytestclassificationsList.add(labaratoryclassificationsRow);
                }
                model.addAttribute("act", "a");
            } else {

                String[] params1 = {"labtestclassificationid"};
                Object[] paramsValues1 = {Long.parseLong(request.getParameter("labtestclassificationid"))};
                String[] fields1 = {"laboratorytestid", "testname"};
                String where1 = "WHERE labtestclassificationid=:labtestclassificationid";
                List<Object[]> laboratorytests = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields1, where1, params1, paramsValues1);
                if (laboratorytests != null) {
                    Map<String, Object> labaratorytestsRow;
                    for (Object[] laboratorytest : laboratorytests) {
                        labaratorytestsRow = new HashMap<>();
                        if (!item.isEmpty() && item.contains(((Long) laboratorytest[0]).intValue())) {
                            labaratorytestsRow.put("assigned", true);
                        } else {
                            labaratorytestsRow.put("assigned", false);
                        }
                        labaratorytestsRow.put("laboratorytestid", laboratorytest[0]);
                        labaratorytestsRow.put("testname", laboratorytest[1]);
                        laboratorytestclassificationsList.add(labaratorytestsRow);
                    }
                }
                model.addAttribute("laboratorytestclassificationsList", laboratorytestclassificationsList);
                model.addAttribute("act", "b");
                model.addAttribute("classification", request.getParameter("name"));
            }
            model.addAttribute("laboratorytestclassificationsList", laboratorytestclassificationsList);

        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::" + e);
        }
        return "doctorConsultations/forms/laboratoryTests";
    }

    @RequestMapping(value = "/patientsgetupdatednumbers.htm", method = RequestMethod.GET)
    public String patientsgetupdatednumbers(Model model, HttpServletRequest request) {

        int totalpatients = 0;
        String[] params1 = {"dateadded", "addedby", "status", "originunit"};
        Object[] paramsValues1 = {new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), "SENT", request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields1 = {"laboratoryrequestid", "laboratoryrequestnumber"};
        String where1 = "WHERE dateadded=:dateadded AND addedby=:addedby AND status=:status AND originunit=:originunit";
        List<Object[]> patientlabrequests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields1, where1, params1, paramsValues1);
        if (patientlabrequests != null) {
            model.addAttribute("patientlabrequestssize", patientlabrequests.size());

        } else {
            model.addAttribute("patientlabrequestssize", 0);
        }
        String[] params = {"dateadded", "addedby", "status", "originunit"};
        Object[] paramsValues = {new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), "SERVICED", request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"laboratoryrequestid", "destinationunit"};
        List<Object[]> labrequestscount = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, "WHERE dateadded=:dateadded AND addedby=:addedby AND status=:status AND originunit=:originunit", params, paramsValues);
        if (labrequestscount != null) {
            model.addAttribute("patientlabresultssize", labrequestscount.size());

        } else {
            model.addAttribute("patientlabresultssize", 0);
        }

        String[] params2 = {"dateprescribed", "addedby", "originunitid"};
        Object[] paramsValues2 = {new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields2 = {"prescriptionid", "destinationunitid"};
        List<Object[]> prescriptionscount = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields2, "WHERE DATE(dateprescribed)=:dateprescribed AND addedby=:addedby AND originunitid=:originunitid", params2, paramsValues2);
        if (prescriptionscount != null) {
            model.addAttribute("patientprescriptionsize", prescriptionscount.size());

        } else {
            model.addAttribute("patientprescriptionsize", 0);
        }
        Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        String[] params5todaypat = {"facilityunitid", "dateadded"};
        Object[] paramsValuestodaypat = {BigInteger.valueOf(facilityunitId.longValue()), new Date()};
//        Object[] paramsValuestodaypat = {BigInteger.valueOf(facilityunitId.longValue()), formatter.format(new Date())};
        String[] fields5todaypat = {"patientvisitid"};
//        List<Long> objtodaypat = (List<Long>) genericClassService.fetchRecord(Patientvisit.class, fields5todaypat, "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params5todaypat, paramsValuestodaypat);
        List<Long> objtodaypat = (List<Long>) genericClassService.fetchRecord(Patientvisit.class, fields5todaypat, "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded", params5todaypat, paramsValuestodaypat);
        if (objtodaypat != null) {
            for (Long todaypat : objtodaypat) {
                String[] paramstriageid = {"servicekey"};
                Object[] paramsValuestriageid = {"key_consultation"};
                String[] fieldstriageid = {"serviceid"};
                List<Integer> patientsvisitstriageid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
                if (patientsvisitstriageid != null) {
                    String[] paramsu = {"serviceid", "facilityunit"};
                    Object[] paramValuesu = {patientsvisitstriageid, (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                    String[] fieldsu = {"facilityunitserviceid"};
                    String whereu = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                    List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fieldsu, whereu, paramsu, paramValuesu);
                    if (serviceid != null) {

                        String[] params6 = {"unitserviceid", "patientvisitid", "serviced"};
                        Object[] paramsValues6 = {serviceid.get(0), BigInteger.valueOf(todaypat), Boolean.TRUE};
                        String where6 = "WHERE unitserviceid=:unitserviceid AND patientvisitid=:patientvisitid AND serviced=:serviced";
                        int patients = genericClassService.fetchRecordCount(Servicequeue.class, where6, params6, paramsValues6);
                        totalpatients = +totalpatients + patients;
                    }
                }
            }
        }
        model.addAttribute("totalpatients", totalpatients);

        return "doctorConsultations/views/statistics";
    }

    @RequestMapping(value = "/sendPatientLabRequests.htm", method = RequestMethod.GET)
    public String sendPatientLabRequests(Model model, HttpServletRequest request) {
        List<Map> laboratoryunitsList = new ArrayList<>();

        String[] params3 = {"servicekey", "status", "facilityid"};
        Object[] paramsValues3 = {"key_laboratory", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacility")};
        String[] fields3 = {"facilityunitserviceid", "facilityunit.facilityunitid"};
        String where3 = "WHERE r.facilityservices.servicekey=:servicekey AND status=:status AND r.facilityunit.facilityid=:facilityid";
        List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields3, where3, params3, paramsValues3);
        if (facilityunitservices != null) {
            Map<String, Object> unitservice;
            for (Object[] facilityunitservice : facilityunitservices) {
                unitservice = new HashMap<>();

                String[] params = {"facilityunitid"};
                Object[] paramsValues = {facilityunitservice[1]};
                String[] fields = {"facilityunitid", "facilityunitname"};
                String where = "WHERE facilityunitid=:facilityunitid";
                List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                if (facilityunits != null) {
                    unitservice.put("facilityunitid", facilityunitservice[1]);
                    unitservice.put("facilityunitname", facilityunits.get(0)[1]);
                    laboratoryunitsList.add(unitservice);
                }
            }
        }
        model.addAttribute("labunitsFound", laboratoryunitsList);
        return "doctorConsultations/forms/laboratoryUnits";
    }

    @RequestMapping(value = "/savepatientlaboratorytestsandqueue.htm")
    public @ResponseBody
    String savepatientlaboratorytestsandqueue(HttpServletRequest request) {
        String results = "";
        List<Map> labunitsFound = new ArrayList<>();
        try {
            Laboratoryrequest laboratoryrequest = new Laboratoryrequest();
            int unit = ((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")) + 1;
            String labtestnumber = generatelabtestno(String.valueOf(unit), Long.parseLong(String.valueOf(((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));

            laboratoryrequest.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            laboratoryrequest.setDateadded(new Date());
            laboratoryrequest.setDestinationunit(Long.parseLong(request.getParameter("labunit")));
            laboratoryrequest.setLaboratoryrequestnumber(labtestnumber);
            laboratoryrequest.setStatus("SENT");
            laboratoryrequest.setOriginunit(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            laboratoryrequest.setPatientvisitid(Long.parseLong(request.getParameter("patientVisitsid")));
            Object save = genericClassService.saveOrUpdateRecordLoadObject(laboratoryrequest);
            if (save != null) {
                List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("tests"), List.class);
                for (Integer item1 : item) {
                    Laboratoryrequesttest laboratoryrequesttest = new Laboratoryrequesttest();
                    laboratoryrequesttest.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                    laboratoryrequesttest.setDateadded(new Date());
                    laboratoryrequesttest.setIscompleted(Boolean.FALSE);
                    laboratoryrequesttest.setLaboratoryrequestid(laboratoryrequest.getLaboratoryrequestid());
                    laboratoryrequesttest.setLaboratorytestid(Long.parseLong(String.valueOf(item1)));
                    genericClassService.saveOrUpdateRecordLoadObject(laboratoryrequesttest);

                }
                Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
                String[] params = {"facilityunitid", "status", "servicekey"};
                Object[] paramsValues = {Long.parseLong(request.getParameter("labunit")), Boolean.TRUE, "key_laboratory"};
                String[] fields = {"facilityunitserviceid", "facilityservices.serviceid", "facilityservices.servicename", "facilityservices.servicekey"};
                String where = "WHERE r.facilityunit.facilityunitid=:facilityunitid AND status=:status AND servicekey=:servicekey";
                List<Object[]> facilityunitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                Map<String, Object> resultsRow = new HashMap<>();
                if (facilityunitservices != null) {
                    resultsRow.put("facilityunitservicesid", facilityunitservices.get(0)[0]);
                }
                resultsRow.put("laboratoryrequestid", laboratoryrequest.getLaboratoryrequestid());
                resultsRow.put("staffid", staffid);
                resultsRow.put("laboratoryunit", laboratoryrequest.getDestinationunit());
                resultsRow.put("requestnumber", laboratoryrequest.getLaboratoryrequestnumber());
                labunitsFound.add(resultsRow);

                results = new ObjectMapper().writeValueAsString(labunitsFound);

            }

        } catch (Exception e) {
            System.out.println("::::::::::::" + e);
        }

        return results;
    }

    private String generatelabtestno(String facilityunit, Long originstoreid) {
        String name = facilityunit + "/";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String pattern = name + f.format(new Date()) + "/%";
        String facilitylabtestno = "";

        String[] params = {"originunit", "laboratoryrequestnumber"};
        Object[] paramsValues = {originstoreid, pattern};
        String[] fields = {"laboratoryrequestnumber"};
        String where = "WHERE originunit=:originunit AND laboratoryrequestnumber LIKE :laboratoryrequestnumber ORDER BY laboratoryrequestnumber DESC LIMIT 1";
        List<String> lastFacilitylabtestno = (List<String>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, where, params, paramsValues);
        if (lastFacilitylabtestno == null) {
            facilitylabtestno = name + f.format(new Date()) + "/0001";
            return facilitylabtestno;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilitylabtestno.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        facilitylabtestno = name + f.format(new Date()) + "/000" + newNo;
                        break;
                    case 2:
                        facilitylabtestno = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 3:
                        facilitylabtestno = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        facilitylabtestno = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return facilitylabtestno;
    }

    @RequestMapping(value = "/viewpreviousPatientLabTest.htm", method = RequestMethod.GET)
    public String viewpreviousPatientLabTest(Model model, HttpServletRequest request) {
        List<Map> laboratorytestsList = new ArrayList<>();

        String[] params3 = {"patientid", "patientvisitid"};
        Object[] paramsValues3 = {Long.parseLong(request.getParameter("patientid")), Long.parseLong(request.getParameter("patientVisitsid"))};
        String[] fields3 = {"patientvisitid", "dateadded", "visitnumber"};
        String where3 = "WHERE patientid=:patientid AND patientvisitid!=:patientvisitid";
        List<Object[]> previouslabtests = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields3, where3, params3, paramsValues3);
        if (previouslabtests != null) {
            Map<String, Object> resultsRow;
            for (Object[] previouslabtest : previouslabtests) {
                resultsRow = new HashMap<>();

                resultsRow.put("visitnumber", previouslabtest[2]);

                String[] params5 = {"patientvisitid"};
                Object[] paramsValues5 = {previouslabtest[0]};
                String[] fields5 = {"facilityid", "gender"};
                String where5 = "WHERE patientvisitid=:patientvisitid";
                List<Object[]> previouslabstests = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5, where5, params5, paramsValues5);
                if (previouslabstests != null) {

                    String[] params8 = {"facilityid"};
                    Object[] paramsValues8 = {previouslabstests.get(0)[0]};
                    String[] fields8 = {"facilityname"};
                    String where8 = "WHERE facilityid=:facilityid";
                    List<String> facilityname = (List<String>) genericClassService.fetchRecord(Facility.class, fields8, where8, params8, paramsValues8);
                    if (facilityname != null) {
                        resultsRow.put("facilityname", facilityname.get(0));
                    }
                }

                String[] params = {"patientvisitid"};
                Object[] paramsValues = {previouslabtest[0]};
                String[] fields = {"laboratoryrequestid", "laboratoryrequestnumber", "originunit", "dateadded", "status"};
                String where = "WHERE patientvisitid=:patientvisitid";
                List<Object[]> previoustests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, where, params, paramsValues);
                if (previoustests != null) {

                    String[] params6 = {"laboratoryrequestid"};
                    Object[] paramsValues6 = {previoustests.get(0)[0]};
                    String where6 = "WHERE laboratoryrequestid=:laboratoryrequestid";
                    int tests = genericClassService.fetchRecordCount(Laboratoryrequesttest.class, where6, params6, paramsValues6);

                    resultsRow.put("laboratoryrequestid", previoustests.get(0)[0]);
                    resultsRow.put("laboratoryrequestnumber", previoustests.get(0)[1]);
                    resultsRow.put("count", tests);
                    resultsRow.put("status", previoustests.get(0)[4]);
                    resultsRow.put("dateadded", formatter.format((Date) previoustests.get(0)[3]));
                    laboratorytestsList.add(resultsRow);
                }
            }
        }
        model.addAttribute("laboratorytestsList", laboratorytestsList);

        return "doctorConsultations/views/previousLaboratoryTests";
    }

    @RequestMapping(value = "/viewpatientslabrequests.htm", method = RequestMethod.GET)
    public String viewpatientslabrequests(Model model, HttpServletRequest request) {
        List<Map> laboratoryrequestsList = new ArrayList<>();
        String[] params = {"dateadded", "addedby", "originunit", "status"};
        Object[] paramsValues = {new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), "SENT"};
        String[] fields = {"laboratoryrequestid", "laboratoryrequestnumber", "originunit", "patientvisitid", "destinationunit"};
        String where = "WHERE dateadded=:dateadded AND addedby=:addedby AND originunit=:originunit AND status=:status";
        List<Object[]> patientlabrequests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, where, params, paramsValues);
        if (patientlabrequests != null) {
            Map<String, Object> requestsRow;
            for (Object[] patientlabrequest : patientlabrequests) {
                requestsRow = new HashMap<>();
                requestsRow.put("laboratoryrequestnumber", patientlabrequest[1]);
                requestsRow.put("laboratoryrequestid", patientlabrequest[0]);
                requestsRow.put("patientvisitid", patientlabrequest[3]);

                String[] params3 = {"patientvisitid"};
                Object[] paramsValues3 = {patientlabrequest[3]};
                String[] fields3 = {"visitnumber", "patientid"};
                String where3 = "WHERE patientvisitid =:patientvisitid";
                List<Object[]> patientvisit = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields3, where3, params3, paramsValues3);
                if (patientvisit != null) {
                    String[] params4 = {"patientid"};
                    Object[] paramsValues4 = {patientvisit.get(0)[1]};
                    String[] fields4 = {"firstname", "lastname", "othernames", "patientno"};
                    String where4 = "WHERE patientid=:patientid";
                    List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields4, where4, params4, paramsValues4);
                    if (patientdetails != null) {
                        requestsRow.put("patientname", patientdetails.get(0)[0] + " " + patientdetails.get(0)[1] + " " + patientdetails.get(0)[2]);
                        requestsRow.put("patientno", patientdetails.get(0)[3]);
                        requestsRow.put("visitnumber", patientvisit.get(0)[0]);
                        requestsRow.put("patientid", patientvisit.get(0)[1]);
                    }
                }
                String[] params6 = {"laboratoryrequestid"};
                Object[] paramsValues6 = {patientlabrequest[0]};
                String where6 = "WHERE laboratoryrequestid=:laboratoryrequestid";
                int labrequestscount = genericClassService.fetchRecordCount(Laboratoryrequesttest.class, where6, params6, paramsValues6);

                requestsRow.put("labrequestscount", labrequestscount);

                String[] params4 = {"facilityunitid"};
                Object[] paramsValues4 = {patientlabrequest[4]};
                String[] fields4 = {"facilityunitname", "shortname"};
                String where4 = "WHERE facilityunitid=:facilityunitid";
                List<Object[]> facilityunitname = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
                if (facilityunitname != null) {
                    requestsRow.put("facilityunitname", facilityunitname.get(0)[0]);
                }
                laboratoryrequestsList.add(requestsRow);

            }
        }
        model.addAttribute("laboratoryrequestsList", laboratoryrequestsList);
        return "doctorConsultations/views/patientsLaboratoryRequests";
    }

    @RequestMapping(value = "/viewpatientslabreqtests.htm", method = RequestMethod.GET)
    public String viewpatientslabreqtests(Model model, HttpServletRequest request) {
        List<Map> laboratoryrequesttestList = new ArrayList<>();

        String[] params = {"laboratoryrequestid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("laboratoryrequestid"))};
        String[] fields = {"laboratoryrequesttestid", "laboratorytestid", "testresult"};
        String where = "WHERE laboratoryrequestid=:laboratoryrequestid";
        List<Object[]> patientlabrequests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields, where, params, paramsValues);
        if (patientlabrequests != null) {
            Map<String, Object> requesttestsRow;
            for (Object[] patientlabrequest : patientlabrequests) {
                requesttestsRow = new HashMap<>();
                if (patientlabrequest[2] != null) {
                    requesttestsRow.put("tested", true);
                } else {
                    requesttestsRow.put("tested", false);
                }
                String[] params4 = {"laboratorytestid"};
                Object[] paramsValues4 = {patientlabrequest[1]};
                String[] fields4 = {"testname"};
                String where4 = "WHERE laboratorytestid=:laboratorytestid";
                List<String> testname = (List<String>) genericClassService.fetchRecord(Laboratorytest.class, fields4, where4, params4, paramsValues4);
                if (testname != null) {
                    requesttestsRow.put("testname", testname.get(0));
                    requesttestsRow.put("laboratoryrequesttestid", patientlabrequest[0]);
                    laboratoryrequesttestList.add(requesttestsRow);
                }
            }
        }
        model.addAttribute("laboratoryrequesttestList", laboratoryrequesttestList);
        return "doctorConsultations/views/PatientLabTests";
    }

    @RequestMapping(value = "/viewpatientmadeprescriptions.htm", method = RequestMethod.GET)
    public String viewpatientmadeprescriptions(Model model, HttpServletRequest request) {
        List<Map> prescribedpatientsList = new ArrayList<>();

        String[] params2 = {"dateprescribed", "addedby", "originunitid"};
        Object[] paramsValues2 = {new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields2 = {"prescriptionid", "destinationunitid", "patientvisitid"};
        List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields2, "WHERE DATE(dateprescribed)=:dateprescribed AND addedby=:addedby AND originunitid=:originunitid", params2, paramsValues2);
        if (prescriptions != null) {
            Map<String, Object> prescriptionsRow;
            for (Object[] prescription : prescriptions) {
                prescriptionsRow = new HashMap<>();
                prescriptionsRow.put("prescriptionid", prescription[0]);

                String[] params4 = {"facilityunitid"};
                Object[] paramsValues4 = {prescription[1]};
                String[] fields4 = {"facilityunitname", "shortname"};
                String where4 = "WHERE facilityunitid=:facilityunitid";
                List<Object[]> facilityunitname = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
                if (facilityunitname != null) {
                    prescriptionsRow.put("facilityunitname", facilityunitname.get(0)[0]);
                }
                String[] params3 = {"patientvisitid"};
                Object[] paramsValues3 = {prescription[2]};
                String[] fields3 = {"visitnumber", "patientid"};
                String where3 = "WHERE patientvisitid =:patientvisitid";
                List<Object[]> patientvisit = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields3, where3, params3, paramsValues3);
                if (patientvisit != null) {
                    String[] params5 = {"patientid"};
                    Object[] paramsValues5 = {patientvisit.get(0)[1]};
                    String[] fields5 = {"firstname", "lastname", "othernames", "patientno"};
                    String where5 = "WHERE patientid=:patientid";
                    List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields5, where5, params5, paramsValues5);
                    if (patientdetails != null) {
                        prescriptionsRow.put("patientname", patientdetails.get(0)[0] + " " + patientdetails.get(0)[1] + " " + patientdetails.get(0)[2]);
                        prescriptionsRow.put("patientno", patientdetails.get(0)[3]);
                        prescriptionsRow.put("visitnumber", patientvisit.get(0)[0]);
                    }
                    String[] params6 = {"prescriptionid"};
                    Object[] paramsValues6 = {prescription[0]};
                    String where6 = "WHERE prescriptionid=:prescriptionid";
                    int prescriptionsitemscount = genericClassService.fetchRecordCount(Prescriptionitems.class, where6, params6, paramsValues6);
                    if (prescriptionsitemscount == 0) {
                        prescriptionsitemscount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where6, params6, paramsValues6);
                    }
                    prescriptionsRow.put("prescriptionsitemscount", prescriptionsitemscount);
                    prescribedpatientsList.add(prescriptionsRow);
                }
            }
        }
        model.addAttribute("prescribedpatientsList", prescribedpatientsList);
        return "doctorConsultations/views/prescribedPatients";
    }

    @RequestMapping(value = "/viewPatientslaboratoryresultsback.htm", method = RequestMethod.GET)
    public String viewPatientslaboratoryresultsback(Model model, HttpServletRequest request) {
        List<Map> labpatientsList = new ArrayList<>();

        String[] params = {"dateadded", "addedby", "status", "originunit"};
        Object[] paramsValues = {new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), "SERVICED", request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"laboratoryrequestid", "destinationunit", "patientvisitid", "lastupdatedby", "laboratoryrequestnumber"};
        List<Object[]> labresults = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, "WHERE dateadded=:dateadded AND addedby=:addedby AND status=:status AND originunit=:originunit", params, paramsValues);
        if (labresults != null) {
            Map<String, Object> labresultsRow;
            for (Object[] labresult : labresults) {
                labresultsRow = new HashMap<>();
                labresultsRow.put("laboratoryrequestnumber", labresult[4]);
                labresultsRow.put("laboratoryrequestid", labresult[0]);
                labresultsRow.put("patientvisitid", labresult[2]);

                String[] params3 = {"patientvisitid"};
                Object[] paramsValues3 = {labresult[2]};
                String[] fields3 = {"visitnumber", "patientid"};
                String where3 = "WHERE patientvisitid =:patientvisitid";
                List<Object[]> patientvisit = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields3, where3, params3, paramsValues3);
                if (patientvisit != null) {
                    String[] params4 = {"patientid"};
                    Object[] paramsValues4 = {patientvisit.get(0)[1]};
                    String[] fields4 = {"firstname", "lastname", "othernames", "patientno", "patientid"};
                    String where4 = "WHERE patientid=:patientid";
                    List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields4, where4, params4, paramsValues4);
                    if (patientdetails != null) {
                        labresultsRow.put("patientname", patientdetails.get(0)[0] + " " + patientdetails.get(0)[1] + " " + patientdetails.get(0)[2]);
                        labresultsRow.put("patientno", patientdetails.get(0)[3]);
                        labresultsRow.put("visitnumber", patientvisit.get(0)[0]);
                        labresultsRow.put("patientid", patientdetails.get(0)[4]);
                    }
                }
                String[] params6 = {"laboratoryrequestid"};
                Object[] paramsValues6 = {labresult[0]};
                String where6 = "WHERE laboratoryrequestid=:laboratoryrequestid";
                int labrequestscount = genericClassService.fetchRecordCount(Laboratoryrequesttest.class, where6, params6, paramsValues6);

                labresultsRow.put("labrequestscount", labrequestscount);

                String[] params4 = {"facilityunitid"};
                Object[] paramsValues4 = {labresult[1]};
                String[] fields4 = {"facilityunitname", "shortname"};
                String where4 = "WHERE facilityunitid=:facilityunitid";
                List<Object[]> facilityunitname = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
                if (facilityunitname != null) {
                    labresultsRow.put("facilityunitname", facilityunitname.get(0)[0]);
                }
                String[] params5 = {"staffid"};
                Object[] paramsValues5 = {BigInteger.valueOf((Long) labresult[3])};
                String[] fields5 = {"firstname", "othernames", "lastname"};
                String where5 = "WHERE staffid=:staffid";
                List<Object[]> servicedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, where5, params5, paramsValues5);
                if (servicedby != null) {
                    labresultsRow.put("servicedby", servicedby.get(0)[0] + " " + servicedby.get(0)[1] + " " + servicedby.get(0)[2]);
                }
                labpatientsList.add(labresultsRow);
            }
        }
        model.addAttribute("labpatientsList", labpatientsList);
        return "doctorConsultations/laboratory/views/laboratoryPatients";
    }

    @RequestMapping(value = "/patientfromlaboratorydetails.htm", method = RequestMethod.GET)
    public String patientfromlaboratorydetails(Model model, HttpServletRequest request) {
        List<Map> labpatienttestsList = new ArrayList<>();

        String[] params = {"patientid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fields = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin"};
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
        if (patientsvisits != null) {
            String[] params5 = {"personid"};
            Object[] paramsValues5 = {patientsvisits.get(0)[0]};
            String[] fields5 = {"dob", "estimatedage", "gender"};
            List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5, "WHERE personid=:personid", params5, paramsValues5);

            model.addAttribute("name", patientsvisits.get(0)[1] + " " + patientsvisits.get(0)[3] + " " + patientsvisits.get(0)[2]);
            model.addAttribute("patientno", patientsvisits.get(0)[4]);
            model.addAttribute("telephone", patientsvisits.get(0)[5]);
            model.addAttribute("nextofkin", patientsvisits.get(0)[6]);
            model.addAttribute("dob", formatter.format((Date) patientdetails.get(0)[0]));

            model.addAttribute("gender", patientdetails.get(0)[2]);

            SimpleDateFormat df = new SimpleDateFormat("yyyy");
            int year = Integer.parseInt(df.format((Date) patientdetails.get(0)[0]));
            int currentyear = Integer.parseInt(df.format(new Date()));
            model.addAttribute("estimatedage", currentyear - year);

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }
        String[] params1 = {"laboratoryrequestid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("laboratoryrequestid"))};
        String[] fields1 = {"testresult", "laboratorytestid"};
        String where1 = "WHERE laboratoryrequestid=:laboratoryrequestid";
        List<Object[]> patientlabtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields1, where1, params1, paramsValues1);
        if (patientlabtests != null) {
            Map<String, Object> labresultsRow;
            for (Object[] patientlabtest : patientlabtests) {
                labresultsRow = new HashMap<>();

                String[] params4 = {"laboratorytestid"};
                Object[] paramsValues4 = {patientlabtest[1]};
                String[] fields4 = {"testname"};
                String where4 = "WHERE laboratorytestid=:laboratorytestid";
                List<String> teste = (List<String>) genericClassService.fetchRecord(Laboratorytest.class, fields4, where4, params4, paramsValues4);
                if (teste != null) {
                    labresultsRow.put("testname", teste.get(0));
                    labresultsRow.put("testresult", patientlabtest[0]);
                    labpatienttestsList.add(labresultsRow);
                }
            }
        }
        model.addAttribute("labpatienttestsList", labpatienttestsList);
        model.addAttribute("servicedby", request.getParameter("servicedby"));
        model.addAttribute("facilityunitname", request.getParameter("facilityunitname"));
        model.addAttribute("date", formatter.format(new Date()));
        model.addAttribute("laboratoryrequestnumber", request.getParameter("laboratoryrequestnumber"));

        return "doctorConsultations/laboratory/views/labPatientVitals";
    }

    @RequestMapping(value = "/patientsvitalsandallergies.htm", method = RequestMethod.GET)
    public String patientsvitalsandallergies(Model model, HttpServletRequest request) {
        String[] params1 = {"patientvisitid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields1 = {"weight", "temperature", "height", "pulse", "headcircum", "bodysurfacearea", "respirationrate", "patientpressuresystolic", "patientpressurediastolic"};
        String where1 = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patienttriages = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields1, where1, params1, paramsValues1);
        if (patienttriages != null) {
            if (patienttriages.get(0)[0] != null) {
                model.addAttribute("weight", patienttriages.get(0)[0] + " " + "Kg");
            } else {
                model.addAttribute("weight", "pending");
            }
            if (patienttriages.get(0)[1] != null) {
                model.addAttribute("temperature", patienttriages.get(0)[1] + " " + "");
            } else {
                model.addAttribute("temperature", "pending");
            }
            if (patienttriages.get(0)[2] != null) {
                model.addAttribute("height", patienttriages.get(0)[2] + " " + "cm");
            } else {
                model.addAttribute("height", "pending");
            }
            if (patienttriages.get(0)[3] != null) {
                model.addAttribute("pulse", patienttriages.get(0)[3] + " " + "");
            } else {
                model.addAttribute("pulse", "pending");
            }
            if (patienttriages.get(0)[4] != null) {
                model.addAttribute("headcircum", patienttriages.get(0)[4] + " " + "");
            } else {
                model.addAttribute("headcircum", "pending");
            }
            if (patienttriages.get(0)[5] != null) {
                model.addAttribute("bodysurfacearea", patienttriages.get(0)[5] + " " + "");
            } else {
                model.addAttribute("bodysurfacearea", "pending");
            }
            if (patienttriages.get(0)[6] != null) {
                model.addAttribute("respirationrate", patienttriages.get(0)[6] + " " + "");
            } else {
                model.addAttribute("respirationrate", "pending");
            }
            if (patienttriages.get(0)[7] != null && patienttriages.get(0)[7] != null) {
                model.addAttribute("bloodpressure", patienttriages.get(0)[7] + "/" + patienttriages.get(0)[7] + " " + "mm Hg");
            } else {
                model.addAttribute("bloodpressure", "pending");
            }
            if (patienttriages.get(0)[2] != null && patienttriages.get(0)[0] != null) {
                model.addAttribute("bmi", (Double) patienttriages.get(0)[0] / ((((Double) patienttriages.get(0)[2]) * 0.01) * (((Double) patienttriages.get(0)[2]) * 0.01)) + " " + "");
            } else {
                model.addAttribute("bmi", "pending");
            }
        } else {
            model.addAttribute("bmi", "pending");
            model.addAttribute("bloodpressure", "pending");
            model.addAttribute("respirationrate", "pending");
            model.addAttribute("bodysurfacearea", "pending");
            model.addAttribute("headcircum", "pending");
            model.addAttribute("pulse", "pending");
            model.addAttribute("height", "pending");
            model.addAttribute("temperature", "pending");
            model.addAttribute("weight", "pending");

        }
        return "doctorConsultations/laboratory/forms/labPatientAllergiesandVitals";
    }

    @RequestMapping(value = "/labprescriptionhome.htm", method = RequestMethod.GET)
    public String labprescriptionhome(Model model, HttpServletRequest request) {
        long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        String results_view = "";
        String[] params7 = {"patientvisitid", "addedby", "dateprescribed", "status"};
        Object[] paramsValues7 = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginStaffid"), new Date(), "SENT"};
        String[] fields7 = {"prescriptionid", "destinationunitid", "addedby", "dateprescribed"};
        String where7 = "WHERE patientvisitid =:patientvisitid AND addedby=:addedby AND DATE(dateprescribed)=:dateprescribed AND status=:status";
        List<Object[]> patientsvisitprescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields7, where7, params7, paramsValues7);
        if (patientsvisitprescriptions != null) {

        } else {
            int prevousPrescriptions = 0;
            String[] params = {"patientid", "patientvisitid"};
            Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid"))), BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid")))};
            String[] fields = {"patientvisitid", "visitnumber"};
            String where = "WHERE patientid=:patientid AND patientvisitid!=:patientvisitid";
            List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Patientvisits.class, fields, where, params, paramsValues);
            if (patientsvisits != null) {
                for (Object[] patientsvisit : patientsvisits) {

                    String[] params6 = {"patientvisitid"};
                    Object[] paramsValues6 = {patientsvisit[0]};
                    String where6 = "WHERE patientvisitid=:patientvisitid";
                    int prescriptions = genericClassService.fetchRecordCount(Prescription.class, where6, params6, paramsValues6);

                    prevousPrescriptions = prevousPrescriptions + prescriptions;

                }
            }
            model.addAttribute("prevousPrescriptions", prevousPrescriptions);
            List<Map> doctorprescriptionHomesFound = new ArrayList<>();
            String[] params1 = {"issupplies"};
            Object[] paramsValues1 = {Boolean.FALSE};
            String[] fields1 = {"itemid", "genericname"};
            String where1 = "WHERE issupplies=:issupplies";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields1, where1, params1, paramsValues1);
            if (items != null) {
                Map<String, Object> itemsRow;
                for (Object[] item : items) {
                    itemsRow = new HashMap<>();
//                    itemsRow.put("itemid", item[0]);
                    itemsRow.put("itemid", item[1]);
                    itemsRow.put("fullname", item[1]);
                    doctorprescriptionHomesFound.add(itemsRow);
                }
            }

            model.addAttribute("ItemsFound", doctorprescriptionHomesFound);
            model.addAttribute("facilityid", facilityId);
            results_view = "doctorConsultations/laboratory/forms/prescription";
        }
        return results_view;
    }

    @RequestMapping(value = "/labprescriptionform.htm", method = RequestMethod.GET)
    public String labprescriptionform(Model model, HttpServletRequest request) {
        List<Map> doctorprescriptionHomesFound = new ArrayList<>();
        List<Map<String, Object>> specialInstructions = new ArrayList<>(); //
        try {
            if ("a".equals(request.getParameter("act"))) {
                String[] params = {"issupplies"};
                Object[] paramsValues = {Boolean.FALSE};
//                String[] fields = {"itemid", "genericname"};
//                String where = "WHERE issupplies=:issupplies";
//                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                String[] fields = {"genericname"};
                String where = "WHERE issupplies=:issupplies GROUP BY genericname";
                List<Object> items = (List<Object>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                if (items != null) {
                    Map<String, Object> itemsRow;
//                    for (Object[] item : items) {
                    for (Object item : items) {
                        itemsRow = new HashMap<>();
//                        itemsRow.put("itemid", item[0]);
//                        itemsRow.put("itemid", item[1]);
//                        itemsRow.put("fullname", item[1]);
                        itemsRow.put("itemid", item.toString());
                        itemsRow.put("fullname", item.toString());
                        doctorprescriptionHomesFound.add(itemsRow);
                    }
                }
            } else {
//                Set<Long> items = new HashSet<>();
                Set<String> items = new HashSet<>();
//                List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescribedItems"), List.class);
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescribedItems"), List.class);
//                for (Integer itemid : item) {
                for (String itemid : item) {
//                    items.add(Long.parseLong(String.valueOf(itemid)));
                    items.add(itemid);
                }
                String[] params = {"issupplies"};
                Object[] paramsValues = {Boolean.FALSE};
//                String[] fields = {"itemid", "genericname"};
//                String where = "WHERE issupplies=:issupplies";
//                List<Object[]> itemss = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                String[] fields = {"genericname"};
                String where = "WHERE issupplies=:issupplies GROUP BY genericname";
                List<Object> itemss = (List<Object>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                if (itemss != null) {
                    Map<String, Object> itemsRow;
//                    for (Object[] itemz : itemss) {
                    for (Object itemz : itemss) { 
                        itemsRow = new HashMap<>();
//                        if (items.isEmpty() || !items.contains(((BigInteger) itemz[0]).longValue())) {
//                        if (items.isEmpty() || !items.contains((itemz[1]).toString().replaceAll("[^a-zA-Z0-9]", ""))) {
////                            itemsRow.put("itemid", itemz[0]);
//                            itemsRow.put("itemid", itemz[1]);
//                            itemsRow.put("fullname", itemz[1]);
//                            doctorprescriptionHomesFound.add(itemsRow);
//                        }
                        if (items.isEmpty() || !items.contains((itemz).toString())) {
                                itemsRow.put("itemid", itemz.toString());
                                itemsRow.put("fullname", itemz.toString());
                                if(!doctorprescriptionHomesFound.contains(itemsRow)){
                                    doctorprescriptionHomesFound.add(itemsRow);
                                }
                        }
                    }
                }
            }
            //
            String [] fields = { "specialinstructionsid", "specialinstruction" };
            String where = "";
            String [] params = null;
            Object [] paramsValues = null;
            List<Object[]> instructions = (List<Object[]>) genericClassService.fetchRecord(Specialinstructions.class, fields, where, params, paramsValues);
            if(instructions != null){
                Map<String, Object> specialInstruction;
                for(Object[] instruction : instructions){
                    specialInstruction = new HashMap<>();
                    specialInstruction.put("specialinstructionsid", instruction[0]);
                    specialInstruction.put("specialinstruction", instruction[1].toString());
                    specialInstructions.add(specialInstruction);
                }
            }
            //
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::" + e);
        }
        model.addAttribute("specialInstructions", specialInstructions);
        model.addAttribute("ItemsFound", doctorprescriptionHomesFound);
        return "doctorConsultations/laboratory/forms/prescriptionform";
    }

    @RequestMapping(value = "/gettodaysreceivedpatients.htm", method = RequestMethod.GET)
    public String gettodaysreceivedpatients(Model model, HttpServletRequest request) {
        List<Map> patientsFound = new ArrayList<>();
        String results_view = "";
        try {
            model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
            Date date;
            if ("a".equals(request.getParameter("act"))) {
                results_view = "doctorConsultations/views/patientRegister";
            } else {
                date = formatter.parse(request.getParameter("date"));

                String[] params = {"facilityunitid", "servicekey"};
                Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), "key_consultation"};
                String[] fields = {"facilityunitserviceid"};
                String where = "WHERE facilityunitid=:facilityunitid AND r.facilityservices.servicekey=:servicekey";
                List<Long> unitservices = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                if (unitservices != null) {
                    String[] params5 = {"facilityunitserviceid", "timein", "canceled", "serviced"};
//                    Object[] paramsValues5 = {BigInteger.valueOf(unitservices.get(0)), formatter.format(date), Boolean.FALSE, Boolean.TRUE};
                    Object[] paramsValues5 = {BigInteger.valueOf(unitservices.get(0)), date, Boolean.FALSE, Boolean.TRUE};
                    String[] fields5 = {"servicequeueid", "patientvisitid.patientvisitid", "servicedby"};
//                    String where5 = "WHERE  unitserviceid=:facilityunitserviceid AND to_char(timein, 'DD-MM-YYYY')=:timein AND canceled=:canceled AND serviced=:serviced";
                    String where5 = "WHERE  unitserviceid=:facilityunitserviceid AND DATE(timein)=:timein AND canceled=:canceled AND serviced=:serviced";
                    List<Object[]> servicedpatients = (List<Object[]>) genericClassService.fetchRecord(Servicequeue.class, fields5, where5, params5, paramsValues5);
                    if (servicedpatients != null) {
                        Map<String, Object> patientsRow;
                        for (Object[] servicedpatient : servicedpatients) {
                            patientsRow = new HashMap<>();

                            int labrequests = 0;
                            int clinicalnotes = 0;
                            int prescriptions = 0;
                            int internalreferral = 0;
                            int vitals = 0;
                            String servicedbyvale = "";

                            String[] params6 = {"patientvisitid"};
                            Object[] paramsValues6 = {servicedpatient[1]};
                            String[] fields6 = {"visitnumber", "fullname", "patientno", "gender", "villagename", "parishname", "age", "patientid"};
                            String where6 = "WHERE patientvisitid=:patientvisitid";
                            List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields6, where6, params6, paramsValues6);
                            if (patientdetails != null) {

                                String[] params8 = {"originunit", "patientvisitid"};
                                Object[] paramsValues8 = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), servicedpatient[1]};
                                String where8 = "WHERE originunit=:originunit AND patientvisitid=:patientvisitid";
                                labrequests = genericClassService.fetchRecordCount(Laboratoryrequest.class, where8, params8, paramsValues8);

                                String[] params9 = {"facilityunitid", "patientvisitid"};
                                Object[] paramsValues9 = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), servicedpatient[1]};
                                String where9 = "WHERE facilityunitid=:facilityunitid AND patientvisitid=:patientvisitid";
                                clinicalnotes = genericClassService.fetchRecordCount(Patientcomplaint.class, where9, params9, paramsValues9);

                                String[] params4 = {"originunitid", "patientvisitid"};
                                Object[] paramsValues4 = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), servicedpatient[1]};
                                String where4 = "WHERE originunitid=:originunitid AND patientvisitid=:patientvisitid";
                                prescriptions = genericClassService.fetchRecordCount(Prescription.class, where4, params4, paramsValues4);

                                String[] params41 = {"referringunitid", "patientvisitid"};
                                Object[] paramsValues41 = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), servicedpatient[1]};
                                String where41 = "WHERE referringunitid=:referringunitid AND patientvisitid=:patientvisitid";
                                internalreferral = genericClassService.fetchRecordCount(Internalreferral.class, where41, params41, paramsValues41);

                                String[] params51 = {"patientvisitid"};
                                Object[] paramsValues51 = {servicedpatient[1]};
                                String where51 = "WHERE patientvisitid=:patientvisitid";
                                vitals = genericClassService.fetchRecordCount(Triage.class, where51, params51, paramsValues51);

                                String[] paramsg = {"staffid"};
                                Object[] paramsValuesg = {servicedpatient[2]};
                                String[] fieldsg = {"firstname", "othernames", "lastname"};
                                String whereg = "WHERE staffid=:staffid";
                                List<Object[]> servicedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsg, whereg, paramsg, paramsValuesg);
                                if (servicedby != null) {
                                    servicedbyvale = servicedby.get(0)[0] + " " + servicedby.get(0)[1] + " " + servicedby.get(0)[2];
                                }

                                if ("allPatients".equals(request.getParameter("type"))) {
                                    patientsRow.put("patientvisitid", servicedpatient[1]);
                                    patientsRow.put("visitnumber", patientdetails.get(0)[0]);
                                    patientsRow.put("fullname", patientdetails.get(0)[1]);
                                    patientsRow.put("patientno", patientdetails.get(0)[2]);
                                    patientsRow.put("gender", patientdetails.get(0)[3]);
                                    patientsRow.put("villagename", patientdetails.get(0)[4]);
                                    patientsRow.put("parishname", patientdetails.get(0)[5]);
                                    patientsRow.put("age", patientdetails.get(0)[6]);
                                    patientsRow.put("patientid", patientdetails.get(0)[7]);
                                    patientsRow.put("labrequests", labrequests);
                                    patientsRow.put("clinicalnotes", clinicalnotes);
                                    patientsRow.put("prescriptions", prescriptions);
                                    patientsRow.put("internalreferral", internalreferral);
                                    patientsRow.put("servicedby", servicedbyvale);

                                    patientsRow.put("vitals", vitals);

                                    patientsFound.add(patientsRow);
                                }
                                if ("attended".equals(request.getParameter("type"))) {
                                    if (vitals != 0 || clinicalnotes != 0 || labrequests != 0 || internalreferral != 0 || prescriptions != 0) {
                                        patientsRow.put("patientvisitid", servicedpatient[1]);
                                        patientsRow.put("visitnumber", patientdetails.get(0)[0]);
                                        patientsRow.put("fullname", patientdetails.get(0)[1]);
                                        patientsRow.put("patientno", patientdetails.get(0)[2]);
                                        patientsRow.put("gender", patientdetails.get(0)[3]);
                                        patientsRow.put("villagename", patientdetails.get(0)[4]);
                                        patientsRow.put("parishname", patientdetails.get(0)[5]);
                                        patientsRow.put("age", patientdetails.get(0)[6]);
                                        patientsRow.put("patientid", patientdetails.get(0)[7]);
                                        patientsRow.put("labrequests", labrequests);
                                        patientsRow.put("clinicalnotes", clinicalnotes);
                                        patientsRow.put("prescriptions", prescriptions);
                                        patientsRow.put("internalreferral", internalreferral);
                                        patientsRow.put("servicedby", servicedbyvale);

                                        patientsRow.put("vitals", vitals);

                                        patientsFound.add(patientsRow);
                                    }
                                }
                                if ("unattended".equals(request.getParameter("type"))) {
                                    if (vitals == 0 && clinicalnotes == 0 && labrequests == 0 && internalreferral == 0 && prescriptions == 0) {
                                        patientsRow.put("patientvisitid", servicedpatient[1]);
                                        patientsRow.put("visitnumber", patientdetails.get(0)[0]);
                                        patientsRow.put("fullname", patientdetails.get(0)[1]);
                                        patientsRow.put("patientno", patientdetails.get(0)[2]);
                                        patientsRow.put("gender", patientdetails.get(0)[3]);
                                        patientsRow.put("villagename", patientdetails.get(0)[4]);
                                        patientsRow.put("parishname", patientdetails.get(0)[5]);
                                        patientsRow.put("age", patientdetails.get(0)[6]);
                                        patientsRow.put("patientid", patientdetails.get(0)[7]);
                                        patientsRow.put("labrequests", labrequests);
                                        patientsRow.put("clinicalnotes", clinicalnotes);
                                        patientsRow.put("prescriptions", prescriptions);
                                        patientsRow.put("internalreferral", internalreferral);
                                        patientsRow.put("servicedby", servicedbyvale);

                                        patientsRow.put("vitals", vitals);

                                        patientsFound.add(patientsRow);
                                    }
                                }

                            }
                        }
                    }
                }
                model.addAttribute("patientsFound", patientsFound);
                model.addAttribute("date", formatter.format(date));
                results_view = "doctorConsultations/views/Register";
            }

        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::::::::" + e);
        }

        return results_view;
    }

    @RequestMapping(value = "/internalreferral.htm", method = RequestMethod.GET)
    public String internalreferral(Model model, HttpServletRequest request) {
        List<Map> unitsFound = new ArrayList<>();
        String results_view = "";
        Set<Long> units = new HashSet<>();
        //
        long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        //

        String[] params = {"facilityid", "active", "status"};
        Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE, Boolean.TRUE};
        String[] fields = {"facilityunit.facilityunitid", "facilityunit.facilityunitname", "facilityunitserviceid"};
        String where = "WHERE r.facilityunit.facilityid=:facilityid AND r.facilityunit.active=:active AND status=:status";
        List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
        Map<String, Object> unitsRow;
        if (facilityunits != null) {
            for (Object[] facilityunit : facilityunits) {
                unitsRow = new HashMap<>();
                if (((Long) facilityunit[0]).intValue() != (int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit") && !units.contains((Long) facilityunit[0])) {
                    unitsRow.put("facilityunitid", facilityunit[0]);
                    unitsRow.put("facilityunitname", facilityunit[1]);
//                    unitsRow.put("facilityunitserviceid", facilityunit[2]);
                    fields = new String[]{"facilityunitserviceid"};
                    params = new String[]{"facilityunitid", "active", "servicekey"};
                    paramsValues = new Object[]{Long.parseLong(facilityunit[0].toString()), Boolean.TRUE, "key_consultation"};
                    where = "WHERE facilityunitid=:facilityunitid AND active=:active AND servicekey=:servicekey";
                    List<Object> facilityUnitServiceIds = ((List<Object>) genericClassService.fetchRecord(Facilityunitservicesview.class, fields, where, params, paramsValues));
                    if (facilityUnitServiceIds == null || facilityUnitServiceIds.get(0) == null) {
                        paramsValues = new Object[]{Long.parseLong(facilityunit[0].toString()), Boolean.TRUE, "key_triage"};
                        where = "WHERE facilityunitid=:facilityunitid AND active=:active AND servicekey=:servicekey";
                        facilityUnitServiceIds = ((List<Object>) genericClassService.fetchRecord(Facilityunitservicesview.class, fields, where, params, paramsValues));
                    }
                    if (facilityUnitServiceIds != null && facilityUnitServiceIds.get(0) != null) {
                        unitsRow.put("facilityunitserviceid", Long.parseLong(facilityUnitServiceIds.get(0).toString()));
                    } else {
                        unitsRow.put("facilityunitserviceid", facilityunit[2]);
                    }
                    units.add((Long) facilityunit[0]);

                    unitsFound.add(unitsRow);
                }

            }
        }
        model.addAttribute("unitsFound", unitsFound);
        //
        model.addAttribute("facilityid", facilityId);
        //
        if ("a".equals(request.getParameter("act"))) {
            results_view = "doctorConsultations/forms/internalReferrals";
        } else {
            results_view = "doctorConsultations/laboratory/forms/internalPatientReferral";
        }
        return results_view;
    }

    @RequestMapping(value = "/externalreferral", method = RequestMethod.GET)
    public String externalReferral(HttpServletRequest request, Model model) {
        // TODO: Implement External Referral Logic.
        return "doctorConsultations/forms/externalReferrals";
    }

    @RequestMapping(value = "/saveinternalreferredpatient.htm")
    public @ResponseBody
    String saveinternalreferredpatient(HttpServletRequest request) {
        String results = "";
        try {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Internalreferral internalreferral = new Internalreferral();
            internalreferral.setAddedby(BigInteger.valueOf(staffid));
            internalreferral.setDateadded(new Date());
            internalreferral.setIscomplete(Boolean.FALSE);
            internalreferral.setReferralnotes(request.getParameter("referralnotes"));
            internalreferral.setReferralunitid(BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))));
            internalreferral.setReferringunitid(BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));
            internalreferral.setPatientvisitid(BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))));
            String[] fields = {"facilityunitserviceid"};
            String[] params = {"facilityunitid", "active", "servicekey"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("facilityunit")), Boolean.TRUE, "key_consultation"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active AND servicekey=:servicekey";
            List<Object> facilityUnitServiceIds = ((List<Object>) genericClassService.fetchRecord(Facilityunitservicesview.class, fields, where, params, paramsValues));
            if (facilityUnitServiceIds == null || facilityUnitServiceIds.get(0) == null) {
                paramsValues = new Object[]{Long.parseLong(request.getParameter("facilityunit")), Boolean.TRUE, "key_triage"};
                where = "WHERE facilityunitid=:facilityunitid AND active=:active AND servicekey=:servicekey";
                facilityUnitServiceIds = ((List<Object>) genericClassService.fetchRecord(Facilityunitservicesview.class, fields, where, params, paramsValues));
            }
            if (facilityUnitServiceIds != null || facilityUnitServiceIds.get(0) == null) {
                internalreferral.setUnitserviceid(Long.parseLong(facilityUnitServiceIds.get(0).toString()));
            }
            //
            Object saved = genericClassService.saveOrUpdateRecordLoadObject(internalreferral);
            if (saved != null) {
                results = String.valueOf(staffid);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return results;
    } 

    @RequestMapping(value = "/labpatientclinicalnotesform.htm", method = RequestMethod.GET)
    public String labpatientclinicalnotesform(Model model, HttpServletRequest request) {
        List<Map> complaintsFound = new ArrayList<>();
        List<Map> commentsFound = new ArrayList<>();

        String[] params = {"patientvisitid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields = {"patientcomplaintid", "patientcomplaint", "description", "addedby"};
        String where = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patientcomplaints = (List<Object[]>) genericClassService.fetchRecord(Patientcomplaint.class, fields, where, params, paramsValues);
        if (patientcomplaints != null) {
            Map<String, Object> unitsRow;
            for (Object[] patientcomplaint : patientcomplaints) {
                unitsRow = new HashMap<>();
                unitsRow.put("patientcomplaintid", patientcomplaint[0]);
                unitsRow.put("patientcomplaint", patientcomplaint[1]);
                unitsRow.put("description", patientcomplaint[2]);

                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {patientcomplaint[3]};
                String[] fields2 = {"firstname", "othernames", "lastname"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                if (addedby != null) {
                    unitsRow.put("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
                }
                complaintsFound.add(unitsRow);
            }
            model.addAttribute("act", "b");

            String[] params3 = {"patientvisitid"};
            Object[] paramsValues3 = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields3 = {"patientobservationid", "observation", "addedby"};
            String where3 = "WHERE patientvisitid=:patientvisitid";
            List<Object[]> comments = (List<Object[]>) genericClassService.fetchRecord(Patientobservation.class, fields3, where3, params3, paramsValues3);
            if (comments != null) {
                Map<String, Object> commentsRow;
                for (Object[] comment : comments) {
                    commentsRow = new HashMap<>();
                    commentsRow.put("patientobservationid", comment[0]);
                    commentsRow.put("observation", comment[1]);

                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {comment[2]};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (addedby != null) {
                        commentsRow.put("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
                    }
                    commentsFound.add(commentsRow);
                }
            }
        } else {
            model.addAttribute("act", "a");
        }
        model.addAttribute("commentsFound", commentsFound);
        model.addAttribute("complaintsFound", complaintsFound);
        return "doctorConsultations/laboratory/labRequestPrescription/views/clinicalNotes";
    }

    @RequestMapping(value = "/diseasessymptoms.htm")
    public @ResponseBody
    String diseasessymptoms(HttpServletRequest request) {
        String results = "";
        List<Map> itemsFound = new ArrayList<>();
        try {
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"symptomid", "symptom"};
            List<Object[]> symptoms = (List<Object[]>) genericClassService.fetchRecord(Symptom.class, fields, "", params, paramsValues);
            if (symptoms != null) {
                Map<String, Object> itemsRow;
                for (Object[] symptom : symptoms) {
                    itemsRow = new HashMap<>();

                    String[] params2 = {"symptomid"};
                    Object[] paramsValues2 = {symptom[0]};
                    String[] fields2 = {"diseasesymptomid", "addedby"};
                    String where2 = "WHERE symptomid=:symptomid";
                    List<Object[]> symptomss = (List<Object[]>) genericClassService.fetchRecord(Diseasesymptom.class, fields2, where2, params2, paramsValues2);
                    if (symptomss != null) {
                        itemsRow.put("data", symptom[0]);
                        itemsRow.put("value", symptom[1]);
                        itemsFound.add(itemsRow);
                    }
                }
            }
            results = new ObjectMapper().writeValueAsString(itemsFound);
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::" + e.getMessage());

        }
        return results;
    }

    @RequestMapping(value = "/symptomsdiseases.htm")
    public @ResponseBody
    String symptomsdiseases(HttpServletRequest request) {
        String results = "";
        try {
            List<Map> diseaseFound = new ArrayList<>();
            String[] params = {"symptomid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("symptomid"))};
            String[] fields = {"diseaseid.diseaseid", "diseaseid.diseasename"};
            List<Object[]> symptoms = (List<Object[]>) genericClassService.fetchRecord(Diseasesymptom.class, fields, "WHERE symptomid=:symptomid", params, paramsValues);
            if (symptoms != null) {
                Map<String, Object> diseaseRow;
                for (Object[] symptom : symptoms) {
                    diseaseRow = new HashMap<>();
                    diseaseRow.put("diseaseid", symptom[0]);
                    diseaseRow.put("diseasename", symptom[1]);
                    diseaseFound.add(diseaseRow);
                }
            }
            results = new ObjectMapper().writeValueAsString(diseaseFound);

        } catch (Exception e) {

        }
        return results;
    }

    @RequestMapping(value = "/symptoms.htm", method = RequestMethod.GET)
    public String symptoms(Model model, HttpServletRequest request) {
        List<Map> symptomsFound = new ArrayList<>();
        try {
            List<Map> item2 = (ArrayList) new ObjectMapper().readValue(request.getParameter("symptoms"), List.class);
            Map<String, Object> symptomRow;
            for (Map item1 : item2) {
                Map<String, Object> map = (HashMap) item1;
                symptomRow = new HashMap<>();
                symptomRow.put("symptomid", map.get("symptomid"));
                symptomRow.put("symptom", map.get("symptom"));
                symptomsFound.add(symptomRow);
            }
        } catch (Exception e) {
            System.out.println(":::::::::::::::::::::::::::::::" + e);
        }
        model.addAttribute("symptomsFound", symptomsFound);
        return "doctorConsultations/views/symptoms";
    }

    @RequestMapping(value = "/patientconditions.htm", method = RequestMethod.GET)
    public String patientconditions(Model model, HttpServletRequest request) {
        List<Map> conditionsFound = new ArrayList<>();
        try {
            List<Map> item2 = (ArrayList) new ObjectMapper().readValue(request.getParameter("diseases"), List.class);
            Map<String, Object> conditionRow;
            for (Map item1 : item2) {
                Map<String, Object> map = (HashMap) item1;
                conditionRow = new HashMap<>();
                conditionRow.put("diseaseid", map.get("diseaseid"));
                conditionRow.put("diseasename", map.get("diseasename"));
                conditionRow.put("count", map.get("count"));

                String[] params = {"diseaseid"};
                Object[] paramsValues = {Long.parseLong(String.valueOf((Integer) map.get("diseaseid")))};
                String[] fields = {"diseasecategoryid", "status"};
                List<Object[]> disease = (List<Object[]>) genericClassService.fetchRecord(Disease.class, fields, "WHERE diseaseid=:diseaseid", params, paramsValues);
                if (disease != null) {

                    String[] params2 = {"diseasecategoryid"};
                    Object[] paramsValues2 = {disease.get(0)[0]};
                    String[] fields2 = {"diseasecategoryid", "diseasecategoryname"};
                    String where2 = "WHERE diseasecategoryid=:diseasecategoryid";
                    List<Object[]> diseasecategory = (List<Object[]>) genericClassService.fetchRecord(Diseasecategory.class, fields2, where2, params2, paramsValues2);
                    if (diseasecategory != null) {
                        conditionRow.put("diseasecategory", diseasecategory.get(0)[1]);
                    }
                }
                conditionsFound.add(conditionRow);
            }
        } catch (Exception e) {
            System.out.println(":::::::::::::::::::::::::::::::" + e);
        }
        Collections.sort(conditionsFound, sortdiseases);
        model.addAttribute("conditionsFound", conditionsFound);
        return "doctorConsultations/views/patientConditions";
    }

    Comparator sortdiseases = new Comparator<Map>() {
        @Override
        public int compare(final Map o1, final Map o2) {
            try {
                return -((Integer) o1.get("count")).compareTo((Integer) o2.get("count"));
            } catch (Exception e) {
                System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::" + e);
            }
            return 0;
        }
    };

    @RequestMapping(value = "/loadbackgroundimages.htm", method = RequestMethod.GET)
    public String loadbackgroundimages(Model model, HttpServletRequest request) {

        return "doctorConsultations/views/backgroundImage";
    }

    @RequestMapping(value = "/patientconditiondetails.htm", method = RequestMethod.GET)
    public String patientconditiondetails(Model model, HttpServletRequest request) {

        List<Map> symptomsFound = new ArrayList<>();
        String[] params = {"diseaseid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("diseaseid"))};
        String[] fields = {"symptomid.symptomid", "symptomid.symptom"};
        List<Object[]> symptoms = (List<Object[]>) genericClassService.fetchRecord(Diseasesymptom.class, fields, "WHERE diseaseid=:diseaseid", params, paramsValues);
        if (symptoms != null) {
            Map<String, Object> symptomsRow;
            for (Object[] symptom : symptoms) {
                symptomsRow = new HashMap<>();
                symptomsRow.put("symptomid", symptom[0]);
                symptomsRow.put("symptom", symptom[1]);
                symptomsFound.add(symptomsRow);
            }
        }
        model.addAttribute("symptomsFound", symptomsFound);

        return "doctorConsultations/views/patientConditionsDetail";
    }

    @RequestMapping(value = "/updatepatientvisitvitals.htm")
    public @ResponseBody
    String updatepatientvisitvitals(HttpServletRequest request) {
        String results = "";

        if ("pressure".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"patientpressuresystolic", "patientpressurediastolic"};
                Object[] columnValues = {Long.parseLong(request.getParameter("systolic")), Long.parseLong(request.getParameter("diastolic"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setPatientpressuresystolic(Long.parseLong(request.getParameter("systolic")));
                triage.setPatientpressurediastolic(Long.parseLong(request.getParameter("diastolic")));
                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("weight".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"weight"};
                Object[] columnValues = {Double.parseDouble(request.getParameter("weight"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setWeight(Double.parseDouble(request.getParameter("weight")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("height".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"height"};
                Object[] columnValues = {Double.parseDouble(request.getParameter("height"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setHeight(Double.parseDouble(request.getParameter("height")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("temperature".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"temperature"};
                Object[] columnValues = {Double.parseDouble(request.getParameter("temperature"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setTemperature(Double.parseDouble(request.getParameter("temperature")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("bodysurfacearea".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"bodysurfacearea"};
                Object[] columnValues = {Double.parseDouble(request.getParameter("bodysurfacearea"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setBodysurfacearea(Double.parseDouble(request.getParameter("bodysurfacearea")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("headcircum".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"headcircum"};
                Object[] columnValues = {Double.parseDouble(request.getParameter("headcircum"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setHeadcircum(Double.parseDouble(request.getParameter("headcircum")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("pulse".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"pulse"};
                Object[] columnValues = {Integer.parseInt(request.getParameter("pulse"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setPulse(Integer.parseInt(request.getParameter("pulse")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        if ("respirationrate".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"respirationrate"};
                Object[] columnValues = {Integer.parseInt(request.getParameter("respirationrate"))};
                String pk = "triageid";
                Object pkValue = triageid.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Triage.class, columns, columnValues, pk, pkValue, "patient");
                if (result != 0) {
                    results = "success";
                }
            } else {
                Triage triage = new Triage();
                triage.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                triage.setDateadded(new Date());
                triage.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                triage.setRespirationrate(Integer.parseInt(request.getParameter("respirationrate")));

                Object saved = genericClassService.saveOrUpdateRecordLoadObject(triage);
                if (saved != null) {
                    results = "success";
                }
            }
        }
        return results;
    }

    @RequestMapping(value = "/countRequestsPatients")
    public @ResponseBody
    String countServicedPatients(HttpServletRequest request) {
        Integer serviced;
        if ("requests".equals(request.getParameter("type"))) {
            String[] params = {"originunit", "status", "addedby", "dateadded"};
            Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), "SENT", request.getSession().getAttribute("sessionActiveLoginStaffid"), new Date()};
            String where = "WHERE originunit=:originunit AND status=:status AND addedby=:addedby AND dateadded=:dateadded";
            serviced = genericClassService.fetchRecordCount(Laboratoryrequest.class, where, params, paramsValues);

        } else {
            String[] params = {"originunit", "status", "dateadded"};
            Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), "SERVICED", new Date()};
            String where = "WHERE originunit=:originunit AND status=:status AND dateadded=:dateadded";
            serviced = genericClassService.fetchRecordCount(Laboratoryrequest.class, where, params, paramsValues);

        }

        return serviced.toString();
    }

    @RequestMapping(value = "/labpatientdetails.htm", method = RequestMethod.GET)
    public String labpatientdetails(Model model, HttpServletRequest request) {

        String[] params = {"patientid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fields = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin"};
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
        if (patientsvisits != null) {
            String[] params5 = {"personid"};
            Object[] paramsValues5 = {patientsvisits.get(0)[0]};
            String[] fields5 = {"dob", "estimatedage", "gender"};
            List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5, "WHERE personid=:personid", params5, paramsValues5);

            model.addAttribute("name", patientsvisits.get(0)[1] + " " + patientsvisits.get(0)[3] + " " + patientsvisits.get(0)[2]);
            model.addAttribute("patientno", patientsvisits.get(0)[4]);
            model.addAttribute("telephone", patientsvisits.get(0)[5]);
            model.addAttribute("nextofkin", patientsvisits.get(0)[6]);
            model.addAttribute("dob", formatter.format((Date) patientdetails.get(0)[0]));
            model.addAttribute("gender", patientdetails.get(0)[2]);

            SimpleDateFormat df = new SimpleDateFormat("yyyy");
            int year = Integer.parseInt(df.format((Date) patientdetails.get(0)[0]));
            int currentyear = Integer.parseInt(df.format(new Date()));
            model.addAttribute("estimatedage", currentyear - year);

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }

        String[] params1 = {"patientvisitid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields1 = {"weight", "temperature", "height", "pulse", "headcircum", "bodysurfacearea", "respirationrate", "patientpressuresystolic", "patientpressurediastolic"};
        String where1 = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patienttriages = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields1, where1, params1, paramsValues1);
        if (patienttriages != null) {
            if (patienttriages.get(0)[0] != null) {
                model.addAttribute("weight", patienttriages.get(0)[0]);
            } else {
                model.addAttribute("weight", 0);
            }
            if (patienttriages.get(0)[1] != null) {
                model.addAttribute("temperature", patienttriages.get(0)[1]);
            } else {
                model.addAttribute("temperature", 0);
            }
            if (patienttriages.get(0)[2] != null) {
                model.addAttribute("height", patienttriages.get(0)[2]);
            } else {
                model.addAttribute("height", 0);
            }
            if (patienttriages.get(0)[3] != null) {
                model.addAttribute("pulse", patienttriages.get(0)[3]);
            } else {
                model.addAttribute("pulse", 0);
            }
            if (patienttriages.get(0)[4] != null) {
                model.addAttribute("headcircum", patienttriages.get(0)[4]);
            } else {
                model.addAttribute("headcircum", 0);
            }
            if (patienttriages.get(0)[5] != null) {
                model.addAttribute("bodysurfacearea", patienttriages.get(0)[5]);
            } else {
                model.addAttribute("bodysurfacearea", 0);
            }
            if (patienttriages.get(0)[6] != null) {
                model.addAttribute("respirationrate", patienttriages.get(0)[6]);
            } else {
                model.addAttribute("respirationrate", 0);
            }
            if (patienttriages.get(0)[7] != null) {
                model.addAttribute("systolic", patienttriages.get(0)[7]);
            } else {
                model.addAttribute("systolic", 0);
            }
            if (patienttriages.get(0)[8] != null) {
                model.addAttribute("diastolic", patienttriages.get(0)[8]);
            } else {
                model.addAttribute("diastolic", 0);
            }
            if (patienttriages.get(0)[2] != null && patienttriages.get(0)[0] != null) {
                model.addAttribute("bmi", String.format("%.02f", (Double) patienttriages.get(0)[0] / ((((Double) patienttriages.get(0)[2]) * 0.01) * (((Double) patienttriages.get(0)[2]) * 0.01))) + " " + "");
            } else {
                model.addAttribute("bmi", "pending");
            }
        } else {
            model.addAttribute("bmi", "pending");
            model.addAttribute("systolic", 0);
            model.addAttribute("diastolic", 0);
            model.addAttribute("respirationrate", 0);
            model.addAttribute("bodysurfacearea", 0);
            model.addAttribute("headcircum", 0);
            model.addAttribute("pulse", 0);
            model.addAttribute("height", 0);
            model.addAttribute("temperature", 0);
            model.addAttribute("weight", 0);
        }
        return "doctorConsultations/laboratory/labRequestPrescription/views/labRequestPrescriptionHome";
    }

    @RequestMapping(value = "/labpatientsentlabaratory.htm", method = RequestMethod.GET)
    public String labpatientsentlabaratory(Model model, HttpServletRequest request) {
        List<Map> labtestsFound = new ArrayList<>();
        String[] params1 = {"patientvisitid", "status", "dateadded", "originunit"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid")), "SENT", new Date(), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields1 = {"laboratoryrequestid", "laboratoryrequestnumber", "addedby", "destinationunit"};
        String where1 = "WHERE patientvisitid=:patientvisitid AND status=:status AND dateadded=:dateadded AND originunit=:originunit";
        List<Object[]> patientlabrequests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields1, where1, params1, paramsValues1);
        if (patientlabrequests != null) {
            Map<String, Object> testsRow;

            String[] params = {"laboratoryrequestid"};
            Object[] paramsValues = {patientlabrequests.get(0)[0]};
            String[] fields = {"laboratorytestid", "laboratoryrequesttestid"};
            List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields, "WHERE laboratoryrequestid=:laboratoryrequestid", params, paramsValues);
            if (labtests != null) {
                for (Object[] labtest : labtests) {
                    testsRow = new HashMap<>();

                    String[] params3 = {"laboratorytestid"};
                    Object[] paramsValues3 = {labtest[0]};
                    String[] fields3 = {"laboratorytestid", "testname", "labtestclassificationid"};
                    String where3 = "WHERE laboratorytestid=:laboratorytestid";
                    List<Object[]> test = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields3, where3, params3, paramsValues3);
                    if (test != null) {
                        testsRow.put("laboratorytestid", test.get(0)[0]);
                        testsRow.put("testname", test.get(0)[1]);

                        String[] params2 = {"labtestclassificationid"};
                        Object[] paramsValues2 = {test.get(0)[2]};
                        String[] fields2 = {"labtestclassificationname"};
                        String where2 = "WHERE labtestclassificationid=:labtestclassificationid";
                        List<String> classification = (List<String>) genericClassService.fetchRecord(Labtestclassification.class, fields2, where2, params2, paramsValues2);
                        if (classification != null) {
                            testsRow.put("classification", classification.get(0));
                        }
                        labtestsFound.add(testsRow);
                    }
                }
            }
            String[] params2 = {"staffid"};
            Object[] paramsValues2 = {patientlabrequests.get(0)[2]};
            String[] fields2 = {"firstname", "othernames", "lastname"};
            String where2 = "WHERE staffid=:staffid";
            List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
            if (addedby != null) {
                model.addAttribute("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
            }
            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {patientlabrequests.get(0)[3]};
            String[] fields4 = {"facilityunitname"};
            String where4 = "WHERE facilityunitid=:facilityunitid";
            List<String> destinationunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
            if (destinationunit != null) {
                model.addAttribute("facilityunitname", destinationunit.get(0));
            }
            model.addAttribute("laboratoryrequestnumber", patientlabrequests.get(0)[1]);
            model.addAttribute("date", formatter.format(new Date()));
        }
        model.addAttribute("labtestsFound", labtestsFound);
        return "doctorConsultations/laboratory/labRequestPrescription/views/labRequests";
    }

    @RequestMapping(value = "/labsentpatientclinicalnotesform.htm", method = RequestMethod.GET)
    public String labsentpatientclinicalnotesform(Model model, HttpServletRequest request) {
        List<Map> complaintsFound = new ArrayList<>();
        List<Map> commentsFound = new ArrayList<>();

        String[] params = {"patientvisitid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields = {"patientcomplaintid", "patientcomplaint", "description", "addedby"};
        String where = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patientcomplaints = (List<Object[]>) genericClassService.fetchRecord(Patientcomplaint.class, fields, where, params, paramsValues);
        if (patientcomplaints != null) {
            Map<String, Object> unitsRow;
            for (Object[] patientcomplaint : patientcomplaints) {
                unitsRow = new HashMap<>();
                unitsRow.put("patientcomplaintid", patientcomplaint[0]);
                unitsRow.put("patientcomplaint", patientcomplaint[1]);
                unitsRow.put("description", patientcomplaint[2]);

                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {patientcomplaint[3]};
                String[] fields2 = {"firstname", "othernames", "lastname"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                if (addedby != null) {
                    unitsRow.put("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
                }
                complaintsFound.add(unitsRow);
            }
            model.addAttribute("act", "b");

            String[] params3 = {"patientvisitid"};
            Object[] paramsValues3 = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields3 = {"patientobservationid", "observation", "addedby"};
            String where3 = "WHERE patientvisitid=:patientvisitid";
            List<Object[]> comments = (List<Object[]>) genericClassService.fetchRecord(Patientobservation.class, fields3, where3, params3, paramsValues3);
            if (comments != null) {
                Map<String, Object> commentsRow;
                for (Object[] comment : comments) {
                    commentsRow = new HashMap<>();
                    commentsRow.put("patientobservationid", comment[0]);
                    commentsRow.put("observation", comment[1]);

                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {comment[2]};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (addedby != null) {
                        commentsRow.put("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
                    }
                    commentsFound.add(commentsRow);
                }
            }
        } else {
            model.addAttribute("act", "a");
        }
        model.addAttribute("commentsFound", commentsFound);
        model.addAttribute("complaintsFound", complaintsFound);
        return "doctorConsultations/laboratory/labRequestPrescription/views/clinicalNotes";
    }

    @RequestMapping(value = "/labinternallabReferrals.htm", method = RequestMethod.GET)
    public String labinternallabReferrals(Model model, HttpServletRequest request) {
        List<Map> unitsFound = new ArrayList<>();
        Set<Long> units = new HashSet<>();

        String[] params = {"facilityid", "active", "status"};
        Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE, Boolean.TRUE};
        String[] fields = {"facilityunit.facilityunitid", "facilityunit.facilityunitname", "facilityunitserviceid"};
        String where = "WHERE r.facilityunit.facilityid=:facilityid AND r.facilityunit.active=:active AND status=:status";
        List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
        Map<String, Object> unitsRow;
        if (facilityunits != null) {
            for (Object[] facilityunit : facilityunits) {
                unitsRow = new HashMap<>();
                if (((Long) facilityunit[0]).intValue() != (int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit") && !units.contains((Long) facilityunit[0])) {
                    unitsRow.put("facilityunitid", facilityunit[0]);
                    unitsRow.put("facilityunitname", facilityunit[1]);
                    unitsRow.put("facilityunitserviceid", facilityunit[2]);
                    units.add((Long) facilityunit[0]);

                    unitsFound.add(unitsRow);
                }

            }
        }
        model.addAttribute("unitsFound", unitsFound);

        return "doctorConsultations/laboratory/labRequestPrescription/forms/internalReferrals";
    }

    @RequestMapping(value = "/laboratorypatientprescription.htm", method = RequestMethod.GET)
    public String laboratorypatientprescription(Model model, HttpServletRequest request) {
        long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> unitsFound = new ArrayList<>();
        int prevousPrescriptions = 0;
        String[] params = {"patientid", "patientvisitid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid"))), BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid")))};
        String[] fields = {"patientvisitid", "visitnumber"};
        String where = "WHERE patientid=:patientid AND patientvisitid!=:patientvisitid";
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Patientvisits.class, fields, where, params, paramsValues);
        if (patientsvisits != null) {
            for (Object[] patientsvisit : patientsvisits) {

                String[] params6 = {"patientvisitid"};
                Object[] paramsValues6 = {patientsvisit[0]};
                String where6 = "WHERE patientvisitid=:patientvisitid";
                int prescriptions = genericClassService.fetchRecordCount(Prescription.class, where6, params6, paramsValues6);

                prevousPrescriptions = prevousPrescriptions + prescriptions;

            }
        }
        model.addAttribute("prevousPrescriptions", prevousPrescriptions);
        model.addAttribute("facilityid", facilityId);
        return "doctorConsultations/laboratory/labRequestPrescription/forms/prescription";
    }

    @RequestMapping(value = "/laboratoryprescriptionform.htm", method = RequestMethod.GET)
    public String laboratoryprescriptionform(Model model, HttpServletRequest request) {
        List<Map> doctorprescriptionHomesFound = new ArrayList<>();
        List<Map<String, Object>> specialInstructions = new ArrayList<>(); //
        try {
            if ("a".equals(request.getParameter("act"))) {
                String[] params = {"issupplies"};
                Object[] paramsValues = {Boolean.FALSE};
//                String[] fields = {"itemid", "genericname"};
//                String where = "WHERE issupplies=:issupplies";
//                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                String[] fields = {"genericname"};
                String where = "WHERE issupplies=:issupplies GROUP BY genericname";
                List<Object> items = (List<Object>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                if (items != null) {
                    Map<String, Object> itemsRow;
//                    for (Object[] item : items) {
                    for (Object item : items) {
                        itemsRow = new HashMap<>();
//                        itemsRow.put("itemid", item[0]);
//                        itemsRow.put("itemid", item[1]);
//                        itemsRow.put("fullname", item[1]);
                        itemsRow.put("itemid", item.toString());
                        itemsRow.put("fullname", item.toString());
                        doctorprescriptionHomesFound.add(itemsRow);
                    }
                }
            } else {
//                Set<Long> items = new HashSet<>();
//                List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescribedItems"), List.class);
                Set<String> items = new HashSet<>();
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("prescribedItems"), List.class);
                if (!item.isEmpty()) {
                    for (String itemid : item) {
                        items.add(itemid);
                    }
                }
                String[] params = {"issupplies"};
                Object[] paramsValues = {Boolean.FALSE};
//                String[] fields = {"itemid", "genericname"};
//                String where = "WHERE issupplies=:issupplies";
//                List<Object[]> itemss = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                String[] fields = {"genericname"};
                String where = "WHERE issupplies=:issupplies GROUP BY genericname";
                List<Object> itemss = (List<Object>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
                if (itemss != null) {
                    Map<String, Object> itemsRow;
//                    for (Object[] itemz : itemss) {
                    for (Object itemz : itemss) { 
                        itemsRow = new HashMap<>();
//                        if (items.isEmpty() || !items.contains(((BigInteger) itemz[0]).longValue())) {
//                            itemsRow.put("itemid", itemz[0]);
//                        if (items.isEmpty() || !items.contains((itemz[1]).toString().replaceAll("[^a-zA-Z0-9]", ""))) {
//                            itemsRow.put("itemid", itemz[1]);
//                            itemsRow.put("fullname", itemz[1]);
//                            doctorprescriptionHomesFound.add(itemsRow);
//                        }
                        if (items.isEmpty() || !items.contains((itemz).toString())) {
                                itemsRow.put("itemid", itemz.toString());
                                itemsRow.put("fullname", itemz.toString());
                                if(!doctorprescriptionHomesFound.contains(itemsRow)){
                                    doctorprescriptionHomesFound.add(itemsRow);
                                }
                        }
                    }
                }
            }
            //
            String [] fields = { "specialinstructionsid", "specialinstruction" };
            String where = "";
            String [] params = null;
            Object [] paramsValues = null;
            List<Object[]> instructions = (List<Object[]>) genericClassService.fetchRecord(Specialinstructions.class, fields, where, params, paramsValues);
            if(instructions != null){
                Map<String, Object> specialInstruction;
                for(Object[] instruction : instructions){
                    specialInstruction = new HashMap<>();
                    specialInstruction.put("specialinstructionsid", instruction[0]);
                    specialInstruction.put("specialinstruction", instruction[1].toString());
                    specialInstructions.add(specialInstruction);
                }
            }
            //
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::" + e);
        }
        model.addAttribute("specialInstructions", specialInstructions);
        model.addAttribute("ItemsFound", doctorprescriptionHomesFound);
        return "doctorConsultations/laboratory/labRequestPrescription/forms/prescriptionform";
    }

    @RequestMapping(value = "/sentlaboratorytests.htm", method = RequestMethod.GET)
    public String sentlaboratorytests(Model model, HttpServletRequest request) {
        List<Map> labtestsFound = new ArrayList<>();

        String[] params = {"laboratoryrequestid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("laboratoryrequestid"))};
        String[] fields = {"laboratorytestid", "laboratoryrequesttestid"};
        List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields, "WHERE laboratoryrequestid=:laboratoryrequestid", params, paramsValues);
        if (labtests != null) {
            Map<String, Object> testsRow;
            for (Object[] labtest : labtests) {
                testsRow = new HashMap<>();

                String[] params3 = {"laboratorytestid"};
                Object[] paramsValues3 = {labtest[0]};
                String[] fields3 = {"laboratorytestid", "testname", "labtestclassificationid"};
                String where3 = "WHERE laboratorytestid=:laboratorytestid";
                List<Object[]> test = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields3, where3, params3, paramsValues3);
                if (test != null) {

                    String[] params4 = {"labtestclassificationid"};
                    Object[] paramsValues4 = {test.get(0)[2]};
                    String[] fields4 = {"labtestclassificationname"};
                    List<String> specimen = (List<String>) genericClassService.fetchRecord(Labtestclassification.class, fields4, "WHERE labtestclassificationid=:labtestclassificationid", params4, paramsValues4);
                    if (specimen != null) {
                        testsRow.put("specimen", specimen.get(0));
                    }
                    testsRow.put("laboratorytestid", test.get(0)[0]);
                    testsRow.put("testname", test.get(0)[1]);
                    labtestsFound.add(testsRow);
                }
            }
        }
        String[] params2 = {"staffid"};
        Object[] paramsValues2 = {BigInteger.valueOf(Long.parseLong(request.getParameter("addedby")))};
        String[] fields2 = {"firstname", "othernames", "lastname"};
        String where2 = "WHERE staffid=:staffid";
        List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
        if (addedby != null) {
            model.addAttribute("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
        }
        String[] params4 = {"facilityunitid"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("unit"))};
        String[] fields4 = {"facilityunitname"};
        String where4 = "WHERE facilityunitid=:facilityunitid";
        List<String> destinationunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
        if (destinationunit != null) {
            model.addAttribute("facilityunitname", destinationunit.get(0));
        }
        model.addAttribute("laboratoryrequestnumber", request.getParameter("requestnumber"));
        model.addAttribute("date", formatter.format(new Date()));

        model.addAttribute("labtestsFound", labtestsFound);
        return "doctorConsultations/views/labRequestedTests";
    }

    @RequestMapping(value = "/savepatientcomplaintobservation.htm")
    public @ResponseBody
    String savepatientcomplaintobservation(HttpServletRequest request) {
        String results = "";
        Patientobservation patientobservation = new Patientobservation();
        patientobservation.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
        patientobservation.setDateadded(new Date());
        patientobservation.setObservation(request.getParameter("observation"));
        patientobservation.setPatientvisitid(BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))));
        genericClassService.saveOrUpdateRecordLoadObject(patientobservation);

        return results;
    }

    @RequestMapping(value = "/deletepatientcomplaintorobservation.htm")
    public @ResponseBody
    String deletepatientcomplaintorobservation(HttpServletRequest request) {
        String results = "";
        if ("a".equals(request.getParameter("act"))) {
            String[] columns = {"patientcomplaintid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("patientcomplaintid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.patientcomplaint", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] columns = {"patientobservationid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("patientobservationid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.patientobservation", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/updatepatientcomplaint.htm")
    public @ResponseBody
    String updatepatientcomplaint(HttpServletRequest request) {
        String results = "";
        if ("a".equals(request.getParameter("act"))) {

            String[] columns = {"patientcomplaint", "description"};
            Object[] columnValues = {request.getParameter("complaint"), request.getParameter("history")};
            String pk = "patientcomplaintid";
            Object pkValue = Long.parseLong(request.getParameter("patientcomplaintid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Patientcomplaint.class, columns, columnValues, pk, pkValue, "patient");

        } else {
            String[] columns = {"observation"};
            Object[] columnValues = {request.getParameter("observation")};
            String pk = "patientobservationid";
            Object pkValue = Long.parseLong(request.getParameter("patientobservationid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Patientobservation.class, columns, columnValues, pk, pkValue, "patient");

        }
        return results;
    }

    @RequestMapping(value = "/patienthistory.htm", method = RequestMethod.GET)
    public String patienthistory(Model model, HttpServletRequest request) {
        List<Map> previoushistoryList = new ArrayList<>();

        String[] params = {"patientvisitid", "patientid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid")), Long.parseLong(request.getParameter("patientid"))};
        String[] fields = {"patientvisitid", "patientid", "visitnumber", "dateadded"};
        List<Object[]> previoushistoryvisits = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields, "WHERE patientvisitid!=:patientvisitid AND patientid=:patientid ORDER BY patientvisitid DESC", params, paramsValues);
        if (previoushistoryvisits != null) {
            Map<String, Object> previousvisitsRow;
            for (Object[] previoushistoryvisit : previoushistoryvisits) {

                previousvisitsRow = new HashMap<>();
                String[] params2 = {"patientvisitid"};
                Object[] paramsValues2 = {previoushistoryvisit[0]};
                String where2 = "WHERE patientvisitid=:patientvisitid";
                int prevoiusvisitsCount2 = genericClassService.fetchRecordCount(Laboratoryrequest.class, where2, params2, paramsValues2);

                String[] params3 = {"patientvisitid"};
                Object[] paramsValues3 = {previoushistoryvisit[0]};
                String where3 = "WHERE patientvisitid=:patientvisitid";
                int prevoiusvisitspresc = genericClassService.fetchRecordCount(Prescription.class, where3, params3, paramsValues3);

                if (prevoiusvisitsCount2 == 0 && prevoiusvisitspresc == 0) {
                } else {
                    previousvisitsRow.put("patientvisitid", previoushistoryvisit[0]);
                    previousvisitsRow.put("prevoiusvisitslab", prevoiusvisitsCount2);
                    previousvisitsRow.put("visitnumber", previoushistoryvisit[2]);
                    previousvisitsRow.put("date", formatter.format((Date) previoushistoryvisit[3]));

                    String[] params5 = {"patientvisitid"};
                    Object[] paramsValues5 = {previoushistoryvisit[0]};
                    String[] fields5 = {"facilityid", "gender"};
                    String where5 = "WHERE patientvisitid=:patientvisitid";
                    List<Object[]> previouslabstests = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5, where5, params5, paramsValues5);
                    if (previouslabstests != null) {

                        String[] params8 = {"facilityid"};
                        Object[] paramsValues8 = {previouslabstests.get(0)[0]};
                        String[] fields8 = {"facilityname"};
                        String where8 = "WHERE facilityid=:facilityid";
                        List<String> facilityname = (List<String>) genericClassService.fetchRecord(Facility.class, fields8, where8, params8, paramsValues8);
                        if (facilityname != null) {
                            previousvisitsRow.put("facilityname", facilityname.get(0));
                            previousvisitsRow.put("facilityid", previouslabstests.get(0)[0]);
                        }

                        previousvisitsRow.put("prescriptions", prevoiusvisitspresc);

                    }
                    previoushistoryList.add(previousvisitsRow);
                }
            }
        }
        model.addAttribute("previoushistoryList", previoushistoryList);
        return "doctorConsultations/views/patientHistory";
    }

    @RequestMapping(value = "/pickpausedpatientqueues.htm")
    public @ResponseBody
    String pickpausedpatientqueues(HttpServletRequest request) {
        String results = "";
        List<Map> patientdetailList = new ArrayList<>();
        try {
            String[] params5 = {"patientvisitid"};
            Object[] paramsValues5 = {Long.parseLong(request.getParameter("patvisitid"))};
            String[] fields5 = {"patientid", "visitnumber", "patientvisitid"};
            String where5 = "WHERE patientvisitid=:patientvisitid";
            List<Object[]> patientdetail = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields5, where5, params5, paramsValues5);
            if (patientdetail != null) {
                Map<String, Object> resultsRow = new HashMap<>();
                resultsRow.put("patientid", patientdetail.get(0)[0]);
                resultsRow.put("visitnumber", patientdetail.get(0)[1]);
                resultsRow.put("patientvisitid", patientdetail.get(0)[2]);
                patientdetailList.add(resultsRow);
            }
            results = new ObjectMapper().writeValueAsString(patientdetailList);
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::" + e);
        }

        return results;
    }

    @RequestMapping(value = "/closepausedpatient.htm")
    public @ResponseBody
    String closepausedpatient(HttpServletRequest request) {
        String results = "";
        final long patientvisitid = Long.parseLong(request.getParameter("patientvisitid"));
        final long addedby = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        final int facilityunit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        Runnable myRunnable = new Runnable() {
            @Override
            public void run() {
                String[] params = {"addedby", "dateadded", "paused", "facilityunit", "patientvisitid"};
                Object[] paramsValues = {BigInteger.valueOf(addedby), new Date(), true, facilityunit, BigInteger.valueOf(patientvisitid)};
                String[] fields = {"patientpauseid"};
                List<Integer> pausedpatient = (List<Integer>) genericClassService.fetchRecord(Patientpause.class, fields, "WHERE addedby=:addedby AND dateadded=:dateadded AND paused=:paused AND facilityunit=:facilityunit AND patientvisitid=:patientvisitid", params, paramsValues);
                if (pausedpatient != null) {
                    String[] columns = {"patientpauseid"};
                    Object[] columnValues = {pausedpatient.get(0)};
                    int result = genericClassService.deleteRecordByByColumns("patient.patientpause", columns, columnValues);
                    if (result != 0) {

                    } else {
                        String[] columns1 = {"paused"};
                        Object[] columnValues1 = {Boolean.FALSE};
                        String pk = "patientpauseid";
                        Object pkValue = pausedpatient.get(0);
                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Patientpause.class, columns1, columnValues1, pk, pkValue, "patient");

                    }
                }
            }
        };
        Thread thread = new Thread(myRunnable);
        thread.start();
        return results;
    }

    @RequestMapping(value = "/labpatientprescriptionhome.htm", method = RequestMethod.GET)
    public String labpatientprescriptionhome(Model model, HttpServletRequest request) {

        long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

        String results_view = "";
        String[] params7 = {"patientvisitid", "addedby", "dateprescribed", "status"};
        Object[] paramsValues7 = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginStaffid"), new Date(), "SENT"};
        String[] fields7 = {"prescriptionid", "destinationunitid", "addedby", "dateprescribed"};
        String where7 = "WHERE patientvisitid =:patientvisitid AND addedby=:addedby AND DATE(dateprescribed)=:dateprescribed AND status=:status";
        List<Object[]> patientsvisitprescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields7, where7, params7, paramsValues7);
        if (patientsvisitprescriptions != null) {

            List<Map> prescriptionsFound = new ArrayList<>();
            model.addAttribute("prescriptionid", patientsvisitprescriptions.get(0)[0]);

            String[] params2 = {"prescriptionid"};
            Object[] paramsValues2 = {patientsvisitprescriptions.get(0)[0]};
            String[] fields2 = {"prescriptionitemsid", "itemid", "dosage", "days", "daysname", "notes", "dose"};
            String where2 = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields2, where2, params2, paramsValues2);
            if (prescriptions != null) {
                Map<String, Object> itemsRow;
                for (Object[] prescription : prescriptions) {
                    itemsRow = new HashMap<>();

                    String[] params4 = {"itemid"};
                    Object[] paramsValues4 = {BigInteger.valueOf((Long) prescription[1])};
                    String[] fields4 = {"genericname"};
                    String where4 = "WHERE itemid=:itemid";
                    List<String> prescribedItems = (List<String>) genericClassService.fetchRecord(Itemcategories.class, fields4, where4, params4, paramsValues4);
                    if (prescribedItems != null) {
                        itemsRow.put("fullname", prescribedItems.get(0));
                    }
                    itemsRow.put("dosage", prescription[2]);
                    itemsRow.put("days", prescription[3]);
                    itemsRow.put("daysname", prescription[4]);

                    if (prescription[5] != null) {
                        itemsRow.put("notes", prescription[5]);
                    } else {
                        itemsRow.put("notes", "----------");
                    }
                    if (prescription[6] != null) {
                        itemsRow.put("dose", prescription[6]);
                    } else {
                        itemsRow.put("dose", "----------");
                    }

                    prescriptionsFound.add(itemsRow);
                }
            } else {
                String[] params = {"prescriptionid"};
                Object[] paramsValues = {patientsvisitprescriptions.get(0)[0]};
                String[] fields = {"newprescriptionitemsid", "itemname", "dosage", "days", "daysname", "notes", "dose"};
                String where = "WHERE prescriptionid=:prescriptionid";
                List<Object[]> newPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
                if (newPrescriptions != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] newPrescription : newPrescriptions) {
                        itemsRow = new HashMap<>();
                        itemsRow.put("fullname", newPrescription[1].toString());
                        itemsRow.put("dosage", newPrescription[2]);
                        itemsRow.put("days", newPrescription[3]);
                        itemsRow.put("daysname", newPrescription[4]);
                        if (newPrescription[5] != null) {
                            itemsRow.put("notes", newPrescription[5]);
                        } else {
                            itemsRow.put("notes", "----------");
                        }
                        if (newPrescription[6] != null) {
                            itemsRow.put("dose", newPrescription[6]);
                        } else {
                            itemsRow.put("dose", "----------");
                        }
                        prescriptionsFound.add(itemsRow);
                    }
                }
            }
            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {patientsvisitprescriptions.get(0)[1]};
            String[] fields4 = {"facilityunitname"};
            String where4 = "WHERE facilityunitid=:facilityunitid";
            List<String> destinationunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
            if (destinationunit != null) {
                model.addAttribute("facilityunitname", destinationunit.get(0));
            }
            String[] params6 = {"staffid"};
            Object[] paramsValues6 = {patientsvisitprescriptions.get(0)[2]};
            String[] fields6 = {"firstname", "othernames", "lastname"};
            String where6 = "WHERE staffid=:staffid";
            List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields6, where6, params6, paramsValues6);
            if (addedby != null) {
                model.addAttribute("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
            }
            model.addAttribute("date", formatter.format((Date) patientsvisitprescriptions.get(0)[3]));

            model.addAttribute("prescriptionsFound", prescriptionsFound);
            results_view = "doctorConsultations/laboratory/labRequestPrescription/views/patientPrescriptions";

        } else {
            results_view = "doctorConsultations/laboratory/labRequestPrescription/forms/prescription";
        }
        model.addAttribute("facilityid", facilityId);
        return results_view;
    }

    @RequestMapping(value = "/closelaboratorypatient.htm")
    public @ResponseBody
    String closelaboratorypatient(HttpServletRequest request) {
        String results = "";
        final long patientvisitid = Long.parseLong(request.getParameter("patientvisitid"));
        final int facilityunit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        Runnable myRunnable = new Runnable() {
            @Override
            public void run() {
                String[] params = {"originunit", "patientvisitid"};
                Object[] paramsValues = {facilityunit, patientvisitid};
                String[] fields = {"laboratoryrequestid"};
                List<Long> patient = (List<Long>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, "WHERE originunit=:originunit AND patientvisitid=:patientvisitid", params, paramsValues);
                if (patient != null) {
                    String[] columns1 = {"status"};
                    Object[] columnValues1 = {"PRESCRIBED"};
                    String pk = "laboratoryrequestid";
                    Object pkValue = patient.get(0);
                    int result1 = genericClassService.updateRecordSQLSchemaStyle(Laboratoryrequest.class, columns1, columnValues1, pk, pkValue, "patient");
                }
            }
        };
        Thread thread = new Thread(myRunnable);
        thread.start();
        return results;
    }

    @RequestMapping(value = "/patientdiagnosis.htm", method = RequestMethod.GET)
    public String patientdiagnosis(Model model, HttpServletRequest request) {
//        String[] params = {"originunit", "patientvisitid"};
//        Object[] paramsValues = {facilityunit, patientvisitid};
//        String[] fields = {"laboratoryrequestid"};
//        List<Long> patient = (List<Long>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, "WHERE originunit=:originunit AND patientvisitid=:patientvisitid", params, paramsValues);
        System.out.println("::::::::::::::::::::::::::::::::::::::::::Now");

        String results_view = "doctorConsultations/forms/patientDiagnosis";
        return results_view;
    }

    @RequestMapping(value = "/patienthistorycount.htm")
    public @ResponseBody
    String historycount(HttpServletRequest request) {
        String results = "";
        int counts = 0;
        String[] params = {"patientvisitid", "patientid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid")), Long.parseLong(request.getParameter("patientid"))};
        String[] fields = {"patientvisitid", "patientid", "visitnumber", "dateadded"};
        List<Object[]> previoushistoryvisits = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields, "WHERE patientvisitid!=:patientvisitid AND patientid=:patientid", params, paramsValues);
        if (previoushistoryvisits != null) {
            for (Object[] previoushistoryvisit : previoushistoryvisits) {

                String[] params2 = {"patientvisitid"};
                Object[] paramsValues2 = {previoushistoryvisit[0]};
                String where2 = "WHERE patientvisitid=:patientvisitid";
                int prevoiusvisitsCount2 = genericClassService.fetchRecordCount(Laboratoryrequest.class, where2, params2, paramsValues2);

                String[] params3 = {"patientvisitid"};
                Object[] paramsValues3 = {previoushistoryvisit[0]};
                String where3 = "WHERE patientvisitid=:patientvisitid";
                int prevoiusvisitspresc = genericClassService.fetchRecordCount(Prescription.class, where3, params3, paramsValues3);

                if (prevoiusvisitsCount2 == 0 && prevoiusvisitspresc == 0) {
                } else {
                    counts += 1;
                }
            }
        }
        results = String.valueOf(counts);
        return results;
    }

    @RequestMapping(value = "/previouspatientvisit.htm")
    public String previouspatientvisit(Model model, HttpServletRequest request) {

        Set<Long> facilityunits = new HashSet<>();

        Set<Long> facilityunitserviceid = new HashSet<>();

        String[] paramsu = {"facilityid"};
        Object[] paramsValuesu = {Integer.parseInt(request.getParameter("facilityid"))};
        String[] fieldsu = {"facilityunitid"};
        List<Long> units = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fieldsu, "WHERE facilityid=:facilityid", paramsu, paramsValuesu);
        if (units != null) {
            for (Long unit : units) {
                facilityunits.add(unit);
            }
        }

        String[] paramsp = {"status", "servicekey"};
        Object[] paramsValuesp = {true, "key_consultation"};
        String[] fieldsp = {"facilityunitserviceid", "facilityunit.facilityunitid"};
        List<Object[]> servicekeys = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fieldsp, "WHERE status=:status AND r.facilityservices.servicekey=:servicekey", paramsp, paramsValuesp);
        if (servicekeys != null) {
            for (Object[] servicekey : servicekeys) {
                if (!facilityunits.isEmpty() && facilityunits.contains((Long) servicekey[1])) {
                    facilityunitserviceid.add((Long) servicekey[0]);
                }
            }
        }
//         List<String>  mylist = new ArrayList<String>();
//         Collections.reverse(mylist);

        Set<Long> patientservices = new HashSet<>();
        String[] paramss = {"patientvisitid"};
        Object[] paramsValuess = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fieldss = {"unitserviceid", "servicequeueid"};
        List<Object[]> services = (List<Object[]>) genericClassService.fetchRecord(Servicequeue.class, fieldss, "WHERE patientvisitid=:patientvisitid ORDER BY servicequeueid ASC", paramss, paramsValuess);
        if (services != null) {
            for (Object[] service : services) {
                patientservices.add(((BigInteger) service[0]).longValue());
            }
        }
        List<Map> visitunitsFound = new ArrayList<>();
        System.out.println("::::::::::::::::::::::::::::::::::::" + patientservices);
        if (!patientservices.isEmpty() && !facilityunitserviceid.isEmpty()) {
            Map<String, Object> unitsRow;
            for (Long patientservice : patientservices) {
                unitsRow = new HashMap<>();
                if (facilityunitserviceid.contains(patientservice)) {

                    List<Map> complaintsFound = new ArrayList<>();
                    List<Map> observationsFound = new ArrayList<>();

                    String[] paramsunit = {"facilityunitserviceid"};
                    Object[] paramsValuesunit = {patientservice};
                    String[] fieldsunit = {"facilityunit.facilityunitid", "facilityunit.facilityunitname"};
                    List<Object[]> unitdetails = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fieldsunit, "WHERE facilityunitserviceid=:facilityunitserviceid", paramsunit, paramsValuesunit);
                    if (unitdetails != null) {

                        String[] params = {"patientvisitid", "facilityunitid"};
                        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid")), unitdetails.get(0)[0]};
                        String[] fields = {"patientcomplaintid", "patientcomplaint", "description"};
                        List<Object[]> previoushistorycomplaints = (List<Object[]>) genericClassService.fetchRecord(Patientcomplaint.class, fields, "WHERE patientvisitid=:patientvisitid AND facilityunitid=:facilityunitid", params, paramsValues);
                        if (previoushistorycomplaints != null) {
                            Map<String, Object> complaintsRow;
                            for (Object[] previoushistoryvisit : previoushistorycomplaints) {
                                complaintsRow = new HashMap<>();
                                complaintsRow.put("patientcomplaintid", previoushistoryvisit[0]);
                                complaintsRow.put("patientcomplaint", previoushistoryvisit[1]);
                                complaintsRow.put("description", previoushistoryvisit[2]);
                                complaintsFound.add(complaintsRow);
                            }
                        }

                        String[] params6 = {"patientvisitid", "facilityunitid"};
                        Object[] paramsValues6 = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))), unitdetails.get(0)[0]};
                        String[] fields6 = {"observation", "patientobservationid"};
                        String where6 = "WHERE patientvisitid=:patientvisitid AND facilityunitid=:facilityunitid";
                        List<Object[]> patienthistoryobservations = (List<Object[]>) genericClassService.fetchRecord(Patientobservation.class, fields6, where6, params6, paramsValues6);
                        if (patienthistoryobservations != null) {
                            Map<String, Object> observationsRow;
                            for (Object[] historyobservation : patienthistoryobservations) {
                                observationsRow = new HashMap<>();
                                observationsRow.put("observation", historyobservation[0]);
                                observationsRow.put("patientobservationid", historyobservation[1]);
                                observationsFound.add(observationsRow);
                            }
                        }

                        String presciptionaddedby = "";
                        String laboratoryaddedby = "";
                        String laboratoryrequestnumber = "";
                        Long laboratoryrequestid = 0L;
                        String labdateadded = "";
                        String prescriptiondate = "";
                        String laboratoryunitname = "";
                        String dispensingunitname = "";
                        String referenceNumber = "";

                        List<Map> prescriptionsFound = new ArrayList<>();
                        String[] params7 = {"patientvisitid", "originunitid"};
                        Object[] paramsValues7 = {Long.parseLong(request.getParameter("patientvisitid")), unitdetails.get(0)[0]};
                        String[] fields7 = {"prescriptionid", "destinationunitid", "addedby", "dateprescribed", "referencenumber"};
                        String where7 = "WHERE patientvisitid =:patientvisitid AND originunitid=:originunitid";
                        List<Object[]> patientsvisitprescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields7, where7, params7, paramsValues7);
                        if (patientsvisitprescriptions != null) {

//                            prescriptiondate = formatter.format((Date) patientsvisitprescriptions.get(0)[3]);
                            prescriptiondate = formatterwithtime.format((Date) patientsvisitprescriptions.get(0)[3]).replaceAll("PM", "pm").replaceAll("AM", "am");
                            referenceNumber = patientsvisitprescriptions.get(0)[4].toString();
                            String[] params2 = {"prescriptionid"};
                            Object[] paramsValues2 = {patientsvisitprescriptions.get(0)[0]};
                            String[] fields2 = {"prescriptionitemsid", "itemid", "dosage", "days", "daysname", "notes", "dose"};
                            String where2 = "WHERE prescriptionid=:prescriptionid";
                            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields2, where2, params2, paramsValues2);
                            if (prescriptions != null) {
                                Map<String, Object> itemsRow;
                                for (Object[] prescription : prescriptions) {
                                    itemsRow = new HashMap<>();

                                    String[] params4 = {"itemid"};
                                    Object[] paramsValues4 = {BigInteger.valueOf((Long) prescription[1])};
                                    String[] fields4 = {"genericname"};
                                    String where4 = "WHERE itemid=:itemid";
                                    List<String> prescribedItems = (List<String>) genericClassService.fetchRecord(Itemcategories.class, fields4, where4, params4, paramsValues4);
                                    if (prescribedItems != null) {
                                        itemsRow.put("fullname", prescribedItems.get(0));
                                    }
                                    itemsRow.put("dosage", prescription[2]);
                                    itemsRow.put("days", prescription[3]);
                                    itemsRow.put("daysname", prescription[4]);

                                    if (prescription[5] != null) {
                                        itemsRow.put("notes", prescription[5]);
                                    } else {
                                        itemsRow.put("notes", "----------");
                                    }
                                    if (prescription[6] != null) {
                                        itemsRow.put("dose", prescription[6]);
                                    } else {
                                        itemsRow.put("dose", "----------");
                                    }

                                    prescriptionsFound.add(itemsRow);
                                }
                            } else {
                                params = new String[]{"prescriptionid"};
                                paramsValues = new Object[]{patientsvisitprescriptions.get(0)[0]};
                                String where = "WHERE prescriptionid=:prescriptionid";
                                fields = new String[]{"newprescriptionitemsid", "itemname", "dosage", "days", "daysname", "notes", "dose"};
                                List<Object[]> newPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
                                if (newPrescriptions != null) {
                                    Map<String, Object> itemsRow;
                                    for (Object[] newPrescription : newPrescriptions) {
                                        itemsRow = new HashMap<>();
                                        itemsRow.put("fullname", newPrescription[1].toString());
                                        itemsRow.put("dosage", newPrescription[2]);
                                        itemsRow.put("days", newPrescription[3]);
                                        itemsRow.put("daysname", newPrescription[4]);
                                        if (newPrescription[5] != null) {
                                            itemsRow.put("notes", newPrescription[5]);
                                        } else {
                                            itemsRow.put("notes", "----------");
                                        }
                                        if (newPrescription[6] != null) {
                                            itemsRow.put("dose", newPrescription[6]);
                                        } else {
                                            itemsRow.put("dose", "----------");
                                        }
                                        prescriptionsFound.add(itemsRow);
                                    }
                                }
                            }
                            String[] params5 = {"staffid"};
                            Object[] paramsValues5 = {patientsvisitprescriptions.get(0)[2]};
                            String[] fields5 = {"firstname", "othernames", "lastname"};
                            List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, "WHERE staffid=:staffid", params5, paramsValues5);
                            if (addedby != null) {
                                presciptionaddedby = addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2];
                            }
                            String[] params19 = {"facilityunitid"};
                            Object[] paramsValues19 = {patientsvisitprescriptions.get(0)[1]};
                            String[] fields19 = {"facilityunitname"};
                            List<String> dispensing = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields19, "WHERE facilityunitid=:facilityunitid", params19, paramsValues19);
                            if (dispensing != null) {
                                dispensingunitname = dispensing.get(0);
                            }

                        }

                        List<Map> labtestsFound = new ArrayList<>();

                        String[] params5 = {"patientvisitid", "originunit"};
                        Object[] paramsValues5 = {Long.parseLong(request.getParameter("patientvisitid")), unitdetails.get(0)[0]};
                        String[] fields5 = {"laboratoryrequestnumber", "laboratoryrequestid", "dateadded", "destinationunit", "addedby"};
                        List<Object[]> labvisits = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields5, "WHERE patientvisitid=:patientvisitid AND originunit=:originunit", params5, paramsValues5);
                        if (labvisits != null) {
                            laboratoryrequestnumber = (String) labvisits.get(0)[0];
                            laboratoryrequestid = (Long) labvisits.get(0)[1];
                            labdateadded = formatter.format((Date) labvisits.get(0)[2]);

                            String[] params0 = {"laboratoryrequestid"};
                            Object[] paramsValues0 = {labvisits.get(0)[1]};
                            String[] fields0 = {"laboratorytestid", "laboratoryrequesttestid", "iscompleted"};
                            List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields0, "WHERE laboratoryrequestid=:laboratoryrequestid", params0, paramsValues0);
                            if (labtests != null) {
                                Map<String, Object> testsRow;
                                for (Object[] labtest : labtests) {
                                    testsRow = new HashMap<>();

                                    String[] params3 = {"laboratorytestid"};
                                    Object[] paramsValues3 = {labtest[0]};
                                    String[] fields3 = {"laboratorytestid", "testname", "labtestclassificationid"};
                                    String where3 = "WHERE laboratorytestid=:laboratorytestid";
                                    List<Object[]> test = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields3, where3, params3, paramsValues3);
                                    if (test != null) {

                                        String[] params4 = {"labtestclassificationid"};
                                        Object[] paramsValues4 = {test.get(0)[2]};
                                        String[] fields4 = {"labtestclassificationname"};
                                        List<String> specimen = (List<String>) genericClassService.fetchRecord(Labtestclassification.class, fields4, "WHERE labtestclassificationid=:labtestclassificationid", params4, paramsValues4);
                                        if (specimen != null) {
                                            testsRow.put("specimen", specimen.get(0));
                                        }
                                        testsRow.put("laboratorytestid", test.get(0)[0]);
                                        testsRow.put("testname", test.get(0)[1]);
                                        testsRow.put("iscompleted", labtest[2]);

                                        labtestsFound.add(testsRow);
                                    }
                                }
                            }
                            String[] params9 = {"staffid"};
                            Object[] paramsValues9 = {labvisits.get(0)[4]};
                            String[] fields9 = {"firstname", "othernames", "lastname"};
                            List<Object[]> labaddedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields9, "WHERE staffid=:staffid", params9, paramsValues9);
                            if (labaddedby != null) {
                                laboratoryaddedby = labaddedby.get(0)[0] + " " + labaddedby.get(0)[1] + " " + labaddedby.get(0)[2];
                            }

                            String[] params19 = {"facilityunitid"};
                            Object[] paramsValues19 = {labvisits.get(0)[3]};
                            String[] fields19 = {"facilityunitname"};
                            List<String> laboratoryunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields19, "WHERE facilityunitid=:facilityunitid", params19, paramsValues19);
                            if (laboratoryunit != null) {
                                laboratoryunitname = laboratoryunit.get(0);
                            }

                        }
                        List<Map> internalreferralsFound = new ArrayList<>();

                        String[] paramsr = {"patientvisitid", "referringunitid"};
                        Object[] paramsValuesr = {Long.parseLong(request.getParameter("patientvisitid")), unitdetails.get(0)[0]};
                        String[] fieldsr = {"internalreferralid", "referralunitid", "addedby", "referralnotes", "referredto", "specialty"};
                        List<Object[]> internalreferral = (List<Object[]>) genericClassService.fetchRecord(Internalreferral.class, fieldsr, "WHERE patientvisitid=:patientvisitid AND referringunitid=:referringunitid", paramsr, paramsValuesr);
                        if (internalreferral != null) {
                            Map<String, Object> referralRow;
                            for (Object[] internal : internalreferral) {
                                referralRow = new HashMap<>();
                                referralRow.put("internalreferralid", internal[0]);
                                referralRow.put("referralnotes", internal[3]);

                                String[] params9 = {"facilityunitid"};
                                Object[] paramsValues9 = {internal[1]};
                                String[] fields9 = {"facilityunitname"};
                                List<String> unit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields9, "WHERE facilityunitid=:facilityunitid", params9, paramsValues9);
                                if (unit != null) {
                                    referralRow.put("unit", unit.get(0));
                                }
                                referralRow.put("internalreferralid", internal[0]);
                                internalreferralsFound.add(referralRow);
                            }
                        }

                        if (!labtestsFound.isEmpty() || !prescriptionsFound.isEmpty() || !complaintsFound.isEmpty() || !internalreferralsFound.isEmpty()) {
                            unitsRow.put("labtestsFound", labtestsFound);
                            unitsRow.put("prescriptionsFound", prescriptionsFound);
                            unitsRow.put("complaintsFound", complaintsFound);
                            unitsRow.put("observationsFound", observationsFound);
                            unitsRow.put("internalreferralsFound", internalreferralsFound);

                            unitsRow.put("facilityunitid", unitdetails.get(0)[0]);
                            unitsRow.put("facilityunitname", unitdetails.get(0)[1]);
                            unitsRow.put("presciptionaddedby", presciptionaddedby);
                            unitsRow.put("laboratoryaddedby", laboratoryaddedby);
                            unitsRow.put("laboratoryrequestnumber", laboratoryrequestnumber);
                            unitsRow.put("laboratoryrequestid", laboratoryrequestid);
                            unitsRow.put("labdateadded", labdateadded);
                            unitsRow.put("prescriptiondate", prescriptiondate);
                            unitsRow.put("referencenumber", referenceNumber);
                            unitsRow.put("laboratoryunitname", laboratoryunitname);
                            unitsRow.put("dispensingunitname", dispensingunitname);

                            visitunitsFound.add(unitsRow);
                        }

                    }
                }
            }
        }

        model.addAttribute("visitunitsFound", visitunitsFound);

        String[] params1 = {"patientvisitid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields1 = {"weight", "temperature", "height", "pulse", "headcircum", "bodysurfacearea", "respirationrate", "patientpressuresystolic", "patientpressurediastolic"};
        String where1 = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patienttriages = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields1, where1, params1, paramsValues1);
        if (patienttriages != null) {
            if (patienttriages.get(0)[0] != null) {
                model.addAttribute("weight", patienttriages.get(0)[0]);
            } else {
                model.addAttribute("weight", 0);
            }
            if (patienttriages.get(0)[1] != null) {
                model.addAttribute("temperature", patienttriages.get(0)[1]);
            } else {
                model.addAttribute("temperature", 0);
            }
            if (patienttriages.get(0)[2] != null) {
                model.addAttribute("height", patienttriages.get(0)[2]);
            } else {
                model.addAttribute("height", 0);
            }
            if (patienttriages.get(0)[3] != null) {
                model.addAttribute("pulse", patienttriages.get(0)[3]);
            } else {
                model.addAttribute("pulse", 0);
            }
            if (patienttriages.get(0)[4] != null) {
                model.addAttribute("headcircum", patienttriages.get(0)[4]);
            } else {
                model.addAttribute("headcircum", 0);
            }
            if (patienttriages.get(0)[5] != null) {
                model.addAttribute("bodysurfacearea", patienttriages.get(0)[5]);
            } else {
                model.addAttribute("bodysurfacearea", 0);
            }
            if (patienttriages.get(0)[6] != null) {
                model.addAttribute("respirationrate", patienttriages.get(0)[6]);
            } else {
                model.addAttribute("respirationrate", 0);
            }
            if (patienttriages.get(0)[7] != null) {
                model.addAttribute("systolic", patienttriages.get(0)[7]);
            } else {
                model.addAttribute("systolic", 0);
            }
            if (patienttriages.get(0)[8] != null) {
                model.addAttribute("diastolic", patienttriages.get(0)[8]);
            } else {
                model.addAttribute("diastolic", 0);
            }
            if (patienttriages.get(0)[2] != null && patienttriages.get(0)[0] != null) {
                model.addAttribute("bmi", String.format("%.02f", (Double) patienttriages.get(0)[0] / ((((Double) patienttriages.get(0)[2]) * 0.01) * (((Double) patienttriages.get(0)[2]) * 0.01))) + " " + "");
            } else {
                model.addAttribute("bmi", "pending");
            }
        } else {
            model.addAttribute("bmi", "pending");
            model.addAttribute("systolic", 0);
            model.addAttribute("diastolic", 0);
            model.addAttribute("respirationrate", 0);
            model.addAttribute("bodysurfacearea", 0);
            model.addAttribute("headcircum", 0);
            model.addAttribute("pulse", 0);
            model.addAttribute("height", 0);
            model.addAttribute("temperature", 0);
            model.addAttribute("weight", 0);
        }

        //
        String[] params = new String[]{"patientvisitid"};
        Object[] paramsValues = new Object[]{Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields = new String[]{"triagevalidationskipid", "skippedfield", "reason",
            "patientvisitid", "addedby", "dateadded", "facilityunitid"};
        String where = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> validationSkips = (List<Object[]>) genericClassService.fetchRecord(Triagevalidationskip.class, fields, where, params, paramsValues);
        if (validationSkips != null) {
            for (Object[] skip : validationSkips) {
                String skippedfield = skip[1].toString().toLowerCase();
                if (skippedfield.equalsIgnoreCase("Weight")) {
                    model.addAttribute("weightReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Height")) {
                    model.addAttribute("HeightReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Temperature")) {
                    model.addAttribute("TempReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Respiration Rate")) {
                    model.addAttribute("RespirationReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Blood Pressure")) {
                    model.addAttribute("PressureReason", skip[2]);
                }
            }
            model.addAttribute("reasonAdded", formatter.format(((Date) validationSkips.get(0)[5])));
            params = new String[]{"facilityunitid"};
            paramsValues = new Object[]{validationSkips.get(0)[6]};
            fields = new String[]{"facilityunitname"};
            List<String> validationSkipUnits = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields, "WHERE facilityunitid=:facilityunitid", params, paramsValues);
            if (validationSkipUnits != null) {
                model.addAttribute("reasonUnit", validationSkipUnits.get(0));
            }
            params = new String[]{"staffid"};
            paramsValues = new Object[]{BigInteger.valueOf((Long) validationSkips.get(0)[4])};
            fields = new String[]{"firstname", "lastname", "othernames", "personid"};
            List<Object[]> staffList = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, "WHERE staffid=:staffid", params, paramsValues);
            if (staffList != null) {
                Object[] staff = staffList.get(0);
                if (staff[2] != null) {
                    model.addAttribute("reasonBy", staff[0] + " " + staff[1] + " " + staff[2]);
                } else {
                    model.addAttribute("reasonBy", staff[0] + " " + staff[1]);
                }
                List<Object[]> contacts = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, new String[]{"contactvalue", "contacttype"}, "WHERE personid=:personid", new String[]{"personid"}, new Object[]{staff[3]});
                if (contacts != null) {
                    String tel = "";
                    for (Object[] contact : contacts) {
                        if (contact[0].toString().equalsIgnoreCase("EMAIL")) {
                            model.addAttribute("email", contact[1]);
                        } else if (contact[0].toString().equalsIgnoreCase("PRIMARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        } else if (contact[0].toString().equalsIgnoreCase("SECONDARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        }
                    }
                    model.addAttribute("contacts", tel);
                }
            }
        }
        //

        model.addAttribute("facility", request.getParameter("facilityname"));
        model.addAttribute("facilitydate", request.getParameter("date"));
        model.addAttribute("visitnumber", request.getParameter("visitnumber"));
        return "doctorConsultations/views/visitDetails";
    }

    @RequestMapping(value = "/patientvisitdetails.htm", method = RequestMethod.GET)
    public String patientvisitdetails(Model model, HttpServletRequest request) {

        String[] paramsy = {"patientid"};
        Object[] paramsValuesy = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fieldsy = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin"};
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fieldsy, "WHERE patientid=:patientid", paramsy, paramsValuesy);
        if (patientsvisits != null) {
            String[] params5 = {"personid"};
            Object[] paramsValues5 = {patientsvisits.get(0)[0]};
            String[] fields5 = {"dob", "estimatedage", "gender"};
            List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5, "WHERE personid=:personid", params5, paramsValues5);

            model.addAttribute("name", patientsvisits.get(0)[1] + " " + patientsvisits.get(0)[3] + " " + patientsvisits.get(0)[2]);
            model.addAttribute("patientno", patientsvisits.get(0)[4]);
            model.addAttribute("telephone", patientsvisits.get(0)[5]);
            model.addAttribute("nextofkin", patientsvisits.get(0)[6]);
            model.addAttribute("dob", formatter.format((Date) patientdetails.get(0)[0]));
            model.addAttribute("gender", patientdetails.get(0)[2]);

            SimpleDateFormat df = new SimpleDateFormat("yyyy");
            int year = Integer.parseInt(df.format((Date) patientdetails.get(0)[0]));
            int currentyear = Integer.parseInt(df.format(new Date()));
            model.addAttribute("estimatedage", currentyear - year);

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }

        String[] params1 = {"patientvisitid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields1 = {"weight", "temperature", "height", "pulse", "headcircum", "bodysurfacearea", "respirationrate", "patientpressuresystolic", "patientpressurediastolic"};
        String where1 = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patienttriages = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields1, where1, params1, paramsValues1);
        if (patienttriages != null) {
            if (patienttriages.get(0)[0] != null) {
                model.addAttribute("weight", patienttriages.get(0)[0]);
            } else {
                model.addAttribute("weight", 0);
            }
            if (patienttriages.get(0)[1] != null) {
                model.addAttribute("temperature", patienttriages.get(0)[1]);
            } else {
                model.addAttribute("temperature", 0);
            }
            if (patienttriages.get(0)[2] != null) {
                model.addAttribute("height", patienttriages.get(0)[2]);
            } else {
                model.addAttribute("height", 0);
            }
            if (patienttriages.get(0)[3] != null) {
                model.addAttribute("pulse", patienttriages.get(0)[3]);
            } else {
                model.addAttribute("pulse", 0);
            }
            if (patienttriages.get(0)[4] != null) {
                model.addAttribute("headcircum", patienttriages.get(0)[4]);
            } else {
                model.addAttribute("headcircum", 0);
            }
            if (patienttriages.get(0)[5] != null) {
                model.addAttribute("bodysurfacearea", patienttriages.get(0)[5]);
            } else {
                model.addAttribute("bodysurfacearea", 0);
            }
            if (patienttriages.get(0)[6] != null) {
                model.addAttribute("respirationrate", patienttriages.get(0)[6]);
            } else {
                model.addAttribute("respirationrate", 0);
            }
            if (patienttriages.get(0)[7] != null) {
                model.addAttribute("systolic", patienttriages.get(0)[7]);
            } else {
                model.addAttribute("systolic", 0);
            }
            if (patienttriages.get(0)[8] != null) {
                model.addAttribute("diastolic", patienttriages.get(0)[8]);
            } else {
                model.addAttribute("diastolic", 0);
            }
            if (patienttriages.get(0)[2] != null && patienttriages.get(0)[0] != null) {
                model.addAttribute("bmi", String.format("%.02f", (Double) patienttriages.get(0)[0] / ((((Double) patienttriages.get(0)[2]) * 0.01) * (((Double) patienttriages.get(0)[2]) * 0.01))) + " " + "");
            } else {
                model.addAttribute("bmi", "pending");
            }
        } else {
            model.addAttribute("bmi", "pending");
            model.addAttribute("systolic", 0);
            model.addAttribute("diastolic", 0);
            model.addAttribute("respirationrate", 0);
            model.addAttribute("bodysurfacearea", 0);
            model.addAttribute("headcircum", 0);
            model.addAttribute("pulse", 0);
            model.addAttribute("height", 0);
            model.addAttribute("temperature", 0);
            model.addAttribute("weight", 0);
        }
        //
        String[] paramsValidationSkip = new String[]{"patientvisitid"};
        Object[] paramsValuesValidationSkip = new Object[]{Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fieldsValidationSkip = new String[]{"triagevalidationskipid", "skippedfield", "reason",
            "patientvisitid", "addedby", "dateadded", "facilityunitid"};
        String where = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> validationSkips = (List<Object[]>) genericClassService.fetchRecord(Triagevalidationskip.class, fieldsValidationSkip, where, paramsValidationSkip, paramsValuesValidationSkip);
        if (validationSkips != null) {
            for (Object[] skip : validationSkips) {
                String skippedfield = skip[1].toString().toLowerCase();
                if (skippedfield.equalsIgnoreCase("Weight")) {
                    model.addAttribute("weightReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Height")) {
                    model.addAttribute("HeightReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Temperature")) {
                    model.addAttribute("TempReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Respiration Rate")) {
                    model.addAttribute("RespirationReason", skip[2]);
                } else if (skippedfield.equalsIgnoreCase("Blood Pressure")) {
                    model.addAttribute("PressureReason", skip[2]);
                }
            }
            model.addAttribute("reasonAdded", formatter.format(((Date) validationSkips.get(0)[5])));
            paramsValidationSkip = new String[]{"facilityunitid"};
            paramsValuesValidationSkip = new Object[]{validationSkips.get(0)[6]};
            fieldsValidationSkip = new String[]{"facilityunitname"};
            List<String> units = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsValidationSkip, "WHERE facilityunitid=:facilityunitid", paramsValidationSkip, paramsValuesValidationSkip);
            if (units != null) {
                model.addAttribute("reasonUnit", units.get(0));
            }
            paramsValidationSkip = new String[]{"staffid"};
            paramsValuesValidationSkip = new Object[]{BigInteger.valueOf((Long) validationSkips.get(0)[4])};
            fieldsValidationSkip = new String[]{"firstname", "lastname", "othernames", "personid"};
            List<Object[]> staffList = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsValidationSkip, "WHERE staffid=:staffid", paramsValidationSkip, paramsValuesValidationSkip);
            if (staffList != null) {
                Object[] staff = staffList.get(0);
                if (staff[2] != null) {
                    model.addAttribute("reasonBy", staff[0] + " " + staff[1] + " " + staff[2]);
                } else {
                    model.addAttribute("reasonBy", staff[0] + " " + staff[1]);
                }
                List<Object[]> contacts = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, new String[]{"contactvalue", "contacttype"}, "WHERE personid=:personid", new String[]{"personid"}, new Object[]{staff[3]});
                if (contacts != null) {
                    String tel = "";
                    for (Object[] contact : contacts) {
                        if (contact[0].toString().equalsIgnoreCase("EMAIL")) {
                            model.addAttribute("email", contact[1]);
                        } else if (contact[0].toString().equalsIgnoreCase("PRIMARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        } else if (contact[0].toString().equalsIgnoreCase("SECONDARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        }
                    }
                    model.addAttribute("contacts", tel);
                }
            }
        }
        //
        List<Map> complaintsFound = new ArrayList<>();
        String[] params = {"patientvisitid", "facilityunitid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"patientcomplaintid", "patientcomplaint", "description"};
        List<Object[]> previoushistorycomplaints = (List<Object[]>) genericClassService.fetchRecord(Patientcomplaint.class, fields, "WHERE patientvisitid=:patientvisitid AND facilityunitid=:facilityunitid", params, paramsValues);
        if (previoushistorycomplaints != null) {
            Map<String, Object> complaintsRow;
            for (Object[] previoushistoryvisit : previoushistorycomplaints) {
                complaintsRow = new HashMap<>();
                complaintsRow.put("patientcomplaintid", previoushistoryvisit[0]);
                complaintsRow.put("patientcomplaint", previoushistoryvisit[1]);
                complaintsRow.put("description", previoushistoryvisit[2]);
                complaintsFound.add(complaintsRow);
            }
        }
        List<Map> observationsFound = new ArrayList<>();
        String[] params6 = {"patientvisitid", "facilityunitid"};
        Object[] paramsValues6 = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields6 = {"observation", "patientobservationid"};
        String where6 = "WHERE patientvisitid=:patientvisitid AND facilityunitid=:facilityunitid";
        List<Object[]> patienthistoryobservations = (List<Object[]>) genericClassService.fetchRecord(Patientobservation.class, fields6, where6, params6, paramsValues6);
        if (patienthistoryobservations != null) {
            Map<String, Object> observationsRow;
            for (Object[] historyobservation : patienthistoryobservations) {
                observationsRow = new HashMap<>();
                observationsRow.put("observation", historyobservation[0]);
                observationsRow.put("patientobservationid", historyobservation[1]);
                observationsFound.add(observationsRow);
            }
        }

        String presciptionaddedby = "";
        String laboratoryaddedby = "";
        String laboratoryrequestnumber = "";
        Long laboratoryrequestid = 0L;
        String labdateadded = "";
        String prescriptiondate = "";
        String laboratoryunitname = "";
        String dispensingunitname = "";
        String referenceNumber = "";

        List<Map> prescriptionsFound = new ArrayList<>();
        String[] params7 = {"patientvisitid", "originunitid"};
        Object[] paramsValues7 = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields7 = {"prescriptionid", "destinationunitid", "addedby", "dateprescribed", "referencenumber"};
        String where7 = "WHERE patientvisitid =:patientvisitid AND originunitid=:originunitid";
        List<Object[]> patientsvisitprescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields7, where7, params7, paramsValues7);
        if (patientsvisitprescriptions != null) {

//            prescriptiondate = formatter.format((Date) patientsvisitprescriptions.get(0)[3]);
            prescriptiondate = formatterwithtime.format((Date) patientsvisitprescriptions.get(0)[3]).replaceAll("PM", "pm").replaceAll("AM", "am");
            referenceNumber = patientsvisitprescriptions.get(0)[4].toString();
            String[] params2 = {"prescriptionid"};
            Object[] paramsValues2 = {patientsvisitprescriptions.get(0)[0]};
            String[] fields2 = {"prescriptionitemsid", "itemid", "dosage", "days", "daysname", "notes", "dose"};
            String where2 = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields2, where2, params2, paramsValues2);
            if (prescriptions != null) {
                Map<String, Object> itemsRow;
                for (Object[] prescription : prescriptions) {
                    itemsRow = new HashMap<>();

                    String[] params4 = {"itemid"};
                    Object[] paramsValues4 = {BigInteger.valueOf((Long) prescription[1])};
                    String[] fields4 = {"genericname"};
                    String where4 = "WHERE itemid=:itemid";
                    List<String> prescribedItems = (List<String>) genericClassService.fetchRecord(Itemcategories.class, fields4, where4, params4, paramsValues4);
                    if (prescribedItems != null) {
                        itemsRow.put("fullname", prescribedItems.get(0));
                    }
                    itemsRow.put("dosage", prescription[2]);
                    itemsRow.put("days", prescription[3]);
                    itemsRow.put("daysname", prescription[4]);

                    if (prescription[5] != null) {
                        itemsRow.put("notes", prescription[5]);
                    } else {
                        itemsRow.put("notes", "----------");
                    }
                    if (prescription[6] != null) {
                        itemsRow.put("dose", prescription[6]);
                    } else {
                        itemsRow.put("dose", "----------");
                    }

                    prescriptionsFound.add(itemsRow);
                }
            } else {
                params = new String[]{"prescriptionid"};
                paramsValues = new Object[]{patientsvisitprescriptions.get(0)[0]};
                fields = new String[]{"newprescriptionitemsid", "itemname", "dosage", "days", "daysname", "notes", "dose"};
                where = "WHERE prescriptionid=:prescriptionid";
                List<Object[]> newPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
                if (newPrescriptions != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] newPrescription : newPrescriptions) {
                        itemsRow = new HashMap<>();
                        itemsRow.put("fullname", newPrescription[1].toString());
                        itemsRow.put("dosage", newPrescription[2]);
                        itemsRow.put("days", newPrescription[3]);
                        itemsRow.put("daysname", newPrescription[4]);
                        if (newPrescription[5] != null) {
                            itemsRow.put("notes", newPrescription[5]);
                        } else {
                            itemsRow.put("notes", "----------");
                        }
                        if (newPrescription[6] != null) {
                            itemsRow.put("dose", newPrescription[6]);
                        } else {
                            itemsRow.put("dose", "----------");
                        }
                        prescriptionsFound.add(itemsRow);
                    }
                }
            }
            String[] params5 = {"staffid"};
            Object[] paramsValues5 = {patientsvisitprescriptions.get(0)[2]};
            String[] fields5 = {"firstname", "othernames", "lastname"};
            List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, "WHERE staffid=:staffid", params5, paramsValues5);
            if (addedby != null) {
                presciptionaddedby = addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2];
            }
            String[] params19 = {"facilityunitid"};
            Object[] paramsValues19 = {patientsvisitprescriptions.get(0)[1]};
            String[] fields19 = {"facilityunitname"};
            List<String> dispensing = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields19, "WHERE facilityunitid=:facilityunitid", params19, paramsValues19);
            if (dispensing != null) {
                dispensingunitname = dispensing.get(0);
            }

        }

        List<Map> labtestsFound = new ArrayList<>();

        String[] params5 = {"patientvisitid", "originunit"};
        Object[] paramsValues5 = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields5 = {"laboratoryrequestnumber", "laboratoryrequestid", "dateadded", "destinationunit", "addedby"};
        List<Object[]> labvisits = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields5, "WHERE patientvisitid=:patientvisitid AND originunit=:originunit", params5, paramsValues5);
        if (labvisits != null) {
            laboratoryrequestnumber = (String) labvisits.get(0)[0];
            laboratoryrequestid = (Long) labvisits.get(0)[1];
            labdateadded = formatter.format((Date) labvisits.get(0)[2]);

            String[] params0 = {"laboratoryrequestid"};
            Object[] paramsValues0 = {labvisits.get(0)[1]};
            String[] fields0 = {"laboratorytestid", "laboratoryrequesttestid", "iscompleted"};
            List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields0, "WHERE laboratoryrequestid=:laboratoryrequestid", params0, paramsValues0);
            if (labtests != null) {
                Map<String, Object> testsRow;
                for (Object[] labtest : labtests) {
                    testsRow = new HashMap<>();

                    String[] params3 = {"laboratorytestid"};
                    Object[] paramsValues3 = {labtest[0]};
                    String[] fields3 = {"laboratorytestid", "testname", "labtestclassificationid"};
                    String where3 = "WHERE laboratorytestid=:laboratorytestid";
                    List<Object[]> test = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields3, where3, params3, paramsValues3);
                    if (test != null) {

                        String[] params4 = {"labtestclassificationid"};
                        Object[] paramsValues4 = {test.get(0)[2]};
                        String[] fields4 = {"labtestclassificationname"};
                        List<String> specimen = (List<String>) genericClassService.fetchRecord(Labtestclassification.class, fields4, "WHERE labtestclassificationid=:labtestclassificationid", params4, paramsValues4);
                        if (specimen != null) {
                            testsRow.put("specimen", specimen.get(0));
                        }
                        testsRow.put("laboratorytestid", test.get(0)[0]);
                        testsRow.put("testname", test.get(0)[1]);
                        testsRow.put("iscompleted", labtest[2]);

                        labtestsFound.add(testsRow);
                    }
                }
            }
            String[] params9 = {"staffid"};
            Object[] paramsValues9 = {labvisits.get(0)[4]};
            String[] fields9 = {"firstname", "othernames", "lastname"};
            List<Object[]> labaddedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields9, "WHERE staffid=:staffid", params9, paramsValues9);
            if (labaddedby != null) {
                laboratoryaddedby = labaddedby.get(0)[0] + " " + labaddedby.get(0)[1] + " " + labaddedby.get(0)[2];
            }

            String[] params19 = {"facilityunitid"};
            Object[] paramsValues19 = {labvisits.get(0)[3]};
            String[] fields19 = {"facilityunitname"};
            List<String> laboratoryunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields19, "WHERE facilityunitid=:facilityunitid", params19, paramsValues19);
            if (laboratoryunit != null) {
                laboratoryunitname = laboratoryunit.get(0);
            }

        }
        List<Map> internalreferralsFound = new ArrayList<>();

        String[] paramsr = {"patientvisitid", "referringunitid"};
        Object[] paramsValuesr = {Long.parseLong(request.getParameter("patientvisitid")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fieldsr = {"internalreferralid", "referralunitid", "addedby", "referralnotes", "referredto", "specialty"};
        List<Object[]> internalreferral = (List<Object[]>) genericClassService.fetchRecord(Internalreferral.class, fieldsr, "WHERE patientvisitid=:patientvisitid AND referringunitid=:referringunitid", paramsr, paramsValuesr);
        if (internalreferral != null) {
            Map<String, Object> referralRow;
            for (Object[] internal : internalreferral) {
                referralRow = new HashMap<>();
                referralRow.put("internalreferralid", internal[0]);
                referralRow.put("referralnotes", internal[3]);

                String[] params9 = {"facilityunitid"};
                Object[] paramsValues9 = {internal[1]};
                String[] fields9 = {"facilityunitname"};
                List<String> unit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields9, "WHERE facilityunitid=:facilityunitid", params9, paramsValues9);
                if (unit != null) {
                    referralRow.put("unit", unit.get(0));
                }
                referralRow.put("internalreferralid", internal[0]);
                internalreferralsFound.add(referralRow);
            }
        }

        model.addAttribute("labtestsFound", labtestsFound);
        model.addAttribute("prescriptionsFound", prescriptionsFound);
        model.addAttribute("complaintsFound", complaintsFound);
        model.addAttribute("observationsFound", observationsFound);
        model.addAttribute("internalreferralsFound", internalreferralsFound);

        model.addAttribute("presciptionaddedby", presciptionaddedby);
        model.addAttribute("laboratoryaddedby", laboratoryaddedby);
        model.addAttribute("laboratoryrequestnumber", laboratoryrequestnumber);
        model.addAttribute("laboratoryrequestid", laboratoryrequestid);
        model.addAttribute("labdateadded", labdateadded);
        model.addAttribute("prescriptiondate", prescriptiondate);
        model.addAttribute("referencenumber", referenceNumber);
        model.addAttribute("laboratoryunitname", laboratoryunitname);
        model.addAttribute("dispensingunitname", dispensingunitname);
        return "doctorConsultations/views/register/patientDteails";
    }

    @RequestMapping(value = "/patientobservationcount", method = RequestMethod.GET)
    public @ResponseBody
    String getPatientObservationCount(Model model, HttpServletRequest request) {
        int count = 0;
        try {
            int patientvisitid = Integer.parseInt(request.getParameter("patientvisitid"));
            int clinicianObservationsCount = genericClassService.fetchRecordCount(Patientobservation.class, "WHERE patientvisitid=:patientvisitid", new String[]{"patientvisitid"}, new Object[]{patientvisitid});
            int patientComplaintsCount = genericClassService.fetchRecordCount(Patientcomplaint.class, "WHERE patientvisitid=:patientvisitid", new String[]{"patientvisitid"}, new Object[]{patientvisitid});
            int prescriptionCount = 0;
            int labRequestCount = 0;
            int referralsCount = 0;
            if (clinicianObservationsCount != 0 || patientComplaintsCount != 0) {
                prescriptionCount = genericClassService.fetchRecordCount(Prescription.class, "WHERE patientvisitid=:patientvisitid", new String[]{"patientvisitid"}, new Object[]{patientvisitid});
                labRequestCount = genericClassService.fetchRecordCount(Laboratoryrequest.class, "WHERE patientvisitid=:patientvisitid", new String[]{"patientvisitid"}, new Object[]{patientvisitid});
                referralsCount = genericClassService.fetchRecordCount(Internalreferral.class, "WHERE patientvisitid=:patientvisitid", new String[]{"patientvisitid"}, new Object[]{patientvisitid});
                if ((prescriptionCount == 0 && labRequestCount == 0 && referralsCount == 0)) { // if no prescription, no lab request and no referrals. return 0.
                    clinicianObservationsCount = 0;
                    patientComplaintsCount = 0;
                }
            }
            count = clinicianObservationsCount + patientComplaintsCount + prescriptionCount + labRequestCount;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return String.valueOf(count);
    }

    @RequestMapping(value = "/checkitemalreadyprescribed", method = RequestMethod.GET)
    public @ResponseBody
    String checkItemAlreadyPrescribed(HttpServletRequest request) {
        String result = "noitem";
        try {
            final Map<String, Object> item = new HashMap<>();
            final String itemName = request.getParameter("itemname");
            final long patientId = Long.parseLong(request.getParameter("patientid"));
            String[] fields = {
                "visitnumber", "visitedunit", "dateprescribed", "referencenumber", "dosage", "dose", "days",
                "daysname", "itemname", "issuedby", "dateissued", "quantitydispensed"
            };
            String[] params = {"itemname", "patientid"};
            Object[] paramsValues = {itemName.trim().toLowerCase(), BigInteger.valueOf(patientId)};
            String where = "WHERE patientid=:patientid AND LOWER(TRIM(itemname))=:itemname";
            List<Object[]> issuedItems = (List<Object[]>) genericClassService.fetchRecord(Issuedprescriptionitemsview.class, fields, where, params, paramsValues);

            if (issuedItems != null) {
                long daysLeft = 0L;
                for (Object[] issuedItem : issuedItems) {
                    int days = Integer.parseInt(issuedItem[6].toString());
                    String daysName = issuedItem[7].toString();
                    Date dateIssued = formatter2.parse(issuedItem[10].toString());
                    daysLeft = getDaysLeft(days, daysName.trim().toLowerCase(), dateIssued);
                    if (daysLeft > 0) {
                        if (daysLeft < 3) {
                            item.put("message", "This item was previously prescribed to this patient and its left with " + daysLeft + " " + "days! Would you like to continue prescribing it ?");
                        } else {
                            item.put("visitnumber", issuedItem[0]);
                            item.put("referencenumber", issuedItem[3]);
                            item.put("dosage", issuedItem[4]);
                            item.put("dose", issuedItem[5]);
                            item.put("days", days);
                            item.put("daysname", daysName);
                            item.put("itemname", issuedItem[8]);
                            item.put("dateissued", formatter.format(dateIssued));
                            item.put("quantitydispensed", issuedItem[11]);
                        }
                    }

                }

                if (item.containsKey("visitnumber") || item.containsKey("message")) {
                    item.put("daysLeft", daysLeft);
                    result = new ObjectMapper().writeValueAsString(item);
                } else {
                    result = "noitem";
                }
            }
        } catch (JsonProcessingException | NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
	
	   @RequestMapping(value = "/patientclinicalnotesform.htm", method = RequestMethod.GET)
    public String patientclinicalnotesform(Model model, HttpServletRequest request) {
        List<Map> complaintsFound = new ArrayList<>();
        List<Map> commentsFound = new ArrayList<>();
        List<Map> interimFound = new ArrayList<>();

        String[] params = {"patientvisitid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields = {"patientcomplaintid", "patientcomplaint", "description", "addedby"};
        String where = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patientcomplaints = (List<Object[]>) genericClassService.fetchRecord(Patientcomplaint.class, fields, where, params, paramsValues);
        if (patientcomplaints != null) {
            Map<String, Object> unitsRow;
            for (Object[] patientcomplaint : patientcomplaints) {
                unitsRow = new HashMap<>();
                unitsRow.put("patientcomplaintid", patientcomplaint[0]);
                unitsRow.put("patientcomplaint", patientcomplaint[1]);
                unitsRow.put("description", patientcomplaint[2]);

                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {patientcomplaint[3]};
                String[] fields2 = {"firstname", "othernames", "lastname"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                if (addedby != null) {
                    unitsRow.put("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
                }
                complaintsFound.add(unitsRow);
            }
            model.addAttribute("act", "b");

            String[] params3 = {"patientvisitid"};
            Object[] paramsValues3 = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields3 = {"patientobservationid", "observation", "addedby"};
            String where3 = "WHERE patientvisitid=:patientvisitid";
            List<Object[]> comments = (List<Object[]>) genericClassService.fetchRecord(Patientobservation.class, fields3, where3, params3, paramsValues3);
            if (comments != null) {
                Map<String, Object> commentsRow;
                for (Object[] comment : comments) {
                    commentsRow = new HashMap<>();
                    commentsRow.put("patientobservationid", comment[0]);
                    commentsRow.put("observation", comment[1]);

                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {comment[2]};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (addedby != null) {
                        commentsRow.put("addedby", addedby.get(0)[0] + " " + addedby.get(0)[1] + " " + addedby.get(0)[2]);
                    }
                    commentsFound.add(commentsRow);
                }
            }
            String[] params4 = {"patientvisitid"};
            Object[] paramsValues4 = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields4 = {"diagnosisid", "interimdiagnosis", "addedby"};
            String where4 = "WHERE patientvisitid=:patientvisitid";
            List<Object[]> interim = (List<Object[]>) genericClassService.fetchRecord(Patientinterimdiagnosis.class, fields4, where4, params4, paramsValues4);
            if (interim != null) {
                Map<String, Object> commentsRow;
                for (Object[] interimdiag : interim) {
                    commentsRow = new HashMap<>();
                    commentsRow.put("diagnosisid", interimdiag[0]);
                    commentsRow.put("interimdiagnosis", interimdiag[1]);

                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {interimdiag[2]};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> addedby2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (addedby2 != null) {
                        commentsRow.put("addedby", addedby2.get(0)[0] + " " + addedby2.get(0)[1] + " " + addedby2.get(0)[2]);
                    }
                    interimFound.add(commentsRow);
                }
            }
        } else {
            model.addAttribute("act", "a");
        }
        model.addAttribute("commentsFound", commentsFound);
        model.addAttribute("complaintsFound", complaintsFound);
        model.addAttribute("interimFound", interimFound);

        return "doctorConsultations/forms/clinicalNotes";
    }
	
	
	

	
	
	  @RequestMapping(value = "/savepatientscomplaintandcomments.htm")
    public @ResponseBody
    String savepatientscomplaintandcomments(HttpServletRequest request) {
        String results = "";
        try {
            if ("a".equals(request.getParameter("act"))) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("complaintspatient"), List.class);

                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;

                    Patientcomplaint patientcomplaint = new Patientcomplaint();
                    patientcomplaint.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
                    patientcomplaint.setDateadded(new Date());
                    patientcomplaint.setDescription((String) map.get("desc"));
                    patientcomplaint.setPatientcomplaint((String) map.get("patientcomplaint"));
                    patientcomplaint.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                    patientcomplaint.setFacilityunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                    genericClassService.saveOrUpdateRecordLoadObject(patientcomplaint);
                }
            } else {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("complaintspatient"), List.class);
                List<Map> item2 = (ArrayList) new ObjectMapper().readValue(request.getParameter("clinicianComment"), List.class);
                String item4 = request.getParameter("interimdiagnosis");
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;

                    Patientcomplaint patientcomplaint = new Patientcomplaint();
                    patientcomplaint.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
                    patientcomplaint.setDateadded(new Date());
                    patientcomplaint.setDescription((String) map.get("desc"));
                    patientcomplaint.setPatientcomplaint((String) map.get("patientcomplaint"));
                    patientcomplaint.setPatientvisitid(Long.parseLong(request.getParameter("patientvisitid")));
                    patientcomplaint.setFacilityunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                    genericClassService.saveOrUpdateRecordLoadObject(patientcomplaint);
                }
                for (Map item3 : item2) {
                    Map<String, Object> map = (HashMap) item3;
                    Patientobservation patientobservation = new Patientobservation();
                    patientobservation.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
                    patientobservation.setDateadded(new Date());
                    patientobservation.setObservation((String) map.get("observation"));
                    patientobservation.setPatientvisitid(BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))));
                    patientobservation.setFacilityunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));

                    genericClassService.saveOrUpdateRecordLoadObject(patientobservation);
                }
                Patientinterimdiagnosis Patientinterim = new Patientinterimdiagnosis();
                Patientinterim.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
                Patientinterim.setDateadded(new Date());
                Patientinterim.setInterimdiagnosis(item4);
                Patientinterim.setPatientvisitid(BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))));
                Patientinterim.setFacilityunitid(BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));

                genericClassService.saveOrUpdateRecordLoadObject(Patientinterim);
            }

        } catch (Exception e) {
            System.err.println("::::::::::::::::::::::::::" + e);
        }

        return results;
    }

    @RequestMapping(value = "/savepatientinterim.htm")
    public @ResponseBody
    String savepatientinterim(HttpServletRequest request) {
        String results = "";
        Patientinterimdiagnosis patientobservation = new Patientinterimdiagnosis();
        patientobservation.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
        patientobservation.setDateadded(new Date());
        patientobservation.setInterimdiagnosis(request.getParameter("interim"));
        patientobservation.setPatientvisitid(BigInteger.valueOf(Long.parseLong(request.getParameter("patientvisitid"))));
        genericClassService.saveOrUpdateRecordLoadObject(patientobservation);

        return results;
    }
    @RequestMapping(value = "/deletepatientinterim.htm")
    public @ResponseBody
    String deletepatientinterim(HttpServletRequest request) {
        String results = "";
        if ("a".equals(request.getParameter("act"))) {
            String[] columns = {"patientcomplaintid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("patientcomplaintid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.patientcomplaint", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] columns = {"diagnosisid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("patientdiagnosisid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.patientinterimdiagnosis", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }
    private static String capitalize(String str) {
        StringBuilder result = new StringBuilder(str.length());
        String words[] = str.split("\\ ");
        for (int i = 0; i < words.length; i++) {
            if (words[i].length() != 0) {
                result.append(Character.toUpperCase(words[i].charAt(0))).append(words[i].substring(1)).append(" ");
            }
        }
        return result.toString();
    }

    private String getPrescriptionRefrenceNumber(long originUnitId) {
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String referenceNumber = "RX/";
        String temp = originUnitId + "/";
        try {
            String pattern = "RX/" + temp + f.format(new Date()) + "/%";
            String[] params = {"referencenumber", "originunitid"};
            Object[] paramsValues = {pattern, originUnitId};
            String[] fields = {"referencenumber"};
            String where = "WHERE originunitid=:originunitid AND referencenumber LIKE :referencenumber ORDER BY referencenumber DESC LIMIT 1";
            List<String> lastReferenceNumber = (List<String>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
            if (lastReferenceNumber == null) {
                referenceNumber += temp + f.format(new Date()) + "/0001";
            } else {
                try {
                    int lastNo = Integer.parseInt(lastReferenceNumber.get(0).split("\\/")[3]);
                    String newNo = String.valueOf(lastNo + 1);
                    switch (newNo.length()) {
                        case 1:
                            referenceNumber += temp + f.format(new Date()) + "/000" + newNo;
                            break;
                        case 2:
                            referenceNumber += temp + f.format(new Date()) + "/00" + newNo;
                            break;
                        case 3:
                            referenceNumber += temp + f.format(new Date()) + "/0" + newNo;
                            break;
                        default:
                            referenceNumber += temp + f.format(new Date()) + "/" + newNo;
                            break;
                    }
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return referenceNumber;
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

    private long getDaysLeft(int duration, String daysName, Date dateIssued) {
        long daysLeft = 0L;
        long days = 0;
        Date today = new Date();
        long diff = today.getTime() - dateIssued.getTime();
        long daysDiff = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
        try {
            switch (daysName) {
                case "day(s)":
                    days = duration;
                    break;
                case "week(s)":
                    days = (duration * 7);
                    break;
                case "month(s)":
                    days = (duration * 31);
                    break;
                default:
                    days = 0;
                    break;
            }
            daysLeft = days - daysDiff;
        } catch (Exception e) {
            System.out.println(e);
        }
        return daysLeft;
    }
    //
}
