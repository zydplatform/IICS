/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Accessrightgroupprivilege;
import com.iics.controlpanel.Accessrightsgroup;
import com.iics.controlpanel.Facilityprivilege;
import com.iics.controlpanel.Privilege;
import com.iics.controlpanel.Staffassignedrights;
import com.iics.controlpanel.Stafffacilityunitaccessrightprivilege;
import com.iics.controlpanel.Systemmodule;
import com.iics.controlpanel.Systemroleprivilege;
import com.iics.domain.Designationcategory;
import com.iics.domain.Facility;
import com.iics.service.GenericClassService;
import com.iics.utils.CustomSystemmodule;
import java.io.IOException;
import java.math.BigInteger;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/activitiesandaccessrights")
public class ActivitiesAndAccessRightsController {
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/template.htm", method = RequestMethod.GET)
    public String template(Model model, HttpServletRequest request) {
        return "controlPanel/universalPanel/activitiesAndRights/modulesAndComponents/views/template";
    }

    @RequestMapping(value = "/activitiesandaccessrights_tabs.htm", method = RequestMethod.GET)
    public String controlPanelMenu(Model model, HttpServletRequest request) {
        List<Map> systemmodulesList = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            model.addAttribute("systemmoduleclicked", "a");
            model.addAttribute("act", "a");
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};
//        String where = "";

            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                Map<String, Object> systemmoduleRow;
                for (Object[] systemmod : systemmodules) {
                    int systemmoduleCount = 0;
                    systemmoduleRow = new HashMap<>();
                    String[] params2 = {"parentid"};
                    Object[] paramsValues2 = {(Long) systemmod[0]};
                    String where2 = "WHERE parentid=:parentid";
                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                    systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                    systemmoduleRow.put("systemmodulename", (String) systemmod[1]);
                    systemmoduleRow.put("dateadded", formatter.format((Date) systemmod[2]));
                    systemmoduleRow.put("dateupadated", formatter.format((Date) systemmod[3]));
                    systemmoduleRow.put("status", (Boolean) systemmod[4]);
                    systemmoduleRow.put("hasprivilege", (Boolean) systemmod[5]);
                    systemmoduleRow.put("systemmoduleid", (Long) systemmod[0]);
                    systemmoduleRow.put("description", (String) systemmod[6]);
                    systemmoduleRow.put("activity", (String) systemmod[7]);
                    systemmodulesList.add(systemmoduleRow);
                }
            }
        } else if ("b".equals(request.getParameter("act"))) {
            model.addAttribute("systemmoduleclicked", Long.parseLong(request.getParameter("i")));
            model.addAttribute("act", "b");
            String[] params = {"parentid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("i"))};
            String[] fields = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};
            String where = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (systemmodules != null) {
                Map<String, Object> systemmoduleRow;
                for (Object[] submod : systemmodules) {
                    systemmoduleRow = new HashMap<>();
                    int systemmoduleCount = 0;
                    systemmoduleRow = new HashMap<>();
                    String[] params2 = {"parentid"};
                    Object[] paramsValues2 = {(Long) submod[0]};
                    String where2 = "WHERE parentid=:parentid";
                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                    systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                    systemmoduleRow.put("systemmodulename", (String) submod[1]);
                    systemmoduleRow.put("dateadded", formatter.format((Date) submod[2]));
                    systemmoduleRow.put("dateupadated", formatter.format((Date) submod[3]));
                    systemmoduleRow.put("status", (Boolean) submod[4]);
                    systemmoduleRow.put("hasprivilege", (Boolean) submod[5]);
                    systemmoduleRow.put("systemmoduleid", (Long) submod[0]);
                    systemmoduleRow.put("description", (String) submod[6]);
                    systemmoduleRow.put("activity", (String) submod[7]);
                    systemmodulesList.add(systemmoduleRow);
                }
            }
        } else if ("c".equals(request.getParameter("act"))) {
            String[] params = {"systemmoduleid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("i"))};
            String[] fields = {"parentid.systemmoduleid", "componentname"};
            String where = "WHERE systemmoduleid=:systemmoduleid ORDER BY r.componentname ASC";
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (systemmodules != null) {
                for (Object[] system : systemmodules) {
                    if (system[0] == null) {
                        model.addAttribute("systemmoduleclicked", "a");
                        model.addAttribute("act", "a");
                        String[] params5 = {};
                        Object[] paramsValues5 = {};
                        String[] fields5 = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};

                        List<Object[]> systemmodules5 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields5, "WHERE r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC", params5, paramsValues5);
                        if (systemmodules5 != null) {
                            Map<String, Object> systemmoduleRow;
                            for (Object[] systemmod : systemmodules5) {
                                int systemmoduleCount = 0;
                                systemmoduleRow = new HashMap<>();
                                String[] params2 = {"parentid"};
                                Object[] paramsValues2 = {(Long) systemmod[0]};
                                String where2 = "WHERE parentid=:parentid";
                                systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                                systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                                systemmoduleRow.put("systemmodulename", (String) systemmod[1]);
                                systemmoduleRow.put("dateadded", formatter.format((Date) systemmod[2]));
                                systemmoduleRow.put("dateupadated", formatter.format((Date) systemmod[3]));
                                systemmoduleRow.put("status", (Boolean) systemmod[4]);
                                systemmoduleRow.put("hasprivilege", (Boolean) systemmod[5]);
                                systemmoduleRow.put("systemmoduleid", (Long) systemmod[0]);
                                systemmoduleRow.put("description", (String) systemmod[6]);
                                systemmoduleRow.put("activity", (String) systemmod[7]);
                                systemmodulesList.add(systemmoduleRow);
                            }
                        }
                    } else {
                        model.addAttribute("systemmoduleclicked", system[0]);
                        model.addAttribute("act", "b");
                        String[] params8 = {"parentid"};
                        Object[] paramsValues8 = {(Long) system[0]};
                        String[] fields8 = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};
                        String where8 = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
                        List<Object[]> systemmodules8 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields8, where8, params8, paramsValues8);
                        if (systemmodules8 != null) {
                            Map<String, Object> systemmoduleRow;
                            for (Object[] submod : systemmodules8) {
                                systemmoduleRow = new HashMap<>();
                                int systemmoduleCount = 0;
                                systemmoduleRow = new HashMap<>();
                                String[] params2 = {"parentid"};
                                Object[] paramsValues2 = {(Long) submod[0]};
                                String where2 = "WHERE parentid=:parentid";
                                systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                                systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                                systemmoduleRow.put("systemmodulename", (String) submod[1]);
                                systemmoduleRow.put("dateadded", formatter.format((Date) submod[2]));
                                systemmoduleRow.put("dateupadated", formatter.format((Date) submod[3]));
                                systemmoduleRow.put("status", (Boolean) submod[4]);
                                systemmoduleRow.put("hasprivilege", (Boolean) submod[5]);
                                systemmoduleRow.put("systemmoduleid", (Long) submod[0]);
                                systemmoduleRow.put("description", (String) submod[6]);
                                systemmoduleRow.put("activity", (String) submod[7]);
                                systemmodulesList.add(systemmoduleRow);
                            }
                        }
                    }
                }
            }
        }

        model.addAttribute("systemmodules", systemmodulesList);
        return "controlPanel/universalPanel/activitiesAndRights/modulesAndComponents/views/activitiesandaccessrightstabs";
    }

    @RequestMapping(value = "/systemmodulemgtbyaccessrightgroups.htm", method = RequestMethod.GET)
    public String systemModuleMgtByPost(Model model) {
        List<Map> accessrightsgroup = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"accessrightsgroupid", "designationcategoryid", "description", "active"};
        String where = "";
        List<Object[]> accessrightsgrouplist = (List<Object[]>) genericClassService.fetchRecord(Accessrightsgroup.class, fields, where, params, paramsValues);
        if (accessrightsgrouplist != null) {
            Map<String, Object> accessrightgroupRow;
            for (Object[] accessrightsgroupcat : accessrightsgrouplist) {
                accessrightgroupRow = new HashMap<>();
                String[] params1 = {"designationcategoryid"};
                Object[] paramsValues1 = {(Long) accessrightsgroupcat[1]};
                String[] fields1 = {"categoryname", "description"};
                String where1 = "WHERE designationcategoryid=:designationcategoryid";
                List<Object[]> accessrightsgrouplist1 = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fields1, where1, params1, paramsValues1);
                if (accessrightsgrouplist1 != null) {
                    Object[] accessrights = accessrightsgrouplist1.get(0);
                    accessrightgroupRow.put("categoryname", (String) accessrights[0]);
                    accessrightgroupRow.put("accessrightsgroupid", (int) accessrightsgroupcat[0]);
                    accessrightgroupRow.put("description", (String) accessrightsgroupcat[2]);
                    accessrightgroupRow.put("active", (Boolean) accessrightsgroupcat[3]);
                }
                accessrightsgroup.add(accessrightgroupRow);
            }
        }
        model.addAttribute("accessrightsgrouplist", accessrightsgroup);
        return "controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/accessRightsHome";
    }

    @RequestMapping(value = "/configurepostactivity.htm")
    public @ResponseBody
    String ConfigurePostActivity(HttpServletRequest request) {
        List<Map> systemroleslist = new ArrayList<>();
        String results = "";
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"systemmoduleid", "componentname", "status", "hasprivilege"};
        String where = "WHERE r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC";
        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
        if (systemmodules != null) {
            Map<String, Object> systemmoduleRow;
            for (Object[] system : systemmodules) {
                systemmoduleRow = new HashMap<>();
                int subsystemmoduleCount = 0;
                String[] params2 = {"parentid"};
                Object[] paramsValues2 = {(Long) system[0]};
                String where2 = "WHERE parentid=:parentid";
                subsystemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                systemmoduleRow.put("subsystemmoduleCount", subsystemmoduleCount);
                systemmoduleRow.put("componentname", (String) system[1]);
                systemmoduleRow.put("status", (Boolean) system[2]);
                systemmoduleRow.put("hasprivilege", (Boolean) system[3]);
                systemmoduleRow.put("systemmoduleid", (Long) system[0]);
                systemmoduleRow.put("systemroleid", Long.parseLong(request.getParameter("systemroleid")));

                String[] paramsp = {"systemmoduleid"};
                Object[] paramsValuesp = {(Long) system[0]};
                String[] fieldsp = {"privilegeid", "hasprivilege"};
                String wherep = "WHERE systemmoduleid=:systemmoduleid";
                List<Object[]> systemmodulesp = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldsp, wherep, paramsp, paramsValuesp);
                if (systemmodulesp != null) {
                    for (Object[] prev : systemmodulesp) {

                        String[] paramspr = {"systemroleid", "privilegeid"};
                        Object[] paramsValuespr = {Long.parseLong(request.getParameter("systemroleid")), (BigInteger) prev[0]};
                        String[] fieldspr = {"systemroleprivilegeid", "active"};
                        String wherepr = "WHERE systemroleid=:systemroleid AND privilegeid=:privilegeid";
                        List<Object[]> systemmodulespr = (List<Object[]>) genericClassService.fetchRecord(Systemroleprivilege.class, fieldspr, wherepr, paramspr, paramsValuespr);
                        if (systemmodulespr != null) {
                            systemmoduleRow.put("assigned", "Yes");
                        } else {
                            systemmoduleRow.put("assigned", "No");
                        }
                    }
                }
                systemroleslist.add(systemmoduleRow);
            }
        }
        try {
            results = new ObjectMapper().writeValueAsString(systemroleslist);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/savecomponentandsubcomponent.htm")
    public @ResponseBody
    String SaveComponentAndSubSomponents(HttpServletRequest request) {

        String results = "";
        try {
            if ("withoutsubcomponents".equals(request.getParameter("act"))) {
                Systemmodule systemmodule = new ObjectMapper().readValue(request.getParameter("component"), Systemmodule.class);
                systemmodule.setAddedby((Long) request.getSession().getAttribute("person_id"));
                systemmodule.setDateadded(new Date());
                systemmodule.setHasprivilege(false);
                systemmodule.setDateupdated(new Date());
                systemmodule.setUpdatedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                Object save = genericClassService.saveOrUpdateRecordLoadObject(systemmodule);
                if (save != null) {
                    results = "success";
                } else {
                    results = "failed";
                }

            } else if ("update".equals(request.getParameter("act"))) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("component"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    String[] columns = {"componentname", "description", "activity"};
                    Object[] columnValues = {(String) map.get("systemmodulename"), (String) map.get("description"), (String) map.get("itemtype")};
                    String pk = "systemmoduleid";
                    Object pkValue = Long.parseLong((String) map.get("systemmoduleid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns, columnValues, pk, pkValue, "controlpanel");
                    if (result != 0) {
                        Systemmodule setsymod = new Systemmodule();
                        setsymod.setSystemmoduleid(Long.parseLong((String) map.get("systemmoduleid")));
                        List<Map> item4 = (ArrayList) new ObjectMapper().readValue(request.getParameter("subcomponents"), List.class);
                        for (Map item3 : item4) {
                            Map<String, Object> map1 = (HashMap) item3;
                            Systemmodule systemmodule1 = new Systemmodule();
                            systemmodule1.setAddedby((Long) request.getSession().getAttribute("person_id"));
                            systemmodule1.setDateadded(new Date());
                            if ("Active".equals((String) map1.get("status"))) {
                                systemmodule1.setStatus(true);
                            } else {
                                systemmodule1.setStatus(false);
                            }
                            systemmodule1.setHasprivilege(false);
                            systemmodule1.setParentid(setsymod);
                            systemmodule1.setDateupdated(new Date());
                            systemmodule1.setActivity((String) map1.get("activity"));
                            systemmodule1.setUpdatedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                            systemmodule1.setComponentname((String) map1.get("componentname"));
                            systemmodule1.setDescription((String) map1.get("description"));
                            Object save1 = genericClassService.saveOrUpdateRecordLoadObject(systemmodule1);
                            if (save1 != null) {
                                results = "success";
                            } else {
                                results = "failed";
                            }
                        }
                    }
                }

            } else {
                Systemmodule systemmodule = new ObjectMapper().readValue(request.getParameter("component"), Systemmodule.class);

                systemmodule.setAddedby((Long) request.getSession().getAttribute("person_id"));
                systemmodule.setDateadded(new Date());
                systemmodule.setHasprivilege(false);
                systemmodule.setDateupdated(new Date());
                systemmodule.setUpdatedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));

                Object save = genericClassService.saveOrUpdateRecordLoadObject(systemmodule);
                if (save != null) {
                    List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("subcomponents"), List.class);
                    for (Map item1 : item) {
                        Map<String, Object> map = (HashMap) item1;
                        Systemmodule systemmodule1 = new Systemmodule();
                        systemmodule1.setAddedby((Long) request.getSession().getAttribute("person_id"));
                        systemmodule1.setDateadded(new Date());
                        if ("Active".equals((String) map.get("status"))) {
                            systemmodule1.setStatus(true);
                        } else {
                            systemmodule1.setStatus(false);
                        }
                        systemmodule1.setHasprivilege(false);
                        systemmodule1.setParentid(systemmodule);
                        systemmodule1.setDateupdated(new Date());
                        systemmodule1.setActivity((String) map.get("activity"));
                        systemmodule1.setUpdatedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                        systemmodule1.setComponentname((String) map.get("componentname"));
                        systemmodule1.setDescription((String) map.get("description"));
                        Object save1 = genericClassService.saveOrUpdateRecordLoadObject(systemmodule1);
                        if (save1 != null) {
                            results = "success";
                        } else {
                            results = "failed";
                        }
                    }
                } else {
                }

            }
        } catch (Exception e) {
            System.out.println("" + e);
        }

        return results;
    }

    @RequestMapping(value = "/developerkeysmanagement.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public String DeveloperkeysManagement(HttpServletRequest request, Principal principal, Model model) {
        List<Map> systemroleslist = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            model.addAttribute("act", "a");
            String[] field = {"systemmoduleid", "componentname", "description", "status", "activity"};
            String[] param = {};
            Object[] paramsValue = {};
            List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE  r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC ", param, paramsValue);
            if (sysArrList != null) {
                Map<String, Object> systemmoduleprivilegeRow;
                for (Object[] system : sysArrList) {
                    systemmoduleprivilegeRow = new HashMap<>();
                    String[] fieldp = {"privilegeid"};
                    String[] paramp = {"systemmoduleid"};
                    Object[] paramsValuep = {(Long) system[0]};
                    systemmoduleprivilegeRow.put("componentname", (String) system[1]);
                    systemmoduleprivilegeRow.put("systemmoduleid", (Long) system[0]);
                    int systemmoduleCount = 0;
                    String[] params2 = {"parentid"};
                    Object[] paramsValues2 = {(Long) system[0]};
                    String where2 = "WHERE parentid=:parentid";

                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                    systemmoduleprivilegeRow.put("subcomponentcount", systemmoduleCount);

                    List<BigInteger> sysArrListp = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fieldp, "WHERE systemmoduleid=:systemmoduleid", paramp, paramsValuep);
                    if (sysArrListp != null) {
                        for (BigInteger sys : sysArrListp) {
                            String[] field1 = {"privilegeid", "privilege", "description", "privilegekey", "active"};
                            String[] param1 = {"privilegeid"};
                            Object[] paramsValue1 = {sys};
                            List<Object[]> sysArrList1 = (List<Object[]>) genericClassService.fetchRecord(Privilege.class, field1, "WHERE  privilegeid=:privilegeid", param1, paramsValue1);
                            if (sysArrList1 != null) {
                                Object[] prev = sysArrList1.get(0);
                                systemmoduleprivilegeRow.put("privilegeid", (int) prev[0]);
                                systemmoduleprivilegeRow.put("privilege", (String) prev[1]);
                                systemmoduleprivilegeRow.put("description", (String) prev[2]);
                                systemmoduleprivilegeRow.put("privilegekey", (String) prev[3]);
                                systemmoduleprivilegeRow.put("privilegestatus", (Boolean) prev[4]);
                            }
                            systemroleslist.add(systemmoduleprivilegeRow);
                        }
                    }
                }
            }
        }
        if ("b".equals(request.getParameter("act"))) {
            model.addAttribute("act", "b");
            model.addAttribute("systemmoduleidclicked", Long.parseLong(request.getParameter("systemmoduleid")));
            String[] field = {"systemmoduleid", "componentname", "description", "status", "activity"};
            String[] param = {"parentid"};
            Object[] paramsValue = {Long.parseLong(request.getParameter("systemmoduleid"))};
            String where = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
            List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, where, param, paramsValue);
            if (sysArrList != null) {
                Map<String, Object> systemmoduleprivilegeRow;
                for (Object[] system : sysArrList) {
                    systemmoduleprivilegeRow = new HashMap<>();
                    String[] fieldp = {"privilegeid"};
                    String[] paramp = {"systemmoduleid"};
                    Object[] paramsValuep = {(Long) system[0]};
                    systemmoduleprivilegeRow.put("componentname", (String) system[1]);
                    systemmoduleprivilegeRow.put("systemmoduleid", (Long) system[0]);
                    int systemmoduleCount = 0;
                    String[] params2 = {"parentid"};
                    Object[] paramsValues2 = {(Long) system[0]};
                    String where2 = "WHERE parentid=:parentid";

                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                    systemmoduleprivilegeRow.put("subcomponentcount", systemmoduleCount);

                    List<BigInteger> sysArrListp = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fieldp, "WHERE systemmoduleid=:systemmoduleid", paramp, paramsValuep);
                    if (sysArrListp != null) {
                        for (BigInteger sys : sysArrListp) {
                            String[] field1 = {"privilegeid", "privilege", "description", "privilegekey", "active"};
                            String[] param1 = {"privilegeid"};
                            Object[] paramsValue1 = {sys};
                            List<Object[]> sysArrList1 = (List<Object[]>) genericClassService.fetchRecord(Privilege.class, field1, "WHERE  privilegeid=:privilegeid", param1, paramsValue1);
                            if (sysArrList1 != null) {
                                Object[] prev = sysArrList1.get(0);
                                systemmoduleprivilegeRow.put("privilegeid", (int) prev[0]);
                                systemmoduleprivilegeRow.put("privilege", (String) prev[1]);
                                systemmoduleprivilegeRow.put("description", (String) prev[2]);
                                systemmoduleprivilegeRow.put("privilegekey", (String) prev[3]);
                                systemmoduleprivilegeRow.put("privilegestatus", (Boolean) prev[4]);
                            }
                            systemroleslist.add(systemmoduleprivilegeRow);
                        }
                    }
                }
            }
        }
        if ("c".equals(request.getParameter("act"))) {

            String[] params = {"systemmoduleid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("systemmoduleid"))};
            String[] fields = {"parentid.systemmoduleid", "componentname"};
            String where = "WHERE systemmoduleid=:systemmoduleid ORDER BY r.componentname ASC";
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (systemmodules != null) {
                for (Object[] system : systemmodules) {
                    if (system[0] == null) {
                        model.addAttribute("act", "a");
                        String[] field = {"systemmoduleid", "componentname", "description", "status", "activity"};
                        String[] param = {};
                        Object[] paramsValue = {};
                        List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE  r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC ", param, paramsValue);
                        if (sysArrList != null) {
                            Map<String, Object> systemmoduleprivilegeRow;
                            for (Object[] system0 : sysArrList) {
                                systemmoduleprivilegeRow = new HashMap<>();
                                String[] fieldp = {"privilegeid"};
                                String[] paramp = {"systemmoduleid"};
                                Object[] paramsValuep = {(Long) system0[0]};
                                systemmoduleprivilegeRow.put("componentname", (String) system0[1]);
                                systemmoduleprivilegeRow.put("systemmoduleid", (Long) system0[0]);
                                int systemmoduleCount = 0;
                                String[] params2 = {"parentid"};
                                Object[] paramsValues2 = {(Long) system0[0]};
                                String where2 = "WHERE parentid=:parentid";

                                systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                                systemmoduleprivilegeRow.put("subcomponentcount", systemmoduleCount);

                                List<BigInteger> sysArrListp = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fieldp, "WHERE systemmoduleid=:systemmoduleid", paramp, paramsValuep);
                                if (sysArrListp != null) {
                                    for (BigInteger sys : sysArrListp) {
                                        String[] field1 = {"privilegeid", "privilege", "description", "privilegekey", "active"};
                                        String[] param1 = {"privilegeid"};
                                        Object[] paramsValue1 = {sys};
                                        List<Object[]> sysArrList1 = (List<Object[]>) genericClassService.fetchRecord(Privilege.class, field1, "WHERE  privilegeid=:privilegeid", param1, paramsValue1);
                                        if (sysArrList1 != null) {
                                            Object[] prev = sysArrList1.get(0);
                                            systemmoduleprivilegeRow.put("privilegeid", (int) prev[0]);
                                            systemmoduleprivilegeRow.put("privilege", (String) prev[1]);
                                            systemmoduleprivilegeRow.put("description", (String) prev[2]);
                                            systemmoduleprivilegeRow.put("privilegekey", (String) prev[3]);
                                            systemmoduleprivilegeRow.put("privilegestatus", (Boolean) prev[4]);
                                        }
                                        systemroleslist.add(systemmoduleprivilegeRow);
                                    }
                                }
                            }
                        }
                    } else {
                        model.addAttribute("act", "b");
                        model.addAttribute("systemmoduleidclicked", system[0]);
                        String[] field = {"systemmoduleid", "componentname", "description", "status", "activity"};
                        String[] param = {"parentid"};
                        Object[] paramsValue = {(Long) system[0]};
                        String where2 = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
                        List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, where2, param, paramsValue);
                        if (sysArrList != null) {
                            Map<String, Object> systemmoduleprivilegeRow;
                            for (Object[] system2 : sysArrList) {
                                systemmoduleprivilegeRow = new HashMap<>();
                                String[] fieldp = {"privilegeid"};
                                String[] paramp = {"systemmoduleid"};
                                Object[] paramsValuep = {(Long) system2[0]};
                                systemmoduleprivilegeRow.put("componentname", (String) system2[1]);
                                systemmoduleprivilegeRow.put("systemmoduleid", (Long) system2[0]);
                                int systemmoduleCount = 0;
                                String[] params2 = {"parentid"};
                                Object[] paramsValues2 = {(Long) system2[0]};
                                String where8 = "WHERE parentid=:parentid";

                                systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where8, params2, paramsValues2);
                                systemmoduleprivilegeRow.put("subcomponentcount", systemmoduleCount);

                                List<BigInteger> sysArrListp = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fieldp, "WHERE systemmoduleid=:systemmoduleid", paramp, paramsValuep);
                                if (sysArrListp != null) {
                                    for (BigInteger sys : sysArrListp) {
                                        String[] field1 = {"privilegeid", "privilege", "description", "privilegekey", "active"};
                                        String[] param1 = {"privilegeid"};
                                        Object[] paramsValue1 = {sys};
                                        List<Object[]> sysArrList1 = (List<Object[]>) genericClassService.fetchRecord(Privilege.class, field1, "WHERE  privilegeid=:privilegeid", param1, paramsValue1);
                                        if (sysArrList1 != null) {
                                            Object[] prev = sysArrList1.get(0);
                                            systemmoduleprivilegeRow.put("privilegeid", (int) prev[0]);
                                            systemmoduleprivilegeRow.put("privilege", (String) prev[1]);
                                            systemmoduleprivilegeRow.put("description", (String) prev[2]);
                                            systemmoduleprivilegeRow.put("privilegekey", (String) prev[3]);
                                            systemmoduleprivilegeRow.put("privilegestatus", (Boolean) prev[4]);
                                        }
                                        systemroleslist.add(systemmoduleprivilegeRow);
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
        model.addAttribute("systemroleslist", systemroleslist);
        return "controlPanel/universalPanel/activitiesAndRights/developerKeys/views/developerkeysHome";
    }

    @RequestMapping(value = "/getdesignationcategories.htm")
    public String GetDesignationCategories(HttpServletRequest request, Model model) {
        List<Long> designationcategoryids = new ArrayList<Long>();
        List<Designationcategory> designationcategorylist = new ArrayList<Designationcategory>();
        String results = "";
        String[] field3 = {"designationcategoryid"};
        String[] param3 = {"active"};
        Object[] paramsValue3 = {true};
        List<Long> existingaccessrightgroups = (List<Long>) genericClassService.fetchRecord(Accessrightsgroup.class, field3, "WHERE active=:active", param3, paramsValue3);
        if (existingaccessrightgroups != null) {
            for (Long existingaccessright : existingaccessrightgroups) {
                designationcategoryids.add(existingaccessright);
            }
        }
        String[] field = {"designationcategoryid", "categoryname"};
        String[] param = {};
        Object[] paramsValue = {};
        List<Object[]> designationcategory = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, field, " ", param, paramsValue);
        if (designationcategory != null) {
            for (Object[] designation : designationcategory) {
                if (!designationcategoryids.contains(Long.valueOf(String.valueOf((int) designation[0])))) {
                    Designationcategory designationcategory1 = new Designationcategory();
                    designationcategory1.setCategoryname((String) designation[1]);
                    designationcategory1.setDesignationcategoryid((int) designation[0]);
                    designationcategorylist.add(designationcategory1);
                }
            }
        }
        model.addAttribute("designationcategorylist", designationcategorylist);
        return "controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/forms/addnewaccessrightsgroup";
    }

    @RequestMapping(value = "/saveaccessrightgroup.htm")
    public @ResponseBody
    String SaveAccessRightGroup(HttpServletRequest request) {
        String results = "";
        try {
            Accessrightsgroup accessrightsgroup = new ObjectMapper().readValue(request.getParameter("values"), Accessrightsgroup.class);
            accessrightsgroup.setDateadded(new Date());
            Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightsgroup);
            if (save != null) {
                results = "success" + "-" + accessrightsgroup.getAccessrightsgroupid();
            } else {
                results = "fail" + "-" + accessrightsgroup.getAccessrightsgroupid();
            }
        } catch (IOException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/getsystemmoduleandsubcomponents.htm", method = RequestMethod.GET)
    public String GetSystemmoduleAndSubComponents(HttpServletRequest request, Model model) {
        List<Systemmodule> systemroleslist = new ArrayList<>();
        try {
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }
        model.addAttribute("systemcomponentlist", systemroleslist);
        model.addAttribute("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
        model.addAttribute("groupname", request.getParameter("groupname"));
        return "controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/views/systemmoduleAndComponents";
    }

    @RequestMapping(value = "/popupaletetreewithselectedsystemmodulecomponent.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView PopupaleteTreeWithSelectedSystemModuleComponent(HttpServletRequest request, Principal principal) {
        List<Systemmodule> systemroleslist = new ArrayList<>();
        long id = Long.parseLong(request.getParameter("accessrightsgroupid"));
        long id2 = Long.parseLong(request.getParameter("systemmoduleid"));
        String activity = "a";
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("groupname", request.getParameter("groupname"));
            model.put("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }
            List<CustomSystemmodule> customList = new ArrayList<CustomSystemmodule>();
            List<CustomSystemmodule> customChildList = new ArrayList<CustomSystemmodule>();
            model.put("activity", activity);

            if (activity.equals("a")) {
                List<Integer> assignedPrivs = new ArrayList<Integer>();
                String[] fieldPriv = {"privilegeid"};
                String[] paramPriv = {"Id", "active"};
                Object[] paramsValPriv = {id, true};
                List<Object[]> rolePrivArrList = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fieldPriv, "WHERE r.accessrightsgroupid=:Id AND active=:active", paramPriv, paramsValPriv);
                if (rolePrivArrList != null && !rolePrivArrList.isEmpty()) {
                    for (Object obj : rolePrivArrList) {
                        assignedPrivs.add(((Long) obj).intValue());
                    }
                }

                Systemmodule selectedSysModule = null;
                List<Systemmodule> allSysModules = new ArrayList<Systemmodule>();
                String[] fieldSM = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] paramSM = {};
                Object[] paramsValSM = {};
                List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE r.status=TRUE ORDER BY r.componentname ASC ", paramSM, paramsValSM);
                if (smArrList != null && !smArrList.isEmpty()) {
                    for (Object[] obj : smArrList) {
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        if (sm.getSystemmoduleid() == id2) {
                            selectedSysModule = sm;
                        }
                        allSysModules.add(sm);
                    }
                }

                List<Systemmodule> allChildSysModules = new ArrayList<Systemmodule>();
                String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname"};
                String[] paramCSM = {};
                Object[] paramsValCSM = {};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
                if (csmArrList != null && !csmArrList.isEmpty()) {
                    for (Object[] ob : csmArrList) {
                        Systemmodule sm = new Systemmodule((Long) ob[0]);
                        Systemmodule ssm = new Systemmodule((Long) ob[1]);
                        sm.setParentid(ssm);
                        sm.setComponentname((String) ob[2]);
                        allChildSysModules.add(sm);
                    }
                }

                List<Systemmodule> allPrivSysModules = new ArrayList<Systemmodule>();
                String[] fieldSmPriv = {"systemmoduleid", "privilegeid"};
                String[] paramSmPriv = {};
                Object[] paramsValSmPriv = {};
                List<Object[]> sysArrListSmPriv = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSmPriv, "WHERE r.status=TRUE AND r.privilegeid IS NOT NULL", paramSmPriv, paramsValSmPriv);
                if (sysArrListSmPriv != null && !sysArrListSmPriv.isEmpty()) {
                    for (Object[] obj3 : sysArrListSmPriv) {
                        Systemmodule sm = new Systemmodule((Long) obj3[0]);
                        sm.setPrivilegeid((BigInteger) obj3[1]);
                        allPrivSysModules.add(sm);
                    }
                }

                String[] field = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] param = {"ssmid"};
                Object[] paramsValue = {id2};
                List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
                if (sysArrList != null && !sysArrList.isEmpty()) {
                    for (Object[] obj : sysArrList) {
                        CustomSystemmodule ssm = new CustomSystemmodule();
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<Long>();

                        if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        ssm.setSubmodules(subModules);

                        if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                            for (Systemmodule obj3 : allPrivSysModules) {
                                if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    sm.setPrivilegeid(obj3.getPrivilegeid());
                                }
                            }
                            if (!assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).intValue())) {
                                ssm.setAssigned(true);
                            } else {
                                ssm.setAssigned(false);
                            }
                        }
                        ssm.setSystemmodule(sm);
                        if (request.getSession().getAttribute("sessAssignt_AddSysModule") != null) {
                            List<Systemmodule> systemmoduleList2 = (List<Systemmodule>) request.getSession().getAttribute("sessAssignt_AddSysModule");
                            if (systemmoduleList2 != null && !systemmoduleList2.isEmpty()) {
                                for (Systemmodule smObj : systemmoduleList2) {
                                    if (smObj.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        ssm.setSelected(true);
                                    }
                                }
                            }
                        }
                        if (request.getSession().getAttribute("sessAssignt_RemoveSysModule") != null) {
                            List<Systemmodule> systemmoduleList2 = (List<Systemmodule>) request.getSession().getAttribute("sessAssignt_RemoveSysModule");
                            if (systemmoduleList2 != null && !systemmoduleList2.isEmpty()) {
                                for (Systemmodule smObj : systemmoduleList2) {
                                    if (smObj.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        ssm.setSelected(true);
                                    }
                                }
                            }
                        }

                        //Call function to load child elements
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList = loadParentActivity(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, id, assignedPrivs);

                        }
                        ssm.setCustomSystemmoduleList(customChildList);
                        customList.add(ssm);

                    }
                }
            }

            model.put("customList", customList);

            model.put("customLists", new ObjectMapper().writeValueAsString(customList));
            if (customList != null && !customList.isEmpty()) {
                model.put("size", customList.size());
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/views/componentTree", "model", model);
    }

    public List<Long> getparent(List<Long> allparents, Long moduleparent, List<Long> parents) {

        if (!allparents.isEmpty() && allparents.contains(moduleparent)) {
            parents.add(moduleparent);
            String[] params = {"systemmoduleid"};
            Object[] paramsValues = {moduleparent};
            String[] fields = {"parentid.systemmoduleid"};
            List<Long> systemmodules = (List<Long>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE systemmoduleid=:systemmoduleid", params, paramsValues);
            if (systemmodules != null) {
                Long sym = systemmodules.get(0);
                getparent(allparents, sym, parents);
            }
        }
        return parents;
    }

    @RequestMapping(value = "/addprivtoaccessrightsgroup.htm")
    public @ResponseBody
    String AddPrivToAccessRightsGroup(HttpServletRequest request, Model model) {
        String results = "success";
        try {
            if ("a".equals(request.getParameter("act"))) {
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("privilegeset"), List.class);
                Set<Long> allparentsysmods = new HashSet<Long>();
                for (String item1 : item) {
                    Accessrightgroupprivilege accessrightgroupprivilege = new Accessrightgroupprivilege();
                    accessrightgroupprivilege.setPrivilegeid(Long.parseLong(item1));
                    accessrightgroupprivilege.setAccessrightsgroupid(Integer.parseInt(request.getParameter("accessrightsgroupid")));
                    accessrightgroupprivilege.setActive(Boolean.TRUE);
                    accessrightgroupprivilege.setDateadded(new Date());
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightgroupprivilege);

                    List<Long> allparentmodules = new ArrayList<Long>();
                    String[] params = {"status"};
                    Object[] paramsValues = {true};
                    String[] fields = {"systemmoduleid"};
                    List<Long> systemmodules = (List<Long>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE status=:status AND r.privilegeid IS NOT NULL", params, paramsValues);
                    if (systemmodules != null) {
                        for (Long sysmods : systemmodules) {
                            allparentmodules.add(sysmods);
                        }
                    }
                    List<Long> parents = new ArrayList<Long>();
                    String[] params1 = {"privilegeid"};
                    Object[] paramsValues1 = {Long.parseLong(item1)};
                    String[] fields1 = {"systemmoduleid", "parentid.systemmoduleid"};
                    List<Object[]> systemmodules1 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE privilegeid=:privilegeid", params1, paramsValues1);
                    if (systemmodules1 != null) {
                        Object[] symd = systemmodules1.get(0);
                        for (Long add : getparent(allparentmodules, (Long) symd[1], parents)) {
                            allparentsysmods.add(add);
                        }
                    }

//                    
                }
                if (!allparentsysmods.isEmpty()) {
                    for (Long allparentmd : allparentsysmods) {
                        String[] params2 = {"systemmoduleid"};
                        Object[] paramsValues2 = {allparentmd};
                        String[] fields2 = {"privilegeid"};
                        List<BigInteger> systemmodules2 = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fields2, "WHERE systemmoduleid=:systemmoduleid", params2, paramsValues2);
                        if (systemmodules2 != null) {
                            BigInteger priv = systemmodules2.get(0);
                            Accessrightgroupprivilege accessrightgroupprivilege = new Accessrightgroupprivilege();
                            accessrightgroupprivilege.setPrivilegeid(priv.longValue());
                            accessrightgroupprivilege.setAccessrightsgroupid(Integer.parseInt(request.getParameter("accessrightsgroupid")));
                            accessrightgroupprivilege.setActive(Boolean.TRUE);
                            accessrightgroupprivilege.setDateadded(new Date());
                            Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightgroupprivilege);
                        }
                    }
                }
            } else {

            }
        } catch (IOException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/groupaccessrightstree.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView GroupAccessRightsTree(HttpServletRequest request, Principal principal) {
        List<Systemmodule> systemroleslist = new ArrayList<>();
        long id = Long.parseLong(request.getParameter("accessrightsgroupid"));
        long id2 = Long.parseLong(request.getParameter("systemmoduleid"));
        String activity = "a";
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("groupname", request.getParameter("groupname"));
            model.put("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
//        String where = "";

            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }

            List<CustomSystemmodule> customList = new ArrayList<CustomSystemmodule>();
            List<CustomSystemmodule> customChildList = new ArrayList<CustomSystemmodule>();
            List<Long> ids = new ArrayList<Long>();

            model.put("activity", activity);

            if (activity.equals("a")) {
                List<Integer> assignedPrivs = new ArrayList<Integer>();
                String[] fieldPriv = {"privilegeid"};
                String[] paramPriv = {"Id", "active"};
                Object[] paramsValPriv = {id, true};
                List<Object[]> rolePrivArrList = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fieldPriv, "WHERE r.accessrightsgroupid=:Id AND active=:active", paramPriv, paramsValPriv);
                if (rolePrivArrList != null && !rolePrivArrList.isEmpty()) {
                    for (Object obj : rolePrivArrList) {
                        assignedPrivs.add(((Long) obj).intValue());
                    }
                }

                Systemmodule selectedSysModule = null;
                List<Systemmodule> allSysModules = new ArrayList<Systemmodule>();
                String[] fieldSM = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity", "parentid.systemmoduleid"};
                String[] paramSM = {};
                Object[] paramsValSM = {};
                List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE r.status=TRUE ORDER BY r.componentname ASC ", paramSM, paramsValSM);
                if (smArrList != null && !smArrList.isEmpty()) {
                    for (Object[] obj : smArrList) {
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);
                        Systemmodule ssm = new Systemmodule((Long) obj[8]);
                        sm.setParentid(ssm);
                        if (sm.getSystemmoduleid() == id2) {
                            selectedSysModule = sm;
                        }
                        allSysModules.add(sm);
                    }
                }

                List<Systemmodule> allChildSysModules = new ArrayList<Systemmodule>();
                String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname"};
                String[] paramCSM = {};
                Object[] paramsValCSM = {};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
                if (csmArrList != null && !csmArrList.isEmpty()) {
                    for (Object[] ob : csmArrList) {
                        Systemmodule sm = new Systemmodule((Long) ob[0]);
                        Systemmodule ssm = new Systemmodule((Long) ob[1]);
                        sm.setParentid(ssm);
                        sm.setComponentname((String) ob[2]);
                        allChildSysModules.add(sm);
                    }
                }

                List<Systemmodule> allPrivSysModules = new ArrayList<Systemmodule>();
                String[] fieldSmPriv = {"systemmoduleid", "privilegeid", "parentid.systemmoduleid"};
                String[] paramSmPriv = {};
                Object[] paramsValSmPriv = {};
                List<Object[]> sysArrListSmPriv = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSmPriv, "WHERE r.status=TRUE AND r.privilegeid IS NOT NULL", paramSmPriv, paramsValSmPriv);
                if (sysArrListSmPriv != null && !sysArrListSmPriv.isEmpty()) {
                    for (Object[] obj3 : sysArrListSmPriv) {
                        Systemmodule sm = new Systemmodule((Long) obj3[0]);
                        Systemmodule ssm = new Systemmodule((Long) obj3[2]);
                        sm.setParentid(ssm);
                        sm.setPrivilegeid((BigInteger) obj3[1]);
                        allPrivSysModules.add(sm);
                    }
                }

                String[] field = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] param = {"ssmid"};
                Object[] paramsValue = {id2};
                List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
                if (sysArrList != null && !sysArrList.isEmpty()) {
                    for (Object[] obj : sysArrList) {
                        CustomSystemmodule ssm = new CustomSystemmodule();
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<Long>();

                        if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        ssm.setSubmodules(subModules);

                        if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                            for (Systemmodule obj3 : allPrivSysModules) {
                                if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    sm.setPrivilegeid(obj3.getPrivilegeid());
                                }
                            }
//                            System.out.println("fff:" + sm.getPrivilegeid().intValue());
//                            System.out.println("" + assignedPrivs);
                            if (!assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).intValue())) {
//                              
                                ssm.setAssigned(true);
                            } else {

//                                    logger.info("privilege un assigned ::::::::::::::: false");
                                ssm.setAssigned(false);
                            }

                        }
                        ssm.setSystemmodule(sm);

                        //Call function to load child elements
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList = loadParentActivity(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, id, assignedPrivs);

                        }
                        ssm.setCustomSystemmoduleList(customChildList);
                        customList.add(ssm);

                    }
                }
            }

            model.put("customList", customList);

            model.put("customLists", new ObjectMapper().writeValueAsString(customList));
            if (customList != null && !customList.isEmpty()) {
                model.put("size", customList.size());
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }
        model.put("groupstatus", request.getParameter("groupstatus"));
        ModelAndView modelAndView = new ModelAndView();
        if (null == request.getParameter("view")) {
        } else {
            switch (request.getParameter("view")) {
                case "assigned":
                    modelAndView = new ModelAndView("controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/forms/assignedgroupmodules", "model", model);
                    break;
                case "all":
                    modelAndView = new ModelAndView("controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/views/accessrightsTree", "model", model);
                    break;
                default:
                    break;
            }
        }

        return modelAndView;
    }

    @RequestMapping(value = "/accessrightsgroupactivitiestree.htm", method = RequestMethod.GET)
    public String AccessRightsGroupActivities(HttpServletRequest request, Model model) {
        List<Systemmodule> systemroleslist = new ArrayList<>();
        try {
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }
            String[] params1 = {"accessrightsgroupid"};
            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("accessrightsgroupid"))};
            String[] fields1 = {"active"};
            List<Boolean> systemmodules1 = (List<Boolean>) genericClassService.fetchRecord(Accessrightsgroup.class, fields1, "WHERE accessrightsgroupid=:accessrightsgroupid", params1, paramsValues1);
            if (systemmodules1 != null) {
                Boolean state = systemmodules1.get(0);
                model.addAttribute("groupstatus", state);
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }
        model.addAttribute("systemcomponentlist", systemroleslist);
        model.addAttribute("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
        model.addAttribute("groupname", request.getParameter("groupname"));
        return "controlPanel/universalPanel/activitiesAndRights/accessRightsGroups/views/accessrightsgroupactivitiestree";
    }

    private List<CustomSystemmodule> loadParentActivity(List<Systemmodule> allSysModules, List<Systemmodule> allChildSysModules, List<Systemmodule> allPrivSysModules, HttpServletRequest request, List<Long> ids, long roleid, List<Integer> assignedPrivs) {
        List<CustomSystemmodule> customChildList2 = new ArrayList<CustomSystemmodule>();
        List<CustomSystemmodule> customList2 = new ArrayList<CustomSystemmodule>();
        try {
            for (Long id : ids) {
                if (allSysModules != null && !allSysModules.isEmpty()) {
                    for (Systemmodule sm : allSysModules) {
                        if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                            CustomSystemmodule ssm = new CustomSystemmodule();

                            int subModules = 0;
                            List<Long> subModuleId = new ArrayList<Long>();

                            if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                                for (Systemmodule ob : allChildSysModules) {
                                    if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        subModuleId.add(ob.getSystemmoduleid());
                                        subModules += 1;
                                    }
                                }
                            }

                            ssm.setSubmodules(subModules);

                            if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                                for (Systemmodule obj3 : allPrivSysModules) {
                                    if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        sm.setPrivilegeid(obj3.getPrivilegeid());
                                    }
                                }
                                if (sm.getParentid() != null && ((sm.getPrivilegeid()).intValue()) != 0 && !assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).intValue())) {

//                                logger.info("privilege assigned ::::::::::::::: true");
                                    ssm.setAssigned(true);
                                } else {
//                                logger.info("privilege un assigned ::::::::::::::: false");
                                    ssm.setAssigned(false);
                                }
                            }

                            ssm.setSystemmodule(sm);

                            if (subModules > 0) {
//                            logger.info(":Child Fetch:::went In again get::::--------::sms::"+subModules+" for "+sm.getComponentname()+" ::"+subModuleId.size());
                                customChildList2 = loadParentActivity(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, roleid, assignedPrivs);
                            }
                            ssm.setCustomSystemmoduleList(customChildList2);
                            customList2.add(ssm);
                        }
                    }

                }
            }
        } catch (NullPointerException e) {
        }

        return customList2;
    }

    private List<CustomSystemmodule> loadParentActivityrepeat(List<Systemmodule> allSysModules, List<Systemmodule> allChildSysModules, List<Systemmodule> allPrivSysModules, HttpServletRequest request, List<Long> ids, long roleid, List<Integer> assignedPrivs, Set<Long> assignedstaffpriv) {
        List<CustomSystemmodule> customChildList2 = new ArrayList<CustomSystemmodule>();
        List<CustomSystemmodule> customList2 = new ArrayList<CustomSystemmodule>();
        try {
            for (Long id : ids) {
                if (allSysModules != null && !allSysModules.isEmpty()) {
                    for (Systemmodule sm : allSysModules) {
                        if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                            CustomSystemmodule ssm = new CustomSystemmodule();

                            int subModules = 0;
                            List<Long> subModuleId = new ArrayList<Long>();

                            if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                                for (Systemmodule ob : allChildSysModules) {
                                    if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        subModuleId.add(ob.getSystemmoduleid());
                                        subModules += 1;
                                    }
                                }
                            }

                            ssm.setSubmodules(subModules);

                            if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                                for (Systemmodule obj3 : allPrivSysModules) {
                                    if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        sm.setPrivilegeid(obj3.getPrivilegeid());
                                    }
                                }
                                if (!assignedstaffpriv.isEmpty() && sm.getPrivilegeid() != null && assignedstaffpriv.contains(sm.getPrivilegeid().longValue())) {
                                    ssm.setAssignedpost(true);
                                }
                                if (sm.getParentid() != null && ((sm.getPrivilegeid()).intValue()) != 0 && !assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).intValue())) {

//                                logger.info("privilege assigned ::::::::::::::: true");
                                    ssm.setAssigned(true);
                                } else {
//                                logger.info("privilege un assigned ::::::::::::::: false");
                                    ssm.setAssigned(false);
                                }
                            }

                            ssm.setSystemmodule(sm);

                            if (subModules > 0) {
//                            logger.info(":Child Fetch:::went In again get::::--------::sms::"+subModules+" for "+sm.getComponentname()+" ::"+subModuleId.size());
                                customChildList2 = loadParentActivityrepeat(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, roleid, assignedPrivs, assignedstaffpriv);
                            }
                            ssm.setCustomSystemmoduleList(customChildList2);
                            customList2.add(ssm);
                        }
                    }

                }
            }
        } catch (NullPointerException e) {
        }

        return customList2;
    }

    @RequestMapping(value = "/getaccessrightgrouplists.htm")
    public @ResponseBody
    String GetAccessRightGroupLists(HttpServletRequest request, Model model) {
        List<Map> groupslists = new ArrayList<>();
        String results = "";
        String[] params = {"active"};
        Object[] paramsValues = {Boolean.TRUE};
        String[] fields = {"accessrightsgroupid", "designationcategoryid"};
        List<Object[]> groups = (List<Object[]>) genericClassService.fetchRecord(Accessrightsgroup.class, fields, "WHERE  active=:active", params, paramsValues);
        if (groups != null) {
            Map<String, Object> groupslistRow;
            for (Object[] grps : groups) {
                groupslistRow = new HashMap<>();
                String[] params1 = {"designationcategoryid"};
                Object[] paramsValues1 = {(Long) grps[1]};
                String[] fields1 = {"categoryname", "rolessize"};
                List<Object[]> groups1 = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fields1, "WHERE  designationcategoryid=:designationcategoryid", params1, paramsValues1);
                if (groups1 != null) {
                    Object[] group = groups1.get(0);
                    groupslistRow.put("categoryname", (String) group[0]);
                    groupslistRow.put("accessrightsgroupid", (int) grps[0]);
                    groupslists.add(groupslistRow);
                }
            }
        }
        try {
            results = new ObjectMapper().writeValueAsString(groupslists);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/getselectedsystemmodules.htm")
    public @ResponseBody
    String GetSelectedSystemModules(HttpServletRequest request, Model model) {
        String results = "";
        List<Systemmodule> systemroleslist = new ArrayList<>();
        try {
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }
        try {
            results = new ObjectMapper().writeValueAsString(systemroleslist);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/getassignedgroupaccessrightsandmoduleactivities.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView GetAssignedgroupaccessright(HttpServletRequest request, Principal principal) {
        List<Systemmodule> systemroleslist = new ArrayList<>();
        Set<Long> assignedstaffpriv = new HashSet<>();
        Set<Long> assignedgrppriv = new HashSet<>();
        long id = Long.parseLong(request.getParameter("accessrightsgroupid"));
        long id2 = Long.parseLong(request.getParameter("systemmoduleid"));
        String activity = "a";
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            String[] params10 = {"accessrightsgroupid", "active"};
            Object[] paramsValues10 = {Integer.parseInt(request.getParameter("accessrightsgroupid")), true};
            String[] fields10 = {"privilegeid"};
            List<Long> accessrightsgroup10 = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields10, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params10, paramsValues10);
            if (accessrightsgroup10 != null) {
                for (Long priv : accessrightsgroup10) {
                    assignedgrppriv.add(priv);
                }
            }
            model.put("systemmoduleid", id2);
            model.put("groupname", request.getParameter("groupname"));
            model.put("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }

            String[] params6 = {"stafffacilityunitid", "accessrightsgroupid", "stafffacilityunitaccessrightprivstatus"};
            Object[] paramsValues6 = {Long.parseLong(request.getParameter("stafffacilityunitid")), Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
            String[] fields6 = {"privilegeid"};
            List<Long> privilegeidd = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fields6, "WHERE stafffacilityunitid=:stafffacilityunitid AND accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", params6, paramsValues6);
            if (privilegeidd != null) {
                for (Long priv : privilegeidd) {
                    assignedstaffpriv.add(priv);
                    if (!assignedgrppriv.isEmpty() && assignedgrppriv.contains(priv)) {
                        assignedgrppriv.remove(priv);
                    }
                }
            }

            List<CustomSystemmodule> customList = new ArrayList<CustomSystemmodule>();
            List<CustomSystemmodule> customChildList = new ArrayList<CustomSystemmodule>();
            model.put("activity", activity);
            if (activity.equals("a")) {
                List<Integer> assignedPrivs = new ArrayList<Integer>();
                String[] fieldPriv = {"privilegeid"};
                String[] paramPriv = {"Id", "active"};
                Object[] paramsValPriv = {id, true};
                List<Object[]> rolePrivArrList = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fieldPriv, "WHERE r.accessrightsgroupid=:Id AND active=:active", paramPriv, paramsValPriv);
                if (rolePrivArrList != null && !rolePrivArrList.isEmpty()) {
                    for (Object obj : rolePrivArrList) {
                        assignedPrivs.add(((Long) obj).intValue());
                    }
                }

                Systemmodule selectedSysModule = null;
                List<Systemmodule> allSysModules = new ArrayList<Systemmodule>();
                String[] fieldSM = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity", "parentid.systemmoduleid"};
                String[] paramSM = {};
                Object[] paramsValSM = {};
                List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE r.status=TRUE ORDER BY r.componentname ASC ", paramSM, paramsValSM);
                if (smArrList != null && !smArrList.isEmpty()) {
                    for (Object[] obj : smArrList) {
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);
                        Systemmodule ssm = new Systemmodule((Long) obj[8]);
                        sm.setParentid(ssm);
                        if (sm.getSystemmoduleid() == id2) {
                            selectedSysModule = sm;
                        }
                        allSysModules.add(sm);
                    }
                }

                List<Systemmodule> allChildSysModules = new ArrayList<Systemmodule>();
                String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname"};
                String[] paramCSM = {};
                Object[] paramsValCSM = {};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
                if (csmArrList != null && !csmArrList.isEmpty()) {
                    for (Object[] ob : csmArrList) {
                        Systemmodule sm = new Systemmodule((Long) ob[0]);
                        Systemmodule ssm = new Systemmodule((Long) ob[1]);
                        sm.setParentid(ssm);
                        sm.setComponentname((String) ob[2]);
                        allChildSysModules.add(sm);
                    }
                }

                List<Systemmodule> allPrivSysModules = new ArrayList<Systemmodule>();
                String[] fieldSmPriv = {"systemmoduleid", "privilegeid", "parentid.systemmoduleid"};
                String[] paramSmPriv = {};
                Object[] paramsValSmPriv = {};
                List<Object[]> sysArrListSmPriv = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSmPriv, "WHERE r.status=TRUE AND r.privilegeid IS NOT NULL", paramSmPriv, paramsValSmPriv);
                if (sysArrListSmPriv != null && !sysArrListSmPriv.isEmpty()) {
                    for (Object[] obj3 : sysArrListSmPriv) {
                        Systemmodule sm = new Systemmodule((Long) obj3[0]);
                        Systemmodule ssm = new Systemmodule((Long) obj3[2]);
                        sm.setParentid(ssm);
                        sm.setPrivilegeid((BigInteger) obj3[1]);
                        allPrivSysModules.add(sm);
                    }
                }

                String[] field = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] param = {"ssmid"};
                Object[] paramsValue = {id2};
                List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
                if (sysArrList != null && !sysArrList.isEmpty()) {
                    for (Object[] obj : sysArrList) {
                        CustomSystemmodule ssm = new CustomSystemmodule();
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<Long>();

                        if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        ssm.setSubmodules(subModules);

                        if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                            for (Systemmodule obj3 : allPrivSysModules) {
                                if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    sm.setPrivilegeid(obj3.getPrivilegeid());
                                }
                            }
                            if (!assignedstaffpriv.isEmpty() && assignedstaffpriv.contains(sm.getPrivilegeid().longValue())) {
                                ssm.setAssignedpost(true);
                            }
                            if (!assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).intValue())) {
                                ssm.setAssigned(true);
                            } else {

//                                    logger.info("privilege un assigned ::::::::::::::: false");
                                ssm.setAssigned(false);
                            }

                        }
                        ssm.setSystemmodule(sm);

                        //Call function to load child elements
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList = loadParentActivityrepeat(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, id, assignedPrivs, assignedstaffpriv);

                        }
                        ssm.setCustomSystemmoduleList(customChildList);
                        customList.add(ssm);

                    }
                }
            }

            model.put("customList", customList);

            model.put("customLists", new ObjectMapper().writeValueAsString(customList));
            if (customList != null && !customList.isEmpty()) {
                model.put("size", customList.size());
            }
            model.put("assignedgrpprivsize", assignedgrppriv.size());
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/activitiesAndRights/userAccessRights/forms/groupaccessrightsandmoduleTree", "model", model);
    }

    @RequestMapping(value = "/savestaffaccessgrouprightsprivileges.htm")
    public @ResponseBody
    String SaveStaffAccessGroupRightsPrivileges(HttpServletRequest request, Model model) {
        String results = "";
        try {
            List<Long> allassignedprivileges = new ArrayList<>();
            List<Long> allstaffassignedprivileges = new ArrayList<>();

            String[] paramss = {"accessrightsgroupid", "stafffacilityunitid"};
            Object[] paramsValuess = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Long.parseLong(request.getParameter("stafffacilityunitid"))};
            String[] fieldss = {"privilegeid"};
            List<Long> staffprivilegesid = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fieldss, "WHERE accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitid=:stafffacilityunitid", paramss, paramsValuess);
            if (staffprivilegesid != null) {
                for (Long staffprivileges : staffprivilegesid) {
                    allstaffassignedprivileges.add(staffprivileges);
                }
            }

            String[] params = {"accessrightsgroupid", "active"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("accessrightsgroupid")), true};
            String[] fields = {"privilegeid"};
            List<Long> accessrightsgroup = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
            if (accessrightsgroup != null) {
                for (Long priv : accessrightsgroup) {
                    if (allstaffassignedprivileges.isEmpty()) {
                        allassignedprivileges.add(priv);
                    } else {
                        if (!allstaffassignedprivileges.contains(priv)) {
                            allassignedprivileges.add(priv);
                        }
                    }

                }
            }
            if (request.getParameter("set") != null) {
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("set"), List.class);
                for (String item1 : item) {
                    if (allassignedprivileges.contains(Long.parseLong(item1))) {
                        allassignedprivileges.remove(Long.parseLong(item1));
                    }
                }
            }
            if (!allassignedprivileges.isEmpty()) {
                Integer accessright;
                for (Long assign : allassignedprivileges) {
                    String[] params1 = {"accessrightsgroupid", "privilegeid"};
                    Object[] paramsValues1 = {Integer.parseInt(request.getParameter("accessrightsgroupid")), assign};
                    String[] fields1 = {"accessrightgroupprivilegeid"};
                    List<Integer> accessrightsgroup1 = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields1, "WHERE accessrightsgroupid=:accessrightsgroupid AND privilegeid=:privilegeid", params1, paramsValues1);
                    if (accessrightsgroup1 != null) {
                        Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege;
                        accessright = accessrightsgroup1.get(0);
                        stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                        stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                        stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                        stafffacilityunitaccessrightprivilege.setStafffacilityunitid(Long.parseLong(request.getParameter("stafffacilityunitid")));
                        stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid(accessright);
                        genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);
                    }
                }

            }
        } catch (IOException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/saveaccessrightsgroupprivilegesdesignment.htm")
    public @ResponseBody
    String SaveAccessRightsGroupPrivilegesDesignment(HttpServletRequest request, Model model) {
        String results = "success";
        List<String> item;
        try {
            List<Long> allassignedprivileges = new ArrayList<>();
            List<Long> designgroupprivilegs = new ArrayList<>();
            String[] params = {"accessrightsgroupid", "active"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("accessrightsgroupid")), true};
            String[] fields = {"privilegeid"};
            List<Long> accessrightsgroup = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
            if (accessrightsgroup != null) {
                for (Long priv : accessrightsgroup) {
                    allassignedprivileges.add(priv);
                }
            }
            item = (ArrayList) new ObjectMapper().readValue(request.getParameter("data"), List.class);
            for (String item1 : item) {
                if (!allassignedprivileges.isEmpty()) {
                    if (allassignedprivileges.contains(Long.parseLong(item1))) {
                        designgroupprivilegs.add(Long.parseLong(item1));
                    }
                }
            }
            if (!designgroupprivilegs.isEmpty()) {
                for (Long des : designgroupprivilegs) {
                    String[] params1 = {"privilegeid", "accessrightsgroupid"};
                    Object[] paramsValues1 = {des, Integer.parseInt(request.getParameter("accessrightsgroupid"))};
                    String[] fields1 = {"accessrightgroupprivilegeid"};
                    List<Integer> accessrightsgroup1 = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields1, "WHERE privilegeid=:privilegeid AND accessrightsgroupid=:accessrightsgroupid", params1, paramsValues1);
                    if (accessrightsgroup1 != null) {
                        Integer accessrightsgroupprivilegeid = accessrightsgroup1.get(0);

                        Long updatedby = (Long) request.getSession().getAttribute("person_id");
                        String[] columns = {"active", "updatedby", "dateupdated"};
                        Object[] columnValues = {false, updatedby, new Date()};
                        String pk = "accessrightgroupprivilegeid";
                        Object pkValue = accessrightsgroupprivilegeid;
                        int result = genericClassService.updateRecordSQLSchemaStyle(Accessrightgroupprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");
                    }
                }
            }
        } catch (IOException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/saveorremoveprivilegesfromaccessrightsgroup.htm")
    public @ResponseBody
    String SaveOrRemovePrivilegesFromAccessRightsGroup(HttpServletRequest request, Model model) {
        String results = "";
        Set<Long> allparentsysmods = new HashSet<Long>();
        Set<Long> allgroupprivs = new HashSet<Long>();
        try {
            if (request.getParameter("add") != null) {
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("add"), List.class);
                for (String item1 : item) {
                    Accessrightgroupprivilege accessrightgroupprivilege = new Accessrightgroupprivilege();
                    accessrightgroupprivilege.setPrivilegeid(Long.parseLong(item1));
                    accessrightgroupprivilege.setAccessrightsgroupid(Integer.parseInt(request.getParameter("accessgrouprightsid")));
                    accessrightgroupprivilege.setActive(Boolean.TRUE);
                    accessrightgroupprivilege.setDateadded(new Date());
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightgroupprivilege);

                    List<Long> allparentmodules = new ArrayList<Long>();
                    String[] params = {"status"};
                    Object[] paramsValues = {true};
                    String[] fields = {"systemmoduleid"};
                    List<Long> systemmodules = (List<Long>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE status=:status AND r.privilegeid IS NOT NULL", params, paramsValues);
                    if (systemmodules != null) {
                        for (Long sysmods : systemmodules) {
                            allparentmodules.add(sysmods);
                        }
                    }
                    List<Long> parents = new ArrayList<Long>();
                    String[] params1 = {"privilegeid"};
                    Object[] paramsValues1 = {Long.parseLong(item1)};
                    String[] fields1 = {"systemmoduleid", "parentid.systemmoduleid"};
                    List<Object[]> systemmodules1 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE privilegeid=:privilegeid", params1, paramsValues1);
                    if (systemmodules1 != null) {
                        Object[] symd = systemmodules1.get(0);
                        for (Long add : getparent(allparentmodules, (Long) symd[1], parents)) {
                            allparentsysmods.add(add);
                        }
                    }

                }
                String[] params3 = {"accessrightsgroupid", "active"};
                Object[] paramsValues3 = {Integer.parseInt(request.getParameter("accessgrouprightsid")), true};
                String[] fields3 = {"privilegeid"};
                List<Long> systemmodules3 = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields3, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params3, paramsValues3);
                if (systemmodules3 != null) {
                    for (Long sys : systemmodules3) {
                        allgroupprivs.add(sys);
                    }
                }
                if (!allparentsysmods.isEmpty()) {
                    for (Long allparentmd : allparentsysmods) {
                        String[] params2 = {"systemmoduleid"};
                        Object[] paramsValues2 = {allparentmd};
                        String[] fields2 = {"privilegeid"};
                        List<BigInteger> systemmodules2 = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fields2, "WHERE systemmoduleid=:systemmoduleid", params2, paramsValues2);
                        if (systemmodules2 != null) {
                            BigInteger priv = systemmodules2.get(0);
                            if (!allgroupprivs.isEmpty()) {
                                if (!allgroupprivs.contains(priv.longValue())) {
                                    Accessrightgroupprivilege accessrightgroupprivilege = new Accessrightgroupprivilege();
                                    accessrightgroupprivilege.setPrivilegeid(priv.longValue());
                                    accessrightgroupprivilege.setAccessrightsgroupid(Integer.parseInt(request.getParameter("accessgrouprightsid")));
                                    accessrightgroupprivilege.setActive(Boolean.TRUE);
                                    accessrightgroupprivilege.setDateadded(new Date());
                                    Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightgroupprivilege);

                                }
                            }
                        }
                    }
                }
            }
            if (request.getParameter("remove") != null) {
                List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("remove"), List.class);

                for (String item1 : item) {
                    String[] params2 = {"privilegeid", "accessrightsgroupid"};
                    Object[] paramsValues2 = {Long.parseLong(item1), Integer.parseInt(request.getParameter("accessgrouprightsid"))};
                    String[] fields2 = {"accessrightgroupprivilegeid"};
                    List<Integer> accessid = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields2, "WHERE privilegeid=:privilegeid AND accessrightsgroupid=:accessrightsgroupid", params2, paramsValues2);
                    if (accessid != null) {
                        Integer accessrightsgroupprivilegeid = accessid.get(0);

                        Long updatedby = (Long) request.getSession().getAttribute("person_id");
                        String[] columns = {"active", "updatedby", "dateupdated"};
                        Object[] columnValues = {false, updatedby, new Date()};
                        String pk = "accessrightgroupprivilegeid";
                        Object pkValue = accessrightsgroupprivilegeid;
                        int result = genericClassService.updateRecordSQLSchemaStyle(Accessrightgroupprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");
                        if (result != 0) {
                            String[] params = {"accessrightgroupprivilegeid"};
                            Object[] paramsValues = {accessrightsgroupprivilegeid};
                            String[] fields = {"stafffacilityunitaccessrightprivilegeid"};
                            List<Integer> systemmodules = (List<Integer>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fields, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid", params, paramsValues);
                            if (systemmodules != null) {
                                for (Integer pks : systemmodules) {
                                    String[] columns1 = {"active", "lastupdatedby", "lastupdated"};
                                    Object[] columnValues1 = {false, updatedby, new Date()};
                                    String pk1 = "stafffacilityunitaccessrightprivilegeid";
                                    Object pkValue1 = pks;
                                    int result1 = genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunitaccessrightprivilege.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");
                                }

                            }
                        }
                    }
                }
            }

        } catch (IOException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/diactivateoractivateaccessrightsgroup.htm")
    public @ResponseBody
    String DiactivateOrActivateAccessRightsGroup(HttpServletRequest request, Model model) {
        String results = "";
        if ("diactivate".equals(request.getParameter("type"))) {
            Long updatedby = (Long) request.getSession().getAttribute("person_id");
            String[] columns = {"active", "lastupdatedby", "lastupdated"};
            Object[] columnValues = {false, updatedby, new Date()};
            String pk = "accessrightsgroupid";
            Object pkValue = Integer.parseInt(request.getParameter("accessrightgroupid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Accessrightsgroup.class, columns, columnValues, pk, pkValue, "controlpanel");

        } else {
            Long updatedby = (Long) request.getSession().getAttribute("person_id");
            String[] columns = {"active", "lastupdatedby", "lastupdated"};
            Object[] columnValues = {true, updatedby, new Date()};
            String pk = "accessrightsgroupid";
            Object pkValue = Integer.parseInt(request.getParameter("accessrightgroupid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Accessrightsgroup.class, columns, columnValues, pk, pkValue, "controlpanel");

        }

        return results;
    }

    @RequestMapping(value = "/getsubmodulesorcomponentsmodule.htm")
    public @ResponseBody
    String getsubmodulesorcomponentsmodule(HttpServletRequest request, Model model) {
        String results = "";
        try {
            if ("activate".equals(request.getParameter("type"))) {

            } else {
                List<Long> allchildmos = new ArrayList<>();
                Set<Long> resultallchildmos = new HashSet<>();
                String[] params1 = {"systemmoduleid"};
                Object[] paramsValues1 = {Long.parseLong(request.getParameter("systemmoduleid"))};
                String[] fields1 = {"systemmoduleid"};
                List<Long> systemmodules1 = (List<Long>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid=:systemmoduleid", params1, paramsValues1);
                if (systemmodules1 != null) {
                    for (Long symd : systemmodules1) {
                        allchildmos.add(symd);
                        for (Long add : getchildrenmodules(allchildmos, symd)) {
                            resultallchildmos.add(add);
                        }
                    }
                }
                results = new ObjectMapper().writeValueAsString(resultallchildmos);
            }
        } catch (JsonProcessingException | NumberFormatException e) {
        }

        return results;
    }

    @RequestMapping(value = "/diactivateoractivatesystemmodule.htm")
    public @ResponseBody
    String diactivateoractivatesystemmodule(HttpServletRequest request, Model model) {
        String results = "";
        try {

            if ("activate".equals(request.getParameter("type"))) {

                Long updatedby = (Long) request.getSession().getAttribute("person_id");
                String[] columns = {"status", "updatedby", "dateupdated"};
                Object[] columnValues = {true, updatedby, new Date()};
                String pk = "systemmoduleid";
                Object pkValue = Long.parseLong(request.getParameter("systemmoduleid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns, columnValues, pk, pkValue, "controlpanel");
                if (result != 0) {
                    List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    for (Integer item1 : item) {
                        String[] columns1 = {"status", "updatedby", "dateupdated"};
                        Object[] columnValues1 = {true, updatedby, new Date()};
                        String pk1 = "systemmoduleid";
                        Object pkValue1 = Long.parseLong(String.valueOf(item1));
                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");

                    }
                }
            } else {
                Long updatedby = (Long) request.getSession().getAttribute("person_id");
                String[] columns = {"status", "updatedby", "dateupdated"};
                Object[] columnValues = {false, updatedby, new Date()};
                String pk = "systemmoduleid";
                Object pkValue = Long.parseLong(request.getParameter("systemmoduleid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns, columnValues, pk, pkValue, "controlpanel");
                if (result != 0) {
                    List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    for (Integer item1 : item) {
                        String[] columns1 = {"status", "updatedby", "dateupdated"};
                        Object[] columnValues1 = {false, updatedby, new Date()};
                        String pk1 = "systemmoduleid";
                        Object pkValue1 = Long.parseLong(String.valueOf(item1));
                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");

                    }
                }
            }
        } catch (IOException | NumberFormatException e) {
        }

        return results;
    }

    public List<Long> getchildrenmodules(List<Long> allchildmos, Long systemoduleid) {
        String[] params = {"systemmoduleid"};
        Object[] paramsValues = {systemoduleid};
        String[] fields = {"systemmoduleid"};
        List<Long> systemmodules = (List<Long>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid=:systemmoduleid", params, paramsValues);
        if (systemmodules != null) {
            for (Long sym : systemmodules) {
                allchildmos.add(sym);
                getchildrenmodules(allchildmos, sym);
            }

        }
        return allchildmos;
    }

    @RequestMapping(value = "/updatesystemmoduledetails.htm")
    public @ResponseBody
    String updatesystemmoduledetails(HttpServletRequest request, Model model) {
        String results = "";
        String[] columns1 = {"componentname", "updatedby", "dateupdated", "description", "activity"};
        Object[] columnValues1 = {request.getParameter("systemmodulename"), BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")), new Date(), request.getParameter("description"), request.getParameter("itemtype")};
        String pk1 = "systemmoduleid";
        Object pkValue1 = Long.parseLong(request.getParameter("systemmoduleid"));
        int result1 = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");

        return results;
    }

    @RequestMapping(value = "/saveorupdateprivilegekey.htm")
    public @ResponseBody
    String saveorupdateprivilegekey(HttpServletRequest request, Model model) {
        String results = "";
        if ("update".equals(request.getParameter("type"))) {
            String[] columns1 = {"privilege", "description", "privilegekey"};
            Object[] columnValues1 = {request.getParameter("privilege"), request.getParameter("description"), request.getParameter("privilegekey")};
            String pk1 = "privilegeid";
            Object pkValue1 = Integer.parseInt(request.getParameter("privilegekeyid"));
            int result1 = genericClassService.updateRecordSQLSchemaStyle(Privilege.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");
            if (result1 != 0) {
                results = "success";
            }
        } else {

        }

        return results;
    }

    @RequestMapping(value = "/privilegeslist.htm", method = RequestMethod.GET)
    public String privilegeslist(HttpServletRequest request, Model model) {
        Set<BigInteger> assignedprivileges = new HashSet<>();
        List<Privilege> privilegelist = new ArrayList<>();
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"privilegeid"};
        List<BigInteger> privileges1 = (List<BigInteger>) genericClassService.fetchRecord(Systemmodule.class, fields1, "", params1, paramsValues1);
        if (privileges1 != null) {
            for (BigInteger priv : privileges1) {
                assignedprivileges.add(priv);
            }
        }
        String[] params = {"active"};
        Object[] paramsValues = {Boolean.TRUE};
        String[] fields = {"privilegeid", "privilege", "privilegekey", "description"};
        List<Object[]> privileges = (List<Object[]>) genericClassService.fetchRecord(Privilege.class, fields, "WHERE active=:active", params, paramsValues);
        if (privileges != null) {
            for (Object[] priv : privileges) {
                if (!assignedprivileges.isEmpty() && !assignedprivileges.contains(BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) priv[0]))))) {
                    Privilege privilege = new Privilege();
                    privilege.setDescription((String) priv[3]);
                    privilege.setPrivilege((String) priv[1]);
                    privilege.setPrivilegekey((String) priv[2]);
                    privilege.setPrivilegeid((int) priv[0]);
                    privilegelist.add(privilege);
                }
            }
        }
        model.addAttribute("privilegelist", privilegelist);
        return "controlPanel/universalPanel/activitiesAndRights/developerKeys/forms/developerPrivilege";
    }

    @RequestMapping(value = "/saveassignedprivilegekeytosystemmodule.htm")
    public @ResponseBody
    String saveassignedprivilegekeytosystemmodule(HttpServletRequest request, Model model) {
        String results = "";
        try {
            List<String> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String item1 : itemz) {
                String[] columns1 = {"hasprivilege", "privilegeid"};
                Object[] columnValues1 = {Boolean.TRUE, BigInteger.valueOf(Long.parseLong(item1))};
                String pk1 = "systemmoduleid";
                Object pkValue1 = Long.parseLong(request.getParameter("systemmoduleid"));
                int result1 = genericClassService.updateRecordSQLSchemaStyle(Systemmodule.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");
                if (result1 != 0) {
                    results = "success";
                }
            }
        } catch (IOException e) {
        }

        return results;
    }

    @RequestMapping(value = "/savenewprivilegekeydetails.htm")
    public @ResponseBody
    String savenewprivilegekey(HttpServletRequest request, Model model) {
        String results = "";
        try {
            Privilege privilege = new Privilege();
            privilege.setActive(true);
            privilege.setDescription(request.getParameter("privmoreinfo"));
            privilege.setPrivilege(request.getParameter("privilegename"));
            privilege.setPrivilegetype("SYSTEM");
            privilege.setPrivilegekey(request.getParameter("privilegekey"));
            privilege.setPrivilegelevel(1);
            genericClassService.saveOrUpdateRecordLoadObject(privilege);
        } catch (Exception e) {
        }

        return results;
    }

    @RequestMapping(value = "/deletesystemmodule.htm")
    public @ResponseBody
    String deletesystemmodule(HttpServletRequest request, Model model) {
        String results = "";
        String[] columns = {"systemmoduleid"};
        Object[] columnValues = {Long.parseLong(request.getParameter("systemmoduleid"))};
        int result = genericClassService.deleteRecordByByColumns("controlpanel.systemmodule", columns, columnValues);
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/getstafffacilityunitaccessrightsgroups.htm", method = RequestMethod.GET)
    public final String getstafffacilityunitaccessrightsgroups(HttpServletRequest request, Model model) {
        List<Map> staffgroups = new ArrayList<>();
        Set<Integer> allaccessgroups = new HashSet<>();

        String[] params1 = {"stafffacilityunitid", "stafffacilityunitaccessrightprivstatus"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("stafffacilityunitid")), Boolean.TRUE};
        String[] fields1 = {"accessrightsgroupid"};
        List<Integer> accessrightsgroupid = (List<Integer>) genericClassService.fetchRecord(Staffassignedrights.class, fields1, "WHERE stafffacilityunitid=:stafffacilityunitid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", params1, paramsValues1);
        if (accessrightsgroupid != null) {
            for (Integer accessrightsgroup : accessrightsgroupid) {
                allaccessgroups.add(accessrightsgroup);
            }
        }
        if (!allaccessgroups.isEmpty()) {
            Map<String, Object> accessrightsgroupRow;
            for (Integer accessrightsgrups : allaccessgroups) {
                accessrightsgroupRow = new HashMap<>();
                String[] params = {"active", "accessrightsgroupid"};
                Object[] paramsValues = {Boolean.TRUE, accessrightsgrups};
                String[] fields = {"designationcategoryid"};
                List<Long> designationcategoryid = (List<Long>) genericClassService.fetchRecord(Accessrightsgroup.class, fields, "WHERE active=:active AND accessrightsgroupid=:accessrightsgroupid", params, paramsValues);
                if (designationcategoryid != null) {
                    String[] params2 = {"designationcategoryid"};
                    Object[] paramsValues2 = {designationcategoryid.get(0)};
                    String[] fields2 = {"categoryname"};
                    List<String> categoryname = (List<String>) genericClassService.fetchRecord(Designationcategory.class, fields2, "WHERE designationcategoryid=:designationcategoryid", params2, paramsValues2);
                    accessrightsgroupRow.put("groupname", categoryname.get(0));
                    accessrightsgroupRow.put("accessrightsgroupid", accessrightsgrups);
                    staffgroups.add(accessrightsgroupRow);
                }
            }

        }
        model.addAttribute("staffgroups", staffgroups);
        model.addAttribute("size", staffgroups.size());
        model.addAttribute("stafffacilityunitid", request.getParameter("stafffacilityunitid"));
        return "controlPanel/universalPanel/activitiesAndRights/userAccessRights/forms/staffAssignedGroups";
    }

    @RequestMapping(value = "/getassignedcomponents.htm", method = RequestMethod.GET)
    public final String getassignedcomponents(HttpServletRequest request, Model model) {
        List<Map> systemcomponents = new ArrayList<>();
        Set<Long> allsystemmodulesids = new HashSet<>();
        String[] params = {"status"};
        Object[] paramsValues = {Boolean.TRUE};
        String[] fields = {"systemmoduleid"};
        List<Long> systemmodules = (List<Long>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status", params, paramsValues);
        if (systemmodules != null) {
            for (Long systemmoduleid : systemmodules) {
                allsystemmodulesids.add(systemmoduleid);
            }
        }
        String[] params1 = {"stafffacilityunitid", "accessrightsgroupid", "stafffacilityunitaccessrightprivstatus"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("stafffacilityunitid")), Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
        String[] fields1 = {"privilegeid"};
        List<Long> privilegeid = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fields1, "WHERE stafffacilityunitid=:stafffacilityunitid AND accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", params1, paramsValues1);
        if (privilegeid != null) {
            Map<String, Object> systemcomponentsRow;
            for (Long privilege : privilegeid) {
                systemcomponentsRow = new HashMap<>();
                String[] params2 = {"privilegeid"};
                Object[] paramsValues2 = {BigInteger.valueOf(privilege)};
                String[] fields2 = {"systemmoduleid", "componentname"};
                List<Object[]> systemcomp = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields2, "WHERE privilegeid=:privilegeid", params2, paramsValues2);

                if (systemcomp != null && !allsystemmodulesids.isEmpty() && allsystemmodulesids.contains((Long) systemcomp.get(0)[0])) {
                    systemcomponentsRow.put("componentname", systemcomp.get(0)[1]);
                    systemcomponentsRow.put("systemmoduleid", systemcomp.get(0)[0]);
                    systemcomponentsRow.put("privilegeid", privilege);
                    systemcomponents.add(systemcomponentsRow);
                }
            }
        }
        model.addAttribute("systemcomponents", systemcomponents);
        model.addAttribute("sizes", systemcomponents.size());
        model.addAttribute("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
        model.addAttribute("stafffacilityunitid", request.getParameter("stafffacilityunitid"));
        return "controlPanel/universalPanel/activitiesAndRights/userAccessRights/forms/staffAssignedComponents";
    }

    public Map<String, Object> getChildrenSystemModules(int size, Set<Long> allassignedprivilegeid, Long systemmoduleid, int i, Map<String, Object> systemcomponentsRow1) {
        Map<String, Object> systemcomponentsRow = null;
        String[] params2 = {"systemmoduleid"};
        Object[] paramsValues2 = {systemmoduleid};
        String[] fields2 = {"systemmoduleid", "componentname", "privilegeid"};
        List<Object[]> systemcomp = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields2, "WHERE r.parentid.systemmoduleid=:systemmoduleid", params2, paramsValues2);
        if (systemcomp != null) {
            for (Object[] systemcomponent : systemcomp) {
                systemcomponentsRow = new HashMap<>();
                if (!allassignedprivilegeid.isEmpty() && allassignedprivilegeid.contains(((BigInteger) systemcomponent[2]).longValue())) {
                    systemcomponentsRow.put("systemmoduleid", systemcomponent[0]);
                    systemcomponentsRow.put("componentname", systemcomponent[1]);
                    systemcomponentsRow.put("i", i++);
                    if (i == size) {
                        return systemcomponentsRow1;
                    } else {
                        getChildrenSystemModules(size, allassignedprivilegeid, (Long) systemcomponent[0], i, systemcomponentsRow);
                    }
                    return systemcomponentsRow;
                }
            }
            systemcomponentsRow1.put("systemcomponentsRow" + i, systemcomponentsRow);
        }
        return systemcomponentsRow1;
    }

    @RequestMapping(value = "/activitiesandaccessrightsaddsubcomponents.htm", method = RequestMethod.GET)
    public final String activitiesandaccessrightsaddsubcomponents(HttpServletRequest request, Model model) {
        model.addAttribute("numberofsubcomponents", request.getParameter("numberofsubcomponents"));
        model.addAttribute("savetype", request.getParameter("savetype"));
        return "controlPanel/universalPanel/activitiesAndRights/modulesAndComponents/forms/addSubComponents";
    }

    @RequestMapping(value = "/viewstaffassinedgroupsaccessrights.htm", method = RequestMethod.GET)
    public final String viewstaffassinedgroupsaccessrights(HttpServletRequest request, Model model) {
        List<Map> staffgroups = new ArrayList<>();

        Set<Integer> allaccessgroups = new HashSet<>();
        String[] params1 = {"stafffacilityunitid", "stafffacilityunitaccessrightprivstatus"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("stafffacilityunitid")), Boolean.TRUE};
        String[] fields1 = {"accessrightsgroupid", "privilegeid"};
        List<Object[]> accessrightsgroupid = (List<Object[]>) genericClassService.fetchRecord(Staffassignedrights.class, fields1, "WHERE stafffacilityunitid=:stafffacilityunitid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", params1, paramsValues1);
        if (accessrightsgroupid != null) {
            for (Object[] accessrightsgroup : accessrightsgroupid) {
                allaccessgroups.add((Integer) accessrightsgroup[0]);
            }
        }
        if (!allaccessgroups.isEmpty()) {
            Map<String, Object> accessrightsgroupRow;
            for (Integer accessrightsgrups : allaccessgroups) {
                Set<Long> allprivileges = new HashSet<>();
                String[] params9 = {"stafffacilityunitid", "stafffacilityunitaccessrightprivstatus", "accessrightsgroupid"};
                Object[] paramsValues9 = {Long.parseLong(request.getParameter("stafffacilityunitid")), Boolean.TRUE, accessrightsgrups};
                String[] fields9 = {"privilegeid"};
                List<Long> accessrightsgroupid9 = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fields9, "WHERE stafffacilityunitid=:stafffacilityunitid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus AND accessrightsgroupid=:accessrightsgroupid", params9, paramsValues9);
                if (accessrightsgroupid9 != null) {
                    for (Long accessrightsgrou : accessrightsgroupid9) {
                        allprivileges.add(accessrightsgrou);
                    }
                }
                accessrightsgroupRow = new HashMap<>();
                String[] params = {"active", "accessrightsgroupid"};
                Object[] paramsValues = {Boolean.TRUE, accessrightsgrups};
                String[] fields = {"designationcategoryid", "description"};
                List<Object[]> designationcategoryid = (List<Object[]>) genericClassService.fetchRecord(Accessrightsgroup.class, fields, "WHERE active=:active AND accessrightsgroupid=:accessrightsgroupid", params, paramsValues);
                if (designationcategoryid != null) {
                    String[] params2 = {"designationcategoryid"};
                    Object[] paramsValues2 = {designationcategoryid.get(0)[0]};
                    String[] fields2 = {"categoryname"};
                    List<String> categoryname = (List<String>) genericClassService.fetchRecord(Designationcategory.class, fields2, "WHERE designationcategoryid=:designationcategoryid", params2, paramsValues2);
                    accessrightsgroupRow.put("groupname", categoryname.get(0));
                    accessrightsgroupRow.put("accessrightsgroupid", accessrightsgrups);
                    accessrightsgroupRow.put("description", designationcategoryid.get(0)[1]);
                    List<Map> systemmoduleprivilege = new ArrayList<>();
                    String[] field = {"systemmoduleid", "componentname", "privilegeid"};
                    String[] param = {};
                    Object[] paramsValue = {};
                    List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE  r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC ", param, paramsValue);
                    if (sysArrList != null) {
                        Map<String, Object> systemmoduleprivilegeRow;
                        for (Object[] system : sysArrList) {
                            systemmoduleprivilegeRow = new HashMap<>();
                            if (!allprivileges.isEmpty() && system[2] != null && allprivileges.contains(((BigInteger) system[2]).longValue())) {
                                systemmoduleprivilegeRow.put("privilegeid", (BigInteger) system[2]);
                                systemmoduleprivilegeRow.put("componentname", (String) system[1]);
                                systemmoduleprivilegeRow.put("systemmoduleid", (Long) system[0]);
                                systemmoduleprivilege.add(systemmoduleprivilegeRow);
                            }
                        }
                    }
                    accessrightsgroupRow.put("systemmoduleprivilegeRow", systemmoduleprivilege);
                    staffgroups.add(accessrightsgroupRow);
                }
            }

        }

        model.addAttribute("staffgroups", staffgroups);
        model.addAttribute("stafffacilityunitid", request.getParameter("stafffacilityunitid"));
        return "controlPanel/universalPanel/activitiesAndRights/userAccessRights/views/accessRightsGroups";
    }

    @RequestMapping(value = "/getstaffaccessrightsassignmentbytree.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView getstaffaccessrightsassignmentbytree(HttpServletRequest request, Principal principal) {
        List<Systemmodule> systemroleslist = new ArrayList<>();

        long id = Long.parseLong(request.getParameter("accessrightsgroupid"));
        long id2 = Long.parseLong(request.getParameter("systemmoduleidid"));
        String activity = "a";
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("systemmoduleid", id2);
            model.put("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
            model.put("stafffacilityunitid", request.getParameter("stafffacilityunitid"));
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }

            List<CustomSystemmodule> customList = new ArrayList<CustomSystemmodule>();
            List<CustomSystemmodule> customChildList = new ArrayList<CustomSystemmodule>();
            model.put("activity", activity);
            if (activity.equals("a")) {
                List<Long> assignedPrivs = new ArrayList<>();

                String[] paramPriv = {"stafffacilityunitid", "accessrightsgroupid", "stafffacilityunitaccessrightprivstatus"};
                Object[] paramsValPriv = {Long.parseLong(request.getParameter("stafffacilityunitid")), Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
                String[] fieldPriv = {"privilegeid"};
                List<Long> rolePrivArrList = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fieldPriv, "WHERE stafffacilityunitid=:stafffacilityunitid AND accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", paramPriv, paramsValPriv);
                if (rolePrivArrList != null) {
                    for (Long privilege : rolePrivArrList) {
                        assignedPrivs.add(privilege);
                    }
                }

                Systemmodule selectedSysModule = null;
                List<Systemmodule> allSysModules = new ArrayList<Systemmodule>();
                String[] fieldSM = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity", "parentid.systemmoduleid"};
                String[] paramSM = {};
                Object[] paramsValSM = {};
                List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE r.status=TRUE ORDER BY r.componentname ASC ", paramSM, paramsValSM);
                if (smArrList != null && !smArrList.isEmpty()) {
                    for (Object[] obj : smArrList) {
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);
                        Systemmodule ssm = new Systemmodule((Long) obj[8]);
                        sm.setParentid(ssm);
                        if (sm.getSystemmoduleid() == id2) {
                            selectedSysModule = sm;
                        }
                        allSysModules.add(sm);
                    }
                }

                List<Systemmodule> allChildSysModules = new ArrayList<Systemmodule>();
                String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname"};
                String[] paramCSM = {};
                Object[] paramsValCSM = {};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
                if (csmArrList != null && !csmArrList.isEmpty()) {
                    for (Object[] ob : csmArrList) {
                        Systemmodule sm = new Systemmodule((Long) ob[0]);
                        Systemmodule ssm = new Systemmodule((Long) ob[1]);
                        sm.setParentid(ssm);
                        sm.setComponentname((String) ob[2]);
                        allChildSysModules.add(sm);
                    }
                }

                List<Systemmodule> allPrivSysModules = new ArrayList<Systemmodule>();
                String[] fieldSmPriv = {"systemmoduleid", "privilegeid", "parentid.systemmoduleid"};
                String[] paramSmPriv = {};
                Object[] paramsValSmPriv = {};
                List<Object[]> sysArrListSmPriv = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSmPriv, "WHERE r.status=TRUE AND r.privilegeid IS NOT NULL", paramSmPriv, paramsValSmPriv);
                if (sysArrListSmPriv != null && !sysArrListSmPriv.isEmpty()) {
                    for (Object[] obj3 : sysArrListSmPriv) {
                        Systemmodule sm = new Systemmodule((Long) obj3[0]);
                        Systemmodule ssm = new Systemmodule((Long) obj3[2]);
                        sm.setParentid(ssm);
                        sm.setPrivilegeid((BigInteger) obj3[1]);
                        allPrivSysModules.add(sm);
                    }
                }

                String[] field = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] param = {"ssmid"};
                Object[] paramsValue = {id2};
                List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
                if (sysArrList != null && !sysArrList.isEmpty()) {
                    for (Object[] obj : sysArrList) {
                        CustomSystemmodule ssm = new CustomSystemmodule();
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<Long>();

                        if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        ssm.setSubmodules(subModules);

                        if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                            for (Systemmodule obj3 : allPrivSysModules) {
                                if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    sm.setPrivilegeid(obj3.getPrivilegeid());
                                }
                            }
                            if (!assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).longValue())) {
                                ssm.setAssigned(true);
                            } else {

//                                    logger.info("privilege un assigned ::::::::::::::: false");
                                ssm.setAssigned(false);
                            }

                        }
                        ssm.setSystemmodule(sm);

                        //Call function to load child elements
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList = loadParentActivity2(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, id, assignedPrivs);

                        }
                        ssm.setCustomSystemmoduleList(customChildList);
                        customList.add(ssm);

                    }
                }
            }

            model.put("customList", customList);

            model.put("customLists", new ObjectMapper().writeValueAsString(customList));
            if (customList != null && !customList.isEmpty()) {
                model.put("size", customList.size());
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/activitiesAndRights/userAccessRights/forms/accessRightsTree", "model", model);
    }

    private List<CustomSystemmodule> loadParentActivity2(List<Systemmodule> allSysModules, List<Systemmodule> allChildSysModules, List<Systemmodule> allPrivSysModules, HttpServletRequest request, List<Long> ids, long roleid, List<Long> assignedPrivs) {
        List<CustomSystemmodule> customChildList2 = new ArrayList<CustomSystemmodule>();
        List<CustomSystemmodule> customList2 = new ArrayList<CustomSystemmodule>();
        try {
            for (Long id : ids) {
                if (allSysModules != null && !allSysModules.isEmpty()) {
                    for (Systemmodule sm : allSysModules) {
                        if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                            CustomSystemmodule ssm = new CustomSystemmodule();

                            int subModules = 0;
                            List<Long> subModuleId = new ArrayList<Long>();

                            if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                                for (Systemmodule ob : allChildSysModules) {
                                    if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        subModuleId.add(ob.getSystemmoduleid());
                                        subModules += 1;
                                    }
                                }
                            }

                            ssm.setSubmodules(subModules);

                            if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                                for (Systemmodule obj3 : allPrivSysModules) {
                                    if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        sm.setPrivilegeid(obj3.getPrivilegeid());
                                    }
                                }
                                if (sm.getParentid() != null && ((sm.getPrivilegeid()).intValue()) != 0 && !assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).longValue())) {

//                                logger.info("privilege assigned ::::::::::::::: true");
                                    ssm.setAssigned(true);
                                } else {
//                                logger.info("privilege un assigned ::::::::::::::: false");
                                    ssm.setAssigned(false);
                                }
                            }

                            ssm.setSystemmodule(sm);

                            if (subModules > 0) {
//                            logger.info(":Child Fetch:::went In again get::::--------::sms::"+subModules+" for "+sm.getComponentname()+" ::"+subModuleId.size());
                                customChildList2 = loadParentActivity2(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, roleid, assignedPrivs);
                            }
                            ssm.setCustomSystemmoduleList(customChildList2);
                            customList2.add(ssm);
                        }
                    }

                }
            }
        } catch (NullPointerException e) {
        }

        return customList2;
    }

    @RequestMapping(value = "/deassignstaffassignedaccessrightsfromgroup.htm")
    public @ResponseBody
    String deassignstaffassignedaccessrightsfromgroup(HttpServletRequest request, Model model) {
        String results = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String item1 : item) {
                String[] field = {"stafffacilityunitaccessrightprivilegeid"};
                String[] param = {"stafffacilityunitid", "accessrightsgroupid", "privilegeid"};
                Object[] paramsValue = {Long.parseLong(request.getParameter("stfffacilityunitid")), Integer.parseInt(request.getParameter("accessrightgrp")), Long.parseLong(item1)};
                List<Integer> stafffacilityunitaccessrightprivilegeid = (List<Integer>) genericClassService.fetchRecord(Staffassignedrights.class, field, "WHERE stafffacilityunitid=:stafffacilityunitid AND  accessrightsgroupid=:accessrightsgroupid AND privilegeid=:privilegeid", param, paramsValue);
                if (stafffacilityunitaccessrightprivilegeid != null) {
                    String[] columns = {"active"};
                    Object[] columnValues = {Boolean.FALSE};
                    String pk = "stafffacilityunitaccessrightprivilegeid";
                    Object pkValue = stafffacilityunitaccessrightprivilegeid.get(0);
                    int result = genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunitaccessrightprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");

                }
            }
        } catch (IOException e) {
            System.out.println("" + e);
        }

        return results;
    }

    @RequestMapping(value = "/getcascadingsystemmodulesubcomponents.htm", method = RequestMethod.GET)
    public String getcascadingsystemmodulesubcomponents(Model model, HttpServletRequest request) {
        List<Map> systemmodulesList = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            model.addAttribute("act", "a");
            String[] params = {"parentid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("systemmoduleid"))};
            String[] fields = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};
            String where = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (systemmodules != null) {
                Map<String, Object> systemmoduleRow;
                for (Object[] submod : systemmodules) {
                    systemmoduleRow = new HashMap<>();
                    int systemmoduleCount = 0;
                    systemmoduleRow = new HashMap<>();
                    String[] params2 = {"parentid"};
                    Object[] paramsValues2 = {(Long) submod[0]};
                    String where2 = "WHERE parentid=:parentid";
                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                    systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                    systemmoduleRow.put("systemmodulename", (String) submod[1]);
                    systemmoduleRow.put("dateadded", formatter.format((Date) submod[2]));
                    systemmoduleRow.put("dateupadated", formatter.format((Date) submod[3]));
                    systemmoduleRow.put("status", (Boolean) submod[4]);
                    systemmoduleRow.put("hasprivilege", (Boolean) submod[5]);
                    systemmoduleRow.put("systemmoduleid", (Long) submod[0]);
                    systemmoduleRow.put("description", (String) submod[6]);
                    systemmoduleRow.put("activity", (String) submod[7]);
                    systemmodulesList.add(systemmoduleRow);
                }
            }
            model.addAttribute("systemmoduleid", request.getParameter("systemmoduleid"));
        } else if ("b".equals(request.getParameter("act"))) {
            model.addAttribute("act", "b");
            String[] params = {"parentid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("systemmoduleid"))};
            String[] fields = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};
            String where = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (systemmodules != null) {
                Map<String, Object> systemmoduleRow;
                for (Object[] submod : systemmodules) {
                    systemmoduleRow = new HashMap<>();
                    int systemmoduleCount = 0;
                    systemmoduleRow = new HashMap<>();
                    String[] params2 = {"parentid"};
                    Object[] paramsValues2 = {(Long) submod[0]};
                    String where2 = "WHERE parentid=:parentid";
                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                    systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                    systemmoduleRow.put("systemmodulename", (String) submod[1]);
                    systemmoduleRow.put("dateadded", formatter.format((Date) submod[2]));
                    systemmoduleRow.put("dateupadated", formatter.format((Date) submod[3]));
                    systemmoduleRow.put("status", (Boolean) submod[4]);
                    systemmoduleRow.put("hasprivilege", (Boolean) submod[5]);
                    systemmoduleRow.put("systemmoduleid", (Long) submod[0]);
                    systemmoduleRow.put("description", (String) submod[6]);
                    systemmoduleRow.put("activity", (String) submod[7]);
                    systemmodulesList.add(systemmoduleRow);
                }
            }
            model.addAttribute("systemmoduleid", request.getParameter("systemmoduleid"));
        } else if ("c".equals(request.getParameter("act"))) {
            String[] params = {"systemmoduleid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("systemmoduleid"))};
            String[] fields = {"parentid.systemmoduleid", "componentname"};
            String where = "WHERE systemmoduleid=:systemmoduleid ORDER BY r.componentname ASC";
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (systemmodules != null) {
                for (Object[] system : systemmodules) {
                    if (system[0] != null) {
                        if (((Long) system[0]) != Long.parseLong(request.getParameter("initialsystemmoduleid"))) {
                            model.addAttribute("act", "b");
                            model.addAttribute("systemmoduleid", system[0]);
                            String[] params5 = {"systemmoduleid"};
                            Object[] paramsValues5 = {(Long) system[0]};
                            String[] fields5 = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};

                            List<Object[]> systemmodules5 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields5, "WHERE r.parentid.systemmoduleid=:systemmoduleid ORDER BY r.componentname ASC", params5, paramsValues5);
                            if (systemmodules5 != null) {
                                Map<String, Object> systemmoduleRow;
                                for (Object[] systemmod : systemmodules5) {
                                    int systemmoduleCount = 0;
                                    systemmoduleRow = new HashMap<>();
                                    String[] params2 = {"parentid"};
                                    Object[] paramsValues2 = {(Long) systemmod[0]};
                                    String where2 = "WHERE parentid=:parentid";
                                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                                    systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                                    systemmoduleRow.put("systemmodulename", (String) systemmod[1]);
                                    systemmoduleRow.put("dateadded", formatter.format((Date) systemmod[2]));
                                    systemmoduleRow.put("dateupadated", formatter.format((Date) systemmod[3]));
                                    systemmoduleRow.put("status", (Boolean) systemmod[4]);
                                    systemmoduleRow.put("hasprivilege", (Boolean) systemmod[5]);
                                    systemmoduleRow.put("systemmoduleid", (Long) systemmod[0]);
                                    systemmoduleRow.put("description", (String) systemmod[6]);
                                    systemmoduleRow.put("activity", (String) systemmod[7]);
                                    systemmodulesList.add(systemmoduleRow);
                                }
                            }
                        } else {
                            model.addAttribute("act", "a");
                            String[] params4 = {"parentid"};
                            Object[] paramsValues4 = {Long.parseLong(request.getParameter("initialsystemmoduleid"))};
                            String[] fields4 = {"systemmoduleid", "componentname", "dateadded", "dateupdated", "status", "hasprivilege", "description", "activity"};
                            String where4 = "WHERE parentid=:parentid ORDER BY r.componentname ASC";
                            List<Object[]> systemmodules4 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields4, where4, params4, paramsValues4);
                            if (systemmodules4 != null) {
                                Map<String, Object> systemmoduleRow;
                                for (Object[] submod : systemmodules4) {
                                    systemmoduleRow = new HashMap<>();
                                    int systemmoduleCount = 0;
                                    systemmoduleRow = new HashMap<>();
                                    String[] params2 = {"parentid"};
                                    Object[] paramsValues2 = {(Long) submod[0]};
                                    String where2 = "WHERE parentid=:parentid";
                                    systemmoduleCount = genericClassService.fetchRecordCount(Systemmodule.class, where2, params2, paramsValues2);
                                    systemmoduleRow.put("subcomponentcount", systemmoduleCount);
                                    systemmoduleRow.put("systemmodulename", (String) submod[1]);
                                    systemmoduleRow.put("dateadded", formatter.format((Date) submod[2]));
                                    systemmoduleRow.put("dateupadated", formatter.format((Date) submod[3]));
                                    systemmoduleRow.put("status", (Boolean) submod[4]);
                                    systemmoduleRow.put("hasprivilege", (Boolean) submod[5]);
                                    systemmoduleRow.put("systemmoduleid", (Long) submod[0]);
                                    systemmoduleRow.put("description", (String) submod[6]);
                                    systemmoduleRow.put("activity", (String) submod[7]);
                                    systemmodulesList.add(systemmoduleRow);
                                }
                            }
                            model.addAttribute("systemmoduleid", request.getParameter("initialsystemmoduleid"));
                        }

                    }
                }
            }
        }
        model.addAttribute("systemmodulesList", systemmodulesList);
        model.addAttribute("systemmodulesListSize", systemmodulesList.size());
        return "controlPanel/universalPanel/activitiesAndRights/modulesAndComponents/forms/subComponents";
    }

    @RequestMapping(value = "/deleteaccessrightsgroups.htm")
    public @ResponseBody
    String deleteaccessrightsgroups(HttpServletRequest request, Model model) {
        String results = "";
        if ("count".equals(request.getParameter("type"))) {
            String[] params = {"accessrightsgroupid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("accessrightsgroupid"))};
            String[] fields = {"accessrightgroupprivilegeid", "addedby"};
            String where = "WHERE accessrightsgroupid=:accessrightsgroupid";
            List<Object[]> accessrightsgroupid = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, where, params, paramsValues);
            if (accessrightsgroupid != null) {
                results = "notnull";
            } else {
                results = "null";
            }
        } else if ("delete".equals(request.getParameter("type"))) {
            String[] columns = {"accessrightsgroupid"};
            Object[] columnValues = {Integer.parseInt(request.getParameter("accessrightsgroupid"))};
            int result = genericClassService.deleteRecordByByColumns("controlpanel.accessrightsgroup", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/assignedfacilityaccessrights.htm", method = RequestMethod.GET)
    public String assignedfacilityaccessrights(Model model, HttpServletRequest request) {
        try {
            List<Map> facilityFound = new ArrayList<>();
            Set<BigInteger> systempriv = new HashSet<>();
            String[] paramsp = {"status"};
            Object[] paramsValuesp = {Boolean.TRUE};
            String[] fieldsp = {"systemmoduleid", "componentname", "privilegeid"};
            String wherep = "WHERE r.parentid.systemmoduleid IS NULL AND status=:status";
            List<Object[]> parents = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldsp, wherep, paramsp, paramsValuesp);
            if (parents != null) {
                for (Object[] parent : parents) {
                    if (parent[2] != null) {
                        systempriv.add((BigInteger) parent[2]);
                    }
                }
            }
            Set<Integer> systemfacilitypriv = new HashSet<>();
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"facilityid", "facilityname"};
            String where = "";
            List<Object[]> facilitys = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
            if (facilitys != null) {
                Map<String, Object> facilityRow;
                for (Object[] facility : facilitys) {
                    int componentscount = 0;
                    facilityRow = new HashMap<>();
                    String[] params4 = {"facilityid", "isactive"};
                    Object[] paramsValues4 = {facility[0], Boolean.TRUE};
                    String[] fields4 = {"facilityprivilegeid", "privilegeid"};
                    String where4 = "WHERE facilityid=:facilityid AND isactive=:isactive";
                    List<Object[]> facilityprivileges = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, fields4, where4, params4, paramsValues4);
                    if (facilityprivileges != null) {
                        facilityRow.put("facilityid", facility[0]);
                        facilityRow.put("facilityname", facility[1]);
                        systemfacilitypriv.add((Integer) facility[0]);

                        for (Object[] facilityprivilege : facilityprivileges) {
                            if (!systempriv.isEmpty() && systempriv.contains(BigInteger.valueOf((Long) facilityprivilege[1]))) {
                                componentscount = componentscount + 1;

                            }
                        }
                        facilityRow.put("componentscount", componentscount);
                        facilityFound.add(facilityRow);
                    }
                }
            }
            model.addAttribute("systemfacilitypriv", new ObjectMapper().writeValueAsString(facilityFound));
            model.addAttribute("facilityFound", facilityFound);

        } catch (Exception e) {
        }
        return "controlPanel/universalPanel/activitiesAndRights/facility/facilityHome";
    }

    @RequestMapping(value = "/unreleasefacility.htm", method = RequestMethod.GET)
    public String unreleasefacility(Model model, HttpServletRequest request) {
        List<Map> facilitysFound = new ArrayList<>();
        String[] params4 = {};
        Object[] paramsValues4 = {};
        String[] fields4 = {"facilityid", "facilityname"};
        String where4 = "";
        List<Object[]> facilitys = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields4, where4, params4, paramsValues4);
        if (facilitys != null) {
            Map<String, Object> facilityRow;
            for (Object[] facility : facilitys) {
                facilityRow = new HashMap<>();
                facilityRow.put("facilityid", facility[0]);
                facilityRow.put("facilityname", facility[1]);
                facilitysFound.add(facilityRow);
            }
        }
        model.addAttribute("facilitysFound", facilitysFound);
        return "controlPanel/universalPanel/activitiesAndRights/facility/forms/ReleaseFacilityrights";
    }

    @RequestMapping(value = "/releasecomponents.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView releasecomponents(HttpServletRequest request, Principal principal) {
        List<Systemmodule> systemroleslist = new ArrayList<>();
        long id = Long.parseLong(String.valueOf(Integer.parseInt(request.getParameter("facilityid"))));
        long id2 = Long.parseLong(request.getParameter("systemmoduleid"));
        String activity = "a";
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("facilityid", request.getParameter("facilityid"));
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND status=:status ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                for (Object[] systemmodule : systemmodules) {
                    Systemmodule systemmodule1 = new Systemmodule();
                    systemmodule1.setSystemmoduleid((Long) systemmodule[0]);
                    systemmodule1.setComponentname((String) systemmodule[1]);
                    systemroleslist.add(systemmodule1);
                }
            }
            List<CustomSystemmodule> customList = new ArrayList<CustomSystemmodule>();
            List<CustomSystemmodule> customChildList = new ArrayList<CustomSystemmodule>();
            model.put("activity", activity);

            if (activity.equals("a")) {
                List<Integer> assignedPrivs = new ArrayList<Integer>();
                String[] fieldPriv = {"privilegeid"};
                String[] paramPriv = {"Id", "active"};
                Object[] paramsValPriv = {id, true};
                List<Object[]> rolePrivArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, fieldPriv, "WHERE r.facilityid=:Id AND isactive=:active", paramPriv, paramsValPriv);
                if (rolePrivArrList != null && !rolePrivArrList.isEmpty()) {
                    for (Object obj : rolePrivArrList) {
                        assignedPrivs.add(((Long) obj).intValue());
                    }
                }

                Systemmodule selectedSysModule = null;
                List<Systemmodule> allSysModules = new ArrayList<Systemmodule>();
                String[] fieldSM = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] paramSM = {};
                Object[] paramsValSM = {};
                List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE r.status=TRUE ORDER BY r.componentname ASC ", paramSM, paramsValSM);
                if (smArrList != null && !smArrList.isEmpty()) {
                    for (Object[] obj : smArrList) {
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        if (sm.getSystemmoduleid() == id2) {
                            selectedSysModule = sm;
                        }
                        allSysModules.add(sm);
                    }
                }

                List<Systemmodule> allChildSysModules = new ArrayList<Systemmodule>();
                String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname"};
                String[] paramCSM = {};
                Object[] paramsValCSM = {};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
                if (csmArrList != null && !csmArrList.isEmpty()) {
                    for (Object[] ob : csmArrList) {
                        Systemmodule sm = new Systemmodule((Long) ob[0]);
                        Systemmodule ssm = new Systemmodule((Long) ob[1]);
                        sm.setParentid(ssm);
                        sm.setComponentname((String) ob[2]);
                        allChildSysModules.add(sm);
                    }
                }

                List<Systemmodule> allPrivSysModules = new ArrayList<Systemmodule>();
                String[] fieldSmPriv = {"systemmoduleid", "privilegeid"};
                String[] paramSmPriv = {};
                Object[] paramsValSmPriv = {};
                List<Object[]> sysArrListSmPriv = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSmPriv, "WHERE r.status=TRUE AND r.privilegeid IS NOT NULL", paramSmPriv, paramsValSmPriv);
                if (sysArrListSmPriv != null && !sysArrListSmPriv.isEmpty()) {
                    for (Object[] obj3 : sysArrListSmPriv) {
                        Systemmodule sm = new Systemmodule((Long) obj3[0]);
                        sm.setPrivilegeid((BigInteger) obj3[1]);
                        allPrivSysModules.add(sm);
                    }
                }

                String[] field = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity"};
                String[] param = {"ssmid"};
                Object[] paramsValue = {id2};
                List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
                if (sysArrList != null && !sysArrList.isEmpty()) {
                    for (Object[] obj : sysArrList) {
                        CustomSystemmodule ssm = new CustomSystemmodule();
                        Systemmodule sm = new Systemmodule((Long) obj[0]);
                        sm.setComponentname((String) obj[1]);
                        sm.setDescription((String) obj[2]);
                        sm.setStatus((Boolean) obj[3]);
                        sm.setDateadded((Date) obj[4]);
                        sm.setDateupdated((Date) obj[5]);
                        sm.setHasprivilege((Boolean) obj[6]);
                        sm.setActivity((String) obj[7]);

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<Long>();

                        if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        ssm.setSubmodules(subModules);

                        if (allPrivSysModules != null && !allPrivSysModules.isEmpty()) {
                            for (Systemmodule obj3 : allPrivSysModules) {
                                if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    sm.setPrivilegeid(obj3.getPrivilegeid());
                                }
                            }
                            if (!assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).intValue())) {
                                ssm.setAssigned(true);
                            } else {
                                ssm.setAssigned(false);
                            }
                        }
                        ssm.setSystemmodule(sm);
                        if (request.getSession().getAttribute("sessAssignt_AddSysModule") != null) {
                            List<Systemmodule> systemmoduleList2 = (List<Systemmodule>) request.getSession().getAttribute("sessAssignt_AddSysModule");
                            if (systemmoduleList2 != null && !systemmoduleList2.isEmpty()) {
                                for (Systemmodule smObj : systemmoduleList2) {
                                    if (smObj.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        ssm.setSelected(true);
                                    }
                                }
                            }
                        }
                        if (request.getSession().getAttribute("sessAssignt_RemoveSysModule") != null) {
                            List<Systemmodule> systemmoduleList2 = (List<Systemmodule>) request.getSession().getAttribute("sessAssignt_RemoveSysModule");
                            if (systemmoduleList2 != null && !systemmoduleList2.isEmpty()) {
                                for (Systemmodule smObj : systemmoduleList2) {
                                    if (smObj.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        ssm.setSelected(true);
                                    }
                                }
                            }
                        }

                        //Call function to load child elements
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList = loadParentActivity(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, id, assignedPrivs);

                        }
                        ssm.setCustomSystemmoduleList(customChildList);
                        customList.add(ssm);

                    }
                }
            }

            model.put("customList", customList);

            model.put("customLists", new ObjectMapper().writeValueAsString(customList));
            if (customList != null && !customList.isEmpty()) {
                model.put("size", customList.size());
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/activitiesAndRights/facility/forms/ReleaseTree", "model", model);
    }

    @RequestMapping(value = "/savereleasedfacilityprivileges.htm")
    public @ResponseBody
    String savereleasedfacilityprivileges(HttpServletRequest request, Model model) {
        String results = "";
        try {
            if (request.getParameter("privilegs") != null) {
                final List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("privilegs"), List.class);
                for (String item1 : item) {
                    Facilityprivilege facilityprivilege = new Facilityprivilege();
                    facilityprivilege.setAddedby((Long) request.getSession().getAttribute("person_id"));
                    facilityprivilege.setDateadded(new Date());
                    facilityprivilege.setFacilityid(Integer.parseInt(request.getParameter("facility")));
                    facilityprivilege.setPrivilegeid(Long.parseLong(item1));
                    facilityprivilege.setIsactive(Boolean.TRUE);
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityprivilege);
                }
                final int facilityid = Integer.parseInt(request.getParameter("facility"));
                final Long person_id = (Long) request.getSession().getAttribute("person_id");
                Runnable myRunnable = new Runnable() {
                    @Override
                    public void run() {
                        for (String priv : item) {
                            String[] params2 = {"privilegeid"};
                            Object[] paramsValues2 = {BigInteger.valueOf(Long.valueOf(priv))};
                            String[] fields2 = {"parentid.systemmoduleid", "status"};
                            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields2, "WHERE privilegeid=:privilegeid", params2, paramsValues2);
                            if (systemmodules != null) {
                                if (systemmodules.get(0)[0] != null) {
                                    getparentsprivileges(systemmodules.get(0)[0], facilityid, person_id);
                                }
                            }
                        }
                    }
                };
                Thread thread = new Thread(myRunnable);
                thread.start();
            }
        } catch (Exception e) {
            System.out.println("com.iics.web.ActivitiesAndAccessRightsController.savereleasedfacilityprivileges()" + e);
        }

        return results;

    }

    private void getparentsprivileges(Object systemmoduleid, int facilityid, Long person_id) {
        String[] params1 = {"systemmoduleid"};
        Object[] paramsValues1 = {systemmoduleid};
        String[] fields1 = {"parentid.systemmoduleid", "privilegeid"};
        List<Object[]> systemmodules1 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE systemmoduleid=:systemmoduleid", params1, paramsValues1);
        if (systemmodules1 != null) {
            if (systemmodules1.get(0)[1] != null) {
                String[] params2 = {"privilegeid", "facilityid", "isactive"};
                Object[] paramsValues2 = {systemmodules1.get(0)[1], facilityid, Boolean.TRUE};
                String[] fields2 = {"facilityprivilegeid", "privilegeid"};
                List<Object[]> privileges = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, fields2, "WHERE privilegeid=:privilegeid AND facilityid=:facilityid AND isactive=:isactive", params2, paramsValues2);
                if (privileges == null) {
                    Facilityprivilege facilityprivilege = new Facilityprivilege();
                    facilityprivilege.setAddedby(person_id);
                    facilityprivilege.setDateadded(new Date());
                    facilityprivilege.setFacilityid(facilityid);
                    facilityprivilege.setPrivilegeid(((BigInteger) systemmodules1.get(0)[1]).longValue());
                    facilityprivilege.setIsactive(Boolean.TRUE);
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityprivilege);
                }
            }
            if (systemmodules1.get(0)[0] != null) {
                getparentsprivileges(systemmodules1.get(0)[0], facilityid, person_id);
            }
        }
    }

    @RequestMapping(value = "/viewReleaseFacilityComponent.htm", method = RequestMethod.GET)
    public String viewReleaseFacilityComponent(Model model, HttpServletRequest request) {
        List<Map> systemsFound = new ArrayList<>();
        Set<BigInteger> systempriv = new HashSet<>();
        String[] paramsp = {"status"};
        Object[] paramsValuesp = {Boolean.TRUE};
        String[] fieldsp = {"systemmoduleid", "componentname", "privilegeid"};
        String wherep = "WHERE r.parentid.systemmoduleid IS NULL AND status=:status";
        List<Object[]> parents = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldsp, wherep, paramsp, paramsValuesp);
        if (parents != null) {
            for (Object[] parent : parents) {
                if (parent[2] != null) {
                    systempriv.add((BigInteger) parent[2]);
                }
            }
        }
        String[] params4 = {"facilityid", "isactive"};
        Object[] paramsValues4 = {Integer.parseInt(request.getParameter("facilityid")), Boolean.TRUE};
        String[] fields4 = {"facilityprivilegeid", "privilegeid"};
        String where4 = "WHERE facilityid=:facilityid AND isactive=:isactive";
        List<Object[]> facilityprivileges = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, fields4, where4, params4, paramsValues4);
        if (facilityprivileges != null) {
            Map<String, Object> systemRow;
            for (Object[] facilityprivilege : facilityprivileges) {
                systemRow = new HashMap<>();
                if (!systempriv.isEmpty() && systempriv.contains(BigInteger.valueOf((Long) facilityprivilege[1]))) {

                    String[] params = {"status", "privilegeid"};
                    Object[] paramsValues = {Boolean.TRUE, BigInteger.valueOf((Long) facilityprivilege[1])};
                    String[] fields = {"systemmoduleid", "componentname", "privilegeid"};
                    String where = "WHERE r.parentid.systemmoduleid IS NULL AND status=:status AND privilegeid=:privilegeid";
                    List<Object[]> privcomp = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
                    if (privcomp != null) {
                        systemRow.put("systemmoduleid", privcomp.get(0)[0]);
                        systemRow.put("componentname", privcomp.get(0)[1]);
                        systemRow.put("privilegeid", privcomp.get(0)[2]);
                        systemsFound.add(systemRow);
                    }
                }
            }
        }
        model.addAttribute("systemsFound", systemsFound);
        model.addAttribute("facilityid", request.getParameter("facilityid"));
        return "controlPanel/universalPanel/activitiesAndRights/facility/views/components";
    }

    @RequestMapping(value = "/ViewcomponentsActivityReleasedfacility.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public final String ViewcomponentsActivityReleasedfacility(HttpServletRequest request, Principal principal, Model model) {
        String results_view = "";
        List<Map> customChildList = new ArrayList<>();

        List<Map> Assigned = new ArrayList<>();
        long id = Long.parseLong(String.valueOf(Integer.parseInt(request.getParameter("facilityid"))));
        long id2 = Long.parseLong(request.getParameter("systemmoduleid"));
        String activity = "a";
        try {
            model.addAttribute("facilityid", request.getParameter("facilityid"));

            model.addAttribute("activity", activity);

            if (activity.equals("a")) {
                List<Long> assignedPrivs = new ArrayList<>();
                String[] fieldPriv = {"privilegeid"};
                String[] paramPriv = {"Id", "active"};
                Object[] paramsValPriv = {id, true};
                List<Object[]> rolePrivArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, fieldPriv, "WHERE r.facilityid=:Id AND isactive=:active", paramPriv, paramsValPriv);
                if (rolePrivArrList != null && !rolePrivArrList.isEmpty()) {
                    for (Object obj : rolePrivArrList) {
                        assignedPrivs.add(((Long) obj));
                    }
                }

                List<Systemmodule> allChildSysModules = new ArrayList<>();
                String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "activity", "hasprivilege", "privilegeid"};
                String[] paramCSM = {};
                Object[] paramsValCSM = {};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
                if (csmArrList != null && !csmArrList.isEmpty()) {
                    for (Object[] ob : csmArrList) {
                        Systemmodule sm = new Systemmodule((Long) ob[0]);
                        Systemmodule ssm = new Systemmodule((Long) ob[1]);
                        sm.setParentid(ssm);
                        sm.setComponentname((String) ob[2]);
                        sm.setActivity((String) ob[3]);
                        sm.setHasprivilege((Boolean) ob[4]);
                        sm.setPrivilegeid((BigInteger) ob[5]);

                        allChildSysModules.add(sm);
                    }
                }

                String[] fieldSM = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity", "privilegeid"};
                String[] paramSM = {"systemmoduleid"};
                Object[] paramsValSM = {id2};
                List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE systemmoduleid=:systemmoduleid", paramSM, paramsValSM);
                if (smArrList != null && !smArrList.isEmpty()) {
                    Map<String, Object> systemRow;
                    for (Object[] obj : smArrList) {
                        systemRow = new HashMap<>();
                        systemRow.put("componentname", obj[1]);
                        systemRow.put("systemmoduleid", obj[0]);
                        systemRow.put("description", obj[2]);
                        systemRow.put("status", obj[3]);
                        systemRow.put("dateadded", obj[4]);
                        systemRow.put("dateupdated", obj[5]);
                        systemRow.put("hasprivilege", obj[6]);
                        systemRow.put("activity", obj[7]);
                        systemRow.put("privilegeid", obj[8]);

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<>();

                        if (!allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == ((Long) obj[0]).intValue()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        systemRow.put("subModules", subModules);

                        if (!assignedPrivs.isEmpty() && assignedPrivs.contains(((BigInteger) obj[8]).longValue())) {
                            systemRow.put("assigned", true);
                        } else {
                            systemRow.put("assigned", false);
                        }
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList = childComponents(allChildSysModules, subModuleId, assignedPrivs);
                        }
                        systemRow.put("customSystemmoduleList", customChildList);
                        Assigned.add(systemRow);
                    }
                }

            }

            model.addAttribute("customList", Assigned);

            if (!Assigned.isEmpty()) {
                model.addAttribute("size", Assigned.size());
            }
        } catch (Exception ex) {
            System.out.println("Error Occured: =========================================");
            ex.printStackTrace();
        }

        if ("a".equals(request.getParameter("act"))) {
            results_view = "controlPanel/universalPanel/activitiesAndRights/facility/forms/AssignedTree";
        } else {
            results_view = "controlPanel/universalPanel/activitiesAndRights/facility/forms/UnassignedTree";
        }
        return results_view;
    }

    private List<Map> childComponents(List<Systemmodule> allChildSysModules, List<Long> ids, List<Long> assignedPrivs) {
        List<Map> Assigned = new ArrayList<>();
        for (Long id : ids) {
            List<Map> customChildList2 = new ArrayList<>();
            if (!allChildSysModules.isEmpty()) {
                Map<String, Object> systemRow;
                for (Systemmodule sm : allChildSysModules) {
                    systemRow = new HashMap<>();
                    if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                        systemRow.put("componentname", sm.getComponentname());
                        systemRow.put("systemmoduleid", sm.getSystemmoduleid());
                        systemRow.put("hasprivilege", sm.getHasprivilege());
                        systemRow.put("activity", sm.getActivity());
                        systemRow.put("privilegeid", sm.getPrivilegeid());

                        int subModules = 0;
                        List<Long> subModuleId = new ArrayList<>();
                        if (!allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == id.intValue()) {
                                    subModuleId.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        systemRow.put("subModules", subModules);
                        if (!assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).longValue())) {
                            systemRow.put("assigned", true);
                        } else {
                            systemRow.put("assigned", false);
                        }

                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = childComponents(allChildSysModules, subModuleId, assignedPrivs);
                        }
                        systemRow.put("customSystemmoduleList", customChildList2);

                        Assigned.add(systemRow);
                    }
                }
            }

        }
        return Assigned;
    }

    @RequestMapping(value = "/facilityunreleasedcomponents.htm")
    public @ResponseBody
    String facilityunreleasedcomponents(HttpServletRequest request, Model model
    ) {
        String results = "";
        List<Map> systemsFound = new ArrayList<>();
        try {
            Set<Long> facilityprivs = new HashSet<>();
            String[] paramsf = {"facilityid", "isactive"};
            Object[] paramsValuesf = {Integer.parseInt(request.getParameter("facilityid")), Boolean.TRUE};
            String[] fieldsf = {"privilegeid"};
            List<Long> facilitysprivs = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fieldsf, "WHERE facilityid=:facilityid AND isactive=:isactive", paramsf, paramsValuesf);
            if (facilitysprivs != null) {
                for (Long facilitysspriv : facilitysprivs) {
                    facilityprivs.add(facilitysspriv);
                }
            }
            String[] params = {"status"};
            Object[] paramsValues = {Boolean.TRUE};
            String[] fields = {"systemmoduleid", "componentname", "privilegeid"};
            String where = "WHERE r.parentid.systemmoduleid IS NULL AND status=:status";
            List<Object[]> privcomp = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, where, params, paramsValues);
            if (privcomp != null) {
                Map<String, Object> systemmodulesRow;
                for (Object[] priv : privcomp) {
                    systemmodulesRow = new HashMap<>();
                    if (facilityprivs.isEmpty() || !facilityprivs.contains(((BigInteger) priv[2]).longValue())) {
                        systemmodulesRow.put("systemmoduleid", priv[0]);
                        systemmodulesRow.put("privilegeid", priv[2]);
                        systemmodulesRow.put("componentname", priv[1]);
                        systemsFound.add(systemmodulesRow);
                    }
                }
            }
            results = new ObjectMapper().writeValueAsString(systemsFound);
        } catch (Exception e) {

        }

        return results;
    }

    @RequestMapping(value = "/addmorereleasedfacilitycomponents.htm", method = RequestMethod.GET)
    public String addmorereleasedfacilitycomponents(Model model, HttpServletRequest request) {
        List<Map> customChildList = new ArrayList<>();
        Set<Long> facilityprivs = new HashSet<>();
        String[] params = {"facilityid", "isactive"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        String where = "WHERE facilityid=:facilityid AND isactive=:isactive";
        List<Long> privcomp = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields, where, params, paramsValues);
        if (privcomp != null) {
            for (Long privilegeid : privcomp) {
                facilityprivs.add(privilegeid);
            }
        }
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "activity", "hasprivilege", "privilegeid"};
        String[] paramCSM = {};
        Object[] paramsValCSM = {};
        List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NULL", paramCSM, paramsValCSM);
        if (csmArrList != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] csmArr : csmArrList) {
                systemmodulesRow = new HashMap<>();
                if (facilityprivs.isEmpty() || !facilityprivs.contains(((BigInteger) csmArr[5]).longValue())) {
                    systemmodulesRow.put("systemmoduleid", csmArr[0]);
                    systemmodulesRow.put("componentname", csmArr[2]);
                    systemmodulesRow.put("privilegeid", csmArr[5]);
                    customChildList.add(systemmodulesRow);
                }
            }
        }
        model.addAttribute("customChildList", customChildList);
        model.addAttribute("facilityid", request.getParameter("facilityid"));
        return "controlPanel/universalPanel/activitiesAndRights/facility/forms/addMoreComponents";
    }

    @RequestMapping(value = "/componentsubcomponents.htm", method = RequestMethod.GET)
    public String componentsubcomponents(Model model, HttpServletRequest request) {
        List<Map> customChildList = new ArrayList<>();
        List<Map> customList = new ArrayList<>();

        List<Systemmodule> allChildSysModules = new ArrayList<>();
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "activity", "hasprivilege", "privilegeid"};
        String[] paramCSM = {};
        Object[] paramsValCSM = {};
        List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
        if (csmArrList != null && !csmArrList.isEmpty()) {
            for (Object[] ob : csmArrList) {
                Systemmodule sm = new Systemmodule((Long) ob[0]);
                Systemmodule ssm = new Systemmodule((Long) ob[1]);
                sm.setParentid(ssm);
                sm.setComponentname((String) ob[2]);
                sm.setActivity((String) ob[3]);
                sm.setHasprivilege((Boolean) ob[4]);
                sm.setPrivilegeid((BigInteger) ob[5]);
                allChildSysModules.add(sm);
            }
        }
        String[] field = {"systemmoduleid", "componentname", "hasprivilege", "activity", "privilegeid"};
        String[] param = {"ssmid"};
        Object[] paramsValue = {Long.parseLong(request.getParameter("systemmoduleid"))};
        List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
        if (sysArrList != null && !sysArrList.isEmpty()) {
            Map<String, Object> systemmodulesRow;
            for (Object[] obj : sysArrList) {
                systemmodulesRow = new HashMap<>();
                systemmodulesRow.put("systemmoduleid", obj[0]);
                systemmodulesRow.put("componentname", obj[1]);
                systemmodulesRow.put("hasprivilege", obj[2]);
                systemmodulesRow.put("activity", obj[3]);
                systemmodulesRow.put("privilegeid", obj[4]);

                int subModules = 0;
                List<Long> subModuleId = new ArrayList<>();

                if (!allChildSysModules.isEmpty()) {
                    for (Systemmodule ob : allChildSysModules) {
                        if (ob.getParentid().getSystemmoduleid().intValue() == ((Long) obj[0]).intValue()) {
                            subModuleId.add(ob.getSystemmoduleid());
                            subModules += 1;
                        }
                    }
                }
                systemmodulesRow.put("submodules", subModules);

                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = loadAddParentActivity(allChildSysModules, subModuleId);
                }
                systemmodulesRow.put("customSystemmoduleList", customChildList);
                customList.add(systemmodulesRow);
            }

        }
        model.addAttribute("customList", customList);
        return "controlPanel/universalPanel/activitiesAndRights/facility/forms/component";
    }

    private List<Map> loadAddParentActivity(List<Systemmodule> allChildSysModules, List<Long> ids) {
        List<Map> customList2 = new ArrayList<>();
        for (Long id : ids) {
            List<Map> customChildList2 = new ArrayList<>();
            if (!allChildSysModules.isEmpty()) {
                Map<String, Object> systemmodulesRow;
                for (Systemmodule sm : allChildSysModules) {
                    systemmodulesRow = new HashMap<>();
                    if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                        systemmodulesRow.put("systemmoduleid", sm.getSystemmoduleid());
                        systemmodulesRow.put("componentname", sm.getComponentname());
                        systemmodulesRow.put("hasprivilege", sm.getHasprivilege());
                        systemmodulesRow.put("activity", sm.getActivity());
                        systemmodulesRow.put("privilegeid", sm.getPrivilegeid());

                        int subModules = 0;
                        List<Long> subModuleId2 = new ArrayList<>();

                        if (!allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == (sm.getSystemmoduleid()).intValue()) {
                                    subModuleId2.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        systemmodulesRow.put("submodules", subModules);
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = loadAddParentActivity(allChildSysModules, subModuleId2);
                        }
                        systemmodulesRow.put("customSystemmoduleList", customChildList2);
                        customList2.add(systemmodulesRow);
                    }
                }
            }
        }
        return customList2;
    }

    @RequestMapping(value = "/saverecalledfacilitycomponents.htm")
    public @ResponseBody
    String saverecalledfacilitycomponents(final HttpServletRequest request, Model model) {
        String results = "";
        try {
            final List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String priv : item) {
                String[] field1 = {"facilityprivilegeid"};
                String[] param1 = {"facilityid", "privilegeid"};
                Object[] paramsValue1 = {Integer.parseInt(request.getParameter("facilityid")), Long.parseLong(priv)};
                List<Long> sysArrList1 = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, field1, "WHERE facilityid=:facilityid AND privilegeid=:privilegeid", param1, paramsValue1);
                if (sysArrList1 != null) {
                    String[] columns = {"isactive", "lastupdatedby", "lastupdated"};
                    Object[] columnValues = {Boolean.FALSE, (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk = "facilityprivilegeid";
                    Object pkValue = sysArrList1.get(0);
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");

                }
            }
            final Long person_id = (Long) request.getSession().getAttribute("person_id");
            final Integer facilityid = Integer.parseInt(request.getParameter("facilityid"));
            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    Set<Long> facilityprivs = new HashSet<>();
                    Set<Long> facilityassignedprivs = new HashSet<>();

                    String[] field = {"privilegeid"};
                    String[] param = {"facilityid", "isactive"};
                    Object[] paramsValue = {Integer.parseInt(request.getParameter("facilityid")), Boolean.TRUE};
                    List<Long> sysArrList = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, field, "WHERE facilityid=:facilityid AND isactive=:isactive", param, paramsValue);
                    if (sysArrList != null) {
                        for (Long sysArr : sysArrList) {
                            facilityassignedprivs.add(sysArr);
                        }
                    }

                    for (String priv : item) {
                        facilityprivs.add(Long.parseLong(priv));
                        for (Long facilityprivscomp : getfacilityrecalledcomponents(facilityassignedprivs, Long.parseLong(priv), facilityid, person_id)) {
                            facilityprivs.add(facilityprivscomp);
                        }
                    }
                    if (!facilityprivs.isEmpty()) {
                        for (Long facilitypriv : facilityprivs) {
                            String[] field1 = {"facilityprivilegeid"};
                            String[] param1 = {"facilityid", "privilegeid"};
                            Object[] paramsValue1 = {facilityid, facilitypriv};
                            List<Long> sysArrList1 = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, field1, "WHERE facilityid=:facilityid AND privilegeid=:privilegeid", param1, paramsValue1);
                            if (sysArrList1 != null) {
                                String[] field2 = {"accessrightgroupprivilegeid", "active"};
                                String[] param2 = {"facilityprivilegeid"};
                                Object[] paramsValue2 = {sysArrList1};
                                List<Object[]> sysArrList2 = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, field2, "WHERE facilityprivilegeid=:facilityprivilegeid", param2, paramsValue2);
                                if (sysArrList2 != null) {
                                    for (Object[] sysArrLists2 : sysArrList2) {
                                        String[] columns = {"isrecalled", "updatedby", "dateupdated", "active"};
                                        Object[] columnValues = {(Boolean) sysArrLists2[1], person_id, new Date(), Boolean.FALSE};
                                        String pk = "accessrightgroupprivilegeid";
                                        Object pkValue = sysArrLists2[0];
                                        int result = genericClassService.updateRecordSQLSchemaStyle(Accessrightgroupprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");
                                        if (result != 0) {
                                            String[] fieldp = {"stafffacilityunitaccessrightprivilegeid", "active"};
                                            String[] paramp = {"accessrightgroupprivilegeid"};
                                            Object[] paramsValuep = {sysArrLists2[0]};
                                            List<Object[]> sysArrListp = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fieldp, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid", paramp, paramsValuep);
                                            if (sysArrListp != null) {
                                                for (Object[] sysArrListps : sysArrListp) {
                                                    String[] columns1 = {"isrecalled", "lastupdatedby", "lastupdated", "active"};
                                                    Object[] columnValues1 = {(Boolean) sysArrListps[1], person_id, new Date(), Boolean.FALSE};
                                                    String pk1 = "stafffacilityunitaccessrightprivilegeid";
                                                    Object pkValue1 = sysArrListps[0];
                                                    int result1 = genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunitaccessrightprivilege.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();
        } catch (Exception e) {

        }

        return results;
    }
    Set<Long> facilitysprivs = new HashSet<>();

    private Set<Long> getfacilityrecalledcomponents(Set<Long> facilityassignedprivs, Long priv, Integer facilityid, Long person_id) {

        String[] field = {"systemmoduleid", "parentid.systemmoduleid", "parentid.privilegeid"};
        String[] param = {"privilegeid"};
        Object[] paramsValue = {BigInteger.valueOf(priv)};
        List<Object[]> privileges = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.privilegeid=:privilegeid", param, paramsValue);
        if (privileges != null) {
            if (privileges.get(0)[1] != null) {
                String[] fieldCSM = {"systemmoduleid", "privilegeid", "componentname"};
                String[] paramCSM = {"parentid", "privilegeid"};
                Object[] paramsValCSM = {privileges.get(0)[1], BigInteger.valueOf(priv)};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.parentid.systemmoduleid=:parentid AND privilegeid !=:privilegeid", paramCSM, paramsValCSM);
                if (csmArrList != null) {
                    int count = 0;
                    for (Object[] csmArrLists : csmArrList) {
                        if (!facilityassignedprivs.isEmpty() && facilityassignedprivs.contains(((BigInteger) csmArrLists[1]).longValue())) {
                            count = count + 1;
                        }
                    }
                    if (count == 0) {
                        String[] field1 = {"facilityprivilegeid"};
                        String[] param1 = {"facilityid", "privilegeid"};
                        Object[] paramsValue1 = {facilityid, ((BigInteger) privileges.get(0)[2]).longValue()};
                        List<Long> sysArrList1 = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, field1, "WHERE facilityid=:facilityid AND privilegeid=:privilegeid", param1, paramsValue1);
                        if (sysArrList1 != null) {
                            String[] columns = {"isactive", "lastupdatedby", "lastupdated"};
                            Object[] columnValues = {Boolean.FALSE, person_id, new Date()};
                            String pk = "facilityprivilegeid";
                            Object pkValue = sysArrList1.get(0);
                            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");
                            if (result != 0) {
                                facilitysprivs.add(((BigInteger) privileges.get(0)[2]).longValue());

                                Set<Long> facilityassignedprivs2 = new HashSet<>();
                                String[] field2 = {"privilegeid"};
                                String[] param2 = {"facilityid", "isactive"};
                                Object[] paramsValue2 = {facilityid, Boolean.TRUE};
                                List<Long> sysArrList = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, field2, "WHERE facilityid=:facilityid AND isactive=:isactive", param2, paramsValue2);
                                if (sysArrList != null) {
                                    for (Long sysArr : sysArrList) {
                                        facilityassignedprivs2.add(sysArr);
                                    }
                                }
                                getfacilityrecalledcomponents(facilityassignedprivs2, ((BigInteger) privileges.get(0)[2]).longValue(), facilityid, person_id);
                            }
                        }
                    }
                }

            }
        }
        return facilitysprivs;
    }

    @RequestMapping(value = "/viewrecalledfacilityscomponents.htm")
    public @ResponseBody
    String viewrecalledfacilityscomponents(HttpServletRequest request, Model model) {
        String results = "";
        Set<Long> facilityunassignedprivs = new HashSet<>();
        String[] field2 = {"privilegeid"};
        String[] param2 = {"facilityid", "isactive"};
        Object[] paramsValue2 = {Integer.parseInt(request.getParameter("facilityid")), Boolean.FALSE};
        List<Long> sysArrList = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, field2, "WHERE facilityid=:facilityid AND isactive=:isactive", param2, paramsValue2);
        if (sysArrList != null) {
            for (Long sysArr : sysArrList) {
                facilityunassignedprivs.add(sysArr);
            }
        }
        List<Systemmodule> allChildSysModules = new ArrayList<>();
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "activity", "hasprivilege", "privilegeid"};
        String[] paramCSM = {};
        Object[] paramsValCSM = {};
        List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
        if (csmArrList != null && !csmArrList.isEmpty()) {
            for (Object[] ob : csmArrList) {
                Systemmodule sm = new Systemmodule((Long) ob[0]);
                Systemmodule ssm = new Systemmodule((Long) ob[1]);
                sm.setParentid(ssm);
                sm.setComponentname((String) ob[2]);
                sm.setActivity((String) ob[3]);
                sm.setHasprivilege((Boolean) ob[4]);
                sm.setPrivilegeid((BigInteger) ob[5]);
                allChildSysModules.add(sm);
            }
        }
        Set<Long> facilityunassignprivcomp = new HashSet<>();

        String[] fieldSM = {"systemmoduleid", "componentname", "hasprivilege", "activity", "privilegeid"};
        String[] paramSM = {};
        Object[] paramsValSM = {};
        List<Object[]> smArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldSM, "WHERE r.status=TRUE  AND r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC ", paramSM, paramsValSM);
        if (smArrList != null && !smArrList.isEmpty()) {
            for (Object[] obj : smArrList) {
                Set<Long> facilityunassignprivs = new HashSet<>();
                if (!facilityunassignedprivs.isEmpty() && facilityunassignedprivs.contains(((BigInteger) obj[4]).longValue())) {
                    facilityunassignprivs.add(((BigInteger) obj[4]).longValue());
                }
                int subModules = 0;
                List<Long> subModuleId = new ArrayList<>();
                if (!allChildSysModules.isEmpty()) {
                    for (Systemmodule allChildSysModule : allChildSysModules) {
                        if (allChildSysModule.getParentid().getSystemmoduleid().intValue() == ((Long) obj[0]).intValue()) {
                            subModuleId.add(allChildSysModule.getSystemmoduleid());
                            subModules = subModules + 1;
                        }
                    }
                }
                if (subModules > 0) {
                    if (!getrecalledfacilitysactivities(subModuleId, allChildSysModules, facilityunassignedprivs).isEmpty()) {
                        facilityunassignprivs.add(Long.valueOf(String.valueOf(0)));
                    }
                }

                if (!facilityunassignprivs.isEmpty()) {
                    facilityunassignprivcomp.add((Long) obj[0]);
                }
            }
        }
        List<Map> responses = new ArrayList<>();
        Map<String, Object> responseRow = new HashMap<>();
        responseRow.put("facilityid", request.getParameter("facilityid"));
        responseRow.put("facilityunassignprivcomp", facilityunassignprivcomp.size());
        responses.add(responseRow);

        try {
            results = new ObjectMapper().writeValueAsString(responses);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ActivitiesAndAccessRightsController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    private Set<Long> getrecalledfacilitysactivities(List<Long> subModuleId, List<Systemmodule> allChildSysModules, Set<Long> facilityunassignedprivs) {
        Set<Long> facilityunassignprivs = new HashSet<>();
        for (Long subModule : subModuleId) {
            Set<Long> facilityunasprivs = new HashSet<>();
            for (Systemmodule allChildSysModule : allChildSysModules) {
                if (allChildSysModule.getSystemmoduleid().intValue() == subModule.intValue()) {
                    if (!facilityunassignedprivs.isEmpty() && facilityunassignedprivs.contains(allChildSysModule.getPrivilegeid().longValue())) {
                        facilityunasprivs.add(allChildSysModule.getSystemmoduleid());
                    }
                    int subModules = 0;
                    List<Long> subModuleId2 = new ArrayList<>();

                    if (!allChildSysModules.isEmpty()) {
                        for (Systemmodule ob : allChildSysModules) {
                            if (ob.getParentid().getSystemmoduleid().intValue() == (allChildSysModule.getSystemmoduleid()).intValue()) {
                                subModuleId2.add(ob.getSystemmoduleid());
                                subModules += 1;
                            }
                        }
                    }
                    if (subModules > 0) {
                        facilityunasprivs = getrecalledfacilitysactivities(subModuleId2, allChildSysModules, facilityunassignedprivs);
                    }
                    if (!facilityunasprivs.isEmpty()) {
                        for (Long facilityun : facilityunasprivs) {
                            facilityunassignprivs.add(facilityun);
                        }
                    }
                }
            }

        }
        return facilityunassignprivs;
    }

    @RequestMapping(value = "/saveunassignedgroupaccessrightsfacilityassign.htm")
    public @ResponseBody
    String saveunassignedgroupaccessrightsfacilityassign(HttpServletRequest request, Model model) {
        String results = "";
        try {
            final List<String> privileges = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String priv : privileges) {
                String[] param2 = {"facilityid", "privilegeid"};
                Object[] paramsValue2 = {Integer.parseInt(request.getParameter("facilityid")), Long.parseLong(priv)};
                String[] field2 = {"facilityprivilegeid", "isactive"};
                List<Object[]> sysArrLists = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, field2, "WHERE facilityid=:facilityid AND privilegeid=:privilegeid", param2, paramsValue2);
                if (sysArrLists == null) {
                    Facilityprivilege facilityprivilege = new Facilityprivilege();
                    facilityprivilege.setAddedby((Long) request.getSession().getAttribute("person_id"));
                    facilityprivilege.setDateadded(new Date());
                    facilityprivilege.setFacilityid(Integer.parseInt(request.getParameter("facilityid")));
                    facilityprivilege.setPrivilegeid(Long.parseLong(priv));
                    facilityprivilege.setIsactive(Boolean.TRUE);
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityprivilege);

                } else if ((Boolean) sysArrLists.get(0)[1] == false) {
                    //back truck
                }
            }

            final int facilityid = Integer.parseInt(request.getParameter("facilityid"));
            final Long person_id = (Long) request.getSession().getAttribute("person_id");
            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    for (String priv : privileges) {
                        String[] params2 = {"privilegeid"};
                        Object[] paramsValues2 = {BigInteger.valueOf(Long.valueOf(priv))};
                        String[] fields2 = {"parentid.systemmoduleid", "status"};
                        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields2, "WHERE privilegeid=:privilegeid", params2, paramsValues2);
                        if (systemmodules != null) {
                            if (systemmodules.get(0)[0] != null) {
                                parentReleasedFacilityComponent(systemmodules.get(0)[0], facilityid, person_id);
                            }
                        }
                    }
                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();

        } catch (Exception e) {
            System.out.println("com.iics.web.ActivitiesAndAccessRightsController.saveunassignedgroupaccessrightsfacilityassign()"+e);
        }
        return results;
    }

    private void parentReleasedFacilityComponent(Object systemmoduleid, int facilityid, Long person_id) {
        String[] params1 = {"systemmoduleid"};
        Object[] paramsValues1 = {systemmoduleid};
        String[] fields1 = {"parentid.systemmoduleid", "privilegeid"};
        List<Object[]> systemmodules1 = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE systemmoduleid=:systemmoduleid", params1, paramsValues1);
        if (systemmodules1 != null) {
            if (systemmodules1.get(0)[1] != null) {

                String[] params2 = {"privilegeid", "facilityid"};
                Object[] paramsValues2 = {systemmodules1.get(0)[1], facilityid};
                String[] fields2 = {"facilityprivilegeid", "isactive"};
                List<Object[]> privileges = (List<Object[]>) genericClassService.fetchRecord(Facilityprivilege.class, fields2, "WHERE privilegeid=:privilegeid AND facilityid=:facilityid", params2, paramsValues2);
                if (privileges == null) {
                    
                    Facilityprivilege facilityprivilege = new Facilityprivilege();
                    facilityprivilege.setAddedby(person_id);
                    facilityprivilege.setDateadded(new Date());
                    facilityprivilege.setFacilityid(facilityid);
                    facilityprivilege.setPrivilegeid(((BigInteger) systemmodules1.get(0)[1]).longValue());
                    facilityprivilege.setIsactive(Boolean.TRUE);
                    Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityprivilege);
                    
                } else if ((Boolean) privileges.get(0)[1] == false) {

                    //back truck
                }
            }
            if (systemmodules1.get(0)[0] != null) {
                getparentsprivileges(systemmodules1.get(0)[0], facilityid, person_id);
            }
        }
    }
}
