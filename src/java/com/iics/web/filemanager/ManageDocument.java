/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.filemanager;

import com.iics.filemanger.DocumentModel;
import com.iics.filemanger.Filepage;
import com.iics.service.GenericClassService;
import com.iics.service.filemanager.DocumentScannerService;
import com.iics.service.filemanager.Filemanagerservicelocator;
import com.iics.service.filemanager.ManageDocumentService;
import com.iics.utils.OsCheck;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import uk.co.mmscomputing.device.scanner.Scanner;




/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/files")
public class ManageDocument {
    HttpSession session;
  //Filemanagerservicelocator f= Filemanagerservicelocator.getInstance();
  private @Autowired ManageDocumentService manageDocumentService;
  boolean  returnValue=false;
  private @Autowired  GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
// Handling multiple files upload request
@RequestMapping(value = "/pagelist", method = RequestMethod.GET)
public String viewDocuments(HttpServletRequest request,@ModelAttribute("pname") String pname,@ModelAttribute("fileno") String fileno,Model model) {
     List<Map> filePages=manageDocumentService.fetchFilePages(fileno,genericClassService);
     model.addAttribute("fileno",fileno);
     model.addAttribute("filePages",filePages);
     model.addAttribute("filelength", manageDocumentService.getfileLength());
     session = request.getSession();
     session.setAttribute("fileno",fileno);
     session.setAttribute("pname",pname);
      manageDocumentService.getAllAssignmentIds(genericClassService);
  return "fileManagement/views/managefile/patientfilePages";
     }
    //Resource banner = resourceLoader.getResource("file:c:/temp/filesystemdata.txt");
   @RequestMapping(value = "/scandocumentorimage.htm", method = RequestMethod.GET )
    public @ResponseBody String scandocumentorimage(Model model,
    @ModelAttribute("pageNumber") int pageNumber,
    @ModelAttribute("totalPages") int totalPages,HttpServletRequest request) {
    String pageTitle="";
    Scanner scanner=null;
    String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
    String realPathtoUploads =request.getSession().getServletContext().getRealPath("/resources/");
    //String realPathtoUploads =request.getSession().getServletContext().getRealPath("file:D:/Markpaul/MultipleFileUpload/img/05_images.png");
   // System.out.println(realPathtoUploads);
    String fileno = request.getSession().getAttribute("fileno").toString();
       pageTitle= request.getParameter("filename");
       String filelength= request.getParameter("filelength");
       DocumentScannerService scannerObject=null;
        String patientFlder="photos/patient/"+fileno.replaceAll("/","")+"/";
        
        String link=pageTitle.replaceAll("\\s+","").replaceAll("-","").toLowerCase()+pageNumber+ ".png";
        System.out.println("This is my link: "+link);
         String documentid="";
        if(pageNumber==1){
        boolean saveStaus= saveDocument(fileno,pageTitle,staffidsession);       
       if(saveStaus){
        documentid=  session.getAttribute("documentid").toString();
      // scannerObject =new DocumentScannerService(scanner,link,baseDir+patientFlder);
        }else{
        System.out.println("failed To create New file Document"); 
        }
        }else{
        //Scann page
       documentid=  session.getAttribute("documentid").toString();
      // scannerObject =new DocumentScannerService(scanner,link,baseDir+patientFlder);
      }
       
       /* while(!scannerObject.isFileStaus()){
           try {
            // thread to sleep for 3000 milliseconds
            Thread.sleep(3000);
         } catch (Exception e) {
            System.out.println(e.getMessage());
         }
           System.out.println("Waiting");
        }*/
         File source = new File("D:/IICS PROJECT/pic.png");
        File dest = new File(createorreturndirectory(patientFlder)+link);
         //copy files using apache commons io
        //copy file conventional way using Stream
        long start = System.nanoTime();
        start = System.nanoTime();
        try{
        copyFileUsingApacheCommonsIO(source, dest);
        }catch(Exception e){
        System.out.println(e.getMessage());
        }
        System.out.println("Time taken by Apache Commons IO Copy = "+(System.nanoTime()-start));
      
        boolean  pageStatus= savePage(Long.parseLong(documentid),patientFlder+link,filelength);
        return String.valueOf(pageNumber);
}
        //Resource banner = resourceLoader.getResource("file:c:/temp/filesystemdata.txt");
   @RequestMapping(value = "/rescandocumentorimage.htm", method = RequestMethod.GET )
    public @ResponseBody String reScandocumentorimage(Model model,
    @ModelAttribute("pageNumber") int pageNumber,@ModelAttribute("pageid") String pageid,
    @ModelAttribute("fileno")String fileno,HttpServletRequest request) {
    String pageTitle="";
   
    Scanner scanner=null;
    String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
    String realPathtoUploads =request.getSession().getServletContext().getRealPath("/resources/");
    //String realPathtoUploads =request.getSession().getServletContext().getRealPath("file:D:/Markpaul/MultipleFileUpload/img/05_images.png");
   // System.out.println(realPathtoUploads);
       pageTitle= request.getParameter("filename");
       DocumentScannerService scannerObject=null;
       String patientFlder="photos/patient/"+fileno.replaceAll("/","")+"/";
        String link=pageTitle.replaceAll("\\s+","").replaceAll("-","").toLowerCase()+pageNumber+ ".png";
        System.out.println("This is my link: "+link);
       /* while(!scannerObject.isFileStaus()){
           try {
            // thread to sleep for 3000 milliseconds
            Thread.sleep(3000);
         } catch (Exception e) {
            System.out.println(e.getMessage());
         }
           System.out.println("Waiting");
        }*/
       String baseDir="";
     boolean  pageStatus= saveReScannedPage(Long.parseLong(pageid),link,patientFlder,baseDir);
        return String.valueOf(pageNumber);
}
 private boolean saveDocument(String fileno,String pageTitle ,String staffidsession){
                 //save the image here
                DocumentModel doc = new DocumentModel();
                doc.setFileno(fileno);
                doc.setDocname(pageTitle);
                doc.setStaffid(Long.parseLong(staffidsession));
                doc.setDescription(pageTitle);
                try{
                    
                doc.setDatecreated(formatter.parse(formatter.format(new Date())));
                }catch(Exception e){
                    System.out.println(e.getMessage());
                }
               doc = (DocumentModel) genericClassService.saveOrUpdateRecordLoadObject(doc);
               if (doc != null) {
                  session.setAttribute("documentid",String.valueOf(doc.getDocumentid()));
                   return true;
                    }else{ 
                   return false;
                }
    }
  private boolean savePage(long documentid,String link,String filelength){
  Filepage page = new Filepage();
  page.setDoctumentid(documentid);
  page.setLink(link);
  page.setPagenumber(String.valueOf(Integer.parseInt(filelength)+1));
   page = (Filepage) genericClassService.saveOrUpdateRecordLoadObject(page);
               if ( page != null) {
                   return true;
                    }else{ 
                   return false;
   }
} 
   private boolean saveReScannedPage(long pageid,String link,String folder,String baseDir){
      
        try {
            File file = new File(baseDir+folder+link);
            if (file.delete()) {
                System.out.println("Success: " + file.getName() + " is deleted!");
            } else {
                System.out.println("Failed: Delete operation is failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
  
        File source = new File("D:/IICS PROJECT/mark.png");
        File dest = new File(baseDir+folder+link);
         //copy files using apache commons io
        //copy file conventional way using Stream
        long start = System.nanoTime();
        start = System.nanoTime();
        try{
        copyFileUsingApacheCommonsIO(source, dest);
        }catch(Exception e){
        System.out.println(e.getMessage());
        }
        System.out.println("Time taken by Apache Commons IO Copy = "+(System.nanoTime()-start));
       boolean results=false;
       String pk = "pageid";
                 String[] columns = {"link"};
                    Object[] columnValues = {folder+link};
                    Object pkValue = pageid;
                    int upadetPageStatusid = -1;
                    upadetPageStatusid = genericClassService.updateRecordSQLSchemaStyle(Filepage.class, columns, columnValues, pk, pkValue, "patient");
                    if (upadetPageStatusid != -1) {
                        results = true;
                    } else {
                        results =false;
                    } 
                    return results;
} 
private static void copyFileUsingApacheCommonsIO(File source, File dest) throws IOException {
    FileUtils.copyFile(source, dest);
}
@RequestMapping(value = "/pagedetail", method = RequestMethod.GET)
public String viewDocumentFiles(HttpServletRequest request,
        @ModelAttribute("documentid") String documentid,
        @ModelAttribute("description") String description,
        @ModelAttribute("datecreated") String datecreated,
        @ModelAttribute("filelength") String filelength,
        Model model) {
    String fileno = request.getSession().getAttribute("fileno").toString();
    String pname = request.getSession().getAttribute("pname").toString();
    List<Map> filePageDetailList=manageDocumentService.fetchPageDetails(documentid,genericClassService);
    model.addAttribute("filePageDetailList",filePageDetailList);
    model.addAttribute("fileno",fileno);
    model.addAttribute("description",description);
    model.addAttribute("datecreated",datecreated);
    model.addAttribute("filelength",filelength);
    model.addAttribute("documentid",documentid);
    model.addAttribute("pname",pname);
return "fileManagement/views/managefile/patientFileViewer";
}
  public String createorreturndirectory(String dir) {
        String subdirectory = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                if (!(new File("C:/IICS/PHARMACETICALS/" + dir + "/")).exists()) {
                    (new File("C:/IICS/PHARMACETICALS/" + dir)).mkdirs();
                    subdirectory = "C:/IICS/PHARMACETICALS/" + dir;
                } else {
                   subdirectory = "C:/IICS/PHARMACETICALS/" + dir;
                }
                break;
            case "Linux":
                if (!(new File("/home/iics/static/" + dir + "/")).exists()) {
                    (new File("/home/iics/static/" + dir + "/")).mkdirs();
                    subdirectory = "/home/iics/static/" + dir + "/";
                } else {
                    subdirectory = "/home/iics/static/" + dir + "/";
                }
                break;
            case "MacOS":
                if (!(new File("/Users/iics/static/" + dir + "/")).exists()) {
                    (new File("/Users/iics/static/" + dir + "/")).mkdirs();
                    subdirectory = "/Users/iics/static/" + dir + "/";
                } else {
                    subdirectory = "/Users/iics/static/" + dir + "/";
                }
                break;
            default:
                break;
        }
        return subdirectory;
    }
}

