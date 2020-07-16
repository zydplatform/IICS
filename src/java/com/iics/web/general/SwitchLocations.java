/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.general;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilityunit;
import com.iics.domain.Searchfacility;
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

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/switchLocations")
public class SwitchLocations {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/searchFacility", method = RequestMethod.GET)
    public String searchFacility(HttpServletRequest request, Model model, @ModelAttribute("searchvalue") String searchValue) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> itemsFound = new ArrayList<>();
            String[] params = {"value"};
            Object[] paramsValues = {searchValue.trim().toLowerCase() + "%"};
            String[] fields = {"facilityid", "facilityname", "levelcode", "villagename", "subcountyname"};
            String where = "WHERE (LOWER(facilityname) LIKE :value OR LOWER(facilitycode) LIKE :value OR LOWER(facilitylevelname) LIKE :value OR LOWER(shortname) LIKE :value OR LOWER(villagename) LIKE :value OR LOWER(parishname) LIKE :value OR LOWER(subcountyname) LIKE :value OR LOWER(countyname) LIKE :value OR LOWER(emailaddress) LIKE :value OR LOWER(phonecontact) LIKE :value OR LOWER(phonecontact2) LIKE :value OR LOWER(postaddress) LIKE :value) ORDER BY facilityname";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Searchfacility.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> item;
                for (Object[] object : cellList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    if (object[2] != null) {
                        item.put("level", object[2]);
                    } else {
                        item.put("level", "Level Unknown");
                    }
                    item.put("village", object[3]);
                    item.put("sub", object[4]);
                    itemsFound.add(item);
                }
            }
            model.addAttribute("name", searchValue);
            model.addAttribute("facilities", itemsFound);
            return "facilitySearchResults";
        } else {
            return "refresh";
        }
    }
    
    @RequestMapping(value = "/searchFacilityUnit", method = RequestMethod.GET)
    public String searchFacilityUnit(HttpServletRequest request, Model model, @ModelAttribute("searchvalue") String searchValue) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> itemsFound = new ArrayList<>();
            Integer facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String[] params = {"value","facId"};
            Object[] paramsValues = {searchValue.trim().toLowerCase() + "%",facilityid};
            String[] fields = {"facilityunitid", "facilityunitname"};
            String where = "WHERE LOWER(r.facilityunitname) LIKE :value AND r.facilityid=:facId ORDER BY r.facilityunitname ASC  ";
            List<Object[]> unitList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (unitList != null) {
                Map<String, Object> item;
                for (Object[] object : unitList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    item.put("facilityid", facilityid);
                    itemsFound.add(item);
                }
            }
            model.addAttribute("name", searchValue);
            model.addAttribute("units", itemsFound);
            return "facilityUnitSearchResults";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchFacilityUnits", method = RequestMethod.POST)
    public @ResponseBody
    String fetchFacilityUnits(HttpServletRequest request, Model model, @ModelAttribute("facilityid") Integer facilityid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> facilityUnits = new ArrayList<>();
            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityid};
            String[] fields = {"facilityunitid", "facilityunitname"};
//            String where = "WHERE facilityid=:facilityid";
            String where = "WHERE facilityid=:facilityid ORDER BY facilityunitname";
            List<Object[]> staff = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                Map<String, Object> facilityUnit;
                for (Object[] unit : staff) {
                    facilityUnit = new HashMap<>();
                    facilityUnit.put("id", unit[0]);
                    facilityUnit.put("name", unit[1]);
                    facilityUnits.add(facilityUnit);
                }
            }
            String unitList = "[]";
            try {
                unitList = new ObjectMapper().writeValueAsString(facilityUnits);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return unitList;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/changeUserSession", method = RequestMethod.POST)
    public @ResponseBody String changeUserSession(HttpServletRequest request, Model model, @ModelAttribute("facilityid") Integer facilityid, @ModelAttribute("unitid") Integer unitid) {
        Object curFacilityId = request.getSession().getAttribute("sessionActiveLoginFacility");
        Object curFacilityunitid = request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        request.getSession().setAttribute("sessionLoginFacilityUnit", unitid);
        request.getSession().setAttribute("sessionLoginFacility", facilityid);
        request.getSession().setAttribute("sessionActiveLoginFacility", facilityid);
        request.getSession().setAttribute("sessionActiveLoginFacilityUnit", unitid);

        request.getSession().setAttribute("sessionActiveLoginFacilityTemp", curFacilityId);
        request.getSession().setAttribute("sessionActiveLoginFacilityUnitTemp", curFacilityunitid);
        request.getSession().setAttribute("sessionChanged", true);

        return "refresh";
    }
    
    @RequestMapping(value = "/changeUserUnitSession", method = RequestMethod.POST)
    public @ResponseBody String changeUserUnitSession(HttpServletRequest request, Model model, @ModelAttribute("unitid") Integer unitid) {
        Object curFacilityId = request.getSession().getAttribute("sessionActiveLoginFacility");
        Object curFacilityunitid = request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        request.getSession().setAttribute("sessionActiveLoginFacilityUnit", unitid);
        request.getSession().setAttribute("sessionActiveLoginFacilityTemp", curFacilityId);
        request.getSession().setAttribute("sessionActiveLoginFacilityUnitTemp", curFacilityunitid);
        request.getSession().setAttribute("sessionChanged", true);

        return "refresh";
    }
    
    @RequestMapping(value = "/endUserSession", method = RequestMethod.POST)
    public @ResponseBody String endUserSession(HttpServletRequest request, Model model) {
        Object originFacilityId = request.getSession().getAttribute("sessionActiveLoginFacilityTemp");
        Object originFacilityunitid = request.getSession().getAttribute("sessionActiveLoginFacilityUnitTemp");

        request.getSession().setAttribute("sessionLoginFacility", originFacilityId);
        request.getSession().setAttribute("sessionActiveLoginFacility", originFacilityId);
        request.getSession().setAttribute("sessionLoginFacilityUnit", originFacilityunitid);
        request.getSession().setAttribute("sessionActiveLoginFacilityUnit", originFacilityunitid);

        request.getSession().setAttribute("sessionActiveLoginFacilityTemp", null);
        request.getSession().setAttribute("sessionActiveLoginFacilityUnitTemp", null);
        request.getSession().setAttribute("sessionChanged", null);

        return "refresh";
    }
}