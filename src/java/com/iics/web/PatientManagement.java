/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Contactdetails;
import com.iics.domain.Facility;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Facilityunitservicesview;
import com.iics.domain.Person;
import com.iics.patient.Patient;
import com.iics.patient.Searchpatient;
import com.iics.service.GenericClassService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.iics.domain.Locations;
import com.iics.domain.Personlanguage;
import com.iics.domain.Searchstaff;
import com.iics.domain.Spokenlanguages;
import com.iics.domain.Staff;
import com.iics.domain.Village;
import com.iics.patient.Facilityvisitno;
import com.iics.patient.Medicalissue;
import com.iics.patient.Patientmedicalissue;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Patientvisit;
import com.iics.patient.Patientvisits;
import com.iics.patient.Registrarpatients;
import com.iics.patient.Servicequeue;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import static com.iics.web.Stock.loadFileAsBytesArray;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Grace-K
 */
@Controller
@RequestMapping("/patient")
public class PatientManagement {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formatterwithtime = new SimpleDateFormat("E, dd MMM yyyy HH:mm aa");
    SimpleDateFormat df = new SimpleDateFormat("yyyy");
    private final SimpleDateFormat formatterwithtime2 = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private final Date serverDate = new Date();

    @RequestMapping(value = "/patientmenu", method = RequestMethod.GET)
    public String patientMainMenu(HttpServletRequest request, Model model) {
        return "patientsManagement/PatientMenu";
    }

    @RequestMapping(value = "/patientvisits", method = RequestMethod.GET)
    public String searchPatient(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            int facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            int totalpatientvisit = 0;
            int totalpatientvisitbelow5 = 0;
            int totalpatientvisit5to12 = 0;
            int totalpatientvisit13andabove = 0;

            long totalpatientsMale = 0;
            long totalpatientsFemale = 0;

            int staffTotalPatients = 0;

            String[] paramspatienttotvisits = {"facilityid", "dateadded"};
            Object[] paramsValuespatienttot = {facilityId, new Date()};
//            String wherepatienttot = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//            Object[] paramsValuespatienttot = {facilityId, formatter.format(new Date())}; 
//            String wherepatienttot = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
            String wherepatienttot = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded";
//          Commented out because it produces a wrong count. Replaced with code below.
            // totalpatientvisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot);
            List<Object[]> totalpatientvisitList = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, new String[]{"COUNT(DISTINCT r.patientid)"}, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot, 0, 0);
            if (totalpatientvisitList != null) {
                totalpatientvisit = Integer.parseInt(String.valueOf(totalpatientvisitList.get(0)));
            }
            //
            String[] paramsstaffTotalPatients = {"facilityid", "dateadded", "addedby"};
//            Object[] paramsValuesstaffTotalPatients = {facilityId, formatter.format(new Date()), BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("person_id").toString()))}; 
//            String wherestaffTotalPatients = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND addedby=:addedby";
            Object[] paramsValuesstaffTotalPatients = {facilityId, new Date(), BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("person_id").toString()))};
            String wherestaffTotalPatients = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND addedby=:addedby";
            List<Object[]> totalstaffTotalPatients = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, new String[]{"COUNT(DISTINCT r.patientid)"}, wherestaffTotalPatients, paramsstaffTotalPatients, paramsValuesstaffTotalPatients, 0, 0);
            if (totalstaffTotalPatients != null) {
                staffTotalPatients = Integer.parseInt(String.valueOf(totalstaffTotalPatients.get(0)));
            }
            //
            String[] paramspatientgender = {"facilityid", "dateadded"};
            Object[] paramsValuespatiengender = {facilityId, new Date()};
//            Object[] paramsValuespatiengender = {facilityId, formatter.format(new Date())};
//          Commented out because it produces duplicates. Replaced with code below it.
//            String[] fields5patientgender = {"COUNT(r.patientvisitid)", "r.gender"};
//            List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, fields5patientgender, "WHERE facilityid=:facilityid AND dateadded=:dateadded GROUP BY r.gender", paramspatientgender, paramsValuespatiengender, 0, 0);
            String[] fields5patientgender = {"COUNT(DISTINCT r.patientid)", "r.gender"};
//            List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, fields5patientgender, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded GROUP BY r.gender", paramspatientgender, paramsValuespatiengender, 0, 0);
            List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, fields5patientgender, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded GROUP BY r.gender", paramspatientgender, paramsValuespatiengender, 0, 0);
            if (objpatientgender != null) {
                for (Object[] patienttotgender : objpatientgender) {
                    if ("Female".equals((String) patienttotgender[1])) {
                        totalpatientsFemale = (long) patienttotgender[0];
                        continue;
                    }
                    if ("Male".equals((String) patienttotgender[1])) {
                        totalpatientsMale = (long) patienttotgender[0];
                    }
                }
            }

            String[] paramspatienttotvisitsage = {"facilityid", "dateadded"};
            Object[] paramsValuespatienttotage = {facilityId, new Date()};
//            Object[] paramsValuespatienttotage = {facilityId, formatter.format(new Date())};
//            Commented Out Because It Produces Duplicates.
//            String[] fields5patienttotage = {"patientvisitid", "dob"};
            String[] fields5patienttotage = {"patientno", "dob"};
