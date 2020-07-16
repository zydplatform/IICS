/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Locations;
import com.iics.domain.Person;
import com.iics.patient.Patientvisit;
import com.iics.patient.Searchpatient;
import com.iics.patient.Servicequeue;
import com.iics.patient.Triage;
import com.iics.patient.Zscores;
import com.iics.service.GenericClassService;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author user
 */
@Controller
@RequestMapping("/paediatrics")
public class paediatrics {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Double totalmonths;

    @RequestMapping(value = "/paediaricsmenu", method = RequestMethod.GET)
    public String paediaricsmenu(Model model) {
        return "patientsManagement/paediatrics/paediaricsmenu";
    }

    @RequestMapping(value = "/paedtriage", method = RequestMethod.GET)
    public String paedtriage(Model model, HttpServletRequest request) throws FileNotFoundException, IOException {
        Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        int totalTriagePatients = 0;
        String[] params5todaypat = {"facilityunitid", "dateadded"};
        Object[] paramsValuestodaypat = {BigInteger.valueOf(facilityunitId.longValue()), new Date()};
//        Object[] paramsValuestodaypat = {BigInteger.valueOf(facilityunitId.longValue()), formatter.format(new Date())};
        String[] fields5todaypat = {"patientvisitid"};
//        List<Long> objtodaypat = (List<Long>) genericClassService.fetchRecord(Patientvisit.class, fields5todaypat, "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params5todaypat, paramsValuestodaypat);
        List<Long> objtodaypat = (List<Long>) genericClassService.fetchRecord(Patientvisit.class, fields5todaypat, "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded", params5todaypat, paramsValuestodaypat);
        if (objtodaypat != null) {
            for (Long todaypat : objtodaypat) {
                String[] paramstriageid = {"servicekey"};
                Object[] paramsValuestriageid = {"key_triage"};
                String[] fieldstriageid = {"serviceid"};
                List<Integer> patientsvisitstriageid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
                if (patientsvisitstriageid != null) {
                    String[] params = {"serviceid", "facilityunit"};
                    Object[] paramValues = {patientsvisitstriageid, (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                    String[] fields = {"facilityunitserviceid"};
                    String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                    List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramValues);
                    if (serviceid != null) {
                        String[] paramspatienttot = {"unitserviceid", "patientvisitid", "serviced", "canceled"};
                        Object[] paramsValuespatienttot = {serviceid.get(0), BigInteger.valueOf(todaypat), true, false};
                        String wherepatienttot = "WHERE unitserviceid=:unitserviceid AND patientvisitid=:patientvisitid AND serviced=:serviced AND canceled=:canceled";
                        totalTriagePatients = genericClassService.fetchRecordCount(Servicequeue.class, wherepatienttot, paramspatienttot, paramsValuespatienttot);
                    }
                }
            }
        }
        model.addAttribute("totalTriagePatients", String.format("%,d", totalTriagePatients));
        return "patientsManagement/paediatrics/views/triage";
    }

    @RequestMapping(value = "/triagepatientinqueuedetails.htm", method = RequestMethod.GET)
    public String triagepatientinqueuedetails(Model model, HttpServletRequest request) {

        String[] paramsbasicinfo = {"patientid"};
        Object[] paramsValuesbasicinfo = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fieldsbasicinfo = {"personid", "firstname", "lastname", "othernames", "patientno", "nextofkincontact", "nextofkin", "currentaddress"};
        List<Object[]> patientsvisitsbasicinfo = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fieldsbasicinfo, "WHERE patientid=:patientid", paramsbasicinfo, paramsValuesbasicinfo);
        if (patientsvisitsbasicinfo != null) {
            String[] params5basicinfo = {"personid"};
            Object[] paramsValues5basicinfo = {patientsvisitsbasicinfo.get(0)[0]};
            String[] fields5basicinfo = {"dob", "estimatedage", "gender"};
            List<Object[]> objpatientdetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields5basicinfo, "WHERE personid=:personid", params5basicinfo, paramsValues5basicinfo);

            if (patientsvisitsbasicinfo.get(0)[3] != null || patientsvisitsbasicinfo.get(0)[3] != "") {
                model.addAttribute("name", patientsvisitsbasicinfo.get(0)[1] + " " + patientsvisitsbasicinfo.get(0)[2] + " " + patientsvisitsbasicinfo.get(0)[3]);
            } else {
                model.addAttribute("name", patientsvisitsbasicinfo.get(0)[1] + " " + patientsvisitsbasicinfo.get(0)[3] + " " + patientsvisitsbasicinfo.get(0)[2]);
            }
            model.addAttribute("patientno", patientsvisitsbasicinfo.get(0)[4]);
            model.addAttribute("nextofkincontact", patientsvisitsbasicinfo.get(0)[5]);
            model.addAttribute("nextofkin", patientsvisitsbasicinfo.get(0)[6]);
            model.addAttribute("dob", formatter.format((Date) objpatientdetails.get(0)[0]));

            model.addAttribute("gender", objpatientdetails.get(0)[2]);
            DateTimeFormatter dtformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate today = LocalDate.now();
            LocalDate birthday = LocalDate.parse(formatter.format((Date) objpatientdetails.get(0)[0]), dtformatter);
            Period p = Period.between(birthday, today);
            model.addAttribute("years", p.getYears());
            model.addAttribute("months", p.getMonths());
            model.addAttribute("days", p.getDays());
            //GET TOTAL NUMBER OF MONTHS
            int total_months = ((p.getYears()) * 12) + p.getMonths();
            model.addAttribute("total_months", total_months);

            String[] paramsresidence = {"villageid"};
            Object[] paramsValuesresidence = {(Integer) patientsvisitsbasicinfo.get(0)[7]};
            String[] fieldsresidence = {"villagename"};
            List<String> patientsvisitsresidence = (List<String>) genericClassService.fetchRecord(Locations.class, fieldsresidence, "WHERE villageid=:villageid", paramsresidence, paramsValuesresidence);
            if (patientsvisitsresidence != null) {
                model.addAttribute("village", patientsvisitsresidence.get(0));
            }

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }
        return "patientsManagement/paediatrics/views/paedtriageformbasicinfo";
    }

