/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.filemanager;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.filemanger.FileLocation;
import com.iics.service.GenericClassService;
import com.iics.service.filemanager.Filemanagerservicelocator;
import com.iics.service.filemanager.ManageLocationService;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/filelocation")
public class FileLocationManager {

   // Filemanagerservicelocator f = Filemanagerservicelocator.getInstance();
    private @Autowired ManageLocationService manageLocationService;

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/locationdetails", method = RequestMethod.GET)
    public String viewFilLocationDetails(HttpServletRequest request, Model model) {
        return "fileManagement/views/files/locationdetails";
    }

    @RequestMapping(value = {"/newlocation"}, method = RequestMethod.GET)
    public @ResponseBody
    String assignFileLocation(HttpServletRequest request, ModelMap model) throws ParseException {
        int cellid = Integer.parseInt(request.getParameter("cellid"));
        String fileNo = request.getParameter("fileNo");
        int zoneid = Integer.parseInt(request.getParameter("zoneid"));
        FileLocation loc = new FileLocation();
        loc.setZoneid(zoneid);
        loc.setFileno(fileNo);
        loc.setCellid(cellid);
        loc.setDatecreated(new Date());
        loc = (FileLocation) genericClassService.saveOrUpdateRecordLoadObject(loc);
        String result = "";
        Map<String, Object> fileObjMap = new HashMap();
        if (loc != null) {
            fileObjMap.put("status", "succes");
            fileObjMap.put("message", "Successfully added new Location");
        } else {
            fileObjMap.put("status", "failed");
            fileObjMap.put("message", "Failed to add new Location");
            System.out.println("Failed to add new Location");
        }
        try {
            result = new ObjectMapper().writeValueAsString(fileObjMap);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return result;
    }

    @RequestMapping(value = "/updatelocation", method = RequestMethod.GET)
    public String getUpdatePatientFileForm(HttpServletRequest request, Model model) {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        List<Map> zones = manageLocationService.fetchZones(Long.parseLong(facilityidsession), genericClassService);
        model.addAttribute("zones", zones);
        return "fileManagement/forms/updateFileForm";
    }

    @RequestMapping(value = {"/updatelocation"}, method = RequestMethod.POST)
    public @ResponseBody
    String updateFileLocation(HttpServletRequest request, ModelMap model) throws ParseException {
        int cellid = Integer.parseInt(request.getParameter("cellid"));
        int zoneid = Integer.parseInt(request.getParameter("zoneid"));
        int locationid = Integer.parseInt(request.getParameter("locationid"));
        String fileno = request.getParameter("fileno");
        String[] columns = {"zoneid", "cellid", "fileno"};
        Object[] columnValues = {zoneid, cellid, fileno};
        String pk = "locationid";
        Object pkValue = locationid;
        int id = -1;
        id = genericClassService.updateRecordSQLSchemaStyle(FileLocation.class, columns, columnValues, pk, pkValue, "patient");
        if (id != -1) {
            String results = "";
            try {
                results = new ObjectMapper().writeValueAsString(manageLocationService.locationDetails(fileno, genericClassService));
            } catch (JsonProcessingException ex) {
                Logger.getLogger(ManageFile.class.getName()).log(Level.SEVERE, null, ex);
            }
            return results;
        } else {
            return "failed";
        }
    }

    @RequestMapping(value = {"/fetchbays"}, method = RequestMethod.GET)
    public @ResponseBody
    String fetchBays(HttpServletRequest request, ModelMap model) throws ParseException {
        int zoneid = Integer.parseInt(request.getParameter("zoneid"));
        String results = "";
        int storagemechanismid = 2;
        try {
            results = new ObjectMapper().writeValueAsString(manageLocationService.fetchAllBays(zoneid, storagemechanismid, genericClassService));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(FileLocationManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(results);
        return results;
    }

    @RequestMapping(value = {"/fetchbayrows"}, method = RequestMethod.GET)
    public @ResponseBody
    String fetchBayrows(HttpServletRequest request, ModelMap model) throws ParseException {
        int zonebayid = Integer.parseInt(request.getParameter("bayid"));
        String results = "";
        try {
            results = new ObjectMapper().writeValueAsString(manageLocationService.fetchAllBayRows(zonebayid, genericClassService));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(FileLocationManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(results);
        return results;
    }

    @RequestMapping(value = {"/fetchcells"}, method = RequestMethod.GET)
    public @ResponseBody
    String fetchCells(HttpServletRequest request, ModelMap model) throws ParseException {

        int bayrowid = Integer.parseInt(request.getParameter("bayrowid"));
        String results = "";
        int storagetypeid = 4;
        try {
            results = new ObjectMapper().writeValueAsString(manageLocationService.fetchCells(bayrowid, storagetypeid, genericClassService));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(FileLocationManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(results);
        return results;
    }
}
