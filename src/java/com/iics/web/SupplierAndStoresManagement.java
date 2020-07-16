/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.domain.Facilityunitservice;
import com.iics.service.GenericClassService;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/supplierandstoresmanagement")
public class SupplierAndStoresManagement {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/supplierandstoresmanagementhomemenu.htm", method = RequestMethod.GET)
    public String SupplierAndStoresManagement(Model model, HttpServletRequest request) {
        String isStores = "no";
        String[] params = {"facilityunit"};
        Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"facilityservices.serviceid", "facilityservices.servicekey"};
        String where = "WHERE r.facilityunit.facilityunitid=:facilityunit";
        List<Object[]> facilityunitservicesLists = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
        if (facilityunitservicesLists != null) {
            for (Object[] facilityunitservice : facilityunitservicesLists) {
                if ("key_suppliyunitstore".equals((String) facilityunitservice[1])) {
                    isStores = "yes";
                }
            }
        }
        model.addAttribute("isstoresunit", isStores);
        return "controlPanel/localSettingsPanel/supplierAndStores/supplierAndStoresHomeMenu";
    }
}
