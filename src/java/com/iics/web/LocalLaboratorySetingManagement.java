/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.patient.Laboratorytest;
import com.iics.patient.Labtestclassification;
import com.iics.patient.Testmethod;
import com.iics.service.GenericClassService;
import java.text.DateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/locallaboratorysetingmanagement")
public class LocalLaboratorySetingManagement {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/labTestsClassification.htm", method = RequestMethod.GET)
    public String addnewLabTestClassification(Model model, HttpServletRequest request) {
        List<Map> labClassificationsList = new ArrayList<>();

        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"labtestclassificationid", "labtestclassificationname"};
        List<Object[]> labtestsclassifications = (List<Object[]>) genericClassService.fetchRecord(Labtestclassification.class, fields, "WHERE parentid IS NULL AND isactive=TRUE", params, paramsValues);
        if (labtestsclassifications != null) {
            Map<String, Object> classificationsRow;
            for (Object[] labtestsclassification : labtestsclassifications) {
                classificationsRow = new HashMap<>();
                classificationsRow.put("labtestclassificationid", labtestsclassification[0]);
                classificationsRow.put("labtestclassificationname", labtestsclassification[1]);

                String[] params1 = {"parentid"};
                Object[] paramsValues1 = {labtestsclassification[0]};
                String[] fields1 = {"labtestclassificationid", "labtestclassificationname"};
                List<Object[]> labtestsclassificationsubs = (List<Object[]>) genericClassService.fetchRecord(Labtestclassification.class, fields1, "WHERE parentid=:parentid", params1, paramsValues1);
                List<Map> labClassificationsSubList = new ArrayList<>();

                if (labtestsclassificationsubs != null) {
                    Map<String, Object> classificationRow;
                    for (Object[] labtestsclassificationsub : labtestsclassificationsubs) {
                        classificationRow = new HashMap<>();
                        classificationRow.put("labtestclassificationid", labtestsclassificationsub[0]);
                        classificationRow.put("labtestclassificationname", labtestsclassificationsub[1]);
                        labClassificationsSubList.add(classificationRow);
                    }
                }
                classificationsRow.put("size", labClassificationsSubList.size());
                classificationsRow.put("labtestsclassificationsub", labClassificationsSubList);
                labClassificationsList.add(classificationsRow);
            }
        }
        model.addAttribute("labClassificationsList", labClassificationsList);
        return "controlPanel/localSettingsPanel/Labaratory/LabaratoryHome";
    }

    @RequestMapping(value = "/laboratoryCategoryTestshome.htm", method = RequestMethod.GET)
    public String laboratoryHome(Model model, HttpServletRequest request) {
        List<Map> laboratorytestclassificationsList = new ArrayList<>();
        String[] params = {"parentid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("labtestclassificationid"))};
        String[] fields = {"labtestclassificationid", "labtestclassificationname", "description", "isactive"};
        List<Object[]> labaratoryclassifications = (List<Object[]>) genericClassService.fetchRecord(Labtestclassification.class, fields, "WHERE parentid=:parentid", params, paramsValues);
        if (labaratoryclassifications != null) {
            model.addAttribute("act", "a");
            Map<String, Object> labaratoryclassificationsRow;
            for (Object[] labaratoryclassification : labaratoryclassifications) {
                labaratoryclassificationsRow = new HashMap<>();
                labaratoryclassificationsRow.put("labtestclassificationid", labaratoryclassification[0]);
                labaratoryclassificationsRow.put("labtestclassificationname", labaratoryclassification[1]);
                labaratoryclassificationsRow.put("description", labaratoryclassification[2]);
                labaratoryclassificationsRow.put("isactive", labaratoryclassification[3]);
                laboratorytestclassificationsList.add(labaratoryclassificationsRow);
            }

        } else {
            String[] params1 = {"labtestclassificationid"};
            Object[] paramsValues1 = {Long.parseLong(request.getParameter("labtestclassificationid"))};
            String[] fields1 = {"laboratorytestid", "testname", "testmethodid","unitofmeasure","testrange"};
            List<Object[]> labtestsclassificationsubs = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields1, "WHERE labtestclassificationid=:labtestclassificationid", params1, paramsValues1);
            if (labtestsclassificationsubs != null) {
                model.addAttribute("act", "b");
                Map<String, Object> labaratoryclassificationsRow;
                for (Object[] labtestsclassificationsub : labtestsclassificationsubs) {
                    labaratoryclassificationsRow = new HashMap<>();
                    labaratoryclassificationsRow.put("laboratorytestid", labtestsclassificationsub[0]);
                    labaratoryclassificationsRow.put("testname", labtestsclassificationsub[1]);
                    
                    labaratoryclassificationsRow.put("unitofmeasure", labtestsclassificationsub[3]);
                    labaratoryclassificationsRow.put("testrange", labtestsclassificationsub[4]);
                    if (labtestsclassificationsub[2] != null) {

                        String[] params3 = {"testmethodid"};
                        Object[] paramsValues3 = {labtestsclassificationsub[2]};
                        String[] fields3 = {"testmethodname"};
                        List<String> labtestsmethods = (List<String>) genericClassService.fetchRecord(Testmethod.class, fields3, "WHERE testmethodid=:testmethodid", params3, paramsValues3);
                        if (labtestsmethods != null) {
                            labaratoryclassificationsRow.put("testmethod", labtestsmethods.get(0));
                        }
                    } else {
                        labaratoryclassificationsRow.put("testmethod", "N/A");
                    }
                    laboratorytestclassificationsList.add(labaratoryclassificationsRow);
                }
            } else {
                model.addAttribute("act", "c");
            }
        }
        model.addAttribute("laboratorytestclassificationsList", laboratorytestclassificationsList);
        model.addAttribute("size", laboratorytestclassificationsList.size());
        model.addAttribute("labtestclassificationid", request.getParameter("labtestclassificationid"));
        return "controlPanel/localSettingsPanel/Labaratory/views/categoryTests";
    }

    @RequestMapping(value = "/laboratoryTests.htm", method = RequestMethod.GET)
    public String laboratoryTests(Model model, HttpServletRequest request) {
        List<Map> laboratorytestsList = new ArrayList<>();
        String[] params1 = {"labtestclassificationid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("labtestclassificationid"))};
        String[] fields1 = {"laboratorytestid", "testname", "testmethodid","unitofmeasure","testrange"};
        List<Object[]> labtestsclassificationsubs = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields1, "WHERE labtestclassificationid=:labtestclassificationid", params1, paramsValues1);
        if (labtestsclassificationsubs != null) {
            Map<String, Object> labaratoryclassificationsRow;
            for (Object[] labtestsclassificationsub : labtestsclassificationsubs) {
                labaratoryclassificationsRow = new HashMap<>();
                labaratoryclassificationsRow.put("laboratorytestid", labtestsclassificationsub[0]);
                labaratoryclassificationsRow.put("testname", labtestsclassificationsub[1]);
                
                labaratoryclassificationsRow.put("unitofmeasure", labtestsclassificationsub[3]);
                labaratoryclassificationsRow.put("testrange", labtestsclassificationsub[4]);
                
                if (labtestsclassificationsub[2] != null) {

                    String[] params3 = {"testmethodid"};
                    Object[] paramsValues3 = {labtestsclassificationsub[2]};
                    String[] fields3 = {"testmethodname"};
                    List<String> labtestsmethods = (List<String>) genericClassService.fetchRecord(Testmethod.class, fields3, "WHERE testmethodid=:testmethodid", params3, paramsValues3);
                    if (labtestsmethods != null) {
                        labaratoryclassificationsRow.put("testmethod", labtestsmethods.get(0));
                    }
                } else {
                    labaratoryclassificationsRow.put("testmethod", "N/A");
                }
                laboratorytestsList.add(labaratoryclassificationsRow);
            }
        }
        model.addAttribute("laboratorytestsList", laboratorytestsList);
        model.addAttribute("labtestclassificationid", request.getParameter("labtestclassificationid"));
        return "controlPanel/localSettingsPanel/Labaratory/views/labTests";
    }

    @RequestMapping(value = "/addmethodTestProcedure.htm", method = RequestMethod.GET)
    public String addmethodTestProcedure(Model model, HttpServletRequest request) {
        List<Map> laboratorytestMethodsList = new ArrayList<>();
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"testmethodid", "testmethodname", "isactive"};
        List<Object[]> labtestsmethods = (List<Object[]>) genericClassService.fetchRecord(Testmethod.class, fields1, "", params1, paramsValues1);
        if (labtestsmethods != null) {
            Map<String, Object> labaratorytestMethodsRow;
            for (Object[] labtestsmethod : labtestsmethods) {
                labaratorytestMethodsRow = new HashMap<>();
                labaratorytestMethodsRow.put("testmethodid", labtestsmethod[0]);
                labaratorytestMethodsRow.put("testmethodname", labtestsmethod[1]);
                labaratorytestMethodsRow.put("isactive", labtestsmethod[2]);
                laboratorytestMethodsList.add(labaratorytestMethodsRow);
            }
        }
        model.addAttribute("laboratorytestMethodsList", laboratorytestMethodsList);
        return "controlPanel/localSettingsPanel/Labaratory/testMethodsorProcedures/testMethods";
    }

    @RequestMapping(value = "/addmethodTestProcedureform.htm", method = RequestMethod.GET)
    public String addmethodTestProcedureform(Model model, HttpServletRequest request) {
        return "controlPanel/localSettingsPanel/Labaratory/testMethodsorProcedures/forms/addTestMethods";
    }

    @RequestMapping(value = "/addnewlaboratoryclassificationsform.htm", method = RequestMethod.GET)
    public String addnewlaboratoryclassificationsform(Model model, HttpServletRequest request) {

        return "controlPanel/localSettingsPanel/Labaratory/forms/addNewLabClassification";
    }

    @RequestMapping(value = "/addnewLaboratoryTests.htm", method = RequestMethod.GET)
    public String addnewLaboratoryTests(Model model, HttpServletRequest request) {
        List<Map> laboratorytestMethodsList = new ArrayList<>();
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"testmethodid", "testmethodname", "isactive"};
        List<Object[]> labtestsmethods = (List<Object[]>) genericClassService.fetchRecord(Testmethod.class, fields1, "", params1, paramsValues1);
        if (labtestsmethods != null) {
            Map<String, Object> labaratorytestMethodsRow;
            for (Object[] labtestsmethod : labtestsmethods) {
                labaratorytestMethodsRow = new HashMap<>();
                labaratorytestMethodsRow.put("testmethodid", labtestsmethod[0]);
                labaratorytestMethodsRow.put("testmethodname", labtestsmethod[1]);
                labaratorytestMethodsRow.put("isactive", labtestsmethod[2]);
                laboratorytestMethodsList.add(labaratorytestMethodsRow);
            }
        }
        model.addAttribute("laboratorytestMethodsList", laboratorytestMethodsList);
        model.addAttribute("labSubCategoryid", request.getParameter("labSubCategoryid"));
        return "controlPanel/localSettingsPanel/Labaratory/forms/addnewLaboratoryTests";
    }

    @RequestMapping(value = "/addClassificationLabTests.htm")
    public @ResponseBody
    String addClassificationLabTests(HttpServletRequest request) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Laboratorytest laboratorytest = new Laboratorytest();
            laboratorytest.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            laboratorytest.setDateadded(new Date());
            laboratorytest.setDescription(request.getParameter("desc"));
            laboratorytest.setUnitofmeasure(request.getParameter("testunits"));
            if (!"".equals(request.getParameter("testmethod"))) {
                laboratorytest.setTestmethodid(Long.parseLong(request.getParameter("testmethod")));
            }
            laboratorytest.setTestname(request.getParameter("testname"));
            laboratorytest.setLabtestclassificationid(Long.parseLong(request.getParameter("classifid")));

            Object save = genericClassService.saveOrUpdateRecordLoadObject(laboratorytest);
            if (save != null) {
                results = String.valueOf(laboratorytest.getLaboratorytestid());
            } else {
                results = "failed";
            }
        } else {
            results = "reload";
        }
        return results;
    }

    @RequestMapping(value = "/deleteClassificationLabTests.htm")
    public @ResponseBody
    String deleteClassificationLabTests(HttpServletRequest request) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"laboratorytestid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("laboratorytestid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.laboratorytest", columns, columnValues);
            if (result != 0) {
                results = "delete";
            }
        } else {
            results = "reload";
        }
        return results;
    }

    @RequestMapping(value = "/addnewLabClassifications.htm")
    public @ResponseBody
    String addnewLabClassifications(HttpServletRequest request) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Labtestclassification labtestclassification = new Labtestclassification();
            labtestclassification.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            labtestclassification.setDateadded(new Date());
            labtestclassification.setDescription(request.getParameter("description"));
            labtestclassification.setIsactive(Boolean.TRUE);
            labtestclassification.setLabtestclassificationname(request.getParameter("classificationname"));
            Object save = genericClassService.saveOrUpdateRecordLoadObject(labtestclassification);

            if (save != null) {
                results = String.valueOf(labtestclassification.getLabtestclassificationid());
            }
        } else {
            results = "reload";
        }
        return results;
    }

    @RequestMapping(value = "/deleteLabClassTestes.htm")
    public @ResponseBody
    String deleteLabClassTestes(HttpServletRequest request) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"labtestclassificationid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("labtestclassificationid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.labtestclassification", columns, columnValues);
            if (result != 0) {
                results = "delete";
            }
        } else {
            results = "reload";
        }
        return results;
    }

    @RequestMapping(value = "/addClassificationSubCategory.htm", method = RequestMethod.GET)
    public String addClassificationSubCategory(Model model, HttpServletRequest request) {
        model.addAttribute("labtestclassificationid", request.getParameter("labtestclassificationid"));
        return "controlPanel/localSettingsPanel/Labaratory/forms/addNewLabClassificationSubCategory";
    }

    @RequestMapping(value = "/addLabClassificationSubCategory.htm")
    public @ResponseBody
    String addLabClassificationSubCategory(HttpServletRequest request) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Labtestclassification labtestclassification = new Labtestclassification();
            labtestclassification.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            labtestclassification.setDateadded(new Date());
            labtestclassification.setDescription(request.getParameter("description"));
            labtestclassification.setIsactive(Boolean.TRUE);
            labtestclassification.setLabtestclassificationname(request.getParameter("categoryname"));
            labtestclassification.setParentid(Long.parseLong(request.getParameter("classifid")));

            Object save = genericClassService.saveOrUpdateRecordLoadObject(labtestclassification);

            if (save != null) {
                results = String.valueOf(labtestclassification.getLabtestclassificationid());
            }
        } else {
            results = "reload";
        }
        return results;
    }

    @RequestMapping(value = "/saveaddmethodTestProcedureform.htm")
    public @ResponseBody
    String saveaddmethodTestProcedureform(HttpServletRequest request) {
        String results = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("methods"), List.class);
            if (!item.isEmpty()) {
                for (String items : item) {
                    Testmethod testmethod = new Testmethod();
                    testmethod.setTestmethodname(items);
                    testmethod.setIsactive(Boolean.TRUE);
                    genericClassService.saveOrUpdateRecordLoadObject(testmethod);
                }
            }
        } catch (Exception e) {

        }

        return results;
    }

    @RequestMapping(value = "/deletetestmethod.htm")
    public @ResponseBody
    String deletetestmethod(HttpServletRequest request) {
        String results = "";
        String[] params1 = {"testmethodid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("testmethodid"))};
        String[] fields1 = {"testname", "laboratorytestid"};
        List<Object[]> labtestsmethods = (List<Object[]>) genericClassService.fetchRecord(Laboratorytest.class, fields1, "WHERE testmethodid=:testmethodid", params1, paramsValues1);
        if (labtestsmethods != null) {
            results = "not";
        } else {
            String[] columns = {"testmethodid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("testmethodid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.testmethod", columns, columnValues);
            if (result != 0) {
                results = "delete";
            }
        }
        return results;
    }
}
