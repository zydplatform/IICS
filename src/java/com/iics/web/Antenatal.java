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
import com.iics.domain.Person;
import com.iics.patient.Patient;
import com.iics.patient.Searchpatient;
import com.iics.service.GenericClassService;
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
import org.springframework.web.bind.annotation.ResponseBody;
import com.iics.domain.Locations;
import com.iics.domain.Staff;
import com.iics.domain.Village;
import com.iics.patient.Facilityvisitno;
import com.iics.patient.Medicalissue;
import com.iics.patient.Patientmedicalissue;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Patientvisit;
import com.iics.patient.Patientvisits;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import com.iics.antenatal.Condition;
import com.iics.antenatal.Familyplanningmethod;

import com.iics.assetsmanager.Assetclassification;
import com.iics.assetsmanager.Assets;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.security.Principal;
import java.io.IOException;
import java.io.FileNotFoundException;

/**
 *
 * @author Uwera
 */
@Controller
@RequestMapping("/antenatal")
public class Antenatal {
    
    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formatterwithtime = new SimpleDateFormat("E, dd MMM yyyy HH:mm aa");
    SimpleDateFormat df = new SimpleDateFormat("yyyy");

    @RequestMapping(value = "/antenatalMenu", method = RequestMethod.GET)
    public String patientMainMenu(HttpServletRequest request, Model model) {
        return "patientsManagement/antenatal/antenatalMenu";
    }
//    @RequestMapping(value = "/antenatalMainpage", method = RequestMethod.GET)
//    public String init(Model model1) {
//      
//        List<Condition> conditionList = new ArrayList<>();
//        String[] params = {};
//        Object[] paramsValues = {};
//        String[] fields = {"conditionid", "conditionname"};
//        String where = "";
//        List<Object[]> condition = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, where, params, paramsValues);
//        Condition conditions;
//        if (condition != null) {
//            for (Object[] cdt : condition) {
//                conditions = new Condition();
//                conditions.setConditionid((Integer) cdt[0]);
//                conditions.setConditionname((String) cdt[1]);
//                conditions.setConditontype((String) cdt[2]);
//                conditionList.add(conditions);
//            
//            } 
//
//            model1.addAttribute("conditionList", conditionList);
//        }
//       return "patientsManagement/antenatal/antenatalMainpage";
//       
//    }
     @RequestMapping(value = "/antenatalMainpage.htm", method = RequestMethod.GET)
    public String antenatalMainpage(Model model, HttpServletRequest request) {
        List<Map> conditionList = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"conditionid", "conditionname","conditontype"};
        String where = "ORDER BY conditionname ASC";
        List<Object[]> conditions = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, where, params, paramsValues);
        if (conditions != null) {
            Map<String, Object> cond;
            for (Object[] condition: conditions) {
                cond = new HashMap<>();
                cond.put("conditionid", condition[0]);
                cond.put("conditionname", condition[1]);
                cond.put("conditontype", condition[2]);
              
                conditionList.add(cond);
            }
        }
        model.addAttribute("conditionList", conditionList);
        return "patientsManagement/antenatal/antenatalMainpage";
    }
    @RequestMapping(value = "/conditions.htm", method = RequestMethod.GET)
    public String conditions(Model model, HttpServletRequest request) {
        List<Map> conditionList = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
          String[] fields = {"conditionid", "conditionname","conditontype"};
            String where = "ORDER BY c.conditionname ASC";
        List<Object[]> conditions = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, where, params, paramsValues);
        if (conditions != null) {
            Map<String, Object> cond;
            for (Object[] condition: conditions) {
                cond = new HashMap<>();
                cond.put("conditionid", condition[0]);
                cond.put("conditionname", condition[1]);
                cond.put("conditontype", condition[2]);
              
                conditionList.add(cond);
            }
        }
        model.addAttribute("conditionList", conditionList);
        return "patientsManagement/antenatal/views/viewConditions";
    }
    
    @RequestMapping(value = "/updatecondition.htm")
    public @ResponseBody
    String updatecondition(HttpServletRequest request) {
        String response = "";
        String[] columns = {"conditionname", "conditontype"};
        Object[] columnValues = {request.getParameter("name"), request.getParameter("conditontype")};
        String pk = "conditionid";
        Object pkValue = Integer.parseInt(request.getParameter("conditionid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Condition.class, columns, columnValues, pk, pkValue, "public");
        if (result != 0) {
            response = "success";
        }
        return response;
    }
     @RequestMapping(value = "/registerNewCondition", method = RequestMethod.GET)
    public String registerNewCondition(HttpServletRequest request, Model model) {

        return "patientsManagement/antenatal/forms/registercondition";
    }
    
    //fisrt implementation  @RequestMapping(value = "/manageAntenatalAttributes", method = RequestMethod.GET)
    @RequestMapping(value = "/manageAntenatalAttributesx", method = RequestMethod.GET)
    public String init(Model model1) {
       
        List<Condition> conditionList = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"conditionid", "conditionname"};
        String where = "";
        List<Object[]> condition = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, where, params, paramsValues);
        Condition conditions;
        if (condition != null) {
            for (Object[] cond : condition) {
                conditions = new Condition();
                conditions.setConditionid((Integer)cond[0]);
//                conditions.setConditionname((String)cond[1]);
              
                conditionList.add(conditions);
            } 
//             
            model1.addAttribute("conditionList", conditionList);
        }
        return "patientsManagement/antenatal/views/listAntenatalTab";

    }
    @RequestMapping(value = "/submitcondition", method = RequestMethod.POST)
    public @ResponseBody
    String submitcondition(Model model, HttpServletRequest request) {
        Condition condition = new Condition();
        String conditionname = request.getParameter("conditionname");
       
        condition.setConditionname(conditionname);
        //Check Existing condition
        List<Object[]> existingCondition = (List<Object[]>) genericClassService.fetchRecord(Condition.class, new String[]{"conditionid"}, "WHERE LOWER(c.conditionname)=:name", new String[]{"name"}, new Object[]{conditionname.toLowerCase()});
        if (existingCondition != null) {
            return "Condition " + conditionname + " ALREADY EXISTS!";
        }
        genericClassService.saveOrUpdateRecordLoadObject(condition);
        return "";
    }
