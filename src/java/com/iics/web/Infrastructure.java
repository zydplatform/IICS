/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.domain.Buildingfloors;
import com.iics.domain.Facility;
import com.iics.domain.Facilitybuildings;
import com.iics.domain.Floorrooms;
import com.iics.service.GenericClassService;
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

/**
 *
 * @author USER 1
 */
@Controller
@RequestMapping("/infrastructure")
public class Infrastructure {
     @Autowired
    GenericClassService genericservice;
    
     
      /* method for manage infrastructure*/
    @RequestMapping(value = "/manageinfrastructure", method = RequestMethod.GET)
    public String manageinfrastructure(HttpServletRequest request, Model model) {

        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");

        //Fetching Facility
        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericservice.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityLists", facilityDesignations);
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/infrastructure";

    }
    
    
     /*method for fetching buildings from the database*/
    @RequestMapping(value = "/facilityinfrastructure", method = RequestMethod.GET)
    public String manageFacilityStructure(HttpServletRequest request, Model model) {

        List<Map> buildingList = new ArrayList<>();
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");

        String[] params = {"facilityid"};
        Object[] paramValues = {facilityid};
        String[] fields = {"buildingid", "buildingname", "isactive"};
        String where = "WHERE facilityid =:facilityid";
        List<Object[]> facilitybuilding = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, where, params, paramValues);
        Map<String, Object> fbuilds;
        if (facilitybuilding != null) {
            for (Object[] building : facilitybuilding) {
                int roomsinbuilding = 0;
                fbuilds = new HashMap<>();
                fbuilds.put("buildingid", building[0]);
                fbuilds.put("buildingname", (String) building[1]);
                fbuilds.put("facilityid", building[2]);
                int count = genericservice.fetchRecordCount(Buildingfloors.class, "WHERE buildingid=:buildingid", new String[]{"buildingid"}, new Object[]{(Integer) building[0]});
                fbuilds.put("floorsize", count);

                String[] params1 = {"buildingid"};
                Object[] paramsValues1 = {(Integer) building[0]};
                String[] fields1 = {"floorid", "buildingid", "floorname"};
                String where1 = "WHERE buildingid=:buildingid";
                List<Object[]> buldingfloors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fields1, where1, params1, paramsValues1);
                if (buldingfloors != null) {
                    for (Object[] floor : buldingfloors) {
                        int roomCounter;
                        String[] paramsf = {"floorid"};
                        Object[] paramsValuesf = {(Integer) floor[0]};
                        String[] fieldsf = {"roomid", "floorid", "roomname"};
                        String wheref = "WHERE floorid=:floorid";
                        roomCounter = genericservice.fetchRecordCount(Floorrooms.class, wheref, paramsf, paramsValuesf);
                        roomsinbuilding = roomsinbuilding + roomCounter;

                    }

                    int roomCounter;
                    String wherer = "WHERE r.roomid IN (SELECT f.roomid FROM Floorrooms f WHERE f.floorid IN (SELECT fb.floorid FROM Buildingfloors fb WHERE fb.buildingid=:buildingid))";
                    roomCounter = genericservice.fetchRecordCount(Floorrooms.class, wherer, params1, paramsValues1);
                    fbuilds.put("roomsinbuilding", roomCounter);

                    System.out.println("------------------------------roomCounter" + roomCounter);

                }
                buildingList.add(fbuilds);

            }
            model.addAttribute("buildingLists", buildingList);
        }

        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericservice.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityListed", facilityDesignations);

        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/views/table";
    }
}
