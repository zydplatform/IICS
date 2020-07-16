/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.service.GenericClassService;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/bothermedicines")
public class BrotherMedicines {
    
    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
    
    @RequestMapping(value = "/brotherMedicinesHome", method = RequestMethod.GET)
    public String dispensingmenu(HttpServletRequest request, Model model) {

        return "controlPanel/universalPanel/essentialmedicine/brotherMedicines/views/viewMedicineGroups";
    }
}
