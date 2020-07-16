/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.cronutils.descriptor.CronDescriptor;
import com.cronutils.model.Cron;
import static com.cronutils.model.CronType.QUARTZ;
import com.cronutils.model.definition.CronDefinition;
import com.cronutils.model.definition.CronDefinitionBuilder;
import com.cronutils.parser.CronParser;
import com.iics.controlpanel.Autoactivityrunsetting;
import com.iics.controlpanel.Services;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;
import java.util.concurrent.ScheduledFuture;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.scheduling.support.CronTrigger;
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
@RequestMapping("/schedulerservicesmanagement")
public class SchedulerServicesManagement {

    @Autowired
    private ApplicationContext appContextx;

    @Autowired
    private TaskScheduler taskScheduler;

    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    DateFormat format = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/scheduledservicesmanagementhome.htm", method = RequestMethod.GET)
    public String scheduledservicesmanagementhome(Model model, HttpServletRequest request) {
        List<Map> scheduledservices = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"serviceid", "completed", "crondescription", "description", "servicename", "interrupted", "status", "startondemand", "startonstartup", "lastruntime", "nextruntime", "startingtime", "autoactivityrunsetting", "startingtimepattern", "createdby"};
        List<Object[]> services = (List<Object[]>) genericClassService.fetchRecord(Services.class, fields, "ORDER BY r.servicename ASC", params, paramsValues);
        if (services != null) {
            Map<String, Object> servicerunRow;
            for (Object[] service : services) {
                servicerunRow = new HashMap<>();
                servicerunRow.put("serviceid", service[0]);
                servicerunRow.put("completed", (Boolean) service[1]);
                servicerunRow.put("crondescription", service[2]);
                servicerunRow.put("description", service[3]);
                servicerunRow.put("servicename", service[4]);
                servicerunRow.put("interrupted", (Boolean) service[5]);
                servicerunRow.put("status", (Boolean) service[6]);
                servicerunRow.put("startondemand", (Boolean) service[7]);
                servicerunRow.put("startonstartup", (Boolean) service[8]);
                if (service[9] != null) {
                    servicerunRow.put("lastruntime", format.format((Date) service[9]));
                } else {
                    servicerunRow.put("lastruntime", "No Execution Time");
                }
                servicerunRow.put("nextruntime", service[10]);
                servicerunRow.put("startingtime", service[11]);

                servicerunRow.put("startingtimepattern", service[13]);

                String[] params2 = {"autoactivityrunsettingid"};
                Object[] paramsValues2 = {(Integer) service[12]};
                String[] fields2 = {"beanname", "activityname"};
                List<Object[]> autoactivityrunsetting = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields2, "WHERE autoactivityrunsettingid=:autoactivityrunsettingid", params2, paramsValues2);
                if (autoactivityrunsetting != null) {
                    servicerunRow.put("beanname", autoactivityrunsetting.get(0)[0]);
                }
                String[] params3 = {"personid"};
                Object[] paramsValues3 = {service[14]};
                String[] fields3 = {"firstname", "lastname"};
                List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                if (personname != null) {
                    servicerunRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1]);
                }
                scheduledservices.add(servicerunRow);
            }
        }
        model.addAttribute("scheduledservices", scheduledservices);
        return "controlPanel/universalPanel/schedule/scheduledServicesHome";
    }

    @RequestMapping(value = "/scheduledgetupdatedservices.htm", method = RequestMethod.GET)
    public String scheduledgetupdatedservices(Model model, HttpServletRequest request) {
        List<Map> scheduledservices = new ArrayList<>();

        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"serviceid", "completed", "crondescription", "description", "servicename", "interrupted", "status", "startondemand", "startonstartup", "lastruntime", "nextruntime", "startingtime", "autoactivityrunsetting", "startingtimepattern", "createdby"};
        List<Object[]> services = (List<Object[]>) genericClassService.fetchRecord(Services.class, fields, "ORDER BY r.servicename ASC", params, paramsValues);
        if (services != null) {
            Map<String, Object> servicerunRow;
            for (Object[] service : services) {
                servicerunRow = new HashMap<>();
                servicerunRow.put("serviceid", service[0]);
                servicerunRow.put("completed", (Boolean) service[1]);
                servicerunRow.put("crondescription", service[2]);
                servicerunRow.put("description", service[3]);
                servicerunRow.put("servicename", service[4]);
                servicerunRow.put("interrupted", (Boolean) service[5]);
                servicerunRow.put("status", (Boolean) service[6]);
                servicerunRow.put("startondemand", (Boolean) service[7]);
                servicerunRow.put("startonstartup", (Boolean) service[8]);
                if (service[9] != null) {
                    servicerunRow.put("lastruntime", format.format((Date) service[9]));
                } else {
                    servicerunRow.put("lastruntime", "No Execution Time");
                }
                servicerunRow.put("nextruntime", service[10]);
                servicerunRow.put("startingtime", service[11]);
                servicerunRow.put("startingtimepattern", service[13]);

                String[] params2 = {"autoactivityrunsettingid"};
                Object[] paramsValues2 = {(Integer) service[12]};
                String[] fields2 = {"beanname", "activityname"};
                List<Object[]> autoactivityrunsetting = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields2, "WHERE autoactivityrunsettingid=:autoactivityrunsettingid", params2, paramsValues2);
                if (autoactivityrunsetting != null) {
                    servicerunRow.put("beanname", autoactivityrunsetting.get(0)[0]);
                }
                String[] params3 = {"personid"};
                Object[] paramsValues3 = {service[14]};
                String[] fields3 = {"firstname", "lastname"};
                List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                if (personname != null) {
                    servicerunRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1]);
                }
                scheduledservices.add(servicerunRow);
            }
        }
        model.addAttribute("scheduledservices", scheduledservices);
        return "controlPanel/universalPanel/schedule/views/registeredServices";
    }

    @RequestMapping(value = "/schedulerservicesactivities.htm", method = RequestMethod.GET)
    public String schedulerservicesactivities(Model model, HttpServletRequest request) {
        List<Map> activityFound = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"autoactivityrunsettingid", "activityname", "beanname", "description", "addedby", "added"};
        List<Object[]> autoactivityrunsetting = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields, "ORDER BY r.activityname ASC", params, paramsValues);
        if (autoactivityrunsetting != null) {
            Map<String, Object> autoactivityrunRow;
            for (Object[] autoactivityrun : autoactivityrunsetting) {
                autoactivityrunRow = new HashMap<>();
                autoactivityrunRow.put("autoactivityrunsettingid", autoactivityrun[0]);
                autoactivityrunRow.put("activityname", autoactivityrun[1]);
                autoactivityrunRow.put("beanname", autoactivityrun[2]);
                autoactivityrunRow.put("description", autoactivityrun[3]);
                autoactivityrunRow.put("added", autoactivityrun[5]);
                String[] params1 = {"personid"};
                Object[] paramsValues1 = {(Long) autoactivityrun[4]};
                String[] fields1 = {"firstname", "lastname"};
                List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields1, "WHERE personid=:personid", params1, paramsValues1);
                if (personname != null) {
                    autoactivityrunRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1]);
                }
                activityFound.add(autoactivityrunRow);
            }
        }
        model.addAttribute("activityFound", activityFound);
        return "controlPanel/universalPanel/schedule/views/registeredActivities";
    }

    @RequestMapping(value = "/checkforexistingbeanname.htm")
    public @ResponseBody
    String checkforexistingbeanname(HttpServletRequest request) {
        String response = "";
        Set<String> set = new HashSet<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"beanname", "description"};
        List<Object[]> autoactivityrunsetting = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields, "", params, paramsValues);
        if (autoactivityrunsetting != null) {
            for (Object[] autoactivityrun : autoactivityrunsetting) {
                set.add((String) autoactivityrun[0]);
            }
        }
        try {
            if (appContextx.getBean(request.getParameter("beanname")) != null) {
                if (!set.isEmpty() && !set.contains(request.getParameter("beanname"))) {
                    response = "notnull";
                } else if (set.isEmpty()) {
                    response = "notnull";
                } else {
                    response = "null";
                }
            } else {
                response = "null";
            }
        } catch (BeansException e) {
            response = "null";
        }
        return response;
    }

    @RequestMapping(value = "/saveorupdatenewactivity.htm")
    public @ResponseBody
    String savenewactivity(HttpServletRequest request) {
        String response = "";
        try {
            if (appContextx.getBean(request.getParameter("beanname")) != null) {
                if ("save".equals(request.getParameter("type"))) {
                    Autoactivityrunsetting autoactivityrunsetting = new Autoactivityrunsetting();
                    autoactivityrunsetting.setActivityname(request.getParameter("activity"));
                    autoactivityrunsetting.setAddedby((Long) request.getSession().getAttribute("person_id"));
                    autoactivityrunsetting.setAdded(Boolean.FALSE);
                    autoactivityrunsetting.setBeanname(request.getParameter("beanname"));
                    autoactivityrunsetting.setDescription(request.getParameter("moreinfo"));
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(autoactivityrunsetting);
                    if (save != null) {
                        response = "saved";
                    } else {
                        response = "notsaved";
                    }
                } else if ("update".equals(request.getParameter("type"))) {
                    String[] columns = {"activityname", "description", "beanname"};
                    Object[] columnValues = {request.getParameter("activity"), request.getParameter("moreinfo"), request.getParameter("beanname")};
                    String pk = "autoactivityrunsettingid";
                    Object pkValue = Long.parseLong(request.getParameter("autoactivityrunsettingid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Autoactivityrunsetting.class, columns, columnValues, pk, pkValue, "controlpanel");
                    if (result != 0) {
                        response = "saved";
                    }
                } else if ("delete".equals(request.getParameter("type"))) {
                    String[] columns = {"autoactivityrunsettingid"};
                    Object[] columnValues = {Long.parseLong(request.getParameter("autoactivityrunsettingid"))};
                    int result = genericClassService.deleteRecordByByColumns("controlpanel.autoactivityrunsetting", columns, columnValues);
                    if (result != 0) {
                        response = "saved";
                    }
                } else {

                }
            } else {
                response = "null";
            }
        } catch (BeansException e) {
            response = "null";
        }
        return response;
    }

    @RequestMapping(value = "/addnewservice.htm", method = RequestMethod.GET)
    public String addnewservice(Model model, HttpServletRequest request) {
        List<Map> activityFound = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"autoactivityrunsettingid", "activityname", "beanname", "description", "addedby", "added"};
        List<Object[]> autoactivityrunsetting = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields, "ORDER BY r.activityname ASC", params, paramsValues);
        if (autoactivityrunsetting != null) {
            Map<String, Object> autoactivityrunRow;
            for (Object[] autoactivityrun : autoactivityrunsetting) {
                autoactivityrunRow = new HashMap<>();
                if ((Boolean) autoactivityrun[5] == false) {
                    autoactivityrunRow.put("autoactivityrunsettingid", autoactivityrun[0]);
                    autoactivityrunRow.put("activityname", autoactivityrun[1]);
                    autoactivityrunRow.put("description", autoactivityrun[3]);
                    autoactivityrunRow.put("beanname", autoactivityrun[2]);
                    activityFound.add(autoactivityrunRow);
                }
            }
        }
        model.addAttribute("activityFound", activityFound);
        return "controlPanel/universalPanel/schedule/forms/newService";
    }

    @RequestMapping(value = "/saveScheduledService.htm")

    public @ResponseBody
    String savenewmanuallorautomaticservice(HttpServletRequest request) {
        String response = "";

        Services services = new Services();

        services.setServicename(request.getParameter("servicename"));
        services.setInterrupted(false);
        services.setCreatedby((Long) request.getSession().getAttribute("person_id"));
        services.setAutoactivityrunsetting(Integer.parseInt(request.getParameter("autoid")));
        services.setDescription(request.getParameter("description"));
        services.setDatecreated(new Date());
        CronTrigger trigger = new CronTrigger(request.getParameter("cron"));

        if ("manual".equals(request.getParameter("type"))) {
            services.setStartondemand(Boolean.TRUE);
            services.setStartonstartup(Boolean.FALSE);
            services.setCrondescription("Run manually on demand");

        } else {

            services.setStartondemand(Boolean.FALSE);
            services.setStartonstartup(Boolean.TRUE);

            CronSequenceGenerator generator = new CronSequenceGenerator(request.getParameter("cron"), TimeZone.getDefault());
            final Date nextExecutionDate = generator.next(new Date());
            CronDefinition cronDefinition = CronDefinitionBuilder.instanceDefinitionFor(QUARTZ); //CronDefinitionRegistry.instance().retrieve(QUARTZ);

            //create a parser based on provided definition
            CronParser parser = new CronParser(cronDefinition);
            Cron quartzCron = parser.parse(request.getParameter("cron"));

            //create a descriptor for a specific Locale
            CronDescriptor descriptor = CronDescriptor.instance(Locale.getDefault());
            //parse some expression and ask descriptor for description
            String descriptionx = descriptor.describe(quartzCron);
            services.setNextruntime(nextExecutionDate);

            services.setCrondescription(descriptionx);
            services.setStartingtimepattern(request.getParameter("cron"));

        }

        Object save = genericClassService.saveOrUpdateRecordLoadObject(services);
        if (save != null) {
            String[] columns = {"added"};
            Object[] columnValues = {Boolean.TRUE};
            String pk = "autoactivityrunsettingid";
            Object pkValue = Long.parseLong(request.getParameter("autoid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Autoactivityrunsetting.class, columns, columnValues, pk, pkValue, "controlpanel");
            if (result != 0) {
                response = "saved";
            }
            if ("manual".equals(request.getParameter("type"))) {
                ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), new Date());
            } else {
                ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), trigger);
            }
        }

        return response;
    }

    @RequestMapping(value = "/runManualService.htm")
    public @ResponseBody
    String runManualService(HttpServletRequest request) {
        String response = "";
        try {
            if ("mannual".equals(request.getParameter("type"))) {
                if (appContextx.getBean(request.getParameter("beanname")) != null) {
                    ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), new Date());

                }
            } else {
                if (appContextx.getBean(request.getParameter("beanname")) != null) {
                    CronTrigger trigger = new CronTrigger(request.getParameter("startingtimepattern"));
                    ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), trigger);
                }
            }
        } catch (BeansException e) {

        }

        return response;
    }

    @RequestMapping(value = "/deleteservice.htm")
    public @ResponseBody
    String deleteservice(HttpServletRequest request) {
        String response = "";
        String[] columns = {"serviceid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("serviceid"))};
        int result = genericClassService.deleteRecordByByColumns("controlpanel.services", columns, columnValues);
        if (result != 0) {
            response = "success";
        }
        return response;
    }

    @RequestMapping(value = "/updateservice.htm", method = RequestMethod.GET)
    public String updateservice(Model model, HttpServletRequest request) {
        List<Map> activityFound = new ArrayList<>();

        String[] params2 = {"serviceid"};
        Object[] paramsValues2 = {Integer.parseInt(request.getParameter("serviceid"))};
        String[] fields2 = {"autoactivityrunsetting", "description"};
        List<Object[]> autoactivityrunsettingid = (List<Object[]>) genericClassService.fetchRecord(Services.class, fields2, "WHERE serviceid=:serviceid", params2, paramsValues2);
        if (autoactivityrunsettingid != null) {

            model.addAttribute("description", autoactivityrunsettingid.get(0)[1]);

            String[] params = {"autoactivityrunsettingid"};
            Object[] paramsValues = {autoactivityrunsettingid.get(0)[0]};
            String[] fields = {"autoactivityrunsettingid", "activityname", "beanname", "description", "addedby", "added"};
            List<Object[]> autoactivityrunsetting = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields, "WHERE autoactivityrunsettingid=:autoactivityrunsettingid", params, paramsValues);
            if (autoactivityrunsetting != null) {
                for (Object[] autoactivityrun : autoactivityrunsetting) {
                    model.addAttribute("autoactivityrunsettingid", autoactivityrun[0]);
                    model.addAttribute("activityname", autoactivityrun[1]);
                    model.addAttribute("description", autoactivityrun[3]);
                    model.addAttribute("beanname", autoactivityrun[2]);
                }
            }

        }
        model.addAttribute("serviceid", request.getParameter("serviceid"));
        model.addAttribute("servicename", request.getParameter("servicename"));
        model.addAttribute("startonstartup", request.getParameter("startonstartup"));
        model.addAttribute("startondemand", request.getParameter("startondemand"));
        return "controlPanel/universalPanel/schedule/forms/updateService";
    }

    @RequestMapping(value = "/updateScheduledService.htm")
    public @ResponseBody
    String updateScheduledService(HttpServletRequest request) {
        String response = "";
        CronTrigger trigger = new CronTrigger(request.getParameter("cron"));
        CronSequenceGenerator generator = new CronSequenceGenerator(request.getParameter("cron"), TimeZone.getDefault());
        final Date nextExecutionDate = generator.next(new Date());
        CronDefinition cronDefinition = CronDefinitionBuilder.instanceDefinitionFor(QUARTZ); //CronDefinitionRegistry.instance().retrieve(QUARTZ);

        //create a parser based on provided definition
        CronParser parser = new CronParser(cronDefinition);
        Cron quartzCron = parser.parse(request.getParameter("cron"));

        //create a descriptor for a specific Locale
        CronDescriptor descriptor = CronDescriptor.instance(Locale.getDefault());
        //parse some expression and ask descriptor for description
        String descriptionx = descriptor.describe(quartzCron);

        if (null != request.getParameter("type")) {
            switch (request.getParameter("type")) {
                case "tomannual": {
                    String[] columns = {"servicename", "startondemand", "startonstartup", "datechanged", "description", "changedby"};
                    Object[] columnValues = {request.getParameter("servicename"), Boolean.TRUE, Boolean.FALSE, new Date(), request.getParameter("description"), (Long) request.getSession().getAttribute("person_id")};
                    String pk = "serviceid";
                    Object pkValue = Integer.parseInt(request.getParameter("serviceid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");
                    if (result != 0) {
                        if (appContextx.getBean(request.getParameter("beanname")) != null) {
                            ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), new Date());
                        }
                        response = "success";
                    }
                    break;
                }
                case "toauto": {
                    String[] columns = {"servicename", "startondemand", "startonstartup", "datechanged", "description", "crondescription", "startingtimepattern", "nextruntime", "changedby"};
                    Object[] columnValues = {request.getParameter("servicename"), Boolean.FALSE, Boolean.TRUE, new Date(), request.getParameter("description"), descriptionx, request.getParameter("cron"), nextExecutionDate, (Long) request.getSession().getAttribute("person_id")};
                    String pk = "serviceid";
                    Object pkValue = Integer.parseInt(request.getParameter("serviceid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");
                    if (result != 0) {
                        if (appContextx.getBean(request.getParameter("beanname")) != null) {
                            ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), trigger);
                        }
                        response = "success";
                    }
                    break;
                }
                case "auto": {
                    String[] columns = {"servicename", "datechanged", "description", "crondescription", "startingtimepattern", "nextruntime", "changedby"};
                    Object[] columnValues = {request.getParameter("servicename"), new Date(), request.getParameter("description"), descriptionx, request.getParameter("cron"), nextExecutionDate, (Long) request.getSession().getAttribute("person_id")};
                    String pk = "serviceid";
                    Object pkValue = Integer.parseInt(request.getParameter("serviceid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");
                    if (result != 0) {
                        if (appContextx.getBean(request.getParameter("beanname")) != null) {
                            ScheduledFuture scedulefuture2 = taskScheduler.schedule((Runnable) appContextx.getBean(request.getParameter("beanname")), trigger);
                        }
                        response = "success";
                    }
                    break;
                }
                case "mannual": {
                    String[] columns = {"servicename", "datechanged", "description", "changedby"};
                    Object[] columnValues = {request.getParameter("servicename"), new Date(), request.getParameter("description"), (Long) request.getSession().getAttribute("person_id")};
                    String pk = "serviceid";
                    Object pkValue = Integer.parseInt(request.getParameter("serviceid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");
                    if (result != 0) {
                        response = "success";
                    }
                    break;
                }
                default:
                    break;
            }
        }
        return response;
    }
}
