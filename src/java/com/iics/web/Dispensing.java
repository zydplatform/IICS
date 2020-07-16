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
import com.iics.domain.Facilityunit;
import com.iics.domain.Locations;
import com.iics.domain.Searchstaff;
import com.iics.patient.Alternatedosages;
import com.iics.patient.Modifiedprescriptionitems;
import com.iics.patient.Newprescriptionissueview;
import com.iics.patient.Newprescriptionitems;
import com.iics.patient.Patient;
import com.iics.patient.Patientobservation;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Patientvisit;
import com.iics.patient.Prescription;
import com.iics.patient.Prescriptionpicklist;
import com.iics.patient.Prescriptionqueue;
import com.iics.patient.Searchpatient;
import com.iics.patient.Servicedprescriptionbatchnumbersview;
import com.iics.patient.Servicedprescriptions;
import com.iics.patient.Servicedprescriptionstats;
import com.iics.patient.Servicequeue;
import com.iics.patient.Todaydispensingconsumption;
import com.iics.patient.Triage;
import com.iics.patient.Unresolvedprescriptionitems;
import com.iics.patient.Unservicedprescriptionitemsreasons;
import com.iics.patient.Unservicedprescriptionsview;
import com.iics.service.GenericClassService;
import com.iics.store.Bookedprescriptionitemsview;
import com.iics.store.Cellitems;
import com.iics.store.Dispenseditems;
import com.iics.store.Facilitystocklog;
import com.iics.store.Facilityunitstock;
import com.iics.store.Itemcategories;
import com.iics.store.Itempackage;
import com.iics.store.Picklist;
import com.iics.store.Prescriptionissue;
import com.iics.store.Readypackets;
import com.iics.store.Shelfstock;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.iics.store.Stock;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import com.iics.utils.ShelfActivityLog;
import com.iics.utils.StockActivityLog;
import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Base64;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/dispensing")
public class Dispensing {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formatterWithTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat formatterWithTime2 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");    
    private SimpleDateFormat formatterwithtime3 = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");
    private Date serverDate = new Date();

    @RequestMapping(value = "/dispensingmenu", method = RequestMethod.GET)
    public String dispensingmenu(HttpServletRequest request, Model model) {
//        return "dispensing/views/dispensingMainHome";
        try {
            long facilityId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            Long currentFacilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            int reviewedCount = 0, readyToIssueCount = 0, pickListCount = 0;
            String[] params = {"facilityunitid", "queuestage"};
            Object[] paramsValues = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "approval"};
            String[] fields = {"COUNT(DISTINCT r.prescriptionid)"};
            String where = "WHERE facilityunitid=:facilityunitid AND ispopped=false AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage";
            List<Object[]> reviewedCounts = (List<Object[]>) genericClassService.fetchRecordFunction(Prescriptionqueue.class, fields, where, params, paramsValues, 0, 0);
            if (reviewedCounts != null) {
                reviewedCount = Integer.parseInt(String.valueOf(reviewedCounts.get(0)));
            }
            params = new String[]{"facilityunitid", "queuestage"};
            paramsValues = new Object[]{Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "dispensing"};
            fields = new String[]{"COUNT(DISTINCT r.prescriptionid)"};
            where = "WHERE facilityunitid=:facilityunitid AND ispopped=false AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage";
            List<Object[]> readyToIssueCounts = (List<Object[]>) genericClassService.fetchRecordFunction(Prescriptionqueue.class, fields, where, params, paramsValues, 0, 0);
            if (readyToIssueCounts != null) {
                readyToIssueCount = Integer.parseInt(String.valueOf(readyToIssueCounts.get(0)));
            }
            params = new String[]{"facilityunitid", "queuestage"};
            paramsValues = new Object[]{Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "picking"};
            fields = new String[]{"COUNT(DISTINCT r.prescriptionid)"};
            where = "WHERE facilityunitid=:facilityunitid AND ispopped=false AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage";
            List<Object[]> pickListCounts = (List<Object[]>) genericClassService.fetchRecordFunction(Prescriptionqueue.class, fields, where, params, paramsValues, 0, 0);
            if (pickListCounts != null) {
                pickListCount = Integer.parseInt(String.valueOf(pickListCounts.get(0)));
            }
            //
            int servicedPrescriptionCount = 0;
//            fields = new String[]{"prescriptionid", "patientvisitid"};
//            params = new String[]{"timein", "facilityunitid", "isserviced", "isunresolved"};
//            paramsValues = new Object[]{new Date(), BigInteger.valueOf(currentFacilityUnitId), Boolean.TRUE, Boolean.FALSE};
//            where = "WHERE DATE(timein)=:timein  AND facilityunitid=:facilityunitid AND isserviced=:isserviced AND isunresolved=:isunresolved";
//            List<Object[]> servicedPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
//            if (servicedPrescriptions != null) {
//                servicedPrescriptionCount = servicedPrescriptions.size();
//            }
            fields = new String [] { "prescriptionid", "patientvisitid" };
            params = new String [] { "dateadded", "destinationunitid"  };
            paramsValues = new Object [] { new Date(), BigInteger.valueOf(currentFacilityUnitId) };
            where = "WHERE DATE(dateadded)=:dateadded AND destinationunitid=:destinationunitid";
            List<Object[]> servicedPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Servicedprescriptionstats.class, fields, where, params, paramsValues);
            if(servicedPrescriptions != null){
                servicedPrescriptionCount = servicedPrescriptions.size();
            }
            int unresolvedPrescriptionCount = 0;
            fields = new String[]{"COUNT(DISTINCT r.prescriptionid)"};
            params = new String[]{"dateadded", "facilityunitid"};
            paramsValues = new Object[]{new Date(), currentFacilityUnitId};
            where = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded";
            List<Object[]> unresolvedPrescriptions = (List<Object[]>) genericClassService.fetchRecordFunction(Unresolvedprescriptionitems.class, fields, where, params, paramsValues, 0, 0);
            if (unresolvedPrescriptions != null) {
                unresolvedPrescriptionCount = Integer.parseInt(String.valueOf(unresolvedPrescriptions.get(0)));
            }
            //
            model.addAttribute("readyToIssueCount", readyToIssueCount);
            model.addAttribute("pickListCount", pickListCount);
            model.addAttribute("servicedPrescriptionCount", servicedPrescriptionCount);
            model.addAttribute("unresolvedPrescriptionCount", unresolvedPrescriptionCount);
            model.addAttribute("reviewedCount", reviewedCount);
            model.addAttribute("facilityunitid", currentFacilityUnitId);
            model.addAttribute("facilityid", facilityId);
            model.addAttribute("serverdate", formatterwithtime3.format(serverDate));
//            Boolean userHasRole = (request.isUserInRole("ROLE_ROOTADMIN") || request.isUserInRole("PRIVILEGE_VIEWPRESCRIPTIONITEMS"));
//            model.addAttribute("usercanreviewprescription", userHasRole);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "dispensing/views/prescriptionTabs";
    }

//    @RequestMapping(value = "/readyItemsCount", method = RequestMethod.GET)
//    public @ResponseBody
//    String readyItemsCount(HttpServletRequest request, Model model) {
//        int prescriptionReadyItems = 0;
//        String[] paramsitemcount = {"status", "destinationunitid", "dateapproved"};
//        Object[] paramsValuesitemcount = {"APPROVED", Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), new Date()};
//        String whereitemcount = "WHERE status=:status AND destinationunitid=:destinationunitid AND dateapproved=:dateapproved";
//        prescriptionReadyItems = genericClassService.fetchRecordCount(Prescription.class, whereitemcount, paramsitemcount, paramsValuesitemcount);
//
//        String readyItemscount = String.valueOf(prescriptionReadyItems);
//        return readyItemscount;
//    }
//    @RequestMapping(value = "/pausedprescriptions", method = RequestMethod.GET)
//    public ModelAndView pausedPrescriptions(HttpServletRequest request) {
//        Map<String, Object> model = new HashMap<>();
//        List<Map<String, Object>> prescriptions = new ArrayList<>();
//        try {
//            Long currentFacilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());            
//            String[] params = new String[]{"paused", "datepaused", "facilityunitid"};
//            Object[] paramsValues = new Object[]{Boolean.TRUE, formatter2.format(new Date()), currentFacilityUnitId};
//            String where = "WHERE paused=:paused AND to_char(datepaused, 'dd-MM-yyyy')=:datepaused AND facilityunitid=:facilityunitid AND LOWER(pausetype) <> 'automatic' ORDER BY datepaused";
//            String[] fields = {"pausedprescriptionsid", "paused", "prescriptionid", "patientvisitid", "facilityunitid", "pausedby", "datepaused","pausestage"};
//            List<Object[]> pausedPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Pausedprescriptions.class, fields, where, params, paramsValues);
//            if (pausedPrescriptions != null) {
//                Map<String, Object> prescription;
//                for (Object[] pausedPrescription : pausedPrescriptions) {
//                    prescription = new HashMap<>();
//                    prescription.put("patientvisitid", pausedPrescription[3]);
//                    prescription.put("prescriptionid", pausedPrescription[2]);
//                    prescription.put("pausestage", pausedPrescription[7]);
//                    long time = ((new Date().getTime() - ((Date) pausedPrescription[6]).getTime()) / (1000 * 60));
//                    String timePaused = "";
//                    if (time < 1) {
//                        timePaused = "0 Minutes";
//                    } else if (time == 1) {
//                        timePaused = "1 Minute";
//                    } else if (time > 1) {
//                        if (time < 60) {
//                            timePaused = time + " Minutes";
//                        } else if (time == 60) {
//                            timePaused = "1 Hour";
//                        } else if (time > 60) {
//                            double hours = (time / 60);
//                            if (hours == 1) {
//                                timePaused = "1 Hour";
//                            } else if (hours != 1) {
//                                timePaused = String.format("%.0f", hours) + " Hours";
//                            }
//                        }
//                    }
//                    prescription.put("pausedfor", timePaused);
//                    params = new String[]{"patientvisitid"};
//                    paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(pausedPrescription[3].toString()))};
//                    fields = new String[]{"fullnames", "visitnumber"};
//                    List<Object[]> patientdetails = (List<Object[]>) genericClassService.fetchRecord(Patientvisits.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
//                    if (patientdetails != null) {
//                        prescription.put("patientname", patientdetails.get(0)[0]);
//                        prescription.put("visitnumber", patientdetails.get(0)[1]);
//                    }
//                    params = new String[]{"staffid"};
//                    paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(pausedPrescription[5].toString()))};
//                    fields = new String[]{"firstname", "lastname", "othernames", "personid"};
//                    List<Object[]> staffList = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, "WHERE staffid=:staffid", params, paramsValues);
//                    if (staffList != null) {
//                        Object[] staff = staffList.get(0);
//                        if (staff[2] != null) {
//                            prescription.put("pausedBy", staff[0] + " " + staff[1] + " " + staff[2]);
//                        } else {
//                            prescription.put("pausedBy", staff[0] + " " + staff[1]);
//                        }
//                    }
//                    prescriptions.add(prescription);
//                }
//            }
//            model.put("prescriptions", prescriptions);
//        } catch (NumberFormatException ex) {
//            System.out.println(ex);
//        }catch (Exception ex) {
//            System.out.println(ex);
//        }
//        return new ModelAndView("dispensing/views/pausedPrescriptions", model);
//    }
//    @RequestMapping(value = "/dispensedDrugsView", method = RequestMethod.GET)
//    public String dispensedDrugsView(HttpServletRequest request, Model model) {
//
//        return "dispensing/views/dispensansaryRecord";
//    }
//    @RequestMapping(value = "/IssuedDispensedDrugs", method = RequestMethod.POST)
//    public String IssuedDispensedDrugs(HttpServletRequest request, Model model) {
//
//        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
//            List<Map> dispensingRecordList = new ArrayList<>();
//            try {
//                String date = request.getParameter("date");
//                Date issuedDate = formatter2.parse(date);
//
//                String[] paramPrescriptionIssue = {"dateissued", "destinationunitid"};
//                Object[] paramsValuesPrescriptionIssue = {issuedDate, BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
//                String[] fieldsPrescriptionIssue = {"r.itempackageid", "SUM(r.quantitydispensed)"};
//                String wherePrescriptionIssue = "WHERE r.dateissued=:dateissued AND r.destinationunitid=:destinationunitid GROUP BY r.itempackageid";
//                List<Object[]> objPrescriptionIssue = (List<Object[]>) genericClassService.fetchRecordFunction(Prescriptionissueview.class, fieldsPrescriptionIssue, wherePrescriptionIssue, paramPrescriptionIssue, paramsValuesPrescriptionIssue, 0, 0);
//                if (objPrescriptionIssue != null) {
//                    Map<String, Object> dispensedDrugs;
//                    for (Object[] itempackageid : objPrescriptionIssue) {
//                        dispensedDrugs = new HashMap<>();
//                        dispensedDrugs.put("quantityissued", itempackageid[1]);
//
//                        String[] paramItempackageDetails = {"itempackageid"};
//                        Object[] paramsValuesItempackageDetails = {itempackageid[0]};
//                        String[] fieldsItempackageDetails = {"packagename"};
//                        String whereItempackageDetails = "WHERE itempackageid=:itempackageid";
//                        List<String> objItempackageDetails = (List<String>) genericClassService.fetchRecord(Itempackage.class, fieldsItempackageDetails, whereItempackageDetails, paramItempackageDetails, paramsValuesItempackageDetails);
//                        if (objItempackageDetails != null) {
//                            dispensedDrugs.put("itempackagename", objItempackageDetails.get(0));
//                        }
//                        dispensingRecordList.add(dispensedDrugs);
//                    }
//                }
//            } catch (Exception e) {
//                System.out.println(e);
//            }
//            model.addAttribute("dispensingRecordList", dispensingRecordList);
//
//        } else {
//            return "refresh";
//        }
//        return "dispensing/views/dispensedDrugsTable";
//    }
//    @RequestMapping(value = "/approvePrescriptionView", method = RequestMethod.GET)
//    public String approvePrescriptionView(HttpServletRequest request, Model model) {
//
//        return "dispensing/views/drugDispensingPane";
//    }
//    @RequestMapping(value = "/prescribedDrugsDetails", method = RequestMethod.GET)
//    public String prescribedDrugsDetails(HttpServletRequest request, Model model, @ModelAttribute("patientvisitid") String patientvisitid) {
//        List<Map> patientPrescriptionList = new ArrayList<>();
//
//        String[] paramsPatientPrescription = {"patientvisitid", "destinationunitid"};
//        Object[] paramsValuesPatientPrescription = {Long.parseLong(patientvisitid), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
//        String[] fields5PatientPrescription = {"prescriptionid", "dateprescribed", "addedby", "originunitid"};
//        List<Object[]> objPatientPrescription = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields5PatientPrescription, "WHERE patientvisitid=:patientvisitid AND destinationunitid=:destinationunitid", paramsPatientPrescription, paramsValuesPatientPrescription);
//        if (objPatientPrescription != null) {
//            for (Object[] patientPrescription : objPatientPrescription) {
//
//                String[] paramsPatientPrescriptionunit = {"facilityunitid"};
//                Object[] paramsValuesPatientPrescriptionunit = {patientPrescription[3]};
//                String[] fields5PatientPrescriptionunit = {"facilityunitname"};
//                List<String> objPatientPrescriptionunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5PatientPrescriptionunit, "WHERE facilityunitid=:facilityunitid", paramsPatientPrescriptionunit, paramsValuesPatientPrescriptionunit);
//                if (objPatientPrescriptionunit != null) {
//                    model.addAttribute("facilityunitname", objPatientPrescriptionunit.get(0));
//                }
//
//                String[] paramsPrescriber = {"staffid"};
//                Object[] paramsValuesPrescriber = {BigInteger.valueOf((Long) patientPrescription[2])};
//                String[] fields5Prescriber = {"firstname", "lastname", "othernames"};
//                List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
//                if (objPrescriber != null) {
//                    Object[] per = objPrescriber.get(0);
//                    if (per[2] != null) {
//                        model.addAttribute("prescriber", per[0] + " " + per[1] + " " + per[2]);
//                    } else {
//                        model.addAttribute("prescriber", per[0] + " " + per[1]);
//                    }
//                }
//
//                String[] paramsPatientPrescriptionItems = {"prescriptionid"};
//                Object[] paramsValuesPatientPrescriptionItems = {patientPrescription[0]};
//                String[] fields5PatientPrescriptionItems = {"prescriptionitemsid", "itemid", "dosage", "days", "dosagestatus", "daysname", "dose"};
//                List<Object[]> objPatientPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fields5PatientPrescriptionItems, "WHERE prescriptionid=:prescriptionid", paramsPatientPrescriptionItems, paramsValuesPatientPrescriptionItems);
//                Map<String, Object> prescriptionsItems;
//                if (objPatientPrescriptionItems != null) {
//                    for (Object[] patientPrescriptionItems : objPatientPrescriptionItems) {
//                        prescriptionsItems = new HashMap<>();
//
//                        String[] paramsPatientPrescriptionItemName = {"itemid"};
//                        Object[] paramsValuesPatientPrescriptionItemName = {patientPrescriptionItems[1]};
//                        String[] fields5PatientPrescriptionItemName = {"fullname"};
//                        List<String> objPatientPrescriptionItemName = (List<String>) genericClassService.fetchRecord(Itemcategories.class,
//                                fields5PatientPrescriptionItemName, "WHERE itemid=:itemid", paramsPatientPrescriptionItemName, paramsValuesPatientPrescriptionItemName);
//                        if (objPatientPrescriptionItemName != null) {
//                            prescriptionsItems.put("itemname", objPatientPrescriptionItemName.get(0));
//                        }
//                        prescriptionsItems.put("itemid", patientPrescriptionItems[1]);
//                        prescriptionsItems.put("prescriptionitemsid", patientPrescriptionItems[0]);
//                        prescriptionsItems.put("dosage", patientPrescriptionItems[2]);
//                        prescriptionsItems.put("days", patientPrescriptionItems[3] + " " + patientPrescriptionItems[5]);
//                        prescriptionsItems.put("dosagestatus", patientPrescriptionItems[4]);
//                        prescriptionsItems.put("dose", patientPrescriptionItems[6]);
//                        patientPrescriptionList.add(prescriptionsItems);
//                    }
//                }
//                model.addAttribute("prescriptionid", patientPrescription[0]);
//            }
//            model.addAttribute("patientPrescriptionListsize", patientPrescriptionList.size());
//            model.addAttribute("patientPrescriptionList", patientPrescriptionList);
//        }
//        return "dispensing/views/approvePrescription";
//    }
//    @RequestMapping(value = "/managePrescribedDrug", method = RequestMethod.GET)
//    public String managePrescribedDrug(HttpServletRequest request, Model model, @ModelAttribute("itemid") String itemid, @ModelAttribute("prescriptionitemsid") String prescriptionitemsid) {
//        List<Map> prescriptionSpecificItemList = new ArrayList<>();
//
//        String[] paramsPrescriptionItm = {"itemid"};
//        Object[] paramsValuesPrescriptionItm = {Long.parseLong(itemid)};
//        String[] fields5PrescriptionItm = {"itempackageid", "packagename"};
//        List<Object[]> objPrescriptionItm = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields5PrescriptionItm, "WHERE itemid=:itemid", paramsPrescriptionItm, paramsValuesPrescriptionItm);
//        Map<String, Object> facilityUnitItem;
//        if (objPrescriptionItm != null) {
//            for (Object[] prescriptionItm : objPrescriptionItm) {
//                facilityUnitItem = new HashMap<>();
//                facilityUnitItem.put("itemid", prescriptionItm[0]);
//                facilityUnitItem.put("fullname", prescriptionItm[1]);
//
//                String[] paramsCellitem = {"itemid", "facilityunitid"};
//                Object[] paramsValuesCellitem = {prescriptionItm[0], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
//                String whereCellitem = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
//                String[] fieldsCellitem = {"celllabel", "daystoexpire", "quantityshelved", "batchnumber"};
//                List<Object[]> objCellitem = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class,
//                        fieldsCellitem, whereCellitem, paramsCellitem, paramsValuesCellitem);
//                int stockBalance = 0;
//                long unshelvedstock = 0;
//                //NEED THIS
//                if (objCellitem != null) {
//                    for (Object[] cellitem : objCellitem) {
//                        if (cellitem[1] != null) {
//                            if ((Integer) cellitem[1] > 0) {
//                                stockBalance = stockBalance + (Integer) cellitem[2];
//                            }
//                        } else {
//                            stockBalance = stockBalance + (Integer) cellitem[2];
//                        }
//                    }
//                }
//
//                //FETCH Qty unshelved
//                String[] paramsstockrecieved = {"itemid", "facilityunitid"};
//                Object[] paramsValuesstockrecieved = {prescriptionItm[0], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
//                String wherestockrecieved = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
//                String[] fieldsstockrecieved = {"quantityrecieved", "shelvedstock", "stockid"};
//                List<Object[]> objstockrecieved = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fieldsstockrecieved, wherestockrecieved, paramsstockrecieved, paramsValuesstockrecieved);
//                if (objstockrecieved != null) {
//                    long unshelved = 0;
//                    for (Object[] stockrecieved : objstockrecieved) {
//                        unshelved = unshelved + (Integer) stockrecieved[0] - (Integer) stockrecieved[1];
//                        unshelvedstock = unshelvedstock + unshelved;
//                        facilityUnitItem.put("unshelvedstock", unshelvedstock);
//                    }
//                }
//                facilityUnitItem.put("shelvedstock", stockBalance);
//                prescriptionSpecificItemList.add(facilityUnitItem);
//            }
//            model.addAttribute("medicalitemid", itemid);
//            model.addAttribute("prescriptionitemsid", prescriptionitemsid);
//            model.addAttribute("prescriptionSpecificItemList", prescriptionSpecificItemList);
//        }
//        return "dispensing/views/itemPrescriptionView";
//    }
//    @RequestMapping(value = "/submitApprovedPrescriptions.htm", method = RequestMethod.GET)
//    public @ResponseBody
//    String submitApprovedPrescriptions(Model model, HttpServletRequest request, @ModelAttribute("patientprescriptionid") String prescriptionid) throws IOException {
//        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
//        List<Map> qtyapprovedtoissueList = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyapprovedtoissueList"), List.class);
//        Integer check = 0;
//        for (Map itemone : qtyapprovedtoissueList) {
//            int prescriptionitemid = (Integer) itemone.get("prescriptionitemid");
//            Integer itempackageid = Integer.parseInt((String) itemone.get("itempackageid"));
//            String qtyApproved = (String) itemone.get("qtyapprovetoissuee");
//
//            Prescriptionissue prescriptionissue = new Prescriptionissue();
//            if (!itemone.get("qtyapprovetoissuee").equals("")) {
//                if (!itemone.get("qtyapprovetoissuee").equals("0")) {
//
//                    if (!qtyApproved.equals(0)) {
//                        check = check + 1;
//                        prescriptionissue.setQuantityapproved(Integer.valueOf(qtyApproved));
//                        prescriptionissue.setItempackageid(BigInteger.valueOf(Long.valueOf(itempackageid.toString())));
//                        prescriptionissue.setPrescriptionitemsid(BigInteger.valueOf(Long.valueOf(String.valueOf(prescriptionitemid))));
//                        genericClassService.saveOrUpdateRecordLoadObject(prescriptionissue);
//
//                        String[] columnscellqty = {"isapproved"};
//                        Object[] columnValuescellqty = {true};
//                        String pkcellqty = "prescriptionitemsid";
//                        Object pkValuecellqty = Long.valueOf(String.valueOf(prescriptionitemid));
//                        genericClassService.updateRecordSQLSchemaStyle(Prescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
//                    }
//                }
//            }
//        }
//
//        if (check > 0) {
//            String[] columns = {"dateapproved", "status", "approvedby"};
//            Object[] columnValues = {new Date(), "APPROVED", currStaffId};
//            String pk = "prescriptionid";
//            Object pkValue = Long.valueOf(prescriptionid);
//            genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
//        }
//        return "";
//    }
//    @RequestMapping(value = "/issuePrescriptionsView.htm", method = RequestMethod.GET)
//    public String issuePrescriptionsView(Model model, HttpServletRequest request) {
//
//        return "dispensing/views/readyApprovedPatientDrugs";
//    }
//    @RequestMapping(value = "/readyDrugsToIssue.htm", method = RequestMethod.GET)
//    public String readyDrugsToIssue(Model model, HttpServletRequest request) {
//        List<Map> readyToIssuePrescription = new ArrayList<>();
//
//        try {
//            String date = request.getParameter("date");
//            Date approvalDate = formatter2.parse(date);
//
//            String[] paramprescription = {"status", "destinationunitid", "dateapproved"};
//            Object[] paramsValuesprescription = {"APPROVED", Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), approvalDate};
//            String[] fieldsissueprescription = {"prescriptionid", "approvedby", "patientvisitid", "originunitid"};
//            String whereissueprescription = "WHERE status=:status AND destinationunitid=:destinationunitid AND dateapproved=:dateapproved ORDER BY prescriptionid";
//            List<Object[]> objprescription = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fieldsissueprescription, whereissueprescription, paramprescription, paramsValuesprescription);
//
//            if (objprescription != null) {
//                Map<String, Object> prescIssue;
//                for (Object[] presc : objprescription) {
//                    prescIssue = new HashMap<>();
//                    prescIssue.put("prescriptionid", presc[0]);
//
//                    String[] paramsPatientPrescriptionunit = {"facilityunitid"};
//                    Object[] paramsValuesPatientPrescriptionunit = {presc[3]};
//                    String[] fields5PatientPrescriptionunit = {"facilityunitname"};
//                    List<String> objPatientPrescriptionunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5PatientPrescriptionunit, "WHERE facilityunitid=:facilityunitid", paramsPatientPrescriptionunit, paramsValuesPatientPrescriptionunit);
//                    if (objPatientPrescriptionunit != null) {
//                        prescIssue.put("facilityunitname", objPatientPrescriptionunit.get(0));
//                    }
//
//                    String[] paramsPrescriber = {"staffid"};
//                    Object[] paramsValuesPrescriber = {presc[1]};
//                    String[] fields5Prescriber = {"firstname", "lastname", "othernames"};
//                    List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
//                    if (objPrescriber != null) {
//                        Object[] per = objPrescriber.get(0);
//                        if (per[2] != null) {
//                            prescIssue.put("approvedby", per[0] + " " + per[1] + " " + per[2]);
//                        } else {
//                            prescIssue.put("approvedby", per[0] + " " + per[1]);
//                        }
//                    }
//
//                    //Retrive Person Details
//                    String[] parampersn = {"patientvisitid"};
//                    Object[] paramsValuepersn = {presc[2]};
//                    String wherepersn = "WHERE patientvisitid=:patientvisitid";
//                    String[] fieldspersn = {"fullname", "visitnumber", "patientno"};
//                    List<Object[]> objpersn = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
//                    if (objpersn != null) {
//                        Object[] personDetails = objpersn.get(0);
//                        prescIssue.put("patientname", (String) personDetails[0]);
//                        prescIssue.put("patientno", (String) personDetails[2]);
//                        prescIssue.put("visitnumber", (String) personDetails[1]);
//                    }
//
//                    int prescriptionItemsNo = 0;
//                    String[] paramsitemno = {"isapproved", "prescriptionid"};
//                    Object[] paramsValuesitemno = {true, presc[0]};
//                    String whereitemno = "WHERE isapproved=:isapproved AND prescriptionid=:prescriptionid";
//                    prescriptionItemsNo = genericClassService.fetchRecordCount(Prescriptionitems.class, whereitemno, paramsitemno, paramsValuesitemno);
//                    prescIssue.put("prescriptionItemsNo", prescriptionItemsNo);
//
//                    readyToIssuePrescription.add(prescIssue);
//                }
//            }
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        model.addAttribute("readyToIssuePrescription", readyToIssuePrescription);
//        return "dispensing/views/readyToIssuePrescriptions";
//    }
//    @RequestMapping(value = "/viewfacilityunitprescriptionitems.htm", method = RequestMethod.GET)
//    public String viewfacilityunitprescriptionitems(Model model, HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) {
//        List<Map> prescItemsList = new ArrayList<>();
//
//        String[] paramorderItems = {"prescriptionid", "isapproved"};
//        Object[] paramsValuesorderItems = {Long.parseLong(prescriptionid), true};
//        String[] fieldsorderItems = {"prescriptionitemsid", "itemid"};
//        String whereorderItems = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved";
//        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class,
//                fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
//        Map<String, Object> items;
//        if (objOrderItems != null) {
//            for (Object[] itm : objOrderItems) {
//                items = new HashMap<>();
//                String[] paramsitemname = {"itemid"};
//                Object[] paramsValuesitemname = {itm[1]};
//                String whereitemname = "WHERE itemid=:itemid";
//                String[] fieldsitemname = {"fullname"};
//                List<String> objitemname = (List<String>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
//                if (objitemname != null) {
//                    items.put("genericname", objitemname.get(0));
//                }
//
//                String[] paramsitemqtyapprv = {"prescriptionitemsid"};
//                Object[] paramsValuesitemqtyapprv = {itm[0]};
//                String whereitemqtyapprv = "WHERE prescriptionitemsid=:prescriptionitemsid";
//                String[] fieldsitemqtyapprv = {"quantityapproved"};
//                List<Integer> objitemqtyapprv = (List<Integer>) genericClassService.fetchRecord(Prescriptionissue.class, fieldsitemqtyapprv, whereitemqtyapprv, paramsitemqtyapprv, paramsValuesitemqtyapprv);
//                if (objitemqtyapprv != null) {
//                    items.put("quantityapproved", objitemqtyapprv.get(0));
//                }
//                prescItemsList.add(items);
//            }
//        }
//        model.addAttribute("prescItemsList", prescItemsList);
//        return "dispensing/views/prescriptionItems";
//    }
//    @RequestMapping(value = "/manageDispeingApprovedItems.htm", method = RequestMethod.GET)
//    public String manageDispeingApprovedItems(Model model, HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) {
//        List<Map> qtylist = new ArrayList<>();
//        List<Map> picklist = new ArrayList<>();
//        int picklisttablesize = 0;
//
//        String[] paramorderItems = {"prescriptionid", "isapproved"};
//        Object[] paramsValuesorderItems = {Long.parseLong(prescriptionid), true};
//        String[] fieldsorderItems = {"prescriptionitemsid", "itemid"};
//        String whereorderItems = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved";
//        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Prescriptionitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
//        Map<String, Object> items;
//        Map<String, Object> picklistqtys;
//        if (objOrderItems != null) {
//            for (Object[] itmpresc : objOrderItems) {
//                items = new HashMap<>();
//                items.put("prescriptionitemsid", itmpresc[0]);
//
//                String[] paramsitemqtyapprv = {"prescriptionitemsid"};
//                Object[] paramsValuesitemqtyapprv = {itmpresc[0]};
//                String whereitemqtyapprv = "WHERE prescriptionitemsid=:prescriptionitemsid";
//                String[] fieldsitemqtyapprv = {"prescriptionissueid", "quantityapproved", "itempackageid"};
//                List<Object[]> objitemqtyapprv = (List<Object[]>) genericClassService.fetchRecord(Prescriptionissue.class, fieldsitemqtyapprv, whereitemqtyapprv, paramsitemqtyapprv, paramsValuesitemqtyapprv);
//                if (objitemqtyapprv != null) {
//                    Object[] issuedetails = objitemqtyapprv.get(0);
//
//                    String[] paramsitemname = {"itempackageid"};
//                    Object[] paramsValuesitemname = {issuedetails[2]};
//                    String whereitemname = "WHERE itempackageid=:itempackageid";
//                    String[] fieldsitemname = {"itempackageid", "fullname"};
//                    List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
//                    if (objitemname != null) {
//                        Object[] itemdetails = objitemname.get(0);
//                        items.put("genericname", (String) itemdetails[1]);
//
//                        items.put("quantityapproved", issuedetails[1]);
//                        items.put("prescriptionissueid", issuedetails[0]);
//
//                        List<Map> itemLocation = getDispensingItemslocations(Long.valueOf(String.valueOf((BigInteger) itemdetails[0])), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
//                        List<Map> itemPickList = generateDispensingPickList(itemLocation, (Integer) issuedetails[1]);
//                        items.put("itemid", itmpresc[0]);
//                        Collections.sort(itemPickList, sortCells2);
//
//                        for (Map itemsstockdetails : itemPickList) {
//                            picklistqtys = new HashMap<>();
//                            picklistqtys.put("prescriptionitemsid", issuedetails[0]);
//                            picklistqtys.put("cellid", itemsstockdetails.get("cellid"));
//                            picklistqtys.put("stockid", itemsstockdetails.get("stockid"));
//                            picklistqtys.put("qtypicked", 0);
//                            picklist.add(picklistqtys);
//                        }
//
//                        int itemPickListsize = itemPickList.size();
//                        picklisttablesize = picklisttablesize + itemPickListsize;
//                        items.put("pick", itemPickList);
//                    }
//                }
//                qtylist.add(items);
//            }
//        }
//
//        String jsonqtypicklist = "";
//        try {
//            jsonqtypicklist = new ObjectMapper().writeValueAsString(picklist);
//        } catch (JsonProcessingException ex) {
//            System.out.println(ex);
//        }
//        model.addAttribute("jsonqtypicklist", jsonqtypicklist);
//        model.addAttribute("picklisttablesize", picklisttablesize);
//        model.addAttribute("prescriptionid", prescriptionid);
//        model.addAttribute("items", qtylist);
//        return "dispensing/views/handOverDrugs";
//    }
//    private List<Map> getDispensingItemslocations(long itemid, long currentfacility) {
//        List<Map> itemsWithCellLocations = new ArrayList<>();
//        float expired = 0;
//        //FOR EACH ITEM(item ID find cells its located in
//        String[] paramslocateitemcell = {"itemid", "facilityunitid"};
//        Object[] paramsValueslocateitemcell = {itemid, currentfacility};
//        String wherelocateitemcell = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid AND quantityshelved > 0 ORDER BY daystoexpire";
//        String[] fieldslocateitemcell = {"itemid", "bayrowcellid", "quantityshelved", "daystoexpire", "celllabel", "batchnumber", "stockid"};
//        List<Object[]> objlocateitemcell = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldslocateitemcell, wherelocateitemcell, paramslocateitemcell, paramsValueslocateitemcell);
//        if (objlocateitemcell != null) {
//            //Object[] cells = objlocateitemcell.get(0);
//            Map<String, Object> cellMap;
//            for (Object[] object : objlocateitemcell) {
//                cellMap = new HashMap<>();
//                if (object[3] != null) {
//                    if ((Integer) object[3] > 0) {
//                        expired = (Integer) object[3];
//                        cellMap.put("daystoexpire", expired);
//                        cellMap.put("itemid", object[0]);
//                        cellMap.put("cellid", object[1]);
//                        cellMap.put("qty", (Integer) object[2]);
//                        cellMap.put("cell", object[4]);
//                        cellMap.put("batchnumber", object[5]);
//                        cellMap.put("stockid", object[6]);
//                        itemsWithCellLocations.add(cellMap);
//                    }
//                } else {
//                    cellMap.put("daystoexpire", 0.5);
//                    cellMap.put("itemid", object[0]);
//                    cellMap.put("cellid", object[1]);
//                    cellMap.put("qty", (Integer) object[2]);
//                    cellMap.put("cell", object[4]);
//                    cellMap.put("batchnumber", object[5]);
//                    cellMap.put("stockid", object[6]);
//                    itemsWithCellLocations.add(cellMap);
//                }
//            }
//        }
//        return itemsWithCellLocations;
//    }
//    private List<Map> generateDispensingPickList(List<Map> itemLocations, Integer quantityNeeded) {
//        List<Map> itemPickList = new ArrayList<>();
//        Map<String, Object> cellDatails;
//        for (Map loc : itemLocations) {
//            cellDatails = new HashMap<>();
//            if ((Integer) loc.get("qty") < quantityNeeded) {
//                cellDatails.put("cellid", loc.get("cellid"));
//                cellDatails.put("cell", loc.get("cell"));
//                cellDatails.put("batch", loc.get("batchnumber"));
//                cellDatails.put("qty", loc.get("qty"));
//                cellDatails.put("stockid", loc.get("stockid"));
//                itemPickList.add(cellDatails);
//                quantityNeeded = quantityNeeded - (Integer) loc.get("qty");
//            } else {
//                cellDatails.put("cellid", loc.get("cellid"));
//                cellDatails.put("cell", loc.get("cell"));
//                cellDatails.put("batch", loc.get("batchnumber"));
//                cellDatails.put("stockid", loc.get("stockid"));
//                cellDatails.put("qty", quantityNeeded);
//                itemPickList.add(cellDatails);
//                break;
//            }
//        }
//        return itemPickList;
//    }
    Comparator sortCells2 = new Comparator<Map>() {
        @Override
        public int compare(final Map o1, final Map o2) {
            try {
                return ((String) o1.get("cell")).compareTo((String) o2.get("cell"));
            } catch (Exception e) {
                System.out.println(e);
            }
            return 0;
        }
    };

