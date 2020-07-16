/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.patient.Disease;
import com.iics.patient.Diseasecategory;
import com.iics.patient.Diseaseclassification;
import com.iics.patient.Diseasesymptom;
import com.iics.patient.Symptom;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
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
 * @author IICS-GRACE
 */
@Controller
@RequestMapping("/consultation")
public class ClinicalGuideLines {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/consultationhome.htm", method = RequestMethod.GET)
    public String consultationhome(Model model, HttpServletRequest request) {

        List<Map> diseaseClassificationList = new ArrayList<>();
        String[] paramclassfn = {"status"};
        Object[] paramsValuesclassfn = {true};
        String whereclassfn = "WHERE status=:status";
        String[] fieldsclassfn = {"diseaseclassificationid", "classifficationname"};
        List<Object[]> objclassfication = (List<Object[]>) genericClassService.fetchRecord(Diseaseclassification.class, fieldsclassfn, whereclassfn, paramclassfn, paramsValuesclassfn);
        if (objclassfication != null) {
            Map<String, Object> diseaseClassification;
            for (Object[] classf : objclassfication) {
                diseaseClassification = new HashMap<>();
                diseaseClassification.put("diseaseclassificationid", (Long) classf[0]);
                diseaseClassification.put("classifficationname", (String) classf[1]);

                //Fetch Categories
                List<Map> diseaseClassificationCategoryList = new ArrayList<>();
                int categorysize = 0;
                String[] paramclassfncategory = {"diseaseclassificationid"};
                Object[] paramsValuesclassfncategory = {(Long) classf[0]};
                String whereclassfncategory = "WHERE diseaseclassificationid=:diseaseclassificationid";
                String[] fieldsclassfncategory = {"diseasecategoryid", "diseasecategoryname"};
                List<Object[]> objclassfncategory = (List<Object[]>) genericClassService.fetchRecord(Diseasecategory.class, fieldsclassfncategory, whereclassfncategory, paramclassfncategory, paramsValuesclassfncategory);
                if (objclassfncategory != null) {
                    Map<String, Object> diseaseDiseaseClassfnCategories;
                    for (Object[] classfncategry : objclassfncategory) {
                        diseaseDiseaseClassfnCategories = new HashMap<>();

                        diseaseDiseaseClassfnCategories.put("diseasecategoryid", (Long) classfncategry[0]);
                        diseaseDiseaseClassfnCategories.put("diseasecategoryname", (String) classfncategry[1]);

                        //Fetch Diseases
                        List<Map> diseaseClassificationCategoryDiseaseList = new ArrayList<>();
                        int categoryDisease = 0;
                        String[] paramclassfncategorydisease = {"diseasecategoryid"};
                        Object[] paramsValuesclassfncategorydisease = {(Long) classfncategry[0]};
                        String whereclassfncategorydisease = "WHERE diseasecategoryid=:diseasecategoryid";
                        String[] fieldsclassfncategorydisease = {"diseaseid", "diseasename", "description", "diseasecode"};
                        List<Object[]> objclassfncategorydisease = (List<Object[]>) genericClassService.fetchRecord(Disease.class, fieldsclassfncategorydisease, whereclassfncategorydisease, paramclassfncategorydisease, paramsValuesclassfncategorydisease);
                        if (objclassfncategorydisease != null) {
                            Map<String, Object> diseaseDiseaseClassfnCategoriesdisease;
                            for (Object[] classfncategrydisease : objclassfncategorydisease) {
                                diseaseDiseaseClassfnCategoriesdisease = new HashMap<>();

                                diseaseDiseaseClassfnCategoriesdisease.put("diseaseid", (Long) classfncategrydisease[0]);
                                diseaseDiseaseClassfnCategoriesdisease.put("diseasename", (String) classfncategrydisease[1]);
                                diseaseDiseaseClassfnCategoriesdisease.put("description", (String) classfncategrydisease[2]);
                                diseaseDiseaseClassfnCategoriesdisease.put("diseasecode", (String) classfncategrydisease[3]);
                                diseaseClassificationCategoryDiseaseList.add(diseaseDiseaseClassfnCategoriesdisease);
                            }
                        }
                        categoryDisease = diseaseClassificationCategoryDiseaseList.size();
                        diseaseDiseaseClassfnCategories.put("diseaseClassificationCategoryDiseaseListsize", categoryDisease);
                        diseaseDiseaseClassfnCategories.put("diseaseClassificationCategoryDiseaseList", diseaseClassificationCategoryDiseaseList);
                        diseaseClassificationCategoryList.add(diseaseDiseaseClassfnCategories);
                    }
                }
                categorysize = diseaseClassificationCategoryList.size();
                diseaseClassification.put("diseaseCategories", diseaseClassificationCategoryList);
                diseaseClassification.put("diseaseCategoriessize", categorysize);
                diseaseClassificationList.add(diseaseClassification);
            }
        }
        model.addAttribute("diseaseClassificationList", diseaseClassificationList);
        return "patientsManagement/consultation/consultationMainPane";
    }