@RequestMapping(value = "/deleteCondition", method = RequestMethod.GET)
    public final ModelAndView deleteRegion(@RequestParam("act") String activity, @RequestParam("cID") int conditionId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
       
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        try {
            String[] params = {"cID"};
            Object[] paramValues = {conditionId};
            String[] fields = {"conditionid", "conditionname"};
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, " WHERE c.conditionid=:cID", params, paramValues);
            if (checkObj != null) {
               model.put("checkObj", checkObj.get(0));  
            }
      return new ModelAndView("patientsManagement/antenatal/forms/discardCondition", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
            return new ModelAndView("patientsManagement/antenatal/forms/discardCondition", "model", model);
        }
    }

 @RequestMapping(value = "/addNewMethod", method = RequestMethod.GET)
    public String addNewFamilyPlanningMethod(HttpServletRequest request, Model model) {

        return "patientsManagement/antenatal/forms/addfamilyPlanningMethod";
    }
    @RequestMapping(value = "/manageAntenatalAttributes", method = RequestMethod.GET)
    public String manageAntenatalAttributes(HttpServletRequest request, Model model) {
        //FETCHING methods.
        
        List<Map> methods = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"familyplanningmethodid", "methodname","description"};
        String where = "ORDER BY methodname ASC";
        List<Object[]> methodx = (List<Object[]>) genericClassService.fetchRecord(Familyplanningmethod.class, fields, where, params, paramsValues);
        if (methodx != null) {
            Map<String, Object> meth;
            for (Object[] method: methodx) {
                meth = new HashMap<>();
                meth.put("familyplanningmethodid", method[0]);
                meth.put("methodname", method[1]);
                meth.put("description", method[2]);
              
                methods.add(meth);
            }
         }
        model.addAttribute("methodList", methods);

        return "patientsManagement/antenatal/antenatalMainpage";
    }
    
    //SAVING Family Planning Method
    @RequestMapping(value = "/saveMethod", method = RequestMethod.POST)
    public @ResponseBody
    String saveMethod(HttpServletRequest request, Model model, @ModelAttribute("methods") String methods) {
        System.out.println("++++" + methods);
        Set<Integer> methodsids = new HashSet<>();
        String results = "";
        try {
            List<Map> methodsList = new ObjectMapper().readValue(methods, List.class);
            for (Map item : methodsList) {
                Map<String, Object> map = (HashMap) item;

                Object addedbyname = request.getSession().getAttribute("person_id");
                Object updatedbyname = request.getSession().getAttribute("person_id");
                Familyplanningmethod methodClassx = new Familyplanningmethod();
                methodClassx.setMethodname((String) map.get("className"));
                methodClassx.setDescription((String) map.get("description"));
               Object save = genericClassService.saveOrUpdateRecordLoadObject(methodClassx);
                if (save != null) {
                    results = "Success";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }
    //CHECKING FPM NAME 
    @RequestMapping(value = "/checkMethodName", method = RequestMethod.POST)
    public @ResponseBody
    String checkMethodName(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String methodname) {
        String results = "";
        try {
            String[] paramszrrp = { "methodname"};
            Object[] paramsValueszrrp = { methodname.trim().toLowerCase() + "%"};
            String[] fieldszrrp = {"familyplanningmethodid", "methodname", "description"};
            String wherezrrp = "WHERE methodname=:methodname AND (LOWER(methodname) LIKE :methodname)";
            List<Object[]> method = (List<Object[]>) genericClassService.fetchRecord(Familyplanningmethod.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (method != null) {
                results = "exists";
            } else {
                results = "doesnotexists";
            }
        } catch (Exception ex) {
            return "Failed";
        }

        return results;
    }
    @RequestMapping(value = "/updatemethod.htm")
    public @ResponseBody
    String updatemethod(HttpServletRequest request) {
        String results = "";
        String[] columns = {"methodname", "description"};
        Object[] columnValues = {request.getParameter("name"), request.getParameter("description")};
        String pk = "familyplanningmethodid";
        Object pkValue = Integer.parseInt(request.getParameter("familyplanningmethodid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Familyplanningmethod.class, columns, columnValues, pk, pkValue, "antenatal");
        if (result != 0) {
            results = "success";
        }
        return results;
    }
    
    @RequestMapping(value = "/deleteMethod.htm")
    public @ResponseBody
    String deleteMethod(HttpServletRequest request) {
        String results = "";
        String[] columns = {"familyplanningmethodid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("familyplanningmethodid"))};
        int result = genericClassService.deleteRecordByByColumns("antenatal.familyplanningmethod", columns, columnValues);
        if (result != 0) {
            results = "success";
        }
        return results;
    }
    
//@RequestMapping(value = "/manageCondition", method = RequestMethod.GET)
//    public final ModelAndView manageCondition(Principal principal, HttpServletRequest request) {
//        if (principal == null) {
//            return new ModelAndView("login");
//        }
//        System.out.println("ngwino ::::");
//        Map<String, Object> model = new HashMap<String, Object>();
//        try {
//            
//
//            List<Condition> conditionsList = (List<Condition>) genericClassService.fetchRecord(Condition.class, new String[]{}, " ORDER BY r.conditionname ASC", null, null);
//            model.put("conditionsList", conditionsList);
//
//            return new ModelAndView("patientsManagement/antenatal/views/ConditionContent", "model", model);
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
//            return new ModelAndView("patientsManagement/antenatal/views/ConditionContent", "model", model);
//        }
//    }
     @RequestMapping(value = "/manageConditions.htm", method = RequestMethod.GET)
    public String manageConditions(Model model, HttpServletRequest request) {
        List<Map> conditionList = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"conditionid", "conditionname", "conditontype"};
        String where = "ORDER BY r.conditionname ASC";
        List<Object[]> conditions = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, where, params, paramsValues);
        if (conditions != null) {
            Map<String, Object> cond;
            for (Object[] condition : conditions) {
                cond = new HashMap<>();
                cond.put("conditionid", condition[0]);
                cond.put("conditionname", condition[1]);
                cond.put("conditontype", condition[2]);

                conditionList.add(cond);
            }
        }
        model.addAttribute("conditionList", conditionList);
        return "patientsManagement/antenatal/views/viewConditions";
    }
     @RequestMapping(value = "/addNewCondition", method = RequestMethod.GET)
    public String addNewCondition(HttpServletRequest request, Model model) {

        return "patientsManagement/antenatal/forms/addCondition";
    }


    //CHECKING Condition name 
    @RequestMapping(value = "/checkConditionName", method = RequestMethod.POST)
    public @ResponseBody
    String checkConditionName(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String conditionname) {
        String results = "";
        try {
            String[] params = {"conditionname"};
            Object[] paramsValues = {conditionname.trim().toLowerCase() + "%"};
            String[] fields = {"conditionid", "conditionname", "conditontype"};
            String where = "WHERE conditionname=:conditionname AND (LOWER(conditionname) LIKE :conditionname)";
            List<Object[]> condition = (List<Object[]>) genericClassService.fetchRecord(Condition.class, fields, where, params, paramsValues);
            if (condition != null) {
                results = "exists";
            } else {
                results = "doesnotexists";
            }
        } catch (Exception ex) {
            return "Failed";
        }

        return results;
    }

    @RequestMapping(value = "/saveCondit", method = RequestMethod.POST)
    public @ResponseBody
    String saveCondit(HttpServletRequest request, Model model, @ModelAttribute("conditions") String conditions) {
        Set<Integer> conditionids = new HashSet<>();
        String results = "";
        try {
            List<Map> conditionsList = new ObjectMapper().readValue(conditions, List.class);
            for (Map item : conditionsList) {
                Map<String, Object> map = (HashMap) item;

                Condition con = new Condition();
                con.setConditionname((String) map.get("className"));
                con.setConditontype((String) map.get("conditontype"));
                Object save = genericClassService.saveOrUpdateRecordLoadObject(con);
                if (save != null) {
                    results = "Success";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }
    @RequestMapping(value = "/deleteCondition.htm")
    public @ResponseBody
    String deleteCondition(HttpServletRequest request) {
        String results = "";
        String[] columns = {"conditionid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("conditionid"))};
        int result = genericClassService.deleteRecordByByColumns("antenatal.Condition", columns, columnValues);
        if (result != 0) {
            results = "success";
        }
        return results;
    }
     @RequestMapping(value = "/updateCondition.htm")
    public @ResponseBody
    String updateCondition(HttpServletRequest request) {
        String results = "";
        String[] columns = {"conditionname", "conditontype"};
        Object[] columnValues = {request.getParameter("name"), request.getParameter("conditontype")};
        String pk = "conditionid";
        Object pkValue = Integer.parseInt(request.getParameter("conditionid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Condition.class, columns, columnValues, pk, pkValue, "antenatal");
        if (result != 0) {
            results = "success";
        }
        return results;
    }
   }

