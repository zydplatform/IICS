/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.filemanager;

import com.iics.service.GenericClassService;
import com.iics.service.filemanager.ManageDocumentService;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



/**
 *
 * @author user
 */
@Controller
@RequestMapping("/filepages") 
public class ManageFilePage {
private @Autowired  ManageDocumentService manageDocumentService;
  private @Autowired  GenericClassService genericClassService;   
@RequestMapping(value = "/pagelist2", method = RequestMethod.GET)
public String viewFilePages(HttpServletRequest request,@ModelAttribute("fileno") String fileno,Model model) {
     List<Map> filePages=manageDocumentService.fetchFilePages(fileno,genericClassService);
     model.addAttribute("fileno",fileno);
     System.out.println(fileno);
     model.addAttribute("filePages",filePages);
    // String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
   // List<Map> fu = manageLocationService.fetchAllFacilityUnits(Integer.parseInt(facilityidsession));
     //model.addAttribute("fu",fu);
     return "fileManagement/views/filefold/patientfilePages";
     }
@RequestMapping(value = "/pagedetail", method = RequestMethod.GET)
public String viewPageDetail(HttpServletRequest request,@ModelAttribute("pageid") String pageid,Model model) {
   // List<Map> filePageDetails=manageDocumentService.fetchPageDetails(pageid);
    //model.addAttribute("filePageDetails",filePageDetails);
    return "patientsManagement/views/files/filePageDetails";
     }
 
  
}