    @RequestMapping(value = "/submitDiseaseClassification", method = RequestMethod.POST)
    public @ResponseBody
    String submitDiseaseClassification(Model model, HttpServletRequest request) {
        Diseaseclassification diseaseclassification = new Diseaseclassification();
        String classificationname = request.getParameter("diseaseclassification");
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        diseaseclassification.setClassifficationname(classificationname.toUpperCase());
        diseaseclassification.setCreatedby(currStaffId);
        diseaseclassification.setDatecreated(new Date());
        diseaseclassification.setStatus(true);
        genericClassService.saveOrUpdateRecordLoadObject(diseaseclassification);
        return "";
    }

    @RequestMapping(value = "/managediseaseclassificationcategories.htm", method = RequestMethod.GET)
    public String managediseaseclassificationcategories(Model model, HttpServletRequest request, @ModelAttribute("diseaseclassificationid") String diseaseclassificationid, @ModelAttribute("diseaseclassificationname") String diseaseclassificationname) {

        List<Map> diseaseCategoryList = new ArrayList<>();
        String[] paramcategory = {"diseaseclassificationid"};
        Object[] paramsValuescategory = {Long.parseLong(diseaseclassificationid)};
        String wherecategory = "WHERE diseaseclassificationid=:diseaseclassificationid";
        String[] fieldscategory = {"diseasecategoryid", "diseasecategoryname", "status"};
        List<Object[]> objcategory = (List<Object[]>) genericClassService.fetchRecord(Diseasecategory.class, fieldscategory, wherecategory, paramcategory, paramsValuescategory);
        if (objcategory != null) {
            Map<String, Object> diseaseDiseaseCategories;
            for (Object[] categry : objcategory) {
                diseaseDiseaseCategories = new HashMap<>();

                diseaseDiseaseCategories.put("diseasecategoryid", (Long) categry[0]);
                diseaseDiseaseCategories.put("diseasecategoryname", (String) categry[1]);
                diseaseDiseaseCategories.put("isactive", (Boolean) categry[2]);

                diseaseCategoryList.add(diseaseDiseaseCategories);
            }
        }
        model.addAttribute("diseaseCategoryList", diseaseCategoryList);
        model.addAttribute("diseaseclassificationid", diseaseclassificationid);
        model.addAttribute("diseaseclassificationname", diseaseclassificationname);
        return "patientsManagement/consultation/clinicalguidelines/views/manageDiseaseCategories";
    }

    @RequestMapping(value = "/activatedOrDeactivatedDiseaseCategory.htm")
    public @ResponseBody
    String activatedOrDeactivatedDiseaseCategory(Model model, HttpServletRequest request) {
        String response = "";
        if ("activate".equals(request.getParameter("type"))) {
            String[] columnsact = {"status"};
            Object[] columnValuesact = {true};
            String pkact = "diseasecategoryid";
            Object pkValueact = Long.parseLong(request.getParameter("diseasecategoryid"));
            int resultact = genericClassService.updateRecordSQLSchemaStyle(Diseasecategory.class, columnsact, columnValuesact, pkact, pkValueact, "patient");
            if (resultact != 0) {
                response = "success";
            }
        } else {
            String[] columnsdiact = {"status"};
            Object[] columnValuesdiact = {false};
            String pkdiact = "diseasecategoryid";
            Object pkValuediact = Long.parseLong(request.getParameter("diseasecategoryid"));
            int resultdiact = genericClassService.updateRecordSQLSchemaStyle(Diseasecategory.class, columnsdiact, columnValuesdiact, pkdiact, pkValuediact, "patient");
            if (resultdiact != 0) {
                response = "success";
            }
        }
        return response;
    }

