/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Queuetype;
import com.iics.service.GenericClassService;
import com.iics.store.Zone;
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
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author SAMINUNU
 */
@Controller
@RequestMapping("/queuingsystemsettings")

public class QueueTypes {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/queuepane", method = RequestMethod.GET)
    public final ModelAndView queuePane(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        //Fetch QueueTypes
        List<Queuetype> queuetypeList = new ArrayList<>();
        String[] paramsqueuetype = {};
        Object[] paramsValuesqueuetype = {};
        String[] fieldsqueuetype = {"queuetypeid", "name", "weight", "description", "queuestatus"};
        String wherequeuetype = "";
        List<Object[]> queuetypes = (List<Object[]>) genericClassService.fetchRecord(Queuetype.class, fieldsqueuetype, wherequeuetype, paramsqueuetype, paramsValuesqueuetype);
        if (queuetypes != null) {
            for (Object[] queue : queuetypes) {

                Queuetype queuetypeObj = new Queuetype();

                queuetypeObj.setQueuetypeid((Long) queue[0]);
                queuetypeObj.setName((String) queue[1]);
                queuetypeObj.setWeight((Integer) queue[2]);
                queuetypeObj.setDescription((String) queue[3]);
                queuetypeObj.setQueuestatus((Boolean) queue[4]);
                queuetypeList.add(queuetypeObj);
            }
            model.put("queuingList", queuetypeList);
        }

        return new ModelAndView("controlPanel/universalPanel/Queues/queuingpane", "model", model);
    }

    @RequestMapping(value = "/viewqueuetypes", method = RequestMethod.GET)
    public final ModelAndView viewQueueTypes(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("controlPanel/universalPanel/Queues/view/viewqueuetypes", "model", model);
    }

    @RequestMapping(value = "/savequeuingtypes", method = RequestMethod.POST)
    public final ModelAndView saveQueuingTypes(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            //saving queuing types
            Queuetype queuetypeObj = new Queuetype();

            String name = request.getParameter("name");
            String weight = request.getParameter("weight");
            String description = request.getParameter("description");

            queuetypeObj.setName(name);
            queuetypeObj.setWeight(Integer.parseInt(weight));
            queuetypeObj.setDescription(description);

            Object save = genericClassService.saveOrUpdateRecordLoadObject(queuetypeObj);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/Queues/view/viewqueuetypes", "model", model);
    }

    @RequestMapping(value = "/updatequeuingtypes", method = RequestMethod.POST)
    public @ResponseBody
    String updateQueuingTypes(HttpServletRequest request) {
        try {
            //update queuing types

            String name = request.getParameter("name");
            int weight = Integer.parseInt(request.getParameter("weight"));
            String description = request.getParameter("description");
            Long queuetypeid = Long.parseLong(request.getParameter("queuetypeid"));
            //String queuetypeid = request.getParameter("queuetypeid");

            String[] columns = {"queuetypeid", "name", "weight", "description"};
            Object[] columnValues = {queuetypeid, name, weight, description};
            String pk = "queuetypeid";
            Object pkValue = queuetypeid;
            genericClassService.updateRecordSQLSchemaStyle(Queuetype.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/checkWeight", method = RequestMethod.GET)
    public @ResponseBody
    String checkWeight(HttpServletRequest request, Model model, @ModelAttribute("weights") String weights) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
//            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"weight"};
            Object[] paramsValues = {Integer.parseInt(weights)};
            String[] fields = {"queuetypeid", "name", "description"};
            String where = "WHERE weight=:weight";
            List<Object[]> queuewgts = (List<Object[]>) genericClassService.fetchRecord(Queuetype.class, fields, where, params, paramsValues);
            if (queuewgts != null) {
                Map<String, Object> queuewgt = new HashMap<>();
                queuewgt.put("queuetypeid", queuewgts.get(0)[0]);
                queuewgt.put("name", queuewgts.get(0)[1]);
                queuewgt.put("description", queuewgts.get(0)[2]);
                try {
                    res = new ObjectMapper().writeValueAsString(queuewgt);

                    System.out.println("com.iics.web.QueueTypes.checkWeight()" + res);
                } catch (JsonProcessingException ex) {
                    System.out.println(ex);
                }
            }
            return res;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/activateDeactivatequeue", method = RequestMethod.GET)
    public String activateDeactivatequeue(HttpServletRequest request, Model model, @ModelAttribute("queuestatus") String queues, @ModelAttribute("queuetypeid") long queuetypeid) {
        
        boolean queuestatus = Boolean.parseBoolean(queues);
        
        System.out.println("----------b----" + queuestatus);
        System.out.println("----------v----" + queuetypeid);
        
        String[] columnslev = {"queuestatus"};
        Object[] columnValueslev = {queuestatus};
        String levelPrimaryKey = "queuetypeid";
        Object levelPkValue = queuetypeid;
        genericClassService.updateRecordSQLSchemaStyle(Queuetype.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
        return "";
    }
    
      @RequestMapping(value = "/removequeuetype", method = RequestMethod.POST)
    public @ResponseBody
    String removeQueueType(HttpServletRequest request, Model model, @ModelAttribute("queuetypeid") int queuetypeid) {
        String results = "";

        String[] columnslev = {"queuestatus"};
        Object[] columnValueslev = {Boolean.FALSE};
        String levelPrimaryKey = "queuetypeid";
        Object levelPkValue = queuetypeid;
        int result = genericClassService.updateRecordSQLSchemaStyle(Queuetype.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
        if (result != 0) {
            results = "success";
        }
        return results;
    }
}