//            List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patienttotage, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", paramspatienttotvisitsage, paramsValuespatienttotage);
            List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patienttotage, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", paramspatienttotvisitsage, paramsValuespatienttotage);
            if (objpatienttotage != null) {
                for (Object[] patienttotage : objpatienttotage) {

                    int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                    int currentyear = Integer.parseInt(df.format(new Date()));
                    int estimatedage = currentyear - year;
                    if (estimatedage < 5) {
                        totalpatientvisitbelow5 = totalpatientvisitbelow5 + 1;
                    }

                    if (estimatedage >= 5 && estimatedage <= 12) {
                        totalpatientvisit5to12 = totalpatientvisit5to12 + 1;
                    }

                    if (estimatedage >= 13) {
                        totalpatientvisit13andabove = totalpatientvisit13andabove + 1;
                    }
                }
            }

            model.addAttribute("totalpatientsFemale", totalpatientsFemale);
            model.addAttribute("totalpatientsMale", totalpatientsMale);
            model.addAttribute("totalpatientvisit", totalpatientvisit);
            model.addAttribute("totalpatientvisitbelow5", totalpatientvisitbelow5);
            model.addAttribute("totalpatientvisit5to12", totalpatientvisit5to12);
            model.addAttribute("totalpatientvisit13andabove", totalpatientvisit13andabove);
            //
            model.addAttribute("stafftotalpatients", staffTotalPatients);
            model.addAttribute("staffpersonid", BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("person_id").toString())));
            model.addAttribute("facilityid", facilityId);
            //
        }
        return "patientsManagement/views/searchPatient";
    }

    @RequestMapping(value = "/registernewpatient", method = RequestMethod.GET)
    public String registerNewPatient(HttpServletRequest request, Model model, @ModelAttribute("patientname") String patientNameSearch) {
        String facid;
        int facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
        int facilityIdnew = (int) (Math.log10(facilityId) + 1);
        if (facilityIdnew == 1) {
            facid = "00" + facilityId;
        } else {
            facid = "0" + facilityId;
        }

        String patientpin = generatepatientPINs(facid, facilityId);
        model.addAttribute("currentid", patientpin);

        String[] newPatientNames = patientNameSearch.split(" ");
        for (int i = 0; i < newPatientNames.length; i++) {
            if (newPatientNames.length == 1) {
                model.addAttribute("patientFirstName", newPatientNames[0]);
            } else if (newPatientNames.length == 2) {
                model.addAttribute("patientFirstName", newPatientNames[0]);
                model.addAttribute("patientLastName", newPatientNames[1]);
            } else {
                model.addAttribute("patientFirstName", newPatientNames[0]);
                model.addAttribute("patientLastName", newPatientNames[1]);
                model.addAttribute("patientOtherName", newPatientNames[2]);
            }
        }
        model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
        
        
        
        //spoken languages
        List<Map> languageList = new ArrayList<>();

        //fetching 
        String[] params = {"archived"};
        Object[] paramvalues = {Boolean.FALSE};
        String[] fields = {"languageid", "languagename"};
        String where = "WHERE r.archived=:archived";

        List<Object[]> languages = (List<Object[]>) genericClassService.fetchRecord(Spokenlanguages.class, fields, where, params, paramvalues);
        Map<String, Object> lang;
        if (languages != null) {
            for (Object[] language : languages) {
                lang = new HashMap<>();
                lang.put("languageid", language[0]);
                lang.put("languagename", (String) language[1]);

                languageList.add(lang);

            }
        }
      
        model.addAttribute("languagelist", languageList);
        return "patientsManagement/forms/registerNewPatient";
    }

    @RequestMapping(value = "/searchPatient", method = RequestMethod.POST)
    public String searchPatient(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        List<Map> patients = new ArrayList<>();

        String[] params = {"othernames", "permutation"};
        Object[] paramsValues = {searchValue.replace(" ", "").toLowerCase() + "%", searchValue.replace(" ", "").toLowerCase() + "%"};
        String[] fields = {"personid", "othernames", "lastname", "firstname", "patientno", "currentaddress", "patientid", "telephone", "nextofkin", "nextofkincontact"};
        String where = "WHERE telephone LIKE :othernames OR patientno LIKE :othernames OR permutation1 LIKE :permutation OR permutation2 LIKE :permutation OR permutation3 LIKE :permutation OR permutation2 LIKE :othernames ORDER BY firstname, lastname, othernames";
        List<Object[]> objPatient = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, where, params, paramsValues);
        Map<String, Object> pat;
        if (objPatient != null) {
            for (Object[] patientobj : objPatient) {
                pat = new HashMap<>();
                pat.put("personid", (BigInteger) patientobj[0]);
                pat.put("othernames", (String) patientobj[1]);
                pat.put("lastname", (String) patientobj[2]);
                pat.put("firstname", (String) patientobj[3]);
                pat.put("pin", (String) patientobj[4]);
                pat.put("patientid", (BigInteger) patientobj[6]);
                pat.put("contact", (String) patientobj[7]);

                pat.put("nxtofkin", (String) patientobj[8]);
                pat.put("nxtofkincontact", (String) patientobj[9]);
                patients.add(pat);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("patients", patients);
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("resultsCount", patients.size());
        return "patientsManagement/views/patientSearchResults";
    }

    @RequestMapping(value = "/searchedPatientDetails", method = RequestMethod.GET)
    public @ResponseBody
    String searchedPatientDetails(HttpServletRequest request, Model model, @ModelAttribute("personid") String personid) {
        String jsonqtylist = "";
        Map<String, Object> patSearchedDetails = new HashMap<>();

        //Retrive Person Details
        String[] parampersn = {"personid"};
        Object[] paramsValuepersn = {Integer.parseInt(personid)};
        String wherepersn = "WHERE personid=:personid";
        String[] fieldspersn = {"dob", "gender", "maritalstatus", "nin", "nationality", "registrationpoint", "currentaddress"};
        List<Object[]> objpersn = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
        if (objpersn != null) {
            Object[] personOtherDetails = objpersn.get(0);
            try {
                patSearchedDetails.put("dob", formatter.format((Date) personOtherDetails[0]));
                patSearchedDetails.put("gender", (String) personOtherDetails[1]);

                if (personOtherDetails[2] != null && personOtherDetails[2] != "") {
                    patSearchedDetails.put("maritalstatus", (String) personOtherDetails[2]);
                } else {
                    patSearchedDetails.put("maritalstatus", "");
                }

                if (personOtherDetails[3] != null && personOtherDetails[3] != "") {
                    patSearchedDetails.put("nin", (String) personOtherDetails[3]);
                } else {
                    patSearchedDetails.put("nin", "");
                }

                patSearchedDetails.put("nationality", (String) personOtherDetails[4]);
            } catch (Exception ex) {
                System.out.println(ex);
            }
            //Retrive Location Details
            String[] paramsvill2 = {"villageid"};
            Object[] paramsValuesvilla2 = {personOtherDetails[6]};
            String wherevilla2 = "WHERE villageid=:villageid";
//            String[] fieldsvilla2 = {"villageid", "villagename"};
            String[] fieldsvilla2 = {"villageid", "villagename", "parishid", "parishname"};
            List<Object[]> objPersonVillage2 = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fieldsvilla2, wherevilla2, paramsvill2, paramsValuesvilla2);
            if (objPersonVillage2 != null) {
                Object[] personlocationInfo2 = objPersonVillage2.get(0);
                patSearchedDetails.put("village", (String) personlocationInfo2[1]);
                //
                patSearchedDetails.put("parish", personlocationInfo2[3].toString());
                //

                String[] paramsdist = {"villageid"};
                Object[] paramsValuesdistr = {personlocationInfo2[0]};
                String wheredistri = "WHERE villageid=:villageid";
                String[] fieldsdistr = {"districtid", "districtname"};
                List<Object[]> objPersonDistict11 = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fieldsdistr, wheredistri, paramsdist, paramsValuesdistr);
                if (objPersonDistict11 != null) {
                    Object[] personlocationDistri = objPersonDistict11.get(0);
                    patSearchedDetails.put("districtname", (String) personlocationDistri[1]);
                }
            }
        }
        try {
            jsonqtylist = new ObjectMapper().writeValueAsString(patSearchedDetails);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsonqtylist;
    }

    @RequestMapping(value = "/checkpatientexists", method = RequestMethod.POST)
    public @ResponseBody
    String checkPatientExists(HttpServletRequest request) {
        String result = "false";
        try {
            String maritalstatus2 = request.getParameter("maritalstatus2");
            String firstname = request.getParameter("firstname2");
            String lastname = request.getParameter("lastname2");
            String othername2 = request.getParameter("othername2");
            String nin2 = request.getParameter("nin2");
            String gender2 = request.getParameter("gender2");
            String dob = request.getParameter("dateOfBirth2");
            Date date = formatter.parse(dob.replaceAll("/", "-"));
            String[] fields = {"firstname", "lastname", "othernames", "nin", "dob", "maritalstatus", "gender"};
            String[] params = {"firstname", "lastname", "othernames", "nin", "dob", "maritalstatus", "gender"};
            Object[] paramsValues = {firstname, lastname, othername2, nin2, date, maritalstatus2, gender2};
            String where = "WHERE firstname=:firstname AND lastname=:lastname AND othernames=:othernames AND nin=:nin AND dob=:dob AND maritalstatus=:maritalstatus AND gender=:gender";
            List<Object[]> patientList = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields, where, params, paramsValues);
            result = (patientList == null) ? "false" : "true";
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/savenewpatient", method = RequestMethod.POST)
    public String saveNewPatient(Model model, HttpServletRequest request,@ModelAttribute("languageIds") String ids) throws IOException{
        Patient newPatient;
        String patientNo = "";
        Long patientid = (long) 0;
        Map<String, Object> newPatientDetails = new HashMap<>();
        Person person = new Person();
        String maritalstatus2 = request.getParameter("maritalstatus2");
        String firstname = request.getParameter("firstname2");
        String lastname = request.getParameter("lastname2");
        String pin = request.getParameter("pin2");
        int facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
        String othername2 = request.getParameter("othername2");
        String phoneno2 = request.getParameter("phoneno2");
        String nin2 = request.getParameter("nin2");
        String nextofkinphone2 = request.getParameter("nextofkinphone2");
        String gender2 = request.getParameter("gender2");
        String nationality2 = request.getParameter("nationality2");
        int village2 = Integer.parseInt(request.getParameter("village3"));
        String nextofkinname2 = request.getParameter("nextofkinname2");
        String nextofkinrelationship2 = request.getParameter("nextofkinrelationship2");
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        List<Map> facilityUnits = new ArrayList<>();

        try {
            String dob = request.getParameter("dateOfBirth2");
            Date date = formatter.parse(dob.replaceAll("/", "-"));
            person.setDob(date);
        } catch (ParseException ex) {
            System.out.println(ex);
        }

        try {
            person.setFirstname(firstname);
            person.setLastname(lastname);
            if (othername2 != null) {
                person.setOthernames(othername2);
            }
            person.setGender(gender2);
            person.setNin(nin2);
            person.setNationality(nationality2);
            person.setFacilityid(new Facility(facilityId));
            person.setCurrentaddress(new Village(village2));
            person.setNin(nin2);
            person.setNationality(nationality2);
            person.setMaritalstatus(maritalstatus2);
            person.setRegistrationpoint(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            person = (Person) genericClassService.saveOrUpdateRecordLoadObject(person);
             newPatientDetails.put("fname", person.getFirstname());
            newPatientDetails.put("lname", person.getLastname());
            if (person.getOthernames() != null) {
                newPatientDetails.put("oname", person.getOthernames());
            } else {
                newPatientDetails.put("oname", "");
            }
        } catch (NumberFormatException ex) {
            System.out.println(ex);
        }

        if (person.getPersonid() != null) {
            ///savelanguages
            Personlanguage newlanguage;
            ObjectMapper mapper = new ObjectMapper();
            try {
            List<Object> rm = mapper.readValue(ids, List.class);
                for (Object k : rm) {
                newlanguage = new Personlanguage();
                int languageid = Integer.parseInt( k.toString());
                BigInteger personid = BigInteger.valueOf((Long)person.getPersonid());
                newlanguage.setLanguageid(languageid);
                newlanguage.setPersonid(personid);
                Object savedlanguages = genericClassService.saveOrUpdateRecordLoadObject(newlanguage);
                if (savedlanguages != null) {
            //
            newPatient = new Patient();
            newPatient.setPatientno(pin);
            newPatient.setFacilityid(facilityId);
            newPatient.setDatecreated(new Date());
            newPatient.setPersonid(person.getPersonid());
            if (phoneno2 != null && phoneno2.length() > 0) {
                newPatient.setTelephone(phoneno2);
            } else {
                newPatient.setTelephone(null);
            }
            newPatient.setNextofkinname(nextofkinname2);
            newPatient.setRelationship(nextofkinrelationship2);
            newPatient.setNextofkincontact(nextofkinphone2);
            newPatient.setCreatedby(BigInteger.valueOf(currStaffId));
            newPatient = (Patient) genericClassService.saveOrUpdateRecordLoadObject(newPatient);
            if (newPatient != null) {
                patientid = newPatient.getPatientid();
                patientNo = newPatient.getPatientno();
            }
            }
       
    }
        }catch(Exception e){e.printStackTrace();}
}
        
        List<Map> medicalIssues = new ArrayList<>();
        Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        String name = person.getFirstname() + " " + person.getLastname() + " " + person.getOthernames();

        //Get facility units
        String[] params2 = {"facilityid", "administrative"};
        Object[] paramsValues2 = {facilityId, false};
        String[] fields2 = {"facilityunitid", "facilityunitname"};
        String where2 = "WHERE facilityid=:facilityid AND administrative=:administrative";
        List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2, where2, params2, paramsValues2);
        if (units != null) {
            Map<String, Object> unit;
            for (Object[] u : units) {
                unit = new HashMap<>();
                unit.put("id", u[0]);
                unit.put("name", u[1]);
                facilityUnits.add(unit);
            }
        }

        //Get Patient Issues
        String[] params = {"patientid"};
        Object[] paramsValues = {patientid};
        String[] fields = {"medicalissue.medicalissueid", "medicalissuestate"};
        String where = "WHERE patientid=:patientid";
        List<Object[]> issues = (List<Object[]>) genericClassService.fetchRecord(Patientmedicalissue.class, fields, where, params, paramsValues);
        if (issues != null) {
            Map<String, Object> issue;
            for (Object[] sue : issues) {
                issue = new HashMap<>();
                issue.put("id", sue[0]);
                issue.put("key", sue[1]);
                medicalIssues.add(issue);
            }
        }
        String issueKeys = "[]";
        try {
            issueKeys = new ObjectMapper().writeValueAsString(medicalIssues);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }

        model.addAttribute("staffid", currStaffId);
        model.addAttribute("facilityunits", facilityUnits);

        model.addAttribute("pin", patientNo);
        model.addAttribute("patientid", patientid);
        model.addAttribute("issueKeys", issueKeys);
        model.addAttribute("currentUnit", facilityUnit);
        model.addAttribute("name", name.replace("novalue", ""));
        model.addAttribute("visitno", getVisitNumber(facilityUnit));
        //
        model.addAttribute("facilityid", facilityId);
        model.addAttribute("isnewpatient", Boolean.TRUE);
        //
        return "patientsManagement/forms/patientVisitForm";
    }

    @RequestMapping(value = "/updatevillage", method = RequestMethod.POST)
    public @ResponseBody
    String updateVilage(Model model, HttpServletRequest request) {
        Long updatepersonid = Long.parseLong(request.getParameter("personid"));
        int updatevillage = Integer.parseInt(request.getParameter("village"));
        String[] columns = {"currentaddress"};
        Object[] columnValues = {updatevillage};
        String pk = "personid";
        Object pkValue = updatepersonid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updatePin", method = RequestMethod.POST)
    public @ResponseBody
    String updatePin(Model model, HttpServletRequest request) {
        Long updatepatientid = Long.parseLong(request.getParameter("patientid"));
        String updtPin = request.getParameter("updatepin");

        String[] columns = {"patientno"};
        Object[] columnValues = {updtPin};
        String pk = "patientid";
        Object pkValue = updatepatientid;
        genericClassService.updateRecordSQLSchemaStyle(Patient.class, columns, columnValues, pk, pkValue, "patient");
        return "";
    }

    @RequestMapping(value = "/updateFname", method = RequestMethod.POST)
    public @ResponseBody
    String updateFname(Model model, HttpServletRequest request) {
        Long updatepersonid = Long.parseLong(request.getParameter("personid"));
        String updatefname = request.getParameter("updatefname");

        String[] columns = {"firstname"};
        Object[] columnValues = {updatefname};
        String pk = "personid";
        Object pkValue = updatepersonid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updateLname", method = RequestMethod.POST)
    public @ResponseBody
    String updateLname(Model model, HttpServletRequest request) {
        Long updatepersonid = Long.parseLong(request.getParameter("personid"));
        String updatelname = request.getParameter("updatelname");

        String[] columns = {"lastname"};
        Object[] columnValues = {updatelname};
        String pk = "personid";
        Object pkValue = updatepersonid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updateOname", method = RequestMethod.POST)
    public @ResponseBody
    String updateOname(Model model, HttpServletRequest request) {
        Long updatepersonid = Long.parseLong(request.getParameter("personid"));
        String updateOthername = request.getParameter("updateOname");

        String[] columns = {"othernames"};
        Object[] columnValues = {updateOthername};
        String pk = "personid";
        Object pkValue = updatepersonid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updateGender", method = RequestMethod.POST)
    public @ResponseBody
    String updateGender(Model model, HttpServletRequest request) {
        Long updatepersonid = Long.parseLong(request.getParameter("personid"));
        String updateGender = request.getParameter("updateGender");

        String[] columns = {"gender"};
        Object[] columnValues = {updateGender};
        String pk = "personid";
        Object pkValue = updatepersonid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updatecontact", method = RequestMethod.POST)
    public @ResponseBody
    String updateContact(Model model, HttpServletRequest request) {
        Long patientid = Long.parseLong(request.getParameter("patientid"));
        String telephone = request.getParameter("patientContact");

        String[] columns = {"telephone"};
        Object[] columnValues = {telephone};
        String pk = "patientid";
        Object pkValue = patientid;
        genericClassService.updateRecordSQLSchemaStyle(Patient.class, columns, columnValues, pk, pkValue, "patient");
        return "";
    }

    @RequestMapping(value = "/updatedob", method = RequestMethod.POST)
    public @ResponseBody
    String updateDob(Model model, HttpServletRequest request) {
        Long personid = Long.parseLong(request.getParameter("personid"));

        try {
            String updatedob = request.getParameter("patientdobedit");
            Date dateofbirth = formatter.parse(updatedob.replaceAll("/", "-"));
            String[] columns = {"dob"};
            Object[] columnValues = {dateofbirth};
            String pk = "personid";
            Object pkValue = personid;
            genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    @RequestMapping(value = "/updatenationality", method = RequestMethod.POST)
    public @ResponseBody
    String updateNationality(Model model, HttpServletRequest request) {
        Long personid = Long.parseLong(request.getParameter("personid"));
        String nationalityedit = request.getParameter("nationalityedit");

        String[] columns = {"nationality"};
        Object[] columnValues = {nationalityedit};
        String pk = "personid";
        Object pkValue = personid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updatemaritalstatus", method = RequestMethod.POST)
    public @ResponseBody
    String updateMaritalstatus(Model model, HttpServletRequest request) {
        Long personid = Long.parseLong(request.getParameter("personid"));
        String nationalityedit = request.getParameter("maritalstatusedit");

        String[] columns = {"maritalstatus"};
        Object[] columnValues = {nationalityedit};
        String pk = "personid";
        Object pkValue = personid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updateNIN", method = RequestMethod.POST)
    public @ResponseBody
    String updateNIN(Model model, HttpServletRequest request) {
        Long personid = Long.parseLong(request.getParameter("personid"));
        String ninedit = request.getParameter("ninedit");

        String[] columns = {"nin"};
        Object[] columnValues = {ninedit};
        String pk = "personid";
        Object pkValue = personid;
        genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/updatenextofkin", method = RequestMethod.POST)
    public @ResponseBody
    String updateNextOfKin(Model model, HttpServletRequest request) {
        try {
            String updatenextofkinfullname = request.getParameter("nextOfKinFullName");
            String updatenextofkinrelationship = request.getParameter("nextofkinrelationship");
            String nextOfKinPhoneUpdt = request.getParameter("nextOfKinPhoneUpdt");
            Long patientid = Long.parseLong(request.getParameter("patientid"));

            if (updatenextofkinfullname != null) {
                String[] columns = {"nextofkinname", "relationship", "nextofkincontact"};
                Object[] columnValues = {updatenextofkinfullname, updatenextofkinrelationship, nextOfKinPhoneUpdt};
                String pk = "patientid";
                Object pkValue = patientid;
                genericClassService.updateRecordSQLSchemaStyle(Patient.class, columns, columnValues, pk, pkValue, "patient");
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    private String generatepatientPINs(String facilityid, int facilty) {
        String name = facilityid + "/";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String pattern = name + f.format(new Date()) + "/%";
        String patientnumber = "";

        String[] params = {"facilityid", "patientno"};
        Object[] paramsValues = {facilty, pattern};
        String[] fields = {"patientno"};
        String where = "WHERE facilityid=:facilityid AND patientno LIKE :patientno ORDER BY patientno DESC LIMIT 1";
        List<String> lastFacilityPatientno = (List<String>) genericClassService.fetchRecord(Patient.class, fields, where, params, paramsValues);
        if (lastFacilityPatientno == null) {
            patientnumber = name + f.format(new Date()) + "/0001";
            return patientnumber;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilityPatientno.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        patientnumber = name + f.format(new Date()) + "/000" + newNo;
                        break;
                    case 2:
                        patientnumber = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 3:
                        patientnumber = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        patientnumber = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return patientnumber;
    }

    @RequestMapping(value = "/manageregisteredpatientdetails", method = RequestMethod.GET)
    public String manageRegisteredPatientDetails(HttpServletRequest request, Model model) throws ParseException {
        Date now, actualdob;
        String personGender = null;
        String patientFullNames = request.getParameter("patientFullNames");
        String firstname = request.getParameter("pFirstName");
        String lastname = request.getParameter("pLastName");
        String patPin = request.getParameter("patPin");
        String othername = request.getParameter("pOtherName");
        String pNxtofkinphonecontact = request.getParameter("pNxtofkinphonecontact");
        long personid = Long.parseLong(request.getParameter("personid"));
        String pNxtfullname = request.getParameter("pNxtfullname");
        String pRelationship = request.getParameter("pRelationship");
        String pDistrict = request.getParameter("pDistrict");
        String pContact = request.getParameter("pContact");
        String residenceVill = request.getParameter("residenceVill");
        //
        String residenceParish = request.getParameter("residenceparish");
        //
        String dob = request.getParameter("dob");
        long patientid = Long.parseLong(request.getParameter("patientid"));

        String pNin = request.getParameter("pNin");
        String pNationality = request.getParameter("pNationality");
        String pMaritalstatus = request.getParameter("pMaritalstatus");

        String[] paramsPergender = {"personid"};
        Object[] paramsValuesPergender = {personid};
        String wherePergender = "WHERE personid=:personid";
        String[] fieldsPergender = {"gender", "registrationpoint", "facilityid.facilityid"};
        List<Object[]> objPergender = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPergender, wherePergender, paramsPergender, paramsValuesPergender);
        if (objPergender != null) {
            Object[] per = objPergender.get(0);
            personGender = (String) per[0];

            String[] paramsregpoint = {"facilityunitid"};
            Object[] paramsValuesregpoint = {(long) per[1]};
            String whereregpoint = "WHERE facilityunitid=:facilityunitid";
            String[] fieldsregpoint = {"facilityunitname"};
            List<String> regpoint = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsregpoint, whereregpoint, paramsregpoint, paramsValuesregpoint);
            if (regpoint != null) {
                model.addAttribute("registrationpoint", regpoint.get(0));
            }

            String[] paramsregfacilty = {"facilityid"};
            Object[] paramsValuesregfacilty = {(Integer) per[2]};
            String whereregfacilty = "WHERE facilityid=:facilityid";
            String[] fieldsregfacilty = {"facilityname"};
            List<String> regfacilty = (List<String>) genericClassService.fetchRecord(Facility.class, fieldsregfacilty, whereregfacilty, paramsregfacilty, paramsValuesregfacilty);
            if (regfacilty != null) {
                model.addAttribute("facilityname", regfacilty.get(0));
            }
        }

        //Staff Details
        String[] paramcreatedby = {"patientid"};
        Object[] paramsValuescreatedby = {patientid};
        String wherecreatedby = "WHERE patientid=:patientid";
        String[] fieldscreatedby = {"createdby", "datecreated"};
        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Patient.class, fieldscreatedby, wherecreatedby, paramcreatedby, paramsValuescreatedby);
        if (createdby != null) {
            Object[] objcretby = createdby.get(0);
            model.addAttribute("datecreated", formatterwithtime.format((Date) objcretby[1]));

            if (objcretby[0] != null) {
                String[] paramsstaff = {"staffid"};
                Object[] paramsValuesstaff = {objcretby[0]};
                String wherestaff = "WHERE staffid=:staffid";
                String[] fieldstaff = {"personid.personid"};
                List<Long> objstaff = (List<Long>) genericClassService.fetchRecord(Staff.class, fieldstaff, wherestaff, paramsstaff, paramsValuesstaff);
                if (objstaff != null) {
                    Long personstaff = objstaff.get(0);

                    String[] paramsPerDetails = {"personid"};
                    Object[] paramsValuesPerDetails = {personstaff};
                    String wherePerDetails = "WHERE personid=:personid";
                    String[] fieldsPerDetails = {"firstname", "lastname", "othernames"};
                    List<Object[]> objPerDetails = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPerDetails, wherePerDetails, paramsPerDetails, paramsValuesPerDetails);
                    if (objPerDetails != null) {
                        Object[] PerDetails = objPerDetails.get(0);
                        if (PerDetails[2] != null) {
                            String createdbyname = (String) PerDetails[0] + " " + PerDetails[1] + " " + PerDetails[2];
                            model.addAttribute("createdby", createdbyname);
                        } else {
                            String createdbyname = (String) PerDetails[0] + " " + PerDetails[1];
                            model.addAttribute("createdby", createdbyname);
                        }
                    }
                }
            }
        }

        model.addAttribute("patientid", patientid);
        model.addAttribute("personid", personid);
        model.addAttribute("patientfullnames", patientFullNames);
        model.addAttribute("firstname", firstname);
        model.addAttribute("lastname", lastname);
        model.addAttribute("patPin", patPin);
        model.addAttribute("pDistrict", pDistrict);
        model.addAttribute("residenceparish", residenceParish);
        if ("".equals(othername) || othername == null) {
            model.addAttribute("othername", "novalue");
        } else {
            model.addAttribute("othername", othername);
        }

        if ("".equals(residenceVill)) {
            model.addAttribute("residenceVill", "novalue");
        } else {
            model.addAttribute("residenceVill", residenceVill);
        }

        if ("".equals(pNxtfullname)) {
            model.addAttribute("pNxtfullname", "novalue");
        } else {
            model.addAttribute("pNxtfullname", pNxtfullname);
            model.addAttribute("pRelationship", pRelationship);
            model.addAttribute("pNxtofkinphonecontact", pNxtofkinphonecontact);
        }

        if ("".equals(pMaritalstatus) || pMaritalstatus == null) {
            model.addAttribute("pMaritalstatus", "novalue");
        } else {
            model.addAttribute("pMaritalstatus", pMaritalstatus);
        }

        if ("".equals(pNationality)) {
            model.addAttribute("pNationality", "novalue");
        } else {
            model.addAttribute("pNationality", pNationality);
        }

        if ("".equals(pNin) || pNin == null) {
            model.addAttribute("pNin", "novalue");
        } else {
            model.addAttribute("pNin", pNin);
        }

        if ("".equals(dob)) {
            model.addAttribute("dob", "novalue");
        } else {
            try {
                now = formatter.parse(formatter.format(new Date()));
                actualdob = formatter.parse(dob);
                model.addAttribute("dob", dob);
                long difference = now.getTime() - actualdob.getTime();
                float daysBetween = (difference / (1000 * 60 * 60 * 24));
                model.addAttribute("estimatedage", computeAge(Math.round(daysBetween)));
            } catch (ParseException ex) {
                System.out.println(ex);
            }
        }

        if ("".equals(pContact) || pContact == null) {
            model.addAttribute("pContact", "novalue");
        } else {
            model.addAttribute("pContact", pContact);
        }

        if (personGender == null) {
            model.addAttribute("gender", "novalue");
        } else {
            model.addAttribute("gender", personGender);
        }
        return "patientsManagement/views/managePatient";
    }

    @RequestMapping(value = "/patientvisitation", method = RequestMethod.GET)
    public String patientVisitation(HttpServletRequest request, Model model, @ModelAttribute("patientid") String pid, @ModelAttribute("pfirstname") String pfirstname, @ModelAttribute("plastname") String plastname, @ModelAttribute("pothername") String pothername, @ModelAttribute("pin") String patientno) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null && request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> medicalIssues = new ArrayList<>();
            List<Map> facilityUnits = new ArrayList<>();
            BigInteger patientid = BigInteger.valueOf(Long.valueOf(pid));
            String name = pfirstname + " " + plastname + " " + pothername;

            //Get Patient Issues
            String[] params = {"patientid"};
            Object[] paramsValues = {patientid};
            String[] fields = {"medicalissue.medicalissueid", "medicalissuestate"};
            String where = "WHERE patientid=:patientid";
            List<Object[]> issues = (List<Object[]>) genericClassService.fetchRecord(Patientmedicalissue.class, fields, where, params, paramsValues);
            if (issues != null) {
                Map<String, Object> issue;
                for (Object[] sue : issues) {
                    issue = new HashMap<>();
                    issue.put("id", sue[0]);
                    issue.put("key", sue[1]);
                    medicalIssues.add(issue);
                }
            }
            //Get Units
            Set<Long> unitServices = new HashSet<>();
            String[] params6 = {};
            Object[] paramsValues6 = {};
            String[] fields6 = {"facilityunit.facilityunitid", "facilityunitserviceid"};
            String where6 = "";
            List<Object[]> unitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields6, where6, params6, paramsValues6);
            if (unitservices != null) {
                for (Object[] unitservice : unitservices) {
                    unitServices.add((Long) unitservice[0]);
                }
            }
            String[] params2 = {"facilityid", "administrative"};
            Object[] paramsValues2 = {facilityId, false};
            String[] fields2 = {"facilityunitid", "facilityunitname"};
            String where2 = "WHERE facilityid=:facilityid AND administrative=:administrative";
            List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2, where2, params2, paramsValues2);
            if (units != null) {
                Map<String, Object> unit;
                for (Object[] u : units) {
                    unit = new HashMap<>();
                    if (unitServices.isEmpty() || unitServices.contains((Long) u[0])) {
                        unit.put("id", u[0]);
                        unit.put("name", u[1]);
                        facilityUnits.add(unit);
                    }
                }
            }
            String issueKeys = "[]";
            try {
                issueKeys = new ObjectMapper().writeValueAsString(medicalIssues);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            //
            params = new String[]{"patientid"};
            paramsValues = new Object[]{patientid};
            fields = new String[]{"patientvisitid", "facilityid"};
            where = "WHERE patientid=:patientid";
            List<Object[]> patientVisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (patientVisits != null && patientVisits.size() > 0) {
                model.addAttribute("isnewpatient", Boolean.FALSE);
            } else {
                model.addAttribute("isnewpatient", Boolean.TRUE);
            }
            //

            model.addAttribute("pin", patientno);
            model.addAttribute("staffid", staffid);
            model.addAttribute("patientid", patientid);
            model.addAttribute("issueKeys", issueKeys);
            model.addAttribute("currentUnit", facilityUnit);
            model.addAttribute("facilityunits", facilityUnits);
            model.addAttribute("name", name.replace("novalue", ""));
            model.addAttribute("visitno", getVisitNumber(facilityUnit));
            //
            model.addAttribute("facilityid", facilityId);
            //
            return "patientsManagement/forms/patientVisitForm";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/managePatientIssues", method = RequestMethod.POST)
    public @ResponseBody
    String managePatientIssues(HttpServletRequest request, Model model, @ModelAttribute("patientid") String pid, @ModelAttribute("issuekey") String issueKey, @ModelAttribute("issueid") Integer issueid, @ModelAttribute("operation") String operation) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            BigInteger patientid = BigInteger.valueOf(Long.valueOf(pid));
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            if ("save".equalsIgnoreCase(operation)) {
                Patientmedicalissue issue = new Patientmedicalissue();
                issue.setMedicalissue(new Medicalissue(issueid.longValue()));
                issue.setMedicalissuestate(issueKey);
                issue.setPatientid(new Patient(patientid.longValue()));
                issue.setAddedby(BigInteger.valueOf(staffid));
                issue.setDateadded(new Date());
                genericClassService.saveOrUpdateRecordLoadObject(issue);
            } else {
                //Get Patient Issues
                String[] columns = {"medicalissuestate", "dateadded"};
                Object[] columnValues = {issueKey, new Date()};
                String[] whereColumns = {"patientid", "medicalissue"};
                Object[] whereValues = {patientid, issueid};
                genericClassService.updateRecordSQLStyle("patient.patientmedicalissue", columns, columnValues, whereColumns, whereValues, "AND");
            }
            return "saved";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/getPatientVisitDetails", method = RequestMethod.POST)
    public @ResponseBody
    String getPatientVisitDetails(HttpServletRequest request, Model model, @ModelAttribute("visitid") Integer patientvisitid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Map<String, Object> visitDetails = new HashMap<>();
            String[] params = {"patientvisitid"};
            Object[] paramsValues = {patientvisitid};
            String[] fields = {"patientid", "fullnames", "visitnumber"};
            String where = "WHERE patientvisitid=:patientvisitid";
            List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Patientvisits.class, fields, where, params, paramsValues);
            if (queue != null) {
                visitDetails.put("patientid", queue.get(0)[0]);
                visitDetails.put("names", queue.get(0)[1]);
                visitDetails.put("visitno", queue.get(0)[2]);
            }
            String response = "";
            try {
                response = new ObjectMapper().writeValueAsString(visitDetails);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return response;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/getUnitServices", method = RequestMethod.POST)
    public @ResponseBody
    String getUnitServices(HttpServletRequest request, Model model, @ModelAttribute("unitid") Integer unitid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> services = new ArrayList<>();
            String[] params = {"facilityunitid"};
            Object[] paramsValues = {unitid};
            String[] fields = {"facilityunitserviceid", "facilityservices.serviceid"};
            String where = "WHERE facilityunitid=:facilityunitid";
            List<Object[]> unitServices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
            if (unitServices != null) {
                Map<String, Object> service;
                for (Object[] unitService : unitServices) {
                    service = new HashMap<>();
                    service.put("usid", unitService[0]);

                    String[] params2 = {"serviceid"};
                    Object[] paramsValues2 = {unitService[1]};
                    String[] fields2 = {"servicename"};
//                    String where2 = "WHERE serviceid=:serviceid";                    
                    String where2 = "WHERE serviceid=:serviceid AND LOWER(servicekey) NOT IN(LOWER('key_dispensing'), LOWER('key_counselling'))";
                    List<Object[]> serviceName = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, fields2, where2, params2, paramsValues2);
                    if (serviceName != null) {
                        service.put("serviceName", serviceName.get(0));
                        services.add(service);
                    }
//                    services.add(service);
                }
            }
            String servicesJSON = "[]";
            try {
                servicesJSON = new ObjectMapper().writeValueAsString(services);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return servicesJSON;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/initiatePatientVisit", method = RequestMethod.POST)
    public @ResponseBody
    String initiatePatientVisit(HttpServletRequest request, Model model, @ModelAttribute("visitno") String visitNo, @ModelAttribute("unit") Integer facilityUnit, @ModelAttribute("patientid") Integer patientid, @ModelAttribute("priority") String priority, @ModelAttribute("type") String type) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String patientVisitid = "";
            Long staffid = (Long) request.getSession().getAttribute("person_id");

            Patientvisit visit = new Patientvisit();
            visit.setPatientid(patientid.longValue());
            visit.setFacilityunitid(BigInteger.valueOf(facilityUnit.longValue()));
            visit.setAddedby(BigInteger.valueOf(staffid));
            visit.setDateadded(new Date());
            visit.setVisitnumber(visitNo);
            visit.setVisittype(type);
            visit.setVisitpriority(priority);
            visit = (Patientvisit) genericClassService.saveOrUpdateRecordLoadObject(visit);
            if (visit != null) {
                patientVisitid = visit.getPatientvisitid().toString();
            }
            return patientVisitid;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/getFacilityRegisteredPatients", method = RequestMethod.GET)
    public String getFacilityRegisteredPatients(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> facilityUnitsList = new ArrayList<>();
            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");

            //Get Units
            String[] params2Funits = {"facilityid", "administrative"};
            Object[] paramsValues2Funits = {facilityId, false};
            String[] fields2Funits = {"facilityunitid", "facilityunitname"};
            String where2Funits = "WHERE facilityid=:facilityid AND administrative=:administrative";
            List<Object[]> objFacilityUnits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2Funits, where2Funits, params2Funits, paramsValues2Funits);
            if (objFacilityUnits != null) {
                Map<String, Object> unitMap;
                for (Object[] units : objFacilityUnits) {
                    unitMap = new HashMap<>();
                    unitMap.put("id", units[0]);
                    unitMap.put("name", units[1]);
                    facilityUnitsList.add(unitMap);
                }
                model.addAttribute("facilityUnitsList2", facilityUnitsList);
            }
            model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
            return "patientsManagement/patientFacilityRegister/patientRegister";

        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/viewFacilityRegisteredPatients", method = RequestMethod.POST)
    public String viewFacilityRegisteredPatients(HttpServletRequest request, Model model, @ModelAttribute("date") String date, @ModelAttribute("visittype") String visittype) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            int totalCount = 0;
            try {
                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
                Date reportDate = formatter.parse(date);
                List<Map> patientRegisteredList = new ArrayList<>();

                if ("allPatients".equals(visittype)) {
                    String[] paramsregistered33 = {"facilityid", "dateadded"};
                    Object[] paramsValuesparamsregistered33 = {facilityId, reportDate};
//                      Object[] paramsValuesparamsregistered33 = {facilityId, formatter.format(reportDate)};
//                    Commented Out Because It Produces Duplicates.
//                    String[] fieldsparamsregistered33 = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientvisitid"};
                    String[] fieldsparamsregistered33 = {"fullname", "gender", "age", "parishname", "villagename", "patientid"};
//                    String whereparamsregistered33 = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//                    String whereparamsregistered33 = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                    String whereparamsregistered33 = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded";
                    List<Object[]> objRegistered33 = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsparamsregistered33, whereparamsregistered33, paramsregistered33, paramsValuesparamsregistered33);
                    if (objRegistered33 != null) {

                        Map<String, Object> patientMap33;
                        for (Object[] register : objRegistered33) {
                            patientMap33 = new HashMap<>();
                            patientMap33.put("names", capitalize(register[0].toString()));
                            patientMap33.put("gender", register[1]);
                            patientMap33.put("age", register[2]);
                            patientMap33.put("parish", register[3]);
                            patientMap33.put("village", register[4]);
                            //patientMap33.put("visittype", register[5]);
                            patientMap33.put("patientid", register[5]);
                            patientRegisteredList.add(patientMap33);
                        }
                        totalCount = totalCount + patientRegisteredList.size();
                    }
                } else {
                    //filter visit types
                    String[] paramsregisteredOnevisits = {"facilityid", "dateadded", "visittype"};
                    Object[] paramsValuesparamsregisteredOnevisits = {facilityId, reportDate, visittype};
//                    Object[] paramsValuesparamsregisteredOnevisits = {facilityId, formatter.format(reportDate), visittype};
//                    Commented Out Because It Produces Duplicates.
//                    String[] fieldsparamsregisteredOnevisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientvisitid"};
//                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
                    String[] fieldsparamsregisteredOnevisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientid"};
//                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
//                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
                    List<Object[]> objRegisteredOnevisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsparamsregisteredOnevisits, whereparamsregisteredOnevisits, paramsregisteredOnevisits, paramsValuesparamsregisteredOnevisits);
                    if (objRegisteredOnevisits != null) {

                        Map<String, Object> patientMapOnevisits;
                        for (Object[] register : objRegisteredOnevisits) {

                            patientMapOnevisits = new HashMap<>();
                            patientMapOnevisits.put("names", capitalize(register[0].toString()));
                            patientMapOnevisits.put("gender", register[1]);
                            patientMapOnevisits.put("age", register[2]);
                            patientMapOnevisits.put("parish", register[3]);
                            patientMapOnevisits.put("village", register[4]);
                            patientMapOnevisits.put("visittype", register[5]);
                            patientMapOnevisits.put("patientid", register[6]);
                            patientRegisteredList.add(patientMapOnevisits);
                        }
                        totalCount = totalCount + patientRegisteredList.size();
                    }
                }
                model.addAttribute("date", date);
                model.addAttribute("patientsTotal", String.format("%,d", totalCount));
                model.addAttribute("patientlist", patientRegisteredList);
                return "patientsManagement/patientFacilityRegister/patients";
            } catch (ParseException e) {
                return "patientsManagement/patientFacilityRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/patientRegisterStatistics", method = RequestMethod.GET)
    public String patientRegisterStatistics(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {

            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            List<Map> facilityUnitsList = new ArrayList<>();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

            //Get Units
//            String[] params2Funits = {"facilityid", "administrative"};
//            Object[] paramsValues2Funits = {facilityId, false};
            String[] params2Funits = {"facilityid", "administrative", "facilityunitid"};
            Object[] paramsValues2Funits = {facilityId, false, facilityUnit};
            String[] fields2Funits = {"facilityunitid", "facilityunitname"};
//            String where2Funits = "WHERE facilityid=:facilityid AND administrative=:administrative";
            String where2Funits = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND administrative=:administrative";
            List<Object[]> objFacilityUnits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2Funits, where2Funits, params2Funits, paramsValues2Funits);
            if (objFacilityUnits != null) {
                Map<String, Object> unitMap;
                for (Object[] units : objFacilityUnits) {
                    unitMap = new HashMap<>();
                    unitMap.put("id", units[0]);
                    unitMap.put("name", units[1]);
                    Boolean selected = (Long.parseLong(units[0].toString()) == Long.parseLong(facilityUnit.toString())) ? Boolean.TRUE : Boolean.FALSE;
                    unitMap.put("selected", selected);// Added to be used in selecting the current unit in the dropdown by default.
                    facilityUnitsList.add(unitMap);
                }
            }

            model.addAttribute("facilityUnitsList", facilityUnitsList);
            model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
            return "patientsManagement/patientFacilityRegister/patientStatisticsRegister";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/viewPatientRegisterStatistics", method = RequestMethod.GET)
    public String viewPatientRegisterStatistics(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
//            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
//
//            int totalpatientvisit = 0;
//            int totalpatientvisitbelow5 = 0;
//            int totalpatientvisit5to12 = 0;
//            int totalpatientvisit13andabove = 0;
//
//            int totalpatientsMale = 0;
//            int totalpatientsFemale = 0;
//
//            int totalFemaleNew = 0;
//            int totalFemaleOld = 0;
//
//            int totalMaleNew = 0;
//            int totalMaleOld = 0;
//
//            int totalPatientsNew = 0;
//            int totalPatientsOld = 0;
//
//            int zeroTo4YearsNew = 0;
//            int zerotO4yearsOld = 0;
//
//            int zeroTo4YearsNewFemale = 0;
//            int zeroTo4YearsNewMale = 0;
//            int zerotO4yearsOldMale = 0;
//            int zerotO4yearsOldFemale = 0;
//
//            int fiveTo12YearsNew = 0;
//            int fiveTo12YearsOld = 0;
//
//            int fiveTo12YearsNewFemale = 0;
//            int fiveTo12YearsNewMale = 0;
//            int fiveTo12YearsOldMale = 0;
//            int fiveTo12YearsOldFemale = 0;
//
//            int above13YearsNew = 0;
//            int above13YearsOld = 0;
//            int above13YearsNewFemale = 0;
//            int above13YearsNewMale = 0;
//            int above13YearsOldMale = 0;
//            int above13YearsOldFemale = 0;
//
//            String[] paramspatienttotvisits = {"facilityid", "dateadded"};
//            Object[] paramsValuespatienttot = {facilityId, new Date()};
//            String wherepatienttot = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//            totalpatientvisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot);
//
//            String[] paramspatienttotvisitsnew = {"facilityid", "dateadded", "visittype"};
//            Object[] paramsValuespatienttotnew = {facilityId, new Date(), "NEWVISIT"};
//            String wherepatienttotnew = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//            totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttotnew, paramspatienttotvisitsnew, paramsValuespatienttotnew);
//
//            String[] paramspatienttotvisitsold = {"facilityid", "dateadded", "visittype"};
//            Object[] paramsValuespatienttotold = {facilityId, new Date(), "REVISIT"};
//            String wherepatienttotold = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//            totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttotold, paramspatienttotvisitsold, paramsValuespatienttotold);
//
//            String[] paramspatientgender = {"facilityid", "dateadded"};
//            Object[] paramsValuespatiengender = {facilityId, new Date()};
//            String[] fields5patientgender = {"patientvisitid", "gender", "visittype"};
//            List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patientgender, "WHERE facilityid=:facilityid AND dateadded=:dateadded", paramspatientgender, paramsValuespatiengender);
//            if (objpatientgender != null) {
//                for (Object[] patienttotgender : objpatientgender) {
//                    if ("Female".equals((String) patienttotgender[1])) {
//                        if ("NEWVISIT".equals((String) patienttotgender[2])) {
//                            totalFemaleNew = totalFemaleNew + 1;
//                        } else {
//                            totalFemaleOld = totalFemaleOld + 1;
//                        }
//                        totalpatientsFemale = totalpatientsFemale + 1;
//                    }
//                    if ("Male".equals((String) patienttotgender[1])) {
//                        if ("NEWVISIT".equals((String) patienttotgender[2])) {
//                            totalMaleNew = totalMaleNew + 1;
//                        } else {
//                            totalMaleOld = totalMaleOld + 1;
//                        }
//                        totalpatientsMale = totalpatientsMale + 1;
//                    }
//                }
//            }
//
//            String[] paramspatienttotvisitsage = {"facilityid", "dateadded"};
//            Object[] paramsValuespatienttotage = {facilityId, new Date()};
//            String[] fields5patienttotage = {"patientvisitid", "dob", "visittype", "gender"};
//            List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patienttotage, "WHERE facilityid=:facilityid AND dateadded=:dateadded", paramspatienttotvisitsage, paramsValuespatienttotage);
//            if (objpatienttotage != null) {
//                for (Object[] patienttotage : objpatienttotage) {
//
//                    int year = Integer.parseInt(df.format((Date) patienttotage[1]));
//                    int currentyear = Integer.parseInt(df.format(new Date()));
//                    int estimatedage = currentyear - year;
//
//                    if (estimatedage < 5) {
//                        if ("NEWVISIT".equals((String) patienttotage[2])) {
//                            if ("Male".equals((String) patienttotage[3])) {
//                                zeroTo4YearsNewMale = zeroTo4YearsNewMale + 1;
//                            } else {
//                                zeroTo4YearsNewFemale = zeroTo4YearsNewFemale + 1;
//                            }
//                            zeroTo4YearsNew = zeroTo4YearsNew + 1;
//                        } else {
//                            if ("Male".equals((String) patienttotage[3])) {
//                                zerotO4yearsOldMale = zerotO4yearsOldMale + 1;
//                            } else {
//                                zerotO4yearsOldFemale = zerotO4yearsOldFemale + 1;
//                            }
//                            zerotO4yearsOld = zerotO4yearsOld + 1;
//                        }
//                        totalpatientvisitbelow5 = totalpatientvisitbelow5 + 1;
//                    }
//
//                    if (estimatedage >= 5 && estimatedage <= 12) {
//                        if ("NEWVISIT".equals((String) patienttotage[2])) {
//                            if ("Male".equals((String) patienttotage[3])) {
//                                fiveTo12YearsNewMale = fiveTo12YearsNewMale + 1;
//                            } else {
//                                fiveTo12YearsNewFemale = fiveTo12YearsNewFemale + 1;
//                            }
//                            fiveTo12YearsNew = fiveTo12YearsNew + 1;
//                        } else {
//                            if ("Male".equals((String) patienttotage[3])) {
//                                fiveTo12YearsOldMale = fiveTo12YearsOldMale + 1;
//                            } else {
//                                fiveTo12YearsOldFemale = fiveTo12YearsOldFemale + 1;
//                            }
//                            fiveTo12YearsOld = fiveTo12YearsOld + 1;
//                        }
//                        totalpatientvisit5to12 = totalpatientvisit5to12 + 1;
//                    }
//
//                    if (estimatedage >= 13) {
//                        if ("NEWVISIT".equals((String) patienttotage[2])) {
//                            if ("Male".equals((String) patienttotage[3])) {
//                                above13YearsNewMale = above13YearsNewMale + 1;
//                            } else {
//                                above13YearsNewFemale = above13YearsNewFemale + 1;
//                            }
//                            above13YearsNew = above13YearsNew + 1;
//                        } else {
//                            if ("Male".equals((String) patienttotage[3])) {
//                                above13YearsOldMale = above13YearsOldMale + 1;
//                            } else {
//                                above13YearsOldFemale = above13YearsOldFemale + 1;
//                            }
//                            above13YearsOld = above13YearsOld + 1;
//                        }
//                        totalpatientvisit13andabove = totalpatientvisit13andabove + 1;
//                    }
//                }
//            }
//
//            model.addAttribute("totalpatientsFemale", totalpatientsFemale);
//            model.addAttribute("totalpatientsMale", totalpatientsMale);
//            model.addAttribute("totalpatientvisit", totalpatientvisit);
//            model.addAttribute("totalpatientvisitbelow5", totalpatientvisitbelow5);
//            model.addAttribute("totalpatientvisit5to12", totalpatientvisit5to12);
//            model.addAttribute("totalpatientvisit13andabove", totalpatientvisit13andabove);
//
//            model.addAttribute("totalFemaleNew", totalFemaleNew);
//            model.addAttribute("totalFemaleOld", totalFemaleOld);
//            model.addAttribute("totalMaleNew", totalMaleNew);
//            model.addAttribute("totalMaleOld", totalMaleOld);
//
//            model.addAttribute("totalPatientsNew", totalPatientsNew);
//            model.addAttribute("totalPatientsOld", totalPatientsOld);
//
//            model.addAttribute("zeroTo4YearsNew", zeroTo4YearsNew);
//            model.addAttribute("zerotO4yearsOld", zerotO4yearsOld);
//
//            model.addAttribute("zeroTo4YearsNewFemale", zeroTo4YearsNewFemale);
//            model.addAttribute("zeroTo4YearsNewMale", zeroTo4YearsNewMale);
//            model.addAttribute("zerotO4yearsOldFemale", zerotO4yearsOldFemale);
//            model.addAttribute("zerotO4yearsOldMale", zerotO4yearsOldMale);
//
//            model.addAttribute("fiveTo12YearsNew", fiveTo12YearsNew);
//            model.addAttribute("fiveTo12YearsOld", fiveTo12YearsOld);
//
//            model.addAttribute("fiveTo12YearsNewFemale", fiveTo12YearsNewFemale);
//            model.addAttribute("fiveTo12YearsNewMale", fiveTo12YearsNewMale);
//            model.addAttribute("fiveTo12YearsOldFemale", fiveTo12YearsOldFemale);
//            model.addAttribute("fiveTo12YearsOldMale", fiveTo12YearsOldMale);
//
//            model.addAttribute("above13YearsNew", above13YearsNew);
//            model.addAttribute("above13YearsOld", above13YearsOld);
//
//            model.addAttribute("above13YearsNewFemale", above13YearsNewFemale);
//            model.addAttribute("above13YearsNewMale", above13YearsNewMale);
//            model.addAttribute("above13YearsOldFemale", above13YearsOldFemale);
//            model.addAttribute("above13YearsOldMale", above13YearsOldMale);
//
//            return "patientsManagement/patientFacilityRegister/startics";
            try {
                Date reportDate = new Date();

                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");

                int totalPatientVisit = 0;
                int totalPatientVisitBelow29Days = 0;
                int totalPatientVisit29DaysTo4Yrs = 0;
                int totalPatientVisit5YrsTo59Yrs = 0;
                int totalPatientVisit60AndAbove = 0;

                int totalPatientsMale = 0;
                int totalPatientsFemale = 0;

                int totalFemaleNew = 0;
                int totalFemaleOld = 0;

                int totalMaleNew = 0;
                int totalMaleOld = 0;

                int totalPatientsNew = 0;
                int totalPatientsOld = 0;

                int zeroTo28DaysNew = 0;
                int zeroTo28DaysOld = 0;

                int zeroTo28DaysNewFemale = 0;
                int zeroTo28DaysNewMale = 0;
                int zeroTo28DaysOldMale = 0;
                int zeroTo28DaysOldFemale = 0;

                int days29To4YrsNew = 0;
                int days29To4YrsOld = 0;

                int days29To4YrsNewFemale = 0;
                int days29To4YrsNewMale = 0;
                int days29To4YrsOldMale = 0;
                int days29To4YrsOldFemale = 0;

                int yrs5TO59New = 0;
                int yrs5TO59Old = 0;
                int yrs5TO59NewFemale = 0;
                int yrs5TO59NewMale = 0;
                int yrs5TO59OldMale = 0;
                int yrs5TO59OldFemale = 0;

                int yrs60AndAboveNew = 0;
                int yrs60AndAboveOld = 0;
                int yrs60AndAboveNewFemale = 0;
                int yrs60AndAboveNewMale = 0;
                int yrs60AndAboveOldMale = 0;
                int yrs60AndAboveOldFemale = 0;

                String[] params = {"facilityid", "dateadded"};
                Object[] paramsValues = {facilityId, reportDate};
//                String where = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//                Object[] paramsValues = {facilityId, formatter.format(reportDate)};
//                String where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                String where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded";
                totalPatientVisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateadded", "visittype"};
                paramsValues = new Object[]{facilityId, reportDate, "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//                paramsValues = new Object[] {facilityId, formatter.format(reportDate), "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
                where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateadded", "visittype"};
                paramsValues = new Object[]{facilityId, reportDate, "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//                paramsValues = new Object[] {facilityId, formatter.format(reportDate), "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
                where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateadded"};
                paramsValues = new Object[]{facilityId, reportDate};
//                paramsValues = new Object[] {facilityId, formatter.format(reportDate)};
                String[] fields = {"patientvisitid", "gender", "visittype"};
//                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", params, paramsValues);
                if (objpatientgender != null) {
                    for (Object[] patienttotgender : objpatientgender) {
                        if ("Female".toLowerCase().equals(((String) patienttotgender[1]).toLowerCase())) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotgender[2]).toUpperCase())) {
                                totalFemaleNew += 1;
                            } else {
                                totalFemaleOld += 1;
                            }
                            totalPatientsFemale += 1;
                        }
                        if ("Male".toUpperCase().equals(((String) patienttotgender[1]).toUpperCase())) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotgender[2]).toLowerCase())) {
                                totalMaleNew += 1;
                            } else {
                                totalMaleOld += 1;
                            }
                            totalPatientsMale += 1;
                        }
                    }
                }

                params = new String[]{"facilityid", "dateadded"};
                paramsValues = new Object [] {facilityId, reportDate};
//                paramsValues = new Object[]{facilityId, formatter.format(reportDate)};
                fields = new String[]{"patientvisitid", "dob", "visittype", "gender"};
//                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", params, paramsValues);
                if (objpatienttotage != null) {
                    for (Object[] patienttotage : objpatienttotage) {

                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                        int currentyear = Integer.parseInt(df.format(new Date()));
                        Long estimatedAgeInDays = getDays(new Date(), ((Date) patienttotage[1]));
                        int estimatedAgeInYears = currentyear - year;
                        if ((estimatedAgeInDays <= 28 && estimatedAgeInYears == 0)) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    zeroTo28DaysNewMale += 1;
                                } else {
                                    zeroTo28DaysNewFemale += 1;
                                }
                                zeroTo28DaysNew += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    zeroTo28DaysOldMale += 1;
                                } else {
                                    zeroTo28DaysOldFemale += 1;
                                }
                                zeroTo28DaysOld += 1;
                            }
                            totalPatientVisitBelow29Days += 1;
                        } else if (estimatedAgeInDays >= 29 && estimatedAgeInYears <= 4) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotage[2]).toLowerCase())) {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    days29To4YrsNewMale += 1;
                                } else {
                                    days29To4YrsNewFemale += 1;
                                }
                                days29To4YrsNew += 1;
                            } else {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    days29To4YrsOldMale += 1;
                                } else {
                                    days29To4YrsOldFemale += 1;
                                }

                                days29To4YrsOld += 1;
                            }
                            totalPatientVisit29DaysTo4Yrs += 1;
                        } else if (estimatedAgeInYears >= 5 && estimatedAgeInYears <= 59) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    yrs5TO59NewMale += 1;
                                } else {
                                    yrs5TO59NewFemale += 1;
                                }
                                yrs5TO59New += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    yrs5TO59OldMale += 1;
                                } else {
                                    yrs5TO59OldFemale += 1;
                                }
                                yrs5TO59Old += 1;
                            }

                            totalPatientVisit5YrsTo59Yrs += 1;
                        } else if (estimatedAgeInYears >= 60) {
                            if ("NEWVISIT".equals((String) patienttotage[2])) {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveNewMale += 1;
                                } else {
                                    yrs60AndAboveNewFemale += 1;
                                }
                                yrs60AndAboveNew += 1;
                            } else {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveOldMale += 1;
                                } else {
                                    yrs60AndAboveOldFemale += 1;
                                }
                                yrs60AndAboveOld += 1;
                            }
                            totalPatientVisit60AndAbove += 1;
                        }
                    }
                }

                model.addAttribute("totalpatientsFemale", totalPatientsFemale);
                model.addAttribute("totalpatientsMale", totalPatientsMale);
                model.addAttribute("totalpatientvisit", totalPatientVisit);
                model.addAttribute("totalPatientVisitBelow29Days", totalPatientVisitBelow29Days);
                model.addAttribute("totalPatientVisit29DaysTo4Yrs", totalPatientVisit29DaysTo4Yrs);
                model.addAttribute("totalPatientVisit5YrsTo59Yrs", totalPatientVisit5YrsTo59Yrs);
                model.addAttribute("totalPatientVisit60AndAbove", totalPatientVisit60AndAbove);

                model.addAttribute("totalFemaleNew", totalFemaleNew);
                model.addAttribute("totalFemaleOld", totalFemaleOld);
                model.addAttribute("totalMaleNew", totalMaleNew);
                model.addAttribute("totalMaleOld", totalMaleOld);

                model.addAttribute("totalPatientsNew", totalPatientsNew);
                model.addAttribute("totalPatientsOld", totalPatientsOld);

                model.addAttribute("zeroTo28DaysNew", zeroTo28DaysNew);
                model.addAttribute("zeroTo28DaysOld", zeroTo28DaysOld);

                model.addAttribute("zeroTo28DaysNewFemale", zeroTo28DaysNewFemale);
                model.addAttribute("zeroTo28DaysNewMale", zeroTo28DaysNewMale);
                model.addAttribute("zeroTo28DaysOldFemale", zeroTo28DaysOldFemale);
                model.addAttribute("zeroTo28DaysOldMale", zeroTo28DaysOldMale);

                model.addAttribute("days29To4YrsNew", days29To4YrsNew);
                model.addAttribute("days29To4YrsOld", days29To4YrsOld);

                model.addAttribute("days29To4YrsNewFemale", days29To4YrsNewFemale);
                model.addAttribute("days29To4YrsNewMale", days29To4YrsNewMale);
                model.addAttribute("days29To4YrsOldFemale", days29To4YrsOldFemale);
                model.addAttribute("days29To4YrsOldMale", days29To4YrsOldMale);

                model.addAttribute("yrs5TO59New", yrs5TO59New);
                model.addAttribute("yrs5TO59Old", yrs5TO59Old);

                model.addAttribute("yrs5TO59NewFemale", yrs5TO59NewFemale);
                model.addAttribute("yrs5TO59NewMale", yrs5TO59NewMale);
                model.addAttribute("yrs5TO59OldFemale", yrs5TO59OldFemale);
                model.addAttribute("yrs5TO59OldMale", yrs5TO59OldMale);

                model.addAttribute("yrs60AndAboveNew", yrs60AndAboveNew);
                model.addAttribute("yrs60AndAboveOld", yrs60AndAboveOld);

                model.addAttribute("yrs60AndAboveNewFemale", yrs60AndAboveNewFemale);
                model.addAttribute("yrs60AndAboveNewMale", yrs60AndAboveNewMale);
                model.addAttribute("yrs60AndAboveOldFemale", yrs60AndAboveOldFemale);
                model.addAttribute("yrs60AndAboveOldMale", yrs60AndAboveOldMale);

                return "patientsManagement/patientFacilityRegister/startics";
            } catch (Exception ex) {
                ex.printStackTrace();
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/viewPatientsStatisticsByFacility", method = RequestMethod.GET)
    public String viewPatientsStatisticsByFacility(HttpServletRequest request, Model model, @ModelAttribute("date") String date) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            try {
//                Date reportDate = formatter.parse(date);
//                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
//
//                int totalpatientvisit = 0;
//                int totalpatientvisitbelow5 = 0;
//                int totalpatientvisit5to12 = 0;
//                int totalpatientvisit13andabove = 0;
//
//                int totalpatientsMale = 0;
//                int totalpatientsFemale = 0;
//
//                int totalFemaleNew = 0;
//                int totalFemaleOld = 0;
//
//                int totalMaleNew = 0;
//                int totalMaleOld = 0;
//
//                int totalPatientsNew = 0;
//                int totalPatientsOld = 0;
//
//                int zeroTo4YearsNew = 0;
//                int zerotO4yearsOld = 0;
//
//                int zeroTo4YearsNewFemale = 0;
//                int zeroTo4YearsNewMale = 0;
//                int zerotO4yearsOldMale = 0;
//                int zerotO4yearsOldFemale = 0;
//
//                int fiveTo12YearsNew = 0;
//                int fiveTo12YearsOld = 0;
//
//                int fiveTo12YearsNewFemale = 0;
//                int fiveTo12YearsNewMale = 0;
//                int fiveTo12YearsOldMale = 0;
//                int fiveTo12YearsOldFemale = 0;
//
//                int above13YearsNew = 0;
//                int above13YearsOld = 0;
//                int above13YearsNewFemale = 0;
//                int above13YearsNewMale = 0;
//                int above13YearsOldMale = 0;
//                int above13YearsOldFemale = 0;
//
//                String[] paramspatienttotvisits = {"facilityid", "dateadded"};
//                Object[] paramsValuespatienttot = {facilityId, reportDate};
//                String wherepatienttot = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//                totalpatientvisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot);
//
//                String[] paramspatienttotvisitsnew = {"facilityid", "dateadded", "visittype"};
//                Object[] paramsValuespatienttotnew = {facilityId, reportDate, "NEWVISIT"};
//                String wherepatienttotnew = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttotnew, paramspatienttotvisitsnew, paramsValuespatienttotnew);
//
//                String[] paramspatienttotvisitsold = {"facilityid", "dateadded", "visittype"};
//                Object[] paramsValuespatienttotold = {facilityId, reportDate, "REVISIT"};
//                String wherepatienttotold = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttotold, paramspatienttotvisitsold, paramsValuespatienttotold);
//
//                String[] paramspatientgender = {"facilityid", "dateadded"};
//                Object[] paramsValuespatiengender = {facilityId, reportDate};
//                String[] fields5patientgender = {"patientvisitid", "gender", "visittype"};
//                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patientgender, "WHERE facilityid=:facilityid AND dateadded=:dateadded", paramspatientgender, paramsValuespatiengender);
//                if (objpatientgender != null) {
//                    for (Object[] patienttotgender : objpatientgender) {
//                        if ("Female".equals((String) patienttotgender[1])) {
//                            if ("NEWVISIT".equals((String) patienttotgender[2])) {
//                                totalFemaleNew = totalFemaleNew + 1;
//                            } else {
//                                totalFemaleOld = totalFemaleOld + 1;
//                            }
//                            totalpatientsFemale = totalpatientsFemale + 1;
//                        }
//                        if ("Male".equals((String) patienttotgender[1])) {
//                            if ("NEWVISIT".equals((String) patienttotgender[2])) {
//                                totalMaleNew = totalMaleNew + 1;
//                            } else {
//                                totalMaleOld = totalMaleOld + 1;
//                            }
//                            totalpatientsMale = totalpatientsMale + 1;
//                        }
//                    }
//                }
//
//                String[] paramspatienttotvisitsage = {"facilityid", "dateadded"};
//                Object[] paramsValuespatienttotage = {facilityId, reportDate};
//                String[] fields5patienttotage = {"patientvisitid", "dob", "visittype", "gender"};
//                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patienttotage, "WHERE facilityid=:facilityid AND dateadded=:dateadded", paramspatienttotvisitsage, paramsValuespatienttotage);
//                if (objpatienttotage != null) {
//                    for (Object[] patienttotage : objpatienttotage) {
//
//                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
//                        int currentyear = Integer.parseInt(df.format(new Date()));
//                        int estimatedage = currentyear - year;
//
//                        if (estimatedage < 5) {
//                            if ("NEWVISIT".equals((String) patienttotage[2])) {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    zeroTo4YearsNewMale = zeroTo4YearsNewMale + 1;
//                                } else {
//                                    zeroTo4YearsNewFemale = zeroTo4YearsNewFemale + 1;
//                                }
//                                zeroTo4YearsNew = zeroTo4YearsNew + 1;
//                            } else {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    zerotO4yearsOldMale = zerotO4yearsOldMale + 1;
//                                } else {
//                                    zerotO4yearsOldFemale = zerotO4yearsOldFemale + 1;
//                                }
//                                zerotO4yearsOld = zerotO4yearsOld + 1;
//                            }
//                            totalpatientvisitbelow5 = totalpatientvisitbelow5 + 1;
//                        }
//
//                        if (estimatedage >= 5 && estimatedage <= 12) {
//                            if ("NEWVISIT".equals((String) patienttotage[2])) {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    fiveTo12YearsNewMale = fiveTo12YearsNewMale + 1;
//                                } else {
//                                    fiveTo12YearsNewFemale = fiveTo12YearsNewFemale + 1;
//                                }
//                                fiveTo12YearsNew = fiveTo12YearsNew + 1;
//                            } else {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    fiveTo12YearsOldMale = fiveTo12YearsOldMale + 1;
//                                } else {
//                                    fiveTo12YearsOldFemale = fiveTo12YearsOldFemale + 1;
//                                }
//                                fiveTo12YearsOld = fiveTo12YearsOld + 1;
//                            }
//                            totalpatientvisit5to12 = totalpatientvisit5to12 + 1;
//                        }
//
//                        if (estimatedage >= 13) {
//                            if ("NEWVISIT".equals((String) patienttotage[2])) {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    above13YearsNewMale = above13YearsNewMale + 1;
//                                } else {
//                                    above13YearsNewFemale = above13YearsNewFemale + 1;
//                                }
//                                above13YearsNew = above13YearsNew + 1;
//                            } else {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    above13YearsOldMale = above13YearsOldMale + 1;
//                                } else {
//                                    above13YearsOldFemale = above13YearsOldFemale + 1;
//                                }
//                                above13YearsOld = above13YearsOld + 1;
//                            }
//                            totalpatientvisit13andabove = totalpatientvisit13andabove + 1;
//                        }
//                    }
//                }
//
//                model.addAttribute("totalpatientsFemale", totalpatientsFemale);
//                model.addAttribute("totalpatientsMale", totalpatientsMale);
//                model.addAttribute("totalpatientvisit", totalpatientvisit);
//                model.addAttribute("totalpatientvisitbelow5", totalpatientvisitbelow5);
//                model.addAttribute("totalpatientvisit5to12", totalpatientvisit5to12);
//                model.addAttribute("totalpatientvisit13andabove", totalpatientvisit13andabove);
//
//                model.addAttribute("totalFemaleNew", totalFemaleNew);
//                model.addAttribute("totalFemaleOld", totalFemaleOld);
//                model.addAttribute("totalMaleNew", totalMaleNew);
//                model.addAttribute("totalMaleOld", totalMaleOld);
//
//                model.addAttribute("totalPatientsNew", totalPatientsNew);
//                model.addAttribute("totalPatientsOld", totalPatientsOld);
//
//                model.addAttribute("zeroTo4YearsNew", zeroTo4YearsNew);
//                model.addAttribute("zerotO4yearsOld", zerotO4yearsOld);
//
//                model.addAttribute("zeroTo4YearsNewFemale", zeroTo4YearsNewFemale);
//                model.addAttribute("zeroTo4YearsNewMale", zeroTo4YearsNewMale);
//                model.addAttribute("zerotO4yearsOldFemale", zerotO4yearsOldFemale);
//                model.addAttribute("zerotO4yearsOldMale", zerotO4yearsOldMale);
//
//                model.addAttribute("fiveTo12YearsNew", fiveTo12YearsNew);
//                model.addAttribute("fiveTo12YearsOld", fiveTo12YearsOld);
//
//                model.addAttribute("fiveTo12YearsNewFemale", fiveTo12YearsNewFemale);
//                model.addAttribute("fiveTo12YearsNewMale", fiveTo12YearsNewMale);
//                model.addAttribute("fiveTo12YearsOldFemale", fiveTo12YearsOldFemale);
//                model.addAttribute("fiveTo12YearsOldMale", fiveTo12YearsOldMale);
//
//                model.addAttribute("above13YearsNew", above13YearsNew);
//                model.addAttribute("above13YearsOld", above13YearsOld);
//
//                model.addAttribute("above13YearsNewFemale", above13YearsNewFemale);
//                model.addAttribute("above13YearsNewMale", above13YearsNewMale);
//                model.addAttribute("above13YearsOldFemale", above13YearsOldFemale);
//                model.addAttribute("above13YearsOldMale", above13YearsOldMale);
//
//                return "patientsManagement/patientFacilityRegister/startics";

                Date reportDate = formatter.parse(date);
                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");

                int totalPatientVisit = 0;
                int totalPatientVisitBelow29Days = 0;
                int totalPatientVisit29DaysTo4Yrs = 0;
                int totalPatientVisit5YrsTo59Yrs = 0;
                int totalPatientVisit60AndAbove = 0;

                int totalPatientsMale = 0;
                int totalPatientsFemale = 0;

                int totalFemaleNew = 0;
                int totalFemaleOld = 0;

                int totalMaleNew = 0;
                int totalMaleOld = 0;

                int totalPatientsNew = 0;
                int totalPatientsOld = 0;

                int zeroTo28DaysNew = 0;
                int zeroTo28DaysOld = 0;

                int zeroTo28DaysNewFemale = 0;
                int zeroTo28DaysNewMale = 0;
                int zeroTo28DaysOldMale = 0;
                int zeroTo28DaysOldFemale = 0;

                int days29To4YrsNew = 0;
                int days29To4YrsOld = 0;

                int days29To4YrsNewFemale = 0;
                int days29To4YrsNewMale = 0;
                int days29To4YrsOldMale = 0;
                int days29To4YrsOldFemale = 0;

                int yrs5TO59New = 0;
                int yrs5TO59Old = 0;
                int yrs5TO59NewFemale = 0;
                int yrs5TO59NewMale = 0;
                int yrs5TO59OldMale = 0;
                int yrs5TO59OldFemale = 0;

                int yrs60AndAboveNew = 0;
                int yrs60AndAboveOld = 0;
                int yrs60AndAboveNewFemale = 0;
                int yrs60AndAboveNewMale = 0;
                int yrs60AndAboveOldMale = 0;
                int yrs60AndAboveOldFemale = 0;

                String[] params = {"facilityid", "dateadded"};
                Object[] paramsValues = {facilityId, reportDate};
//                String where = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//                Object[] paramsValues = {facilityId, formatter.format(reportDate)};
//                String where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                String where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded";
                totalPatientVisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateadded", "visittype"};
                paramsValues = new Object[] {facilityId, reportDate, "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//                paramsValues = new Object[]{facilityId, formatter.format(reportDate), "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
                where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateadded", "visittype"};
                paramsValues = new Object[] {facilityId, reportDate, "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//                paramsValues = new Object[]{facilityId, formatter.format(reportDate), "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
                where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateadded"};
                paramsValues = new Object[] {facilityId, reportDate};
//                paramsValues = new Object[]{facilityId, formatter.format(reportDate)};
                String[] fields = {"patientvisitid", "gender", "visittype"};
//                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", params, paramsValues);
                if (objpatientgender != null) {
                    for (Object[] patienttotgender : objpatientgender) {
                        if ("Female".toLowerCase().equals(((String) patienttotgender[1]).toLowerCase())) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotgender[2]).toUpperCase())) {
                                totalFemaleNew += 1;
                            } else {
                                totalFemaleOld += 1;
                            }
                            totalPatientsFemale += 1;
                        }
                        if ("Male".toUpperCase().equals(((String) patienttotgender[1]).toUpperCase())) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotgender[2]).toLowerCase())) {
                                totalMaleNew += 1;
                            } else {
                                totalMaleOld += 1;
                            }
                            totalPatientsMale += 1;
                        }
                    }
                }

                params = new String[]{"facilityid", "dateadded"};
                paramsValues = new Object [] {facilityId, reportDate};