    @RequestMapping(value = "/manageDiseaseCategories.htm", method = RequestMethod.GET)
    public String manageDiseaseCategories(Model model, HttpServletRequest request, @ModelAttribute("categoryid") String categoryid, @ModelAttribute("categoryname") String categoryname) {

        List<Map> diseaseDiseaseList = new ArrayList<>();
        String[] paramdisease = {"diseasecategoryid"};
        Object[] paramsValuesdisease = {Long.parseLong(categoryid)};
        String wheredisease = "WHERE diseasecategoryid=:diseasecategoryid";
        String[] fieldsdisease = {"diseaseid", "diseasename", "description", "status", "diseasecode"};
        List<Object[]> objdisease = (List<Object[]>) genericClassService.fetchRecord(Disease.class, fieldsdisease, wheredisease, paramdisease, paramsValuesdisease);
        if (objdisease != null) {
            Map<String, Object> categoryDiseases;
            for (Object[] disease : objdisease) {
                categoryDiseases = new HashMap<>();

                categoryDiseases.put("diseaseid", (Long) disease[0]);
                categoryDiseases.put("diseasename", (String) disease[1]);
                categoryDiseases.put("description", (String) disease[2]);
                categoryDiseases.put("isactive", (Boolean) disease[3]);
                categoryDiseases.put("diseasecode", (String) disease[4]);
                diseaseDiseaseList.add(categoryDiseases);
            }
        }
        model.addAttribute("diseaseDiseaseList", diseaseDiseaseList);
        model.addAttribute("categoryid", categoryid);
        model.addAttribute("categoryname", categoryname);
        return "patientsManagement/consultation/clinicalguidelines/views/manageDiseases";
    }

    @RequestMapping(value = "/submitDiseaseCategory", method = RequestMethod.POST)
    public @ResponseBody
    String submitDiseaseCategory(Model model, HttpServletRequest request) {
        Diseasecategory diseasecategory = new Diseasecategory();
        String categoryname = request.getParameter("diseasecategoryname");
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        Long classificationid = Long.parseLong(request.getParameter("diseaseClassificationId"));

        diseasecategory.setCreatedby(currStaffId);
        diseasecategory.setDatecreated(new Date());
        diseasecategory.setDiseasecategoryname(categoryname.toUpperCase());
        diseasecategory.setDiseaseclassificationid(classificationid);
        diseasecategory.setStatus(true);
        genericClassService.saveOrUpdateRecordLoadObject(diseasecategory);
        return "";
    }

    @RequestMapping(value = "/submitNewDisease", method = RequestMethod.POST)
    public @ResponseBody
    String submitNewDisease(Model model, HttpServletRequest request) {
        Disease disease = new Disease();
        Long categoryid = Long.parseLong(request.getParameter("categoryid"));
        String diseasecode = request.getParameter("diseasecode");
        String diseasename = request.getParameter("diseasename");
        String diseasedescription = request.getParameter("diseasediscription");
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        Long response = null;

        disease.setCreatedby(currStaffId);
        disease.setDatecreated(new Date());
        disease.setDescription(diseasedescription);
        disease.setDiseasecategoryid(categoryid);
        disease.setStatus(true);
        disease.setDiseasename(diseasename);
        disease.setDiseasecode(diseasecode);
        disease = (Disease) genericClassService.saveOrUpdateRecordLoadObject(disease);
        if (disease.getDiseaseid() != null) {
            response = disease.getDiseaseid();
        }
        
        return String.valueOf(response);
    }

