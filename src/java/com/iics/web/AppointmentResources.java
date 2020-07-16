/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.assetsmanager.Blockroom;
import com.iics.assetsmanager.Facilityblock;
import com.iics.controlpanel.Servicetype;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.iics.service.GenericClassService;
import java.util.ArrayList;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/Appointmentresources")
public class AppointmentResources {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/resourcesPane", method = RequestMethod.GET)
    public final ModelAndView ResourcesPane(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        int facilityunitid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());

        return new ModelAndView("controlPanel/localSettingsPanel/appointments/resources/resourcespane", "model", model);

    }

    @RequestMapping(value = "/viewsstaff", method = RequestMethod.GET)
    public final ModelAndView ViewsStaff(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("controlPanel/localSettingsPanel/appointments/resources/views/viewStaff", "model", model);

    }

    @RequestMapping(value = "/service", method = RequestMethod.GET)
    public final ModelAndView Service(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        int facilityunitid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());

        return new ModelAndView("controlPanel/localSettingsPanel/appointments/resources/views/services/views/viewservices", "model", model);

    }

    //IMPLEMENTATION OF SERVICE ACTIVITIES

    @RequestMapping(value = "/serviceActivities", method = RequestMethod.GET)
    public final ModelAndView ServiceActivities(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        //Fetching Facility
        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname", "facilitydomainid"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);
            //facilityDesignations.setFacilitydomainid((Integer) domn[2]);

            model.put("FacilityListZ", facilityDesignations);

        }
        //VIEW SERVICE ACTIVITY IN FACILITY
        List<Servicetype> serviceactivityList = new ArrayList<>();

        String[] params = {"facilityid"};
        Object[] paramsValues = {facilityid};
        String[] fields = {"servicetypeid", "name", "duration", "description", "facilityid", "isactive"};
        String where = "WHERE facilityid=:facilityid";
        List<Object[]> act = (List<Object[]>) genericClassService.fetchRecord(Servicetype.class, fields, where, params, paramsValues);
        if (act != null) {
            for (Object[] acz : act) {
                Servicetype seract = new Servicetype();
                seract.setServicetypeid((Long) acz[0]);
                seract.setName((String) acz[1]);
                seract.setDuration((Integer) acz[2]);
                seract.setDescription((String) acz[3]);
                seract.setIsactive((Boolean) acz[5]);

                serviceactivityList.add(seract);

                model.put("serviceactivityListView", serviceactivityList);
            }
        }

        return new ModelAndView("controlPanel/localSettingsPanel/appointments/resources/views/serviceactivity/views/viewserviceactivity", "model", model);
    }

    @RequestMapping(value = "/Updateserviceactivity.htm")
    public @ResponseBody
    String UpdateServiceActivity(Model model, HttpServletRequest request) {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int facilityid = Integer.parseInt(request.getParameter("facilityid"));
        int servicetypeid = Integer.parseInt(request.getParameter("servicetypeid"));
        int duration = Integer.parseInt(request.getParameter("duration"));

        String[] columns = {"facilityid", "name", "description", "duration", "servicetypeid"};
        Object[] columnValues = {facilityid, name, description, duration, servicetypeid};
        String pk = "servicetypeid";
        Object pkValue = servicetypeid;
        genericClassService.updateRecordSQLSchemaStyle(Servicetype.class, columns, columnValues, pk, pkValue, "controlpanel");
        return "";
    }

    @RequestMapping(value = "/activateDeactivateservicetype", method = RequestMethod.GET)
    public String activateDeactivateServicetype(HttpServletRequest request, Model model, @ModelAttribute("status") boolean isactive, @ModelAttribute("servicetypeid") int servicetypeid) {

        System.out.println("----------b----" + isactive);
        System.out.println("----------v----" + servicetypeid);

        String[] columnslev = {"isactive"};
        Object[] columnValueslev = {isactive};
        String levelPrimaryKey = "servicetypeid";
        Object levelPkValue = servicetypeid;
        genericClassService.updateRecordSQLSchemaStyle(Servicetype.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "controlpanel");
        return "";
    }

    @RequestMapping(value = "/saveserviceactivity", method = RequestMethod.POST)
    public final ModelAndView SaveServiceActivity(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving blocks
            Servicetype serviceAct = new Servicetype();

            String name = request.getParameter("serviceactname");
            String duration = request.getParameter("duration");
            String description = request.getParameter("description");
            String facilityid = request.getParameter("facilityid");

            serviceAct.setName(name);
            serviceAct.setDuration(Integer.parseInt(duration));
            serviceAct.setDescription(description);
            serviceAct.setFacilityid(Integer.parseInt(facilityid));
            serviceAct.setIsactive(Boolean.TRUE);

            Object save = genericClassService.saveOrUpdateRecordLoadObject(serviceAct);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/localSettingsPanel/appointments/resources/views/locationofresources/views/viewlocationofresources", "model", model);
    }

}