//    @RequestMapping(value = "/viewHFAboys", method = RequestMethod.GET)
//    public String viewHFAboys(Model model, HttpServletRequest request) throws JsonProcessingException, FileNotFoundException, Exception {
//
//        List<Map> z_scores = new ArrayList<>();
//        List<Map> others = new ArrayList<>();
//        Map<String, Object> z_scores_values;
//        Map<String, Object> other_values;
//        other_values = new HashMap<>();
//        others.add(other_values);
//        File excelFile = new File("D:\\z_scores.xlsx"); // Change the location and file name as per yours
//        readFromExcel uploaded = new readFromExcel(excelFile);
//        ArrayList<ArrayList<Object>> list = uploaded.extractAsList(); // Rows in excel will be returned as list
//        for (ArrayList<Object> singleRow : list) {
//            z_scores_values = new HashMap<>();
//
//            Double month = (Double) singleRow.get(0);
//            Double neg_3sd = (Double) singleRow.get(5);
//            Double neg_2sd = (Double) singleRow.get(6);
//            Double neg_1sd = (Double) singleRow.get(7);
//            Double normalsd = (Double) singleRow.get(8);
//            Double pos_1sd = (Double) singleRow.get(9);
//            Double pos_2sd = (Double) singleRow.get(10);
//            Double pos_3sd = (Double) singleRow.get(11);
//
//            z_scores_values.put("neg_3sd", neg_3sd);
//            z_scores_values.put("neg_2sd", neg_2sd);
//            z_scores_values.put("neg_1sd", neg_1sd);
//            z_scores_values.put("normalsd", normalsd);
//            z_scores_values.put("pos_1sd", pos_1sd);
//            z_scores_values.put("pos_2sd", pos_2sd);
//            z_scores_values.put("pos_3sd", pos_3sd);
//            z_scores.add(z_scores_values);
//        }
//        String plots = new ObjectMapper().writeValueAsString(z_scores);
//        String othersv = new ObjectMapper().writeValueAsString(others);
//        model.addAttribute("z_scores", plots);
//        model.addAttribute("othersv", othersv);
//
//        return "patientsManagement/paediatrics/views/Height_for_ageboys";
//    }

//
//    @RequestMapping(value = "/viewWFAboys", method = RequestMethod.GET)
//    public String viewWFAboys(Model model) throws JsonProcessingException {
//        List<Map> z_scores = new ArrayList<>();
//        Map<String, Object> z_scores_values;
//        File excelFile = new File("C:\\z_scores.xlsx"); // Change the location and file name as per yours
//        ReadWFAboysExcel uploaded = new ReadWFAboysExcel(excelFile);
//        ArrayList<ArrayList<Object>> list = uploaded.extractAsList(); // Rows in excel will be returned as list
//        for (ArrayList<Object> singleRow : list) {
//            z_scores_values = new HashMap<>();
//            Double month = (Double) singleRow.get(0);
//            Double neg_3sd = (Double) singleRow.get(4);
//            Double neg_2sd = (Double) singleRow.get(5);
//            Double neg_1sd = (Double) singleRow.get(6);
//            Double normalsd = (Double) singleRow.get(7);
//            Double pos_1sd = (Double) singleRow.get(8);
//            Double pos_2sd = (Double) singleRow.get(9);
//            Double pos_3sd = (Double) singleRow.get(10);
//            z_scores_values.put("month", month);
//            z_scores_values.put("neg_3sd", neg_3sd);
//            z_scores_values.put("neg_2sd", neg_2sd);
//            z_scores_values.put("neg_1sd", neg_1sd);
//            z_scores_values.put("normalsd", normalsd);
//            z_scores_values.put("pos_1sd", pos_1sd);
//            z_scores_values.put("pos_2sd", pos_2sd);
//            z_scores_values.put("pos_3sd", pos_3sd);
//            z_scores.add(z_scores_values);
//        }
//        String plots = new ObjectMapper().writeValueAsString(z_scores);
//        model.addAttribute("z_scores", plots);
//        return "patientsManagement/paediatrics/views/weight_for_ageboys";
//    }
//

