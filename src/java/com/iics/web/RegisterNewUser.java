/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.devicedomain.Computerloghistory;
import com.iics.devicedomain.Deviceregistrationrequest;
import com.iics.domain.Contactdetails;
import com.iics.domain.Designation;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunits;
import com.iics.domain.Person;
import com.iics.domain.Requisition;
import com.iics.domain.Searchstaff;
import com.iics.domain.Staff;
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.Socket;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author IICS PROJECT
 */
@Controller
public class RegisterNewUser {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date = new Date();
    String frmtdDate = dateFormat.format(date);

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    private SecureRandom getRandomNo = new SecureRandom();
    private ArrayList<Object> arrayObj;
    @Autowired
    private JavaMailSender mailSender;
    @Resource(name = "sessionRegistry")
    private SessionRegistryImpl sessionRegistry;
    private static final int BUFFER_SIZE = 4096;
    private final String filePath = "/IICSX.exe";

@RequestMapping(value = "/retrievepersons", method = RequestMethod.GET)
    public String retrievepersons(Model model, HttpServletRequest request) {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        List<Map> aplist = new ArrayList<>();
        
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                for (Long staffid : staff) {
                    String[] params62 = {"staffid","approved"};
                    Object[] paramsValues62 = {staffid,"approved"};
                    String[] fields62 = {"requisitionid", "status", "recommender", "staffid", "links"};
                    String where62 = "WHERE staffid=:staffid AND status=:approved";
                    List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields62, where62, params62, paramsValues62);
                    Map<String, Object> requests2;
                    if (found62 != null) {
                        for (Object[] req : found62) {
                            requests2 = new HashMap<>();
                            if ((String) req[4] == null) {
                                String[] params8 = {"staffid", "currentfacility"};
                                Object[] paramsValues8 = {(Long) req[3], Integer.parseInt(facilityidsession)};
                                String[] fields8 = {"lastname", "othernames", "designationname", "personid", "firstname", "currentfacility"};
                                String where8 = "WHERE staffid=:staffid AND currentfacility=:currentfacility";
                                List<Object[]> found8 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields8, where8, params8, paramsValues8);
                                if (found8 != null) {
                                    Object[] f8 = found8.get(0);
                                    requests2.put("staffid", (Long) req[3]);
                                    String[] paramsr = {"personid"};
                                    Object[] paramsValuesr = {(long) req[2]};
                                    String[] fieldsr = {"firstname", "lastname", "othernames"};
                                    String wherer = "WHERE personid=:personid";
                                    List<Object[]> foundr = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsr, wherer, paramsr, paramsValuesr);
                                    if (foundr != null) {
                                        Object[] f7 = foundr.get(0);
                                        requests2.put("firstname", (String) f7[0]);
                                        requests2.put("lastname", (String) f7[1]);
                                    }
                                    int noOfUnits = 0;
                                    String[] params1 = {"staffid", "active"};
                                    Object[] paramsValues1 = {(Long) req[3], Boolean.TRUE};
                                    String where1 = "WHERE staffid=:staffid AND active=:active";
                                    noOfUnits = genericClassService.fetchRecordCount(Stafffacilityunit.class, where1, params1, paramsValues1);
                                    requests2.put("noOfUnits", noOfUnits);
                                    requests2.put("requisitionid", (Integer) req[0]);
                                    requests2.put("status", (String) req[1]);
                                    requests2.put("personid", (BigInteger) f8[3]);
                                    requests2.put("staffname1", (String) f8[4]);
                                    requests2.put("staffname2", (String) f8[0]);
                                    requests2.put("staffname3", (String) f8[1]);
                                    requests2.put("designationname", (String) f8[2]);
                                    String[] params4 = {"personid", "Email"};
                                    Object[] paramsValues4 = {(BigInteger) f8[3], "EMAIL"};
                                    String[] fields4 = {"contactvalue"};
                                    String where4 = "WHERE personid=:personid AND contacttype=:Email";
                                    List<String> found11 = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields4, where4, params4, paramsValues4);
                                    if (found11 != null) {
                                        String f11 = found11.get(0);
                                        requests2.put("contactvalue", f11);
                                    }
                                }
                                aplist.add(requests2);
                            }

                        }
                    }
                }
            }
        }
        
        model.addAttribute("aplist", aplist);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/RegisterUsertable";
    }
    
    @RequestMapping(value = "/getconfirmedstaffdetails")
    public @ResponseBody
    String getconfirmedstaffdetails(HttpServletRequest request) {
        String results = "";
        List<Map> staffdetails = new ArrayList<>();
        Map<String, Object> staff = new HashMap<>();
        String[] params = {"staffid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("staffid"))};
        System.out.println("" + Long.parseLong(request.getParameter("staffid")));
        String[] fields = {"staffid", "personid.personid", "designationid.designationid", "staffno"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);
        if (found != null) {
            Object[] fStaff = found.get(0);
            staff.put("staffid", Long.parseLong(fStaff[0].toString()));
            staff.put("personid", (Long) fStaff[1]);

            String[] params1 = {"personid"};
            Object[] paramsValues1 = {(Long) (found.get(0)[1])};
            String[] fields111 = {"firstname", "lastname", "facilityid.facilityid"};
            String where1 = "WHERE personid=:personid";
            List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields111, where1, params1, paramsValues1);
            if (found1 != null) {
                Object[] f = found1.get(0);
                staff.put("firstname", (String) f[0]);
                staff.put("lastname", (String) f[1]);
            }
        }
        staffdetails.add(staff);
        try {
            results = new ObjectMapper().writeValueAsString(staffdetails);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RegisterUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/detailsofstaff", method = RequestMethod.GET)
    public String detailsofstaff(Model model, HttpServletRequest request) {
        String personidsession = request.getSession().getAttribute("person_id").toString();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        String[] params = {"staffid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("staffid"))};
        System.out.println("" + Long.parseLong(request.getParameter("staffid")));
        String[] fields = {"staffid", "personid.personid", "designationid.designationid"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);
        if (found != null) {
            Object[] fStaff = found.get(0);
            model.addAttribute("staffid", Long.parseLong(fStaff[0].toString()));
            String[] paramsStaff = {"staffid"};
            Object[] paramsValues1Staff = {(found.get(0)[0])};
            String[] fieldsStaff = {"facilityunitid.facilityunitid", "index"};
            String whereStaff = "WHERE staffid=:staffid";
            List<Object[]> foundStaff = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsStaff, whereStaff, paramsStaff, paramsValues1Staff);
            if (foundStaff != null) {
                Object fstaff = foundStaff.get(0);
                String[] paramsStaff1 = {"facilityunitid"};
                Object[] paramsValues1Staff1 = {(foundStaff.get(0)[0])};
                String[] fieldsStaff1 = {"facilityunitname"};
                String whereStaff1 = "WHERE facilityunitid=:facilityunitid";
                List<String> foundStaff1 = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsStaff1, whereStaff1, paramsStaff1, paramsValues1Staff1);
                if (foundStaff1 != null) {
                    String stafff = foundStaff1.get(0);
                    model.addAttribute("facilityunitname", (String) stafff);
                }
            }
            String[] params1 = {"personid"};
            Object[] paramsValues1 = {(found.get(0)[1])};
            String[] fields1 = {"firstname", "lastname", "facilityid"};
            String where1 = "WHERE personid=:personid";
            List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields1, where1, params1, paramsValues1);
            if (found1 != null) {
                Object[] f = found1.get(0);
                model.addAttribute("firstname", (String) f[0]);
                model.addAttribute("lastname", (String) f[1]);
                // facility name
                String[] params2 = {"facilityid"};
                Object[] paramsValues2 = {(found1.get(0)[2])};
                String[] fields2 = {"facilityname"};
                String where2 = "WHERE facilityid=:facilityid";
                List<String> found2 = (List<String>) genericClassService.fetchRecord(Facility.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {
                    String f1 = found2.get(0);
                    model.addAttribute("facilityname", (String) f1);
                }
            }
            //Designation name
            String[] params3 = {"designationid"};
            Object[] paramsValues3 = {(found.get(0)[2])};
            String[] fields3 = {"designationname"};
            String where3 = "WHERE designationid=:designationid";
            List<String> found2 = (List<String>) genericClassService.fetchRecord(Designation.class, fields3, where3, params3, paramsValues3);
            if (found2 != null) {
                String f = found2.get(0);
                model.addAttribute("designationname", (String) f);
            }
            //contact details
            String[] params4 = {"personid"};
            Object[] paramsValues4 = {(found.get(0)[1])};
            String[] fields4 = {"contactvalue"};
            String where4 = "WHERE personid=:personid";
            List<String> objContactDetails = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields4, where4, params4, paramsValues4);
            if (objContactDetails != null) {
                String f1 = objContactDetails.get(0);
                model.addAttribute("contactvalue", (String) f1);
            }
        }
        return "controlPanel/localSettingsPanel/RegisterUser/views/searchstaff";
    }

    @RequestMapping(value = "/savesystemuser", method = RequestMethod.POST)
    @ResponseBody
    public final String savesystemuser(HttpServletRequest request) throws NoSuchAlgorithmException {
        logger.info("Received request to send Email");
        String results = "";
        Map<String, Object> model = new HashMap<String, Object>();
        String personid = request.getParameter("personid");
        String createdby = request.getSession().getAttribute("person_id").toString();
        boolean active = Boolean.TRUE;
        String usernamew = request.getParameter("staffname1");
        String recipientAddress = request.getParameter("contactvalue");
        String username = "";
        username = request.getParameter("contactvalue");
        String requisitionid = request.getParameter("requisitionid");
        //generate password
        RegisterNewUser passwordGenerator = new RegisterNewUser();
        StringBuilder v = new StringBuilder();
        for (int length = 0; length < 5; length++) {
            v.append(passwordGenerator.generateRandom());
        }
        String Linkpassword = v.toString();
        String passwd2hash = v.toString();
        MessageDigest ulinkx = MessageDigest.getInstance("MD5");
        ulinkx.update(passwd2hash.getBytes());
        byte byteDatax[] = ulinkx.digest();
        StringBuffer pbufferx = new StringBuffer();
        for (int i = 0; i < byteDatax.length; i++) {
            pbufferx.append(Integer.toString((byteDatax[i] & 0xff) + 0x100, 16).substring(1));
        }
        String hashpassword = pbufferx.toString();
        v.setLength(0);

        //String subject = "ACTIVATE YOUR USER CREDENTIALS ";
        String unique = new Date().toString() + requisitionid;
        MessageDigest ulink = MessageDigest.getInstance("MD5");
        ulink.update(unique.getBytes());
        byte byteData[] = ulink.digest();
        StringBuffer pbuffer = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
            pbuffer.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
        String links = pbuffer.toString();
        try {
            String staffname2 = request.getParameter("staffname2");
            String fullname = usernamew.substring(0, 1).toUpperCase() + usernamew.substring(1).toLowerCase() + " " + staffname2.substring(0, 1).toUpperCase() + staffname2.substring(1).toLowerCase();
            Map<String, String> mailDetails = new HashMap<>();
            mailDetails.put("staffnames", fullname);
            mailDetails.put("usernames", username.split("@")[0]);
            mailDetails.put("password", Linkpassword);
            mailDetails.put("facility", getuserFacilityname(BigInteger.valueOf(Long.parseLong(personid))));
            mailDetails.put("receiver", recipientAddress);
            String details = new ObjectMapper().writeValueAsString(mailDetails);

            //Call Mail server.
            Socket mailClient = new Socket(IICS.MAIL_URL, 9009);
            BufferedReader in = new BufferedReader(new InputStreamReader(mailClient.getInputStream()));
            PrintWriter out = new PrintWriter(mailClient.getOutputStream(), true);
            //Get receiver details.
            out.println(details);
            String response = in.readLine();
            System.out.println(response);
            if ("sent".equalsIgnoreCase(response)) {
                System.out.println("Sent message successfully....");
                String[] columns = {"links"};
                Object[] columnValues = {links};
                String pk = "requisitionid";
                Object pkValue = Integer.parseInt(requisitionid);
                Object k = genericClassService.updateRecordSQLSchemaStyle(Requisition.class, columns, columnValues, pk, pkValue, "public");
                if (k != null) {
                    Systemuser dcategory = new Systemuser();
                    //save systemuser
                    dcategory.setPassword(hashpassword);
                    dcategory.setUsername(username.split("@")[0]);
                    dcategory.setPersonid(new Person(Long.parseLong(personid)));
                    dcategory.setCreatedby(new Person(Long.parseLong(createdby)));
                    dcategory.setActive(active);
                    dcategory.setDatecreated(new Date());
                    genericClassService.saveOrUpdateRecordLoadObject(dcategory);
                }
            } else {
                results = "This link cannot be sent due to a poor Internet connection.Please check your connection and try again.";
            }
        } catch (IOException | NumberFormatException ex) {
            System.out.println(ex);
            results = "This link cannot be sent due to a poor Internet connection.Please check your connection and try again.";
        }
        return results;
    }

    @RequestMapping(value = "/downloads.htm", method = RequestMethod.GET)
    public void doDownload(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // get absolute path of the application
        ServletContext context = request.getSession().getServletContext();
        String appPath = context.getRealPath("");

        // construct the complete absolute path of the file
        String fullPath = getExecutablePath();
        File downloadFile = new File(fullPath);
        FileInputStream inputStream = new FileInputStream(downloadFile);

        // get MIME type of the file
        String mimeType = context.getMimeType(fullPath);
        if (mimeType == null) {
            // set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }

        // set content attributes for the response
        response.setContentType(mimeType);
        response.setContentLength((int) downloadFile.length());
        //else nem = Base64Enc.encode("192.168.2.5:8084");
        // set headers for the response
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"",
                downloadFile.getName());
        response.setHeader(headerKey, headerValue);

        // get output stream of the response
        OutputStream outStream = response.getOutputStream();

        byte[] buffer = new byte[BUFFER_SIZE];
        int bytesRead = -1;

        // write bytes read from the input stream into the output stream
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }

        inputStream.close();
        outStream.close();
    }

    static String addEnc(String st) {

        Random rand = new Random();
        int randomInt = 0;
        if (st.contains("=")) {
            String st1 = st.substring(0, st.indexOf("="));
            randomInt = rand.nextInt(st1.length());
        } else {
            randomInt = rand.nextInt(st.length());
        }
        StringBuilder buf = new StringBuilder(st);
        String ins = RandomStringUtils.randomAlphabetic(1);
        buf.insert(randomInt, ins);
        int ples = buf.indexOf("=");
        if (ples > 0) {
            buf.insert(ples, String.valueOf(randomInt) + String.valueOf(randomInt).length());
        } else {
            buf.insert(buf.length(), String.valueOf(randomInt) + String.valueOf(randomInt).length());
        }
        return buf.toString();
    }

    public String remEnc(String st) {
        try {
            int ples = st.indexOf("=");
            if (ples > 0) {
                int ss = st.charAt(st.indexOf("=") - 1);
                String st1 = st.substring(0, st.lastIndexOf(ss));
                String newString = deleteCharAt(st, Integer.parseInt(st1.substring(st1.length() - Character.getNumericValue(ss))));
                st = newString.replaceAll(st1.substring(st1.length() - Character.getNumericValue(ss)) + Character.getNumericValue(ss), "");
            } else {
                int ss = st.charAt(st.length() - 1);
                String st1 = st.substring(0, st.lastIndexOf(ss));
                String newString = deleteCharAt(st, Integer.parseInt(st1.substring(st1.length() - Character.getNumericValue(ss))));
                st = newString.replaceAll(st1.substring(st1.length() - Character.getNumericValue(ss)) + Character.getNumericValue(ss), "");
            }
            byte[] decodedStr = DatatypeConverter.parseBase64Binary(st);

            st = new String(decodedStr, "utf-8");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return st;
    }

    private static String deleteCharAt(String strValue, int index) {
        return strValue.substring(0, index) + strValue.substring(index + 1);
    }

    @RequestMapping(value = "/serverinfo", method = RequestMethod.POST)
    public @ResponseBody
    String serverinfo(HttpServletRequest request, @ModelAttribute("mac") String mac, @ModelAttribute("ip") String ip, @ModelAttribute("hostname") String hostname, @ModelAttribute("motherBoard_SerialNumber") String motherBoard_SerialNumber, @ModelAttribute("detectedOS") String detectedOS) {
        String mac_address = mac;
        String[] params = {"macaddress"};
        Object[] paramsValues = {mac_address};
        String[] fields = {"macaddress"};
        String where = "WHERE macaddress=:macaddress";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, fields, where, params, paramsValues);
        if (found == null) {
            try {
                Computerloghistory log = new Computerloghistory();
                log.setAccessdate(new Date());
                log.setComputername(hostname);
                log.setIpaddress(ip);
                log.setIsregistered(false);
                log.setMacaddress(mac_address);
                log.setDevice("Client Device");
                log.setSentrequest(true);
                log.setRegistereduser(true);
                log.setOperatingsystem(detectedOS);
                log.setActive(true);
                log.setUseragent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36");
                Object logx = genericClassService.saveOrUpdateRecordLoadObject(log);
                if (logx != null) {
                    Deviceregistrationrequest devicerequest = new Deviceregistrationrequest();
                    long comp = log.getComputerloghistoryid();
                    devicerequest.setIsregistered(false);
                    devicerequest.setDaterequested(new Date());
                    devicerequest.setSerialnumber(motherBoard_SerialNumber);
                    devicerequest.setComputerlogid(comp);
                    devicerequest.setRequestnote("Good Condition");
                    devicerequest.setOperatingsystem(detectedOS);
                    genericClassService.saveOrUpdateRecordLoadObject(devicerequest);
                }
            } catch (Exception ex) {
                System.out.println(ex);
            }
        } else {
            try {
                Computerloghistory oldlog = new Computerloghistory();
                oldlog.setAccessdate(new Date());
                oldlog.setComputername(hostname);
                oldlog.setIpaddress(ip);
                oldlog.setIsregistered(false);
                oldlog.setMacaddress(mac_address);
                oldlog.setDevice("Client Device");
                oldlog.setSentrequest(true);
                oldlog.setRegistereduser(true);
                oldlog.setOperatingsystem(detectedOS);
                oldlog.setActive(true);
                oldlog.setUseragent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36");
                genericClassService.saveOrUpdateRecordLoadObject(oldlog);
            } catch (Exception ex) {
                System.out.println(ex);
            }
        }
        return "saved";
    }

    public String getExecutablePath() {
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                path = "C:/IICS/IICS.exe";
                break;
            case "Linux":
                path = "/home/iics/Tomcat/IICS.exe";
                break;
            case "MacOS":
                path = "/Users/IICS/documents/IICS.exe";
                break;
            default:
                break;
        }
        return path;
    }

    public RegisterNewUser() {
        arrayObj = new ArrayList<>();
        for (char c = '0'; c <= '9'; c++) {// add digits 0–9
            arrayObj.add(c);
        }
        for (char c = '@'; c <= 'Z'; c++) {// add uppercase A–Z and '@'
            arrayObj.add(c);
        }
        for (char c = 'a'; c <= 'z'; c++) {//add lowercase a–z
            arrayObj.add(c);
        }
        Collections.rotate(arrayObj, 5);
    }

    public char generateRandom() {
        char paswdChar = (char) this.arrayObj.get(getRandomNo.nextInt(this.arrayObj.size()));
        return paswdChar;
    }

    private String getuserFacilityname(BigInteger prsnid) {
        String facilityName = "";
        String[] params = {"personid"};
        Object[] paramsValues = {prsnid};
        String[] fields = {"staffid", "currentfacility"};
        String where = "WHERE personid=:personid";
        List<Object[]> facilityObj = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        if (facilityObj != null) {
            int staffFacilityid = Integer.parseInt(facilityObj.get(0)[1].toString());
            String[] paramsx = {"facilityid"};
            Object[] paramsValuesx = {staffFacilityid};
            String[] fieldsx = {"facilityid", "facilityname"};
            String wherex = "WHERE facilityid=:facilityid";
            List<Object[]> facilitynameObj = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldsx, wherex, paramsx, paramsValuesx);
            if (facilitynameObj != null) {
                facilityName = String.valueOf(facilitynameObj.get(0)[1]);
            }
        }
        return facilityName;
    }

    @RequestMapping(value = "/Viewunitslist", method = RequestMethod.GET)
    public String Viewunitslist(Model model, HttpServletRequest request) {
        String staffid = request.getParameter("staffid");
        List<Map> staffunits = new ArrayList<>();

        String[] params61 = {"staffid","active"};
        Object[] paramsValues61 = {BigInteger.valueOf(Long.parseLong(staffid)),Boolean.TRUE};
        String[] fields61 = {"facilityunitid", "facilityunitname", "active"};
        String where61 = "WHERE staffid=:staffid AND active=:active";
        List<Object[]> found61 = (List<Object[]>) genericClassService.fetchRecord(Facilityunits.class, fields61, where61, params61, paramsValues61);
        Map<String, Object> staffunitnames;

        if (found61 != null) {
            for (Object[] req1 : found61) {
                staffunitnames = new HashMap<>();
                staffunitnames.put("facilityunitid", (BigInteger) req1[0]);
                staffunitnames.put("facilityunitname", (String) req1[1]);
                staffunits.add(staffunitnames);
            }
        }
        model.addAttribute("staffunits", staffunits);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/confirmstaffunits";
    }
}
