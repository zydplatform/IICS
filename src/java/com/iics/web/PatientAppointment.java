/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.service.GenericClassService;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author user
 */
@Controller
@RequestMapping("/patientappoint")
public class PatientAppointment {
    @Autowired
    GenericClassService genericClassService;
    @RequestMapping(value = "/patientappointments.htm", method = RequestMethod.GET)
    public String patientappointments(Model model, HttpServletRequest request) {
        System.out.println("-------------------Testing this-----------------------");
        return "patientsManagement/patientappointment/views/test";
    }
}
