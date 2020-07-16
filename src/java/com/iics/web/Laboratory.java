/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Facilityunitsupplier;
import com.iics.controlpanel.Systemmodule;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Locations;
import com.iics.domain.Person;
import com.iics.domain.Searchstaff;
import com.iics.patient.Laboratoryrequest;
import com.iics.patient.Laboratoryrequesttest;
import com.iics.patient.Laboratorytest;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Searchpatient;
import com.iics.service.GenericClassService;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import static com.iics.web.Stock.loadFileAsBytesArray;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
@RequestMapping("/laboratory")
public class Laboratory {

    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/laboratoryhome.htm", method = RequestMethod.GET)
    public String laboratoryhome(Model model, HttpServletRequest request) {
        return "Laboratory/laboratoryHome";
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
            int year = Integer.parseInt(df.format((Date) patientdetails.get(0)[0]));
            int currentyear = Integer.parseInt(df.format(new Date()));
            model.addAttribute("estimatedage", currentyear - year);

            model.addAttribute("patientvisitid", request.getParameter("patientvisitid"));
            model.addAttribute("visitnumber", request.getParameter("visitnumber"));
            model.addAttribute("patientid", request.getParameter("patientid"));
        }
        return "Laboratory/views/patientLabRequests";
    }

    @RequestMapping(value = "/laboratorypatientstests.htm", method = RequestMethod.GET)
    public String laboratorypatientstests(Model model, HttpServletRequest request) {

        String[] params = {"patientvisitid", "status"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("patientvisitid")), "SENT"};
        String[] fields = {"laboratoryrequestid", "laboratoryrequestnumber", "originunit", "addedby"};
        List<Object[]> patientsvisitlabtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields, "WHERE patientvisitid=:patientvisitid AND status=:status", params, paramsValues);
        if (patientsvisitlabtests != null) {
            model.addAttribute("laboratoryrequestnumber", patientsvisitlabtests.get(0)[1]);
            model.addAttribute("laboratoryrequestid", patientsvisitlabtests.get(0)[0]);

            String[] params6 = {"facilityunitid"};
            Object[] paramsValues6 = {patientsvisitlabtests.get(0)[2]};
            String[] fields6 = {"facilityunitname", "shortname"};
            List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, "WHERE facilityunitid=:facilityunitid", params6, paramsValues6);
            if (facilityunits != null) {
                model.addAttribute("facilityunitname", facilityunits.get(0)[0]);
            }
            String[] params1 = {"staffid"};
            Object[] paramsValues1 = {patientsvisitlabtests.get(0)[3]};
            String[] fields1 = {"firstname", "othernames", "lastname"};
            List<Object[]> staffdetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields1, "WHERE staffid=:staffid", params1, paramsValues1);
            if (staffdetails != null) {
                model.addAttribute("staffdetails", staffdetails.get(0)[0] + " " + staffdetails.get(0)[1] + " " + staffdetails.get(0)[2]);
            }

        }

        return "Laboratory/forms/laboratoryPatientTests";
    }

    @RequestMapping(value = "/laboratorypatientrequestedtests.htm", method = RequestMethod.GET)
    public String laboratorypatientrequestedtests(Model model, HttpServletRequest request) {
        List<Map> testslist = new ArrayList<>();

        Set<Long> tests = new HashSet<>();
        try {
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("patienttestresults"), List.class);
            for (Integer itemid : item) {
                tests.add(Long.parseLong(String.valueOf(itemid)));
            }

            String[] params2 = {"laboratoryrequestid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("laboratoryrequest"))};
            String[] fields2 = {"laboratoryrequesttestid", "laboratorytestid"};
            List<Object[]> laboratorys = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields2, "WHERE laboratoryrequestid=:laboratoryrequestid", params2, paramsValues2);
            if (laboratorys != null) {
                Map<String, Object> testsRow;
                for (Object[] laboratory : laboratorys) {
                    testsRow = new HashMap<>();

                    String[] params7 = {"laboratorytestid"};
                    Object[] paramsValues7 = {laboratory[1]};
                    String[] fields7 = {"testname", "dateadded"};
                    List<Object[]> testname = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields7, "WHERE laboratorytestid=:laboratorytestid", params7, paramsValues7);
                    if (testname != null) {
                        if (tests.isEmpty() || !tests.contains((Long) laboratory[0])) {
                            testsRow.put("laboratoryrequesttestid", laboratory[0]);
                            testsRow.put("testname", testname.get(0)[0]);
                            testslist.add(testsRow);
                        }
                    }
                }
            }
            model.addAttribute("testslist", testslist);

        } catch (Exception e) {
        }
        return "Laboratory/forms/laboratoryRequestTest";
    }

    @RequestMapping(value = "/patientlaboratoryrequesttestsnumber.htm")
    public @ResponseBody
    String patientlaboratoryrequesttestsnumber(HttpServletRequest request) {
        String results = "";
        String[] params2 = {"laboratoryrequestid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("laboratoryrequestid"))};
        String[] fields2 = {"laboratoryrequesttestid", "laboratorytestid"};
        List<Object[]> laboratorys = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields2, "WHERE laboratoryrequestid=:laboratoryrequestid", params2, paramsValues2);
        if (laboratorys != null) {
            results = String.valueOf(laboratorys.size());
        } else {
            results = String.valueOf(0);
        }
        return results;
    }

    @RequestMapping(value = "/submitlabResults.htm")
    public @ResponseBody
    String submitlabResults(HttpServletRequest request) {
        String results = "";
        try {
            List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("tests"), List.class);
            for (Map item1 : item) {
                Map<String, Object> map = (HashMap) item1;
                String[] columns = {"testresult", "lastupdated", "lastupdatedby", "comment", "iscompleted"};
                Object[] columnValues = {(String) map.get("testresult"), new Date(), request.getSession().getAttribute("sessionActiveLoginStaffid"), (String) map.get("notes"), Boolean.TRUE};
                String pk = "laboratoryrequesttestid";
                Object pkValue = Long.parseLong(String.valueOf((Integer) map.get("laboratoryrequesttestid")));
                int result = genericClassService.updateRecordSQLSchemaStyle(Laboratoryrequesttest.class, columns, columnValues, pk, pkValue, "patient");

            }
            String[] columns1 = {"status", "lastupdatedby"};
            Object[] columnValues1 = {"SERVICED", request.getSession().getAttribute("sessionActiveLoginStaffid")};
            String pk1 = "laboratoryrequestid";
            Object pkValue1 = Long.parseLong(request.getParameter("laboratoryrequestid"));
            int result1 = genericClassService.updateRecordSQLSchemaStyle(Laboratoryrequest.class, columns1, columnValues1, pk1, pkValue1, "patient");

        } catch (Exception e) {
            System.out.println(":::::::::::::::::::::::::::" + e);
        }
        return results;
    }

    @RequestMapping(value = "/patientlabTestsResultsPrintOut.htm", method = RequestMethod.GET)
    public String unitResultsPrintOut(HttpServletRequest request, Model model, @ModelAttribute("unitid") Integer facilityUnit, @ModelAttribute("unit") String unit, @ModelAttribute("patientVisitsid") String patientVisitsid, @ModelAttribute("facility") String facility, @ModelAttribute("patientid") String patientid, @ModelAttribute("laboratoryrequestid") String laboratoryrequestid) {
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
            List<Map> labtestresultsFound = new ArrayList<>();
            String[] params2 = {"laboratoryrequestid", "iscompleted"};
            Object[] paramsValues2 = {Long.parseLong(laboratoryrequestid), Boolean.TRUE};
            String[] fields2 = {"laboratorytestid", "testresult", "lastupdatedby", "lastupdated"};
            String where2 = "WHERE laboratoryrequestid=:laboratoryrequestid AND iscompleted=:iscompleted";
            List<Object[]> labtests = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequesttest.class, fields2, where2, params2, paramsValues2);
            if (labtests != null) {
                Map<String, Object> itemsRows;
                for (Object[] labtest : labtests) {
                    itemsRows = new HashMap<>();

                    String[] params3 = {"laboratorytestid"};
                    Object[] paramsValues3 = {labtest[0]};
                    String[] fields3 = {"testname","unitofmeasure","testrange"};
                    String where3 = "WHERE laboratorytestid=:laboratorytestid";
                    List<Object[]> testname = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields3, where3, params3, paramsValues3);
                    if (testname != null) {
                        itemsRows.put("testname", testname.get(0)[0]);
                        itemsRows.put("unitofmeasure", testname.get(0)[1]);
                        itemsRows.put("testrange", testname.get(0)[2]);
                        itemsRows.put("testresult", labtest[1]);
                        itemsRows.put("lastupdated", formatter.format((Date) labtest[3]));

                        String[] params6 = {"staffid"};
                        Object[] paramsValues6 = {labtest[2]};
                        String[] fields6 = {"firstname", "lastname", "othernames"};
                        List<Object[]> lastupdatedby = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields6, "WHERE staffid=:staffid", params6, paramsValues6);
                        if (lastupdatedby != null) {
                            itemsRows.put("lastupdatedby", lastupdatedby.get(0)[0] + " " + lastupdatedby.get(0)[1] + " " + lastupdatedby.get(0)[2]);
                        }
                        labtestresultsFound.add(itemsRows);
                    }
                }
            }
            model.addAttribute("labtestResultsFound", labtestresultsFound);
            model.addAttribute("unit", unit.replace("@--@", " "));
            model.addAttribute("facility", facility.replace("@--@", " "));
            return "Laboratory/forms/laboratoryTestResultsPrintOut";
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::"+e);
            return "patientsManagement/unitRegister/dateError";
        }
    }

    @RequestMapping(value = "/printPatientLaboratoryTestResults.htm", method = RequestMethod.GET)
    public @ResponseBody
    String createLabReportPDF(HttpServletRequest request, Model model, @ModelAttribute("patientVisitsid") String patientVisitsid, @ModelAttribute("patientid") String patientid, @ModelAttribute("laboratoryrequestid") String laboratoryrequestid) {
        String baseEncode = "";
        String facility = ((Facility) request.getSession().getAttribute("sessionActiveLoginFacilityObj")).getFacilityname();
        String unit = ((Facilityunit) request.getSession().getAttribute("sessionActiveLoginFacilityUnitObj")).getFacilityunitname();
        Integer unitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        String url = IICS.BASE_URL + "laboratory/patientlabTestsResultsPrintOut.htm?unitid=" + unitid + "&unit=" + unit + "&patientVisitsid=" + patientVisitsid + "&facility=" + facility + "&patientid=" + patientid + "&laboratoryrequestid=" + laboratoryrequestid;
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
                file = new File("C:/iicsReports/patients/lab");
                path = "C:/iicsReports/patients/lab/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/patients/lab");
                path = "/home/iicsReports/patients/lab/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/patients/lab");
                path = "/Users/iicsReports/patients/lab/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
    }

    @RequestMapping(value = "/todayslaboratorypatientsregister.htm", method = RequestMethod.GET)
    public String todayslaboratorypatientsregister(Model model, HttpServletRequest request) {
        List<Map> labpatientsFound = new ArrayList<>();
        Set<BigInteger> patients = new HashSet<>();

        String[] params2 = {"dateadded", "status", "destinationunit"};
        Object[] paramsValues2 = {new Date(), "SERVICED", request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields2 = {"laboratoryrequestid", "patientvisitid"};
        String where2 = "WHERE dateadded=:dateadded AND status=:status AND destinationunit=:destinationunit";
        List<Object[]> patientsvisits = (List<Object[]>) genericClassService.fetchRecord(Laboratoryrequest.class, fields2, where2, params2, paramsValues2);
        if (patientsvisits != null) {
            for (Object[] patientsvisit : patientsvisits) {
                patients.add(BigInteger.valueOf((Long) patientsvisit[1]));
            }
        }
        if (!patients.isEmpty()) {
            Map<String, Object> patient;
            for (BigInteger patientvisit : patients) {
                patient = new HashMap<>();
                String[] params = {"facilityunitid", "patientvisitid"};
                Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), patientvisit};
                String[] fields = {"fullname", "visitnumber", "gender", "age", "parishname", "villagename"};
                String where = "WHERE facilityunitid=:facilityunitid AND patientvisitid=:patientvisitid";
                List<Object[]> visits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
                if (visits != null) {
                    Object[] visit = visits.get(0);
                    patient.put("names", visit[0]);
                    patient.put("visitno", visit[1]);
                    patient.put("gender", visit[2]);
                    patient.put("age", visit[3]);
                    patient.put("parish", visit[4]);
                    patient.put("village", visit[5]);

                    labpatientsFound.add(patient);
                }

            }
        }
        model.addAttribute("date", formatter.format(new Date()));
        model.addAttribute("labpatientsFound", labpatientsFound);
        return "Laboratory/register/views/todayPatients";
    }
}