//    @RequestMapping(value = "/submitPatientDispensedDrugs.htm", method = RequestMethod.GET)
//    public @ResponseBody
//    String submitPatientDispensedDrugs(Model model, HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) throws IOException {
//        List<Map> stockList = new ArrayList<>();
//        Set<Long> prescriptionitemsset = new HashSet<>();
//        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
//        List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyissuedvalues"), List.class);
//        for (Map picked : itemorderqty) {
//            int qtyPicked = (int) picked.get("qtypicked");
//            if (qtyPicked > 0) {
//                Long cellid = Long.parseLong(picked.get("cellid").toString());
//                Long stockid = Long.parseLong(picked.get("stockid").toString());
//                Long orderitemid = Long.parseLong(picked.get("prescriptionitemsid").toString());
//                boolean stockExists = false;
//
//                for (int i = 0; i < stockList.size(); i++) {
//                    if ((stockList.get(i).get("stockid").toString()).equals(picked.get("stockid").toString())) {
//                        int qty = (int) stockList.get(i).get("qty") + qtyPicked;
//                        stockList.get(i).put("qty", qty);
//                        stockExists = true;
//                        break;
//                    }
//                }
//                if (!stockExists) {
//                    Map<String, Object> stockLog = new HashMap<>();
//                    stockLog.put("stockid", stockid);
//                    stockLog.put("qty", qtyPicked);
//                    stockLog.put("orderitem", orderitemid);
//                    stockList.add(stockLog);
//                }
//
//                //Fetch Previous cell qty value.
//                String[] paramscellqty = {"stockid", "cellid"};
//                Object[] paramsValuescellqty = {BigInteger.valueOf(stockid), cellid};
//                String wherecellqty = "WHERE stockid=:stockid AND cellid=:cellid";
//                String[] fieldscellqty = {"shelfstockid", "quantityshelved", "packsize"};
//                List<Object[]> objcellqty = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldscellqty, wherecellqty, paramscellqty, paramsValuescellqty);
//                if (objcellqty != null) {
//                    Object[] cellqty = objcellqty.get(0);
//
//                    // UPDATE CELL VALUES
//                    String[] columnscellqty = {"quantityshelved", "updatedby", "dateupdated"};
//                    Object[] columnValuescellqty = {((Integer) cellqty[1] - (qtyPicked)), currStaffId.intValue(), new Date()};
//                    String pkcellqty = "shelfstockid";
//                    Object pkValuecellqty = cellqty[0];
//                    genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "store");
//                    new ShelfActivityLog(genericClassService, cellid.intValue(), stockid.intValue(), currStaffId.intValue(), "OUT", qtyPicked).start();
//                }
//
//                //Update stock card
//                String[] paramsStockQty = {"stockid"};
//                Object[] paramsValuesStockQty = {BigInteger.valueOf(stockid)};
//                String whereStockQty = "WHERE stockid=:stockid";
//                String[] fieldsStockQty = {"stockissued", "packsize"};
//                List<Object[]> issued = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fieldsStockQty, whereStockQty, paramsStockQty, paramsValuesStockQty);
//                if (issued != null) {
//                    Integer totalIssued = (Integer) issued.get(0)[0] + (qtyPicked);
//
//                    //UPDATE stock card
//                    String[] columnsqty = {"stockissued"};
//                    Object[] columnValuesqty = {totalIssued};
//                    String pkqty = "stockid";
//                    Object pkValueqty = stockid;
//                    genericClassService.updateRecordSQLSchemaStyle(Stock.class, columnsqty, columnValuesqty, pkqty, pkValueqty, "store");
//
//                    new StockActivityLog(genericClassService, stockid.intValue(), currStaffId.intValue(), "DISP", qtyPicked, null, null, null).start();
//                }
//            }
//        }
//
//        for (Map log : stockList) {
//            Dispenseditems dispenseditems = new Dispenseditems();
//            dispenseditems.setPrescriptionissueid((long) log.get("orderitem"));
//            dispenseditems.setQuantitydispensed((int) log.get("qty"));
//            dispenseditems.setStockid((long) log.get("stockid"));
//            genericClassService.saveOrUpdateRecordLoadObject(dispenseditems);
//            prescriptionitemsset.add((long) log.get("orderitem"));
//
//            String[] columnspreissue = {"issuedby", "dateissued"};
//            Object[] columnValuespreissue = {BigInteger.valueOf(currStaffId), new Date()};
//            String pkpreissue = "prescriptionissueid";
//            Object pkValuepreissue = (long) log.get("orderitem");
//            genericClassService.updateRecordSQLSchemaStyle(Prescriptionissue.class, columnspreissue, columnValuespreissue, pkpreissue, pkValuepreissue, "store");
//        }
//
//        String[] columns = {"status"};
//        Object[] columnValues = {"ISSUED"};
//        String pk = "prescriptionid";
//        Object pkValue = Long.parseLong(prescriptionid);
//        genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
//
//        for (long prescriptionitemsid : prescriptionitemsset) {
//            try {
//                String[] columnsdis = {"isissued"};
//                Object[] columnValuesdis = {true};
//                String pkdis = "prescriptionitemsid";
//                Object pkValuedis = prescriptionitemsid;
//                genericClassService.updateRecordSQLSchemaStyle(Prescriptionitems.class, columnsdis, columnValuesdis, pkdis, pkValuedis, "patient");
//            } catch (Exception ex) {
//                System.out.println(ex);
//            }
//        }
//        return "";
//    }
//    @RequestMapping(value = "/dispensingpatientinqueuedetails.htm", method = RequestMethod.GET)
//    public String dispensingpatientinqueuedetails(Model model, HttpServletRequest request) {
//
//        String[] paramsbasicinfo = {"patientid"};
//        Object[] paramsValuesbasicinfo = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
//        String[] fieldsbasicinfo = {"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin", "currentaddress"};
//        List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fieldsbasicinfo, "WHERE patientid=:patientid", paramsbasicinfo, paramsValuesbasicinfo);
//        if (patientsvisitsbasicinfo != null) {
//            String[] params5basicinfo = {"personid"};
//            Object[] paramsValues5basicinfo = {patientsvisitsbasicinfo.get(0)[0]};
//            String[] fields5basicinfo = {"dob", "estimatedage", "gender"};
//            List<Object[]> objpatientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5basicinfo, "WHERE personid=:personid", params5basicinfo, paramsValues5basicinfo);
//
//            if (patientsvisitsbasicinfo.get(0)[3] != null || patientsvisitsbasicinfo.get(0)[3] != "") {
//                model.addAttribute("name", patientsvisitsbasicinfo.get(0)[1] + " " + patientsvisitsbasicinfo.get(0)[2] + " " + patientsvisitsbasicinfo.get(0)[3]);
//            } else {
//                model.addAttribute("name", patientsvisitsbasicinfo.get(0)[1] + " " + patientsvisitsbasicinfo.get(0)[3] + " " + patientsvisitsbasicinfo.get(0)[2]);
//            }
//            model.addAttribute("patientno", patientsvisitsbasicinfo.get(0)[4]);
//            model.addAttribute("telephone", patientsvisitsbasicinfo.get(0)[5]);
//            model.addAttribute("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
//            model.addAttribute("dob", formatter.format((Date) objpatientdetails.get(0)[0]));
//
//            model.addAttribute("gender", objpatientdetails.get(0)[2]);
//
//            String year = formatter.format((Date) objpatientdetails.get(0)[0]);
//            String currentyear = formatter.format(new Date());
//            SimpleDateFormat myFormat = new SimpleDateFormat("dd MM yyyy");
//            try {
//                Date dateBefore = formatter.parse(year);
//                Date dateAfter = formatter.parse(currentyear);
//                long difference = dateAfter.getTime() - dateBefore.getTime();
//                float daysBetween = (difference / (1000 * 60 * 60 * 24));
//                model.addAttribute("estimatedage", computeAge3(Math.round(daysBetween)));
//            } catch (Exception e) {
//                System.out.println(e);
//            }
//
//            String[] paramsresidence = {"villageid"};
//            Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
//            String[] fieldsresidence = {"villagename"};
//            List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
//            if (patientsvisitsresidence != null) {
//                model.addAttribute("village", patientsvisitsresidence.get(0));
//            }
//
//            String[] paramsTriage = {"patientvisitid"};
//            Object[] paramsValuesTriage = {Long.parseLong(request.getParameter("patientvisitid"))};
//            String[] fields5Triage = {"weight"};
//            List<Double> objTriage = (List<Double>) genericClassService.fetchRecord(Triage.class, fields5Triage, "WHERE patientvisitid=:patientvisitid", paramsTriage, paramsValuesTriage);
//            if (objTriage != null) {
//                model.addAttribute("weight", objTriage.get(0));
//            }
//
//            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
//            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
//            model.addAttribute("patientid", request.getParameter("patientid"));
//        }
//        return "dispensing/views/patientBasicInfoDispensing";
//    }
    @RequestMapping(value = "/getprescriptionid", method = RequestMethod.GET)
    public @ResponseBody
    String getPrescriptionId(HttpServletRequest request) {
        String result = "0";
        try {
            Long patientVisitId = Long.parseLong(request.getParameter("patientvisitid"));
            String[] fields = {"prescriptionid"};
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {patientVisitId};
            String where = "WHERE patientvisitid=:patientvisitid";
            List<Object> prescriptionIds = (List<Object>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
            if (prescriptionIds != null && prescriptionIds.get(0) != null) {
                result = prescriptionIds.get(0).toString();
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return result;
    }
//    @RequestMapping(value = "/viewprescriptionitems", method = RequestMethod.GET)
//    public String viewPrescriptionItems(HttpServletRequest request, Model model,
//            @ModelAttribute("patientvisitid") String patientvisitid) {
//        List<Map> patientPrescriptionList = new ArrayList<>();
//        int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
//        Long staffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
//        String[] paramsPatientPrescription = {"patientvisitid", "destinationunitid"};
//        Object[] paramsValuesPatientPrescription = {Long.parseLong(patientvisitid), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
//        String[] fields5PatientPrescription = {"prescriptionid", "dateprescribed", "addedby", "originunitid"};
//        List<Object[]> objPatientPrescription = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields5PatientPrescription, "WHERE patientvisitid=:patientvisitid AND destinationunitid=:destinationunitid", paramsPatientPrescription, paramsValuesPatientPrescription);
//        if (objPatientPrescription != null) {
//            for (Object[] patientPrescription : objPatientPrescription) {
//                String[] paramsPrescriber = {"staffid"};
//                Object[] paramsValuesPrescriber = {BigInteger.valueOf((Long) patientPrescription[2])};
//                String[] fields5Prescriber = {"firstname", "lastname", "othernames", "personid"};
//                List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
//                if (objPrescriber != null) {
//                    Object[] per = objPrescriber.get(0);
//                    if (per[2] != null) {
//                        model.addAttribute("prescriber", per[0] + " " + per[1] + " " + per[2]);
//                    } else {
//                        model.addAttribute("prescriber", per[0] + " " + per[1]);
//                    }
//                }
//                model.addAttribute("originunitid", patientPrescription[3]);
//                model.addAttribute("prescriberid", BigInteger.valueOf((Long) patientPrescription[2]));
//                String[] params = { "prescriptionid", "isapproved", "isissued", "ismodified" };
//                Object[] paramsValues = { Long.parseLong(patientPrescription[0].toString()), Boolean.FALSE,
//                    Boolean.FALSE, Boolean.FALSE };
//                String[] fields = {"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname",
//                    "itemname"};
//                List<Object[]> newPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, "WHERE prescriptionid=:prescriptionid AND (isapproved IS NULL OR isapproved=:isapproved) AND (isissued IS NULL OR isissued=:isissued) AND ismodified=:ismodified", params, paramsValues);
//                
//                fields = new String[]{"newprescriptionitemsid", "prescriptionid",
//                    "dosage", "dose", "days", "daysname", "itemname", "reason"};
//                params = new String[]{ "prescriptionid" };
//                paramsValues = new Object[]{ Long.parseLong(patientPrescription[0].toString())};
//                String where = "WHERE prescriptionid=:prescriptionid";
//                List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues);
//                if(newPrescriptionItems == null){
//                    newPrescriptionItems = new ArrayList<>();
//                }
//                if (modifiedPrescriptionItems != null) { // Prescription has modified items                        
//                    newPrescriptionItems.addAll(modifiedPrescriptionItems);
//                }
//                
//                Map<String, Object> prescriptionItem;
//                if (newPrescriptionItems != null) {
//                    for (Object[] patientPrescriptionItems : newPrescriptionItems) {
//                        prescriptionItem = new HashMap<>();                        
//                        BigInteger itemId = BigInteger.valueOf(0);
//                        prescriptionItem.put("genericname", patientPrescriptionItems[6]);
//                        params = new String[]{"genericname", "itemstrength"};
//                        paramsValues = new Object[]{patientPrescriptionItems[6], patientPrescriptionItems[3].toString().toLowerCase().replaceAll("\\s+", "")};
//                        fields = new String[]{"itempackageid"};
//                        List<Object> itemIds = (List<Object>) genericClassService.fetchRecord(Itempackage.class,
//                                fields, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemstrength", params, paramsValues);
//                        if (itemIds != null && itemIds.get(0) != null) {
//                            itemId = BigInteger.valueOf(Long.parseLong(itemIds.get(0).toString()));
//                            int strengthCount = genericClassService.fetchRecordCount(Itempackage.class, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemStrength", new String[]{"genericname", "itemStrength"}, new Object[]{patientPrescriptionItems[6].toString(), patientPrescriptionItems[3].toString().toLowerCase().replaceAll("\\s+", "")});
//                            if (strengthCount != 0) {
//                                Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
//                                long qtyinstock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
//                                prescriptionItem.put("qtyinstock", String.format("%,d", qtyinstock));
//                                if (qtyinstock <= 0) {
//                                    prescriptionItem.put("isAvailable", Boolean.FALSE);
//                                    boolean isOutOfStock = isOutOfStock(patientPrescriptionItems[6].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
//                                    prescriptionItem.put("isoutofstock", isOutOfStock);
//                                } else {
//                                    prescriptionItem.put("isAvailable", Boolean.TRUE);
//                                }
//                            } else {
//                                prescriptionItem.put("isAvailable", Boolean.FALSE);
//                                boolean isOutOfStock = isOutOfStock(patientPrescriptionItems[6].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
//                                prescriptionItem.put("isoutofstock", isOutOfStock);
//                            }
//                        } else {
//                            prescriptionItem.put("isAvailable", Boolean.FALSE);
//                            boolean isOutOfStock = isOutOfStock(patientPrescriptionItems[6].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
//                            prescriptionItem.put("isoutofstock", isOutOfStock);
//                        }
//                        prescriptionItem.put("itemid", itemId);
//                        prescriptionItem.put("prescriptionitemsid", patientPrescriptionItems[0]);
//                        prescriptionItem.put("dosage", patientPrescriptionItems[2]);
//                        prescriptionItem.put("dose", patientPrescriptionItems[3]);
//                        prescriptionItem.put("days", patientPrescriptionItems[4]);
//                        prescriptionItem.put("daysname", patientPrescriptionItems[5]);
//                        if (patientPrescriptionItems.length == 8 && patientPrescriptionItems[7] != null) {
//                            prescriptionItem.put("reason", patientPrescriptionItems[7].toString());
//                        }
//                        patientPrescriptionList.add(prescriptionItem);
//                    }
//                }
//                model.addAttribute("prescriptionid", patientPrescription[0]);
//            }
//            model.addAttribute("patientPrescriptionList", patientPrescriptionList);
//        }        
//        //        
//        String[] params = new String[]{"patientvisitid"};
//        Object[] paramsValues = new Object[]{Long.parseLong(patientvisitid)};
//        String where = "WHERE patientvisitid=:patientvisitid";
//        String[] fields = new String[]{"fullname", "visitnumber", "patientno", "dob", "gender", "patientid", "personid"};
//        List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
//        if (persons != null) {
//            Object[] personDetails = persons.get(0);
//            model.addAttribute("name", personDetails[0].toString());
//            model.addAttribute("patientno", personDetails[2].toString());
//            model.addAttribute("visitnumber", personDetails[1].toString());
//            model.addAttribute("dob", personDetails[3].toString());
//            model.addAttribute("gender", personDetails[4].toString());
//            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
//            params = new String[]{"patientid"};
//            paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(personDetails[5].toString()))};
//            fields = new String[]{"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin", "currentaddress"};
//            List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
//            if (patientsvisitsbasicinfo != null) {
//                model.addAttribute("telephone", patientsvisitsbasicinfo.get(0)[5]);
//                model.addAttribute("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
//                String year = formatter.format((Date) personDetails[3]);
//                String currentyear = formatter.format(new Date());
//                Date dateBefore;
//                try {
//                    dateBefore = formatter.parse(year);                    
//                    Date dateAfter = formatter.parse(currentyear);
//                    long difference = dateAfter.getTime() - dateBefore.getTime();
//                    float daysBetween = (difference / (1000 * 60 * 60 * 24));
//                    model.addAttribute("estimatedage", computeAge3(Math.round(daysBetween)));
//                } catch (ParseException ex) {
//                    System.out.println(ex);
//                }
//            }
//            String[] paramsresidence = {"villageid"};
//            Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
//            String[] fieldsresidence = {"villagename"};
//            List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
//            if (patientsvisitsresidence != null) {
//                model.addAttribute("village", patientsvisitsresidence.get(0));
//            }
//            String[] paramsTriage = {"patientvisitid"};
//            Object[] paramsValuesTriage = {Long.parseLong(request.getParameter("patientvisitid"))};
//            fields = new String[]{"weight", "height"};
//            List<Object[]> objTriage = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", paramsTriage, paramsValuesTriage);
//            if (objTriage != null) {
//                Double patientBMI = 0.0;
//                for (Object[] obj : objTriage) {
//                    if(obj[0] != null && obj[1] != null){
//                        Double weight = Double.parseDouble(obj[0].toString());
//                        Double heightcm = Double.parseDouble(obj[1].toString());
//                        Double heightInMetres = (heightcm / 100);
//                        Double heightInMetresSquared = (heightInMetres * heightInMetres);
//                        patientBMI = (weight / heightInMetresSquared);
//                    }
//                }
//                model.addAttribute("patientBMI", patientBMI);
//            }
//        }
//        List<String> observations = new ArrayList<>();
//        params = new String[]{"patientvisitid"};
//        paramsValues = new Object[]{Long.parseLong(request.getParameter("patientvisitid"))};
//        fields = new String[]{"observation"};
//        List<Object> patientObservations = (List<Object>) genericClassService.fetchRecord(Patientobservation.class, fields, where, params, paramsValues);
//        if (patientObservations != null) {
//            for (Object observation : patientObservations) {
//                observations.add(observation.toString());
//            }
//        }
//        model.addAttribute("observations", observations);
//        //
//        
//        model.addAttribute("facilityunitid", facilityUnitId);
//        model.addAttribute("staffid", staffId);
//        return "dispensing/views/viewPrescriptionItems";
//    }

    @RequestMapping(value = "/viewprescriptionitems", method = RequestMethod.GET)
    public String viewPrescriptionItems(HttpServletRequest request, Model model) {
        List<Map> patientPrescriptionList = new ArrayList<>();
        int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
        Long staffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        long patientVisitId = 0L;
        long prescriptionId = 0L;
        String[] paramsPatientPrescription = null;
        Object[] paramsValuesPatientPrescription = null;
        String where = "";
        int availableCount = 0, alternateCount = 0, outOfStockCount = 0;
        if (request.getParameter("patientvisitid") != null) {
            patientVisitId = Long.parseLong(request.getParameter("patientvisitid"));
            paramsPatientPrescription = new String[]{"patientvisitid", "destinationunitid"};
            paramsValuesPatientPrescription = new Object[]{patientVisitId, Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
            where = "WHERE patientvisitid=:patientvisitid AND destinationunitid=:destinationunitid";
        } else if (request.getParameter("prescriptionid") != null) {
            prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            paramsPatientPrescription = new String[]{"prescriptionid", "destinationunitid"};
            paramsValuesPatientPrescription = new Object[]{prescriptionId, Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
            where = "WHERE prescriptionid=:prescriptionid AND destinationunitid=:destinationunitid";
        }
        String[] fields5PatientPrescription = {"prescriptionid", "dateprescribed", "addedby", "originunitid", "patientvisitid"};
        List<Object[]> objPatientPrescription = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields5PatientPrescription, where, paramsPatientPrescription, paramsValuesPatientPrescription);
        if (objPatientPrescription != null) {
            patientVisitId = Long.parseLong(objPatientPrescription.get(0)[4].toString());
            for (Object[] patientPrescription : objPatientPrescription) {
                String[] paramsPrescriber = {"staffid"};
                Object[] paramsValuesPrescriber = {BigInteger.valueOf((Long) patientPrescription[2])};
                String[] fields5Prescriber = {"firstname", "lastname", "othernames", "personid"};
                List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
                if (objPrescriber != null) {
                    Object[] per = objPrescriber.get(0);
                    if (per[2] != null) {
                        model.addAttribute("prescriber", per[0] + " " + per[1] + " " + per[2]);
                    } else {
                        model.addAttribute("prescriber", per[0] + " " + per[1]);
                    }
                }
                model.addAttribute("originunitid", patientPrescription[3]);
                model.addAttribute("prescriberid", BigInteger.valueOf((Long) patientPrescription[2]));
                String[] params = {"prescriptionid", "isapproved", "isissued", "ismodified"};
                Object[] paramsValues = {Long.parseLong(patientPrescription[0].toString()), Boolean.FALSE,
                    Boolean.FALSE, Boolean.FALSE};
                String[] fields = {"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname",
                    "itemname"};
                List<Object[]> newPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, "WHERE prescriptionid=:prescriptionid AND (isapproved IS NULL OR isapproved=:isapproved) AND (isissued IS NULL OR isissued=:isissued) AND ismodified=:ismodified", params, paramsValues);

                fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                    "dosage", "dose", "days", "daysname", "itemname", "reason"};
                params = new String[]{"prescriptionid"};
                paramsValues = new Object[]{Long.parseLong(patientPrescription[0].toString())};
                where = "WHERE prescriptionid=:prescriptionid";
                List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues);
                if (newPrescriptionItems == null) {
                    newPrescriptionItems = new ArrayList<>();
                }
                if (modifiedPrescriptionItems != null) { // Prescription has modified items                        
                    newPrescriptionItems.addAll(modifiedPrescriptionItems);
                }

                Map<String, Object> prescriptionItem;
                if (newPrescriptionItems != null) {
                    for (Object[] patientPrescriptionItems : newPrescriptionItems) {
                        prescriptionItem = new HashMap<>();
                        BigInteger itemId = BigInteger.valueOf(0);
                        prescriptionItem.put("genericname", patientPrescriptionItems[6]);
                        params = new String[]{"genericname", "itemstrength"};
                        paramsValues = new Object[]{patientPrescriptionItems[6], patientPrescriptionItems[3].toString().toLowerCase().replaceAll("\\s+", "")};
                        fields = new String[]{"itempackageid"};
                        List<Object> itemIds = (List<Object>) genericClassService.fetchRecord(Itempackage.class,
                                fields, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemstrength", params, paramsValues);
                        if (itemIds != null && itemIds.get(0) != null) {
                            itemId = BigInteger.valueOf(Long.parseLong(itemIds.get(0).toString()));
                            int strengthCount = genericClassService.fetchRecordCount(Itempackage.class, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemStrength", new String[]{"genericname", "itemStrength"}, new Object[]{patientPrescriptionItems[6].toString(), patientPrescriptionItems[3].toString().toLowerCase().replaceAll("\\s+", "")});
                            if (strengthCount != 0) {
                                Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
                                long qtyinstock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                                prescriptionItem.put("qtyinstock", String.format("%,d", qtyinstock));
                                if (qtyinstock <= 0) {
                                    prescriptionItem.put("isAvailable", Boolean.FALSE);
                                    boolean isOutOfStock = isOutOfStock(patientPrescriptionItems[6].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                                    prescriptionItem.put("isoutofstock", isOutOfStock);
                                    alternateCount += (isOutOfStock != true) ? 1 : 0;
                                    outOfStockCount += (isOutOfStock == true) ? 1 : 0;
                                } else {
                                    prescriptionItem.put("isAvailable", Boolean.TRUE);
                                    availableCount += 1;
                                }
                            } else {
                                prescriptionItem.put("isAvailable", Boolean.FALSE);
                                boolean isOutOfStock = isOutOfStock(patientPrescriptionItems[6].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                                prescriptionItem.put("isoutofstock", isOutOfStock);
                                alternateCount += (isOutOfStock != true) ? 1 : 0;
                                outOfStockCount += (isOutOfStock == true) ? 1 : 0;
                            }
                        } else {
                            prescriptionItem.put("isAvailable", Boolean.FALSE);
                            boolean isOutOfStock = isOutOfStock(patientPrescriptionItems[6].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                            prescriptionItem.put("isoutofstock", isOutOfStock);
                            alternateCount += (isOutOfStock != true) ? 1 : 0;
                            outOfStockCount += (isOutOfStock == true) ? 1 : 0;
                        }
                        prescriptionItem.put("itemid", itemId);
                        prescriptionItem.put("prescriptionitemsid", patientPrescriptionItems[0]);
                        prescriptionItem.put("dosage", patientPrescriptionItems[2]);
                        prescriptionItem.put("dose", patientPrescriptionItems[3]);
                        prescriptionItem.put("days", patientPrescriptionItems[4]);
                        prescriptionItem.put("daysname", patientPrescriptionItems[5]);
                        if (patientPrescriptionItems.length == 8 && patientPrescriptionItems[7] != null) {
                            prescriptionItem.put("reason", patientPrescriptionItems[7].toString());
                        }
                        patientPrescriptionList.add(prescriptionItem);
                    }
                }
                model.addAttribute("prescriptionid", patientPrescription[0]);
            }
            model.addAttribute("patientPrescriptionList", patientPrescriptionList);
        }
        //        
        String[] params = new String[]{"patientvisitid"};
        Object[] paramsValues = new Object[]{patientVisitId};
        where = "WHERE patientvisitid=:patientvisitid";
        String[] fields = new String[]{"fullname", "visitnumber", "patientno", "dob", "gender", "patientid", "personid"};
        List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
        if (persons != null) {
            Object[] personDetails = persons.get(0);
            model.addAttribute("name", personDetails[0].toString());
            model.addAttribute("patientno", personDetails[2].toString());
            model.addAttribute("visitnumber", personDetails[1].toString());
            model.addAttribute("dob", personDetails[3].toString());
            model.addAttribute("gender", personDetails[4].toString());
            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            params = new String[]{"patientid"};
            paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(personDetails[5].toString()))};
            fields = new String[]{"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin", "currentaddress"};
            List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
            if (patientsvisitsbasicinfo != null) {
                model.addAttribute("telephone", patientsvisitsbasicinfo.get(0)[5]);
                model.addAttribute("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
                String year = formatter.format((Date) personDetails[3]);
                String currentyear = formatter.format(new Date());
                Date dateBefore;
                try {
                    dateBefore = formatter.parse(year);
                    Date dateAfter = formatter.parse(currentyear);
                    long difference = dateAfter.getTime() - dateBefore.getTime();
                    float daysBetween = (difference / (1000 * 60 * 60 * 24));
                    model.addAttribute("estimatedage", computeAge3(Math.round(daysBetween)));
                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }
            String[] paramsresidence = {"villageid"};
            Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
            String[] fieldsresidence = {"villagename"};
            List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
            if (patientsvisitsresidence != null) {
                model.addAttribute("village", patientsvisitsresidence.get(0));
            }
            String[] paramsTriage = {"patientvisitid"};
            Object[] paramsValuesTriage = {patientVisitId};
            fields = new String[]{"weight", "height"};
            List<Object[]> objTriage = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", paramsTriage, paramsValuesTriage);
            if (objTriage != null) {
                Double patientBMI = 0.0;
                for (Object[] obj : objTriage) {
                    if (obj[0] != null && obj[1] != null) {
                        Double weight = Double.parseDouble(obj[0].toString());
                        Double heightcm = Double.parseDouble(obj[1].toString());
                        Double heightInMetres = (heightcm / 100);
                        Double heightInMetresSquared = (heightInMetres * heightInMetres);
                        patientBMI = (weight / heightInMetresSquared);
                    }
                }
                model.addAttribute("patientBMI", patientBMI);
            }
        }
        List<String> observations = new ArrayList<>();
        params = new String[]{"patientvisitid"};
        paramsValues = new Object[]{patientVisitId};
        fields = new String[]{"observation"};
        List<Object> patientObservations = (List<Object>) genericClassService.fetchRecord(Patientobservation.class, fields, where, params, paramsValues);
        if (patientObservations != null) {
            for (Object observation : patientObservations) {
                observations.add(observation.toString());
            }
        }
        model.addAttribute("observations", observations);
        //        
        model.addAttribute("facilityunitid", facilityUnitId);
        model.addAttribute("staffid", staffId);
        model.addAttribute("patientvisitid", patientVisitId);
        model.addAttribute("availablecount", availableCount);
        model.addAttribute("alternatecount", alternateCount);
        model.addAttribute("outofstockcount", outOfStockCount);
        return "dispensing/views/viewPrescriptionItems";
    }

    @RequestMapping(value = "/approveprescriptionitems", method = RequestMethod.GET)
    public String approvePrescriptionItems(HttpServletRequest request, Model model,
            @ModelAttribute("prescriptionid") String prescriptionid) {
        try {
            List<Map<String, Object>> prescriptionItems = new ArrayList<>();
            long patientVisitId = 0L;
            float quantity;
            final int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            final Long staffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            int approvedPrescriptionItemsCount = 0, outOfStockCount = 0;
            String[] params = {"prescriptionid", "destinationunitid", "status"};
            Object[] paramsValues = {Long.parseLong(prescriptionid),
                Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))),
                "REVIEWED"};
            String[] fields = {"prescriptionid", "dateprescribed", "addedby", "originunitid", "patientvisitid"};
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields, "WHERE prescriptionid=:prescriptionid AND destinationunitid=:destinationunitid AND status=:status", params, paramsValues);

            if (prescriptions != null) {
                List<Object[]> prescriptionItemsList;
                for (Object[] prescription : prescriptions) {
                    patientVisitId = Long.parseLong(prescription[4].toString());
                    String[] paramsPatientPrescriptionunit = {"facilityunitid"};
                    Object[] paramsValuesPatientPrescriptionunit = {prescription[3]};
                    String[] fields5PatientPrescriptionunit = {"facilityunitname"};
                    List<String> objPatientPrescriptionunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5PatientPrescriptionunit, "WHERE facilityunitid=:facilityunitid", paramsPatientPrescriptionunit, paramsValuesPatientPrescriptionunit);
                    if (objPatientPrescriptionunit != null) {
                        model.addAttribute("facilityunitname", objPatientPrescriptionunit.get(0));
                    }

                    String[] paramsPrescriber = {"staffid"};
                    Object[] paramsValuesPrescriber = {BigInteger.valueOf((Long) prescription[2])};
                    String[] fields5Prescriber = {"firstname", "lastname", "othernames", "personid"};
                    List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
                    if (objPrescriber != null) {
                        Object[] per = objPrescriber.get(0);
                        if (per[2] != null) {
                            model.addAttribute("prescriber", per[0] + " " + per[1] + " " + per[2]);
                        } else {
                            model.addAttribute("prescriber", per[0] + " " + per[1]);
                        }
                    }

                    model.addAttribute("originunitid", prescription[3]);
                    model.addAttribute("prescriberid", BigInteger.valueOf((Long) prescription[2]));
                    model.addAttribute("prescriptionid", prescription[0]);

                    fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                        "dosage", "dose", "days", "daysname", "isapproved",
                        "isissued", "itemname"};
//                    params = new String[]{"prescriptionid", "isissued", "approvable", "ismodified" };
//                    paramsValues = new Object[]{ Long.parseLong(prescription[0].toString()), Boolean.FALSE, Boolean.TRUE, Boolean.FALSE };
                    params = new String[]{"prescriptionid", "isissued", "ismodified"};
                    paramsValues = new Object[]{Long.parseLong(prescription[0].toString()), Boolean.FALSE, Boolean.FALSE};
//                    String where = "WHERE prescriptionid=:prescriptionid AND (isissued IS NULL OR isissued=:isissued) AND approvable=:approvable AND ismodified=:ismodified";
                    String where = "WHERE prescriptionid=:prescriptionid AND (isissued IS NULL OR isissued=:isissued) AND ismodified=:ismodified";
                    prescriptionItemsList = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);

                    fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                        "dosage", "dose", "days", "daysname", "isapproved",
                        "isissued", "itemname"};
                    List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, "WHERE prescriptionid=:prescriptionid", new String[]{"prescriptionid"}, new Object[]{Long.parseLong(prescription[0].toString())});

                    if (prescriptionItemsList == null) {
                        prescriptionItemsList = new ArrayList<>();
                    }

                    if (modifiedPrescriptionItems != null) {
                        prescriptionItemsList.addAll(modifiedPrescriptionItems);
                    }

                    if (prescriptionItemsList != null) {
                        Map<String, Object> prescriptionItem;
                        for (Object[] item : prescriptionItemsList) {
                            prescriptionItem = new HashMap<>();
                            String itemStrength;
                            BigInteger itemId = BigInteger.valueOf(0);
                            prescriptionItem.put("itemname", item[8].toString());
                            prescriptionItem.put("prescriptionid", item[1]);
                            prescriptionItem.put("prescriptionitemsid", item[0]);
                            prescriptionItem.put("isapproved", item[6]);
                            approvedPrescriptionItemsCount = (item[6] != null && Boolean.valueOf(item[6].toString()) == true) ? 1 : 0;
                            DecimalFormat decimalFormat = new DecimalFormat("#.###");
                            quantity = 1.0F;
                            float qtyToPick = 0F;
                            String daysName = (item[5] == null) ? "" : item[5].toString();
                            fields = new String[]{"altdosageid", "dosage", "addedby",
                                "dateadded", "updatedby", "dateupdated", "newprescriptionitemsid", "itemid"};
                            List<Object[]> altDosages = (List<Object[]>) genericClassService.fetchRecord(Alternatedosages.class, fields, "WHERE newprescriptionitemsid=:newprescriptionitemsid", new String[]{"newprescriptionitemsid"}, new Object[]{item[0]});
                            if (altDosages != null) {
                                for (Object[] altDose : altDosages) {
                                    prescriptionItem.put("itemid", altDose[7]);
                                    prescriptionItem.put("strength", (altDose[1] != null) ? altDose[1].toString() : "");
                                    itemStrength = (item[3] != null) ? item[3].toString() : null;
                                    quantity = getQuantity(itemStrength, altDose[1].toString());
                                    qtyToPick = (getQtyToPick(item[2].toString(), Integer.parseInt(item[4].toString()), quantity, daysName));
                                    prescriptionItem.put("qtytopick", decimalFormat.format(qtyToPick));
                                    itemId = BigInteger.valueOf(Long.parseLong(altDose[7].toString()));
                                    prescriptionItem.put("itempackageid", itemId);
                                }
                            } else {
                                List<Object> itemPackageIds = (List<Object>) genericClassService.fetchRecord(Itempackage.class,
                                        new String[]{"itempackageid"}, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemstrength", new String[]{"genericname", "itemstrength"}, new Object[]{item[8].toString(), item[3].toString().toLowerCase().replaceAll("\\s+", "")});
                                if (itemPackageIds != null) {
                                    itemId = BigInteger.valueOf(Long.parseLong(itemPackageIds.get(0).toString()));
                                    prescriptionItem.put("itempackageid", itemId);
                                }
                                prescriptionItem.put("itemid", item[1]);
                                prescriptionItem.put("strength", (item[3] != null) ? item[3] : "");
                                qtyToPick = (getQtyToPick(item[2].toString(), Integer.parseInt(item[4].toString()), quantity, daysName));
                                prescriptionItem.put("qtytopick", decimalFormat.format(qtyToPick));
                            }
                            Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
                            long qtyinstock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                            prescriptionItem.put("qtyinstock", String.format("%,d", qtyinstock));
                            if (qtyinstock <= 0) {
                                prescriptionItem.put("outofstock", true);
                                outOfStockCount += 1;
                            }
                            Object bookedItemsSum = ((List<Object[]>) genericClassService.fetchRecordFunction(Bookedprescriptionitemsview.class, new String[]{"SUM(r.quantityapproved)"}, "WHERE itemid=:itemid AND destinationunitid=:facilityunitid", new String[]{"itemid", "facilityunitid"}, new Object[]{BigInteger.valueOf(Long.parseLong(itemId.toString())), facilityUnitId}, 0, 0)).get(0);
                            long qtyBooked = 0;
                            if (bookedItemsSum != null) {
                                System.out.println(bookedItemsSum);
                                qtyBooked = Long.parseLong(bookedItemsSum.toString());
                            }
                            prescriptionItem.put("qtybooked", String.format("%,d", qtyBooked));
                            prescriptionItem.put("qtyavailable", String.format("%,d", (qtyinstock - qtyBooked)));
                            prescriptionItems.add(prescriptionItem);
                        }
                    }
                }
            }
            //        
            params = new String[]{"patientvisitid"};
            paramsValues = new Object[]{patientVisitId};
            String where = "WHERE patientvisitid=:patientvisitid";
            fields = new String[]{"fullname", "visitnumber", "patientno", "dob", "gender", "patientid", "personid"};
            List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (persons != null) {
                Object[] personDetails = persons.get(0);
                model.addAttribute("name", personDetails[0].toString());
                model.addAttribute("patientno", personDetails[2].toString());
                model.addAttribute("visitnumber", personDetails[1].toString());
                model.addAttribute("dob", personDetails[3].toString());
                model.addAttribute("gender", personDetails[4].toString());
                model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
                params = new String[]{"patientid"};
                paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(personDetails[5].toString()))};
                fields = new String[]{"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin", "currentaddress"};
                List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
                if (patientsvisitsbasicinfo != null) {
                    model.addAttribute("telephone", patientsvisitsbasicinfo.get(0)[5]);
                    model.addAttribute("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
                    String year = formatter.format((Date) personDetails[3]);
                    String currentyear = formatter.format(new Date());
                    Date dateBefore;
                    try {
                        dateBefore = formatter.parse(year);
                        Date dateAfter = formatter.parse(currentyear);
                        long difference = dateAfter.getTime() - dateBefore.getTime();
                        float daysBetween = (difference / (1000 * 60 * 60 * 24));
                        model.addAttribute("estimatedage", computeAge3(Math.round(daysBetween)));
                    } catch (ParseException ex) {
                        System.out.println(ex);
                    }
                }
                String[] paramsresidence = {"villageid"};
                Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
                String[] fieldsresidence = {"villagename"};
                List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
                if (patientsvisitsresidence != null) {
                    model.addAttribute("village", patientsvisitsresidence.get(0));
                }
                String[] paramsTriage = {"patientvisitid"};
                Object[] paramsValuesTriage = {patientVisitId};
                fields = new String[]{"weight", "height"};
                List<Object[]> objTriage = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", paramsTriage, paramsValuesTriage);
                if (objTriage != null) {
                    Double patientBMI = 0.0;
                    for (Object[] obj : objTriage) {
                        if (obj[0] != null && obj[1] != null) {
                            Double weight = Double.parseDouble(obj[0].toString());
                            Double heightcm = Double.parseDouble(obj[1].toString());
                            Double heightInMetres = (heightcm / 100);
                            Double heightInMetresSquared = (heightInMetres * heightInMetres);
                            patientBMI = (weight / heightInMetresSquared);
                        }
                    }
                    model.addAttribute("patientBMI", patientBMI);
                }
            }
            List<String> observations = new ArrayList<>();
            params = new String[]{"patientvisitid"};
            paramsValues = new Object[]{patientVisitId};
            fields = new String[]{"observation"};
            List<Object> patientObservations = (List<Object>) genericClassService.fetchRecord(Patientobservation.class, fields, where, params, paramsValues);
            if (patientObservations != null) {
                for (Object observation : patientObservations) {
                    observations.add(observation.toString());
                }
            }
            model.addAttribute("observations", observations);
            model.addAttribute("outOfStockCount", outOfStockCount);
            //
            model.addAttribute("patientvisitid", patientVisitId);
            model.addAttribute("prescriptionid", prescriptionid);
            model.addAttribute("patientPrescriptionListsize", prescriptionItems.size());
            model.addAttribute("prescriptionItems", prescriptionItems);
            model.addAttribute("facilityunitid", facilityUnitId);
            model.addAttribute("staffid", staffId);
            model.addAttribute("approvedprescriptionitemscount", approvedPrescriptionItemsCount);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "dispensing/views/approvePrescriptionItems";
    }

    @RequestMapping(value = "/modifyprescriptionitemform", method = RequestMethod.GET)
    public ModelAndView modifyPrescriptionItemForm(HttpServletRequest request,
            @ModelAttribute("prescriptionid") String prescriptionId,
            @ModelAttribute("prescriptionitemsid") String prescriptionItemsId) {
        Map<String, Object> model = new HashMap<>();
        Map<String, Object> prescriptionItem = new HashMap<>();
        List<Map<String, Object>> items = new ArrayList<>();
        try {
            List<Object> presItems = (List<Object>) genericClassService.fetchRecord(Itemcategories.class,
                    new String[]{"genericname"}, "WHERE issupplies=:issupplies GROUP BY r.genericname", new String[]{"issupplies"}, new Object[]{Boolean.FALSE});
            if (presItems != null) {
                Map<String, Object> foundItem = null;
                for (Object item : presItems) {
                    foundItem = new HashMap<>();
                    foundItem.put("genericname", item.toString());
                    items.add(foundItem);
                }
            }
            String[] params = {"prescriptionid", "newprescriptionitemsid"};
            Object[] paramsValues = {Long.parseLong(prescriptionId), Long.parseLong(prescriptionItemsId)};
            String[] fields = {"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname",
                "itemname"};
            String where = "WHERE prescriptionid=:prescriptionid AND newprescriptionitemsid=:newprescriptionitemsid";
            List<Object[]> newPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (newPrescriptionItems != null) {
                for (Object[] newPrescriptionItem : newPrescriptionItems) {
                    fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                        "dosage", "dose", "days", "daysname", "itemname", "reason"};
                    params = new String[]{"prescriptionid", "newprescriptionitemsid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionId), newPrescriptionItem[0]};
                    where = "WHERE prescriptionid=:prescriptionid AND newprescriptionitemsid=:newprescriptionitemsid";
                    List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues);
                    if (modifiedPrescriptionItems != null) {
                        newPrescriptionItem = modifiedPrescriptionItems.get(0);
                    }
                    prescriptionItem.put("genericname", newPrescriptionItem[6].toString());
                    prescriptionItem.put("dose", newPrescriptionItem[3].toString());
                    prescriptionItem.put("dosage", newPrescriptionItem[2].toString());
                    prescriptionItem.put("days", newPrescriptionItem[4].toString());
                    prescriptionItem.put("daysname", newPrescriptionItem[5].toString());
                    if (newPrescriptionItem.length == 8 && newPrescriptionItem[7] != null) {
                        prescriptionItem.put("reason", newPrescriptionItem[7].toString());
                    }
                }
            }
            model.put("items", items);
            model.put("prescriptionitem", prescriptionItem);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/forms/modifyPrescriptionItem", model);
    }

    @RequestMapping(value = "/modifyprescriptionitem", method = RequestMethod.POST)
    public @ResponseBody
    String modifyrescription(HttpServletRequest request,
            Model model, @ModelAttribute("prescriptionid") String prescriptionid,
            @ModelAttribute("prescriptionitemsid") String prescriptionitemsid,
            @ModelAttribute("itemname") String itemName, @ModelAttribute("dose") String dose,
            @ModelAttribute("dosage") String dosage, @ModelAttribute("days") String days,
            @ModelAttribute("daysname") String daysName, @ModelAttribute("reason") String reason) {
        String result = "";
        try {
            Long staffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            long prescriptionId = Long.parseLong(prescriptionid);
            long prescriptionItemsId = Long.parseLong(prescriptionitemsid);
            String[] columns = {"lastupdated", "lastupdatedby"};
            Object[] columnValues = {new Date(), staffId};
            String pk = "prescriptionid";
            Object pkValue = Long.parseLong(prescriptionid);
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");

            Modifiedprescriptionitems modifiedPrescriptionItem;
            String[] fields = new String[]{"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "notes", "days",
                "daysname", "isapproved", "isissued", "itemname"};
            String[] params = new String[]{"newprescriptionitemsid", "prescriptionid"};
            String where = "WHERE newprescriptionitemsid=:newprescriptionitemsid AND prescriptionid=:prescriptionid";
            Object[] paramsValues = new Object[]{prescriptionItemsId, prescriptionId};
            List<Object[]> originalPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (originalPrescriptionItems != null) {
                modifiedPrescriptionItem = new Modifiedprescriptionitems();
                for (Object[] originalPrescriptionItem : originalPrescriptionItems) {
                    modifiedPrescriptionItem.setNewprescriptionitemsid(prescriptionItemsId);
                    modifiedPrescriptionItem.setItemname(itemName);
                    modifiedPrescriptionItem.setDose(dose);
                    modifiedPrescriptionItem.setDosage(dosage);
                    modifiedPrescriptionItem.setDays(Integer.parseInt(days));
                    modifiedPrescriptionItem.setDaysname(daysName);
                    modifiedPrescriptionItem.setReason(reason);
                    modifiedPrescriptionItem.setDatemodified(new Date());
                    modifiedPrescriptionItem.setModifiedby(staffId);
                    modifiedPrescriptionItem.setPrescriptionid(prescriptionId);
                    Object saved = genericClassService.saveOrUpdateRecordLoadObject(modifiedPrescriptionItem);
                    if (saved != null) {
                        columns = new String[]{"ismodified"};
                        columnValues = new Object[]{Boolean.TRUE};
                        pk = "newprescriptionitemsid";
                        pkValue = prescriptionItemsId;
                        rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");
                        result = "success";
                    } else {
                        result = "failure";
                        break;
                    }
                }
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return result;
    }

    @RequestMapping(value = "/getaltdosages", method = RequestMethod.GET)
    public String getAltDosages(HttpServletRequest request, Model model, @ModelAttribute("itemname") String itemname,
            @ModelAttribute("currentdosage") String currentDosage,
            @ModelAttribute("prescriptionitemsid") String prescriptionitemsid) {
        try {
            List<Map<String, Object>> itemCategories = new ArrayList<>();
            int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                    new String[]{"itempackageid", "genericname", "itemstrength", "itemform"}, "WHERE issupplies=:issupplies AND genericname=:itemname", new String[]{"issupplies", "itemname"}, new Object[]{Boolean.FALSE, itemname});
            if (items != null) {
                Map<String, Object> foundItem = null;
                for (Object[] item : items) {
                    foundItem = new HashMap<>();
                    BigInteger itemId = BigInteger.valueOf(Long.parseLong(item[0].toString()));
                    Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
                    long qtyinstock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                    if (qtyinstock <= 0) {
                        continue;
                    }
                    Object bookedItemsSum = ((List<Object[]>) genericClassService.fetchRecordFunction(Bookedprescriptionitemsview.class, new String[]{"SUM(r.quantityapproved)"}, "WHERE itemid=:itemid AND destinationunitid=:facilityunitid", new String[]{"itemid", "facilityunitid"}, new Object[]{BigInteger.valueOf(Long.parseLong(item[0].toString())), facilityUnitId}, 0, 0)).get(0);
                    long qtyBooked = 0;
                    if (bookedItemsSum != null) {
                        qtyBooked = Long.parseLong(bookedItemsSum.toString());
                    }
                    int altDoseCount = genericClassService.fetchRecordCount(Alternatedosages.class, "WHERE itemid=:itemid AND newprescriptionitemsid=:newprescriptionitemsid", new String[]{"itemid", "newprescriptionitemsid"}, new Object[]{(itemId != null) ? Integer.parseInt(itemId.toString()) : 0, Long.parseLong(prescriptionitemsid)});
                    foundItem.put("itemid", item[0]);
                    foundItem.put("itemname", item[1]);
                    foundItem.put("dosage", item[2]);
                    foundItem.put("qtyinstock", String.format("%,d", qtyinstock));
                    foundItem.put("qtybooked", String.format("%,d", qtyBooked));
                    foundItem.put("qtyavailable", String.format("%,d", (qtyinstock - qtyBooked)));
                    foundItem.put("exists", (altDoseCount == 0) ? false : true);
                    foundItem.put("itemform", capitalize(item[3].toString()));
                    itemCategories.add(foundItem);
                }
            }
            model.addAttribute("items", itemCategories);
            model.addAttribute("currentDosage", currentDosage);
            model.addAttribute("prescriptionitemsid", prescriptionitemsid);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "dispensing/views/altDosages";
    }

    @RequestMapping(value = "/savealternatedosages", method = RequestMethod.POST)
    public @ResponseBody
    String saveAlternateDosages(HttpServletRequest request, Model model,
            @ModelAttribute("prescriptionitemsid") String prescriptionItemsId,
            @ModelAttribute("itemid") BigInteger itemId, @ModelAttribute("dosage") String alternateDose,
            @ModelAttribute("currentdosage") String prescribedDose, @ModelAttribute("initialrequest") Boolean initialRequest,
            @ModelAttribute("forcesave") Boolean forceSave) {
        String result = "";
        try {
            float quantity = getQuantity(prescribedDose, alternateDose);
            int count = genericClassService.fetchRecordCount(Alternatedosages.class, "WHERE newprescriptionitemsid=:newprescriptionitemsid", new String[]{"newprescriptionitemsid"}, new Object[]{Long.parseLong(prescriptionItemsId)});
            if (count == 0 || forceSave == true) {
                if ((!prescribedDose.contains("+") && !prescribedDose.contains("/")
                        && !prescribedDose.contains("%") && !prescribedDose.contains("\\"))
                        || (!alternateDose.contains("+") && !alternateDose.contains("/")
                        && !alternateDose.contains("%") && !alternateDose.contains("\\"))) {
                    Alternatedosages alternateDosages = new Alternatedosages();
                    if (quantity > 0.25F) {
                        Long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
                        alternateDosages.setItemid(Long.parseLong(itemId.toString()));
                        alternateDosages.setDosage(alternateDose);
                        alternateDosages.setAddedby(staffId);
                        alternateDosages.setDateadded(new Date());
                        alternateDosages.setUpdatedby(staffId);
                        alternateDosages.setDateupdated(new Date());
                        alternateDosages.setNewprescriptionitemsid(Long.parseLong(prescriptionItemsId));
                        Object saved = genericClassService.saveOrUpdateRecordLoadObject(alternateDosages);
                        if (saved != null) {
                            result = "success";
                        } else {
                            result = "failure";
                        }
                    } else if (quantity == 0.25F) {
                        if (initialRequest == false) {
                            Long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
                            alternateDosages.setItemid(Long.parseLong(itemId.toString()));
                            alternateDosages.setDosage(alternateDose);
                            alternateDosages.setAddedby(staffId);
                            alternateDosages.setDateadded(new Date());
                            alternateDosages.setUpdatedby(staffId);
                            alternateDosages.setDateupdated(new Date());
                            alternateDosages.setNewprescriptionitemsid(Long.parseLong(prescriptionItemsId));
                            Object saved = genericClassService.saveOrUpdateRecordLoadObject(alternateDosages);
                            if (saved != null) {
                                result = "success";
                            } else {
                                result = "failure";
                            }
                        } else {
                            result = "The dosage will be split into 4. Do you want to continue?";
                        }

                    } else if (quantity < 0.25F) {
                        result = "Alternate dosage cannot be: " + alternateDose + ". Cannot split dosage more than 4 times";
                    }
                } else {
                    result = "Dosage " + alternateDose + " cannot be altered.";
                }
            } else {
                result = "This item already has an alternate dosage. Do you want to save anyway?";
            }
//            if(result.equalsIgnoreCase("success")){
//                String[] columnscellqty = {"hasaltdosage"};
//                Object[] columnValuescellqty = {Boolean.TRUE};
//                String pkcellqty = "newprescriptionitemsid";
//                Object pkValuecellqty = Long.parseLong(prescriptionItemsId);
//                int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
//                genericClassService.updateRecordSQLSchemaStyle(Modifiedprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
//                if (rowsAffected > 0) {
//                    result = "success";
//                } else {
//                    result = "failure";
//                }
//            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return result;
    }

    @RequestMapping(value = "/deletealternatedosage", method = RequestMethod.POST)
    public @ResponseBody
    String deleteAlternateDosage(HttpServletRequest request,
            @ModelAttribute("prescriptionitemsid") String prescriptionitemsId,
            @ModelAttribute("itemid") String itemId) {
        String result = "";
        try {
            String[] columns = {"newprescriptionitemsid", "itemid"};
            Object[] columnValues = {Long.parseLong(prescriptionitemsId), Long.parseLong(itemId)};
            int rowsAffected = genericClassService.deleteRecordBySchemaByColumns(Alternatedosages.class, columns, columnValues, "patient");
            if (rowsAffected == 0) {
                result = "failure";
            } else {
//                if(result.equalsIgnoreCase("success")){
//                    String[] columnscellqty = {"hasaltdosage"};
//                    Object[] columnValuescellqty = {Boolean.FALSE};
//                    String pkcellqty = "newprescriptionitemsid";
//                    Object pkValuecellqty = Long.parseLong(prescriptionitemsId);
//                    rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
//                    genericClassService.updateRecordSQLSchemaStyle(Modifiedprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
//                    if (rowsAffected > 0) {
//                        result = "success";
//                    } else {
//                        result = "failure";
//                    }
//                }
                result = "success";
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/reviewprescription", method = RequestMethod.GET)
    public @ResponseBody
    String reviewPrescription(HttpServletRequest request,
            @ModelAttribute("prescriptionid") String prescriptionid) {
        String result = "";
        try {
            boolean hasApprovables = false;
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            BigInteger itemId = BigInteger.valueOf(0);
            long patientVisitId = (request.getParameter("patientvisitid") != null) ? Long.parseLong(request.getParameter("patientvisitid")) : 0;
            String[] fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                "dosage", "dose", "days", "daysname", "isapproved",
                "isissued", "itemname"};
            String[] params = {"prescriptionid"};
            Object[] paramsValues = {Long.parseLong(prescriptionid)};
            String where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptionItems != null) {
                for (Object[] prescriptionItem : prescriptionItems) {
                    itemId = BigInteger.valueOf(0L);
                    fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                        "dosage", "dose", "days", "daysname", "isapproved",
                        "isissued", "itemname"};
                    List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, "WHERE prescriptionid=:prescriptionid AND newprescriptionitemsid=:newprescriptionitemsid", new String[]{"prescriptionid", "newprescriptionitemsid"},
                            new Object[]{Long.parseLong(prescriptionid), prescriptionItem[0]});
                    if (modifiedPrescriptionItems != null) {
                        prescriptionItem = modifiedPrescriptionItems.get(0);
                    }
                    fields = new String[]{"altdosageid", "dosage", "addedby",
                        "dateadded", "updatedby", "dateupdated", "newprescriptionitemsid", "itemid"};
                    List<Object[]> altDosages = (List<Object[]>) genericClassService.fetchRecord(Alternatedosages.class, fields, "WHERE newprescriptionitemsid=:newprescriptionitemsid", new String[]{"newprescriptionitemsid"}, new Object[]{prescriptionItem[0]});
                    if (altDosages != null) {
                        for (Object[] altDose : altDosages) {
                            itemId = BigInteger.valueOf(Long.parseLong(altDose[7].toString()));
                        }
                    } else {
                        List<Object> itemPackageIds = (List<Object>) genericClassService.fetchRecord(Itempackage.class,
                                new String[]{"itempackageid"}, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemstrength", new String[]{"genericname", "itemstrength"}, new Object[]{prescriptionItem[8].toString(), prescriptionItem[3].toString().toLowerCase().replaceAll("\\s+", "")});
                        if (itemPackageIds != null) {
                            itemId = BigInteger.valueOf(Long.parseLong(itemPackageIds.get(0).toString()));
                        }
                    }
                    Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
                    long qtyInStock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                    if (qtyInStock <= 0) {
                        String[] columns = {"approvable"};
                        Object[] columnValues = {Boolean.FALSE};
                        String pk = "newprescriptionitemsid";
                        Object pkValue = Long.valueOf(prescriptionItem[0].toString());
                        genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");
                        boolean isOutOfStock = isOutOfStock(prescriptionItem[8].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                        if ((!isOutOfStock)) {
                            recordUresolvedPrescription(Long.parseLong(prescriptionItem[1].toString()), Long.parseLong(prescriptionItem[0].toString()), patientVisitId, currStaffId, facilityUnitId);
                        } else if (isOutOfStock) {
                            recordUnservicedPrescription(Long.parseLong(prescriptionItem[1].toString()), currStaffId, facilityUnitId);
                        }
                    } else if (qtyInStock > 0) {
                        hasApprovables = Boolean.TRUE;
                        String[] columns = {"approvable"};
                        Object[] columnValues = {Boolean.TRUE};
                        String pk = "newprescriptionitemsid";
                        Object pkValue = Long.valueOf(prescriptionItem[0].toString());
                        genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");

                        columns = new String[]{"patientvisitid", "prescriptionid", "prescriptionitemsid"};
                        columnValues = new Object[]{patientVisitId, Long.parseLong(prescriptionItem[1].toString()), Long.parseLong(prescriptionItem[0].toString())};
                        int rowsAffected = genericClassService.deleteRecordBySchemaByColumns(Unresolvedprescriptionitems.class, columns, columnValues, "patient");
                    }
                }
            }
            String[] columns = {"lastupdated", "status", "lastupdatedby"};
            Object[] columnValues = {new Date(), "REVIEWED", currStaffId};
            String pk = "prescriptionid";
            Object pkValue = Long.valueOf(prescriptionid);
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
            if (rowsAffected > 0) {
                result = "success";
            } else {
                result = "failure";
            }
            Map<String, Object> data = new HashMap<>();
            data.put("hasapprovables", hasApprovables);
            data.put("result", result);
            result = new ObjectMapper().writeValueAsString(data);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/recordunservicedprescription", method = RequestMethod.POST)
    public @ResponseBody
    String recordUnServicedPrescriptions(HttpServletRequest request) {
        String result = "";
        try {
            int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            long prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            result = recordUnservicedPrescription(prescriptionId, currStaffId, facilityUnitId);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/recordunresolvedprescriptions", method = RequestMethod.POST)
    public @ResponseBody
    String recordUresolvedPrescriptions(HttpServletRequest request) {
        String result = "";
        try {
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            long prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            long patientVisitId = (request.getParameter("patientvisitid") != null) ? Long.parseLong(request.getParameter("patientvisitid")) : 0;
            String[] fields = {"newprescriptionitemsid"};
            String[] params = {"prescriptionid"};
            Object[] paramsValues = {prescriptionId};
            String where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptionItems != null) {
                for (Object[] prescriptionItem : prescriptionItems) {
                    recordUresolvedPrescription(prescriptionId, Long.parseLong(prescriptionItem[0].toString()), patientVisitId, currStaffId, facilityUnitId);
                }
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/viewfacilityunitreviewedprescriptionitems.htm", method = RequestMethod.GET)
    public String viewfacilityunitreviewedprescriptionitems(Model model, HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) {
        List<Map> prescItemsList = new ArrayList<>();

        String[] paramorderItems = {"prescriptionid", "approvable"};
        Object[] paramsValuesorderItems = {Long.parseLong(prescriptionid), Boolean.TRUE};
        String[] fieldsorderItems = {"newprescriptionitemsid", "itemname"};
        String whereorderItems = "WHERE prescriptionid=:prescriptionid AND approvable=:approvable";
        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class,
                fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems != null) {
            for (Object[] itm : objOrderItems) {
                items = new HashMap<>();
                items.put("genericname", itm[1].toString());
                String[] paramsitemqtyapprv = {"newprescriptionitemsid"};
                Object[] paramsValuesitemqtyapprv = {itm[0]};
                String whereitemqtyapprv = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                String[] fieldsitemqtyapprv = {"quantityapproved"};
                List<Integer> objitemqtyapprv = (List<Integer>) genericClassService.fetchRecord(Prescriptionissue.class, fieldsitemqtyapprv, whereitemqtyapprv, paramsitemqtyapprv, paramsValuesitemqtyapprv);
                if (objitemqtyapprv != null) {
                    items.put("quantityapproved", objitemqtyapprv.get(0));
                }
                prescItemsList.add(items);
            }
        }
        model.addAttribute("prescItemsList", prescItemsList);
        return "dispensing/views/prescriptionItems";
    }

    @RequestMapping(value = "/viewfacilityunitapprovedprescriptionitems.htm", method = RequestMethod.GET)
    public String viewfacilityunitapprovedprescriptionitems(Model model, HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) {
        List<Map> prescItemsList = new ArrayList<>();

        String[] paramorderItems = {"prescriptionid", "isapproved"};
        Object[] paramsValuesorderItems = {Long.parseLong(prescriptionid), Boolean.TRUE};
        String[] fieldsorderItems = {"newprescriptionitemsid", "itemname"};
        String whereorderItems = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved";
        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class,
                fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems != null) {
            for (Object[] itm : objOrderItems) {
                items = new HashMap<>();
                items.put("genericname", itm[1].toString());
                String[] paramsitemqtyapprv = {"newprescriptionitemsid"};
                Object[] paramsValuesitemqtyapprv = {itm[0]};
                String whereitemqtyapprv = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                String[] fieldsitemqtyapprv = {"quantityapproved"};
                List<Integer> objitemqtyapprv = (List<Integer>) genericClassService.fetchRecord(Prescriptionissue.class, fieldsitemqtyapprv, whereitemqtyapprv, paramsitemqtyapprv, paramsValuesitemqtyapprv);
                if (objitemqtyapprv != null) {
                    items.put("quantityapproved", objitemqtyapprv.get(0));
                }
                prescItemsList.add(items);
            }
        }
        model.addAttribute("prescItemsList", prescItemsList);
        return "dispensing/views/prescriptionItems";
    }

    @RequestMapping(value = "/viewfacilityunitpickedprescriptionitems.htm", method = RequestMethod.GET)
    public String viewfacilityunitpickedprescriptionitems(Model model, HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) {
        List<Map> prescItemsList = new ArrayList<>();

        String[] paramorderItems = {"prescriptionid", "isapproved"};
        Object[] paramsValuesorderItems = {Long.parseLong(prescriptionid), Boolean.TRUE};
        String[] fieldsorderItems = {"newprescriptionitemsid", "itemname"};
        String whereorderItems = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved";
        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class,
                fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems != null) {
            for (Object[] itm : objOrderItems) {
                items = new HashMap<>();
                items.put("genericname", itm[1].toString());
                String[] paramsitemqtyapprv = {"newprescriptionitemsid"};
                Object[] paramsValuesitemqtyapprv = {itm[0]};
                String whereitemqtyapprv = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                String[] fieldsitemqtyapprv = {"quantityapproved"};
                List<Integer> objitemqtyapprv = (List<Integer>) genericClassService.fetchRecord(Prescriptionissue.class, fieldsitemqtyapprv, whereitemqtyapprv, paramsitemqtyapprv, paramsValuesitemqtyapprv);
                if (objitemqtyapprv != null) {
                    items.put("quantityapproved", objitemqtyapprv.get(0));
                }

                prescItemsList.add(items);
            }
        }
        model.addAttribute("prescItemsList", prescItemsList);
        return "dispensing/views/prescriptionItems";
    }

    @RequestMapping(value = "/approveprescriptionitem", method = RequestMethod.POST)
    public @ResponseBody
    String approvePrescriptionItem(HttpServletRequest request,
            @ModelAttribute("prescriptionitemid") String prescriptionitemid,
            @ModelAttribute("itempackageid") String itempackageid,
            @ModelAttribute("quantityapproved") String approvedquantity) {
        String result = "";
        try {
            Prescriptionissue prescriptionIssue = new Prescriptionissue();
            prescriptionIssue.setQuantityapproved(Integer.valueOf(approvedquantity));
            prescriptionIssue.setItempackageid(BigInteger.valueOf(Long.valueOf(itempackageid)));
            prescriptionIssue.setNewprescriptionitemsid(BigInteger.valueOf(Long.parseLong(prescriptionitemid)));
            Object saved = genericClassService.saveOrUpdateRecordLoadObject(prescriptionIssue);
            if (saved != null) {
                String[] columnscellqty = {"isapproved"};
                Object[] columnValuescellqty = {Boolean.TRUE};
                String pkcellqty = "newprescriptionitemsid";
                Object pkValuecellqty = Long.parseLong(prescriptionitemid);
                int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
                genericClassService.updateRecordSQLSchemaStyle(Modifiedprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
                if (rowsAffected > 0) {
                    result = "success";
                } else {
                    result = "failure";
                }
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/unapproveprescriptionitem", method = RequestMethod.POST)
    public @ResponseBody
    String unApprovePrescriptionItem(HttpServletRequest request,
            @ModelAttribute("prescriptionitemid") String prescriptionitemid,
            @ModelAttribute("itempackageid") String itempackageid) {
        String result = "";
        try {
            String[] columns = {"newprescriptionitemsid", "itempackageid"};
            Object[] columnValues = {BigInteger.valueOf(Long.parseLong(prescriptionitemid)), BigInteger.valueOf(Long.parseLong(itempackageid))};
            int rowsAffected = genericClassService.deleteRecordBySchemaByColumns(Prescriptionissue.class, columns, columnValues, "store");
            if (rowsAffected > 0) {
                String[] columnscellqty = {"isapproved"};
                Object[] columnValuescellqty = {Boolean.FALSE};
                String pkcellqty = "newprescriptionitemsid";
                Object pkValuecellqty = Long.parseLong(prescriptionitemid);
                rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
                genericClassService.updateRecordSQLSchemaStyle(Modifiedprescriptionitems.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "patient");
                if (rowsAffected > 0) {
                    result = "success";
                } else {
                    result = "failure";
                }
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/submitApprovedPrescriptions.htm", method = RequestMethod.GET)
    public @ResponseBody
    String submitApprovedPrescriptions(Model model, HttpServletRequest request, @ModelAttribute("patientprescriptionid") String prescriptionid) throws IOException {
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        String result = "";
        int rowsAffected = 0;
        String[] columns = {"dateapproved", "status", "approvedby"};
        Object[] columnValues = {new Date(), "APPROVED", currStaffId};
        String pk = "prescriptionid";
        Object pkValue = Long.parseLong(prescriptionid);
        rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
        if (rowsAffected > 0) {
            result = "success";
        } else {
            result = "failure";
        }
        String[] params = {"status", "destinationunitid", "dateprescribed"};
        Object[] paramsValues = new Object[]{"APPROVED", Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), new Date()};
        String where = "WHERE status=:status AND destinationunitid=:destinationunitid AND DATE(dateprescribed)=:dateprescribed";
        int pickListCount = genericClassService.fetchRecordCount(Prescription.class, where, params, paramsValues);

        Map<String, Object> data = new HashMap<>();
        data.put("result", result);
        data.put("pickListCount", pickListCount);
        result = new ObjectMapper().writeValueAsString(data);

        return result;
    }

    @RequestMapping(value = "/checkforprepackageditems", method = RequestMethod.GET)
    public String checkForPrePackagedItems(HttpServletRequest request, Model model) {
        String result = "0";
        try {
            final List<Map> pickList = new ArrayList<>();
            List<Map> itemPickList = new ArrayList<>();
            final List<Map> qtyList = new ArrayList<>();
            int pickListTableSize = 0;
            final long prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            final int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            final Long staffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            final Long patientVisitId = 0L;
            String[] fields = {"newprescriptionitemsid"};
            String[] params = {"prescriptionid"};
            Object[] paramsValues = {prescriptionId};
            String where = "WHERE prescriptionid=:prescriptionid AND isapproved=true AND isissued=false";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptionItems != null) {
                for (Object[] prescriptionItem : prescriptionItems) {
                    fields = new String[]{"prescriptionissueid", "notes", "issuedby", "newprescriptionitemsid", "dateissued", "quantityapproved",
                        "itempackageid"};
                    where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                    params = new String[]{"newprescriptionitemsid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionItem[0].toString())};
                    List<Object[]> prescriptionIssues = (List<Object[]>) genericClassService.fetchRecord(Prescriptionissue.class, fields, where, params, paramsValues);
                    if (prescriptionIssues != null) {
                        Map<String, Object> item;
                        Map<String, Object> pickListQtys;
                        for (Object[] prescriptionIssue : prescriptionIssues) {
                            item = new HashMap<>();
                            item.put("prescriptionissueid", prescriptionIssue[0]);
                            params = new String[]{"itempackageid"};
                            paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(prescriptionIssue[6].toString()))};
                            where = "WHERE itempackageid=:itempackageid";
                            fields = new String[]{"itemid", "packagename"};
                            List<Object[]> packageItem = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                            if (packageItem != null) {
                                item.put("genericname", packageItem.get(0)[1]);
                            }
                            List<Map> itemLocation = getItemslocations(Long.parseLong(prescriptionIssue[6].toString()), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                            itemPickList = generatePickList(itemLocation, Integer.parseInt(prescriptionIssue[5].toString()));
                            item.put("itemid", prescriptionIssue[6]);
                            Collections.sort(itemPickList, sortCells2);//                            
                            for (Map itemsstockdetails : itemPickList) {
                                pickListQtys = new HashMap<>();
                                pickListQtys.put("prescriptionitemsid", prescriptionIssue[3]);
                                pickListQtys.put("itemid", prescriptionIssue[6]);
                                pickListQtys.put("cellid", itemsstockdetails.get("cellid"));
                                pickListQtys.put("stockid", itemsstockdetails.get("stockid"));
                                pickListQtys.put("qtypicked", 0);
                                pickList.add(pickListQtys);
                            }

                            int itemPickListsize = itemPickList.size();
                            pickListTableSize += itemPickListsize;
                            item.put("pick", itemPickList);
                            item.put("quantityapproved", prescriptionIssue[5]);
                            qtyList.add(item);
                        }
                    }
                }
            }
            model.addAttribute("date", formatter.format(new Date()));
            model.addAttribute("picklisttablesize", pickListTableSize);
            model.addAttribute("prescriptionid", prescriptionId);
            model.addAttribute("items", qtyList);
            model.addAttribute("jsonitems", new ObjectMapper().writeValueAsString(pickList));
            model.addAttribute("jsonqtypicklist", new ObjectMapper().writeValueAsString(pickList));
            model.addAttribute("facilityunitid", facilityUnitId);
            model.addAttribute("staffid", staffId);
            model.addAttribute("patientvisitid", patientVisitId);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (JsonProcessingException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return "dispensing/views/pickList";
    }

    @RequestMapping(value = "/pickitems", method = RequestMethod.GET)
    public String pickItems(HttpServletRequest request, Model model,
            @ModelAttribute("prescriptionid") String prescriptionId) {
        List<Map> pickList = new ArrayList<>();
        List<Map> itemPickList = new ArrayList<>();
        List<Map> qtyList = new ArrayList<>();
        int pickListTableSize = 0;
        try {
            int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            Long staffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Long patientVisitId = 0L;
            List<Object> prescriptions = (List<Object>) genericClassService.fetchRecord(Prescription.class, new String[]{"patientvisitid"}, "WHERE prescriptionid=:prescriptionid", new String[]{"prescriptionid"}, new Object[]{Long.parseLong(prescriptionId)});
            if (prescriptions != null) {
                patientVisitId = Long.parseLong(prescriptions.get(0).toString());
            }
            String[] params = {"staffid"};
            Object[] paramsValues = {Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString())};
            String[] fields = {"firstname", "lastname", "othernames", "personid"};
            List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, "WHERE staffid=:staffid", params, paramsValues);
            if (objPrescriber != null) {
                Object[] per = objPrescriber.get(0);
                if (per[2] != null) {
                    model.addAttribute("name", per[0] + " " + per[1] + " " + per[2]);
                } else {
                    model.addAttribute("name", per[0] + " " + per[1]);
                }
            }
            params = new String[]{"patientvisitid"};
            paramsValues = new Object[]{BigInteger.valueOf(patientVisitId)};
            String where = "WHERE patientvisitid=:patientvisitid";
            fields = new String[]{"fullname", "visitnumber", "patientno"};
            List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (persons != null) {
                Object[] personDetails = persons.get(0);
                model.addAttribute("patientname", (String) personDetails[0]);
                model.addAttribute("patientno", (String) personDetails[2]);
                model.addAttribute("visitnumber", (String) personDetails[1]);
            }
            fields = new String[]{"newprescriptionitemsid", "prescriptionid",
                "dosage", "dose", "days", "daysname", "isapproved", "isissued",
                "itemname"};
            where = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved";
            params = new String[]{"prescriptionid", "isapproved"};
            paramsValues = new Object[]{Long.parseLong(prescriptionId), Boolean.TRUE};
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptionItems != null) {
                for (Object[] prescriptionItem : prescriptionItems) {
                    fields = new String[]{"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname",
                        "isapproved", "isissued", "itemname"};
                    List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, "WHERE prescriptionid=:prescriptionid AND newprescriptionitemsid=:newprescriptionitemsid", new String[]{"prescriptionid", "newprescriptionitemsid"}, new Object[]{Long.parseLong(prescriptionItem[1].toString()), Long.parseLong(prescriptionItem[0].toString())});
                    if (modifiedPrescriptionItems != null) {
                        prescriptionItem = modifiedPrescriptionItems.get(0);
                    }
                    fields = new String[]{"prescriptionissueid", "notes", "issuedby", "newprescriptionitemsid", "dateissued", "quantityapproved",
                        "itempackageid"};
                    where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                    params = new String[]{"newprescriptionitemsid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionItem[0].toString())};
                    List<Object[]> prescriptionIssues = (List<Object[]>) genericClassService.fetchRecord(Prescriptionissue.class, fields, where, params, paramsValues);
                    if (prescriptionIssues != null) {
                        Map<String, Object> item;
                        Map<String, Object> pickListQtys;
                        for (Object[] prescriptionIssue : prescriptionIssues) {
                            item = new HashMap<>();
                            item.put("prescriptionissueid", prescriptionIssue[0]);
                            params = new String[]{"itempackageid"};
                            paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(prescriptionIssue[6].toString()))};
                            where = "WHERE itempackageid=:itempackageid";
                            fields = new String[]{"itemid", "packagename"};
                            List<Object[]> packageItem = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                            if (packageItem != null) {
                                item.put("genericname", packageItem.get(0)[1]);
                            }
                            List<Map> itemLocation = getItemslocations(Long.parseLong(prescriptionIssue[6].toString()), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                            itemPickList = generatePickList(itemLocation, Integer.parseInt(prescriptionIssue[5].toString()));
                            item.put("itemid", prescriptionIssue[6]);
                            Collections.sort(itemPickList, sortCells2);//                            
                            for (Map itemsstockdetails : itemPickList) {
                                pickListQtys = new HashMap<>();
                                pickListQtys.put("prescriptionitemsid", prescriptionIssue[3]);
                                pickListQtys.put("itemid", prescriptionIssue[6]);
                                pickListQtys.put("cellid", itemsstockdetails.get("cellid"));
                                pickListQtys.put("stockid", itemsstockdetails.get("stockid"));
                                pickListQtys.put("qtypicked", 0);
                                //
                                long stockId = (itemsstockdetails.get("stockid") != null) ? Long.parseLong(itemsstockdetails.get("stockid").toString()) : 0;
                                params = new String[]{"stockid", "facilityunitid", "quantity"};
                                paramsValues = new Object[]{stockId, Long.parseLong(String.valueOf(facilityUnitId)), Integer.parseInt(prescriptionIssue[5].toString())};
                                where = "WHERE stockid=:stockid AND facilityunitid=:facilityunitid AND eachpacket=:quantity";
                                int packageCount = genericClassService.fetchRecordCount(com.iics.store.Package.class, where, params, paramsValues);
                                if (packageCount > 0) {
                                    item.put("hasPackages", Boolean.TRUE);
                                } else {
                                    item.put("hasPackages", Boolean.FALSE);
                                }
                                //                                
                                pickList.add(pickListQtys);
                            }

                            int itemPickListsize = itemPickList.size();
                            pickListTableSize += itemPickListsize;
                            item.put("pick", itemPickList);
                            item.put("quantityapproved", prescriptionIssue[5]);
                            qtyList.add(item);
                        }
                    }
                }
            }
            //
            fields = new String[]{"addedby"};
            params = new String[]{"prescriptionid"};
            paramsValues = new Object[]{Long.parseLong(prescriptionId)};
            where = "WHERE prescriptionid=:prescriptionid";
            List<Object> prescriberIds = (List<Object>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
            if (prescriberIds != null) {
                model.addAttribute("prescriberid", prescriberIds.get(0));
            }
            //
            model.addAttribute("date", formatter.format(new Date()));
            model.addAttribute("picklisttablesize", pickListTableSize);
            model.addAttribute("prescriptionid", prescriptionId);
            model.addAttribute("items", qtyList);
            model.addAttribute("jsonitems", new ObjectMapper().writeValueAsString(pickList));
            model.addAttribute("jsonqtypicklist", new ObjectMapper().writeValueAsString(pickList));
            model.addAttribute("facilityunitid", facilityUnitId);
            model.addAttribute("staffid", staffId);
            model.addAttribute("patientvisitid", patientVisitId);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "dispensing/views/pickList";
    }

    @RequestMapping(value = "/generatewalkorder.htm", method = RequestMethod.GET)
    public @ResponseBody
    String generatewalkorder(Model model, HttpServletRequest request) throws IOException {
        Set cellLocationSet = new HashSet();
        int section = 0;
        String page = "";
        String jsonsortedList = "";
        String jsonsortedListx = "";

        try {
            section = Integer.parseInt(request.getParameter("selectedid").toString());
            List<Map> itemorderqty = new ObjectMapper().readValue(request.getParameter("qtyorderedvalues"), List.class);
            for (Map itemone : itemorderqty) {
                Map<String, Object> map = (HashMap) itemone;
                cellLocationSet.add((String) map.get("value"));
            }
            List sortedList = new ArrayList(cellLocationSet);
            Collections.sort(sortedList);
            switch (section) {
                case 1:
                    jsonsortedListx = new ObjectMapper().writeValueAsString(sortedList);
                    page = jsonsortedListx;
                    break;
                case 2:
                    jsonsortedList = new ObjectMapper().writeValueAsString(sortedList);
                    page = jsonsortedList;
                    break;
                default:
                    break;
            }
        } catch (IOException | NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return page;
    }

    @RequestMapping(value = "/savepickeditems", method = RequestMethod.GET)
    public @ResponseBody
    String savePickedItems(HttpServletRequest request,
            @ModelAttribute("prescriptionid") String prescriptionId) {
        String result = "";
        try {
            Long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
            Date dateAdded = new Date();
            List<Map> pickedItems = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtypickedvalues"), List.class);
            if (pickedItems != null) {
                for (Map pickedItem : pickedItems) {
                    Picklist pickList = new Picklist();
                    int cellId = Integer.parseInt(pickedItem.get("cellid").toString());
                    Long stockId = Long.parseLong(pickedItem.get("stockid").toString());
                    Long prescriptionItemsId = Long.parseLong(pickedItem.get("prescriptionitemsid").toString());
                    Long itemId = 0L;
                    long qtyPicked = Long.parseLong(pickedItem.get("qtypicked").toString());
                    itemId = Long.parseLong(pickedItem.get("itemid").toString());
                    //
                    boolean usePackage = (pickedItem.get("usepackage") != null) ? Boolean.valueOf(pickedItem.get("usepackage").toString()) : Boolean.FALSE;
                    //
                    pickList.setStockid(stockId);
                    pickList.setBayrowcellid(cellId);
                    pickList.setItemid(itemId);
                    pickList.setQuantitypicked(qtyPicked);
                    pickList.setAddedby(staffId);
                    pickList.setDateadded(dateAdded);
                    Object saved = genericClassService.saveOrUpdateRecordLoadObject(pickList);
                    if (saved != null) {
                        Prescriptionpicklist prescriptionPickList = new Prescriptionpicklist();
                        prescriptionPickList.setPicklistid(((Picklist) saved).getPicklistid());
                        prescriptionPickList.setPrescriptionid(Long.parseLong(prescriptionId));
                        prescriptionPickList.setNewprescriptionitemsid(prescriptionItemsId);
                        saved = genericClassService.saveOrUpdateRecordLoadObject(prescriptionPickList);
                        if (saved != null) {
                            String[] columns = {"lastupdated", "status", "lastupdatedby"};
                            Object[] columnValues = {new Date(), "PICKED", staffId};
                            String pk = "prescriptionid";
                            Object pkValue = Long.parseLong(prescriptionId);
                            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
                            result = (rowsAffected == 0) ? "failure" : "success";
                            //
                            columns = new String[]{"usepackage"};
                            columnValues = new Object[]{usePackage};
                            pk = "newprescriptionitemsid";
                            pkValue = prescriptionItemsId;
                            rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionissue.class, columns, columnValues, pk, pkValue, "store");
                            result = (rowsAffected == 0) ? "failure" : "success";
                            //
                        } else {
                            result = "failure";
                        }
                    } else {
                        result = "failure";
                    }
                }
            }
//            String[] params = {"status", "destinationunitid", "dateprescribed"};
//            Object[] paramsValues = new Object[]{"PICKED", Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), new Date()};
//            String where = "WHERE status=:status AND destinationunitid=:destinationunitid AND dateprescribed=:dateprescribed";
//            int readyToIssueCount = genericClassService.fetchRecordCount(Prescription.class, where, params, paramsValues);
//
            Map<String, Object> data = new HashMap<>();
            data.put("result", result);
//            data.put("readyToIssueCount", readyToIssueCount);
            result = new ObjectMapper().writeValueAsString(data);
        } catch (Exception ex) {
            System.out.println(ex);
        }

        return result;
    }

    @RequestMapping(value = "/readytoissueitems", method = RequestMethod.GET)
    public ModelAndView readyToIssueItems(HttpServletRequest request,
            @ModelAttribute("prescriptionid") String prescriptionid) {
        Map<String, Object> model = new HashMap<>();
        List<Map<String, Object>> readyToIssueItems = new ArrayList<>();
        String frequency = "";
        Float quantity = 1.0F;
        String patientname = "", patientno = "", visitnumber = "", originUnitId = "", referenceNumber = "";
        Long prescriptionId = 0L;
        long patientVisitId = 0L;
        try {
            int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            String[] fields = {"prescriptionid", "patientvisitid", "originunitid", "referencenumber"};
            String[] params = {"prescriptionid"};
            Object[] paramsValues = {Long.parseLong(prescriptionid)};
            String where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
            if (prescriptions != null) {
                patientVisitId = Long.parseLong(prescriptions.get(0)[1].toString());
                for (Object[] prescription : prescriptions) {
                    originUnitId = (prescription[2] != null) ? prescription[2].toString() : "";
                    referenceNumber = (prescription[3] != null) ? prescription[3].toString() : "";
                    prescriptionId = Long.parseLong(prescription[0].toString());
                    fields = new String[]{"newprescriptionitemsid", "dosage",
                        "dose", "days", "daysname", "itemname", "notes"};
                    params = new String[]{"prescriptionid", "isapproved"};
                    paramsValues = new Object[]{Long.parseLong(prescription[0].toString()), Boolean.TRUE};
                    where = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved";
                    List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
                    if (prescriptionItems != null) {
                        Map<String, Object> item = null;
                        for (Object[] prescriptionItem : prescriptionItems) {
                            item = new HashMap<>();
                            item.put("specialinstructions", prescriptionItem[6].toString());
                            fields = new String[]{"newprescriptionitemsid", "dosage", "dose", "days", "daysname", "itemname"};
                            params = new String[]{"newprescriptionitemsid"};
                            paramsValues = new Object[]{Long.parseLong(prescriptionItem[0].toString())};
                            where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                            List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues);
                            if (modifiedPrescriptionItems != null) {
                                prescriptionItem = modifiedPrescriptionItems.get(0);
                            }
                            item.put("medicine", prescriptionItem[5].toString());
                            fields = new String[]{"altdosageid", "dosage", "addedby", "dateadded", "updatedby", "dateupdated",
                                "newprescriptionitemsid", "itemid"};
                            List<Object[]> altDosages = (List<Object[]>) genericClassService.fetchRecord(Alternatedosages.class, fields, "WHERE newprescriptionitemsid=:newprescriptionitemsid", new String[]{"newprescriptionitemsid"}, new Object[]{Long.parseLong(prescriptionItem[0].toString())});
                            if (altDosages != null) {
                                for (Object[] altDose : altDosages) {
                                    String itemStrength = (prescriptionItem[2] != null) ? prescriptionItem[2].toString() : null;
                                    quantity = getQuantity(itemStrength, altDose[1].toString());
                                }
                            } else {
                                String itemStrength = (prescriptionItem[2] != null) ? prescriptionItem[2].toString() : "";
                                quantity = 1.0F;
                            }
                            if (prescriptionItem[1].toString().equalsIgnoreCase("Daily(OD)")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 1";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 1";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 1";
                                } else {
                                    frequency = quantity + " x 1";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("BID/b.i.d")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 2";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 2";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 2";
                                } else {
                                    frequency = quantity + " x 2";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("TID/t.i.d")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 3";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 3";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 3";
                                } else {
                                    frequency = quantity + " x 3";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("QID/q.i.d")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 4";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 4";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 4";
                                } else {
                                    frequency = quantity + " x 4";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("QHS(Bed time)")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 1";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 1";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 1";
                                } else {
                                    frequency = quantity + " x 1";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("Q4h(Every 4 hours)")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 3";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 3";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 3";
                                } else {
                                    frequency = quantity + " x 3";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("Q4h-6h(4-6 hours)")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 3";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 3";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 3";
                                } else {
                                    frequency = quantity + " x 3";
                                }
                            } else if (prescriptionItem[1].toString().equalsIgnoreCase("QWK(Every Week)")) {
                                if (quantity.toString().contains(".0")) {
                                    frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 1";
                                } else if (quantity == 0.5F) {
                                    frequency = "1/2 x 1";
                                } else if (quantity == 0.25F) {
                                    frequency = "1/4 x 1";
                                } else {
                                    frequency = quantity + " x 1";
                                }
                            }

                            item.put("frequency", frequency);
                            String duration = (prescriptionItem[3] != null) ? prescriptionItem[3].toString() + " " : "";
                            duration += (prescriptionItem[4] != null) ? prescriptionItem[4].toString() + " " : "";
                            item.put("duration", duration);
                            readyToIssueItems.add(item);
                        }
                    }
                }
            }
            //        
            params = new String[]{"patientvisitid"};
            paramsValues = new Object[]{patientVisitId};
            where = "WHERE patientvisitid=:patientvisitid";
            fields = new String[]{"fullname", "visitnumber", "patientno", "dob", "gender", "patientid", "personid"};
            List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (persons != null) {
                Object[] personDetails = persons.get(0);
                model.put("name", personDetails[0].toString());
                model.put("patientno", personDetails[2].toString());
                model.put("visitnumber", personDetails[1].toString());
                model.put("dob", personDetails[3].toString());
                model.put("gender", personDetails[4].toString());
                model.put("patientvisitid", request.getParameter("patientvisitid"));
                params = new String[]{"patientid"};
                paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(personDetails[5].toString()))};
                fields = new String[]{"personid", "firstname", "lastname", "othernames", "patientno", "telephone", "nextofkin", "currentaddress"};
                List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, "WHERE patientid=:patientid", params, paramsValues);
                if (patientsvisitsbasicinfo != null) {
                    model.put("telephone", patientsvisitsbasicinfo.get(0)[5]);
                    model.put("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
                    String year = formatter.format((Date) personDetails[3]);
                    String currentyear = formatter.format(new Date());
                    Date dateBefore;
                    try {
                        dateBefore = formatter.parse(year);
                        Date dateAfter = formatter.parse(currentyear);
                        long difference = dateAfter.getTime() - dateBefore.getTime();
                        float daysBetween = (difference / (1000 * 60 * 60 * 24));
                        model.put("estimatedage", computeAge3(Math.round(daysBetween)));
                    } catch (ParseException ex) {
                        System.out.println(ex);
                    }
                }
                String[] paramsresidence = {"villageid"};
                Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
                String[] fieldsresidence = {"villagename"};
                List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
                if (patientsvisitsresidence != null) {
                    model.put("village", patientsvisitsresidence.get(0));
                }
                String[] paramsTriage = {"patientvisitid"};
                Object[] paramsValuesTriage = {patientVisitId};
                fields = new String[]{"weight", "height"};
                List<Object[]> objTriage = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", paramsTriage, paramsValuesTriage);
                if (objTriage != null) {
                    Double patientBMI = 0.0;
                    for (Object[] obj : objTriage) {
                        if (obj[0] != null && obj[1] != null) {
                            Double weight = Double.parseDouble(obj[0].toString());
                            Double heightcm = Double.parseDouble(obj[1].toString());
                            Double heightInMetres = (heightcm / 100);
                            Double heightInMetresSquared = (heightInMetres * heightInMetres);
                            patientBMI = (weight / heightInMetresSquared);
                        }
                    }
                    model.put("patientBMI", patientBMI);
                }
            }
            List<String> observations = new ArrayList<>();
            params = new String[]{"patientvisitid"};
            paramsValues = new Object[]{patientVisitId};
            fields = new String[]{"observation"};
            List<Object> patientObservations = (List<Object>) genericClassService.fetchRecord(Patientobservation.class, fields, where, params, paramsValues);
            if (patientObservations != null) {
                for (Object observation : patientObservations) {
                    observations.add(observation.toString());
                }
            }
            model.put("observations", observations);
            //
            model.put("facilityunitid", facilityUnitId);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        model.put("originunitid", originUnitId);
        model.put("referencenumber", referenceNumber);
        model.put("patientvisitid", patientVisitId);
        model.put("readyToIssueItems", readyToIssueItems);
        model.put("prescriptionid", prescriptionId);
        return new ModelAndView("dispensing/views/readyToIssueItems", model);
    }

    @RequestMapping(value = "/issuereadyitems", method = RequestMethod.GET)
    public @ResponseBody
    String issueReadyItems(HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionid) {
        String result = "";
        try {
            int facilityUnitId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            List<Map<String, Object>> stockList = new ArrayList<>();
            boolean initialRequest = (request.getParameter("initialrequest") != null) ? Boolean.valueOf(request.getParameter("initialrequest")) : true;

            BigInteger originUnitId = (request.getParameter("originunitid") != null) ? BigInteger.valueOf(Long.parseLong(request.getParameter("originunitid"))) : BigInteger.ZERO;
            String referenceNumber = (request.getParameter("referencenumber") != null) ? request.getParameter("referencenumber") : "";

            Long currStaffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
            String[] params = {"prescriptionid", "isapproved", "isissued"};
            Object[] paramsValues = {Long.parseLong(prescriptionid), Boolean.TRUE, Boolean.FALSE};
            String[] fields = {"newprescriptionitemsid", "itemname", "dose"};
            String where = "WHERE prescriptionid=:prescriptionid AND isapproved=:isapproved AND isissued=:isissued";
            List<Object[]> approvedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (approvedPrescriptionItems != null) {
                for (Object[] approvedPrescriptionItem : approvedPrescriptionItems) {
                    params = new String[]{"newprescriptionitemsid"};
                    paramsValues = new Object[]{approvedPrescriptionItem[0]};
                    where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                    fields = new String[]{"prescriptionissueid", "quantityapproved", "itempackageid", "usepackage"};
                    List<Object[]> prescriptionIssues = (List<Object[]>) genericClassService.fetchRecord(Prescriptionissue.class, fields, where, params, paramsValues);
                    if (prescriptionIssues != null) {
                        Object[] issueDetails = prescriptionIssues.get(0);
                        params = new String[]{"itempackageid"};
                        paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(issueDetails[2].toString()))};
                        where = "WHERE itempackageid=:itempackageid";
                        fields = new String[]{"itempackageid", "genericname", "fullname"};
                        List<Object[]> itemPackages = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                        if (itemPackages != null) {
                            Object[] itemDetails = itemPackages.get(0);
                            List<Map> itemLocation = getDispensingItemslocations(Long.parseLong(itemDetails[0].toString()), Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString()));
                            List<Map> itemPickList = generateDispensingPickList(itemLocation, (Integer) issueDetails[1]);
                            Collections.sort(itemPickList, sortCells2);
                            if (itemPickList.size() > 0) {
                                for (Map itemsstockdetails : itemPickList) {
                                    Long cellid = Long.parseLong(itemsstockdetails.get("cellid").toString());
                                    Long stockid = Long.parseLong(itemsstockdetails.get("stockid").toString());
                                    Long prescriptionItemsId = Long.parseLong(approvedPrescriptionItem[0].toString());
                                    int qtyapproved = Integer.parseInt(issueDetails[1].toString());
                                    Long shelvedStock = 0L;
                                    int issuedQty = 0;
                                    //
                                    boolean usePackage = Boolean.valueOf(issueDetails[3].toString());
                                    long readyPacketsId = 0L, packageId = 0L;
                                    //
                                    if (usePackage) {
                                        fields = new String[]{"readypacketsid", "packageid", "quantity"};
                                        params = new String[]{"facilityunitid", "stockid", "quantity"};
                                        paramsValues = new Object[]{Long.parseLong(String.valueOf(facilityUnitId)), stockid, qtyapproved};
                                        where = "WHERE facilityunitid=:facilityunitid AND stockid=:stockid AND quantity=:quantity AND status='AVAILABLE'";
                                        List<Object[]> readyPackets = (List<Object[]>) genericClassService.fetchRecord(Readypackets.class, fields, where, params, paramsValues);
                                        if (readyPackets != null) {
                                            Object[] readyPacket = readyPackets.get(0);
                                            if (readyPacket != null) {
                                                readyPacketsId = Long.parseLong(readyPacket[0].toString());
                                                packageId = Long.parseLong(readyPacket[1].toString());
                                                shelvedStock = Long.parseLong(readyPacket[2].toString());
                                            }
                                        } else {
                                            Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(BigInteger.valueOf(Long.parseLong(issueDetails[2].toString())), facilityUnitId);
                                            shelvedStock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                                        }
                                    } else {
                                        Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(BigInteger.valueOf(Long.parseLong(issueDetails[2].toString())), facilityUnitId);
                                        shelvedStock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                                    }
                                    if (shelvedStock >= qtyapproved) {
                                        issuedQty = qtyapproved;
                                    } else if ((shelvedStock <= qtyapproved)) {
                                        issuedQty = Integer.parseInt(shelvedStock.toString());
                                    }
                                    if ((shelvedStock <= 0) && (initialRequest == true)) {
                                        Map<String, Object> data = new HashMap<>();
                                        data.put("result", String.format("%s is out of stock. Do you want to dispense any way?", itemDetails[2].toString()));
                                        result = new ObjectMapper().writeValueAsString(data);
                                        return result;
                                    } else if ((shelvedStock <= qtyapproved) && (initialRequest == false)) {
                                        String[] columns = new String[]{"status", "lastupdatedby", "lastupdated"};
                                        Object[] columnValues = new Object[]{"SERVICED", currStaffId, new Date()};
                                        String pk = "prescriptionid";
                                        Object pkValue = Long.parseLong(prescriptionid);
                                        genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
                                        columns = new String[]{"isserviced"};
                                        columnValues = new Object[]{Boolean.TRUE};
                                        pk = "newprescriptionitemsid";
                                        pkValue = prescriptionItemsId;
                                        genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");
                                    } else {
                                        if (usePackage) {
                                            String[] columns = {"status", "updatedby", "dispensingstatus"};
                                            Object[] columnValues = {"DISPENSED", BigInteger.valueOf(currStaffId), Boolean.FALSE};
                                            String pkcell = "readypacketsid";
                                            Object pkValuecell = readyPacketsId;
                                            genericClassService.updateRecordSQLSchemaStyle(Readypackets.class, columns, columnValues, pkcell, pkValuecell, "store");
                                        } else {
                                            //                                  Fetch Previous cell qty value.
                                            params = new String[]{"stockid", "cellid"};
                                            paramsValues = new Object[]{BigInteger.valueOf(stockid), cellid};
                                            where = "WHERE stockid=:stockid AND cellid=:cellid";
                                            fields = new String[]{"shelfstockid", "quantityshelved", "packsize"};
                                            List<Object[]> cellItems = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
                                            if (cellItems != null) {
                                                Object[] cellItem = cellItems.get(0);
                                                //                                     UPDATE CELL VALUES
                                                String[] columns = {"quantityshelved", "updatedby", "dateupdated"};
                                                Object[] columnValues = {(Integer.parseInt(cellItem[1].toString()) - issuedQty), currStaffId.intValue(), new Date()};
                                                String pkcell = "shelfstockid";
                                                Object pkValuecell = cellItem[0];
                                                genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columns, columnValues, pkcell, pkValuecell, "store");
                                                new ShelfActivityLog(genericClassService, cellid.intValue(), stockid.intValue(), currStaffId.intValue(), "OUT", issuedQty).start();
                                            }
                                        }
                                        //                              Update stock card
                                        params = new String[]{"stockid"};
                                        paramsValues = new Object[]{BigInteger.valueOf(stockid)};
                                        where = "WHERE stockid=:stockid";
                                        fields = new String[]{"stockissued", "packsize"};
                                        List<Object[]> issued = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields, where, params, paramsValues);
                                        if (issued != null) {
                                            Integer totalIssued = (Integer.parseInt(issued.get(0)[0].toString()) + issuedQty);

                                            //                                    UPDATE stock card
                                            String[] columns = {"stockissued"};
                                            Object[] columnValues = {totalIssued};
                                            String pk = "stockid";
                                            Object pkValue = stockid;
                                            genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
                                            new StockActivityLog(genericClassService, stockid.intValue(), currStaffId.intValue(), "DISP", issuedQty, "RX", originUnitId, referenceNumber).start();
                                        }
                                        Dispenseditems dispenseditems = new Dispenseditems();
                                        dispenseditems.setPrescriptionissueid(Long.parseLong(issueDetails[0].toString()));
                                        dispenseditems.setQuantitydispensed(issuedQty);
                                        dispenseditems.setStockid(stockid);
                                        genericClassService.saveOrUpdateRecordLoadObject(dispenseditems);

                                        String[] columns = {"issuedby", "dateissued"};
                                        Object[] columnValues = {BigInteger.valueOf(currStaffId), new Date()};
                                        String pk = "prescriptionissueid";
                                        Object pkValue = Long.parseLong(issueDetails[0].toString());
                                        genericClassService.updateRecordSQLSchemaStyle(Prescriptionissue.class, columns, columnValues, pk, pkValue, "store");

                                        columns = new String[]{"status", "lastupdatedby", "lastupdated"};
                                        columnValues = new Object[]{"ISSUED", currStaffId, new Date()};
                                        pk = "prescriptionid";
                                        pkValue = Long.parseLong(prescriptionid);
                                        genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");

                                        columns = new String[]{"isissued"};
                                        columnValues = new Object[]{Boolean.TRUE};
                                        pk = "newprescriptionitemsid";
                                        pkValue = prescriptionItemsId;
                                        genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");
                                    }
                                }
                            } else {
                                if ((initialRequest == true)) {
                                    Map<String, Object> data = new HashMap<>();
                                    data.put("result", String.format("%s is out of stock. Do you want to dispense any way?", itemDetails[2].toString()));
                                    result = new ObjectMapper().writeValueAsString(data);
                                    return result;
                                } else if ((initialRequest == false)) {
                                    String[] columns = new String[]{"status", "lastupdatedby", "lastupdated"};
                                    Object[] columnValues = new Object[]{"SERVICED", currStaffId, new Date()};
                                    String pk = "prescriptionid";
                                    Object pkValue = Long.parseLong(prescriptionid);
                                    genericClassService.updateRecordSQLSchemaStyle(Prescription.class, columns, columnValues, pk, pkValue, "patient");
                                    columns = new String[]{"isserviced"};
                                    columnValues = new Object[]{Boolean.TRUE};
                                    pk = "newprescriptionitemsid";
                                    pkValue = Long.parseLong(approvedPrescriptionItem[0].toString());
                                    genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");
                                }
                            }
                        }
                    }
                }
            }
//          Total count
//          fields = new String[]{"COUNT(newprescriptionitemsid)"};
            params = new String[]{"prescriptionid"};
            paramsValues = new Object[]{Long.parseLong(prescriptionid)};
            where = "WHERE prescriptionid=:prescriptionid";
            int totalCount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where, params, paramsValues);
            totalCount = (totalCount == 0) ? 1 : totalCount;
//          Count of issued items
            params = new String[]{"prescriptionid", "isissued"};
            paramsValues = new Object[]{Long.parseLong(prescriptionid), Boolean.TRUE};
            where = "WHERE prescriptionid=:prescriptionid AND isissued=:isissued";
            int issuedCount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where, params, paramsValues);
//          Count of items not issued
            paramsValues = new Object[]{Long.parseLong(prescriptionid), Boolean.FALSE};
            where = "WHERE prescriptionid=:prescriptionid AND (isissued IS NULL OR isissued=:isissued)";
            int notIssuedCount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where, params, paramsValues);
            //
            double issuedPercetnage = Double.parseDouble(String.valueOf((Double.parseDouble(String.valueOf(issuedCount)) / Double.parseDouble(String.valueOf(totalCount))) * 100));
            double notIssuedPercentage = ((Double.parseDouble(String.valueOf(notIssuedCount)) / Double.parseDouble(String.valueOf(totalCount)) * 100));
            Servicedprescriptions servicedPrescription = new Servicedprescriptions();

            String[] columns = {"issueditems", "notissueditems"};
            Object[] columnValues = {BigDecimal.valueOf(issuedPercetnage), BigDecimal.valueOf(notIssuedPercentage)};
            String pk = "prescriptionid";
            Object pkValue = Long.parseLong(prescriptionid);
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Servicedprescriptions.class, columns, columnValues, pk, pkValue, "patient");
            if (rowsAffected <= 0) {
                servicedPrescription.setPrescriptionid(Long.parseLong(prescriptionid));
                servicedPrescription.setAddedby(currStaffId);
                servicedPrescription.setDateadded(new Date());
                servicedPrescription.setIssueditems(BigDecimal.valueOf(issuedPercetnage));
                servicedPrescription.setNotissueditems(BigDecimal.valueOf(notIssuedPercentage));
                Object saved = genericClassService.saveOrUpdateRecordLoadObject(servicedPrescription);
                if (saved != null) {
                    result = "success";
                } else {
                    result = "failure";
                }
            } else {
                result = "success";
            }
            //           
            fields = new String[]{"itemname", "newprescriptionitemsid", "prescriptionid", "dose"};
            params = new String[]{"prescriptionid", "isissued"};
            paramsValues = new Object[]{Long.parseLong(prescriptionid), Boolean.FALSE};
            where = "WHERE prescriptionid=:prescriptionid AND (isissued IS NULL OR isissued=:isissued)";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptionItems != null) {
                for (Object[] item : prescriptionItems) {
                    String reason = "";
                    Unservicedprescriptionitemsreasons unservicedprescriptionitemsreasons = new Unservicedprescriptionitemsreasons();
                    BigInteger itemId = BigInteger.valueOf(0);
                    List<Object> itemPackageIds = (List<Object>) genericClassService.fetchRecord(Itempackage.class,
                            new String[]{"itempackageid"}, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemstrength",
                            new String[]{"genericname", "itemstrength"}, new Object[]{item[0].toString(), item[3].toString().toLowerCase().replaceAll("\\s+", "")});
                    if (itemPackageIds != null) {
                        itemId = BigInteger.valueOf(Long.parseLong(itemPackageIds.get(0).toString()));
                    }
                    Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
                    long shelvedStock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                    Long unshelvedStock = Long.parseLong(shelvedAndUnShelvedStock.get("unshelvedstock").toString());
                    if ((shelvedStock <= 0 && unshelvedStock <= 0)) {
                        reason = "Out Of Stock";
                    } else if ((shelvedStock <= 0 && unshelvedStock > 0)) {
                        reason = "Item Not Shelved";
                    } else {
                        reason = "Insufficient Stock";
                    }
                    columns = new String[]{"reason"};
                    columnValues = new Object[]{reason};
                    pk = "newprescriptionitemsid";
                    pkValue = Long.parseLong(item[1].toString());
                    rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Unservicedprescriptionitemsreasons.class, columns, columnValues, pk, pkValue, "patient");
                    if (rowsAffected <= 0) {
                        unservicedprescriptionitemsreasons.setPrescriptionid(Long.parseLong(prescriptionid));
                        unservicedprescriptionitemsreasons.setAddedby(currStaffId);
                        unservicedprescriptionitemsreasons.setDateadded(new Date());
                        unservicedprescriptionitemsreasons.setUpdatedby(currStaffId);
                        unservicedprescriptionitemsreasons.setDateupdated(new Date());
                        unservicedprescriptionitemsreasons.setNewprescriptionitemsid(Long.parseLong(item[1].toString()));
                        unservicedprescriptionitemsreasons.setReason(reason);
                        unservicedprescriptionitemsreasons.setReason(reason);
                        Object saved = genericClassService.saveOrUpdateRecordLoadObject(unservicedprescriptionitemsreasons);
                        if (saved != null) {
                            result = "success";
                        } else {
                            result = "failure";
                        }
                    } else {
                        result = "success";
                    }
                }
            }
            Map<String, Object> data = new HashMap<>();
            data.put("result", result);
            result = new ObjectMapper().writeValueAsString(data);
        } catch (JsonProcessingException | NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return result;
    }

    @RequestMapping(value = "/servicedprescriptions", method = RequestMethod.GET)
    public ModelAndView servicedPrescriptions(HttpServletRequest request, @ModelAttribute("dateissued") String dateIssued) {
        Map<String, Object> model = new HashMap<>();
        List<Map<String, Object>> items = new ArrayList<>();
        Set<Long> prescriptionIds = new HashSet<>();
        try {
            Long currentFacilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
//            String[] fields = {"prescriptionid", "patientvisitid"};
//            String[] params = {"timein", "facilityunitid", "isserviced", "isunresolved"};
//            Object[] paramsValues = {formatter.parse(dateissued), BigInteger.valueOf(currentFacilityUnitId), Boolean.TRUE, Boolean.FALSE};
//            String where = "WHERE DATE(timein)=:timein  AND facilityunitid=:facilityunitid AND isserviced=:isserviced AND isunresolved=:isunresolved";
//            List<Object[]> prescriptionIssues = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
            String [] fields = { "prescriptionid", "patientvisitid" };
            String [] params = { "dateadded", "destinationunitid"  };
            Object [] paramsValues = { formatter.parse(dateIssued), BigInteger.valueOf(currentFacilityUnitId) };
            String where = "WHERE DATE(dateadded)=:dateadded AND destinationunitid=:destinationunitid";
            List<Object[]> prescriptionIssues = (List<Object[]>) genericClassService.fetchRecord(Servicedprescriptionstats.class, fields, where, params, paramsValues);
            if (prescriptionIssues != null) {
                Map<String, Object> item;
                for (Object[] prescriptionIssue : prescriptionIssues) {
                    item = new HashMap<>();
                    Long prescriptionId = Long.parseLong(prescriptionIssue[0].toString());
                    item.put("prescriptionid", prescriptionId);
                    item.put("patientvisitid", Long.parseLong(prescriptionIssue[1].toString()));
                    params = new String[]{"patientvisitid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionIssue[1].toString())};
                    where = "WHERE patientvisitid=:patientvisitid";
                    fields = new String[]{"fullname", "visitnumber", "patientno"};
                    List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
                    if (persons != null) {
                        Object[] personDetails = persons.get(0);
                        item.put("patientname", personDetails[0].toString());
                    }
                    fields = new String[]{"servicedprescriptionid", "prescriptionid", "issueditems", "notissueditems", "addedby", "dateadded"};
                    params = new String[]{"prescriptionid"};
                    paramsValues = new Object[]{prescriptionId};
                    where = "WHERE prescriptionid=:prescriptionid";
                    List<Object[]> servicedPrescriptions = (List<Object[]>) genericClassService.fetchRecord(Servicedprescriptions.class, fields, where, params, paramsValues);
                    if (servicedPrescriptions != null) {
                        for (Object[] servicedPrescription : servicedPrescriptions) {

                            item.put("serviceditems", servicedPrescription[2].toString() + "%");
                            item.put("notissueditems", servicedPrescription[3].toString() + "%");
                            item.put("serviceditemsnumeric", servicedPrescription[2]);
                            item.put("notissueditemsnumeric", servicedPrescription[3]);
                            if (Double.parseDouble(servicedPrescription[2].toString()) == 0.00) {
                                item.put("dateserviced", "NOT ISSUED");
                            } else {
                                item.put("dateserviced", formatterWithTime2.format((Date) servicedPrescription[5]));
                            }
                            List<Object[]> addedby = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, new String[]{"staffid", "firstname", "lastname", "othernames"}, "WHERE staffid=:staffid", new String[]{"staffid"}, new Object[]{BigInteger.valueOf(Long.parseLong(servicedPrescription[4].toString()))}));
                            if (addedby != null) {
                                if (addedby.get(0)[3] != null) {
                                    item.put("servicedby", addedby.get(0)[1].toString() + " " + addedby.get(0)[2].toString() + " " + addedby.get(0)[3].toString());
                                } else {
                                    item.put("servicedby", addedby.get(0)[1].toString() + " " + addedby.get(0)[2].toString());
                                }
                            } else {
                                item.put("servicedby", "");
                            }
                        }
                    }

                    fields = new String[]{"addedby"};
                    params = new String[]{"prescriptionid"};
                    paramsValues = new Object[]{prescriptionId};
                    where = "WHERE prescriptionid=:prescriptionid";
                    List<Object> prescribers = (List<Object>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
                    if (prescribers != null && prescribers.get(0) != null) {
                        BigInteger prescriberId = BigInteger.valueOf(Long.parseLong(prescribers.get(0).toString()));
                        item.put("prescriberid", prescriberId);
                    } else {
                        item.put("prescriberid", 0);
                    }

                    //
                    fields = new String[]{"timein"};
                    params = new String[]{"patientvisitid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionIssue[1].toString())};
                    where = "WHERE patientvisitid=:patientvisitid";
                    List<Object> prescriptionsTime = (List<Object>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
                    if (prescriptionsTime != null) {
                        item.put("datereceived", formatterWithTime2.format((Date) prescriptionsTime.get(0)));
                    }
                    //
                    items.add(item);
                }
            }
            model.put("items", items);
            model.put("dateissued", dateIssued);
            model.put("serverdate", formatterwithtime3.format(serverDate));
        } catch (NumberFormatException | ParseException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/views/servicedPrescriptions", model);
    }

    @RequestMapping(value = "/servicedprescriptionitems", method = RequestMethod.GET)
    public @ResponseBody
    ModelAndView servicedprescriptionittems(HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionId) {
        Map<String, Object> model = new HashMap<>();
        try {
            List<Map<String, Object>> servicedItems = new ArrayList<>();
            String[] fields = {"itempackageid", "status", "quantitydispensed", "dateissued", "newprescriptionitemsid"};
            String[] params = {"prescriptionid"};
            Object[] paramsValues = {Long.parseLong(prescriptionId)};
            String where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptionissues = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionissueview.class, fields, where, params, paramsValues);
            if (prescriptionissues != null) {
                Map<String, Object> servicedItem;
                for (Object[] prescriptionissue : prescriptionissues) {
                    servicedItem = new HashMap<>();
                    StringBuilder batchnumbers = new StringBuilder();
                    fields = new String[]{"fullname"};
                    params = new String[]{"itempackageid"};
                    paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(prescriptionissue[0].toString()))};
                    where = "WHERE itempackageid=:itempackageid";
                    List<Object> itemNames = (List<Object>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                    if (itemNames != null) {
                        servicedItem.put("item", itemNames.get(0));
                    } else {
                        servicedItem.put("item", "");
                    }
                    //
                    List<Object> itemLocations = getItemBatchNumbers(Long.parseLong(prescriptionissue[4].toString()));
                    if (itemLocations.size() > 1) {
                        batchnumbers.append("&lt;");
                    }
                    for (Object itemLocation : itemLocations) {
                        String batchNumber = (itemLocation == null) ? "" : itemLocation.toString();
                        batchnumbers.append(batchNumber);
                        if (itemLocations.size() > 1) {
                            batchnumbers.append("&gt; &lt;");
                        }
                    }
                    if (itemLocations.size() > 1) {
                        batchnumbers.replace(batchnumbers.lastIndexOf("&"), batchnumbers.length(), "");
                    }
                    //
                    servicedItem.put("status", prescriptionissue[1]);
                    servicedItem.put("quantitydispensed", prescriptionissue[2]);
                    servicedItem.put("dateissued", formatter2.format(prescriptionissue[3]));
                    servicedItem.put("batchnumbers", batchnumbers.toString());
                    servicedItems.add(servicedItem);
                }
            }
            model.put("serviceditems", servicedItems);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/views/servicedItems", model);
    }

    @RequestMapping(value = "/unservicedprescriptionitems", method = RequestMethod.GET)
    public @ResponseBody
    ModelAndView unservicedprescriptionittems(HttpServletRequest request, @ModelAttribute("prescriptionid") String prescriptionId) {
        Map<String, Object> model = new HashMap<>();
        try {
            List<Map<String, Object>> unServicedItems = new ArrayList<>();
            String[] fields = {"newprescriptionitemsid", "itemname", "dose"};
            String[] params = {"prescriptionid", "isissued"};
            Object[] paramsValues = {Long.parseLong(prescriptionId), Boolean.FALSE};
            String where = "WHERE prescriptionid=:prescriptionid AND (isissued IS NULL OR isissued=:isissued)";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptionItems != null) {
                Map<String, Object> unServicedItem;
                for (Object[] prescriptionItem : prescriptionItems) {
                    unServicedItem = new HashMap<>();
                    unServicedItem.put("item", prescriptionItem[1].toString() + " " + prescriptionItem[2].toString());
                    fields = new String[]{"reason", "addedby", "dateadded"};
                    params = new String[]{"prescriptionid", "newprescriptionitemsid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionId), Long.parseLong(prescriptionItem[0].toString())};
                    where = "WHERE prescriptionid=:prescriptionid AND newprescriptionitemsid=:newprescriptionitemsid";
                    List<Object[]> unservicedprescriptionitemsreasons = (List<Object[]>) genericClassService.fetchRecord(Unservicedprescriptionitemsreasons.class, fields, where, params, paramsValues);
                    if (unservicedprescriptionitemsreasons != null) {
                        Object[] unservicedprescriptionitemsreason = unservicedprescriptionitemsreasons.get(0);
                        unServicedItem.put("reason", unservicedprescriptionitemsreason[0]);
                        List<Object[]> addedby = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, new String[]{"staffid", "firstname", "lastname", "othernames"}, "WHERE staffid=:staffid", new String[]{"staffid"}, new Object[]{unservicedprescriptionitemsreason[1]}));
                        if (addedby != null) {
                            if (addedby.get(0)[3] != null) {
                                unServicedItem.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2] + " " + (String) addedby.get(0)[3]);
                            } else {
                                unServicedItem.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2]);
                            }
                        }
                        unServicedItem.put("reasondateadded", formatter2.format(unservicedprescriptionitemsreason[2]));
                    }
                    unServicedItems.add(unServicedItem);
                }
            }
            model.put("unserviceditems", unServicedItems);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/views/unServicedItems", model);
    }

    @RequestMapping(value = "/unservicedprescriptions", method = RequestMethod.GET)
    public ModelAndView unservicedPrescriptions(HttpServletRequest request) {
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> unservicedPrescriptions = new ArrayList<>();
        final long facilityUnitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        try {
            String selectedDate = (request.getParameter("selecteddate") != null) ? request.getParameter("selecteddate") : formatter.format(new Date());
            String[] fields = { "prescriptionid", "patientvisitid", "originunitid", "timein", "addedby", "referencenumber", "timein" };
            String[] params = { "timein", "facilityunitid" };
            Object[] paramsValues = { formatter.parse(selectedDate), BigInteger.valueOf(facilityUnitId) };
            String where = "WHERE destinationunitid=:facilityunitid AND DATE(timein)=:timein";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Unservicedprescriptionsview.class, fields, where, params, paramsValues);
            if (prescriptions != null) {
                prescriptions.forEach((prescription) -> {
                    Map<String, Object> unservicedPrescription = new HashMap<>();
                    Long prescriptionId = Long.parseLong(prescription[0].toString());
                    Long patientVisitId = Long.parseLong(prescription[1].toString());
                    long originUnitId = Long.parseLong(prescription[2].toString());                    
                    String timeIn = time.format((Date) prescription[3]);
                    long addedBy = Long.parseLong(prescription[4].toString());
                    String referenceNumber = prescription[5].toString();
                    String prescriber = "";
                    String originUnit = "";
                    String patientName = "";

                    String[] lambdaParams = new String[]{"patientvisitid"};
                    Object[] lambdaParamsValues = new Object[]{patientVisitId};
                    String lambdaWhere = "WHERE patientvisitid=:patientvisitid";
                    String[] lambdaFields = new String[]{"fullname", "visitnumber", "patientno"};
                    List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, lambdaFields, lambdaWhere, lambdaParams, lambdaParamsValues);
                    if (persons != null) {
                        Object[] personDetails = persons.get(0);
                        patientName = personDetails[0].toString();
                    }
                    lambdaFields = new String[]{"staffid", "firstname", "lastname", "othernames"};
                    lambdaParams = new String[]{"staffid"};
                    lambdaParamsValues = new Object[]{addedBy};
                    lambdaWhere = "WHERE staffid=:staffid";
                    List<Object[]> staff = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, lambdaFields, lambdaWhere, lambdaParams, lambdaParamsValues));
                    if (staff != null) {
                        if (staff.get(0)[3] != null) {
                            prescriber = String.format("%s %s %s", staff.get(0)[1].toString(), staff.get(0)[2].toString(), staff.get(0)[3].toString());
                        } else {
                            prescriber = String.format("%s %s", staff.get(0)[1].toString(), staff.get(0)[2].toString());
                        }
                    }
                    lambdaFields = new String [] { "facilityunitname" };
                    lambdaParams = new String [] { "facilityunitid" };
                    lambdaParamsValues = new Object [] { originUnitId };
                    lambdaWhere = "WHERE facilityunitid=:facilityunitid";
                    List<Object> prescribingUnits = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, lambdaFields, lambdaWhere, lambdaParams, lambdaParamsValues);
                    if(prescribingUnits != null){
                        originUnit = prescribingUnits.get(0).toString();
                    }
                    unservicedPrescription.put("prescriptionid", prescriptionId);
                    unservicedPrescription.put("patientvisitid", patientVisitId);
                    unservicedPrescription.put("patientname", patientName);
                    unservicedPrescription.put("referencenumber", referenceNumber);
                    unservicedPrescription.put("prescriber", prescriber);
                    unservicedPrescription.put("originunit", originUnit);
                    unservicedPrescription.put("timein", timeIn);
                    unservicedPrescriptions.add(unservicedPrescription);
                });
            }
            model.put("unservicedprescriptions", unservicedPrescriptions);
            model.put("selecteddate", selectedDate);
            model.put("serverdate", formatterwithtime3.format(serverDate));
        } catch (ParseException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("dispensing/views/unservicedprescriptions", model);
    }

    @RequestMapping(value = "/pushprescription", method = RequestMethod.POST)
    public @ResponseBody
    String pushPrescription(HttpServletRequest request) {
        String result = "";
        try {
            final long patientVisitId = Long.parseLong(request.getParameter("patientvisitid"));
            final long prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            final long staffId = Long.parseLong(request.getParameter("staffid"));
            final long facilityUnitId = Long.parseLong(request.getParameter("facilityunitid"));
            final String queueStage = request.getParameter("queuestage");
            final boolean isPopped = (request.getParameter("ispopped") != null) ? Boolean.valueOf(request.getParameter("ispopped")) : Boolean.FALSE;
            final BigInteger poppedBy = (request.getParameter("poppedby") != null) ? BigInteger.valueOf(Long.parseLong(request.getParameter("poppedby"))) : null;
            String[] fields = {"prescriptionid"};
            String[] params = {"prescriptionid", "patientvisitid"};
            Object[] paramsValues = {prescriptionId, patientVisitId};
            String where = "WHERE prescriptionid=:prescriptionid AND patientvisitid=:patientvisitid";
            List<Object> queued = (List<Object>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
            if (queued == null || queued.get(0) == null) {
                Prescriptionqueue prescriptionQueue = new Prescriptionqueue();
                prescriptionQueue.setPrescriptionid(prescriptionId);
                prescriptionQueue.setPatientvisitid(patientVisitId);
                prescriptionQueue.setAddedby(staffId);
                prescriptionQueue.setFacilityunitid(facilityUnitId);
                prescriptionQueue.setQueuestage(queueStage);
                prescriptionQueue.setTimein(new Date());
                prescriptionQueue.setIspopped(isPopped);
                if (poppedBy != null) {
                    prescriptionQueue.setPoppedby(poppedBy);
                }
                Object saved = genericClassService.saveOrUpdateRecordLoadObject(prescriptionQueue);
                if (saved != null) {
                    result = "success";
                } else {
                    result = "failure";
                }
            } else {
                String[] columns = {"ispopped", "queuestage"};
                Object[] columnValues = {isPopped, queueStage};
                String pk = "prescriptionid";
                Object pkValue = prescriptionId;
                int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
                if (rowsAffected > 0) {
                    result = "success";
                } else {
                    result = "failure";
                }
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
//    @RequestMapping(value="/popprescription", method=RequestMethod.GET)
//    public @ResponseBody String popPrescription(HttpServletRequest request){        
//        Long prescriptionId = 0L;
//        try {
//            final long facilityUnitId = Long.parseLong(request.getParameter("facilityunitid"));
//            final String queueStage = request.getParameter("queuestage");
//            String[] params = {"facilityunitid", "queuestage"};
//            Object[] paramsValues = {facilityUnitId, queueStage };
//            String[] fields = {"prescriptionid", "timein"};
//            String where = "WHERE facilityunitid=:facilityunitid AND timeout IS NULL AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage ORDER BY timein LIMIT 1";
//            List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
//            if (queue != null) {
//                prescriptionId = Long.parseLong(queue.get(0)[0].toString());
//                String[] columns = {"timeout"};
//                Object[] columnValues = {new Date()};
//                String pk = "prescriptionid";
//                Object pkValue = Long.parseLong(queue.get(0)[0].toString());
//                int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
//            }
//        } catch (NumberFormatException ex) {
//            System.out.println(ex);
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return prescriptionId.toString();
//    }
//    @RequestMapping(value="/popprescription", method=RequestMethod.GET)
//    public @ResponseBody String popPrescription(HttpServletRequest request){        
//        Long prescriptionId = 0L;
//        try {
//            
//            synchronized(prescriptionId){
//                final long facilityUnitId = Long.parseLong(request.getParameter("facilityunitid"));
//                final String queueStage = request.getParameter("queuestage");
//                String[] params = {"facilityunitid", "queuestage"};
//                Object[] paramsValues = {facilityUnitId, queueStage };
//                String[] fields = {"prescriptionid", "timein"};
//                String where = "WHERE facilityunitid=:facilityunitid AND timeout IS NULL AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage ORDER BY timein LIMIT 1";
//                List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
//                if (queue != null) {
//                    prescriptionId = Long.parseLong(queue.get(0)[0].toString());
//                    String[] columns = {"ispopped"};
//                    Object[] columnValues = { Boolean.TRUE };
//                    String pk = "prescriptionid";
//                    Object pkValue = Long.parseLong(queue.get(0)[0].toString());
//                    int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
//                }
//            }
//        } catch (NumberFormatException ex) {
//            System.out.println(ex);
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return prescriptionId.toString();
//    }

    @RequestMapping(value = "/popprescription", method = RequestMethod.GET)
    public @ResponseBody
    String popPrescription(HttpServletRequest request) {
        Long prescriptionId = 0L;
        try {
            synchronized (prescriptionId) {
                final long facilityUnitId = Long.parseLong(request.getParameter("facilityunitid"));
                final long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
                final String queueStage = request.getParameter("queuestage");
                String[] params = {"facilityunitid", "queuestage", "ispopped", "isserviced", "poppedby"};
                Object[] paramsValues = {facilityUnitId, queueStage, Boolean.TRUE, Boolean.FALSE, BigInteger.valueOf(staffId)};
                String[] fields = {"prescriptionid", "timein"};
                String where = "WHERE facilityunitid=:facilityunitid AND timeout IS NULL AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage AND ispopped=:ispopped AND isserviced=:isserviced AND poppedby=:poppedby ORDER BY timein LIMIT 1";
                List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
                if (queue != null) {
                    prescriptionId = Long.parseLong(queue.get(0)[0].toString());
                } else {
                    if (!queueStage.equalsIgnoreCase("review")) {
                        params = new String[]{"facilityunitid", "queuestage", "ispopped", "isserviced"};
                        paramsValues = new Object[]{facilityUnitId, queueStage, Boolean.FALSE, Boolean.FALSE};
                        where = "WHERE facilityunitid=:facilityunitid AND timeout IS NULL AND DATE(timein)=DATE 'now' AND LOWER(queuestage)=:queuestage AND ispopped=:ispopped AND isserviced=:isserviced ORDER BY timein LIMIT 1";
                        queue = (List<Object[]>) genericClassService.fetchRecord(Prescriptionqueue.class, fields, where, params, paramsValues);
                        if (queue != null) {
                            prescriptionId = Long.parseLong(queue.get(0)[0].toString());
                            String[] columns = {"ispopped", "poppedby"};
                            Object[] columnValues = {Boolean.TRUE, staffId};
                            String pk = "prescriptionid";
                            Object pkValue = Long.parseLong(queue.get(0)[0].toString());
                            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
                        }
                    }
                }
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception e) {
            System.out.println(e);
        }
        return prescriptionId.toString();
    }

    @RequestMapping(value = "/closepoppedprescription", method = RequestMethod.POST)
    public @ResponseBody
    String closePoppedPrescription(HttpServletRequest request) {
        String result = "";
        try {
            final long prescriptionId = Long.valueOf(request.getParameter("prescriptionid"));
            final boolean isUnresolved = (request.getParameter("isunresolved") != null) ? Boolean.valueOf(request.getParameter("isunresolved")) : Boolean.FALSE;
            String[] columns = new String[]{"isserviced", "isunresolved"};
            Object[] columnValues = new Object[]{Boolean.TRUE, isUnresolved};
            String pk = "prescriptionid";
            Object pkValue = prescriptionId;
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
//            String[] columns = { "prescriptionid" };
//            Object[] columnValues = { prescriptionId };
//            int rowsAffected = genericClassService.deleteRecordBySchemaByColumns(Prescriptionqueue.class, columns, columnValues, "patient");
            if (rowsAffected > 0) {
                result = "success";
            } else {
                result = "failure";
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/unserviceprescription", method = RequestMethod.POST)
    public @ResponseBody
    String unServicePrescription(HttpServletRequest request) {
        String result = "";
        try {
            long prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            String[] columns = new String[]{"isserviced"};
            Object[] columnValues = new Object[]{Boolean.FALSE};
            String pk = "prescriptionid";
            Object pkValue = prescriptionId;
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/addbacktoqueue", method = RequestMethod.POST)
    public @ResponseBody
    String addBackToQueue(HttpServletRequest request) {
        String result = "";
        try {
            final long prescriptionId = Long.parseLong(request.getParameter("prescriptionid"));
            String[] columns = {"ispopped"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "prescriptionid";
            Object pkValue = prescriptionId;
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
            result = (rowsAffected > 0) ? "success" : "failure";
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return result;
    }

    @RequestMapping(value = "/prescriberdetails", method = RequestMethod.GET)
    public ModelAndView prescriberDetails(HttpServletRequest request,
            @ModelAttribute("originunitid") String originunitid,
            @ModelAttribute("prescriberid") String prescriberId) {
        Map<String, Object> model = new HashMap<>();
        try {
            String[] paramsPatientPrescriptionunit = {"facilityunitid"};
            Object[] paramsValuesPatientPrescriptionunit = {Long.parseLong(originunitid)};
            String[] fields5PatientPrescriptionunit = {"facilityunitname"};
            List<String> objPatientPrescriptionunit = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5PatientPrescriptionunit, "WHERE facilityunitid=:facilityunitid", paramsPatientPrescriptionunit, paramsValuesPatientPrescriptionunit);
            if (objPatientPrescriptionunit != null) {
                model.put("facilityunitname", objPatientPrescriptionunit.get(0));
            }

            String[] paramsPrescriber = {"staffid"};
            Object[] paramsValuesPrescriber = {BigInteger.valueOf(Long.parseLong(prescriberId))};
            String[] fields5Prescriber = {"firstname", "lastname", "othernames", "personid"};
            List<Object[]> objPrescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
            if (objPrescriber != null) {
                Object[] per = objPrescriber.get(0);
                if (per[2] != null) {
                    model.put("prescriber", per[0] + " " + per[1] + " " + per[2]);
                } else {
                    model.put("prescriber", per[0] + " " + per[1]);
                }
                List<Object[]> contacts = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, new String[]{"contactvalue", "contacttype"}, "WHERE personid=:personid", new String[]{"personid"}, new Object[]{per[3]});
                if (contacts != null) {
                    String tel = "";
                    for (Object[] contact : contacts) {
                        if (contact[0].toString().equalsIgnoreCase("EMAIL")) {
                            model.put("email", contact[1]);
                        } else if (contact[0].toString().equalsIgnoreCase("PRIMARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        } else if (contact[0].toString().equalsIgnoreCase("SECONDARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        }
                    }
                    model.put("contactno", tel);
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/views/prescriberDetails", model);
    }

    @RequestMapping(value = "/printprescription", method = RequestMethod.GET)
    public @ResponseBody
    String printPrescription(HttpServletRequest request,
            @ModelAttribute("prescriptionid") String prescriptionId,
            @ModelAttribute("patientvisitid") String patientVisitId,
            @ModelAttribute("prescriberid") String prescriberId,
            @ModelAttribute("printtype") String printType) {
        String result = "";
        try {
            long facilityUnitId = ((Facilityunit) request.getSession().getAttribute("sessionActiveLoginFacilityUnitObj")).getFacilityunitid();
            String facility = ((Facility) request.getSession().getAttribute("sessionActiveLoginFacilityObj")).getFacilityname();
            String facilityUnit = ((Facilityunit) request.getSession().getAttribute("sessionActiveLoginFacilityUnitObj")).getFacilityunitname();
            String url = IICS.BASE_URL + "dispensing/prescriptionprintout.htm?prescriptionid=" + prescriptionId + "&facility="
                    + facility + "&facilityunit=" + facilityUnit + "&facilityunitid=" + facilityUnitId + "&patientvisitid="
                    + patientVisitId + "&prescriberid=" + prescriberId + "&printtype=" + printType;
            String path = getUnitRegisterPath() + facilityUnitId + "_" + patientVisitId + ".pdf";
            Document document = new Document();
            ByteArrayOutputStream outPutStream = new ByteArrayOutputStream();
            PdfWriter pdfWriter = PdfWriter.getInstance(document, outPutStream);
            document.setPageSize(PageSize.A4);
            document.open();
            String imageUrl = IICS.BASE_URL + "static/images/COA.png";
            Image image = Image.getInstance(new URL(imageUrl));
            image.scaleAbsolute(100, 50);
            image.setAlignment(Image.ALIGN_CENTER);
            document.add(image);
            URL myWebPage = new URL(url.replaceAll(" ", "@--@"));
            InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
            XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
            worker.parseXHtml(pdfWriter, document, fis);
            document.close();
            pdfWriter.close();
            result = Base64.getEncoder().encodeToString(outPutStream.toByteArray());
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/prescriptionprintout.htm", method = RequestMethod.GET)
    public ModelAndView prescriptionPrintOut(HttpServletRequest request,
            @ModelAttribute("prescriptionid") String prescriptionId, @ModelAttribute("facility") String facility,
            @ModelAttribute("facilityunit") String facilityUnit,
            @ModelAttribute("facilityunitid") String facilityUnitId,
            @ModelAttribute("patientvisitid") String patientVisitId,
            @ModelAttribute("prescriberid") String prescriberId,
            @ModelAttribute("printtype") String printType) {
        Map<String, Object> model = new HashMap<>();
        try {
            String frequency = "";
            Float quantity = 1.0F;
            List<Map<String, Object>> prescriptionItemsList = new ArrayList<>();
            model.put("facility", facility.toUpperCase().replaceAll("@--@", " "));
            model.put("facilityunit", facilityUnit.toUpperCase().replaceAll("@--@", " "));
            String[] params = new String[]{"patientvisitid"};
            Object[] paramsValues = new Object[]{Long.parseLong(patientVisitId)};
            String where = "WHERE patientvisitid=:patientvisitid";
            String[] fields = new String[]{"fullname", "visitnumber", "patientno", "dob", "gender", "patientid"};
            List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (persons != null) {
                Object[] personDetails = persons.get(0);
                model.put("patientname", personDetails[0].toString());
                model.put("patientno", personDetails[2].toString());
            }

            fields = new String[]{"newprescriptionitemsid", "dosage",
                "dose", "days", "daysname", "itemname", "notes"};
            params = new String[]{"prescriptionid"};
            paramsValues = new Object[]{Long.parseLong(prescriptionId)};
            where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);

            if (prescriptionItems != null) {
                Map<String, Object> item = null;
                for (Object[] prescriptionItem : prescriptionItems) {
                    item = new HashMap<>();
                    item.put("specialinstructions", prescriptionItem[6].toString());
                    fields = new String[]{"newprescriptionitemsid", "dosage", "dose", "days", "daysname", "itemname"};
                    params = new String[]{"newprescriptionitemsid"};
                    paramsValues = new Object[]{Long.parseLong(prescriptionItem[0].toString())};
                    where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                    List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues);
                    if (modifiedPrescriptionItems != null) {
                        prescriptionItem = modifiedPrescriptionItems.get(0);
                    }
                    //
                    if (printType.equalsIgnoreCase("outofstock")) {
                        long qtyinstock = 0L;
                        boolean isOutOfStock = false;
                        BigInteger itemId = BigInteger.valueOf(0);
                        params = new String[]{"genericname", "itemstrength"};
                        paramsValues = new Object[]{prescriptionItem[5].toString(), prescriptionItem[2].toString().toLowerCase().replaceAll("\\s+", "")};
                        fields = new String[]{"itempackageid"};
                        List<Object> itemIds = (List<Object>) genericClassService.fetchRecord(Itempackage.class,
                                fields, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemstrength", params, paramsValues);
                        if (itemIds != null && itemIds.get(0) != null) {
                            itemId = BigInteger.valueOf(Long.parseLong(itemIds.get(0).toString()));
                            int strengthCount = genericClassService.fetchRecordCount(Itempackage.class, "WHERE genericname=:genericname AND LOWER(REPLACE(itemstrength, ' ', ''))=:itemStrength", new String[]{"genericname", "itemStrength"}, new Object[]{prescriptionItem[5], prescriptionItem[2].toString().toLowerCase().replaceAll("\\s+", "")});
                            if (strengthCount != 0) {
                                Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, Long.parseLong(facilityUnitId));
                                qtyinstock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                                if (qtyinstock <= 0) {
                                    item.put("isavailable", Boolean.FALSE);
                                    isOutOfStock = isOutOfStock(prescriptionItem[5].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                                    item.put("isoutofstock", isOutOfStock);
                                } else {
                                    item.put("isavailable", Boolean.TRUE);
                                }
                            } else {
                                item.put("isavailable", Boolean.FALSE);
                                isOutOfStock = isOutOfStock(prescriptionItem[5].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                                item.put("isoutofstock", isOutOfStock);
                            }
                        } else {
                            item.put("isavailable", Boolean.FALSE);
                            isOutOfStock = isOutOfStock(prescriptionItem[5].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                            item.put("isoutofstock", isOutOfStock);
                        }
                    }
                    item.put("medicine", prescriptionItem[5].toString());
                    fields = new String[]{"altdosageid", "dosage", "addedby", "dateadded", "updatedby", "dateupdated",
                        "newprescriptionitemsid", "itemid"};
                    List<Object[]> altDosages = (List<Object[]>) genericClassService.fetchRecord(Alternatedosages.class, fields, "WHERE newprescriptionitemsid=:newprescriptionitemsid", new String[]{"newprescriptionitemsid"}, new Object[]{Long.parseLong(prescriptionItem[0].toString())});
                    if (altDosages != null) {
                        for (Object[] altDose : altDosages) {
                            String itemStrength = (prescriptionItem[2] != null) ? prescriptionItem[2].toString() : null;
                            quantity = getQuantity(itemStrength, altDose[1].toString());
                        }
                    } else {
                        String itemStrength = (prescriptionItem[2] != null) ? prescriptionItem[2].toString() : "";
                        quantity = 1.0F;
                    }
                    if (prescriptionItem[1].toString().equalsIgnoreCase("Daily(OD)")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 1";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 1";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 1";
                        } else {
                            frequency = quantity + " x 1";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("BID/b.i.d")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 2";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 2";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 2";
                        } else {
                            frequency = quantity + " x 2";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("TID/t.i.d")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 3";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 3";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 3";
                        } else {
                            frequency = quantity + " x 3";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("QID/q.i.d")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 4";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 4";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 4";
                        } else {
                            frequency = quantity + " x 4";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("QHS(Bed time)")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 1";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 1";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 1";
                        } else {
                            frequency = quantity + " x 1";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("Q4h(Every 4 hours)")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 3";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 3";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 3";
                        } else {
                            frequency = quantity + " x 3";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("Q4h-6h(4-6 hours)")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 3";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 3";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 3";
                        } else {
                            frequency = quantity + " x 3";
                        }
                    } else if (prescriptionItem[1].toString().equalsIgnoreCase("QWK(Every Week)")) {
                        if (quantity.toString().contains(".0")) {
                            frequency = quantity.toString().substring(0, quantity.toString().indexOf('.')) + " x 1";
                        } else if (quantity == 0.5F) {
                            frequency = "1/2 x 1";
                        } else if (quantity == 0.25F) {
                            frequency = "1/4 x 1";
                        } else {
                            frequency = quantity + " x 1";
                        }
                    }
                    item.put("frequency", frequency);
                    String duration = (prescriptionItem[3] != null) ? prescriptionItem[3].toString() + " " : "";
                    duration += (prescriptionItem[4] != null) ? prescriptionItem[4].toString() + " " : "";
                    item.put("duration", duration);
                    item.put("dosage", prescriptionItem[2]);
                    //
                    int issued = 0;
                    int notIssued = 0;
                    int qtyToPick = (getQtyToPick(prescriptionItem[1].toString(), Integer.parseInt(prescriptionItem[3].toString()), quantity, prescriptionItem[4].toString()));
//                    fields = new String [] { "quantityapproved" };
//                    params = new String [] { "newprescriptionitemsid" };
//                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(prescriptionItem[0].toString())) };
//                    where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
//                    List<Object> quantitiesApproved = (List<Object>) genericClassService.fetchRecord(Prescriptionissue.class, fields, where, params, paramsValues);
                    fields = new String[]{"quantitydispensed"};
                    params = new String[]{"newprescriptionitemsid"};
                    paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(prescriptionItem[0].toString()))};
                    where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
                    List<Object> quantitiesIssued = (List<Object>) genericClassService.fetchRecord(Newprescriptionissueview.class, fields, where, params, paramsValues);
                    if (quantitiesIssued != null && quantitiesIssued.get(0) != null) {
                        issued = Integer.parseInt(quantitiesIssued.get(0).toString());
                        notIssued = qtyToPick - issued;
                    } else {
                        issued = 0;
                        notIssued = qtyToPick;
                    }
                    item.put("issued", issued);
                    item.put("notissued", notIssued);
                    //
                    prescriptionItemsList.add(item);
                }
                String[] paramsPrescriber = {"staffid"};
                Object[] paramsValuesPrescriber = {BigInteger.valueOf(Long.parseLong(prescriberId))};
                String[] fields5Prescriber = {"firstname", "lastname", "othernames", "personid"};
                List<Object[]> prescriber = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5Prescriber, "WHERE staffid=:staffid", paramsPrescriber, paramsValuesPrescriber);
                if (prescriber != null) {
                    Object[] per = prescriber.get(0);
                    if (per[2] != null) {
                        model.put("prescriber", per[0] + " " + per[1] + " " + per[2]);
                    } else {
                        model.put("prescriber", per[0] + " " + per[1]);
                    }
                    List<Object[]> contacts = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, new String[]{"contactvalue", "contacttype"}, "WHERE personid=:personid", new String[]{"personid"}, new Object[]{per[3]});
                    if (contacts != null) {
                        String tel = "";
                        for (Object[] contact : contacts) {
                            if (contact[0].toString().equalsIgnoreCase("EMAIL")) {
                                model.put("email", (contact[1] == null) ? "Not Available" : contact[1]);
                            } else if (contact[0].toString().equalsIgnoreCase("PRIMARYCONTACT")) {
                                tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                            } else if (contact[0].toString().equalsIgnoreCase("SECONDARYCONTACT")) {
                                tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                            }
                        }
                        model.put("contactno", (tel.length() <= 0) ? "Not Available" : tel);
                    } else {
                        model.put("email", "Not Available");
                        model.put("contactno", "Not Available");
                    }
                }
            }
            model.put("prescriptionitems", prescriptionItemsList);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("dispensing/views/prescriptionPrintOut", model);
    }

    @RequestMapping(value = "/servicedpatientdetails", method = RequestMethod.GET)
    public ModelAndView servicedPatientDetails(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<>();
        try {
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            final long patientVisitId = (request.getParameter("patientvisitid") != null) ? Long.parseLong(request.getParameter("patientvisitid")) : 0;
            final List<Map<String, Object>> prescriptionItems = new ArrayList<>();
            List<Object[]> modifiedPrescriptionItems = null;
            long patientid = 0L, prescriptionId = 0L;

            String[] fields = {"patientid"};
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {patientVisitId};
            String where = "WHERE patientvisitid=:patientvisitid";
            List<Object> patientVisits = (List<Object>) genericClassService.fetchRecord(Patientvisit.class, fields, where, params, paramsValues);
            patientid = (patientVisits != null && patientVisits.get(0) != null) ? Long.parseLong(patientVisits.get(0).toString()) : 0;
            fields = new String[]{"nextofkincontact", "nextofkinname", "relationship", "telephone"};
            params = new String[]{"patientid"};
            paramsValues = new Object[]{patientid};
            where = "WHERE r.patientid=:patientid";
            List<Object[]> patients = (List<Object[]>) genericClassService.fetchRecord(Patient.class, fields, where, params, paramsValues);
            if (patients != null && patients.get(0) != null && patients.get(0)[3] != null) {
                model.put("telephone", patients.get(0)[3]);
            } else if (patients != null && patients.get(0) != null && (patients.get(0)[3] == null || patients.get(0)[3].toString().isEmpty())) {
                for (Object[] patient : patients) {
                    model.put("nextofkincontact", patient[0]);
                    model.put("nextofkinname", patient[1]);
                    model.put("relationship", patient[2]);
                }
            }
            fields = new String[]{"prescriptionid", "dateprescribed", "addedby", "originunitid", "patientvisitid"};
            params = new String[]{"patientvisitid", "destinationunitid"};
            paramsValues = new Object[]{patientVisitId, facilityUnitId};
            where = "WHERE patientvisitid=:patientvisitid AND destinationunitid=:destinationunitid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
            prescriptionId = (prescriptions != null && prescriptions.get(0) != null && prescriptions.get(0)[0] != null) ? Long.parseLong(prescriptions.get(0)[0].toString()) : 0;

            params = new String[]{"prescriptionid"};
            paramsValues = new Object[]{prescriptionId};
            fields = new String[]{"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname", "itemname", "notes", "ismodified"};
            where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> originalPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);

            if (originalPrescriptionItems != null) {
                Map<String, Object> prescriptionItem;
                for (Object[] originalPrescriptionItem : originalPrescriptionItems) {
                    prescriptionItem = new HashMap<>();

                    prescriptionItem.put("newprescriptionitemsid", originalPrescriptionItem[0]);
                    prescriptionItem.put("prescriptionid", originalPrescriptionItem[1]);
//                    prescriptionItem.put("notes", originalPrescriptionItem[7]);

                    if (originalPrescriptionItem[8] == null
                            || !Boolean.valueOf(originalPrescriptionItem[8].toString())) {
                        modifiedPrescriptionItems = null;
                    } else {
                        fields = new String[]{"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname", "itemname", "reason"};
                        params = new String[]{"prescriptionid", "newprescriptionitemsid"};
                        paramsValues = new Object[]{prescriptionId, Long.parseLong(originalPrescriptionItem[0].toString())};
                        where = "WHERE prescriptionid=:prescriptionid AND newprescriptionitemsid=:newprescriptionitemsid";
                        modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues);
                    }
                    if (modifiedPrescriptionItems != null) {
                        for (Object[] modifiedPrescriptionItem : modifiedPrescriptionItems) {
                            prescriptionItem.put("dosage", modifiedPrescriptionItem[2]);
                            prescriptionItem.put("dose", modifiedPrescriptionItem[3]);
                            prescriptionItem.put("days", modifiedPrescriptionItem[4]);
                            prescriptionItem.put("daysname", modifiedPrescriptionItem[5]);
                            prescriptionItem.put("itemname", modifiedPrescriptionItem[6]);
                            prescriptionItem.put("ismodified", Boolean.TRUE);
                            prescriptionItem.put("notes", modifiedPrescriptionItem[7]);
                        }
                    } else {
                        prescriptionItem.put("dosage", originalPrescriptionItem[2]);
                        prescriptionItem.put("dose", originalPrescriptionItem[3]);
                        prescriptionItem.put("days", originalPrescriptionItem[4]);
                        prescriptionItem.put("daysname", originalPrescriptionItem[5]);
                        prescriptionItem.put("itemname", originalPrescriptionItem[6]);
                        prescriptionItem.put("ismodified", originalPrescriptionItem[8]);
                        prescriptionItem.put("notes", originalPrescriptionItem[7]);
                    }
                    prescriptionItems.add(prescriptionItem);
                }
            }
            model.put("prescriptionitems", prescriptionItems);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/views/servicedPatientDetails", model);
    }

    @RequestMapping(value = "/modifiedserviceditems", method = RequestMethod.GET)
    public ModelAndView modifiedServicedItems(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<>();
        Map<String, Object> prescriptionItem = new HashMap<>();
        try {
            long prescriptionItemsId = Long.parseLong(request.getParameter("prescriptionitemsid"));
            String[] params = new String[]{"prescriptionitemsid"};
            Object[] paramsValues = new Object[]{prescriptionItemsId};
            String[] fields = new String[]{"newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname", "itemname", "notes", "ismodified"};
            String where = "WHERE newprescriptionitemsid=:prescriptionitemsid";
            List<Object[]> originalPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
            if (originalPrescriptionItems != null) {
                Object[] originalPrescriptionItem = originalPrescriptionItems.get(0);
                prescriptionItem.put("newprescriptionitemsid", originalPrescriptionItem[0]);
                prescriptionItem.put("prescriptionid", originalPrescriptionItem[1]);
                prescriptionItem.put("dosage", originalPrescriptionItem[2]);
                prescriptionItem.put("dose", originalPrescriptionItem[3]);
                prescriptionItem.put("days", originalPrescriptionItem[4]);
                prescriptionItem.put("daysname", originalPrescriptionItem[5]);
                prescriptionItem.put("itemname", originalPrescriptionItem[6]);
                prescriptionItem.put("notes", originalPrescriptionItem[7]);
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        model.put("prescriptionitem", prescriptionItem);
        return new ModelAndView("dispensing/views/modifiedServicedItems", model);
    }

    @RequestMapping(value = "/unresolvedprescriptions", method = RequestMethod.GET)
    public ModelAndView unResolvedPrescriptions(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<>();
        List<Map<String, Object>> unResolvedPrescriptions = new ArrayList<>();
        long patientVisitId = 0L, prescriptionId = 0L;
        try {
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            String[] fields = {"prescriptionid", "patientvisitid", "addedby"};
            String[] params = {"dateadded", "facilityunitid"};
            Object[] paramsValues = {new Date(), facilityUnitId};
            String where = "WHERE dateadded=:dateadded  AND facilityunitid=:facilityunitid";
            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Unresolvedprescriptionitems.class, fields, where, params, paramsValues);
            if (prescriptions != null) {
                Map<String, Object> item;
                for (Object[] prescription : prescriptions) {
                    item = new HashMap<>();
                    prescriptionId = Long.parseLong(prescription[0].toString());
                    patientVisitId = Long.parseLong(prescription[1].toString());
                    List<Object[]> addedby = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, new String[]{"staffid", "firstname", "lastname", "othernames"}, "WHERE staffid=:staffid", new String[]{"staffid"}, new Object[]{BigInteger.valueOf(Long.parseLong(prescription[2].toString()))}));
                    if (addedby != null) {
                        if (addedby.get(0)[3] != null) {
                            item.put("addedby", addedby.get(0)[1].toString() + " " + addedby.get(0)[2].toString() + " " + addedby.get(0)[3].toString());
                        } else {
                            item.put("addedby", addedby.get(0)[1].toString() + " " + addedby.get(0)[2].toString());
                        }
                    } else {
                        item.put("addedby", "");
                    }
                    item.put("prescriptionid", prescriptionId);
                    item.put("patientvisitid", patientVisitId);
                    params = new String[]{"patientvisitid"};
                    paramsValues = new Object[]{patientVisitId};
                    where = "WHERE patientvisitid=:patientvisitid";
                    fields = new String[]{"fullname", "visitnumber", "patientno"};
                    List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
                    if (persons != null) {
                        Object[] personDetails = persons.get(0);
                        item.put("patientname", personDetails[0].toString());
                    }
                    unResolvedPrescriptions.add(item);
                }
            }
            model.put("unresolvedprescriptions", unResolvedPrescriptions);
            model.put("patientvisitid", patientVisitId);
            model.put("prescriptionid", prescriptionId);
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dispensing/views/unResolvedPrescriptions", model);
    }

    @RequestMapping(value = "/todayconsumption", method = RequestMethod.GET)
    public ModelAndView todayConsumption(HttpServletRequest request) {
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> todayConsumptions = new ArrayList<>();
        DecimalFormat removeTrailingZeros = new DecimalFormat("0.##");
        try {
            int totalIssued = 0;
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            final String consumptionDate = request.getParameter("consumptiondate");
            final List<Map<String, Object>> percentages = new ArrayList<>();
            String[] fields = {"destinationunitid", "status", "fullname", "dose", "itempackageid", "quantitydispensed"};
            String[] params = {"destinationunitid", "dateissued"};
            Object[] paramsValues = {BigInteger.valueOf(facilityUnitId), formatter.parse(consumptionDate)};
            String where = "WHERE destinationunitid=:destinationunitid AND DATE(dateissued)=:dateissued";
            List<Object[]> todayIssuedItems = (List<Object[]>) genericClassService.fetchRecord(Todaydispensingconsumption.class, fields, where, params, paramsValues);
            if (todayIssuedItems != null) {
                Map<String, Object> todayConsumption;
                for (Object[] todayIssuedItem : todayIssuedItems) {
                    todayConsumption = new HashMap<>();
                    todayConsumption.put("destinationunitid", todayIssuedItem[0]);
                    todayConsumption.put("status", todayIssuedItem[1]);
                    todayConsumption.put("itemname", todayIssuedItem[2]);
                    todayConsumption.put("dose", todayIssuedItem[3]);
                    todayConsumption.put("itempackageid", todayIssuedItem[4]);
                    todayConsumption.put("quantitydispensed", todayIssuedItem[5]);

                    Date today = new Date();
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY");
                    Date startDate = formatter.parse((simpleDateFormat.format(today) + "-01-01"));
                    Date endDate = today;
                    Map<String, Object> stockLevel = getItemStockLevel(Integer.valueOf(String.valueOf(facilityUnitId)), Integer.parseInt(todayIssuedItem[4].toString()), startDate, endDate);
                    String itemStockBalance = String.format("%,d", Long.parseLong(stockLevel.get("available").toString()));
                    todayConsumption.put("stockbalance", itemStockBalance);
                    todayConsumptions.add(todayConsumption);
                }
            }
            //            
            params = new String[]{"destinationunitid", "dateprescribed"};
            paramsValues = new Object[]{BigInteger.valueOf(facilityUnitId), formatter.parse(consumptionDate)};
            where = "WHERE destinationunitid=:destinationunitid AND DATE(dateprescribed)=:dateprescribed";
            int totalPrescribed = genericClassService.fetchRecordCount(Prescription.class, where, params, paramsValues);
            if (totalPrescribed > 0) {
                fields = new String[]{"COUNT(DISTINCT r.prescriptionid)"};
                params = new String[]{"destinationunitid", "dateprescribed"};
                paramsValues = new Object[]{BigInteger.valueOf(facilityUnitId), formatter.parse(consumptionDate)};
                where = "WHERE destinationunitid=:destinationunitid AND DATE(dateprescribed)=:dateprescribed";
                List<Object[]> issued = (List<Object[]>) genericClassService.fetchRecordFunction(Servicedprescriptionstats.class, fields, where, params, paramsValues, 0, 0);
                if (issued != null) {
                    totalIssued = (issued.get(0) == null) ? 0 : Integer.parseInt(String.valueOf(issued.get(0)));
                }
                fields = new String[]{"COUNT(DISTINCT r.prescriptionid)", "r.dateprescribed", "r.destinationunitid", "r.issueditems", "r.notissueditems"};
                params = new String[]{"destinationunitid", "dateprescribed"};
                paramsValues = new Object[]{BigInteger.valueOf(facilityUnitId), formatter.parse(consumptionDate)};
                where = "WHERE destinationunitid=:destinationunitid AND DATE(dateprescribed)=:dateprescribed GROUP BY issueditems, notissueditems, dateprescribed, destinationunitid";
                List<Object[]> servicedPercentages = (List<Object[]>) genericClassService.fetchRecordFunction(Servicedprescriptionstats.class, fields, where, params, paramsValues, 0, 0);
                if (servicedPercentages != null) {
                    Map<String, Object> percentage;
                    for (Object[] servicedPercentage : servicedPercentages) {
                        percentage = new HashMap<>();
                        percentage.put("count", String.format("%s", servicedPercentage[0].toString()));
                        percentage.put("label", String.format("%s%% Serviced: ", removeTrailingZeros.format(servicedPercentage[3])));
                        percentages.add(percentage);
                    }
                }
            }
            //
            model.put("todayconsumptions", todayConsumptions);
            model.put("consumptiondate", consumptionDate);
            //
            model.put("totalissued", String.format("%,d", totalIssued));
            model.put("totalprescribed", String.format("%,d", totalPrescribed));
            model.put("percentages", percentages);
            model.put("serverdate", formatterwithtime3.format(serverDate));
            //
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (ParseException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("dispensing/views/todayConsumption", model);
    }
//    @RequestMapping(value = "/servicedpatientdetails", method = RequestMethod.GET)  
//    public ModelAndView servicedPatientDetails(HttpServletRequest request){
//        Map<String, Object> model = new HashMap<>();
//        try {  
//            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
//            final long patientVisitId = (request.getParameter("patientvisitid") != null) ? Long.parseLong(request.getParameter("patientvisitid")) : 0;
//            final List<Map<String, Object>> originalPrescriptionItemsList = new ArrayList<>();
//            final List<Map<String, Object>> modifiedPrescriptionItemsList = new ArrayList<>();
//            long patientid = 0L, prescriptionId = 0L;            
//
//            String [] fields = { "patientid" };
//            String [] params = { "patientvisitid" };
//            Object [] paramsValues = { patientVisitId };
//            String where = "WHERE patientvisitid=:patientvisitid";
//            List<Object> patientVisits = (List<Object>) genericClassService.fetchRecord(Patientvisit.class, fields, where, params, paramsValues);
//            patientid = (patientVisits != null && patientVisits.get(0) != null) ? Long.parseLong(patientVisits.get(0).toString()) : 0;
//            fields = new String[]{ "nextofkincontact", "nextofkinname", "relationship", "telephone" };            
//            params = new String[]{"patientid"};
//            paramsValues = new Object[]{  patientid };
//            where = "WHERE r.patientid=:patientid";
//            List<Object[]> patients = (List<Object[]>) genericClassService.fetchRecord(Patient.class, fields, where, params, paramsValues);
//            if(patients != null && patients.get(0) != null && patients.get(0)[3] != null){
//                model.put("telephone", patients.get(0)[3]);
//            } else if(patients != null && patients.get(0) != null && (patients.get(0)[3] == null || patients.get(0)[3].toString().isEmpty())) {
//                for(Object [] patient : patients){
//                    model.put("nextofkincontact", patient[0]);
//                    model.put("nextofkinname", patient[1]);
//                    model.put("relationship", patient[2]);  
//                }
//            }          
//            fields = new String [] { "prescriptionid", "dateprescribed", "addedby", "originunitid", "patientvisitid" };
//            params = new String[] {"patientvisitid", "destinationunitid"};
//            paramsValues = new Object[] {patientVisitId, facilityUnitId };
//            where = "WHERE patientvisitid=:patientvisitid AND destinationunitid=:destinationunitid";
//            List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues); 
//            prescriptionId = (prescriptions != null && prescriptions.get(0) != null && prescriptions.get(0)[0] != null) ? Long.parseLong(prescriptions.get(0)[0].toString()) : 0;
//            
//            params =  new String [] { "prescriptionid" };
//            paramsValues = new Object [] { prescriptionId };
//            fields = new String [] { "newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname", "itemname", "notes" };
//            where = "WHERE prescriptionid=:prescriptionid";
//            List<Object[]> originalPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);
//            
//            fields = new String[]{ "newprescriptionitemsid", "prescriptionid", "dosage", "dose", "days", "daysname", "itemname", "reason" };
//            params = new String[]{ "prescriptionid" };
//            paramsValues = new Object[]{ prescriptionId };
//            where = "WHERE prescriptionid=:prescriptionid";
//            List<Object[]> modifiedPrescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Modifiedprescriptionitems.class, fields, where, params, paramsValues); 
//            if(originalPrescriptionItems != null){
//                Map<String, Object> prescriptionItem;
//                for(Object[] originalPrescriptionItem : originalPrescriptionItems){
//                    prescriptionItem = new HashMap<>();
//                    prescriptionItem.put("newprescriptionitemsid", originalPrescriptionItem[0]);
//                    prescriptionItem.put("prescriptionid", originalPrescriptionItem[1]);
//                    prescriptionItem.put("dosage", originalPrescriptionItem[2]);
//                    prescriptionItem.put("dose", originalPrescriptionItem[3]);
//                    prescriptionItem.put("days", originalPrescriptionItem[4]);
//                    prescriptionItem.put("daysname", originalPrescriptionItem[5]);
//                    prescriptionItem.put("itemname", originalPrescriptionItem[6]);
//                    prescriptionItem.put("notes", originalPrescriptionItem[7]);
//                    originalPrescriptionItemsList.add(prescriptionItem);
//                }
//            }
//            if(modifiedPrescriptionItems != null){
//                Map<String, Object> prescriptionItem;
//                for(Object[] modifiedPrescriptionItem : modifiedPrescriptionItems){
//                    prescriptionItem = new HashMap<>();
//                    prescriptionItem.put("newprescriptionitemsid", modifiedPrescriptionItem[0]);
//                    prescriptionItem.put("prescriptionid", modifiedPrescriptionItem[1]);
//                    prescriptionItem.put("dosage", modifiedPrescriptionItem[2]);
//                    prescriptionItem.put("dose", modifiedPrescriptionItem[3]);
//                    prescriptionItem.put("days", modifiedPrescriptionItem[4]);
//                    prescriptionItem.put("daysname", modifiedPrescriptionItem[5]);
//                    prescriptionItem.put("itemname", modifiedPrescriptionItem[6]);
//                    prescriptionItem.put("reason", modifiedPrescriptionItem[7]);
//                    modifiedPrescriptionItemsList.add(prescriptionItem);
//                }
//            }
//            model.put("originalprescriptionitems", originalPrescriptionItemsList);
//            model.put("modifiedprescriptionitems", modifiedPrescriptionItemsList);
//        } catch(NumberFormatException ex) {
//            System.out.println(ex);
//        } catch(Exception ex) {
//            System.out.println(ex);
//        }
//        return new ModelAndView("dispensing/views/servicedPatientDetails", model);
//    }

    public String computeAge3(int days) {
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

    private List<Map> generateDispensingPickList(List<Map> itemLocations, Integer quantityNeeded) {
        List<Map> itemPickList = new ArrayList<>();
        Map<String, Object> cellDatails;
        for (Map loc : itemLocations) {
            cellDatails = new HashMap<>();
            if ((Integer) loc.get("qty") < quantityNeeded) {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("qty", loc.get("qty"));
                cellDatails.put("stockid", loc.get("stockid"));
                itemPickList.add(cellDatails);
                quantityNeeded = quantityNeeded - (Integer) loc.get("qty");
            } else {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("stockid", loc.get("stockid"));
                cellDatails.put("qty", quantityNeeded);
                itemPickList.add(cellDatails);
                break;
            }
        }
        return itemPickList;
    }

    private static float getQuantity(String prescribedDose, String alternateDose) {
        float quantity = 1F;
        float prescribedDoseValue = 1F;
        float alternateDoseValue = 1F;
        String prescribedStrengthUnit = "";
        String alternateStrengthUnit = "";
        float numerator = 1F;
        float denominator = 1F;
        try {
            if ((!prescribedDose.contains("+") && !prescribedDose.contains("/")
                    && !prescribedDose.contains("%") && !prescribedDose.contains("\\"))
                    || (!alternateDose.contains("+") && !alternateDose.contains("/")
                    && !alternateDose.contains("%") && !alternateDose.contains("\\"))) {
                Pattern pattern = Pattern.compile("[a-zA-Z]+");

                Matcher matcher = pattern.matcher(prescribedDose);
                if (matcher.find()) {
                    prescribedStrengthUnit = matcher.group(0).replaceAll("\\s+", "");
                }

                matcher = pattern.matcher(alternateDose);
                if (matcher.find()) {
                    alternateStrengthUnit = matcher.group(0).replaceAll("\\s+", "");
                }

                pattern = Pattern.compile("[\\d.]+");

                matcher = pattern.matcher(prescribedDose);
                if (matcher.find()) {
                    prescribedDoseValue = Float.parseFloat(matcher.group(0).replaceAll("\\s+", ""));
                }

                matcher = pattern.matcher(alternateDose);
                if (matcher.find()) {
                    alternateDoseValue = Float.parseFloat(matcher.group(0).replaceAll("\\s+", ""));
                }

                if (prescribedStrengthUnit.equalsIgnoreCase(alternateStrengthUnit)) {
                    numerator = prescribedDoseValue;
                    denominator = alternateDoseValue;
                } else if (prescribedStrengthUnit.equalsIgnoreCase("mg") && (alternateStrengthUnit.equalsIgnoreCase("g") || alternateStrengthUnit.equalsIgnoreCase("gm"))) {
                    numerator = prescribedDoseValue;
                    denominator = 1000;
                } else if ((prescribedStrengthUnit.equalsIgnoreCase("g") || alternateStrengthUnit.equalsIgnoreCase("gm")) && alternateStrengthUnit.equalsIgnoreCase("mg")) {
                    numerator = (prescribedDoseValue * 1000);
                    denominator = alternateDoseValue;
                }
                if (denominator != 0) {
                    quantity = (numerator / denominator);
                } else {
                    quantity = 0;
                }
            } else {
                quantity = 1F;
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return quantity;
    }

    private List<Map> getItemslocations(long itemid, long currentfacility) {
        List<Map> itemsWithCellLocations = new ArrayList<>();
        float expired = 0;
        //FOR EACH ITEM(item ID find cells its located in
        String[] paramslocateitemcell = {"itemid", "facilityunitid"};
        Object[] paramsValueslocateitemcell = {itemid, currentfacility};
        String wherelocateitemcell = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid AND quantityshelved > 0 ORDER BY daystoexpire";
        String[] fieldslocateitemcell = {"itemid", "bayrowcellid", "quantityshelved", "daystoexpire", "celllabel", "batchnumber", "stockid"};
        List<Object[]> objlocateitemcell = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldslocateitemcell, wherelocateitemcell, paramslocateitemcell, paramsValueslocateitemcell);
        if (objlocateitemcell != null) {
            //Object[] cells = objlocateitemcell.get(0);
            Map<String, Object> cellMap;
            for (Object[] object : objlocateitemcell) {
                cellMap = new HashMap<>();
                if (object[3] != null) {
                    if ((Integer) object[3] > 0) {
                        expired = (Integer) object[3];
                        cellMap.put("daystoexpire", expired);
                        cellMap.put("itemid", object[0]);
                        cellMap.put("cellid", object[1]);
                        cellMap.put("qty", (Integer) object[2]);
                        cellMap.put("cell", object[4]);
                        cellMap.put("batchnumber", object[5]);
                        cellMap.put("stockid", object[6]);
                        itemsWithCellLocations.add(cellMap);
                    }
                } else {
                    cellMap.put("daystoexpire", 0.5);
                    cellMap.put("itemid", object[0]);
                    cellMap.put("cellid", object[1]);
                    cellMap.put("qty", (Integer) object[2]);
                    cellMap.put("cell", object[4]);
                    cellMap.put("batchnumber", object[5]);
                    cellMap.put("stockid", object[6]);
                    itemsWithCellLocations.add(cellMap);
                }
            }
        }
        return itemsWithCellLocations;
    }

    private List<Map> generatePickList(List<Map> itemLocations, Integer quantityNeeded) {
        List<Map> itemPickList = new ArrayList<>();
        Map<String, Object> cellDatails;
        for (Map loc : itemLocations) {
            cellDatails = new HashMap<>();
            if ((Integer) loc.get("qty") < quantityNeeded) {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("qty", loc.get("qty"));
                cellDatails.put("stockid", loc.get("stockid"));
                itemPickList.add(cellDatails);
                quantityNeeded = quantityNeeded - (Integer) loc.get("qty");
            } else {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("stockid", loc.get("stockid"));
                cellDatails.put("qty", quantityNeeded);
                itemPickList.add(cellDatails);
                break;
            }
        }
        return itemPickList;
    }

    private int getQtyToPick(String dosage, int days, float quantity, String daysName) {
        float qtyToPick = 0.0F;
        try {
            days = getDays(daysName, days);
            if (dosage.equalsIgnoreCase("Daily(OD)")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 1 * days));
            } else if (dosage.equalsIgnoreCase("BID/b.i.d")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 2 * days));
            } else if (dosage.equalsIgnoreCase("TID/t.i.d")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 3 * days));
            } else if (dosage.equalsIgnoreCase("QID/q.i.d")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 4 * days));
            } else if (dosage.equalsIgnoreCase("QHS(Bed time)")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 1 * days));
            } else if (dosage.equalsIgnoreCase("Q4h(Every 4 hours)")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 6 * days));
            } else if (dosage.equalsIgnoreCase("Q4h-6h(4-6 hours)")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 4 * days));
            } else if (dosage.equalsIgnoreCase("QWK(Every Week)")) {
                qtyToPick = Float.parseFloat(String.valueOf(quantity * 1 * days));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return Math.round(qtyToPick);
    }

    public Map<String, Object> getShelvedAndUnShelvedItemStock(BigInteger itemId, long facilityUnitId) {
        Map<String, Object> shelvedAndUnshelvedStock = new HashMap<>();
        try {
            String[] paramsCellitem = {"itemid", "facilityunitid"};
            Object[] paramsValuesCellitem = {itemId, facilityUnitId};
            String whereCellitem = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
            String[] fieldsCellitem = {"celllabel", "daystoexpire", "quantityshelved", "batchnumber"};
            List<Object[]> objCellitem = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class,
                    fieldsCellitem, whereCellitem, paramsCellitem, paramsValuesCellitem);
            int stockBalance = 0;
            long unshelvedstock = 0;
            //NEED THIS
            if (objCellitem != null) {
                for (Object[] cellitem : objCellitem) {
                    if (cellitem[1] != null) {
                        if ((Integer) cellitem[1] > 0) {
                            stockBalance = stockBalance + (Integer) cellitem[2];
                        }
                    } else {
                        stockBalance = stockBalance + (Integer) cellitem[2];
                    }
                }
            }

            //FETCH Qty unshelved
            String[] paramsstockrecieved = {"itemid", "facilityunitid"};
            Object[] paramsValuesstockrecieved = {itemId, facilityUnitId};
            String wherestockrecieved = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
            String[] fieldsstockrecieved = {"quantityrecieved", "shelvedstock", "stockid"};
            List<Object[]> objstockrecieved = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fieldsstockrecieved, wherestockrecieved, paramsstockrecieved, paramsValuesstockrecieved);
            if (objstockrecieved != null) {
                long unshelved = 0;
                for (Object[] stockrecieved : objstockrecieved) {
                    unshelved = unshelved + (Integer) stockrecieved[0] - (Integer) stockrecieved[1];
                    unshelvedstock = unshelvedstock + unshelved;
                    shelvedAndUnshelvedStock.put("unshelvedstock", unshelvedstock);
                }
            }
            shelvedAndUnshelvedStock.put("shelvedstock", stockBalance);
            shelvedAndUnshelvedStock.put("unshelvedstock", unshelvedstock);
        } catch (Exception e) {
            System.out.println(e);
        }
        return shelvedAndUnshelvedStock;
    }

    private List<Map> getDispensingItemslocations(long itemid, long currentfacility) {
        List<Map> itemsWithCellLocations = new ArrayList<>();
        float expired = 0;
        //FOR EACH ITEM(item ID find cells its located in
        String[] paramslocateitemcell = {"itemid", "facilityunitid"};
        Object[] paramsValueslocateitemcell = {itemid, currentfacility};
        String wherelocateitemcell = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid AND quantityshelved > 0 ORDER BY daystoexpire";
        String[] fieldslocateitemcell = {"itemid", "bayrowcellid", "quantityshelved", "daystoexpire", "celllabel", "batchnumber", "stockid"};
        List<Object[]> objlocateitemcell = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldslocateitemcell, wherelocateitemcell, paramslocateitemcell, paramsValueslocateitemcell);
        if (objlocateitemcell != null) {
            //Object[] cells = objlocateitemcell.get(0);
            Map<String, Object> cellMap;
            for (Object[] object : objlocateitemcell) {
                cellMap = new HashMap<>();
                if (object[3] != null) {
                    if ((Integer) object[3] > 0) {
                        expired = (Integer) object[3];
                        cellMap.put("daystoexpire", expired);
                        cellMap.put("itemid", object[0]);
                        cellMap.put("cellid", object[1]);
                        cellMap.put("qty", (Integer) object[2]);
                        cellMap.put("cell", object[4]);
                        cellMap.put("batchnumber", object[5]);
                        cellMap.put("stockid", object[6]);
                        itemsWithCellLocations.add(cellMap);
                    }
                } else {
                    cellMap.put("daystoexpire", 0.5);
                    cellMap.put("itemid", object[0]);
                    cellMap.put("cellid", object[1]);
                    cellMap.put("qty", (Integer) object[2]);
                    cellMap.put("cell", object[4]);
                    cellMap.put("batchnumber", object[5]);
                    cellMap.put("stockid", object[6]);
                    itemsWithCellLocations.add(cellMap);
                }
            }
        }
        return itemsWithCellLocations;
    }

    private Boolean isOutOfStock(String genericname, Long facilityUnitId) {
        boolean isOutOfStock = false;
        try {
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                    new String[]{"itempackageid", "genericname", "itemstrength"}, "WHERE issupplies=:issupplies AND genericname=:itemname", new String[]{"issupplies", "itemname"}, new Object[]{Boolean.FALSE, genericname});

            if (items != null) {
                for (Object[] item : items) {
                    BigInteger itemId = BigInteger.valueOf(Long.parseLong(item[0].toString()));
                    Map<String, Object> shelvedAndUnShelvedStock = getShelvedAndUnShelvedItemStock(itemId, facilityUnitId);
                    long qtyinstock = Long.parseLong(shelvedAndUnShelvedStock.get("shelvedstock").toString());
                    if (qtyinstock <= 0) {
                        isOutOfStock = Boolean.TRUE;
                    } else {
                        isOutOfStock = Boolean.FALSE;
                        break;
                    }
                }
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return isOutOfStock;
    }

    private List<Object> getItemBatchNumbers(Long newprescriptionitemsid) {
        List<Object> batchNumbers = null;
        try {
            String[] fields = {"batchnumber"};
            String[] params = {"newprescriptionitemsid"};
            Object[] paramsValues = {newprescriptionitemsid};
            String where = "WHERE newprescriptionitemsid=:newprescriptionitemsid";
            batchNumbers = (List<Object>) genericClassService.fetchRecord(Servicedprescriptionbatchnumbersview.class, fields, where, params, paramsValues);
        } catch (Exception e) {
            System.out.println(e);
        }
        return batchNumbers;
    }

    public static String getUnitRegisterPath() {
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

    private String recordUresolvedPrescription(final long prescriptionId, final long prescriptionItemsId,
            final long patientVisitId, final long currStaffId, final long facilityUnitId) {
        String result = "";
        try {
            Object saved = null;
            Unresolvedprescriptionitems unresolvedprescriptionitems = new Unresolvedprescriptionitems();
            unresolvedprescriptionitems.setPrescriptionid(prescriptionId);
            unresolvedprescriptionitems.setPrescriptionitemsid(prescriptionItemsId);
            unresolvedprescriptionitems.setPatientvisitid(patientVisitId);
            unresolvedprescriptionitems.setAddedby(currStaffId);
            unresolvedprescriptionitems.setDateadded(new Date());
            unresolvedprescriptionitems.setUpdatedby(currStaffId);
            unresolvedprescriptionitems.setDateupdated(new Date());
            unresolvedprescriptionitems.setFacilityunitid(facilityUnitId);
            saved = genericClassService.saveOrUpdateRecordLoadObject(unresolvedprescriptionitems);
            //
            String[] columns = new String[]{"isunresolved"};
            Object[] columnValues = new Object[]{Boolean.TRUE};
            String pk = "prescriptionid";
            Object pkValue = prescriptionId;
            int rowsAffected = genericClassService.updateRecordSQLSchemaStyle(Prescriptionqueue.class, columns, columnValues, pk, pkValue, "patient");
            //
            result = (saved != null) ? "success" : "failure";
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    private String recordUnservicedPrescription(final long prescriptionId, final long currStaffId, int facilityUnitId) {
        String result = "";
        try {
            Object saved = null;
            boolean alreadyRecorded = Boolean.FALSE;
            String[] fields = new String[]{"itemname", "newprescriptionitemsid", "prescriptionid", "dose"};
//            String [] params = new String[] {"prescriptionid", "approvable"};
//            Object [] paramsValues = new Object[] {prescriptionId, Boolean.FALSE};
//            String where = "WHERE prescriptionid=:prescriptionid AND (approvable IS NULL OR approvable=:approvable)";
            String[] params = new String[]{"prescriptionid"};
            Object[] paramsValues = new Object[]{prescriptionId};
            String where = "WHERE prescriptionid=:prescriptionid";
            List<Object[]> prescriptionItems = (List<Object[]>) genericClassService.fetchRecord(Newprescriptionitems.class, fields, where, params, paramsValues);

            if (prescriptionItems != null) {
                for (Object[] item : prescriptionItems) {
                    //
                    boolean isOutOfStock = isOutOfStock(item[0].toString(), Long.parseLong(String.valueOf(facilityUnitId)));
                    if (!isOutOfStock) {
                        continue;
                    }
                    //
                    String[] columns = {"approvable"};
                    Object[] columnValues = {Boolean.FALSE};
                    String pk = "newprescriptionitemsid";
                    Object pkValue = Long.valueOf(item[1].toString());
                    genericClassService.updateRecordSQLSchemaStyle(Newprescriptionitems.class, columns, columnValues, pk, pkValue, "patient");
                    //
                    Unservicedprescriptionitemsreasons unservicedprescriptionitemsreasons = new Unservicedprescriptionitemsreasons();
                    unservicedprescriptionitemsreasons.setPrescriptionid(prescriptionId);
                    unservicedprescriptionitemsreasons.setAddedby(currStaffId);
                    unservicedprescriptionitemsreasons.setDateadded(new Date());
                    unservicedprescriptionitemsreasons.setUpdatedby(currStaffId);
                    unservicedprescriptionitemsreasons.setDateupdated(new Date());
                    unservicedprescriptionitemsreasons.setNewprescriptionitemsid(Long.parseLong(item[1].toString()));
                    unservicedprescriptionitemsreasons.setReason("Out Of Stock");
                    saved = genericClassService.saveOrUpdateRecordLoadObject(unservicedprescriptionitemsreasons);
                    if (!alreadyRecorded) {
                        params = new String[]{"prescriptionid", "approvable"};
                        paramsValues = new Object[]{prescriptionId, Boolean.TRUE};
                        where = "WHERE prescriptionid=:prescriptionid AND approvable=:approvable";
                        int approvableCount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where, params, paramsValues);

                        paramsValues = new Object[]{prescriptionId, Boolean.FALSE};
                        where = "WHERE prescriptionid=:prescriptionid AND (approvable IS NULL OR approvable=:approvable)";
                        int unApprovableCount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where, params, paramsValues);

                        params = new String[]{"prescriptionid"};
                        paramsValues = new Object[]{prescriptionId};
                        where = "WHERE prescriptionid=:prescriptionid";
                        int totalCount = genericClassService.fetchRecordCount(Newprescriptionitems.class, where, params, paramsValues);
                        totalCount = (totalCount == 0) ? 1 : totalCount;

                        Servicedprescriptions servicedPrescription = new Servicedprescriptions();
                        servicedPrescription.setPrescriptionid(prescriptionId);
                        servicedPrescription.setAddedby(currStaffId);
                        servicedPrescription.setDateadded(new Date());
                        double approvablePercetnage = Double.parseDouble(String.valueOf((Double.parseDouble(String.valueOf(approvableCount)) / Double.parseDouble(String.valueOf(totalCount))) * 100));
                        servicedPrescription.setIssueditems(BigDecimal.valueOf(approvablePercetnage));
                        double unApprovablePercentage = ((Double.parseDouble(String.valueOf(unApprovableCount)) / Double.parseDouble(String.valueOf(totalCount)) * 100));
                        servicedPrescription.setNotissueditems(BigDecimal.valueOf(unApprovablePercentage));
                        saved = genericClassService.saveOrUpdateRecordLoadObject(servicedPrescription);
                        alreadyRecorded = Boolean.TRUE;
                    }
                }
            }
            result = (saved != null) ? "success" : "failure";
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
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

    private Map getItemStockLevel(Integer facilityUnit, Integer itemid, Date startDate, Date endDate) {
        long available = 0, stockReceived = 0;
        Map<String, Object> stockLevels = new HashMap<>();

        //Opening Stock.
        String[] params = {"facilityunitid", "itemid", "start"};
        Object[] paramsValues = {facilityUnit, itemid, startDate};
        String[] fields = {"r.logtype", "SUM(r.quantity)"};
        String where = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)<:start GROUP BY r.logtype";
        List<Object[]> stockLogs = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields, where, params, paramsValues, 0, 0);
        if (stockLogs != null) {
            for (Object[] opn : stockLogs) {
                if ("IN".equalsIgnoreCase((String) opn[0])) {
                    available = available + Long.parseLong(opn[1].toString());
                } else {
                    available = available - Long.parseLong(opn[1].toString());
                }
            }
        }
        stockLevels.put("opening", available);

        //Received stock.
        String[] params3 = {"facilityunitid", "itemid", "start", "end", "logtype"};
        Object[] paramsValues3 = {facilityUnit, itemid, startDate, endDate, "IN"};
        String[] fields3 = {"sum(r.quantity)"};
        String where3 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND r.logtype=:logtype";
        List<Object> received = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields3, where3, params3, paramsValues3, 0, 0);
        if (received != null) {
            if (received.get(0) != null) {
                stockReceived = Long.parseLong(received.get(0).toString());
                available = available + stockReceived;
            }
        }
        stockLevels.put("received", stockReceived);

        //Issued stock.
        String[] params4 = {"facilityunitid", "itemid", "start", "end", "out", "disp", "disc", "exp"};
        Object[] paramsValues4 = {facilityUnit, itemid, startDate, endDate, "OUT", "DISP", "DISC", "EXP"};
        String[] fields4 = {"sum(r.quantity)"};
        String where4 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND (r.logtype=:out OR r.logtype=:disp OR r.logtype=:disc OR r.logtype=:exp)";
        List<Object> stockOut = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields4, where4, params4, paramsValues4, 0, 0);
        if (stockOut != null) {
            if (stockOut.get(0) != null) {
                available = available - Long.parseLong(stockOut.get(0).toString());
            }
        }
        stockLevels.put("available", available);

        return stockLevels;
    }

    private int getDays(String daysName, int days) {
        int result = days;
        try {
            if (daysName.trim().equalsIgnoreCase("Day(s)")) {
                result = (days * 1);
            } else if (daysName.trim().equalsIgnoreCase("Week(S)")) {
                result = (days * 7);
            } else if (daysName.trim().equalsIgnoreCase("Month(s)")) {
                result = (days * 30);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}
