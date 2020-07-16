/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Facilityunitsupplier;
import com.iics.domain.Facilityunit;
import com.iics.service.GenericClassService;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/nominateinternalfacilitySupplier")
public class NominateInternalFacilitySupplier {

    @Autowired
    GenericClassService genericClassService;
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/nominateinternalfacilitysupplierhome.htm", method = RequestMethod.GET)
    public String nominateinternalfacilitysupplierhome(Model model, HttpServletRequest request) {
        Set<Long> nominatedunits = new HashSet<>();
        Set<Long> submittedorrejected = new HashSet<>();
        List<Map> nominatedlist = new ArrayList<>();
        List<Facilityunit> unnominatedlist = new ArrayList<>();
        String[] params = {"status", "isactive", "facilityunitid", "suppliertype"};
        Object[] paramsValues = {"approved", Boolean.TRUE, Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "internal"};
        String[] fields = {"facilityunitsupplierid", "supplierid"};
        List<Object[]> facilityunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields, "WHERE status=:status AND isactive=:isactive AND facilityunitid=:facilityunitid AND suppliertype=:suppliertype", params, paramsValues);
        if (facilityunit != null) {
            Map<String, Object> nomintedRow;
            for (Object[] funit : facilityunit) {
                nomintedRow = new HashMap<>();
                String[] params1 = {"facilityunitid"};
                Object[] paramsValues1 = {(Long) funit[1]};
                String[] fields1 = {"facilityunitname", "shortname"};
                List<Object[]> facilityunitdetails = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                if (facilityunitdetails != null) {
                    nominatedunits.add((Long) funit[1]);
                    Object[] fucilityunitdets = facilityunitdetails.get(0);
                    nomintedRow.put("facilityunitname", (String) fucilityunitdets[0]);
                    nomintedRow.put("shortname", (String) fucilityunitdets[1]);
                    nomintedRow.put("facilityunitsupplierid", (int) funit[0]);
                    nominatedlist.add(nomintedRow);
                }
            }
        }
        String[] params4 = {"value", "value2", "isactive", "facilityunitid", "suppliertype"};
        Object[] paramsValues4 = {"submitted", "rejected", Boolean.FALSE, Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "internal"};
        String[] fields4 = {"facilityunitsupplierid", "supplierid"};
        List<Object[]> facilityunit4 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields4, "WHERE status=:value OR status=:value2 AND isactive=:isactive AND facilityunitid=:facilityunitid AND suppliertype=:suppliertype", params4, paramsValues4);
        if (facilityunit4 != null) {
            for (Object[] funit4 : facilityunit4) {
                submittedorrejected.add((Long) funit4[1]);
            }
        }
        String[] params3 = {"facilityid", "active", "facilityunitid"};
        Object[] paramsValues3 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE, Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields3 = {"facilityunitid", "facilityunitname", "shortname"};
        List<Object[]> facilityunit3 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields3, "WHERE facilityid=:facilityid AND active=:active AND facilityunitid !=:facilityunitid", params3, paramsValues3);
        if (facilityunit3 != null) {
            for (Object[] funit : facilityunit3) {
                if (!nominatedunits.contains((Long) funit[0]) && !submittedorrejected.contains((Long) funit[0])) {
                    Facilityunit facilityunit1 = new Facilityunit();
                    facilityunit1.setFacilityunitname((String) funit[1]);
                    facilityunit1.setFacilityunitid((Long) funit[0]);
                    facilityunit1.setShortname((String) funit[2]);
                    unnominatedlist.add(facilityunit1);
                }
            }
        }
        model.addAttribute("nominatedlist", nominatedlist);
        model.addAttribute("unnominatedlist", unnominatedlist);
        return "controlPanel/localSettingsPanel/supplierAndStores/facilityStores/facilityStoresHome";
    }

    @RequestMapping(value = "/saveorupdatefacilityunitsnominations.htm")
    public @ResponseBody
    String saveorupdatefacilityunitsnominations(Model model, HttpServletRequest request) {
        String results = "";
        try {
            if ("nominate".equals(request.getParameter("type"))) {
                List<String> nominate = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (String item1 : nominate) {
                    String[] params = {"status", "isactive", "supplierid", "facilityunitid"};
                    Object[] paramsValues = {"approved", Boolean.FALSE, Long.parseLong(item1), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                    String[] fields = {"facilityunitsupplierid"};
                    List<Integer> facilityunit = (List<Integer>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields, "WHERE status=:status AND isactive=:isactive AND supplierid=:supplierid AND facilityunitid=:facilityunitid", params, paramsValues);
                    if (facilityunit != null) {
                        String[] columns = {"status", "isactive", "lastupdated", "lastupdatedby"};
                        Object[] columnValues = {"submitted", Boolean.FALSE, new Date(), (Long) request.getSession().getAttribute("person_id")};
                        String pk = "facilityunitsupplierid";
                        Object pkValue = facilityunit.get(0);
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitsupplier.class, columns, columnValues, pk, pkValue, "controlpanel");

                    } else {
                        Facilityunitsupplier facilityunitsupplier = new Facilityunitsupplier();
                        facilityunitsupplier.setAddedby((Long) request.getSession().getAttribute("person_id"));
                        facilityunitsupplier.setDateadded(new Date());
                        facilityunitsupplier.setSuppliertype("internal");
                        facilityunitsupplier.setSupplierid(Long.parseLong(item1));
                        facilityunitsupplier.setStatus("submitted");
                        facilityunitsupplier.setFacilityunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                        facilityunitsupplier.setIsactive(Boolean.FALSE);
                        genericClassService.saveOrUpdateRecordLoadObject(facilityunitsupplier);
                    }
                }
            } else if ("remove".equals(request.getParameter("type"))) {
                List<String> remove = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (String item1 : remove) {
                    String[] columns = {"isactive", "lastupdated", "lastupdatedby"};
                    Object[] columnValues = {Boolean.FALSE, new Date(), (Long) request.getSession().getAttribute("person_id")};
                    String pk = "facilityunitsupplierid";
                    Object pkValue = Integer.parseInt(item1);
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitsupplier.class, columns, columnValues, pk, pkValue, "controlpanel");

                }
            }
        } catch (IOException e) {
        }

        return results;
    }

    @RequestMapping(value = "/approvedorunapprovednominatedinternalsuppliers.htm", method = RequestMethod.GET)
    public String approvedorunapprovednominatedinternalsuppliers(Model model, HttpServletRequest request) {
        String result_view = "";
        if ("unapproved".equals(request.getParameter("type"))) {
            List<Map> unapproved = new ArrayList<>();
            String[] params = {"status", "isactive", "suppliertype"};
            Object[] paramsValues = {"submitted", Boolean.FALSE, "internal"};
            String[] fields = {"facilityunitsupplierid", "supplierid", "facilityunitid"};
            List<Object[]> facilityunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields, "WHERE status=:status AND isactive=:isactive AND suppliertype=:suppliertype", params, paramsValues);
            if (facilityunit != null) {
                Map<String, Object> unapprovedRow;
                for (Object[] funit : facilityunit) {
                    unapprovedRow = new HashMap<>();
                    String[] params3 = {"facilityunitid"};
                    Object[] paramsValues3 = {(Long) funit[1]};
                    String[] fields3 = {"facilityunitname", "shortname"};
                    List<Object[]> facilityunit3 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields3, "WHERE facilityunitid=:facilityunitid", params3, paramsValues3);

                    String[] params4 = {"facilityunitid"};
                    Object[] paramsValues4 = {(Long) funit[2]};
                    String[] fields4 = {"facilityunitname", "shortname"};
                    List<Object[]> facilityunit4 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, "WHERE facilityunitid=:facilityunitid", params4, paramsValues4);

                    if (facilityunit3 != null && facilityunit4 != null) {
                        Object[] funit3 = facilityunit3.get(0);
                        Object[] funit4 = facilityunit4.get(0);
                        unapprovedRow.put("facilityunitsupplierid", (int) funit[0]);
                        unapprovedRow.put("facilityunitname_supplier", (String) funit3[0]);
                        unapprovedRow.put("facilityunitname_client", (String) funit4[0]);
                        unapprovedRow.put("shortname_client", (String) funit4[1]);
                        unapprovedRow.put("shortname_supplier", (String) funit3[1]);
                        unapproved.add(unapprovedRow);
                    }
                }
            }
            model.addAttribute("unapprovedinternalsupplier", unapproved);
            result_view = "controlPanel/localSettingsPanel/supplierAndStores/facilityStores/views/approveNominatedInternalSupplier";
        } else {
            List<Map> approved = new ArrayList<>();
            String[] params = {"status", "isactive", "suppliertype"};
            Object[] paramsValues = {"approved", Boolean.TRUE, "internal"};
            String[] fields = {"facilityunitsupplierid", "supplierid", "facilityunitid"};
            List<Object[]> facilityunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields, "WHERE status=:status AND isactive=:isactive AND suppliertype=:suppliertype", params, paramsValues);
            if (facilityunit != null) {
                Map<String, Object> approvedRow;
                for (Object[] funit : facilityunit) {
                    approvedRow = new HashMap<>();
                    String[] params3 = {"facilityunitid"};
                    Object[] paramsValues3 = {(Long) funit[1]};
                    String[] fields3 = {"facilityunitname", "shortname"};
                    List<Object[]> facilityunit3 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields3, "WHERE facilityunitid=:facilityunitid", params3, paramsValues3);

                    String[] params4 = {"facilityunitid"};
                    Object[] paramsValues4 = {(Long) funit[2]};
                    String[] fields4 = {"facilityunitname", "shortname"};
                    List<Object[]> facilityunit4 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, "WHERE facilityunitid=:facilityunitid", params4, paramsValues4);

                    if (facilityunit3 != null && facilityunit4 != null) {
                        Object[] funit3 = facilityunit3.get(0);
                        Object[] funit4 = facilityunit4.get(0);
                        approvedRow.put("facilityunitsupplierid", (int) funit[0]);
                        approvedRow.put("facilityunitname_supplier", (String) funit3[0]);
                        approvedRow.put("facilityunitname_client", (String) funit4[0]);
                        approvedRow.put("shortname_client", (String) funit4[1]);
                        approvedRow.put("shortname_supplier", (String) funit3[1]);
                        approved.add(approvedRow);
                    }
                }
            }
            model.addAttribute("approvedinternalsupplier", approved);
            result_view = "controlPanel/localSettingsPanel/supplierAndStores/facilityStores/forms/removeApprovedInternalSupplier";
        }
        return result_view;
    }

    @RequestMapping(value = "/approvenominatedinternalfacilitysupplier.htm")
    public @ResponseBody
    String approvenominatedinternalfacilitysupplier(Model model, HttpServletRequest request) {
        String results = "";
        if ("approve".equals(request.getParameter("type"))) {
            String[] columns = {"status", "isactive", "lastupdated", "lastupdatedby"};
            Object[] columnValues = {"approved", Boolean.TRUE, new Date(), (Long) request.getSession().getAttribute("person_id")};
            String pk = "facilityunitsupplierid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitsupplierid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitsupplier.class, columns, columnValues, pk, pkValue, "controlpanel");
            if (result != 0) {
                results = "success";
            }
        } else if ("reject".equals(request.getParameter("type"))) {
            String[] columns = {"status", "isactive", "lastupdated", "lastupdatedby","approvalcomment"};
            Object[] columnValues = {"rejected", Boolean.FALSE, new Date(), (Long) request.getSession().getAttribute("person_id"),request.getParameter("reason")};
            String pk = "facilityunitsupplierid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitsupplierid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitsupplier.class, columns, columnValues, pk, pkValue, "controlpanel");
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }
}
