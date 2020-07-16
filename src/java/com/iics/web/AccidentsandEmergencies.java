/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.service.GenericClassService;
import java.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Kiganda Ivan
 */
@Controller
@RequestMapping(value="/accidentsandEmergencies")
public class AccidentsandEmergencies {
    @Autowired
    GenericClassService genericclassservice;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    
     //accidents and emergencies
    @RequestMapping(value="/accidentsemergenciesmenu.htm",method=RequestMethod.GET)
    public String accidentsEmergenciesMenu(Model model){
        return "accidentsEmergencies/accidentsEmergenciesMenu";
    }

}