//                paramsValues = new Object[]{facilityId, formatter.format(reportDate)};
                fields = new String[]{"patientvisitid", "dob", "visittype", "gender"};
//                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", params, paramsValues);
                if (objpatienttotage != null) {
                    for (Object[] patienttotage : objpatienttotage) {

                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                        int currentyear = Integer.parseInt(df.format(new Date()));
                        Long estimatedAgeInDays = getDays(new Date(), ((Date) patienttotage[1]));
                        int estimatedAgeInYears = currentyear - year;
                        if ((estimatedAgeInDays <= 28 && estimatedAgeInYears == 0)) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    zeroTo28DaysNewMale += 1;
                                } else {
                                    zeroTo28DaysNewFemale += 1;
                                }
                                zeroTo28DaysNew += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    zeroTo28DaysOldMale += 1;
                                } else {
                                    zeroTo28DaysOldFemale += 1;
                                }
                                zeroTo28DaysOld += 1;
                            }
                            totalPatientVisitBelow29Days += 1;
                        } else if (estimatedAgeInDays >= 29 && estimatedAgeInYears <= 4) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotage[2]).toLowerCase())) {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    days29To4YrsNewMale += 1;
                                } else {
                                    days29To4YrsNewFemale += 1;
                                }
                                days29To4YrsNew += 1;
                            } else {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    days29To4YrsOldMale += 1;
                                } else {
                                    days29To4YrsOldFemale += 1;
                                }
                                days29To4YrsOld += 1;
                            }

                            totalPatientVisit29DaysTo4Yrs += 1;
                        } else if (estimatedAgeInYears >= 5 && estimatedAgeInYears <= 59) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    yrs5TO59NewMale += 1;
                                } else {
                                    yrs5TO59NewFemale += 1;
                                }
                                yrs5TO59New += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    yrs5TO59OldMale += 1;
                                } else {
                                    yrs5TO59OldFemale += 1;
                                }
                                yrs5TO59Old += 1;
                            }

                            totalPatientVisit5YrsTo59Yrs += 1;
                        } else if (estimatedAgeInYears >= 60) {
                            if ("NEWVISIT".equals((String) patienttotage[2])) {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveNewMale += 1;
                                } else {
                                    yrs60AndAboveNewFemale += 1;
                                }
                                yrs60AndAboveNew += 1;
                            } else {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveOldMale += 1;
                                } else {
                                    yrs60AndAboveOldFemale += 1;
                                }
                                yrs60AndAboveOld += 1;
                            }
                            totalPatientVisit60AndAbove += 1;
                        }
                    }
                }

                model.addAttribute("totalpatientsFemale", totalPatientsFemale);
                model.addAttribute("totalpatientsMale", totalPatientsMale);
                model.addAttribute("totalpatientvisit", totalPatientVisit);
                model.addAttribute("totalPatientVisitBelow29Days", totalPatientVisitBelow29Days);
                model.addAttribute("totalPatientVisit29DaysTo4Yrs", totalPatientVisit29DaysTo4Yrs);
                model.addAttribute("totalPatientVisit5YrsTo59Yrs", totalPatientVisit5YrsTo59Yrs);
                model.addAttribute("totalPatientVisit60AndAbove", totalPatientVisit60AndAbove);

                model.addAttribute("totalFemaleNew", totalFemaleNew);
                model.addAttribute("totalFemaleOld", totalFemaleOld);
                model.addAttribute("totalMaleNew", totalMaleNew);
                model.addAttribute("totalMaleOld", totalMaleOld);

                model.addAttribute("totalPatientsNew", totalPatientsNew);
                model.addAttribute("totalPatientsOld", totalPatientsOld);

                model.addAttribute("zeroTo28DaysNew", zeroTo28DaysNew);
                model.addAttribute("zeroTo28DaysOld", zeroTo28DaysOld);

                model.addAttribute("zeroTo28DaysNewFemale", zeroTo28DaysNewFemale);
                model.addAttribute("zeroTo28DaysNewMale", zeroTo28DaysNewMale);
                model.addAttribute("zeroTo28DaysOldFemale", zeroTo28DaysOldFemale);
                model.addAttribute("zeroTo28DaysOldMale", zeroTo28DaysOldMale);

                model.addAttribute("days29To4YrsNew", days29To4YrsNew);
                model.addAttribute("days29To4YrsOld", days29To4YrsOld);

                model.addAttribute("days29To4YrsNewFemale", days29To4YrsNewFemale);
                model.addAttribute("days29To4YrsNewMale", days29To4YrsNewMale);
                model.addAttribute("days29To4YrsOldFemale", days29To4YrsOldFemale);
                model.addAttribute("days29To4YrsOldMale", days29To4YrsOldMale);

                model.addAttribute("yrs5TO59New", yrs5TO59New);
                model.addAttribute("yrs5TO59Old", yrs5TO59Old);

                model.addAttribute("yrs5TO59NewFemale", yrs5TO59NewFemale);
                model.addAttribute("yrs5TO59NewMale", yrs5TO59NewMale);
                model.addAttribute("yrs5TO59OldFemale", yrs5TO59OldFemale);
                model.addAttribute("yrs5TO59OldMale", yrs5TO59OldMale);

                model.addAttribute("yrs60AndAboveNew", yrs60AndAboveNew);
                model.addAttribute("yrs60AndAboveOld", yrs60AndAboveOld);

                model.addAttribute("yrs60AndAboveNewFemale", yrs60AndAboveNewFemale);
                model.addAttribute("yrs60AndAboveNewMale", yrs60AndAboveNewMale);
                model.addAttribute("yrs60AndAboveOldFemale", yrs60AndAboveOldFemale);
                model.addAttribute("yrs60AndAboveOldMale", yrs60AndAboveOldMale);

                return "patientsManagement/patientFacilityRegister/startics";
            } catch (Exception e) {
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/patientsStatisticsRegisterListByFacility", method = RequestMethod.GET)
    public String patientsStatisticsRegisterListByFacility(HttpServletRequest request, Model model, @ModelAttribute("date") String date, @ModelAttribute("visittype") String visittype) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            try {
                Date reportDate = formatter.parse(date);
                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
                List<Map> patientRegisteredList = new ArrayList<>();
                int totalCount = 0;

                if ("allPatients".equals(visittype)) {
                    //Both visit types
                    String[] paramsregisteredBothvisits = {"facilityid", "dateadded"};
                    Object[] paramsValuesparamsregisteredBothvisits = {facilityId, reportDate};
//                    Object[] paramsValuesparamsregisteredBothvisits = {facilityId, formatter.format(reportDate)};
                    // String[] fieldsparamsregisteredBothvisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientvisitid"};
                    String[] fieldsparamsregisteredBothvisits = {"fullname", "gender", "age", "parishname", "villagename", "patientid"};
//                    String whereparamsregisteredBothvisits = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//                    String whereparamsregisteredBothvisits = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                    String whereparamsregisteredBothvisits = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded";
                    List<Object[]> objRegisteredBothvisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsparamsregisteredBothvisits, whereparamsregisteredBothvisits, paramsregisteredBothvisits, paramsValuesparamsregisteredBothvisits);
                    if (objRegisteredBothvisits != null) {

                        Map<String, Object> patientMapBothvisits;
                        for (Object[] register : objRegisteredBothvisits) {

                            patientMapBothvisits = new HashMap<>();
                            patientMapBothvisits.put("names", capitalize(register[0].toString()));
                            patientMapBothvisits.put("gender", register[1]);
                            patientMapBothvisits.put("age", register[2]);
                            patientMapBothvisits.put("parish", register[3]);
                            patientMapBothvisits.put("village", register[4]);
                            //patientMapBothvisits.put("visittype", register[5]);
                            patientMapBothvisits.put("patientid", register[5]);
                            patientRegisteredList.add(patientMapBothvisits);
                        }
                        totalCount = totalCount + patientRegisteredList.size();
                    }

                } else {
                    //filter visit types
                    String[] paramsregisteredOnevisits = {"facilityid", "dateadded", "visittype"};
                    Object[] paramsValuesparamsregisteredOnevisits = {facilityId, reportDate, visittype};
//                    Object[] paramsValuesparamsregisteredOnevisits = {facilityId, formatter.format(reportDate), visittype};
//                    String[] fieldsparamsregisteredOnevisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientvisitid"};
//                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
                    String[] fieldsparamsregisteredOnevisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientid"};
//                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
//                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
                    String whereparamsregisteredOnevisits = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
                    List<Object[]> objRegisteredOnevisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsparamsregisteredOnevisits, whereparamsregisteredOnevisits, paramsregisteredOnevisits, paramsValuesparamsregisteredOnevisits);
                    if (objRegisteredOnevisits != null) {

                        Map<String, Object> patientMapOnevisits;
                        for (Object[] register : objRegisteredOnevisits) {
                            patientMapOnevisits = new HashMap<>();
                            patientMapOnevisits.put("names", capitalize(register[0].toString()));
                            patientMapOnevisits.put("gender", register[1]);
                            patientMapOnevisits.put("age", register[2]);
                            patientMapOnevisits.put("parish", register[3]);
                            patientMapOnevisits.put("village", register[4]);
                            patientMapOnevisits.put("visittype", register[5]);
                            patientMapOnevisits.put("patientid", register[6]);
                            patientRegisteredList.add(patientMapOnevisits);
                        }
                        totalCount = totalCount + patientRegisteredList.size();
                    }
                }
                model.addAttribute("date", date);
                model.addAttribute("patientsTotal", String.format("%,d", totalCount));
                model.addAttribute("patientlist", patientRegisteredList);
                return "patientsManagement/patientFacilityRegister/patients";
            } catch (Exception e) {
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/patientsRegisterStatisticsListByUnit", method = RequestMethod.GET)
    public String patientsRegisterStatisticsListByUnit(HttpServletRequest request, Model model, @ModelAttribute("date") String date, @ModelAttribute("unitid") String unitId, @ModelAttribute("visittype") String visittype) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {

            try {
                Date reportDate = formatter.parse(date);
                Long facilityunitid = Long.parseLong(unitId);
                List<Map> patientRegisteredList = new ArrayList<>();
                int totalCount = 0;

                if ("allPatients".equals(visittype)) {
                    //Both visit types
                    String[] paramsregisteredBothvisits = {"facilityunitid", "dateadded"};
                    Object[] paramsValuesparamsregisteredBothvisits = {facilityunitid, reportDate};
//                    Object[] paramsValuesparamsregisteredBothvisits = {facilityunitid, formatter.format(reportDate)};
//                    String[] fieldsparamsregisteredBothvisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientvisitid"};
                    String[] fieldsparamsregisteredBothvisits = {"fullname", "gender", "age", "parishname", "villagename", "patientid"};
//                    String whereparamsregisteredBothvisits = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded";
//                    String whereparamsregisteredBothvisits = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                    String whereparamsregisteredBothvisits = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded";
                    List<Object[]> objRegisteredBothvisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsparamsregisteredBothvisits, whereparamsregisteredBothvisits, paramsregisteredBothvisits, paramsValuesparamsregisteredBothvisits);
                    if (objRegisteredBothvisits != null) {

                        Map<String, Object> patientMapBothvisits;
                        for (Object[] register : objRegisteredBothvisits) {

                            patientMapBothvisits = new HashMap<>();
                            patientMapBothvisits.put("names", capitalize(register[0].toString()));
                            patientMapBothvisits.put("gender", register[1]);
                            patientMapBothvisits.put("age", register[2]);
                            patientMapBothvisits.put("parish", register[3]);
                            patientMapBothvisits.put("village", register[4]);
                            // patientMapBothvisits.put("visittype", register[5]);
                            patientMapBothvisits.put("patientid", register[5]);
                            patientRegisteredList.add(patientMapBothvisits);
                        }
                        totalCount = totalCount + patientRegisteredList.size();
                    }

                } else {
                    //filter visit types
                    String[] paramsregisteredOnevisits = {"facilityunitid", "dateadded", "visittype"};
//                    Object[] paramsValuesparamsregisteredOnevisits = {facilityunitid, reportDate, visittype};
                    Object[] paramsValuesparamsregisteredOnevisits = {facilityunitid, formatter.format(reportDate), visittype};
//                    String[] fieldsparamsregisteredOnevisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientvisitid"};
//                    String whereparamsregisteredOnevisits = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded AND visittype=:visittype";
                    String[] fieldsparamsregisteredOnevisits = {"fullname", "gender", "age", "parishname", "villagename", "visittype", "patientid"};
//                    String whereparamsregisteredOnevisits = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded AND visittype=:visittype  GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
//                    String whereparamsregisteredOnevisits = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype  GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
                    String whereparamsregisteredOnevisits = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded AND visittype=:visittype  GROUP BY fullname, gender, age, parishname, villagename, visittype, patientid";
                    List<Object[]> objRegisteredOnevisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fieldsparamsregisteredOnevisits, whereparamsregisteredOnevisits, paramsregisteredOnevisits, paramsValuesparamsregisteredOnevisits);
                    if (objRegisteredOnevisits != null) {

                        Map<String, Object> patientMapOnevisits;
                        for (Object[] register : objRegisteredOnevisits) {

                            patientMapOnevisits = new HashMap<>();
                            patientMapOnevisits.put("names", capitalize(register[0].toString()));
                            patientMapOnevisits.put("gender", register[1]);
                            patientMapOnevisits.put("age", register[2]);
                            patientMapOnevisits.put("parish", register[3]);
                            patientMapOnevisits.put("village", register[4]);
                            patientMapOnevisits.put("visittype", register[5]);
                            patientMapOnevisits.put("patientid", register[6]);
                            patientRegisteredList.add(patientMapOnevisits);
                        }
                        totalCount = totalCount + patientRegisteredList.size();
                    }
                }
                model.addAttribute("date", date);
                model.addAttribute("patientsTotal", String.format("%,d", totalCount));
                model.addAttribute("patientlist", patientRegisteredList);
                return "patientsManagement/patientFacilityRegister/patients";
            } catch (Exception e) {
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/viewPatientsStatisticsByUnit", method = RequestMethod.GET)
    public String viewPatientsStatisticsByUnit(HttpServletRequest request, Model model, @ModelAttribute("date") String date, @ModelAttribute("unitid") String unitId) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {

            try {
//                Date reportDate = formatter.parse(date);
//                Long facilityunitid = Long.parseLong(unitId);
//
//                int totalpatientvisit = 0;
//                int totalpatientvisitbelow5 = 0;
//                int totalpatientvisit5to12 = 0;
//                int totalpatientvisit13andabove = 0;
//
//                int totalpatientsMale = 0;
//                int totalpatientsFemale = 0;
//
//                int totalFemaleNew = 0;
//                int totalFemaleOld = 0;
//
//                int totalMaleNew = 0;
//                int totalMaleOld = 0;
//
//                int totalPatientsNew = 0;
//                int totalPatientsOld = 0;
//
//                int zeroTo4YearsNew = 0;
//                int zerotO4yearsOld = 0;
//
//                int zeroTo4YearsNewFemale = 0;
//                int zeroTo4YearsNewMale = 0;
//                int zerotO4yearsOldMale = 0;
//                int zerotO4yearsOldFemale = 0;
//
//                int fiveTo12YearsNew = 0;
//                int fiveTo12YearsOld = 0;
//
//                int fiveTo12YearsNewFemale = 0;
//                int fiveTo12YearsNewMale = 0;
//                int fiveTo12YearsOldMale = 0;
//                int fiveTo12YearsOldFemale = 0;
//
//                int above13YearsNew = 0;
//                int above13YearsOld = 0;
//                int above13YearsNewFemale = 0;
//                int above13YearsNewMale = 0;
//                int above13YearsOldMale = 0;
//                int above13YearsOldFemale = 0;
//
//                String[] paramspatienttotvisits = {"facilityunitid", "dateadded"};
//                Object[] paramsValuespatienttot = {facilityunitid, reportDate};
//                String wherepatienttot = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded";
//                totalpatientvisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot);
//
//                String[] paramspatienttotvisitsnew = {"facilityunitid", "dateadded", "visittype"};
//                Object[] paramsValuespatienttotnew = {facilityunitid, reportDate, "NEWVISIT"};
//                String wherepatienttotnew = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded AND visittype=:visittype";
//                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttotnew, paramspatienttotvisitsnew, paramsValuespatienttotnew);
//
//                String[] paramspatienttotvisitsold = {"facilityunitid", "dateadded", "visittype"};
//                Object[] paramsValuespatienttotold = {facilityunitid, reportDate, "REVISIT"};
//                String wherepatienttotold = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded AND visittype=:visittype";
//                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, wherepatienttotold, paramspatienttotvisitsold, paramsValuespatienttotold);
//
//                String[] paramspatientgender = {"facilityunitid", "dateadded"};
//                Object[] paramsValuespatiengender = {facilityunitid, reportDate};
//                String[] fields5patientgender = {"patientvisitid", "gender", "visittype"};
//                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patientgender, "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded", paramspatientgender, paramsValuespatiengender);
//                if (objpatientgender != null) {
//                    for (Object[] patienttotgender : objpatientgender) {
//                        if ("Female".equals((String) patienttotgender[1])) {
//                            if ("NEWVISIT".equals((String) patienttotgender[2])) {
//                                totalFemaleNew = totalFemaleNew + 1;
//                            } else {
//                                totalFemaleOld = totalFemaleOld + 1;
//                            }
//                            totalpatientsFemale = totalpatientsFemale + 1;
//                        }
//                        if ("Male".equals((String) patienttotgender[1])) {
//                            if ("NEWVISIT".equals((String) patienttotgender[2])) {
//                                totalMaleNew = totalMaleNew + 1;
//                            } else {
//                                totalMaleOld = totalMaleOld + 1;
//                            }
//                            totalpatientsMale = totalpatientsMale + 1;
//                        }
//                    }
//                }
//
//                String[] paramspatienttotvisitsage = {"facilityunitid", "dateadded"};
//                Object[] paramsValuespatienttotage = {facilityunitid, reportDate};
//                String[] fields5patienttotage = {"patientvisitid", "dob", "visittype", "gender"};
//                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields5patienttotage, "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded", paramspatienttotvisitsage, paramsValuespatienttotage);
//                if (objpatienttotage != null) {
//                    for (Object[] patienttotage : objpatienttotage) {
//
//                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
//                        int currentyear = Integer.parseInt(df.format(new Date()));
//                        int estimatedage = currentyear - year;
//
//                        if (estimatedage < 5) {
//                            if ("NEWVISIT".equals((String) patienttotage[2])) {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    zeroTo4YearsNewMale = zeroTo4YearsNewMale + 1;
//                                } else {
//                                    zeroTo4YearsNewFemale = zeroTo4YearsNewFemale + 1;
//                                }
//                                zeroTo4YearsNew = zeroTo4YearsNew + 1;
//                            } else {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    zerotO4yearsOldMale = zerotO4yearsOldMale + 1;
//                                } else {
//                                    zerotO4yearsOldFemale = zerotO4yearsOldFemale + 1;
//                                }
//                                zerotO4yearsOld = zerotO4yearsOld + 1;
//                            }
//                            totalpatientvisitbelow5 = totalpatientvisitbelow5 + 1;
//                        }
//
//                        if (estimatedage >= 5 && estimatedage <= 12) {
//                            if ("NEWVISIT".equals((String) patienttotage[2])) {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    fiveTo12YearsNewMale = fiveTo12YearsNewMale + 1;
//                                } else {
//                                    fiveTo12YearsNewFemale = fiveTo12YearsNewFemale + 1;
//                                }
//                                fiveTo12YearsNew = fiveTo12YearsNew + 1;
//                            } else {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    fiveTo12YearsOldMale = fiveTo12YearsOldMale + 1;
//                                } else {
//                                    fiveTo12YearsOldFemale = fiveTo12YearsOldFemale + 1;
//                                }
//                                fiveTo12YearsOld = fiveTo12YearsOld + 1;
//                            }
//                            totalpatientvisit5to12 = totalpatientvisit5to12 + 1;
//                        }
//
//                        if (estimatedage >= 13) {
//                            if ("NEWVISIT".equals((String) patienttotage[2])) {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    above13YearsNewMale = above13YearsNewMale + 1;
//                                } else {
//                                    above13YearsNewFemale = above13YearsNewFemale + 1;
//                                }
//                                above13YearsNew = above13YearsNew + 1;
//                            } else {
//                                if ("Male".equals((String) patienttotage[3])) {
//                                    above13YearsOldMale = above13YearsOldMale + 1;
//                                } else {
//                                    above13YearsOldFemale = above13YearsOldFemale + 1;
//                                }
//                                above13YearsOld = above13YearsOld + 1;
//                            }
//                            totalpatientvisit13andabove = totalpatientvisit13andabove + 1;
//                        }
//                    }
//                }
//
//                model.addAttribute("totalpatientsFemale", totalpatientsFemale);
//                model.addAttribute("totalpatientsMale", totalpatientsMale);
//                model.addAttribute("totalpatientvisit", totalpatientvisit);
//                model.addAttribute("totalpatientvisitbelow5", totalpatientvisitbelow5);
//                model.addAttribute("totalpatientvisit5to12", totalpatientvisit5to12);
//                model.addAttribute("totalpatientvisit13andabove", totalpatientvisit13andabove);
//
//                model.addAttribute("totalFemaleNew", totalFemaleNew);
//                model.addAttribute("totalFemaleOld", totalFemaleOld);
//                model.addAttribute("totalMaleNew", totalMaleNew);
//                model.addAttribute("totalMaleOld", totalMaleOld);
//
//                model.addAttribute("totalPatientsNew", totalPatientsNew);
//                model.addAttribute("totalPatientsOld", totalPatientsOld);
//
//                model.addAttribute("zeroTo4YearsNew", zeroTo4YearsNew);
//                model.addAttribute("zerotO4yearsOld", zerotO4yearsOld);
//
//                model.addAttribute("zeroTo4YearsNewFemale", zeroTo4YearsNewFemale);
//                model.addAttribute("zeroTo4YearsNewMale", zeroTo4YearsNewMale);
//                model.addAttribute("zerotO4yearsOldFemale", zerotO4yearsOldFemale);
//                model.addAttribute("zerotO4yearsOldMale", zerotO4yearsOldMale);
//
//                model.addAttribute("fiveTo12YearsNew", fiveTo12YearsNew);
//                model.addAttribute("fiveTo12YearsOld", fiveTo12YearsOld);
//
//                model.addAttribute("fiveTo12YearsNewFemale", fiveTo12YearsNewFemale);
//                model.addAttribute("fiveTo12YearsNewMale", fiveTo12YearsNewMale);
//                model.addAttribute("fiveTo12YearsOldFemale", fiveTo12YearsOldFemale);
//                model.addAttribute("fiveTo12YearsOldMale", fiveTo12YearsOldMale);
//
//                model.addAttribute("above13YearsNew", above13YearsNew);
//                model.addAttribute("above13YearsOld", above13YearsOld);
//
//                model.addAttribute("above13YearsNewFemale", above13YearsNewFemale);
//                model.addAttribute("above13YearsNewMale", above13YearsNewMale);
//                model.addAttribute("above13YearsOldFemale", above13YearsOldFemale);
//                model.addAttribute("above13YearsOldMale", above13YearsOldMale);
//
//                return "patientsManagement/patientFacilityRegister/startics";
                Date reportDate = formatter.parse(date);
                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
                Long facilityunitid = Long.parseLong(unitId);

                int totalPatientVisit = 0;
                int totalPatientVisitBelow29Days = 0;
                int totalPatientVisit29DaysTo4Yrs = 0;
                int totalPatientVisit5YrsTo59Yrs = 0;
                int totalPatientVisit60AndAbove = 0;

                int totalPatientsMale = 0;
                int totalPatientsFemale = 0;

                int totalFemaleNew = 0;
                int totalFemaleOld = 0;

                int totalMaleNew = 0;
                int totalMaleOld = 0;

                int totalPatientsNew = 0;
                int totalPatientsOld = 0;

                int zeroTo28DaysNew = 0;
                int zeroTo28DaysOld = 0;

                int zeroTo28DaysNewFemale = 0;
                int zeroTo28DaysNewMale = 0;
                int zeroTo28DaysOldMale = 0;
                int zeroTo28DaysOldFemale = 0;

                int days29To4YrsNew = 0;
                int days29To4YrsOld = 0;

                int days29To4YrsNewFemale = 0;
                int days29To4YrsNewMale = 0;
                int days29To4YrsOldMale = 0;
                int days29To4YrsOldFemale = 0;

                int yrs5TO59New = 0;
                int yrs5TO59Old = 0;
                int yrs5TO59NewFemale = 0;
                int yrs5TO59NewMale = 0;
                int yrs5TO59OldMale = 0;
                int yrs5TO59OldFemale = 0;

                int yrs60AndAboveNew = 0;
                int yrs60AndAboveOld = 0;
                int yrs60AndAboveNewFemale = 0;
                int yrs60AndAboveNewMale = 0;
                int yrs60AndAboveOldMale = 0;
                int yrs60AndAboveOldFemale = 0;

                String[] params = {"facilityid", "facilityunitid", "dateadded"};
                Object[] paramsValues = {facilityId, facilityunitid, reportDate};
//                Object[] paramsValues = {facilityId, facilityunitid, formatter.format(reportDate)};
//                String where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                String where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded";
                totalPatientVisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "facilityunitid", "dateadded", "visittype"};
                paramsValues = new Object[] {facilityId, facilityunitid, reportDate, "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND dateadded=:dateadded AND visittype=:visittype";
//                paramsValues = new Object[]{facilityId, facilityunitid, formatter.format(reportDate), "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "facilityunitid", "dateadded", "visittype"};
                paramsValues = new Object[] {facilityId, facilityunitid, reportDate, "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND dateadded=:dateadded AND visittype=:visittype";
//                paramsValues = new Object[]{facilityId, facilityunitid, formatter.format(reportDate), "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "facilityunitid", "dateadded"};
//                paramsValues = new Object[] {facilityId, facilityunitid, reportDate};
                paramsValues = new Object[]{facilityId, facilityunitid, formatter.format(reportDate)};
                String[] fields = {"patientvisitid", "gender", "visittype"};
//                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded", params, paramsValues);
                if (objpatientgender != null) {
                    for (Object[] patienttotgender : objpatientgender) {
                        if ("Female".toLowerCase().equals(((String) patienttotgender[1]).toLowerCase())) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotgender[2]).toUpperCase())) {
                                totalFemaleNew += 1;
                            } else {
                                totalFemaleOld += 1;
                            }
                            totalPatientsFemale += 1;
                        }
                        if ("Male".toUpperCase().equals(((String) patienttotgender[1]).toUpperCase())) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotgender[2]).toLowerCase())) {
                                totalMaleNew += 1;
                            } else {
                                totalMaleOld += 1;
                            }
                            totalPatientsMale += 1;
                        }
                    }
                }

                params = new String[]{"facilityid", "facilityunitid", "dateadded"};
                paramsValues = new Object[] {facilityId, facilityunitid, reportDate};
