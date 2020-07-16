/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.general;

/**
 *
 * @author Ndenzi Gilbert
 *
 * processes a captured image and writes it to the file system
 */
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.service.PersonService;
import com.iics.utils.OsCheck;
import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//-------------------Rest Client------------
import java.io.File;
import java.security.Principal;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
//-----------------------------------------

@Controller
@RequestMapping("/photoProcess.htm")
public class PhotoCaptureController {

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(method = RequestMethod.GET)
    public void setupForm(Model model, HttpServletRequest request) {
    }

//    @RequestMapping(method = RequestMethod.POST)
//    @SuppressWarnings("CallToThreadDumpStack")
//    public void submitForm(Model model, HttpServletRequest request, Principal principal) throws IOException, Exception {
//        BufferedInputStream bis = null;
//        FileOutputStream fos = null;
//        
//        try {
//            if (principal == null) {
//                MainController controller = new MainController();
//                controller.exit(request);
//            }
//            
//            bis = new BufferedInputStream(request.getInputStream());
//
//            request.getSession().setAttribute("bis", bis);
//
//            request.getSession().setAttribute("personimage", null);
//            String prefix = "";
//            
//            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
//            Person person = new Person(pid) ;    
//            String[] params = {"Id"};
//            Object[] paramsValues = {pid};
//            List<Object[]> usrObjArr = (List<Object[]>) genericClassService.fetchRecord(Person.class, new String[]{"personid", "firstname", "lastname", "othername"}, "WHERE r.personid=:Id", params, paramsValues);
//            if (usrObjArr != null && !usrObjArr.isEmpty()) {
//                for (Object[] obj : usrObjArr) {
//                    person.setFirstname((String) obj[1]);
//                    person.setLastname((String) obj[2]);
//                    person.setOthername((String) obj[3]);
//                }
//            }
//                prefix = person.getFirstname().substring(0, 3) + "_" + person.getLastname().substring(0, 3) + "_" + person.getPersonid();              
//
//            String newS = "";
//
//            System.out.println("Os type::" + OsCheck.getOperatingSystemType());
//
//            //creating image temporary storage directory on windows machine
//            if (OsCheck.getOperatingSystemType().toString().equals("Windows")) {
//                (new File("C:\\IICS\\SchoolMate\\UserPhotos\\")).mkdirs();
//                newS = "C:\\IICS\\SchoolMate\\UserPhotos\\";
//                System.out.println("reaching here>>>>");
//            } else if (OsCheck.getOperatingSystemType().toString().equals("Linux")) {
//                 (new File("/home/IICS/SchoolMate/UserPhotos/")).mkdirs();
//                   newS = "/home/IICS/SchoolMate/UserPhotos/"; 
//            } else if (OsCheck.getOperatingSystemType().toString().equals("MacOS")) {
//                 (new File("/Users/IICS/SchoolMate/UserPhotos")).mkdirs();
//                 newS = "/Users/IICS/SchoolMate/UserPhotos/";             
//            }
//
//            String photoUploadDirectory = newS + prefix + "_person_images.jpeg";
//
//            fos = new FileOutputStream(new File(photoUploadDirectory));
//
//            byte[] bs = new byte[0x400];
//            int len;
//
//            while ((len = bis.read(bs, 0x0, bs.length)) != 0xffffffff) {
//                fos.write(bs, 0x0, len);
//            }
//            logger.info("Shot Sessioned @::: "+prefix + "_person_images.jpeg");
//            request.getSession().setAttribute("sessionRefAttachedImageRef", prefix + "_person_images.jpeg");
//            request.getSession().setAttribute("personimageJPEG", photoUploadDirectory);
//            bis.close();
//            fos.close();
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//    }

    private static final Logger LOG = Logger.getLogger(PhotoCaptureController.class
            .getName());
}
