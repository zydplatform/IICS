/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Spokenlanguages;
import com.iics.service.GenericClassService;
import java.io.IOException;
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
 * @author EARTHQUAKER
 */
@Controller
@RequestMapping("/spokenlanguages")
public class SpokenLanguages {

    @Autowired
    GenericClassService genericservice;

    /* method for managing spoken language*/
    @RequestMapping(value = "/managespokenlanguages", method = RequestMethod.GET)
    public String managelanguage(HttpServletRequest request, Model model) {
        List<Map> languageList = new ArrayList<>();

        //fetching 
        String[] params = {"archived"};
        Object[] paramvalues = {Boolean.FALSE};
        String[] fields = {"languageid", "languagename"};
        String where = "WHERE r.archived=:archived";

        List<Object[]> languages = (List<Object[]>) genericservice.fetchRecord(Spokenlanguages.class, fields, where, params, paramvalues);
        Map<String, Object> lang;
        if (languages != null) {
            for (Object[] language : languages) {
                lang = new HashMap<>();
                lang.put("languageid", language[0]);
                lang.put("languagename", (String) language[1]);

                languageList.add(lang);

            }
        }
        String jsonCreatedlanguage = "";
        try {
            jsonCreatedlanguage = new ObjectMapper().writeValueAsString(languageList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("languagelist", languageList);
        model.addAttribute("jsonCreatedlanguage", jsonCreatedlanguage);
        return "controlPanel/universalPanel/spokenLanguages/managespokenlanguages";

    }

    //savelanguage
    @RequestMapping(value = "/savespokenlanguage", method = RequestMethod.POST)
    public @ResponseBody
    String savelanguage(HttpServletRequest request, Model model,@ModelAttribute("languages") String langs) {
        String results = "";
       
        int addedby = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
        try{
        List<Map> languagelist = new ObjectMapper().readValue(langs, List.class);
        for (Map item : languagelist) {
        Spokenlanguages newlanguage = new Spokenlanguages();
        Map<String, Object> map = (HashMap) item;
        newlanguage.setLanguagename(map.get("languagename").toString());
        newlanguage.setAddedby(addedby);
        newlanguage.setDateadded(new Date());
        newlanguage.setArchived(Boolean.FALSE);
        Object save = genericservice.saveOrUpdateRecordLoadObject(newlanguage);
        if (save != null) {
            results = "saved succesfully";
        } else {
            results = "failed";
        }
                    
        }

        
        }catch (IOException ex) {
            System.out.println(ex);
        }
        return results;

    }

    //update language
    @RequestMapping(value = "/updatespokenlanguage", method = RequestMethod.POST)
    public @ResponseBody
    String updatelanguage(HttpServletRequest request, Model model) {
        String results = "";
        
        List<Map> languageList = new ArrayList<>();

        //fetching languages
        String[] params = {"archived"};
        Object[] paramvalues = {Boolean.FALSE};
        String[] fields = {"languageid", "languagename"};
        String where = "WHERE r.archived=:archived";

        List<Object[]> languages = (List<Object[]>) genericservice.fetchRecord(Spokenlanguages.class, fields, where, params, paramvalues);
        Map<String, Object> lang;
        if (languages != null) {
            for (Object[] language : languages) {
                lang = new HashMap<>();
                lang.put("languageid", language[0]);
                lang.put("languagename", (String) language[1]);

                languageList.add(lang);

            }
        }
        String jsonCreatedlanguage = "";
        try {
            jsonCreatedlanguage = new ObjectMapper().writeValueAsString(languageList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("languagelist", languageList);
        model.addAttribute("jsonCreatedlanguage", jsonCreatedlanguage);
        
        
        try {
            int languageid = Integer.parseInt(request.getParameter("languageid"));
            String languagename = request.getParameter("languagename");
            String pk = "languageid";
            Object pkValue = languageid;
            String[] columns = {"languagename"};
            Object[] columnValues = {languagename};
            String schema = "public";
            int response = genericservice.updateRecordSQLSchemaStyle(Spokenlanguages.class, columns, columnValues, pk, pkValue, schema);
            if (response > 0) {
                results = "Record updated successfully";
            } else {
                results = "Failed";
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();

        }
        return results;

    }

    //delete language
     @RequestMapping(value = "/deletespokenlanguage", method = RequestMethod.POST)
    public @ResponseBody
    String removeCurrency(HttpServletRequest request, Model model, @ModelAttribute("languageid") int languageid) {
        String results = "";
        
        String[] columnslev = {"archived"};
        Object[] columnValueslev = {Boolean.TRUE};
        String levelPrimaryKey = "languageid";
        Object levelPkValue = languageid;
        int result = genericservice.updateRecordSQLSchemaStyle(Spokenlanguages.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
        if (result != 0) {
            results = "success";
        }else{
        results = "failed";
        }
        return results;
    }

    //show languages
    @RequestMapping(value = "/listspokenlanguages", method = RequestMethod.GET)
    public @ResponseBody
    String listlanguages(HttpServletRequest request, Model model) {

        return "controlPanel/universalPanel/spokenLanguages/views/viewspokenlanguages";

    }

}
