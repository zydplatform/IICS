/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.service.GenericClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Grace-K
 */
@Controller
@RequestMapping("/Controlpanel")
public class ControlPanel {

    @Autowired
    GenericClassService genericClassService;
    @RequestMapping(value = "/controlpanelmenu", method = RequestMethod.GET)
    public String controlPanelMenu(Model model) {
        return "controlPanel/controlPanelMenu";
    }

    @RequestMapping(value = "/universalpagemenu", method = RequestMethod.GET)
    public String universalPageMenu(Model model) {
        return "controlPanel/universalPanel/universalPanelMenu";
    }
    
       @RequestMapping(value = "/localpagemenu", method = RequestMethod.GET)
    public String localPageMenu(Model model) {
        return "controlPanel/localPanel/localPanelMenu";
    }


    @RequestMapping(value = "/configureandmanage", method = RequestMethod.GET)
    public String configureandmanage(Model model) {
        return "controlPanel/localSettingsPanel/localSettingsMenu";
    }

    @RequestMapping(value = "/loadsuppliermenu", method = RequestMethod.GET)
    public String loadSupplierMenu(Model model) {
        return "controlPanel/universalPanel/externalSuppliers/externalSupplierMenu";
    }
    
    @RequestMapping(value = "/loadItemLists", method = RequestMethod.GET)
    public String loadItemLists(Model model) {
        return "controlPanel/universalPanel/itemLists/itemListPane";
    }
    
    @RequestMapping(value = "/dispensingMenu", method = RequestMethod.GET)
    public String dispensingMenu(Model model) {
        
        return "dispensing/dispensingMenu";
    }
}
