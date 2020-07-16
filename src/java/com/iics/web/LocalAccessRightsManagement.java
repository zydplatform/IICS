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
import com.iics.controlpanel.Staffassignedrights;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.controlpanel.Stafffacilityunitaccessrightprivilege;
import com.iics.controlpanel.Staffunits;
import com.iics.controlpanel.Systemmodule;
import com.iics.domain.Facilityunit;
import com.iics.domain.Searchstaff;
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import com.iics.utils.CustomSystemmodule;
import java.io.IOException;
import java.math.BigInteger;
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

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/localaccessrightsmanagement")
public class LocalAccessRightsManagement {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/localaccessrightsmanagementhome.htm", method = RequestMethod.GET)
    public String localaccessrightsmanagementhome(Model model, HttpServletRequest request) {
        List<Map> accessRightsGroupList = new ArrayList<>();

        String[] params = {"facilityid"};
        Object[] paramsValues = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
        String[] fields = {"accessrightsgroupid", "accessrightgroupname", "description", "active"};
        List<Object[]> accessrightsgroups = (List<Object[]>) genericClassService.fetchRecord(Accessrightsgroup.class, fields, "WHERE facilityid=:facilityid", params, paramsValues);
        if (accessrightsgroups != null) {
            Map<String, Object> groupsRow;
            for (Object[] accessrightsgroup : accessrightsgroups) {
                groupsRow = new HashMap<>();
                groupsRow.put("accessrightsgroupid", accessrightsgroup[0]);
                groupsRow.put("accessrightgroupname", accessrightsgroup[1]);
                groupsRow.put("description", accessrightsgroup[2]);
                groupsRow.put("active", accessrightsgroup[3]);
                Set<Long> groupprivs = new HashSet<>();
                String[] params3 = {"accessrightsgroupid", "active"};
                Object[] paramsValues3 = {accessrightsgroup[0], Boolean.TRUE};
                String[] fields3 = {"privilegeid"};
                List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields3, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params3, paramsValues3);
                if (facilitygroupsprivs != null) {
                    for (Long facilitygroupspriv : facilitygroupsprivs) {
                        groupprivs.add(facilitygroupspriv);
                    }
                }
                int componentscount = 0;
                String[] params1 = {};
                Object[] paramsValues1 = {};
                String[] fields1 = {"systemmoduleid", "componentname", "privilegeid"};
                List<Object[]> systemmoduleprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params1, paramsValues1);
                if (systemmoduleprivs != null) {
                    for (Object[] systemmodulepriv : systemmoduleprivs) {
                        if (!groupprivs.isEmpty() && systemmodulepriv[2] != null && groupprivs.contains(((BigInteger) systemmodulepriv[2]).longValue())) {
                            componentscount = componentscount + 1;
                        }
                    }
                }
                groupsRow.put("componentscount", componentscount);
                accessRightsGroupList.add(groupsRow);
            }
        }
        model.addAttribute("accessRightsGroupList", accessRightsGroupList);
        return "controlPanel/localSettingsPanel/accessRights/accessRightsHome";
    }

    @RequestMapping(value = "/addGroupForm.htm", method = RequestMethod.GET)
    public String addGroupForm(Model model, HttpServletRequest request) {

        return "controlPanel/localSettingsPanel/accessRights/forms/addGroupForm";
    }

    @RequestMapping(value = "/saveaccessrightsgroup.htm")
    public @ResponseBody
    String saveaccessrightsgroup(HttpServletRequest request) {
        String results = "";
        Accessrightsgroup accessrightsgroup = new Accessrightsgroup();
        accessrightsgroup.setAccessrightgroupname(request.getParameter("groupname"));
        accessrightsgroup.setActive(Boolean.TRUE);
        accessrightsgroup.setAddedby((Long) request.getSession().getAttribute("person_id"));
        accessrightsgroup.setDescription(request.getParameter("groupdescription"));
        accessrightsgroup.setDateadded(new Date());
        accessrightsgroup.setFacilityid((Integer) request.getSession().getAttribute("sessionActiveLoginFacility"));
        Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightsgroup);
        if (save != null) {
            results = String.valueOf(accessrightsgroup.getAccessrightsgroupid());
        }
        return results;
    }

    @RequestMapping(value = "/updategroup.htm")
    public @ResponseBody
    String updategroup(HttpServletRequest request) {
        String results = "";
        String[] columns = {"accessrightgroupname", "description"};
        Object[] columnValues = {request.getParameter("name"), request.getParameter("description")};
        String pk = "accessrightsgroupid";
        Object pkValue = Integer.parseInt(request.getParameter("accessrightsgroupid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Accessrightsgroup.class, columns, columnValues, pk, pkValue, "controlpanel");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/deleteaccessrightgroup.htm")
    public @ResponseBody
    String deleteaccessrightgroup(HttpServletRequest request) {
        String results = "";
        String[] columns = {"accessrightsgroupid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("accessrightsgroupid"))};
        int result = genericClassService.deleteRecordByByColumns("controlpanel.accessrightsgroup", columns, columnValues);
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/components.htm", method = RequestMethod.GET)
    public String components(Model model, HttpServletRequest request) {
        try {
            List<Map> componentsList = new ArrayList<>();
            Set<Long> allaccesspriv = new HashSet<>();
            String[] params8 = {"facilityid", "isactive"};
            Object[] paramsValues8 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
            String[] fields8 = {"privilegeid"};
            String where8 = "WHERE facilityid=:facilityid AND isactive=:isactive";
            List<Long> facilityprivilges = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields8, where8, params8, paramsValues8);
            if (facilityprivilges != null) {
                for (Long facilityprivilge : facilityprivilges) {
                    allaccesspriv.add(facilityprivilge);
                }
            }
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"systemmoduleid", "componentname", "privilegeid"};
            List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params, paramsValues);
            if (systemmodules != null) {
                Map<String, Object> systemmodulesRow;
                for (Object[] systemmodule : systemmodules) {
                    systemmodulesRow = new HashMap<>();
                    if (!allaccesspriv.isEmpty() && systemmodule[2] != null && allaccesspriv.contains(((BigInteger) systemmodule[2]).longValue())) {
                        systemmodulesRow.put("systemmoduleid", systemmodule[0]);
                        systemmodulesRow.put("componentname", systemmodule[1]);
                        componentsList.add(systemmodulesRow);
                    }
                }
            }
            model.addAttribute("componentsList", componentsList);
            model.addAttribute("groupid", request.getParameter("groupid"));
            model.addAttribute("allaccesspriv", new ObjectMapper().writeValueAsString(allaccesspriv));
        } catch (Exception e) {

        }

        return "controlPanel/localSettingsPanel/accessRights/forms/components";
    }

    @RequestMapping(value = "/savegroupassignedaccessrights.htm")
    public @ResponseBody
    String savegroupassignedaccessrights(HttpServletRequest request) {
        String results = "";
        try {
            final List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            System.out.println("......................." + item);
            for (String priv : item) {
                String[] params1 = {"isactive", "privilegeid", "facilityid"};
                Object[] paramsValues1 = {true, Long.parseLong(priv), (Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
                String[] fields1 = {"facilityprivilegeid"};
                List<Long> facilityprivilegesids = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields1, "WHERE isactive=:isactive AND privilegeid=:privilegeid AND facilityid=:facilityid", params1, paramsValues1);
                if (facilityprivilegesids != null) {

                    String[] params2 = {"facilityprivilegeid", "accessrightsgroupid"};
                    Object[] paramsValues2 = {facilityprivilegesids.get(0), Integer.parseInt(request.getParameter("accessgrouprightsid"))};
                    String[] fields2 = {"accessrightgroupprivilegeid", "active"};
                    List<Object[]> facilityprivilegesids2 = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields2, "WHERE facilityprivilegeid=:facilityprivilegeid AND accessrightsgroupid=:accessrightsgroupid", params2, paramsValues2);
                    if (facilityprivilegesids2 == null) {

                        Accessrightgroupprivilege accessrightgroupprivilege = new Accessrightgroupprivilege();
                        accessrightgroupprivilege.setPrivilegeid(Long.parseLong(priv));
                        accessrightgroupprivilege.setAccessrightsgroupid(Integer.parseInt(request.getParameter("accessgrouprightsid")));
                        accessrightgroupprivilege.setActive(Boolean.TRUE);
                        accessrightgroupprivilege.setDateadded(new Date());
                        accessrightgroupprivilege.setFacilityprivilegeid(facilityprivilegesids.get(0));
                        accessrightgroupprivilege.setAddedby((Long) request.getSession().getAttribute("person_id"));
                        Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightgroupprivilege);
                    } else {
                        //back track
                    }
                }

            }
            final int accessrightsgroupid = Integer.parseInt(request.getParameter("accessgrouprightsid"));
            final int facilityid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
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
                                getparentprivileges(systemmodules.get(0)[0], accessrightsgroupid, facilityid, person_id);
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

    private void getparentprivileges(Object systemmoduleid, int accessrightsgroupid, int facilityid, Long person_id) {
        String[] params = {"status", "systemmoduleid"};
        Object[] paramsValues = {true, systemmoduleid};
        String[] fields = {"parentid.systemmoduleid", "privilegeid"};
        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields, "WHERE status=:status AND systemmoduleid=:systemmoduleid", params, paramsValues);
        if (systemmodules != null) {
            if (systemmodules.get(0)[1] != null) {
                String[] params1 = {"isactive", "privilegeid", "facilityid"};
                Object[] paramsValues1 = {true, systemmodules.get(0)[1], facilityid};
                String[] fields1 = {"facilityprivilegeid"};
                List<Long> facilityprivilegesids = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields1, "WHERE isactive=:isactive AND privilegeid=:privilegeid AND facilityid=:facilityid", params1, paramsValues1);
                if (facilityprivilegesids != null) {
                    String[] params2 = {"facilityprivilegeid", "accessrightsgroupid"};
                    Object[] paramsValues2 = {facilityprivilegesids.get(0), accessrightsgroupid};
                    String[] fields2 = {"accessrightgroupprivilegeid", "active"};
                    List<Object[]> facilityprivilegesids2 = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields2, "WHERE facilityprivilegeid=:facilityprivilegeid AND accessrightsgroupid=:accessrightsgroupid", params2, paramsValues2);
                    if (facilityprivilegesids2 == null) {

                        Accessrightgroupprivilege accessrightgroupprivilege = new Accessrightgroupprivilege();
                        accessrightgroupprivilege.setPrivilegeid(((BigInteger) systemmodules.get(0)[1]).longValue());
                        accessrightgroupprivilege.setAccessrightsgroupid(accessrightsgroupid);
                        accessrightgroupprivilege.setActive(Boolean.TRUE);
                        accessrightgroupprivilege.setDateadded(new Date());
                        accessrightgroupprivilege.setFacilityprivilegeid(facilityprivilegesids.get(0));
                        accessrightgroupprivilege.setAddedby(person_id);
                        Object save = genericClassService.saveOrUpdateRecordLoadObject(accessrightgroupprivilege);

                    } else {
                        //back track
                    }
                }
            }
            if (systemmodules.get(0)[0] != null) {
                getparentprivileges((Long) systemmodules.get(0)[0], accessrightsgroupid, facilityid, person_id);
            }
        }

    }

    @RequestMapping(value = "/useraccessrightsmanagement.htm", method = RequestMethod.GET)
    public String useraccessrightsmanagement(Model model, HttpServletRequest request) {
        List<Map> staffmemberslist = new ArrayList<>();
        try {
            String[] params = {"facilityid"};
            Object[] paramsValues = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
            String[] fields = {"staffid", "firstname", "othernames", "lastname", "personid"};
            List<Object[]> staffmembers = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, "WHERE facilityid=:facilityid", params, paramsValues);
            if (staffmembers != null) {
                Map<String, Object> staffRow;
                for (Object[] staffmember : staffmembers) {
                    staffRow = new HashMap<>();
                    String[] params1 = {"personid", "active"};
                    Object[] paramsValues1 = {staffmember[4], true};
                    String[] fields1 = {"systemuserid", "username"};
                    List<Object[]> staffusers = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields1, "WHERE r.personid.personid=:personid AND active=:active", params1, paramsValues1);
                    if (staffusers != null) {
                        Set<Long> staffgroupscount = new HashSet<>();
                        staffRow.put("firstname", staffmember[1]);
                        staffRow.put("othernames", staffmember[2]);
                        staffRow.put("lastname", staffmember[3]);
                        staffRow.put("staffid", staffmember[0]);

                        String[] paramsu = {"staffid", "active"};
                        Object[] paramsValuesu = {staffmember[0], true};
                        String[] fieldsu = {"stafffacilityunitid", "facilityunitname"};
                        List<Object[]> staffusersunits = (List<Object[]>) genericClassService.fetchRecord(Staffunits.class, fieldsu, "WHERE  staffid=:staffid AND active=:active", paramsu, paramsValuesu);
                        if (staffusersunits != null) {
                            for (Object[] staffuser : staffusersunits) {
                                String[] params2 = {"stafffacilityunitid", "stafffacilityunitaccessrightprivstatus", "accessrightgroupprivilegestatus", "accessrightgroupstatus"};
                                Object[] paramsValues2 = {staffuser[0], true, true, true};
                                String[] fields2 = {"accessrightsgroupid", "accessrightgroupname"};
                                List<Object[]> staffusersgroups = (List<Object[]>) genericClassService.fetchRecord(Staffassignedrights.class, fields2, "WHERE stafffacilityunitid=:stafffacilityunitid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus AND accessrightgroupprivilegestatus=:accessrightgroupprivilegestatus AND accessrightgroupstatus=:accessrightgroupstatus", params2, paramsValues2);
                                if (staffusersgroups != null) {
                                    for (Object[] staffusersgroup : staffusersgroups) {
                                        staffgroupscount.add(Long.valueOf(String.valueOf((Integer) staffusersgroup[0])));
                                    }
                                }
                            }
                            staffRow.put("staffunitscounts", staffusersunits.size());
                        } else {
                            staffRow.put("staffunitscounts", 0);
                        }
                        staffRow.put("staffgroups", new ObjectMapper().writeValueAsString(staffgroupscount));
                        staffRow.put("staffunitscount", staffgroupscount.size());
                        staffmemberslist.add(staffRow);
                    }
                }
            }
            model.addAttribute("staffmemberslist", staffmemberslist);
        } catch (Exception e) {

        }
        return "controlPanel/localSettingsPanel/accessRights/views/staffsTable";
    }

    @RequestMapping(value = "/useraccessrightsaddtomanagement.htm", method = RequestMethod.GET)
    public String useraccessrightsaddtomanagement(Model model, HttpServletRequest request) {
        List<Map> facilitygroupslist = new ArrayList<>();
        List<Map> stafffacilityunitslist = new ArrayList<>();
        try {
            Set<Integer> staffgroups = new HashSet<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("assignedgroups"), List.class);
            for (Integer grp : item) {
//                 staffgroups.add(grp);
            }

            String[] params = {"facilityid", "active"};
            Object[] paramsValues = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
            String[] fields = {"accessrightsgroupid", "accessrightgroupname"};
            List<Object[]> facilitygroups = (List<Object[]>) genericClassService.fetchRecord(Accessrightsgroup.class, fields, "WHERE facilityid=:facilityid AND active=:active", params, paramsValues);
            if (facilitygroups != null) {
                Map<String, Object> groupsRow;
                for (Object[] facilitygroup : facilitygroups) {
                    groupsRow = new HashMap<>();
                    if (staffgroups.isEmpty() || !staffgroups.contains((Integer) facilitygroup[0])) {
                        groupsRow.put("accessrightsgroupid", facilitygroup[0]);
                        groupsRow.put("accessrightgroupname", facilitygroup[1]);
                        facilitygroupslist.add(groupsRow);
                    }
                }
            }
            String[] params1 = {"staffid", "active"};
            Object[] paramsValues1 = {Long.parseLong(request.getParameter("staffid")), Boolean.TRUE};
            String[] fields1 = {"stafffacilityunitid", "facilityunitname"};
            List<Object[]> staffunits = (List<Object[]>) genericClassService.fetchRecord(Staffunits.class, fields1, "WHERE staffid=:staffid AND active=:active", params1, paramsValues1);
            if (staffunits != null) {
                Map<String, Object> unitsRow;
                for (Object[] staffunit : staffunits) {
                    unitsRow = new HashMap<>();
                    unitsRow.put("stafffacilityunitid", staffunit[0]);
                    unitsRow.put("facilityunitname", staffunit[1]);
                    stafffacilityunitslist.add(unitsRow);
                }
            }
            model.addAttribute("facilitygroupslist", facilitygroupslist);
            model.addAttribute("stafffacilityunitslist", stafffacilityunitslist);
        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.useraccessrightsaddtomanagement()" + e);
        }
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/forms/addStaffToGroup";
    }

    @RequestMapping(value = "/groupasssignedcomponentsubcomponents.htm", method = RequestMethod.GET)
    public String groupasssignedcomponentsubcomponents(Model model, HttpServletRequest request) {
        List<Map> customList = new ArrayList<>();
        List<Map> customChildList = new ArrayList<>();

        Set<Long> groupprivs = new HashSet<>();
        String[] params = {"accessrightsgroupid", "active"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("groupid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
        if (facilitygroupsprivs != null) {
            for (Long facilitygroupspriv : facilitygroupsprivs) {
                groupprivs.add(facilitygroupspriv);
            }
        }

        List<Systemmodule> allChildSysModules = new ArrayList<>();
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "privilegeid", "activity", "hasprivilege"};
        String[] paramCSM = {};
        Object[] paramsValCSM = {};
        List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
        if (csmArrList != null && !csmArrList.isEmpty()) {
            for (Object[] ob : csmArrList) {
                Systemmodule sm = new Systemmodule((Long) ob[0]);
                Systemmodule ssm = new Systemmodule((Long) ob[1]);
                sm.setParentid(ssm);
                sm.setComponentname((String) ob[2]);
                sm.setPrivilegeid((BigInteger) ob[3]);
                sm.setActivity((String) ob[4]);
                sm.setHasprivilege((Boolean) ob[5]);
                allChildSysModules.add(sm);
            }
        }

        String[] field = {"systemmoduleid", "componentname", "description", "status", "dateadded", "dateupdated", "hasprivilege", "activity", "privilegeid"};
        String[] param = {"ssmid"};
        Object[] paramsValue = {Long.parseLong(request.getParameter("componentid"))};
        List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
        if (!sysArrList.isEmpty()) {
            Map<String, Object> systemmodulesRow;
            for (Object[] obj : sysArrList) {
                systemmodulesRow = new HashMap<>();

                systemmodulesRow.put("systemmoduleid", obj[0]);
                systemmodulesRow.put("componentname", obj[1]);
                systemmodulesRow.put("hasprivilege", obj[6]);
                systemmodulesRow.put("activity", obj[7]);
                systemmodulesRow.put("privilegeid", obj[8]);

                if (!groupprivs.isEmpty() && groupprivs.contains(((BigInteger) obj[8]).longValue())) {
                    systemmodulesRow.put("assigned", true);
                } else {
                    systemmodulesRow.put("assigned", false);
                }
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
                systemmodulesRow.put("size", subModules);

                if (obj[8] != null) {
                    systemmodulesRow.put("privilegid", obj[8]);
                    String[] paramsp = {"accessrightsgroupid", "active", "privilegeid"};
                    Object[] paramsValuesp = {Integer.parseInt(request.getParameter("groupid")), Boolean.TRUE, obj[8]};
                    String[] fieldsp = {"accessrightgroupprivilegeid"};
                    List<Integer> facilitygroupprivs = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active AND privilegeid=:privilegeid", paramsp, paramsValuesp);
                    if (facilitygroupprivs != null) {
                        systemmodulesRow.put("accessrightgroupprivilegeid", facilitygroupprivs.get(0));
                    }

                }

                //Call function to load child elements
                if (subModules > 0) {
                    customChildList = getgroupassignedsubcomponents(allChildSysModules, subModuleId, groupprivs, Integer.parseInt(request.getParameter("groupid")));
                }
                systemmodulesRow.put("subComponents", customChildList);
                customList.add(systemmodulesRow);

            }
        }

        model.addAttribute("facilitygroupscomponentslist", customList);
        try {
            model.addAttribute("facilitygroupscomponentslists", new ObjectMapper().writeValueAsString(customList));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LocalAccessRightsManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/forms/groupAccessRightsTree";
    }

    private List<Map> getgroupassignedsubcomponents(List<Systemmodule> allChildSysModules, List<Long> subModuleId, Set<Long> groupprivs, Integer groupid) {
        List<Map> customList = new ArrayList<>();
        if (!subModuleId.isEmpty()) {
            Map<String, Object> systemmodulesRow;
            for (Long subComponents : subModuleId) {
                systemmodulesRow = new HashMap<>();
                List<Map> customChildList = new ArrayList<>();
                for (Systemmodule sm : allChildSysModules) {
                    if (subComponents.intValue() == sm.getSystemmoduleid().intValue()) {
                        systemmodulesRow.put("systemmoduleid", subComponents);
                        systemmodulesRow.put("componentname", sm.getComponentname());
                        systemmodulesRow.put("activity", sm.getActivity());
                        systemmodulesRow.put("hasprivilege", sm.getHasprivilege());

                        if (!groupprivs.isEmpty() && groupprivs.contains((sm.getPrivilegeid()).longValue())) {
                            systemmodulesRow.put("assigned", true);
                        } else {
                            systemmodulesRow.put("assigned", false);
                        }
                        systemmodulesRow.put("privilegid", sm.getPrivilegeid());
                        String[] paramsp = {"accessrightsgroupid", "active", "privilegeid"};
                        Object[] paramsValuesp = {groupid, Boolean.TRUE, sm.getPrivilegeid()};
                        String[] fieldsp = {"accessrightgroupprivilegeid"};
                        List<Integer> facilitygroupprivs = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active AND privilegeid=:privilegeid", paramsp, paramsValuesp);
                        if (facilitygroupprivs != null) {
                            systemmodulesRow.put("accessrightgroupprivilegeid", facilitygroupprivs.get(0));
                        }

                        int subModules = 0;
                        List<Long> subModuleId2 = new ArrayList<>();

                        if (!allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == subComponents.intValue()) {
                                    subModuleId2.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        systemmodulesRow.put("size", subModules);

                        if (subModules > 0) {
                            customChildList = getgroupassignedsubcomponents(allChildSysModules, subModuleId2, groupprivs, groupid);
                        }
                        systemmodulesRow.put("subComponents", customChildList);
                        customList.add(systemmodulesRow);
                    }

                }
            }
        }
        return customList;
    }

    @RequestMapping(value = "/savenewstaffassignedactivitiespriv.htm")
    public @ResponseBody
    String savenewstaffassignedactivitiespriv(HttpServletRequest request) {
        String results = "";
        try {
            final List<String> units = (ArrayList) new ObjectMapper().readValue(request.getParameter("stafffacilityunitid"), List.class);

            final List<String> privileges2 = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String unit : units) {
                for (String priv2 : privileges2) {

                    String[] params2 = {"accessrightgroupprivilegeid", "stafffacilityunitid"};
                    Object[] paramsValues2 = {Integer.parseInt(priv2), Long.parseLong(unit)};
                    String[] fields2 = {"stafffacilityunitaccessrightprivilegeid", "active"};
                    List<Object[]> groupsprivs = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fields2, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid AND stafffacilityunitid=:stafffacilityunitid", params2, paramsValues2);
                    if (groupsprivs == null) {
                        Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                        stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                        stafffacilityunitaccessrightprivilege.setAddedby((Long) request.getSession().getAttribute("person_id"));
                        stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                        stafffacilityunitaccessrightprivilege.setStafffacilityunitid(Long.valueOf(unit));
                        stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid(Integer.parseInt(priv2));
                        Object save = genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);

                    } else if ((Boolean) groupsprivs.get(0)[1] == false) {
                        // back truck
                    }

                }
            }
            final int groupid = Integer.parseInt(request.getParameter("groupid"));
            final Long person_id = (Long) request.getSession().getAttribute("person_id");
            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    for (String priv : privileges2) {
                        String[] params1 = {"accessrightgroupprivilegeid"};
                        Object[] paramsValues1 = {Integer.parseInt(priv)};
                        String[] fields1 = {"privilegeid", "accessrightsgroupid"};
                        List<Object[]> groupsprivs = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields1, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid", params1, paramsValues1);
                        if (groupsprivs != null) {
                            String[] paramsp = {"privilegeid"};
                            Object[] paramsValuesp = {groupsprivs.get(0)[0]};
                            String[] fieldsp = {"parentid.systemmoduleid", "status"};
                            List<Object[]> facilitygroupprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldsp, "WHERE privilegeid=:privilegeid", paramsp, paramsValuesp);
                            if (facilitygroupprivs != null) {
                                getparentsystemmodulesprivs(facilitygroupprivs.get(0)[0], groupid, units, person_id);
                            }
                        }
                    }
                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();

        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.savenewstaffassignedactivitiespriv()" + e);
        }
        return results;
    }

    private void getparentsystemmodulesprivs(Object systemmoduleid, int groupid, List<String> units, Long person_id) {
        String[] paramsp = {"systemmoduleid"};
        Object[] paramsValuesp = {BigInteger.valueOf((Long) systemmoduleid)};
        String[] fieldsp = {"parentid.systemmoduleid", "privilegeid"};
        List<Object[]> parentsystemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldsp, "WHERE systemmoduleid=:systemmoduleid", paramsp, paramsValuesp);
        if (parentsystemmodules != null) {
            if (parentsystemmodules.get(0)[1] != null) {
                String[] params1 = {"privilegeid", "accessrightsgroupid", "active"};
                Object[] paramsValues1 = {parentsystemmodules.get(0)[1], groupid, true};
                String[] fields1 = {"accessrightgroupprivilegeid", "facilityprivilegeid"};
                List<Object[]> groupsprivs = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields1, "WHERE privilegeid=:privilegeid AND accessrightsgroupid=:accessrightsgroupid AND active=:active", params1, paramsValues1);
                if (groupsprivs != null) {

                    for (String unit : units) {
                        String[] params2 = {"accessrightgroupprivilegeid", "stafffacilityunitid"};
                        Object[] paramsValues2 = {groupsprivs.get(0)[0], Long.parseLong(unit)};
                        String[] fields2 = {"stafffacilityunitaccessrightprivilegeid", "active"};
                        List<Object[]> groupsprivs2 = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fields2, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid AND stafffacilityunitid=:stafffacilityunitid", params2, paramsValues2);
                        if (groupsprivs2 == null) {
                            Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                            stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                            stafffacilityunitaccessrightprivilege.setAddedby(person_id);
                            stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                            stafffacilityunitaccessrightprivilege.setStafffacilityunitid(Long.valueOf(unit));
                            stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid((Integer) groupsprivs.get(0)[0]);
                            Object save = genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);
                        } else if ((Boolean) groupsprivs2.get(0)[1] == false) {
                            // back truck
                        }
                    }

                }
            }
            if (parentsystemmodules.get(0)[0] != null) {
                getparentsystemmodulesprivs(parentsystemmodules.get(0)[0], groupid, units, person_id);
            }
        }

    }

    @RequestMapping(value = "/viewassignedstaffgroups.htm", method = RequestMethod.GET)
    public String viewassignedstaffgroups(Model model, HttpServletRequest request) {
        List<Map> staffgroupslist = new ArrayList<>();
        try {

            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("assignedgroup"), List.class);
            Map<String, Object> staffgroupsRow;
            for (Integer grp : item) {
                staffgroupsRow = new HashMap<>();
                String[] paramsp = {"accessrightsgroupid"};
                Object[] paramsValuesp = {grp};
                String[] fieldsp = {"accessrightgroupname"};
                List<String> staffsgroups = (List<String>) genericClassService.fetchRecord(Accessrightsgroup.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid", paramsp, paramsValuesp);
                if (staffsgroups != null) {
                    staffgroupsRow.put("accessrightgroupname", staffsgroups.get(0));
                    staffgroupsRow.put("accessrightsgroupid", grp);
                    staffgroupsRow.put("getAssignedComponents", getAssignedComponents(grp, Long.parseLong(request.getParameter("staffid"))));
                    staffgroupslist.add(staffgroupsRow);
                }
            }
            model.addAttribute("staffgroupslist", staffgroupslist);
            model.addAttribute("staffid", request.getParameter("staffid"));
            model.addAttribute("assignedgroup", request.getParameter("assignedgroup"));

        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.viewassignedstaffgroups():" + e);
        }
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/views/staffGroups";
    }

    private List<Map> getAssignedComponents(Integer accessrightsgroupid, Long staffid) {
        List<Map> staffgroupslist = new ArrayList<>();
        Set<Long> staffprivileges = new HashSet<>();

        String[] paramsp = {"accessrightsgroupid", "stafffacilityunitaccessrightprivstatus", "staffid"};
        Object[] paramsValuesp = {accessrightsgroupid, Boolean.TRUE, staffid};
        String[] fieldsp = {"privilegeid"};
        List<Long> privilegeids = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus AND staffid=:staffid", paramsp, paramsValuesp);
        if (privilegeids != null) {
            for (Long privilegeid : privilegeids) {
                staffprivileges.add(privilegeid);
            }
        }
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"systemmoduleid", "componentname", "privilegeid"};
        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params1, paramsValues1);
        if (systemmodules != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] systemmodule : systemmodules) {
                systemmodulesRow = new HashMap<>();
                if (!staffprivileges.isEmpty() && staffprivileges.contains(((BigInteger) systemmodule[2]).longValue())) {
                    systemmodulesRow.put("systemmoduleid", systemmodule[0]);
                    systemmodulesRow.put("componentname", systemmodule[1]);
                    systemmodulesRow.put("privilegeid", systemmodule[2]);
                    staffgroupslist.add(systemmodulesRow);
                }

            }
        }
        return staffgroupslist;
    }

    @RequestMapping(value = "/viewStaffGrantedRights.htm", method = RequestMethod.GET)
    public String viewStaffGrantedRights(Model model, HttpServletRequest request) {
        List<Map> staffgroupslist = new ArrayList<>();
        try {
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("assignedgroups"), List.class);
            Map<String, Object> staffgroupsRow;
            for (Integer grp : item) {
                staffgroupsRow = new HashMap<>();
                String[] paramsp = {"accessrightsgroupid"};
                Object[] paramsValuesp = {grp};
                String[] fieldsp = {"accessrightgroupname"};
                List<String> staffsgroups = (List<String>) genericClassService.fetchRecord(Accessrightsgroup.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid", paramsp, paramsValuesp);
                if (staffsgroups != null) {
                    staffgroupsRow.put("accessrightgroupname", staffsgroups.get(0));
                    staffgroupsRow.put("accessrightsgroupid", grp);
                    staffgroupslist.add(staffgroupsRow);
                }
            }

        } catch (Exception e) {
        }
        model.addAttribute("staffgroupslist", staffgroupslist);
        model.addAttribute("staffid", request.getParameter("staffid"));
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/views/GrantedGroups";
    }

    @RequestMapping(value = "/staffgrantedscomponentsgrouptree.htm", method = RequestMethod.GET)
    public String staffgrantedscomponentsgrouptree(Model model, HttpServletRequest request) {
        Set<Long> staffprivileges = new HashSet<>();

        List<Map> customList = new ArrayList<>();
        List<Map> customChildList = new ArrayList<>();

        String[] paramsp = {"accessrightsgroupid", "stafffacilityunitid", "facilityid"};
        Object[] paramsValuesp = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Long.parseLong(request.getParameter("stafffacilityunit")), (Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
        String[] fieldsp = {"privilegeid"};
        List<Long> staffsprivs = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitid=:stafffacilityunitid AND facilityid=:facilityid AND stafffacilityunitaccessrightprivstatus=TRUE", paramsp, paramsValuesp);
        if (staffsprivs != null) {
            for (Long staffspriv : staffsprivs) {
                staffprivileges.add(staffspriv);
            }
        }

        List<Systemmodule> allChildSysModules = new ArrayList<>();
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "hasprivilege", "activity", "privilegeid"};
        String[] paramCSM = {};
        Object[] paramsValCSM = {};
        List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
        if (csmArrList != null && !csmArrList.isEmpty()) {
            for (Object[] ob : csmArrList) {
                Systemmodule sm = new Systemmodule((Long) ob[0]);
                Systemmodule ssm = new Systemmodule((Long) ob[1]);
                sm.setParentid(ssm);
                sm.setComponentname((String) ob[2]);
                sm.setHasprivilege((Boolean) ob[3]);
                sm.setActivity((String) ob[4]);
                sm.setPrivilegeid((BigInteger) ob[5]);
                allChildSysModules.add(sm);
            }
        }

        String[] field = {"systemmoduleid", "componentname", "hasprivilege", "activity", "privilegeid"};
        String[] param = {"ssmid"};
        Object[] paramsValue = {Long.parseLong(request.getParameter("systemmoduleid"))};
        List<Object[]> sysArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.status=TRUE AND r.systemmoduleid=:ssmid ORDER BY r.componentname ASC ", param, paramsValue);
        if (sysArrList != null) {
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
                if (!staffprivileges.isEmpty() && obj[4] != null && staffprivileges.contains(((BigInteger) obj[4]).longValue())) {
                    systemmodulesRow.put("assigned", true);
                } else {
                    systemmodulesRow.put("assigned", false);
                }
                systemmodulesRow.put("size", subModules);

                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = getStaffAssignedComponents(allChildSysModules, subModuleId, staffprivileges);

                }
                systemmodulesRow.put("systemSubcomponenets", customChildList);
                customList.add(systemmodulesRow);

            }
        }

        model.addAttribute("staffcomponentstreelist", customList);
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/views/grantedRights";
    }

    private List<Map> getStaffAssignedComponents(List<Systemmodule> allChildSysModules, List<Long> subModuleIds, Set<Long> staffprivileges) {
        List<Map> staffcomponentstreelist = new ArrayList<>();
        if (!subModuleIds.isEmpty()) {
            for (Long subModuleId : subModuleIds) {
                List<Map> customChildList2 = new ArrayList<>();
                Map<String, Object> systemmodulesRow;
                for (Systemmodule sm : allChildSysModules) {
                    systemmodulesRow = new HashMap<>();
                    if (subModuleId.intValue() == sm.getSystemmoduleid().intValue()) {

                        systemmodulesRow.put("systemmoduleid", sm.getSystemmoduleid());
                        systemmodulesRow.put("componentname", sm.getComponentname());
                        systemmodulesRow.put("hasprivilege", sm.getHasprivilege());
                        systemmodulesRow.put("activity", sm.getActivity());
                        systemmodulesRow.put("privilegeid", sm.getPrivilegeid());

                        int subModules = 0;
                        List<Long> subModuleId2 = new ArrayList<>();

                        if (!allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    subModuleId2.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        if (!staffprivileges.isEmpty() && sm.getPrivilegeid() != null && staffprivileges.contains(((BigInteger) sm.getPrivilegeid()).longValue())) {
                            systemmodulesRow.put("assigned", true);
                        } else {
                            systemmodulesRow.put("assigned", false);
                        }
                        systemmodulesRow.put("size", subModules);

                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = getStaffAssignedComponents(allChildSysModules, subModuleId2, staffprivileges);

                        }
                        systemmodulesRow.put("systemSubcomponenets", customChildList2);
                        staffcomponentstreelist.add(systemmodulesRow);
                    }
                }
            }
        }
        return staffcomponentstreelist;
    }

    @RequestMapping(value = "/getgroupcomponents.htm")
    public @ResponseBody
    String getgroupcomponents(Model model, HttpServletRequest request) {
        List<Map> groupnonents = new ArrayList<>();
        String results = "";
        try {
            Set<Long> groupprivs = new HashSet<>();
            if ("a".equals(request.getParameter("act"))) {
                String[] params = {"accessrightsgroupid", "active"};
                Object[] paramsValues = {Integer.parseInt(request.getParameter("groupid")), Boolean.TRUE};
                String[] fields = {"privilegeid"};
                List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
                if (facilitygroupsprivs != null) {
                    for (Long facilitygroupspriv : facilitygroupsprivs) {
                        groupprivs.add(facilitygroupspriv);
                    }
                }
            } else {
                String[] params = {"accessrightsgroupid", "stafffacilityunitid", "stafffacilityunitaccessrightprivstatus"};
                Object[] paramsValues = {Integer.parseInt(request.getParameter("groupid")), Long.parseLong(request.getParameter("stafffacilityunitid")), Boolean.TRUE};
                String[] fields = {"privilegeid"};
                List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitid=:stafffacilityunitid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", params, paramsValues);
                if (facilitygroupsprivs != null) {
                    for (Long facilitygroupspriv : facilitygroupsprivs) {
                        groupprivs.add(facilitygroupspriv);
                    }
                }
            }
            System.out.println(":::::::::::::::::::::::::" + groupprivs);
            String[] params1 = {};
            Object[] paramsValues1 = {};
            String[] fields1 = {"systemmoduleid", "componentname", "privilegeid"};
            List<Object[]> systemmoduleprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params1, paramsValues1);
            if (systemmoduleprivs != null) {
                Map<String, Object> systemmodulesRow;
                for (Object[] systemmodulepriv : systemmoduleprivs) {
                    systemmodulesRow = new HashMap<>();
                    if (!groupprivs.isEmpty() && systemmodulepriv[2] != null && groupprivs.contains(((BigInteger) systemmodulepriv[2]).longValue())) {
                        systemmodulesRow.put("privilegeid", systemmodulepriv[2]);
                        systemmodulesRow.put("systemmoduleid", systemmodulepriv[0]);
                        systemmodulesRow.put("componentname", systemmodulepriv[1]);
                        groupnonents.add(systemmodulesRow);
                    }
                }
            }

            results = new ObjectMapper().writeValueAsString(groupnonents);

        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.getgroupcomponents()" + e);
        }

        return results;
    }

    @RequestMapping(value = "/staffungrantedscomponentsgrouptree.htm", method = RequestMethod.GET)
    public String staffungrantedscomponentsgrouptree(Model model, HttpServletRequest request) {
        List<Map> customList = new ArrayList<>();
        List<Map> customChildList = new ArrayList<>();
        Set<Long> staffprivileges = new HashSet<>();
        Set<Long> groupprivileges = new HashSet<>();
        String[] paramsp = {"accessrightsgroupid", "stafffacilityunitid", "facilityid"};
        Object[] paramsValuesp = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Long.parseLong(request.getParameter("stafffacilityunit")), (Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
        String[] fieldsp = {"privilegeid"};
        List<Long> staffsprivs = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fieldsp, "WHERE accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitid=:stafffacilityunitid AND facilityid=:facilityid AND stafffacilityunitaccessrightprivstatus=TRUE", paramsp, paramsValuesp);
        if (staffsprivs != null) {
            for (Long staffspriv : staffsprivs) {
                staffprivileges.add(staffspriv);
            }
        }
        String[] params3 = {"accessrightsgroupid", "isrecalled"};
        Object[] paramsValues3 = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.FALSE};
        String[] fields3 = {"privilegeid"};
        List<Long> staffsprivs3 = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields3, "WHERE accessrightsgroupid=:accessrightsgroupid AND (isrecalled IS NULL OR isrecalled=:isrecalled)", params3, paramsValues3);
        if (staffsprivs3 != null) {
            for (Long staffspriv : staffsprivs3) {
                groupprivileges.add(staffspriv);
            }
        }
        List<Systemmodule> allChildSysModules = new ArrayList<>();
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "privilegeid", "activity", "hasprivilege"};
        String[] paramCSM = {};
        Object[] paramsValCSM = {};
        List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.status=TRUE AND r.parentid.systemmoduleid IS NOT NULL", paramCSM, paramsValCSM);
        if (csmArrList != null && !csmArrList.isEmpty()) {
            for (Object[] ob : csmArrList) {
                Systemmodule sm = new Systemmodule((Long) ob[0]);
                Systemmodule ssm = new Systemmodule((Long) ob[1]);
                sm.setParentid(ssm);
                sm.setPrivilegeid((BigInteger) ob[3]);
                sm.setComponentname((String) ob[2]);
                sm.setHasprivilege((Boolean) ob[5]);
                sm.setActivity((String) ob[4]);

                allChildSysModules.add(sm);
            }
        }

        String[] params1 = {"systemmoduleid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("systemmoduleid"))};
        String[] fields1 = {"systemmoduleid", "componentname", "privilegeid", "hasprivilege", "activity"};
        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE systemmoduleid=:systemmoduleid", params1, paramsValues1);
        if (systemmodules != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] systemmodule : systemmodules) {
                systemmodulesRow = new HashMap<>();
                systemmodulesRow.put("systemmoduleid", systemmodule[0]);
                systemmodulesRow.put("componentname", systemmodule[1]);
                systemmodulesRow.put("privilegeid", systemmodule[2]);
                systemmodulesRow.put("hasprivilege", systemmodule[3]);
                systemmodulesRow.put("activity", systemmodule[4]);

                int subModules = 0;
                List<Long> subModuleId = new ArrayList<>();

                if (!allChildSysModules.isEmpty()) {
                    for (Systemmodule ob : allChildSysModules) {
                        if (ob.getParentid().getSystemmoduleid().intValue() == ((Long) systemmodule[0]).intValue()) {
                            if (ob.getPrivilegeid() != null && !groupprivileges.isEmpty() && groupprivileges.contains(((BigInteger) systemmodule[2]).longValue())) {
                                subModuleId.add(ob.getSystemmoduleid());
                                subModules += 1;
                            }

                        }
                    }
                }
                if (!staffprivileges.isEmpty() && systemmodule[2] != null && staffprivileges.contains(((BigInteger) systemmodule[2]).longValue()) && !groupprivileges.isEmpty() && groupprivileges.contains(((BigInteger) systemmodule[2]).longValue())) {
                    systemmodulesRow.put("assigned", true);
                } else if (!staffprivileges.isEmpty() && systemmodule[2] != null && !staffprivileges.contains(((BigInteger) systemmodule[2]).longValue()) && !groupprivileges.isEmpty() && groupprivileges.contains(((BigInteger) systemmodule[2]).longValue())) {
                    systemmodulesRow.put("assigned", false);
                }
                systemmodulesRow.put("size", subModules);

                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = getStaffAssignedandUnAssignedComponents(allChildSysModules, subModuleId, staffprivileges, groupprivileges);

                }
                systemmodulesRow.put("systemSubcomponenets", customChildList);
                customList.add(systemmodulesRow);

            }
        }
        model.addAttribute("staffcomponentstreelist", customList);
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/views/unGrantedRights";
    }

    private List<Map> getStaffAssignedandUnAssignedComponents(List<Systemmodule> allChildSysModules, List<Long> subModuleIds, Set<Long> staffprivileges, Set<Long> groupprivileges) {
        List<Map> staffcomponentstreelist = new ArrayList<>();
        if (!subModuleIds.isEmpty()) {
            for (Long subModuleId : subModuleIds) {
                List<Map> customChildList2 = new ArrayList<>();
                Map<String, Object> systemmodulesRow;
                for (Systemmodule sm : allChildSysModules) {
                    systemmodulesRow = new HashMap<>();
                    if (subModuleId.intValue() == sm.getSystemmoduleid().intValue()) {

                        systemmodulesRow.put("systemmoduleid", sm.getSystemmoduleid());
                        systemmodulesRow.put("componentname", sm.getComponentname());
                        systemmodulesRow.put("hasprivilege", sm.getHasprivilege());
                        systemmodulesRow.put("activity", sm.getActivity());
                        systemmodulesRow.put("privilegeid", sm.getPrivilegeid());

                        int subModules = 0;
                        List<Long> subModuleId2 = new ArrayList<>();

                        if (!allChildSysModules.isEmpty()) {
                            for (Systemmodule ob : allChildSysModules) {
                                if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                    if (ob.getPrivilegeid() != null && !groupprivileges.isEmpty() && groupprivileges.contains((ob.getPrivilegeid()).longValue())) {
                                        subModuleId2.add(ob.getSystemmoduleid());
                                        subModules += 1;
                                    }

                                }
                            }
                        }
                        if (!staffprivileges.isEmpty() && sm.getPrivilegeid() != null && staffprivileges.contains(((BigInteger) sm.getPrivilegeid()).longValue()) && !groupprivileges.isEmpty() && groupprivileges.contains(((BigInteger) sm.getPrivilegeid()).longValue())) {
                            systemmodulesRow.put("assigned", true);
                        } else if (!staffprivileges.isEmpty() && sm.getPrivilegeid() != null && !staffprivileges.contains(((BigInteger) sm.getPrivilegeid()).longValue()) && !groupprivileges.isEmpty() && groupprivileges.contains(((BigInteger) sm.getPrivilegeid()).longValue())) {
                            systemmodulesRow.put("assigned", false);
                        }
                        systemmodulesRow.put("size", subModules);

                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = getStaffAssignedandUnAssignedComponents(allChildSysModules, subModuleId2, staffprivileges, groupprivileges);

                        }
                        systemmodulesRow.put("systemSubcomponenets", customChildList2);
                        staffcomponentstreelist.add(systemmodulesRow);
                    }
                }
            }
        }
        return staffcomponentstreelist;
    }

    @RequestMapping(value = "/viewstaffunits.htm", method = RequestMethod.GET)
    public String viewstaffunits(Model model, HttpServletRequest request) {
        List<Map> staffunitsList = new ArrayList<>();
        String[] params1 = {"staffid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("staffid"))};
        String[] fields1 = {"stafffacilityunitid", "facilityunitname"};
        List<Object[]> staffunits = (List<Object[]>) genericClassService.fetchRecord(Staffunits.class, fields1, "WHERE staffid=:staffid", params1, paramsValues1);
        if (staffunits != null) {
            Map<String, Object> staffRow;
            for (Object[] staffunit : staffunits) {
                staffRow = new HashMap<>();
                staffRow.put("stafffacilityunitid", staffunit[0]);
                staffRow.put("facilityunitname", staffunit[1]);
                staffunitsList.add(staffRow);
            }
        }
        model.addAttribute("staffunitsList", staffunitsList);
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/views/units";
    }

    @RequestMapping(value = "/viewgroupassignedComponents.htm", method = RequestMethod.GET)
    public String viewgroupassignedComponents(Model model, HttpServletRequest request) {
        List<Map> groupcomponentsList = new ArrayList<>();
        Set<Long> groupprivs = new HashSet<>();
        String[] params = {"accessrightsgroupid", "active"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("groupid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
        if (facilitygroupsprivs != null) {
            for (Long facilitygroupspriv : facilitygroupsprivs) {
                groupprivs.add(facilitygroupspriv);
            }
        }
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"systemmoduleid", "componentname", "privilegeid"};
        List<Object[]> systemmoduleprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params1, paramsValues1);
        if (systemmoduleprivs != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] systemmodulepriv : systemmoduleprivs) {
                systemmodulesRow = new HashMap<>();
                if (!groupprivs.isEmpty() && systemmodulepriv[2] != null && groupprivs.contains(((BigInteger) systemmodulepriv[2]).longValue())) {
                    systemmodulesRow.put("privilegeid", systemmodulepriv[2]);
                    systemmodulesRow.put("systemmoduleid", systemmodulepriv[0]);
                    systemmodulesRow.put("componentname", systemmodulepriv[1]);
                    groupcomponentsList.add(systemmodulesRow);
                }
            }
        }
        model.addAttribute("groupcomponentsList", groupcomponentsList);
        model.addAttribute("groupid", request.getParameter("groupid"));
        return "controlPanel/localSettingsPanel/accessRights/views/components";
    }

    @RequestMapping(value = "/viewgroupscomponents.htm", method = RequestMethod.GET)
    public String viewgroupscomponents(Model model, HttpServletRequest request) {
        String results_view = "";
        List<CustomSystemmodule> customChildList = new ArrayList<>();
        List<CustomSystemmodule> customList = new ArrayList<>();

        Set<Long> groupprivs = new HashSet<>();
        String[] params = {"accessrightsgroupid", "active"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("groupid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
        if (facilitygroupsprivs != null) {
            for (Long facilitygroupspriv : facilitygroupsprivs) {
                groupprivs.add(facilitygroupspriv);
            }
        }

        List<Systemmodule> allChildSysModules = new ArrayList<>();
        String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "activity", "hasprivilege"};
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

                allChildSysModules.add(sm);
            }
        }

        List<Systemmodule> allPrivSysModules = new ArrayList<>();
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
        Object[] paramsValue = {Long.parseLong(request.getParameter("componentid"))};
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
                List<Long> subModuleId = new ArrayList<>();

                if (!allChildSysModules.isEmpty()) {
                    for (Systemmodule ob : allChildSysModules) {
                        if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                            subModuleId.add(ob.getSystemmoduleid());
                            subModules += 1;
                        }
                    }
                }
                ssm.setSubmodules(subModules);

                if (!allPrivSysModules.isEmpty()) {
                    for (Systemmodule obj3 : allPrivSysModules) {
                        if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                            sm.setPrivilegeid(obj3.getPrivilegeid());
                        }
                    }
                }
                if (!groupprivs.isEmpty() && groupprivs.contains((sm.getPrivilegeid()).longValue())) {
                    ssm.setAssigned(true);
                } else {
                    ssm.setAssigned(false);
                }

                ssm.setSystemmodule(sm);
                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = loadParentActivity(allChildSysModules, allPrivSysModules, request, subModuleId, groupprivs);

                }
                ssm.setCustomSystemmoduleList(customChildList);
                customList.add(ssm);
            }
        }
        model.addAttribute("customList", customList);
        try {
            model.addAttribute("customListss", new ObjectMapper().writeValueAsString(customList));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LocalAccessRightsManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "controlPanel/localSettingsPanel/accessRights/views/groupTree";
    }

    @RequestMapping(value = "/viewUngrantedgroupscomponents.htm", method = RequestMethod.GET)
    public String viewUngrantedgroupscomponents(Model model, HttpServletRequest request) {
        List<Map> customChildList = new ArrayList<>();
        List<Map> customList = new ArrayList<>();

        Set<Long> allaccesspriv = new HashSet<>();
        String[] params8 = {"facilityid", "isactive"};
        Object[] paramsValues8 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
        String[] fields8 = {"privilegeid"};
        String where8 = "WHERE facilityid=:facilityid AND isactive=:isactive";
        List<Long> facilityprivilges = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields8, where8, params8, paramsValues8);
        if (facilityprivilges != null) {
            for (Long facilityprivilge : facilityprivilges) {
                allaccesspriv.add(facilityprivilge);
            }
        }

        Set<Long> groupprivs = new HashSet<>();
        String[] params = {"accessrightsgroupid", "active"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("groupid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
        if (facilitygroupsprivs != null) {
            for (Long facilitygroupspriv : facilitygroupsprivs) {
                groupprivs.add(facilitygroupspriv);
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
                sm.setPrivilegeid((BigInteger) ob[5]);
                sm.setHasprivilege((Boolean) ob[4]);
                allChildSysModules.add(sm);
            }
        }

        String[] field = {"systemmoduleid", "componentname", "hasprivilege", "activity", "privilegeid"};
        String[] param = {"ssmid"};
        Object[] paramsValue = {Long.parseLong(request.getParameter("componentid"))};
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
                        if (ob.getParentid().getSystemmoduleid().intValue() == ((Long) obj[0]).intValue() && !allaccesspriv.isEmpty() && allaccesspriv.contains((ob.getPrivilegeid()).longValue())) {
                            subModuleId.add(ob.getSystemmoduleid());
                            subModules += 1;
                        }
                    }
                }
                systemmodulesRow.put("submodules", subModules);

                if (!allaccesspriv.isEmpty() && allaccesspriv.contains(((BigInteger) obj[4]).longValue()) && !groupprivs.isEmpty() && groupprivs.contains(((BigInteger) obj[4]).longValue())) {
                    systemmodulesRow.put("assigned", true);
                } else if (!allaccesspriv.isEmpty() && allaccesspriv.contains(((BigInteger) obj[4]).longValue()) && !groupprivs.isEmpty() && !groupprivs.contains(((BigInteger) obj[4]).longValue())) {
                    systemmodulesRow.put("assigned", false);
                }

                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = loadUnAssignedGroupParentActivity(allChildSysModules, subModuleId, allaccesspriv, groupprivs);
                }
                systemmodulesRow.put("customSystemmoduleList", customChildList);
                customList.add(systemmodulesRow);
            }

        }

        model.addAttribute("customList", customList);
        model.addAttribute("componentid", request.getParameter("componentid"));
        model.addAttribute("groupid", request.getParameter("groupid"));

        return "controlPanel/localSettingsPanel/accessRights/views/unGrantedGroupTree";

    }

    private List<Map> loadUnAssignedGroupParentActivity(List<Systemmodule> allChildSysModules, List<Long> ids, Set<Long> allaccesspriv, Set<Long> groupprivs) {
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
                                if (ob.getParentid().getSystemmoduleid().intValue() == (sm.getSystemmoduleid()).intValue() && !allaccesspriv.isEmpty() && allaccesspriv.contains(ob.getPrivilegeid().longValue())) {
                                    subModuleId2.add(ob.getSystemmoduleid());
                                    subModules += 1;
                                }
                            }
                        }
                        if (!allaccesspriv.isEmpty() && allaccesspriv.contains(sm.getPrivilegeid().longValue()) && !groupprivs.isEmpty() && groupprivs.contains((sm.getPrivilegeid().longValue()))) {
                            systemmodulesRow.put("assigned", true);
                        } else if (!allaccesspriv.isEmpty() && allaccesspriv.contains(sm.getPrivilegeid().longValue()) && !groupprivs.isEmpty() && !groupprivs.contains((sm.getPrivilegeid().longValue()))) {
                            systemmodulesRow.put("assigned", false);
                        }

                        systemmodulesRow.put("submodules", subModules);
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = loadUnAssignedGroupParentActivity(allChildSysModules, subModuleId2, allaccesspriv, groupprivs);
                        }
                        systemmodulesRow.put("customSystemmoduleList", customChildList2);
                        customList2.add(systemmodulesRow);
                    }
                }
            }
        }
        return customList2;
    }

    @RequestMapping(value = "/getgroupstaffcomponents.htm")
    public @ResponseBody
    String getgroupstaffcomponents(Model model, HttpServletRequest request) {
        List<Map> staffAssignedUnits = new ArrayList<>();
        String results = "";
        try {
            Set<Object> staffsunits = new HashSet<>();
            String[] params1 = {"staffid", "accessrightsgroupid"};
            Object[] paramsValues1 = {Long.parseLong(request.getParameter("staffid")), Integer.parseInt(request.getParameter("groupid"))};
            String[] fields1 = {"facilityunitid", "stafffacilityunitid", "facilityunitname"};
            List<Object[]> staffunits = (List<Object[]>) genericClassService.fetchRecord(Staffunits.class, fields1, "WHERE facilityunitid IN"
                    + "(SELECT sfu.facilityunitid FROM Stafffacilityunit sfu WHERE sfu.staffid=:staffid AND sfu.stafffacilityunitid IN"
                    + "(SELECT sar.stafffacilityunitid FROM Staffassignedrights sar WHERE accessrightsgroupid=:accessrightsgroupid))",
                    params1, paramsValues1);
            if (staffunits != null) {
                for (Object[] staffunit : staffunits) {
                    staffsunits.add(staffunit[0]);
                }
            }
            if (!staffsunits.isEmpty()) {
                Map<String, Object> staffRow;
                for (Object staffsunit : staffsunits) {
                    staffRow = new HashMap<>();
                    String[] params = {"facilityunitid", "staffid", "active"};
                    Object[] paramsValues = {staffsunit, Long.parseLong(request.getParameter("staffid")), Boolean.TRUE};
                    String[] fields = {"facilityunitname", "stafffacilityunitid"};
                    List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Staffunits.class, fields, "WHERE facilityunitid=:facilityunitid AND staffid=:staffid AND active=:active", params, paramsValues);
                    if (facilityunits != null) {
                        staffRow.put("facilityunitid", staffsunit);
                        staffRow.put("stafffacilityunitid", facilityunits.get(0)[1]);
                        staffRow.put("facilityunitname", facilityunits.get(0)[0]);
                        staffAssignedUnits.add(staffRow);
                    }
                }
            }
            results = new ObjectMapper().writeValueAsString(staffAssignedUnits);
        } catch (Exception e) {
        }

        return results;
    }

    @RequestMapping(value = "/savesavestaffungrantedgroupright.htm")
    public @ResponseBody
    String savesavestaffungrantedgroupright(Model model, HttpServletRequest request) {
        String results = "";
        try {
            final List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("privileges"), List.class);
            for (String priv : item) {
                System.out.println("::::::::::::::::::::::::::::::::::::" + priv);

                String[] param = {"accessrightsgroupid", "privilegeid", "active"};
                Object[] paramsValue = {Integer.parseInt(request.getParameter("staffgroupid")), Long.parseLong(priv), Boolean.TRUE};
                String[] field = {"accessrightgroupprivilegeid"};
                List<Integer> privileges = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, field, "WHERE accessrightsgroupid=:accessrightsgroupid AND privilegeid=:privilegeid AND  active=:active", param, paramsValue);
                if (privileges != null) {

                    String[] paramCSM = {"accessrightgroupprivilegeid", "stafffacilityunitid"};
                    Object[] paramsValCSM = {privileges.get(0), Long.valueOf(request.getParameter("stafffacilityunitdI"))};
                    String[] fieldCSM = {"stafffacilityunitaccessrightprivilegeid", "active"};
                    List<Object[]> stafffacilityunitaccessrightprivilegeid = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fieldCSM, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid AND stafffacilityunitid=:stafffacilityunitid", paramCSM, paramsValCSM);
                    if (stafffacilityunitaccessrightprivilegeid == null) {

                        Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                        stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                        stafffacilityunitaccessrightprivilege.setAddedby((Long) request.getSession().getAttribute("person_id"));
                        stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                        stafffacilityunitaccessrightprivilege.setStafffacilityunitid(Long.valueOf(request.getParameter("stafffacilityunitdI")));
                        stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid(privileges.get(0));

                        Object save = genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);
                    } else if ((Boolean) stafffacilityunitaccessrightprivilegeid.get(0)[1] == false) {
                        //to implement and bactrack
                    }
                }
            }
            final int groupid = Integer.parseInt(request.getParameter("staffgroupid"));
            final Long person_id = (Long) request.getSession().getAttribute("person_id");
            final Long stafffacilityunitid = Long.valueOf(request.getParameter("stafffacilityunitdI"));

            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    for (String priv : item) {
                        String[] param = {"privilegeid"};
                        Object[] paramsValue = {Long.parseLong(priv)};
                        String[] field = {"parentid.systemmoduleid", "status"};
                        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE privilegeid=:privilegeid", param, paramsValue);
                        if (systemmodules != null) {
                            parentStaffUnAssignedRights(systemmodules.get(0)[0], stafffacilityunitid, groupid, person_id);
                        }
                    }
                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();
        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.savesavestaffungrantedgroupright()" + e);
        }
        return results;
    }

    private void parentStaffUnAssignedRights(Object systemmoduleid, Long stafffacilityunitid, int groupid, Long person_id) {
        String[] param = {"systemmoduleid"};
        Object[] paramsValue = {systemmoduleid};
        String[] field = {"parentid.systemmoduleid", "privilegeid"};
        List<Object[]> systemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE systemmoduleid=:systemmoduleid", param, paramsValue);
        if (systemmodules != null) {
            if (systemmodules.get(0)[1] != null) {

                String[] param2 = {"accessrightsgroupid", "privilegeid", "active"};
                Object[] paramsValue2 = {groupid, systemmodules.get(0)[1], Boolean.TRUE};
                String[] field2 = {"accessrightgroupprivilegeid"};
                List<Integer> privileges = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, field2, "WHERE accessrightsgroupid=:accessrightsgroupid AND privilegeid=:privilegeid AND active=:active", param2, paramsValue2);
                if (privileges != null) {

                    String[] paramCSM = {"accessrightgroupprivilegeid", "stafffacilityunitid"};
                    Object[] paramsValCSM = {privileges.get(0), stafffacilityunitid};
                    String[] fieldCSM = {"stafffacilityunitaccessrightprivilegeid", "active"};
                    List<Object[]> stafffacilityunitaccessrightprivilegeid = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fieldCSM, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid AND stafffacilityunitid=:stafffacilityunitid", paramCSM, paramsValCSM);
                    if (stafffacilityunitaccessrightprivilegeid == null) {

                        Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                        stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                        stafffacilityunitaccessrightprivilege.setAddedby(person_id);
                        stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                        stafffacilityunitaccessrightprivilege.setStafffacilityunitid(stafffacilityunitid);
                        stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid(privileges.get(0));

                        Object save = genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);
                    } else if ((Boolean) stafffacilityunitaccessrightprivilegeid.get(0)[1] == false) {

                        //to implement and bactrack
                    }
                }
            }
            if (systemmodules.get(0)[0] != null) {
                parentStaffUnAssignedRights(systemmodules.get(0)[0], stafffacilityunitid, groupid, person_id);
            }
        }
    }

    @RequestMapping(value = "/componentsubcomponentstest.htm", method = RequestMethod.GET)
    public String componentsubcomponentstest(Model model, HttpServletRequest request) {
        try {
            List<CustomSystemmodule> customChildList = new ArrayList<>();
            List<CustomSystemmodule> customList = new ArrayList<>();
            Set<Long> allaccesspriv = new HashSet<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("allaccesspriv"), List.class);
            for (Integer priv : item) {
                allaccesspriv.add(Long.valueOf(String.valueOf(priv)));
            }
            System.out.println("::::::::::::::::::::::::::::::::" + allaccesspriv);

            List<Systemmodule> allChildSysModules = new ArrayList<>();
            String[] fieldCSM = {"systemmoduleid", "parentid.systemmoduleid", "componentname", "activity", "hasprivilege"};
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

                    allChildSysModules.add(sm);
                }
            }

            List<Systemmodule> allPrivSysModules = new ArrayList<>();
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
            Object[] paramsValue = {Long.parseLong(request.getParameter("systemmoduleid"))};
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
                    List<Long> subModuleId = new ArrayList<>();

                    if (!allChildSysModules.isEmpty()) {
                        for (Systemmodule ob : allChildSysModules) {
                            if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                subModuleId.add(ob.getSystemmoduleid());
                                subModules += 1;
                            }
                        }
                    }
                    ssm.setSubmodules(subModules);

                    if (!allPrivSysModules.isEmpty()) {
                        for (Systemmodule obj3 : allPrivSysModules) {
                            if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                sm.setPrivilegeid(obj3.getPrivilegeid());
                            }
                        }
                    }
                    if (!allaccesspriv.isEmpty() && allaccesspriv.contains((sm.getPrivilegeid()).longValue())) {
                        ssm.setAssigned(true);
                    } else {
                        ssm.setAssigned(false);
                    }

                    ssm.setSystemmodule(sm);
                    //Call function to load child elements
                    if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                        customChildList = loadParentActivity(allChildSysModules, allPrivSysModules, request, subModuleId, allaccesspriv);

                    }
                    ssm.setCustomSystemmoduleList(customChildList);
                    customList.add(ssm);
                }
            }
            model.addAttribute("customList", customList);
            model.addAttribute("customListsss", new ObjectMapper().writeValueAsString(customList));
            System.out.println("::::::" + new ObjectMapper().writeValueAsString(customList));
            model.addAttribute("createdgroupid", request.getParameter("createdgroupid"));
            model.addAttribute("systemmoduleid", request.getParameter("systemmoduleid"));
        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.componentsubcomponentstest()" + e);
        }

        return "controlPanel/localSettingsPanel/accessRights/forms/subComponents";
    }

    private List<CustomSystemmodule> loadParentActivity(List<Systemmodule> allChildSysModules, List<Systemmodule> allPrivSysModules, HttpServletRequest request, List<Long> ids, Set<Long> assignedPrivs) {

        List<CustomSystemmodule> customList2 = new ArrayList<>();
        try {
            for (Long id : ids) {
                List<CustomSystemmodule> customChildList2 = new ArrayList<>();
                if (!allChildSysModules.isEmpty()) {
                    for (Systemmodule sm : allChildSysModules) {
                        if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                            CustomSystemmodule ssm = new CustomSystemmodule();

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

                            ssm.setSubmodules(subModules);

                            if (!allPrivSysModules.isEmpty()) {
                                for (Systemmodule obj3 : allPrivSysModules) {
                                    if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        sm.setPrivilegeid(obj3.getPrivilegeid());
                                    }
                                }
                            }
                            if ((sm.getPrivilegeid()) != null && !assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).longValue())) {
                                ssm.setAssigned(true);
                            } else {
                                ssm.setAssigned(false);
                            }
                            ssm.setSystemmodule(sm);

                            if (subModules > 0) {
//                            logger.info(":Child Fetch:::went In again get::::--------::sms::"+subModules+" for "+sm.getComponentname()+" ::"+subModuleId.size());
                                customChildList2 = loadParentActivity(allChildSysModules, allPrivSysModules, request, subModuleId, assignedPrivs);
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

    private List<CustomSystemmodule> loadParentUnActivity(List<Systemmodule> allSysModules, List<Systemmodule> allChildSysModules, List<Systemmodule> allPrivSysModules, HttpServletRequest request, List<Long> ids, Set<Long> assignedPrivs, Set<Long> allaccesspriv) {
        List<CustomSystemmodule> customList2 = new ArrayList<>();
        try {
            for (Long id : ids) {
                List<CustomSystemmodule> customChildList2 = new ArrayList<>();
                if (!allSysModules.isEmpty()) {
                    for (Systemmodule sm : allSysModules) {
                        if (sm.getSystemmoduleid().intValue() == id.intValue()) {
                            CustomSystemmodule ssm = new CustomSystemmodule();

                            int subModules = 0;
                            List<Long> subModuleId = new ArrayList<>();

                            if (allChildSysModules != null && !allChildSysModules.isEmpty()) {
                                for (Systemmodule ob : allChildSysModules) {
                                    if (ob.getParentid().getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        subModuleId.add(ob.getSystemmoduleid());
                                        subModules += 1;
                                    }
                                }
                            }

                            ssm.setSubmodules(subModules);

                            if (!allPrivSysModules.isEmpty()) {
                                for (Systemmodule obj3 : allPrivSysModules) {
                                    if (obj3.getSystemmoduleid().intValue() == sm.getSystemmoduleid().intValue()) {
                                        sm.setPrivilegeid(obj3.getPrivilegeid());
                                    }
                                }
                            }
                            ssm.setSystemmodule(sm);

                            if (subModules > 0) {
                                if (!allaccesspriv.isEmpty() && allaccesspriv.contains(sm.getPrivilegeid().longValue())) {
                                    ssm.setAssigned(false);
                                } else {
                                    ssm.setAssigned(true);
                                }
//                            logger.info(":Child Fetch:::went In again get::::--------::sms::"+subModules+" for "+sm.getComponentname()+" ::"+subModuleId.size());
                                customChildList2 = loadParentUnActivity(allSysModules, allChildSysModules, allPrivSysModules, request, subModuleId, assignedPrivs, allaccesspriv);
                            } else {
                                if ((sm.getPrivilegeid()) != null && !assignedPrivs.isEmpty() && assignedPrivs.contains((sm.getPrivilegeid()).longValue())) {
                                    ssm.setAssigned(true);
                                } else {
                                    if (!allaccesspriv.isEmpty() && allaccesspriv.contains(sm.getPrivilegeid().longValue())) {
                                        ssm.setAssigned(false);
                                    } else {
                                        ssm.setAssigned(true);
                                    }
                                }
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

    @RequestMapping(value = "/savestaffgroupaccessrightsdeassigned.htm")
    public @ResponseBody
    String savestaffgroupaccessrightsdeassigned(final HttpServletRequest request) {
        String response = "";
        try {
            final List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String priv : item) {
                String[] field = {"stafffacilityunitaccessrightprivilegeid"};
                String[] param = {"stafffacilityunitid", "privilegeid", "accessrightsgroupid"};
                Object[] paramsValue = {Long.parseLong(request.getParameter("stafffacilityunit")), Long.parseLong(priv), Integer.parseInt(request.getParameter("staffGratedGroupsSlectId"))};
                List<Integer> sysArrList = (List<Integer>) genericClassService.fetchRecord(Staffassignedrights.class, field, "WHERE stafffacilityunitid=:stafffacilityunitid AND privilegeid=:privilegeid AND accessrightsgroupid=:accessrightsgroupid", param, paramsValue);
                if (sysArrList != null) {
                    String[] columns = {"active", "lastupdatedby", "lastupdated"};
                    Object[] columnValues = {Boolean.FALSE, (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk = "stafffacilityunitaccessrightprivilegeid";
                    Object pkValue = sysArrList.get(0);
                    int result = genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunitaccessrightprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");
                }
            }

            final Long stafffacility = Long.parseLong(request.getParameter("stafffacilityunit"));
            final Integer groupid = Integer.parseInt(request.getParameter("staffGratedGroupsSlectId"));
            final Long person_id = (Long) request.getSession().getAttribute("person_id");

            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    Set<Long> staffprivs = new HashSet<>();
                    String[] field = {"privilegeid"};
                    String[] param = {"stafffacilityunitid", "accessrightsgroupid", "stafffacilityunitaccessrightprivstatus"};
                    Object[] paramsValue = {Long.parseLong(request.getParameter("stafffacilityunit")), Integer.parseInt(request.getParameter("staffGratedGroupsSlectId")), Boolean.TRUE};
                    List<Long> sysArrList = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, field, "WHERE stafffacilityunitid=:stafffacilityunitid AND accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", param, paramsValue);
                    if (sysArrList != null) {
                        for (Long sysArr : sysArrList) {
                            staffprivs.add(sysArr);
                        }
                    }
                    for (String priv : item) {
                        getparentprivs(Long.valueOf(priv), stafffacility, staffprivs, groupid, person_id);
                    }
                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();
        } catch (Exception e) {
            System.err.println("'''''''''''''''''''''''''''''''''''''''''''':" + e);
        }
        return response;
    }

    private void getparentprivs(Long privilegeid, Long stafffacilityunit, Set<Long> staffprivs, Integer accessrightsgroupid, Long person_id) {

        String[] field = {"systemmoduleid", "parentid.systemmoduleid", "parentid.privilegeid"};
        String[] param = {"privilegeid"};
        Object[] paramsValue = {BigInteger.valueOf(privilegeid)};
        List<Object[]> privileges = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.privilegeid=:privilegeid", param, paramsValue);
        if (privileges != null) {
            if (privileges.get(0)[1] != null) {
                String[] fieldCSM = {"systemmoduleid", "privilegeid", "componentname"};
                String[] paramCSM = {"parentid", "privilegeid"};
                Object[] paramsValCSM = {privileges.get(0)[1], BigInteger.valueOf(privilegeid)};
                List<Object[]> csmArrList = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldCSM, "WHERE r.parentid.systemmoduleid=:parentid AND privilegeid !=:privilegeid", paramCSM, paramsValCSM);
                if (csmArrList != null) {
                    int count = 0;
                    for (Object[] csmArrLists : csmArrList) {
                        if (!staffprivs.isEmpty() && staffprivs.contains(((BigInteger) csmArrLists[1]).longValue())) {
                            count = count + 1;
                        }
                    }
                    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>" + count);
                    if (count == 0) {
                        System.out.println("::::::::::::::::::::::::::::::::" + count);
                        //getparentprivs(((BigInteger) privileges.get(0)[2]).longValue(), stafffacilityunit, staffprivs, accessrightsgroupid, person_id);
                        //////////
                        String[] field2 = {"stafffacilityunitaccessrightprivilegeid"};
                        String[] param2 = {"privilegeid", "stafffacilityunitid", "accessrightsgroupid"};
                        Object[] paramsValue2 = {privileges.get(0)[2], stafffacilityunit, accessrightsgroupid};
                        List<Integer> privileges2 = (List<Integer>) genericClassService.fetchRecord(Staffassignedrights.class, field2, "WHERE privilegeid=:privilegeid AND stafffacilityunitid=:stafffacilityunitid AND accessrightsgroupid=:accessrightsgroupid", param2, paramsValue2);
                        if (privileges2 != null) {
                            String[] columns = {"active", "lastupdatedby", "lastupdated"};
                            Object[] columnValues = {Boolean.FALSE, person_id, new Date()};
                            String pk = "stafffacilityunitaccessrightprivilegeid";
                            Object pkValue = privileges2.get(0);
                            int result = genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunitaccessrightprivilege.class, columns, columnValues, pk, pkValue, "controlpanel");
                            if (result != 0) {

                                Set<Long> staffprivs2 = new HashSet<>();
                                String[] field5 = {"privilegeid"};
                                String[] param5 = {"stafffacilityunitid", "accessrightsgroupid", "stafffacilityunitaccessrightprivstatus"};
                                Object[] paramsValue5 = {stafffacilityunit, accessrightsgroupid, Boolean.TRUE};
                                List<Long> sysArrList5 = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, field5, "WHERE stafffacilityunitid=:stafffacilityunitid AND accessrightsgroupid=:accessrightsgroupid AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus", param5, paramsValue5);
                                if (sysArrList5 != null) {
                                    for (Long sysArr : sysArrList5) {
                                        staffprivs2.add(sysArr);
                                    }
                                }
                                getparentprivs(((BigInteger) privileges.get(0)[2]).longValue(), stafffacilityunit, staffprivs2, accessrightsgroupid, person_id);
                            }
                        }
                    }
                }
            }
        }
    }

    @RequestMapping(value = "/viewgroupassignedComponentsandadd.htm", method = RequestMethod.GET)
    public String viewgroupassignedComponentsandadd(Model model, HttpServletRequest request) {
        List<Map> groupcomponentsList = new ArrayList<>();
        Set<Long> groupprivs = new HashSet<>();
        String[] params = {"accessrightsgroupid", "active"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
        if (facilitygroupsprivs != null) {
            for (Long facilitygroupspriv : facilitygroupsprivs) {
                groupprivs.add(facilitygroupspriv);
            }
        }
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"systemmoduleid", "componentname", "privilegeid"};
        List<Object[]> systemmoduleprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params1, paramsValues1);
        if (systemmoduleprivs != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] systemmodulepriv : systemmoduleprivs) {
                systemmodulesRow = new HashMap<>();
                if (!groupprivs.isEmpty() && systemmodulepriv[2] != null && groupprivs.contains(((BigInteger) systemmodulepriv[2]).longValue())) {
                    systemmodulesRow.put("privilegeid", systemmodulepriv[2]);
                    systemmodulesRow.put("systemmoduleid", systemmodulepriv[0]);
                    systemmodulesRow.put("componentname", systemmodulepriv[1]);
                    groupcomponentsList.add(systemmodulesRow);
                }
            }
        }
        model.addAttribute("groupcomponentsList", groupcomponentsList);
        model.addAttribute("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
        return "controlPanel/localSettingsPanel/accessRights/views/addMoreGroupComponents";
    }

    @RequestMapping(value = "/addreleasedfacilitygroupcomponents.htm", method = RequestMethod.GET)
    public String addreleasedfacilitygroupcomponents(Model model, HttpServletRequest request) {
        List<Map> groupcomponentsList = new ArrayList<>();
        Set<Long> groupprivs = new HashSet<>();
        String[] params = {"accessrightsgroupid", "active"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
        String[] fields = {"privilegeid"};
        List<Long> facilitygroupsprivs = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields, "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active", params, paramsValues);
        if (facilitygroupsprivs != null) {
            for (Long facilitygroupspriv : facilitygroupsprivs) {
                groupprivs.add(facilitygroupspriv);
            }
        }
        Set<Long> allaccesspriv = new HashSet<>();
        String[] params8 = {"facilityid", "isactive"};
        Object[] paramsValues8 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
        String[] fields8 = {"privilegeid"};
        String where8 = "WHERE facilityid=:facilityid AND isactive=:isactive";
        List<Long> facilityprivilges = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields8, where8, params8, paramsValues8);
        if (facilityprivilges != null) {
            for (Long facilityprivilge : facilityprivilges) {
                allaccesspriv.add(facilityprivilge);
            }
        }
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"systemmoduleid", "componentname", "privilegeid"};
        List<Object[]> systemmoduleprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE r.parentid.systemmoduleid IS NULL AND hasprivilege=TRUE ORDER BY r.componentname ASC", params1, paramsValues1);
        if (systemmoduleprivs != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] systemmodulepriv : systemmoduleprivs) {
                systemmodulesRow = new HashMap<>();
                if (systemmodulepriv[2] != null) {
                    if (groupprivs.isEmpty() || !groupprivs.contains(((BigInteger) systemmodulepriv[2]).longValue())) {
                        if (!allaccesspriv.isEmpty() && allaccesspriv.contains(((BigInteger) systemmodulepriv[2]).longValue())) {
                            systemmodulesRow.put("privilegeid", systemmodulepriv[2]);
                            systemmodulesRow.put("systemmoduleid", systemmodulepriv[0]);
                            systemmodulesRow.put("componentname", systemmodulepriv[1]);
                            groupcomponentsList.add(systemmodulesRow);
                        }
                    }
                }
            }
        }
        model.addAttribute("groupcomponentsList", groupcomponentsList);
        model.addAttribute("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
        return "controlPanel/localSettingsPanel/accessRights/views/unAssignedGroupComponents";
    }

    @RequestMapping(value = "/componentstreeview.htm", method = RequestMethod.GET)
    public String componentstreeview(Model model, HttpServletRequest request) {
        List<Map> customChildList = new ArrayList<>();
        List<Map> customList = new ArrayList<>();

        Set<Long> allaccesspriv = new HashSet<>();
        String[] params8 = {"facilityid", "isactive"};
        Object[] paramsValues8 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
        String[] fields8 = {"privilegeid"};
        String where8 = "WHERE facilityid=:facilityid AND isactive=:isactive";
        List<Long> facilityprivilges = (List<Long>) genericClassService.fetchRecord(Facilityprivilege.class, fields8, where8, params8, paramsValues8);
        if (facilityprivilges != null) {
            for (Long facilityprivilge : facilityprivilges) {
                allaccesspriv.add(facilityprivilge);
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

                if (!allaccesspriv.isEmpty() && allaccesspriv.contains(((BigInteger) obj[4]).longValue())) {
                    systemmodulesRow.put("assigned", true);
                } else {
                    systemmodulesRow.put("assigned", false);
                }

                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = loadAddParentActivity(allChildSysModules, subModuleId, allaccesspriv);
                }
                systemmodulesRow.put("customSystemmoduleList", customChildList);
                customList.add(systemmodulesRow);
            }

        }
        model.addAttribute("customList", customList);
        return "controlPanel/localSettingsPanel/accessRights/forms/unReleasedGroupcomponentTree";
    }

    private List<Map> loadAddParentActivity(List<Systemmodule> allChildSysModules, List<Long> ids, Set<Long> allaccesspriv) {
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
                        if (!allaccesspriv.isEmpty() && allaccesspriv.contains(sm.getPrivilegeid().longValue())) {
                            systemmodulesRow.put("assigned", true);
                        } else {
                            systemmodulesRow.put("assigned", false);
                        }

                        systemmodulesRow.put("submodules", subModules);
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = loadAddParentActivity(allChildSysModules, subModuleId2, allaccesspriv);
                        }
                        systemmodulesRow.put("customSystemmoduleList", customChildList2);
                        customList2.add(systemmodulesRow);
                    }
                }
            }
        }
        return customList2;
    }

    @RequestMapping(value = "/addmoregroupcomponentstostaff.htm", method = RequestMethod.GET)
    public String addmoregroupcomponentstostaff(Model model, HttpServletRequest request) {
        List<Map> componentsList = new ArrayList<>();
        List<Map> staffUnitsList = new ArrayList<>();
        Set<Long> allaccesspriv = new HashSet<>();
        String[] params8 = {"accessrightsgroupid", "active"};
        Object[] paramsValues8 = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
        String[] fields8 = {"privilegeid"};
        String where8 = "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active";
        List<Long> facilityprivilges = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields8, where8, params8, paramsValues8);
        if (facilityprivilges != null) {
            for (Long facilityprivilge : facilityprivilges) {
                allaccesspriv.add(facilityprivilge);
            }
        }

        Set<Long> allstaffaccesspriv = new HashSet<>();
        String[] paramss = {"staffid", "accessrightsgroupid", "accessrightgroupstatus", "stafffacilityunitaccessrightprivstatus"};
        Object[] paramsValuess = {Long.parseLong(request.getParameter("staffid")), Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE, Boolean.TRUE};
        String[] fieldss = {"privilegeid"};
        String wheres = "WHERE staffid=:staffid AND accessrightsgroupid=:accessrightsgroupid AND accessrightgroupstatus=:accessrightgroupstatus AND stafffacilityunitaccessrightprivstatus=:stafffacilityunitaccessrightprivstatus";
        List<Long> facilityprivilgess = (List<Long>) genericClassService.fetchRecord(Staffassignedrights.class, fieldss, wheres, paramss, paramsValuess);
        if (facilityprivilgess != null) {
            for (Long facilityprivilge : facilityprivilgess) {
                allstaffaccesspriv.add(facilityprivilge);
            }
        }

        String[] param = {};
        Object[] paramsValue = {};
        String[] field = {"systemmoduleid", "componentname", "privilegeid"};
        List<Object[]> sysArrLists = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, field, "WHERE r.parentid.systemmoduleid IS NULL ORDER BY r.componentname ASC ", param, paramsValue);
        if (sysArrLists != null) {
            Map<String, Object> systemmodulesRow;
            for (Object[] sysArrList : sysArrLists) {
                systemmodulesRow = new HashMap<>();
                if (!allaccesspriv.isEmpty() && allaccesspriv.contains(((BigInteger) sysArrList[2]).longValue()) && (allstaffaccesspriv.isEmpty() || !allstaffaccesspriv.contains(((BigInteger) sysArrList[2]).longValue()))) {
                    systemmodulesRow.put("systemmoduleid", sysArrList[0]);
                    systemmodulesRow.put("componentname", sysArrList[1]);
                    componentsList.add(systemmodulesRow);
                }

            }
        }

        String[] paramu = {"staffid", "active"};
        Object[] paramsValueu = {Long.parseLong(request.getParameter("staffid")), Boolean.TRUE};
        String[] fieldu = {"stafffacilityunitid", "facilityunitname"};
        List<Object[]> staffunits = (List<Object[]>) genericClassService.fetchRecord(Staffunits.class, fieldu, "WHERE staffid=:staffid AND active=:active", paramu, paramsValueu);
        if (staffunits != null) {
            Map<String, Object> staffunitsRow;
            for (Object[] staffunit : staffunits) {
                staffunitsRow = new HashMap<>();
                staffunitsRow.put("stafffacilityunitid", staffunit[0]);
                staffunitsRow.put("facilityunitname", staffunit[1]);
                staffUnitsList.add(staffunitsRow);
            }
        }
        model.addAttribute("componentsList", componentsList);
        model.addAttribute("staffUnitsList", staffUnitsList);
        model.addAttribute("accessrightsgroupid", request.getParameter("accessrightsgroupid"));
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/forms/AddMoreStaffComponents";
    }

    @RequestMapping(value = "/addmorestaffgroupcomponents.htm", method = RequestMethod.GET)
    public String addmorestaffgroupcomponents(Model model, HttpServletRequest request) {
        List<Map> customChildList = new ArrayList<>();
        List<Map> customList = new ArrayList<>();
        System.out.println("com.iics.web.LocalAccessRightsManagement.addmorestaffgroupcomponents()");
        Set<Long> allaccesspriv = new HashSet<>();
        String[] params8 = {"accessrightsgroupid", "active"};
        Object[] paramsValues8 = {Integer.parseInt(request.getParameter("accessrightsgroupid")), Boolean.TRUE};
        String[] fields8 = {"privilegeid"};
        String where8 = "WHERE accessrightsgroupid=:accessrightsgroupid AND active=:active";
        List<Long> facilityprivilges = (List<Long>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields8, where8, params8, paramsValues8);
        if (facilityprivilges != null) {
            for (Long facilityprivilge : facilityprivilges) {
                allaccesspriv.add(facilityprivilge);
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

                if (!allaccesspriv.isEmpty() && allaccesspriv.contains(((BigInteger) obj[4]).longValue())) {
                    systemmodulesRow.put("assigned", true);
                } else {
                    systemmodulesRow.put("assigned", false);
                }

                //Call function to load child elements
                if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                    customChildList = loadAddGroupParentActivity(allChildSysModules, subModuleId, allaccesspriv);
                }
                systemmodulesRow.put("subComponents", customChildList);
                customList.add(systemmodulesRow);
            }

        }
        model.addAttribute("customList", customList);
        return "controlPanel/localSettingsPanel/accessRights/staffAccessRights/forms/addMoreStaffGroupComponentsTree";
    }

    private List<Map> loadAddGroupParentActivity(List<Systemmodule> allChildSysModules, List<Long> ids, Set<Long> allaccesspriv) {
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
                        if (!allaccesspriv.isEmpty() && allaccesspriv.contains(sm.getPrivilegeid().longValue())) {
                            systemmodulesRow.put("assigned", true);
                        } else {
                            systemmodulesRow.put("assigned", false);
                        }

                        systemmodulesRow.put("submodules", subModules);
                        if (subModules > 0) {
//                                logger.info(":Parent Fetch:::went In again get::::-------::sms::" + subModules + " for " + sm.getComponentname() + " ::" + subModuleId.size());
                            customChildList2 = loadAddGroupParentActivity(allChildSysModules, subModuleId2, allaccesspriv);
                        }
                        systemmodulesRow.put("subComponents", customChildList2);
                        customList2.add(systemmodulesRow);
                    }
                }
            }
        }
        return customList2;
    }

    @RequestMapping(value = "/savestaffaddmoreungrantedgroupright.htm")
    public @ResponseBody
    String savestaffaddmoreungrantedgroupright(final HttpServletRequest request) {
        String response = "";
        try {
            final List<String> privileges2 = (ArrayList) new ObjectMapper().readValue(request.getParameter("privileges"), List.class);
            final List<String> units = (ArrayList) new ObjectMapper().readValue(request.getParameter("stafffacilityunitdI"), List.class);
            for (String unit : units) {
                for (String priv2 : privileges2) {

                    String[] field = {"accessrightgroupprivilegeid"};
                    String[] param = {"accessrightsgroupid", "privilegeid", "active"};
                    Object[] paramsValue = {Integer.parseInt(request.getParameter("staffgroupid")), Long.parseLong(priv2), Boolean.TRUE};
                    List<Integer> privileges = (List<Integer>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, field, "WHERE accessrightsgroupid=:accessrightsgroupid AND privilegeid=:privilegeid AND active=:active", param, paramsValue);
                    if (privileges != null) {

                        String[] params8 = {"accessrightgroupprivilegeid", "stafffacilityunitid"};
                        Object[] paramsValues8 = {privileges.get(0), Long.parseLong(unit)};
                        String[] fields8 = {"stafffacilityunitaccessrightprivilegeid", "active"};
                        String where8 = "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid AND stafffacilityunitid=:stafffacilityunitid";
                        List<Object[]> groupprivilges = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fields8, where8, params8, paramsValues8);
                        if (groupprivilges == null) {
                            Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                            stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                            stafffacilityunitaccessrightprivilege.setAddedby((Long) request.getSession().getAttribute("person_id"));
                            stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                            stafffacilityunitaccessrightprivilege.setStafffacilityunitid(Long.valueOf(unit));
                            stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid(privileges.get(0));
                            Object save = genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);
                        } else if ((Boolean) groupprivilges.get(0)[1] == false) {
                            //back truck
                        }
                    }

                }
            }

            final int groupid = Integer.parseInt(request.getParameter("staffgroupid"));
            final Long person_id = (Long) request.getSession().getAttribute("person_id");
            Runnable myRunnable = new Runnable() {
                @Override
                public void run() {
                    for (String priv : privileges2) {
                        String[] params1 = {"privilegeid"};
                        Object[] paramsValues1 = {Integer.parseInt(priv)};
                        String[] fields1 = {"parentid.systemmoduleid", "status"};
                        List<Object[]> groupsprivs = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fields1, "WHERE privilegeid=:privilegeid", params1, paramsValues1);
                        if (groupsprivs != null) {
                            getparentsystemmodulesprivs2(groupsprivs.get(0)[0], groupid, units, person_id);
                        }
                    }
                }
            };
            Thread thread = new Thread(myRunnable);
            thread.start();

        } catch (Exception e) {
            System.out.println("com.iics.web.LocalAccessRightsManagement.savestaffaddmoreungrantedgroupright()" + e);

        }
        return response;
    }

    private void getparentsystemmodulesprivs2(Object systemmoduleid, int groupid, List<String> units, Long person_id) {
        String[] paramsp = {"systemmoduleid"};
        Object[] paramsValuesp = {systemmoduleid};
        String[] fieldsp = {"parentid.systemmoduleid", "privilegeid"};
        List<Object[]> parentsystemmodules = (List<Object[]>) genericClassService.fetchRecord(Systemmodule.class, fieldsp, "WHERE systemmoduleid=:systemmoduleid", paramsp, paramsValuesp);
        if (parentsystemmodules != null) {
            if (parentsystemmodules.get(0)[1] != null) {
                String[] params1 = {"privilegeid", "accessrightsgroupid", "active"};
                Object[] paramsValues1 = {parentsystemmodules.get(0)[1], groupid, true};
                String[] fields1 = {"accessrightgroupprivilegeid", "facilityprivilegeid"};
                List<Object[]> groupsprivs = (List<Object[]>) genericClassService.fetchRecord(Accessrightgroupprivilege.class, fields1, "WHERE privilegeid=:privilegeid AND accessrightsgroupid=:accessrightsgroupid AND active=:active", params1, paramsValues1);
                if (groupsprivs != null) {
                    for (String unit : units) {
                        String[] params2 = {"accessrightgroupprivilegeid", "stafffacilityunitid"};
                        Object[] paramsValues2 = {groupsprivs.get(0)[0], Long.parseLong(unit)};
                        String[] fields2 = {"stafffacilityunitaccessrightprivilegeid", "active"};
                        List<Object[]> groupsprivs2 = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunitaccessrightprivilege.class, fields2, "WHERE accessrightgroupprivilegeid=:accessrightgroupprivilegeid AND stafffacilityunitid=:stafffacilityunitid", params2, paramsValues2);
                        if (groupsprivs2 == null) {
                            Stafffacilityunitaccessrightprivilege stafffacilityunitaccessrightprivilege = new Stafffacilityunitaccessrightprivilege();
                            stafffacilityunitaccessrightprivilege.setActive(Boolean.TRUE);
                            stafffacilityunitaccessrightprivilege.setAddedby(person_id);
                            stafffacilityunitaccessrightprivilege.setDateadded(new Date());
                            stafffacilityunitaccessrightprivilege.setStafffacilityunitid(Long.valueOf(unit));
                            stafffacilityunitaccessrightprivilege.setAccessrightgroupprivilegeid((Integer) groupsprivs.get(0)[0]);
                            Object save = genericClassService.saveOrUpdateRecordLoadObject(stafffacilityunitaccessrightprivilege);
                        } else if ((Boolean) groupsprivs2.get(0)[1] == false) {
                            //back truck
                        }
                    }

                }
            }
            if (parentsystemmodules.get(0)[0] != null) {
                getparentsystemmodulesprivs2(parentsystemmodules.get(0)[0], groupid, units, person_id);
            }
        }
    }

}
