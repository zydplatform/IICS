/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facility;
import com.iics.domain.Facilitylevel;
import com.iics.service.GenericClassService;
import com.iics.store.Item;
import java.io.IOException;
import java.util.ArrayList;
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
 * @author IICS
 */
@Controller
@RequestMapping("/facilitylevelmanagement")
public class FacilityLevelManagement {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/facilitylevels.htm", method = RequestMethod.GET)
    public String facilitylevels(Model model, HttpServletRequest request) {
        List<Map> faclilityLevelList = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"facilitylevelid", "shortname", "facilitylevelname", "description"};
        String where = "ORDER BY r.facilitylevelname ASC";
        List<Object[]> facilitylevels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields, where, params, paramsValues);
        if (facilitylevels != null) {
            Map<String, Object> facilityLevelsRow;
            for (Object[] facilitylevel : facilitylevels) {
                facilityLevelsRow = new HashMap<>();
                facilityLevelsRow.put("facilitylevelid", facilitylevel[0]);
                facilityLevelsRow.put("shortname", facilitylevel[1]);
                facilityLevelsRow.put("facilitylevelname", facilitylevel[2]);
                facilityLevelsRow.put("description", facilitylevel[3]);
                faclilityLevelList.add(facilityLevelsRow);
            }
        }
        model.addAttribute("faclilityLevelList", faclilityLevelList);
        return "controlPanel/universalPanel/facility/views/viewFacilityLevels";
    }

    @RequestMapping(value = "/updatefacilitylevel.htm")
    public @ResponseBody
    String updatefacilitylevel(HttpServletRequest request) {
        String response = "";
        String[] columns = {"facilitylevelname", "shortname", "description"};
        Object[] columnValues = {request.getParameter("name"), request.getParameter("shortname"), request.getParameter("description")};
        String pk = "facilitylevelid";
        Object pkValue = Integer.parseInt(request.getParameter("facilitylevelid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Facilitylevel.class, columns, columnValues, pk, pkValue, "public");
        if (result != 0) {
            response = "success";
        }
        return response;
    }

    @RequestMapping(value = "/savenewfacilitylevel.htm")
    public @ResponseBody
    String savenewfacilitylevel(HttpServletRequest request) {
        String response = "";
        Facilitylevel facilitylevel = new Facilitylevel();
        facilitylevel.setDescription(request.getParameter("desc"));
        facilitylevel.setFacilitylevelname(request.getParameter("name"));
        facilitylevel.setShortname(request.getParameter("shortname"));
        Object save = genericClassService.saveOrUpdateRecordLoadObject(facilitylevel);
        if (save != null) {
            response = "success";
        } else {
            response = "failed";
        }
        return response;
    }

    @RequestMapping(value = "/deletefacilitylevel.htm")
    public @ResponseBody
    String deletefacilitylevel(HttpServletRequest request) {
        String response = "";
        String[] params = {"facilitylevelid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilitylevelid"))};
        String[] fields = {"facilityid", "facilityname"};
        String where = "WHERE r.facilitylevelid.facilitylevelid=:facilitylevelid";
        List<Object[]> facilitys = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
        if (facilitys == null) {
            String[] params1 = {"levelofuse"};
            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("facilitylevelid"))};
            String[] fields1 = {"itemid", "genericname"};
            String where1 = "WHERE levelofuse=:levelofuse";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields1, where1, params1, paramsValues1);
            if (items == null) {
                String[] columns1 = {"facilitylevelid"};
                Object[] columnValues1 = {Long.parseLong(request.getParameter("facilitylevelid"))};
                int result1 = genericClassService.deleteRecordByByColumns("facilitylevel", columns1, columnValues1);
                if (result1 != 0) {
                    response = "deleted" + "-" + 0;
                }
            } else {
                response = "hasitems" + '-' + items.size();
            }
        } else {
            response = "hasfacilities" + '-' + facilitys.size();
        }
        return response;
    }

    @RequestMapping(value = "/getfacilityieslist.htm", method = RequestMethod.GET)
    public String getfacilityieslist(Model model, HttpServletRequest request) {
        List<Map> faclilityList = new ArrayList<>();
        List<Map> faclilityLevelsList = new ArrayList<>();
        String[] params = {"facilitylevelid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilitylevelid"))};
        String[] fields = {"facilityid", "facilityname"};
        String where = "WHERE r.facilitylevelid.facilitylevelid=:facilitylevelid";
        List<Object[]> facilitys = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
        if (facilitys != null) {
            Map<String, Object> facilityRow;
            for (Object[] facility : facilitys) {
                facilityRow = new HashMap<>();
                facilityRow.put("facilityid", facility[0]);
                facilityRow.put("facilityname", facility[1]);
                faclilityList.add(facilityRow);
            }
        }
        String[] params1 = {"facilitylevelid"};
        Object[] paramsValues1 = {Integer.parseInt(request.getParameter("facilitylevelid"))};
        String[] fields1 = {"facilitylevelid", "facilitylevelname", "shortname"};
        String where1 = "WHERE facilitylevelid !=:facilitylevelid";
        List<Object[]> facilitylevels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields1, where1, params1, paramsValues1);
        if (facilitylevels != null) {
            Map<String, Object> facilitylevelsRow;
            for (Object[] facilitylevel : facilitylevels) {
                facilitylevelsRow = new HashMap<>();
                facilitylevelsRow.put("facilitylevelid", facilitylevel[0]);
                facilitylevelsRow.put("facilitylevelname", facilitylevel[1]);
                facilitylevelsRow.put("shortname", facilitylevel[2]);
                faclilityLevelsList.add(facilitylevelsRow);
            }
        }
        model.addAttribute("faclilityList", faclilityList);
        model.addAttribute("faclilityLevelsList", faclilityLevelsList);
        model.addAttribute("facilitylevelid", request.getParameter("facilitylevelid"));
        return "controlPanel/universalPanel/facility/forms/transferFacility";
    }

    @RequestMapping(value = "/transferfacilitylevelfacility.htm")
    public @ResponseBody
    String transferfacilitylevelfacility(HttpServletRequest request) {
        String response = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("facilityids"), List.class);
            for (String facilityid : item) {
                String[] columns = {"facilitylevelid"};
                Object[] columnValues = {new Facilitylevel(Integer.parseInt(request.getParameter("destinationid")))};
                String pk = "facilityid";
                Object pkValue = Integer.parseInt(facilityid);
                int result = genericClassService.updateRecordSQLSchemaStyle(Facility.class, columns, columnValues, pk, pkValue, "public");
            }
            String[] params = {"facilitylevelid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("facilitylevelid"))};
            String[] fields = {"facilityid", "facilityname"};
            String where = "WHERE r.facilitylevelid.facilitylevelid=:facilitylevelid";
            List<Object[]> facilitys = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
            if (facilitys == null) {
                String[] params1 = {"levelofuse"};
                Object[] paramsValues1 = {Integer.parseInt(request.getParameter("facilitylevelid"))};
                String[] fields1 = {"itemid", "genericname"};
                String where1 = "WHERE levelofuse=:levelofuse";
                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields1, where1, params1, paramsValues1);
                if (items == null) {
                    response = "delete" + "-" + 0;
                } else {
                    response = "hasitems" + "-" + items.size();
                }
            } else {
                response = "hasfacility" + "-" + facilitys.size();
            }
        } catch (IOException e) {

        }

        return response;
    }

    @RequestMapping(value = "/gettransferfacilitylevelitems.htm", method = RequestMethod.GET)
    public String transferfacilitylevelitems(Model model, HttpServletRequest request) {
        List<Map> itemsList = new ArrayList<>();
        List<Map> facilitylevelsList = new ArrayList<>();
        String[] params1 = {"levelofuse"};
        Object[] paramsValues1 = {Integer.parseInt(request.getParameter("facilitylevelid"))};
        String[] fields1 = {"itemid", "genericname"};
        String where1 = "WHERE levelofuse=:levelofuse";
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields1, where1, params1, paramsValues1);
        if (items != null) {
            Map<String, Object> itemsRow;
            for (Object[] item : items) {
                itemsRow = new HashMap<>();
                itemsRow.put("itemid", item[0]);
                itemsRow.put("genericname", item[1]);
                itemsList.add(itemsRow);
            }
        }
        String[] params = {"facilitylevelid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilitylevelid"))};
        String[] fields = {"facilitylevelid", "facilitylevelname", "shortname"};
        String where = "WHERE facilitylevelid !=:facilitylevelid";
        List<Object[]> facilitys = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields, where, params, paramsValues);
        if (facilitys != null) {
            Map<String, Object> levelsRow;
            for (Object[] facilitylevel : facilitys) {
                levelsRow = new HashMap<>();
                levelsRow.put("facilitylevelid", facilitylevel[0]);
                levelsRow.put("facilitylevelname", facilitylevel[1]);
                levelsRow.put("shortname", facilitylevel[2]);
                facilitylevelsList.add(levelsRow);
            }
        }
        model.addAttribute("itemsList", itemsList);
        model.addAttribute("facilitylevelsList", facilitylevelsList);
        model.addAttribute("facilitylevelid", request.getParameter("facilitylevelid"));
        model.addAttribute("type", request.getParameter("type"));
        return "controlPanel/universalPanel/facility/forms/transferItems";
    }

    @RequestMapping(value = "/transferfacilitylevelitems.htm")
    public @ResponseBody
    String transferfacilitylevelitems(HttpServletRequest request) {
        String response = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemids"), List.class);
            for (String itemid : item) {
                String[] columns = {"levelofuse"};
                Object[] columnValues = {Integer.parseInt(request.getParameter("destinationid"))};
                String pk = "itemid";
                Object pkValue = Long.parseLong(itemid);
                int result = genericClassService.updateRecordSQLSchemaStyle(Item.class, columns, columnValues, pk, pkValue, "store");
            }
            String[] params1 = {"levelofuse"};
            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("facilitylevelid"))};
            String[] fields1 = {"itemid", "genericname"};
            String where1 = "WHERE levelofuse=:levelofuse";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields1, where1, params1, paramsValues1);
            if (items == null) {
                response = "delete";
            } else {
                response = "hasitems";
            }

        } catch (IOException e) {
        }
        return response;
    }
}
