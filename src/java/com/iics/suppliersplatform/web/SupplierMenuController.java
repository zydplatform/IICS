/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.web;

import com.iics.service.GenericClassService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Controller
@RequestMapping("Supplier/Menu")
public class SupplierMenuController {
    
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    @RequestMapping(value = "/mainMenu", method = RequestMethod.GET)
    public String controlPanelMenu(Model model) {
        return "SupplierPlatform/supplierMainMenu";
    }
    
}
