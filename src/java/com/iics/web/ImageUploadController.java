/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.google.common.io.Files;
import com.iics.domain.Facility;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.utils.OsCheck;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.stereotype.Controller;

/**
 *
 * @author samuelwam
 */
@Controller
public class ImageUploadController {
    
@Autowired
GenericClassService genericClassService;  
protected static Log logger = LogFactory.getLog("controller");


    
    @RequestMapping(value = "/uploadUserPhoto.htm", method = RequestMethod.POST)
    public @ResponseBody
    String uploadUserPhoto(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile, @RequestParam("type") String uploadCategory) throws IOException {
        try {
            String url = uploadAttachment(createMyDirectory(uploadCategory), multipartFile, uploadCategory, request);
            request.getSession().setAttribute("sessionUploadedAttachment", url);

            logger.info("Photo Set @ URL:::::" + url);
            return url;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    File file;

    public String uploadAttachment(String directory, MultipartFile photoname, String uploadCategory, HttpServletRequest request) {
        try {
            byte[] bytes = photoname.getBytes();
            String newFileName=photoname.getOriginalFilename();
            
            if(uploadCategory.equals("UserPhotos")){
                long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                Person person = new Person(pid) ;    
                String[] params = {"Id"};
                Object[] paramsValues = {pid};
                List<Object[]> usrObjArr = (List<Object[]>) genericClassService.fetchRecord(Person.class, new String[]{"personid", "firstname", "lastname", "othername"}, "WHERE r.personid=:Id", params, paramsValues);
                if (usrObjArr != null && !usrObjArr.isEmpty()) {
                    for (Object[] obj : usrObjArr) {
                        person.setFirstname((String) obj[1]);
                        person.setLastname((String) obj[2]);
                        person.setOthernames((String) obj[3]);
                    }
                }
                newFileName = person.getFirstname().substring(0, 3) + "_" + person.getLastname().substring(0, 3) + "_" + person.getPersonid()+ "_person_images.jpeg";              
            }
            if(uploadCategory.equals("FacilityLogo")){
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                Facility facObj = new Facility(facilityid) ;    
                String[] params = {"Id"};
                Object[] paramsValues = {facilityid};
                List<Object[]> facObjArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid", "facilityname"}, "WHERE r.facilityid=:Id", params, paramsValues);
                if (facObjArr != null && !facObjArr.isEmpty()) {
                    for (Object[] obj : facObjArr) {
                        facObj.setFacilityname((String) obj[1]);
                    }
                }
                newFileName = facObj.getFacilityname().substring(0, 3)+"_" + facObj.getFacilityid()+  "_logo_images.jpeg";              
            }
            logger.info("newFileName ::::: "+newFileName);
            file = new File(directory + "/" + newFileName);
            Files.write(bytes, file);
            request.getSession().setAttribute("sessionRefAttachedImageRef", newFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file.toString();
    }
        
    public String createMyDirectory(String dir) {
        String subdirectory = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                if (!(new File("C:\\IICS\\Pharmaceuticals\\" + dir + "\\")).exists()) {
                    (new File("C:\\IICS\\Pharmaceuticals\\" + dir + "\\")).mkdirs();
                    subdirectory = "C:\\IICS\\Pharmaceuticals\\" + dir + "\\";
                } else {
                    subdirectory = "C:\\IICS\\Pharmaceuticals\\" + dir + "\\";
                }
                break;
            case "Linux":
                if (!(new File("/home/IICS/Pharmaceuticals/" + dir + "/")).exists()) {
                    (new File("/home/IICS/Pharmaceuticals/" + dir + "/")).mkdirs();
                    subdirectory = "/home/IICS/Pharmaceuticals/" + dir + "/";
                } else {
                    subdirectory = "/home/IICS/Pharmaceuticals/" + dir + "/";
                }
                break;
            case "MacOS":
                if (!(new File("/Users/IICS/Pharmaceuticals/" + dir + "/")).exists()) {
                    (new File("/Users/IICS/Pharmaceuticals/" + dir + "/")).mkdirs();
                    subdirectory = "/Users/IICS/Pharmaceuticals/" + dir + "/";
                } else {
                    subdirectory = "/Users/IICS/Pharmaceuticals/" + dir + "/";
                }
                break;
            default:
                break;
        }
        return subdirectory;
    }
}