    @RequestMapping(value = "/manageDiseaseComponents.htm", method = RequestMethod.GET)
    public String addComponentsToDisease(Model model, HttpServletRequest request, @ModelAttribute("diseasename") String diseasename, @ModelAttribute("diseaseid") String diseaseid, @ModelAttribute("diseasecode") String diseasecode) {

        List<Map> diseaseSymptomList = new ArrayList<>();
        String[] paramdiseasesymptom = {"diseaseid"};
        Object[] paramsValuesdiseasesymptom = {Long.parseLong(diseaseid)};
        String wherediseasesymptom = "WHERE diseaseid=:diseaseid";
        String[] fieldsdiseasesymptom = {"symptomid.symptomid", "diseasesymptomid"};
        List<Object[]> objdiseasesymptom = (List<Object[]>) genericClassService.fetchRecord(Diseasesymptom.class, fieldsdiseasesymptom, wherediseasesymptom, paramdiseasesymptom, paramsValuesdiseasesymptom);
        if (objdiseasesymptom != null) {
            Map<String, Object> mapDiseaseSymptom;
            for (Object[] diseasesymptom : objdiseasesymptom) {
                mapDiseaseSymptom = new HashMap<>();

                mapDiseaseSymptom.put("diseasesymptomid", (Long) diseasesymptom[1]);
                String[] paramdiseaseSymptomDisease = {"symptomid"};
                Object[] paramsValuesdiseasesymptomDisease = {diseasesymptom[0]};
                String wherediseasesymptomDisease = "WHERE symptomid=:symptomid";
                String[] fieldsdiseasesymptomDisease = {"symptomid", "symptom"};
                List<Object[]> objdiseasesymptomDisease = (List<Object[]>) genericClassService.fetchRecord(Symptom.class, fieldsdiseasesymptomDisease, wherediseasesymptomDisease, paramdiseaseSymptomDisease, paramsValuesdiseasesymptomDisease);
                if (objdiseasesymptomDisease != null) {
                    for (Object[] symptomss : objdiseasesymptomDisease) {

                        mapDiseaseSymptom.put("symptomid", (Long) symptomss[0]);
                        mapDiseaseSymptom.put("symptomname", (String) symptomss[1]);
                        diseaseSymptomList.add(mapDiseaseSymptom);
                    }
                }
            }
        }
        model.addAttribute("diseaseSymptomList", diseaseSymptomList);
        model.addAttribute("diseaseSymptomListsize", diseaseSymptomList.size());
        model.addAttribute("diseasename", diseasename);
        model.addAttribute("diseaseid", diseaseid);
        model.addAttribute("diseasecode", diseasecode);
        return "patientsManagement/consultation/clinicalguidelines/views/diseaseSymptoms";
    }