//                paramsValues = new Object[]{facilityId, facilityunitid, formatter.format(reportDate)};
                fields = new String[]{"patientvisitid", "dob", "visittype", "gender"};
//                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded", params, paramsValues);
                if (objpatienttotage != null) {
                    for (Object[] patienttotage : objpatienttotage) {

                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                        int currentyear = Integer.parseInt(df.format(new Date()));
                        Long estimatedAgeInDays = getDays(new Date(), ((Date) patienttotage[1]));
                        int estimatedAgeInYears = currentyear - year;
                        if ((estimatedAgeInDays <= 28 && estimatedAgeInYears == 0)) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    zeroTo28DaysNewMale += 1;
                                } else {
                                    zeroTo28DaysNewFemale += 1;
                                }
                                zeroTo28DaysNew += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    zeroTo28DaysOldMale += 1;
                                } else {
                                    zeroTo28DaysOldFemale += 1;
                                }
                                zeroTo28DaysOld += 1;
                            }
                            totalPatientVisitBelow29Days += 1;
                        } else if (estimatedAgeInDays >= 29 && estimatedAgeInYears <= 4) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotage[2]).toLowerCase())) {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    days29To4YrsNewMale += 1;
                                } else {
                                    days29To4YrsNewFemale += 1;
                                }
                                days29To4YrsNew += 1;
                            } else {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    days29To4YrsOldMale += 1;
                                } else {
                                    days29To4YrsOldFemale += 1;
                                }
                                days29To4YrsOld += 1;
                            }

                            totalPatientVisit29DaysTo4Yrs += 1;
                        } else if (estimatedAgeInYears >= 5 && estimatedAgeInYears <= 59) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    yrs5TO59NewMale += 1;
                                } else {
                                    yrs5TO59NewFemale += 1;
                                }
                                yrs5TO59New += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    yrs5TO59OldMale += 1;
                                } else {
                                    yrs5TO59OldFemale += 1;
                                }
                                yrs5TO59Old += 1;
                            }
                            totalPatientVisit5YrsTo59Yrs += 1;
                        } else if (estimatedAgeInYears >= 60) {
                            if ("NEWVISIT".equals((String) patienttotage[2])) {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveNewMale += 1;
                                } else {
                                    yrs60AndAboveNewFemale += 1;
                                }
                                yrs60AndAboveNew += 1;
                            } else {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveOldMale += 1;
                                } else {
                                    yrs60AndAboveOldFemale += 1;
                                }
                                yrs60AndAboveOld += 1;
                            }
                            totalPatientVisit60AndAbove += 1;
                        }
                    }
                }

                model.addAttribute("totalpatientsFemale", totalPatientsFemale);
                model.addAttribute("totalpatientsMale", totalPatientsMale);
                model.addAttribute("totalpatientvisit", totalPatientVisit);
                model.addAttribute("totalPatientVisitBelow29Days", totalPatientVisitBelow29Days);
                model.addAttribute("totalPatientVisit29DaysTo4Yrs", totalPatientVisit29DaysTo4Yrs);
                model.addAttribute("totalPatientVisit5YrsTo59Yrs", totalPatientVisit5YrsTo59Yrs);
                model.addAttribute("totalPatientVisit60AndAbove", totalPatientVisit60AndAbove);

                model.addAttribute("totalFemaleNew", totalFemaleNew);
                model.addAttribute("totalFemaleOld", totalFemaleOld);
                model.addAttribute("totalMaleNew", totalMaleNew);
                model.addAttribute("totalMaleOld", totalMaleOld);

                model.addAttribute("totalPatientsNew", totalPatientsNew);
                model.addAttribute("totalPatientsOld", totalPatientsOld);

                model.addAttribute("zeroTo28DaysNew", zeroTo28DaysNew);
                model.addAttribute("zeroTo28DaysOld", zeroTo28DaysOld);

                model.addAttribute("zeroTo28DaysNewFemale", zeroTo28DaysNewFemale);
                model.addAttribute("zeroTo28DaysNewMale", zeroTo28DaysNewMale);
                model.addAttribute("zeroTo28DaysOldFemale", zeroTo28DaysOldFemale);
                model.addAttribute("zeroTo28DaysOldMale", zeroTo28DaysOldMale);

                model.addAttribute("days29To4YrsNew", days29To4YrsNew);
                model.addAttribute("days29To4YrsOld", days29To4YrsOld);

                model.addAttribute("days29To4YrsNewFemale", days29To4YrsNewFemale);
                model.addAttribute("days29To4YrsNewMale", days29To4YrsNewMale);
                model.addAttribute("days29To4YrsOldFemale", days29To4YrsOldFemale);
                model.addAttribute("days29To4YrsOldMale", days29To4YrsOldMale);

                model.addAttribute("yrs5TO59New", yrs5TO59New);
                model.addAttribute("yrs5TO59Old", yrs5TO59Old);

                model.addAttribute("yrs5TO59NewFemale", yrs5TO59NewFemale);
                model.addAttribute("yrs5TO59NewMale", yrs5TO59NewMale);
                model.addAttribute("yrs5TO59OldFemale", yrs5TO59OldFemale);
                model.addAttribute("yrs5TO59OldMale", yrs5TO59OldMale);

                model.addAttribute("yrs60AndAboveNew", yrs60AndAboveNew);
                model.addAttribute("yrs60AndAboveOld", yrs60AndAboveOld);

                model.addAttribute("yrs60AndAboveNewFemale", yrs60AndAboveNewFemale);
                model.addAttribute("yrs60AndAboveNewMale", yrs60AndAboveNewMale);
                model.addAttribute("yrs60AndAboveOldFemale", yrs60AndAboveOldFemale);
                model.addAttribute("yrs60AndAboveOldMale", yrs60AndAboveOldMale);

                return "patientsManagement/patientFacilityRegister/startics";
            } catch (Exception e) {
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/getUnitPatientReportPane", method = RequestMethod.GET)
    public String getUnitPatientReportPane(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
            return "patientsManagement/unitRegister/patientRegister";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnitPatientRegister", method = RequestMethod.POST)
    public String fetchUnitPatientRegister(HttpServletRequest request, Model model, @ModelAttribute("date") String date) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
                Date reportDate = formatter.parse(date);
                List<Map> patientsVisits = new ArrayList<>();

                String[] params = {"facilityunitid", "dateadded"};
                Object[] paramsValues = {facilityUnit, reportDate};
//                Object[] paramsValues = {facilityUnit, formatter.format(reportDate)};
//                Commented Out Because It Produces Duplicates.
//                String[] fields = {"fullname", "visitnumber", "gender", "age", "parishname", "villagename", "patientvisitid"};
                String[] fields = {"fullname", "gender", "age", "parishname", "villagename", "patientid"};
//                String where = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
                String where = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded";
                List<Object[]> visits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
                if (visits != null) {
                    Map<String, Object> patient;
                    for (Object[] visit : visits) {
                        patient = new HashMap<>();
                        patient.put("names", capitalize(visit[0].toString()));
                        // patient.put("visitno", visit[1]);
                        patient.put("gender", visit[1]);
                        patient.put("age", visit[2]);
                        patient.put("parish", visit[3]);
                        patient.put("village", visit[4]);
                        patient.put("patientid", visit[5]);

                        patientsVisits.add(patient);
                    }
                }

                long revisits = 0;
                long newVisits = 0;
                String[] params2 = {"facilityunitid", "dateadded"};
                Object[] paramsValues2 = {facilityUnit, reportDate};
//                Object[] paramsValues2 = {facilityUnit, formatter.format(reportDate)};
                String[] fields2 = {"COUNT(r.patientvisitid)", "r.visittype"};
//                String where2 = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded GROUP BY r.visittype";
//                String where2 = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded GROUP BY r.visittype";
                String where2 = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded GROUP BY r.visittype";
                List<Object[]> patientGroups = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, fields2, where2, params2, paramsValues2, 0, 0);
                if (patientGroups != null) {
                    for (Object[] group : patientGroups) {
                        if ("REVISIT".equals((String) group[1])) {
                            revisits = (long) group[0];
                            continue;
                        }
                        if ("NEWVISIT".equals((String) group[1])) {
                            newVisits = (long) group[0];
                        }
                    }
                }
                model.addAttribute("date", date);
                model.addAttribute("revisits", revisits);
                model.addAttribute("newvisits", newVisits);
                model.addAttribute("visits", patientsVisits);
                return "patientsManagement/unitRegister/patients";
            } catch (ParseException e) {
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/unitRegisterPrintOut", method = RequestMethod.GET)
    public String unitRegisterPrintOut(HttpServletRequest request, Model model, @ModelAttribute("unitid") Integer facilityUnit, @ModelAttribute("unit") String unit, @ModelAttribute("date") String date, @ModelAttribute("facility") String facility) {
        try {
            Date reportDate = formatter.parse(date);
            List<Map> patientsVisits = new ArrayList<>();

            String[] params = {"facilityunitid", "dateadded"};
            Object[] paramsValues = {facilityUnit, reportDate};
//            Object[] paramsValues = {facilityUnit, formatter.format(reportDate)};
//            Commented Out Because It Produces Duplicates.
//            String[] fields = {"fullname", "visitnumber", "gender", "age", "parishname", "villagename", "patientvisitid"};
            String[] fields = {"fullname", "gender", "age", "parishname", "villagename"};
//            String where = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded";
//            String where = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
            String where = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded";
            List<Object[]> visits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (visits != null) {
                Map<String, Object> patient;
                for (Object[] visit : visits) {
                    patient = new HashMap<>();
                    patient.put("names", capitalize(visit[0].toString()));
                    // patient.put("visitno", visit[1]);
                    patient.put("gender", visit[1]);
                    patient.put("age", computeAge((Integer) visit[2]));
                    patient.put("parish", visit[3]);
                    patient.put("village", visit[4]);

                    patientsVisits.add(patient);
                }
            }

            long revisits = 0;
            long newVisits = 0;
            String[] params2 = {"facilityunitid", "dateadded"};
            Object[] paramsValues2 = {facilityUnit, reportDate};
//            Object[] paramsValues2 = {facilityUnit, formatter.format(reportDate)};
            String[] fields2 = {"COUNT(r.patientvisitid)", "r.visittype"};
//            String where2 = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded GROUP BY r.visittype";
//            String where2 = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded GROUP BY r.visittype";
            String where2 = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded GROUP BY r.visittype";
            List<Object[]> patientGroups = (List<Object[]>) genericClassService.fetchRecordFunction(Patientstartisticsview.class, fields2, where2, params2, paramsValues2, 0, 0);
            if (patientGroups != null) {
                for (Object[] group : patientGroups) {
                    if ("REVISIT".equals((String) group[1])) {
                        revisits = (long) group[0];
                        continue;
                    }
                    if ("NEWVISIT".equals((String) group[1])) {
                        newVisits = (long) group[0];
                    }
                }
            }

            model.addAttribute("date", date);
            model.addAttribute("revisits", revisits);
            model.addAttribute("newvisits", newVisits);
            model.addAttribute("visits", patientsVisits);
            model.addAttribute("unit", unit.replace("@--@", " "));
            model.addAttribute("facility", facility.replace("@--@", " "));
            return "patientsManagement/unitRegister/printRegister";
        } catch (ParseException e) {
            return "patientsManagement/unitRegister/dateError";
        }
    }

    @RequestMapping(value = "/printUnitRegister", method = RequestMethod.GET)
    public @ResponseBody
    String createDiscrepancyReportPDF(HttpServletRequest request, Model model, @ModelAttribute("date") String date) {
        String baseEncode = "";
        String facility = ((Facility) request.getSession().getAttribute("sessionActiveLoginFacilityObj")).getFacilityname();
        String unit = ((Facilityunit) request.getSession().getAttribute("sessionActiveLoginFacilityUnitObj")).getFacilityunitname();
        Integer unitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

        String url = IICS.BASE_URL + "patient/unitRegisterPrintOut.htm?unitid=" + unitid + "&unit=" + unit + "&date=" + date + "&facility=" + facility;
        String path = getUnitRegisterPath() + unitid + date.replace("-", "") + ".pdf";
        PdfWriter pdfWriter;
        Document document = new Document();
        try {
            pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
            document.setPageSize(PageSize.A4);
            document.setMargins(15, 15, 30, 30);
            document.open();

            URL myWebPage = new URL(url.replaceAll(" ", "@--@"));
            InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
            XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
            worker.parseXHtml(pdfWriter, document, fis);

            document.close();
            pdfWriter.close();
            File pdf = new File(path);
            if (pdf.exists()) {
                baseEncode = Base64.getEncoder().encodeToString(loadFileAsBytesArray(path));
                pdf.delete();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return baseEncode;
    }

    @RequestMapping(value = "/checkpatientinqueue", method = RequestMethod.GET)
    public @ResponseBody
    String checkPatientInQueue(HttpServletRequest request) {
        String result = "";
        try {
            long patientid = Long.parseLong(request.getParameter("patientid"));
            Map<String, Object> queueDetails = null;
//            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");            
            String[] fields = {"patientvisitid", "facilityunitid"};
//            String where = "WHERE r.patientid=:patientid AND dateadded=:dateadded";
//            String where = "WHERE r.patientid=:patientid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
            String where = "WHERE r.patientid=:patientid AND DATE(dateadded)=:dateadded";
            String[] params = {"patientid", "dateadded"};
            Object [] paramsValues = { patientid, new Date() };
//            Object[] paramsValues = {patientid, formatter.format(new Date())};
            List<Object[]> visits = (List<Object[]>) genericClassService.fetchRecord(Patientvisit.class, fields, where, params, paramsValues);
            if (visits != null) {
                String facilityUnitServiceName = "";
                String facilityUnitName = "";
                SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
                for (Object[] visit : visits) {
//                    int facilityUnitCount = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE facilityunitid=:unitid AND facilityid=:facilityid", new String [] { "unitid", "facilityid" }, new Object [] { visit[1], facilityId });
                    List<Object> facilityUnits = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityid"}, "WHERE facilityunitid=:unitid", new String[]{"unitid"}, new Object[]{visit[1]});
                    int facilityUnitCount = (facilityUnits != null && facilityUnits.get(0) != null) ? facilityUnits.size() : 0;
                    if (facilityUnitCount != 0) {
                        long facilityId = Long.parseLong(facilityUnits.get(0).toString());
                        fields = new String[]{"addedby", "timein", "unitserviceid"};
                        where = "WHERE r.patientvisitid=:patientvisitid AND r.serviced=:serviced";
                        params = new String[]{"patientvisitid", "serviced"};
                        paramsValues = new Object[]{visit[0], Boolean.FALSE};
                        List<Object[]> queue = (List<Object[]>) genericClassService.fetchRecord(Servicequeue.class, fields, where, params, paramsValues);
                        if (queue != null) {
                            if (queueDetails == null) {
                                queueDetails = new HashMap<>();
                            }
                            List<Object[]> addedby = ((List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, new String[]{"staffid", "firstname", "lastname", "othernames"}, "WHERE staffid=:staffid", new String[]{"staffid"}, new Object[]{(queue.get(0)[0])}));
                            if (addedby != null) {
                                if (addedby.get(0)[3] != null) {
                                    queueDetails.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2] + " " + (String) addedby.get(0)[3]);
                                } else {
                                    queueDetails.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2]);
                                }
                            }
                            System.out.println(dateFormat.format(((Date) queue.get(0)[1])));
                            queueDetails.put("timein", dateFormat.format(((Date) queue.get(0)[1])));
                            List<Object[]> facilityUnitServiceInfo = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservicesview.class, new String[]{"servicename", "facilityunitname"}, "WHERE facilityunitserviceid=:facilityunitserviceid", new String[]{"facilityunitserviceid"}, new Object[]{Long.parseLong(queue.get(0)[2].toString())});
                            if (facilityUnitServiceInfo != null) {
                                facilityUnitServiceName = facilityUnitServiceInfo.get(0)[0].toString();
                                facilityUnitName = facilityUnitServiceInfo.get(0)[1].toString();
                            }
                            //
                            fields = new String[]{"facilityname", "phonecontact"};
                            params = new String[]{"facilityid"};
                            paramsValues = new Object[]{facilityId};
                            where = "WHERE facilityid=:facilityid";
                            List<Object[]> facilityNames = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                            if (facilityNames != null) {
                                queueDetails.put("facilityname", facilityNames.get(0)[0]);
                                queueDetails.put("contact", facilityNames.get(0)[1]);
                            }
                            //
                            queueDetails.put("unitservice", facilityUnitServiceName);
                            queueDetails.put("unit", facilityUnitName);
                            break;
                        } else {
                            queueDetails = null;
                        }
                    }
                }
            }
            result = new ObjectMapper().writeValueAsString(queueDetails);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/facilitypatientvisitdetails", method = RequestMethod.GET)
    public String getFacilityPatientVisitDetails(HttpServletRequest request, Model model) {
        try {
            Date reportDate = formatter.parse(request.getParameter("date"));
            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            BigInteger patientid = BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")));
            List<Map> patientVisitDetails = new ArrayList<>();
            int totalCount = 0;
            String[] params = {"facilityid", "dateadded", "patientid"};
            Object[] paramsValues = {facilityId, reportDate, patientid};
//            Object[] paramsValues = {facilityId, formatter.format(reportDate), patientid};
            String[] fields = {"fullname", "visitnumber", "patientvisitid", "visittype", "visitpriority", "dateadded", "addedby"};
//            String where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND patientid=:patientid";
//            String where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND patientid=:patientid";
            String where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND patientid=:patientid";
            List<Object[]> visits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (visits != null) {
                Map<String, Object> patient;
                for (Object[] visit : visits) {
                    patient = new HashMap<>();
                    patient.put("name", capitalize(visit[0].toString()));
                    patient.put("visitnumber", visit[1]);
                    patient.put("patientvisitid", visit[2]);
                    patient.put("visittype", visit[3]);
                    patient.put("visitpriority", visit[4]);
                    SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                    patient.put("dateadded", f.format(visit[5]));
//                    long result = getDays(((Date) visit[5]), new Date());
//                    String days = String.valueOf(result);
//                    if(result == 0){
//                        days = "Today";
//                    }else if(result == 1){                        
//                        days +=  " day ago";
//                    }else if(result > 1){
//                        days += " days ago";
//                    }
//                    patient.put("days", days);
                    patient.put("personid", visit[6]);
                    List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Person.class,
                            new String[]{"personid", "firstname", "lastname", "othernames"},
                            "WHERE personid=:personid", new String[]{"personid"},
                            new Object[]{BigInteger.valueOf(Long.parseLong(visit[6].toString()))});
                    if (addedby != null) {
                        if (addedby.get(0)[3] != null) {
                            patient.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2] + " " + (String) addedby.get(0)[3]);
                        } else {
                            patient.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2]);
                        }
                    }
                    patientVisitDetails.add(patient);
                }
            }
            model.addAttribute("patientVisitDetails", patientVisitDetails);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "patientsManagement/patientFacilityRegister/patientVisits";
    }

    @RequestMapping(value = "/unitpatientvisitdetails", method = RequestMethod.GET)
    public String getUnitPatientVisitDetails(HttpServletRequest request, Model model) {
        try {
            List<Map> patientVisitDetails = new ArrayList<>();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            BigInteger patientid = BigInteger.valueOf(Long.parseLong(request.getParameter("patientid")));
            Date reportDate = formatter.parse(request.getParameter("date"));
            String[] params = {"facilityunitid", "dateadded", "patientid"};
            Object[] paramsValues = {facilityUnit, reportDate, patientid};
//            Object[] paramsValues = {facilityUnit, formatter.format(reportDate), patientid};
            String[] fields = {"fullname", "visitnumber", "patientvisitid", "visittype", "visitpriority", "dateadded", "addedby"};
//            String where = "WHERE facilityunitid=:facilityunitid AND dateadded=:dateadded AND patientid=:patientid";
//            String where = "WHERE facilityunitid=:facilityunitid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND patientid=:patientid";
            String where = "WHERE facilityunitid=:facilityunitid AND DATE(dateadded)=:dateadded AND patientid=:patientid";
            List<Object[]> visits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if (visits != null) {
                Map<String, Object> patient;
                for (Object[] visit : visits) {
                    patient = new HashMap<>();
                    patient.put("name", capitalize(visit[0].toString()));
                    patient.put("visitnumber", visit[1]);
                    patient.put("patientvisitid", visit[2]);
                    patient.put("visittype", visit[3]);
                    patient.put("visitpriority", visit[4]);
                    SimpleDateFormat f = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                    patient.put("dateadded", f.format(visit[5]));
//                    Long result = getDays(((Date) visit[5]), new Date());
//                    String days = String.valueOf(result);
//                    if(result == 0){
//                        days = "Today";
//                    }else if(result == 1) {                        
//                        days += " day ago";
//                    }else if(result > 1){
//                        days += " days ago";
//                    }
//                    patient.put("days", days);
                    patient.put("personid", visit[6]);
                    List<Object[]> addedby = (List<Object[]>) genericClassService.fetchRecord(Person.class,
                            new String[]{"personid", "firstname", "lastname", "othernames"},
                            "WHERE personid=:personid", new String[]{"personid"},
                            new Object[]{BigInteger.valueOf(Long.parseLong(visit[6].toString()))});
                    if (addedby != null) {
                        if (addedby.get(0)[3] != null) {
                            patient.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2] + " " + (String) addedby.get(0)[3]);
                        } else {
                            patient.put("addedby", (String) addedby.get(0)[1] + " " + (String) addedby.get(0)[2]);
                        }
                    }
                    patientVisitDetails.add(patient);
                }
            }
            model.addAttribute("patientVisitDetails", patientVisitDetails);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "patientsManagement/unitRegister/patientVisits";
    }

    @RequestMapping(value = "/registrardetails", method = RequestMethod.GET)
    public String registrarDetails(HttpServletRequest request,
            Model model, @ModelAttribute("personid") String personid,
            @ModelAttribute("patientvisitid") String patientvisitid) {
        try {
            Map<String, Object> person = new HashMap<>();
            List<Object[]> persons = (List<Object[]>) genericClassService.fetchRecord(Person.class,
                    new String[]{"personid", "firstname", "lastname", "othernames"},
                    "WHERE personid=:personid", new String[]{"personid"},
                    new Object[]{BigInteger.valueOf(Long.parseLong(personid))});
            if (persons != null) {
                if (persons.get(0)[3] != null) {
                    model.addAttribute("name", (String) persons.get(0)[1]
                            + " " + (String) persons.get(0)[2] + " " + (String) persons.get(0)[3]);
                } else {
                    model.addAttribute("name", (String) persons.get(0)[1] + " " + (String) persons.get(0)[2]);
                }
//                List<Object[]> patientsRegisteredList = (List<Object[]>) genericClassService.fetchRecordFunction(Registrarpatients.class, new String[]{"COUNT(r.patientid)"},
//                        "WHERE addedby=:personid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND facilityid=:facilityid GROUP BY r.addedby, r.patientid",
//                        new String[]{"personid", "dateadded", "facilityid"},
//                        new Object[]{BigInteger.valueOf(Long.parseLong(personid)), formatter.format(new Date()),
//                            Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString())}, 0, 0);
                List<Object[]> patientsRegisteredList = (List<Object[]>) genericClassService.fetchRecordFunction(Registrarpatients.class, new String[]{"COUNT(r.patientid)"},
                        "WHERE addedby=:personid AND DATE(dateadded)=:dateadded AND facilityid=:facilityid GROUP BY r.addedby, r.patientid",
                        new String[]{"personid", "dateadded", "facilityid"},
                        new Object[]{BigInteger.valueOf(Long.parseLong(personid)), new Date(),
                            Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString())}, 0, 0);
                if (patientsRegisteredList != null) {
                    model.addAttribute("patientsRegistered", patientsRegisteredList.size());
                } else {
                    model.addAttribute("patientsRegistered", 0);
                }
                List<Object> facilityUnitIds = (List<Object>) genericClassService.fetchRecord(Patientvisit.class,
                        new String[]{"facilityunitid"}, "WHERE addedby=:personid AND patientvisitid=:patientvisitid",
                        new String[]{"personid", "patientvisitid"},
                        new Object[]{BigInteger.valueOf(Long.parseLong(personid)), Long.parseLong(patientvisitid)});
                if (facilityUnitIds != null) {
                    List<Object> facilityUnitNames = (List<Object>) genericClassService.fetchRecord(Facilityunit.class,
                            new String[]{"facilityunitname"}, "WHERE facilityunitid=:facilityunitid",
                            new String[]{"facilityunitid"},
                            new Object[]{Long.parseLong(facilityUnitIds.get(0).toString())});
                    if (facilityUnitNames != null) {
                        model.addAttribute("facilityunitname", facilityUnitNames.get(0));
                    }
                }
                List<Object[]> contacts = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class,
                        new String[]{"contactvalue", "contacttype"}, "WHERE personid=:personid", new String[]{"personid"},
                        new Object[]{Long.parseLong(personid)});
                if (contacts != null) {
                    String tel = "";
                    for (Object[] contact : contacts) {
                        if (contact[0].toString().equalsIgnoreCase("EMAIL")) {
                            model.addAttribute("email", contact[1]);
                        } else if (contact[0].toString().equalsIgnoreCase("PRIMARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        } else if (contact[0].toString().equalsIgnoreCase("SECONDARYCONTACT")) {
                            tel += (tel.length() != 0) ? "/" + contact[1] : contact[1];
                        }
                    }
                    model.addAttribute("contacts", tel);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return "patientsManagement/views/registrarDetails";
    }

    public Long getDays(Date start, Date end)
            throws ParseException {
        long diffInMillies = Math.abs(end.getTime() - start.getTime());
        long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        return diff;
    }

    private String getVisitNumber(Integer facilityunitid) {
        String currentNo;
        String unit = facilityunitid.toString();
        SimpleDateFormat f = new SimpleDateFormat("MMyy");
        String visitNo;

        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"patient.nextvisitno(" + facilityunitid + ")"};
        String where = "";
        List visitCount = genericClassService.fetchRecordStringEntity("", fields, where, params, paramsValues);
        if (visitCount != null && visitCount.get(0) != null) {
            String value = visitCount.get(0).toString();
            switch (value.length()) {
                case 1:
                    currentNo = "000" + value;
                    break;
                case 2:
                    currentNo = "00" + value;
                    break;
                case 3:
                    currentNo = "0" + value;
                    break;
                default:
                    currentNo = value;
                    break;
            }
        } else {
            currentNo = "0001";
            Facilityvisitno count = new Facilityvisitno();
            count.setCurrentvalue(2);
            count.setFacilityunitid(BigInteger.valueOf(facilityunitid.longValue()));
            genericClassService.saveOrUpdateRecordLoadObject(count);
        }
        switch (unit.length()) {
            case 1:
                unit = "000" + unit;
                break;
            case 2:
                unit = "00" + unit;
                break;
            case 3:
                unit = "0" + unit;
                break;
            default:
                break;
        }
        visitNo = unit + f.format(new Date()) + currentNo;
        return visitNo;
    }

    public String getUnitRegisterPath() {
        File file;
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                file = new File("C:/iicsReports/patients/unitRegister");
                path = "C:/iicsReports/patients/unitRegister/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/patients/unitRegister");
                path = "/home/iicsReports/patients/unitRegister/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/patients/unitRegister");
                path = "/Users/iicsReports/patients/unitRegister/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
    }

    public String computeAge(int days) {
        if (days > 364) {
            Integer years = days / 365;
            if (years == 1) {
                return "1 Year.";
            } else {
                return years + " Years";
            }
        } else {
            if (days > 29) {
                Integer months = days / 30;
                if (months == 1) {
                    return "1 Month.";
                } else {
                    return months + " Months";
                }
            } else {
                if (days == 1) {
                    return "1 Day";
                }
                if (days < 1) {
                    return "-";
                }
                return days + " Days";
            }
        }
    }

    private static String capitalize(String str) {
        StringBuilder result = new StringBuilder(str.length());
        String words[] = str.toLowerCase().split("\\ ");
        for (int i = 0; i < words.length; i++) {
            if (words[i].length() != 0) {
                result.append(Character.toUpperCase(words[i].charAt(0))).append(words[i].substring(1)).append(" ");
            }
        }
        return result.toString();
    }
}