//    @RequestMapping(value = "/viewWFHboys", method = RequestMethod.GET)
//    public String viewWFHboys(Model model) throws JsonProcessingException {
//        List<Map> z_scores = new ArrayList<>();
//        Map<String, Object> z_scores_values;
//        File excelFile = new File("D:\\z_scores.xlsx"); // Change the location and file name as per yours
//        ReadWFHboysExcel uploaded = new ReadWFHboysExcel(excelFile);
//        ArrayList<ArrayList<Object>> list = uploaded.extractAsList(); // Rows in excel will be returned as list
//        for (ArrayList<Object> singleRow : list) {
//            z_scores_values = new HashMap<>();
//            Double height = (Double) singleRow.get(0);
//            Double neg_3sd = (Double) singleRow.get(4);
//            Double neg_2sd = (Double) singleRow.get(5);
//            Double neg_1sd = (Double) singleRow.get(6);
//            Double normalsd = (Double) singleRow.get(7);
//            Double pos_1sd = (Double) singleRow.get(8);
//            Double pos_2sd = (Double) singleRow.get(9);
//            Double pos_3sd = (Double) singleRow.get(10);
//            z_scores_values.put("height", height);
//
//            z_scores_values.put("neg_3sd", neg_3sd);
//            z_scores_values.put("neg_2sd", neg_2sd);
//            z_scores_values.put("neg_1sd", neg_1sd);
//            z_scores_values.put("normalsd", normalsd);
//            z_scores_values.put("pos_1sd", pos_1sd);
//            z_scores_values.put("pos_2sd", pos_2sd);
//            z_scores_values.put("pos_3sd", pos_3sd);
//            z_scores.add(z_scores_values);
//        }
//        String plots = new ObjectMapper().writeValueAsString(z_scores);
//        model.addAttribute("z_scores", plots);
//        return "patientsManagement/paediatrics/views/weight_for_heightboys";
//    }
//
//    @RequestMapping(value = "/viewHFAgirls", method = RequestMethod.GET)
//    public String viewHFAgirls(Model model) throws JsonProcessingException {
//        List<Map> z_scores = new ArrayList<>();
//        Map<String, Object> z_scores_values;
//        File excelFile = new File("D:\\z_scores.xlsx"); // Change the location and file name as per yours
//        ReadHFAgirlsExcel uploaded = new ReadHFAgirlsExcel(excelFile);
//        ArrayList<ArrayList<Object>> list = uploaded.extractAsList(); // Rows in excel will be returned as list
//        for (ArrayList<Object> singleRow : list) {
//            z_scores_values = new HashMap<>();
//            z_scores_values = new HashMap<>();
//            Double month = (Double) singleRow.get(0);
//            Double neg_3sd = (Double) singleRow.get(5);
//            Double neg_2sd = (Double) singleRow.get(6);
//            Double neg_1sd = (Double) singleRow.get(7);
//            Double normalsd = (Double) singleRow.get(8);
//            Double pos_1sd = (Double) singleRow.get(9);
//            Double pos_2sd = (Double) singleRow.get(10);
//            Double pos_3sd = (Double) singleRow.get(11);
//            z_scores_values.put("month", month);
//            z_scores_values.put("neg_3sd", neg_3sd);
//            z_scores_values.put("neg_2sd", neg_2sd);
//            z_scores_values.put("neg_1sd", neg_1sd);
//            z_scores_values.put("normalsd", normalsd);
//            z_scores_values.put("pos_1sd", pos_1sd);
//            z_scores_values.put("pos_2sd", pos_2sd);
//            z_scores_values.put("pos_3sd", pos_3sd);
//            z_scores.add(z_scores_values);
//        }
//        String plots = new ObjectMapper().writeValueAsString(z_scores);
//        model.addAttribute("z_scores", plots);
//        return "patientsManagement/paediatrics/views/Height_for_agegirls";
//    }
//
//    @RequestMapping(value = "/viewWFAgirls", method = RequestMethod.GET)
//    public String viewWFAgirls(Model model) throws JsonProcessingException {
//        List<Map> z_scores = new ArrayList<>();
//        Map<String, Object> z_scores_values;
//        File excelFile = new File("D:\\z_scores.xlsx"); // Change the location and file name as per yours
//        ReadWFAexcelgirls uploaded = new ReadWFAexcelgirls(excelFile);
//        ArrayList<ArrayList<Object>> list = uploaded.extractAsList(); // Rows in excel will be returned as list
//        for (ArrayList<Object> singleRow : list) {
//            z_scores_values = new HashMap<>();
//            Double month = (Double) singleRow.get(0);
//            Double neg_3sd = (Double) singleRow.get(4);
//            Double neg_2sd = (Double) singleRow.get(5);
//            Double neg_1sd = (Double) singleRow.get(6);
//            Double normalsd = (Double) singleRow.get(7);
//            Double pos_1sd = (Double) singleRow.get(8);
//            Double pos_2sd = (Double) singleRow.get(9);
//            Double pos_3sd = (Double) singleRow.get(10);
//            z_scores_values.put("month", month);
//            z_scores_values.put("neg_3sd", neg_3sd);
//            z_scores_values.put("neg_2sd", neg_2sd);
//            z_scores_values.put("neg_1sd", neg_1sd);
//            z_scores_values.put("normalsd", normalsd);
//            z_scores_values.put("pos_1sd", pos_1sd);
//            z_scores_values.put("pos_2sd", pos_2sd);
//            z_scores_values.put("pos_3sd", pos_3sd);
//            z_scores.add(z_scores_values);
//        }
//        String plots = new ObjectMapper().writeValueAsString(z_scores);
//        model.addAttribute("z_scores", plots);
//        return "patientsManagement/paediatrics/views/weight_for_agegirls";
//    }
//
//    @RequestMapping(value = "/viewWFHgirls", method = RequestMethod.GET)
//    public String viewWFHgirls(Model model) throws JsonProcessingException {
//        List<Map> z_scores = new ArrayList<>();
//        Map<String, Object> z_scores_values;
//        File excelFile = new File("D:\\z_scores.xlsx"); // Change the location and file name as per yours
//        ReadWFHboysExcel uploaded = new ReadWFHboysExcel(excelFile);
//        ArrayList<ArrayList<Object>> list = uploaded.extractAsList(); // Rows in excel will be returned as list
//        for (ArrayList<Object> singleRow : list) {
//            z_scores_values = new HashMap<>();
//            Double height = (Double) singleRow.get(0);
//            Double neg_3sd = (Double) singleRow.get(4);
//            Double neg_2sd = (Double) singleRow.get(5);
//            Double neg_1sd = (Double) singleRow.get(6);
//            Double normalsd = (Double) singleRow.get(7);
//            Double pos_1sd = (Double) singleRow.get(8);
//            Double pos_2sd = (Double) singleRow.get(9);
//            Double pos_3sd = (Double) singleRow.get(10);
//            z_scores_values.put("height", height);
//
//            z_scores_values.put("neg_3sd", neg_3sd);
//            z_scores_values.put("neg_2sd", neg_2sd);
//            z_scores_values.put("neg_1sd", neg_1sd);
//            z_scores_values.put("normalsd", normalsd);
//            z_scores_values.put("pos_1sd", pos_1sd);
//            z_scores_values.put("pos_2sd", pos_2sd);
//            z_scores_values.put("pos_3sd", pos_3sd);
//            z_scores.add(z_scores_values);
//        }
//        String plots = new ObjectMapper().writeValueAsString(z_scores);
//        model.addAttribute("z_scores", plots);
//        return "patientsManagement/paediatrics/views/weight_for_heightboys";
//    }

    @RequestMapping(value = "/HFAobservationboys", method = RequestMethod.POST)
    public @ResponseBody
    String HFAobservationboys(HttpServletRequest request) {
        String results = "";
        try {
            int monthsintotal = Integer.parseInt(request.getParameter("monthsintotal")) + 2;
            Double patientHeight = Double.parseDouble(request.getParameter("patientHeightcm"));
            //
            String file = "/home/iicsReports/z_scores.xlsx";
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet worksheet = workbook.getSheet("height_for_age_boys");
            XSSFRow row1 = worksheet.getRow(monthsintotal);

            XSSFCell cellA1 = row1.getCell(0);
            Double months = cellA1.getNumericCellValue();
            XSSFCell cellB1 = row1.getCell(4);
            Double standardDeviation = cellB1.getNumericCellValue();
            XSSFCell cellC1 = row1.getCell(5);
            Double neg3sd = cellC1.getNumericCellValue();
            XSSFCell cellD1 = row1.getCell(6);
            Double neg2sd = cellD1.getNumericCellValue();
            XSSFCell cellE1 = row1.getCell(7);
            Double neg1sd = cellE1.getNumericCellValue();
            XSSFCell cellF1 = row1.getCell(8);
            Double normal = cellF1.getNumericCellValue();
            XSSFCell cellG1 = row1.getCell(9);
            Double normal1sd = cellG1.getNumericCellValue();
            XSSFCell cellH1 = row1.getCell(10);
            Double normal2sd = cellH1.getNumericCellValue();
            XSSFCell cellI1 = row1.getCell(11);
            Double normal3sd = cellI1.getNumericCellValue();
            if (patientHeight >= neg1sd && patientHeight <= normal2sd) {
                results = "Normal";
            }
            if (patientHeight >= neg3sd && patientHeight <= neg2sd) {
                results = "Stunted";
            }
            if (patientHeight < neg3sd) {
                results = "Severely Stunted";
            }
            if (patientHeight > normal2sd && patientHeight < normal3sd) {
                results = "Tall";
            }
            if (patientHeight >= normal3sd) {
                results = "Very Tall";
            }

        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/WFAobservationboys", method = RequestMethod.POST)
    public @ResponseBody
    String WFAobservationboys(HttpServletRequest request) {
        String results = "";
        try {
            int monthsintotal = Integer.parseInt(request.getParameter("monthsintotal")) + 2;
            Double patientWeight = Double.parseDouble(request.getParameter("patientWeight"));
            //
            String file = "/home/iicsReports/z_scores.xlsx";
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet worksheet = workbook.getSheet("weight_for_age_boys");
            XSSFRow row1 = worksheet.getRow(monthsintotal);
            if (row1 == null) {
                results = "";
            } else {
                XSSFCell cellA1 = row1.getCell(0);
                Double months = cellA1.getNumericCellValue();
                XSSFCell cellB1 = row1.getCell(3);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(4);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(5);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(6);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(7);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(8);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(9);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(10);
                Double normal3sd = cellI1.getNumericCellValue();
                if ((patientWeight >= normal && patientWeight <= normal1sd)) {
                    results = "Normal";
                }
                if ((patientWeight <= normal && patientWeight >= neg2sd)) {
                    results = "Normal";
                }
                if (patientWeight > normal1sd) {
                    results = "Growth Problem";
                }
                if (patientWeight < neg2sd && patientWeight >= normal3sd) {
                    results = "Under Weight";
                }
                if (patientWeight < neg3sd) {
                    results = "Severely Underweight";
                }
            }

        } catch (IOException ex) {

            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/WFHobservationboys", method = RequestMethod.POST)
    public @ResponseBody
    String WFHobservationboys(HttpServletRequest request) {
        String results = "";
        try {
            int patientHeightcm = Integer.parseInt(request.getParameter("patientHeightcm"));
            Double patientWeight = Double.parseDouble(request.getParameter("patientWeight"));
            //
            if (patientHeightcm < 45) {

            } else {
                String file = "/home/iicsReports/z_scores.xlsx";
                XSSFWorkbook workbook = new XSSFWorkbook(file);
                XSSFSheet worksheet = workbook.getSheet("weight_for_height_boys");
                XSSFRow row1 = worksheet.getRow(((patientHeightcm - 45) * 2) + 1);
                XSSFCell cellB1 = row1.getCell(3);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(4);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(5);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(6);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(7);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(8);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(9);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(10);
                Double normal3sd = cellI1.getNumericCellValue();
                if (patientWeight > normal3sd) {
                    results = "Obese";
                }
                if (patientWeight > normal2sd && patientWeight <= normal3sd) {
                    results = "Over weight";
                }
                if (patientWeight > normal1sd && patientWeight <= normal2sd) {
                    results = "Over Weight Risk";
                }
                if (patientWeight <= normal && patientWeight >= neg2sd) {
                    results = "Normal";
                }
                if (patientWeight < normal2sd && patientWeight >= normal3sd) {
                    results = "Wasted";
                }
                if (patientWeight > normal3sd) {
                    results = "Severely Wasted";
                }
            }

        } catch (IOException ex) {

            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/WFAobservationgirls", method = RequestMethod.POST)
    public @ResponseBody
    String WFAobservationgirls(HttpServletRequest request) {
        String results = "";
        int monthsintotal = Integer.parseInt(request.getParameter("monthsintotal")) + 2;

        Double patientWeight = Double.parseDouble(request.getParameter("patientWeight"));
        try {
            String file = "/home/iicsReports/z_scores.xlsx";
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet worksheet = workbook.getSheet("weight_for_age_girls");
            XSSFRow row1 = worksheet.getRow(monthsintotal);
            if (row1 == null) {
                results = "";
            } else {
                XSSFCell cellA1 = row1.getCell(0);
                Double months = cellA1.getNumericCellValue();
                XSSFCell cellB1 = row1.getCell(3);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(4);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(5);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(6);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(7);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(8);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(9);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(10);
                Double normal3sd = cellI1.getNumericCellValue();
                if ((patientWeight >= normal && patientWeight <= normal1sd)) {
                    results = "Normal";
                }
                if ((patientWeight <= normal && patientWeight >= neg2sd)) {
                    results = "Normal";
                }
                if (patientWeight > normal1sd) {
                    results = "Growth Problem";
                }
                if (patientWeight < neg2sd && patientWeight >= normal3sd) {
                    results = "Under Weight";
                }
                if (patientWeight < neg3sd) {
                    results = "Severely Underweight";
                }
            }

        } catch (IOException ex) {
            results = ex.toString();
        }

        return results;
    }

    @RequestMapping(value = "/HFAobservationgirls", method = RequestMethod.POST)
    public @ResponseBody
    String HFAobservationgirls(HttpServletRequest request) {
        String results = "";
        try {
            int monthsintotal = Integer.parseInt(request.getParameter("monthsintotal")) + 2;
            Double patientHeight = Double.parseDouble(request.getParameter("patientHeightcm"));
            //
            String file = "/home/iicsReports/z_scores.xlsx";
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet worksheet = workbook.getSheet("height_for_age_girls");
            XSSFRow row1 = worksheet.getRow(monthsintotal);
            if (row1 == null) {
                results = "";
            } else {
                XSSFCell cellA1 = row1.getCell(0);
                Double months = cellA1.getNumericCellValue();
                XSSFCell cellB1 = row1.getCell(4);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(5);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(6);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(7);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(8);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(9);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(10);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(11);
                Double normal3sd = cellI1.getNumericCellValue();
                if (patientHeight >= neg1sd && patientHeight <= normal2sd) {
                    results = "Normal";
                }
                if (patientHeight >= neg3sd && patientHeight <= neg2sd) {
                    results = "Stunted";
                }
                if (patientHeight < neg3sd) {
                    results = "Severely Stunted";
                }
                if (patientHeight > normal2sd && patientHeight < normal3sd) {
                    results = "Tall";
                }
                if (patientHeight >= normal3sd) {
                    results = "Very Tall";
                }

            }

        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/WFHobservationgirls", method = RequestMethod.POST)
    public @ResponseBody
    String WFHobservationgirls(HttpServletRequest request) {
        String results = "";
        try {
            int patientHeightcm = Integer.parseInt(request.getParameter("patientHeightcm"));
            Double patientWeight = Double.parseDouble(request.getParameter("patientWeight"));
            if (patientHeightcm < 45) {
            } else {
                String file = "/home/iicsReports/z_scores.xlsx";
                XSSFWorkbook workbook = new XSSFWorkbook(file);
                XSSFSheet worksheet = workbook.getSheet("weight_for-height_girls");
                XSSFRow row1 = worksheet.getRow(((patientHeightcm - 45) * 2) + 1);
                XSSFCell cellB1 = row1.getCell(3);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(4);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(5);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(6);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(7);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(8);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(9);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(10);
                Double normal3sd = cellI1.getNumericCellValue();
                if (patientWeight > normal3sd) {
                    results = "Obese";
                }
                if (patientWeight > normal2sd && patientWeight <= normal3sd) {
                    results = "Over weight";
                }
                if (patientWeight > normal1sd && patientWeight <= normal2sd) {
                    results = "Over Weight Risk";
                }
                if (patientWeight <= normal && patientWeight >= neg2sd) {
                    results = "Normal";
                }
                if (patientWeight < normal2sd && patientWeight >= normal3sd) {
                    results = "Wasted";
                }
                if (patientWeight > normal3sd) {
                    results = "Severely Wasted";
                }
            }
            //

        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/savePatientTriageb", method = RequestMethod.POST)
    public @ResponseBody
    String savePatientTriageb(Model model, HttpServletRequest request) {

        Map<String, Object> item = null;
        try {
            item = new ObjectMapper().readValue(request.getParameter("value"), Map.class);
        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        Triage triage = new Triage();
        String patientWeight = item.get("patientWeight").toString();
        String patientTemperature = item.get("patientTemperature").toString();
        String patientHeight = item.get("patientHeight").toString();
        String patientPressureSystolic = item.get("patientPressureSystolic").toString();
        String patientPressureDiastolic = item.get("patientPressureDiastolic").toString();
        String patientPulse = item.get("patientPressureDiastolic").toString();
        String hfazscore = item.get("hfazscore").toString();
        String wfazscore = item.get("wfazscore").toString();
        String wfhzscore = item.get("wfhzscore").toString();

        String muac = item.get("muac").toString();
        String patientvisitid = item.get("patientVisitationId").toString();
        String patientBodySurfaceArea = item.get("patientBodySurfaceArea").toString();
        String patientRespirationRate = item.get("patientRespirationRate").toString();
        String patientTriageNotes = item.get("patientTriageNotes").toString();
        Long currStaffId = (Long) item.get("sessionActiveLoginStaffid");

        try {
            if ((patientTemperature) != null) {
                triage.setTemperature(Double.parseDouble(patientTemperature));
            }
        } catch (NumberFormatException ex) {
            //Player did the command wrong

        }
        try {
            if ((patientPressureSystolic) != null) {
                triage.setPatientpressuresystolic(Long.parseLong(patientPressureSystolic));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientPressureDiastolic) != null) {
                triage.setPatientpressurediastolic(Long.parseLong(patientPressureDiastolic));

            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientPulse) != null) {
                triage.setPulse(Integer.parseInt(patientPulse));

            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((muac) != null) {
                triage.setMuac(Double.parseDouble(muac));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientBodySurfaceArea) != null) {
                triage.setBodysurfacearea(Double.parseDouble(patientBodySurfaceArea));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientRespirationRate) != null) {
                triage.setRespirationrate(Integer.parseInt(patientRespirationRate));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientTriageNotes) != null) {
                triage.setNotes(patientTriageNotes);
            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientHeight) != null) {
                triage.setHeight(Double.parseDouble(patientHeight));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientWeight) != null) {
                triage.setWeight(Double.parseDouble(patientWeight));
            }
        } catch (NumberFormatException ex) {
        }

        triage.setAddedby(currStaffId);
        triage.setDateadded(new Date());

        triage.setPatientvisitid(Long.parseLong(patientvisitid));
        triage = (Triage) genericClassService.saveOrUpdateRecordLoadObject(triage);
        if (triage != null) {
            Zscores savezscore = new Zscores();
            savezscore.setTriageid(Long.parseLong(triage.getTriageid().toString()));
            try {
                if ((hfazscore) != null) {
                    savezscore.setHeightforage(hfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((hfazscore) != null) {
                    savezscore.setHeightforage(hfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }

            try {
                if ((wfazscore) != null) {
                    savezscore.setWeightforage(wfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong
            }
            try {
                if ((wfhzscore) != null) {
                    savezscore.setWeightforheight(wfhzscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong
            }
            genericClassService.saveOrUpdateRecordLoadObject(savezscore);
            
        }

        return "";
    }

    @RequestMapping(value = "/savePatientTriagebb", method = RequestMethod.POST)
    public @ResponseBody
    String savePatientTriagebb(Model model, HttpServletRequest request) {

        Map<String, Object> item = null;
        try {
            item = new ObjectMapper().readValue(request.getParameter("value"), Map.class);
        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        Triage triage = new Triage();
        String patientWeight = item.get("patientWeight").toString();
        String patientTemperature = item.get("patientTemperature").toString();
        String patientHeight = item.get("patientHeight").toString();
        String patientPressureSystolic = item.get("patientPressureSystolic").toString();
        String patientPressureDiastolic = item.get("patientPressureDiastolic").toString();
        String patientPulse = item.get("patientPressureDiastolic").toString();
        String hfazscore = item.get("hfazscore").toString();
        String wfazscore = item.get("wfazscore").toString();
        String bmiboys = item.get("bmiboys").toString();
        String muac = item.get("muac").toString();
        String patientvisitid = item.get("patientVisitationId").toString();
        String patientBodySurfaceArea = item.get("patientBodySurfaceArea").toString();
        String patientRespirationRate = item.get("patientRespirationRate").toString();
        String patientTriageNotes = item.get("patientTriageNotes").toString();
        Long currStaffId = (Long) item.get("sessionActiveLoginStaffid");

        try {
            if ((patientTemperature) != null) {
                triage.setTemperature(Double.parseDouble(patientTemperature));
            }
        } catch (NumberFormatException ex) {
            //Player did the command wrong

        }
        try {
            if ((patientPressureSystolic) != null) {
                triage.setPatientpressuresystolic(Long.parseLong(patientPressureSystolic));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientPressureDiastolic) != null) {
                triage.setPatientpressurediastolic(Long.parseLong(patientPressureDiastolic));

            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientPulse) != null) {
                triage.setPulse(Integer.parseInt(patientPulse));

            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((muac) != null) {
                triage.setMuac(Double.parseDouble(muac));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientBodySurfaceArea) != null) {
                triage.setBodysurfacearea(Double.parseDouble(patientBodySurfaceArea));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientRespirationRate) != null) {
                triage.setRespirationrate(Integer.parseInt(patientRespirationRate));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientTriageNotes) != null) {
                triage.setNotes(patientTriageNotes);
            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientHeight) != null) {
                triage.setHeight(Double.parseDouble(patientHeight));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientWeight) != null) {
                triage.setWeight(Double.parseDouble(patientWeight));
            }
        } catch (NumberFormatException ex) {
        }

        triage.setAddedby(currStaffId);
        triage.setDateadded(new Date());

        triage.setPatientvisitid(Long.parseLong(patientvisitid));
        triage.setPatientvisitid(Long.parseLong(patientvisitid));
        triage = (Triage) genericClassService.saveOrUpdateRecordLoadObject(triage);
        if (triage != null) {
            Zscores savezscore = new Zscores();
            savezscore.setTriageid(Long.parseLong(triage.getTriageid().toString()));
            try {
                if ((hfazscore) != null) {
                    savezscore.setHeightforage(hfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((bmiboys) != null) {
                    savezscore.setBmi(bmiboys);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((wfazscore) != null) {
                    savezscore.setWeightforage(wfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong
            }
            genericClassService.saveOrUpdateRecordLoadObject(savezscore);
        }
        return "";
    }

    @RequestMapping(value = "/savePatientTriageg", method = RequestMethod.POST)
    public @ResponseBody
    String savePatientTriageg(Model model, HttpServletRequest request) {

        Map<String, Object> item = null;
        try {
            item = new ObjectMapper().readValue(request.getParameter("value"), Map.class);
        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        Triage triage = new Triage();
        String patientWeight = item.get("patientWeight").toString();
        String patientTemperature = item.get("patientTemperature").toString();
        String patientHeight = item.get("patientHeight").toString();
        String patientPressureSystolic = item.get("patientPressureSystolic").toString();
        String patientPressureDiastolic = item.get("patientPressureDiastolic").toString();
        String patientPulse = item.get("patientPressureDiastolic").toString();
        String hfazscore = item.get("hfazscore").toString();
        String wfazscore = item.get("wfazscore").toString();
        String wfhzscore = item.get("wfhzscore").toString();

        String muac = item.get("muac").toString();
        String patientvisitid = item.get("patientVisitationId").toString();
        String patientBodySurfaceArea = item.get("patientBodySurfaceArea").toString();
        String patientRespirationRate = item.get("patientRespirationRate").toString();
        String patientTriageNotes = item.get("patientTriageNotes").toString();
        Long currStaffId = (Long) item.get("sessionActiveLoginStaffid");

        try {
            if ((patientTemperature) != null) {
                triage.setTemperature(Double.parseDouble(patientTemperature));
            }
        } catch (NumberFormatException ex) {
            //Player did the command wrong

        }
        try {
            if ((patientPressureSystolic) != null) {
                triage.setPatientpressuresystolic(Long.parseLong(patientPressureSystolic));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientPressureDiastolic) != null) {
                triage.setPatientpressurediastolic(Long.parseLong(patientPressureDiastolic));

            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientPulse) != null) {
                triage.setPulse(Integer.parseInt(patientPulse));

            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((muac) != null) {
                triage.setMuac(Double.parseDouble(muac));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientBodySurfaceArea) != null) {
                triage.setBodysurfacearea(Double.parseDouble(patientBodySurfaceArea));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientRespirationRate) != null) {
                triage.setRespirationrate(Integer.parseInt(patientRespirationRate));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientTriageNotes) != null) {
                triage.setNotes(patientTriageNotes);
            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientHeight) != null) {
                triage.setHeight(Double.parseDouble(patientHeight));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientWeight) != null) {
                triage.setWeight(Double.parseDouble(patientWeight));
            }
        } catch (NumberFormatException ex) {
        }

        triage.setAddedby(currStaffId);
        triage.setDateadded(new Date());

        triage.setPatientvisitid(Long.parseLong(patientvisitid));
        triage = (Triage) genericClassService.saveOrUpdateRecordLoadObject(triage);
        if (triage != null) {
            Zscores savezscore = new Zscores();
            savezscore.setTriageid(Long.parseLong(triage.getTriageid().toString()));
            try {
                if ((hfazscore) != null) {
                    savezscore.setHeightforage(hfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((wfazscore) != null) {
                    savezscore.setWeightforage(wfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((wfhzscore) != null) {
                    savezscore.setWeightforheight(wfhzscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong
            }
            genericClassService.saveOrUpdateRecordLoadObject(savezscore);
        }

        return "";
    }

    @RequestMapping(value = "/savePatientTriagegg", method = RequestMethod.POST)
    public @ResponseBody
    String savePatientTriagegg(Model model, HttpServletRequest request) {

        Map<String, Object> item = null;
        try {
            item = new ObjectMapper().readValue(request.getParameter("value"), Map.class);
        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }
        Triage triage = new Triage();
        String patientWeight = item.get("patientWeight").toString();
        String patientTemperature = item.get("patientTemperature").toString();
        String patientHeight = item.get("patientHeight").toString();
        String patientPressureSystolic = item.get("patientPressureSystolic").toString();
        String patientPressureDiastolic = item.get("patientPressureDiastolic").toString();
        String patientPulse = item.get("patientPressureDiastolic").toString();
        String hfazscore = item.get("hfazscore").toString();
        String wfazscore = item.get("wfazscore").toString();
        String BMIagegirls = item.get("BMIagegirls").toString();
        String muac = item.get("muac").toString();
        String patientvisitid = item.get("patientVisitationId").toString();
        String patientBodySurfaceArea = item.get("patientBodySurfaceArea").toString();
        String patientRespirationRate = item.get("patientRespirationRate").toString();
        String patientTriageNotes = item.get("patientTriageNotes").toString();
        Long currStaffId = (Long) item.get("sessionActiveLoginStaffid");

        try {
            if ((patientTemperature) != null) {
                triage.setTemperature(Double.parseDouble(patientTemperature));
            }
        } catch (NumberFormatException ex) {
            //Player did the command wrong

        }
        try {
            if ((patientPressureSystolic) != null) {
                triage.setPatientpressuresystolic(Long.parseLong(patientPressureSystolic));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientPressureDiastolic) != null) {
                triage.setPatientpressurediastolic(Long.parseLong(patientPressureDiastolic));

            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientPulse) != null) {
                triage.setPulse(Integer.parseInt(patientPulse));

            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((muac) != null) {
                triage.setMuac(Double.parseDouble(muac));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientBodySurfaceArea) != null) {
                triage.setBodysurfacearea(Double.parseDouble(patientBodySurfaceArea));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientRespirationRate) != null) {
                triage.setRespirationrate(Integer.parseInt(patientRespirationRate));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientTriageNotes) != null) {
                triage.setNotes(patientTriageNotes);
            }
        } catch (NumberFormatException ex) {
        }

        try {
            if ((patientHeight) != null) {
                triage.setHeight(Double.parseDouble(patientHeight));
            }
        } catch (NumberFormatException ex) {
        }
        try {
            if ((patientWeight) != null) {
                triage.setWeight(Double.parseDouble(patientWeight));
            }
        } catch (NumberFormatException ex) {
        }

        triage.setAddedby(currStaffId);
        triage.setDateadded(new Date());

        triage.setPatientvisitid(Long.parseLong(patientvisitid));
        triage = (Triage) genericClassService.saveOrUpdateRecordLoadObject(triage);
        if (triage != null) {
            Zscores savezscore = new Zscores();
            savezscore.setTriageid(Long.parseLong(triage.getTriageid().toString()));
            try {
                if ((hfazscore) != null) {
                    savezscore.setHeightforage(hfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((wfazscore) != null) {
                    savezscore.setWeightforage(wfazscore);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong

            }
            try {
                if ((BMIagegirls) != null) {
                    savezscore.setBmi(BMIagegirls);
                }
            } catch (NumberFormatException ex) {
                //Player did the command wrong
            }
            genericClassService.saveOrUpdateRecordLoadObject(savezscore);
        }

        return "";
    }

    @RequestMapping(value = "/paedconsultation", method = RequestMethod.GET)
    public String paedconsultation(Model model, HttpServletRequest request) {
        Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        model.addAttribute("unit", facilityunitId);
        return "patientsManagement/paediatrics/consultation/paedconsultation";
    }

    @RequestMapping(value = "/patientinqueuedetails.htm", method = RequestMethod.GET)
    public String patientinqueuedetails(Model model, HttpServletRequest request) {

        String[] params = {"patientid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")))};
        String[] fields = {"personid", "firstname", "lastname", "othernames", "patientno", "nextofkincontact", "nextofkin"};
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

            DateTimeFormatter dtformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate today = LocalDate.now();
            LocalDate birthday = LocalDate.parse(formatter.format((Date) patientdetails.get(0)[0]), dtformatter);
            Period p = Period.between(birthday, today);
            model.addAttribute("years", p.getYears());
            model.addAttribute("months", p.getMonths());
            model.addAttribute("days", p.getDays());
            int totalmonth = (p.getYears() * 12) + p.getMonths();

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
            model.addAttribute("consultationtotalmonths", totalmonth);
        }

        String[] params1 = {"patientvisitid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("patientvisitid"))};
        String[] fields1 = {"weight", "temperature", "height", "pulse", "muac", "bodysurfacearea", "respirationrate", "patientpressuresystolic", "patientpressurediastolic", "triageid"};
        String where1 = "WHERE patientvisitid=:patientvisitid";
        List<Object[]> patienttriages = (List<Object[]>) genericClassService.fetchRecord(Triage.class, fields1, where1, params1, paramsValues1);
        if (patienttriages != null) {
            String[] params2 = {"triageid"};
            Object[] paramsValues2 = {(Long) patienttriages.get(0)[9]};
            String[] field2 = {"zscoresid", "weightforage", "heightforage", "weightforheight", "bmi"};
            List<Object[]> patients = (List<Object[]>) genericClassService.fetchRecord(Zscores.class, field2, "WHERE triageid=:triageid", params2, paramsValues2);
            if (patients != null) {
                model.addAttribute("zscoresid", patients.get(0)[0]);
                
                if (patients.get(0)[4] != null) {
                    model.addAttribute("bmiforage", patients.get(0)[4]);
                } else {
                    model.addAttribute("bmiforage", "pending");
                }
                if (patients.get(0)[1] != null) {
                    model.addAttribute("wfazscore", patients.get(0)[1]);
                } else {
                    model.addAttribute("wfazscore", "pending");
                }
                if (patients.get(0)[2] != null) {
                    model.addAttribute("hfazscore", patients.get(0)[2]);
                } else {
                    model.addAttribute("hfazscore", "pending");
                }
                if (patients.get(0)[3] != null) {
                    model.addAttribute("wfhzscore", patients.get(0)[3]);
                } else {
                    model.addAttribute("wfhzscore", "pending");
                }
            }

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
                model.addAttribute("muac", patienttriages.get(0)[4]);
            } else {
                model.addAttribute("muac", 0);
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
            model.addAttribute("bmiforage", "pending");
            model.addAttribute("systolic", 0);
            model.addAttribute("diastolic", 0);
            model.addAttribute("respirationrate", 0);
            model.addAttribute("bodysurfacearea", 0);
            model.addAttribute("muac", 0);
            model.addAttribute("pulse", 0);
            model.addAttribute("height", 0);
            model.addAttribute("temperature", 0);
            model.addAttribute("weight", 0);
            model.addAttribute("wfazscore", "pending");
            model.addAttribute("hfazscore", "pending");
            model.addAttribute("wfhzscore", "pending");
        }
        return "patientsManagement/paediatrics/consultation/paedvitals";
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
        if ("muac".equals(request.getParameter("type"))) {
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid"))};
            String[] fields = {"triageid"};
            List<Long> triageid = (List<Long>) genericClassService.fetchRecord(Triage.class, fields, "WHERE patientvisitid=:patientvisitid", params, paramsValues);
            if (triageid != null) {
                String[] columns = {"muac"};
                Object[] columnValues = {Double.parseDouble(request.getParameter("Muac"))};
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

    @RequestMapping(value = "/updatewfazscore", method = RequestMethod.POST)
    public @ResponseBody
    String updatewfazscore(Model model, HttpServletRequest request) {
        String results = "";
        BigInteger zscoresid =BigInteger.valueOf(Long.parseLong(request.getParameter("zscoresidpaed")));
        String[] columns = {"weightforage"};
        Object[] columnValues = {(request.getParameter("wfazscore"))};
        String pk = "zscoresid";
        Object pkValue =zscoresid ;
        int result = genericClassService.updateRecordSQLSchemaStyle(Zscores.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            results = "success";
        }

        return results;
    }

    @RequestMapping(value = "/updatehfazscore", method = RequestMethod.POST)
    public @ResponseBody
    String updatehfazscore(Model model, HttpServletRequest request) {
        String results = "";
        BigInteger zscoresidpaed =BigInteger.valueOf(Long.parseLong(request.getParameter("zscoresidpaed")));
        String[] columns = {"heightforage"};
        Object[] columnValues = {(request.getParameter("hfazscore"))};
        String pk = "zscoresid";
        Object pkValue =zscoresidpaed ;
        int result = genericClassService.updateRecordSQLSchemaStyle(Zscores.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/updatewfhzscore", method = RequestMethod.POST)
    public @ResponseBody
    String updatewfhzscore(Model model, HttpServletRequest request) {
       String results = "";
        BigInteger zscoresidpaed =BigInteger.valueOf(Long.parseLong(request.getParameter("zscoresidpaed")));
        String[] columns = {"weightforheight"};
        Object[] columnValues = {(request.getParameter("wfhzscore"))};
        String pk = "zscoresid";
        Object pkValue =zscoresidpaed ;
        int result = genericClassService.updateRecordSQLSchemaStyle(Zscores.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            results = "success";
        }
        return results; 
    }

    @RequestMapping(value = "/updatebmi", method = RequestMethod.POST)
    public @ResponseBody
    String updatebmi(Model model, HttpServletRequest request) {
        String results = "";
        BigInteger zscoresidpaed =BigInteger.valueOf(Long.parseLong(request.getParameter("zscoresidpaed")));
        String[] columns = {"bmi"};
        Object[] columnValues = {(request.getParameter("bmi"))};
        String pk = "zscoresid";
        Object pkValue =zscoresidpaed ;
        int result = genericClassService.updateRecordSQLSchemaStyle(Zscores.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/BMIFAobservationgirls", method = RequestMethod.POST)
    public @ResponseBody
    String BMIFAobservationgirls(HttpServletRequest request) {
        String results = "";
        try {
            int monthsintotal = Integer.parseInt(request.getParameter("monthsintotal")) + 1;
            Double patientbmi = Double.parseDouble(request.getParameter("patientbmi"));
            if (Objects.equals(patientbmi, "pending")) {
                results = "";
            }
            //
            String file = "/home/iicsReports/z_scores.xlsx";
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet worksheet = workbook.getSheet("Bmifa_for_girls");
            XSSFRow row1 = worksheet.getRow(monthsintotal);
            if (row1 == null) {
                results = "";
            } else {
                XSSFCell cellA1 = row1.getCell(0);
                Double months = cellA1.getNumericCellValue();
                XSSFCell cellB1 = row1.getCell(3);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(4);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(5);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(6);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(7);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(8);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(9);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(10);
                Double normal3sd = cellI1.getNumericCellValue();
                if (patientbmi > normal3sd) {
                    results = "Obese";
                }
                if (patientbmi > normal2sd && patientbmi <= normal3sd) {
                    results = "Over weight";
                }
                if (patientbmi > normal1sd && patientbmi <= normal2sd) {
                    results = "Over Weight Risk";
                }
                if (patientbmi <= normal && patientbmi >= neg2sd) {
                    results = "Normal";
                }
                if (patientbmi < normal2sd && patientbmi >= normal3sd) {
                    results = "Wasted";
                }
                if (patientbmi > normal3sd) {
                    results = "Severely Wasted";
                }
            }

        } catch (IOException ex) {
            results = "";
        }

        return results;
    }

    @RequestMapping(value = "/BMIFAobservationboys", method = RequestMethod.POST)
    public @ResponseBody
    String BMIFAobservationboys(HttpServletRequest request) {
        String results = "";
        try {
            int monthsintotal = Integer.parseInt(request.getParameter("monthsintotal")) + 1;
            Double patientbmi = Double.parseDouble(request.getParameter("patientbmi"));
            //
            String file = "/home/iicsReports/z_scores.xlsx";
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet worksheet = workbook.getSheet("Bmifa-for-boys");
            XSSFRow row1 = worksheet.getRow(monthsintotal);
            if (row1 == null) {
                results = "";
            } else {
                XSSFCell cellA1 = row1.getCell(0);
                Double months = cellA1.getNumericCellValue();
                XSSFCell cellB1 = row1.getCell(3);
                Double standardDeviation = cellB1.getNumericCellValue();
                XSSFCell cellC1 = row1.getCell(4);
                Double neg3sd = cellC1.getNumericCellValue();
                XSSFCell cellD1 = row1.getCell(5);
                Double neg2sd = cellD1.getNumericCellValue();
                XSSFCell cellE1 = row1.getCell(6);
                Double neg1sd = cellE1.getNumericCellValue();
                XSSFCell cellF1 = row1.getCell(7);
                Double normal = cellF1.getNumericCellValue();
                XSSFCell cellG1 = row1.getCell(8);
                Double normal1sd = cellG1.getNumericCellValue();
                XSSFCell cellH1 = row1.getCell(9);
                Double normal2sd = cellH1.getNumericCellValue();
                XSSFCell cellI1 = row1.getCell(10);
                Double normal3sd = cellI1.getNumericCellValue();
                if (patientbmi > normal3sd) {
                    results = "Obese";
                }
                if (patientbmi > normal2sd && patientbmi <= normal3sd) {
                    results = "Over weight";
                }
                if (patientbmi > normal1sd && patientbmi <= normal2sd) {
                    results = "Over Weight Risk";
                }
                if (patientbmi <= normal && patientbmi >= neg2sd) {
                    results = "Normal";
                }
                if (patientbmi < normal2sd && patientbmi >= normal3sd) {
                    results = "Wasted";
                }
                if (patientbmi > normal3sd) {
                    results = "Severely Wasted";
                }
            }

        } catch (IOException ex) {
            Logger.getLogger(paediatrics.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

}