    @RequestMapping(value = "/updateDiseaseCategory.htm")
    public @ResponseBody
    String updateDiseaseCategory(Model model, HttpServletRequest request) {
        String response = "";

        String[] columns = {"diseasecategoryname"};
        Object[] columnValues = {request.getParameter("diseasecategoryname")};
        String pk = "diseasecategoryid";
        Object pkValue = Long.parseLong(request.getParameter("diseasecategoryid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Diseasecategory.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            response = "success";
        }

        return response;
    }

    @RequestMapping(value = "/updateDiseaseClassificationName.htm")
    public @ResponseBody
    String updateDiseaseClassificationName(Model model, HttpServletRequest request) {
        String response = "";

        String[] columns = {"classifficationname"};
        Object[] columnValues = {request.getParameter("name")};
        String pk = "diseaseclassificationid";
        Object pkValue = Long.parseLong(request.getParameter("classissificationid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Diseaseclassification.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            response = "success";
        }

        return response;
    }

    @RequestMapping(value = "/activatedOrDeactivatedDiseaseStatus.htm")
    public @ResponseBody
    String activatedOrDeactivatedDiseaseStatus(Model model, HttpServletRequest request) {
        String response = "";
        if ("activate".equals(request.getParameter("type"))) {
            String[] columnsact = {"status"};
            Object[] columnValuesact = {true};
            String pkact = "diseaseid";
            Object pkValueact = Long.parseLong(request.getParameter("diseaseid"));
            int resultact = genericClassService.updateRecordSQLSchemaStyle(Disease.class, columnsact, columnValuesact, pkact, pkValueact, "patient");
            if (resultact != 0) {
                response = "success";
            }
        } else {
            String[] columnsdiact = {"status"};
            Object[] columnValuesdiact = {false};
            String pkdiact = "diseaseid";
            Object pkValuediact = Long.parseLong(request.getParameter("diseaseid"));
            int resultdiact = genericClassService.updateRecordSQLSchemaStyle(Disease.class, columnsdiact, columnValuesdiact, pkdiact, pkValuediact, "patient");
            if (resultdiact != 0) {
                response = "success";
            }
        }
        return response;
    }

    @RequestMapping(value = "/updateDiseaseDetails.htm")
    public @ResponseBody
    String updateDiseaseDetails(Model model, HttpServletRequest request) {
        String response = "";

        String[] columnsdis = {"diseasename", "diseasecode", "description"};
        Object[] columnValuesdis = {request.getParameter("diseasename"), request.getParameter("diseasecode"), request.getParameter("diseasediscription")};
        String pkdis = "diseaseid";
        Object pkValuedis = Long.parseLong(request.getParameter("diseaseid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Disease.class, columnsdis, columnValuesdis, pkdis, pkValuedis, "patient");
        if (result != 0) {
            response = "success";
        }

        return response;
    }

    @RequestMapping(value = "/diseaseSymptomsSearched.htm", method = RequestMethod.POST)
    public @ResponseBody
    String diseaseSymptomsSearched(Model model, HttpServletRequest request) {

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
                    itemsRow.put("symptomid", symptom[0]);
                    itemsRow.put("value", symptom[1]);
                    itemsFound.add(itemsRow);
                }
            }
            results = new ObjectMapper().writeValueAsString(itemsFound);
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::" + e.getMessage());

        }
        return results;
    }

    @RequestMapping(value = "/addDiseaseSymptom.htm")
    public @ResponseBody
    String addDiseaseSymptom(Model model, HttpServletRequest request) {
        String response = "";
        String diseaseid = request.getParameter("diseaseid");
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        if ("0".equals(request.getParameter("type"))) {
            String symptomvalue = request.getParameter("symptom");

            Symptom symptom = new Symptom();
            symptom.setSymptom(symptomvalue);
            symptom.setAddedby(BigInteger.valueOf(currStaffId));
            symptom.setDateadded(new Date());
            symptom = (Symptom) genericClassService.saveOrUpdateRecordLoadObject(symptom);

            if (symptom != null) {
                Diseasesymptom diseasesymptom2 = new Diseasesymptom();
                diseasesymptom2.setDiseaseid(new Disease(Long.parseLong(diseaseid)));
                diseasesymptom2.setAddedby(BigInteger.valueOf(currStaffId));
                diseasesymptom2.setDateadded(new Date());
                diseasesymptom2.setSymptomid(new Symptom(symptom.getSymptomid()));
                genericClassService.saveOrUpdateRecordLoadObject(diseasesymptom2);
                response = "success";
            }
        }
        if ("1".equals(request.getParameter("type"))) {
            Long symptomid = Long.parseLong(request.getParameter("symptomid"));

            String[] paramdiseasesymptom3 = {"diseaseid", "symptomid"};
            Object[] paramsValuesdiseasesymptom3 = {Long.parseLong(diseaseid), symptomid};
            String wherediseasesymptom3 = "WHERE diseaseid=:diseaseid AND symptomid=:symptomid";
            String[] fieldsdiseasesymptom3 = {"diseasesymptomid"};
            List<Long> objdiseasesymptom3 = (List<Long>) genericClassService.fetchRecord(Diseasesymptom.class, fieldsdiseasesymptom3, wherediseasesymptom3, paramdiseasesymptom3, paramsValuesdiseasesymptom3);
            if (objdiseasesymptom3 != null) {
                response = "exists";
            } else {
                Diseasesymptom diseasesymptom = new Diseasesymptom();
                diseasesymptom.setDiseaseid(new Disease(Long.parseLong(diseaseid)));
                diseasesymptom.setAddedby(BigInteger.valueOf(currStaffId));
                diseasesymptom.setDateadded(new Date());
                diseasesymptom.setSymptomid(new Symptom(symptomid));
                genericClassService.saveOrUpdateRecordLoadObject(diseasesymptom);
                response = "success";
            }
        }
        return response;
    }

    @RequestMapping(value = "/updateDiseaseSymptom.htm")
    public @ResponseBody
    String updateDiseaseSymptom(Model model, HttpServletRequest request) {
        String response = "";

        String[] columns = {"symptom"};
        Object[] columnValues = {request.getParameter("diseasesymptomname")};
        String pk = "symptomid";
        Object pkValue = Long.parseLong(request.getParameter("symptomid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Symptom.class, columns, columnValues, pk, pkValue, "patient");
        if (result != 0) {
            response = "success";
        }

        return response;
    }

    @RequestMapping(value = "/deleteDiseaseSymptom.htm")
    public @ResponseBody
    String deleteDiseaseSymptom(Model model, HttpServletRequest request) {
        String results = "";

        String[] columnsdelete = {"diseasesymptomid"};
        Object[] columnValuesdelete = {Long.parseLong(request.getParameter("diseasesymptomid"))};
        int result = genericClassService.deleteRecordByByColumns("patient.diseasesymptom", columnsdelete, columnValuesdelete);
        if (result != 0) {
            results = "deleted";
        }
        return results;
    }

    @RequestMapping(value = "/deleteDisease.htm")
    public @ResponseBody
    String deleteDisease(Model model, HttpServletRequest request) {
        String results = "";

        String[] paramdiseasesymptom = {"diseaseid"};
        Object[] paramsValuesdiseasesymptom = {Long.parseLong(request.getParameter("diseaseid"))};
        String wherediseasesymptom = "WHERE diseaseid=:diseaseid";
        String[] fieldsdiseasesymptom = {"symptomid.symptomid", "diseasesymptomid"};
        List<Object[]> objdiseasesymptom = (List<Object[]>) genericClassService.fetchRecord(Diseasesymptom.class, fieldsdiseasesymptom, wherediseasesymptom, paramdiseasesymptom, paramsValuesdiseasesymptom);
        if (objdiseasesymptom != null) {
            results = "hassymptoms";
        } else {
            String[] columnsdelete = {"diseaseid"};
            Object[] columnValuesdelete = {Long.parseLong(request.getParameter("diseaseid"))};
            int result = genericClassService.deleteRecordByByColumns("patient.disease", columnsdelete, columnValuesdelete);
            if (result != 0) {
                results = "deleted";
            }
        }
        return results;
    }

    @RequestMapping(value = "/deleteDiseaseWithSymptoms.htm")
    public @ResponseBody
    String deleteDiseaseWithSymptoms(Model model, HttpServletRequest request) {
        String results = "";

        String[] paramsdis = {"diseaseid"};
        Object[] paramsValuesdis = {Long.parseLong(request.getParameter("diseaseid"))};
        String[] fieldsdis = {"symptomid"};
        String wheredis = "WHERE diseaseid=:diseaseid";
        List<Long> objDiseasesymp = (List<Long>) genericClassService.fetchRecord(Diseasesymptom.class, fieldsdis, wheredis, paramsdis, paramsValuesdis);
        if (objDiseasesymp != null) {
            String[] columnsd = {"symptomid"};
            Object[] columnValuesd = {objDiseasesymp.get(0)};
            int result = genericClassService.deleteRecordByByColumns("patient.diseasesymptom", columnsd, columnValuesd);
            if (result != 0) {
                String[] columnsdisSymp = {"diseaseid"};
                Object[] columnValues2disSymp = {Long.parseLong(request.getParameter("diseaseid"))};
                int result2disSymp = genericClassService.deleteRecordByByColumns("patient.disease", columnsdisSymp, columnValues2disSymp);
                if (result2disSymp != 0) {
                    results = "deleted2";
                }
            }
        }
        return results;
    }
}
