/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.antenatal.Facilityunitprogramservice;
import com.iics.antenatal.Patientprogram;
import com.iics.antenatal.Program;
import com.iics.antenatal.Programstartisticsview;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Locations;
import com.iics.domain.Person;
import com.iics.patient.Facilityvisitno;
import com.iics.patient.Patient;
import com.iics.patient.Patientmedicalissue;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Patientvisit;
import com.iics.patient.Searchpatient;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.io.FileNotFoundException;
import java.io.IOException;
import com.iics.patient.Servicequeue;
/**
 *
 * @author Uwera
 */
@Controller
@RequestMapping("/program")
public class ProgramVisitsController {

    @Autowired
    GenericClassService genericClassService;
    protected static Log logger = LogFactory.getLog("controller");
    
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formatterwithtime = new SimpleDateFormat("E, dd MMM yyyy HH:mm aa");
    SimpleDateFormat df = new SimpleDateFormat("yyyy");   
    
    @RequestMapping(value = "/patientvisits", method = RequestMethod.GET)
    public String searchPatient(HttpServletRequest request, Model model,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        try {
            model.addAttribute("act", activity);
            model.addAttribute("b", strVal);
            model.addAttribute("i", id);
            model.addAttribute("c", strVal2);
            model.addAttribute("d", id2);
            model.addAttribute("ofst", offset);
            model.addAttribute("maxR", maxResults);
            model.addAttribute("sStr", searchPhrase);

            if (activity.equals("a")) {
                //Modify to fetch from TABLE where facilityID or unitID=???
                long selectedProgramId=0;
                String selectedKey="";
                List<Object[]> progListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, new String[]{"programid", "programname", "programkey"}, "ORDER BY r.programname ASC", new String[]{}, new Object[]{});
                model.addAttribute("progListArr", progListArr);
                if (request.getSession().getAttribute("sessionActivePatientVisitProgram") != null) {
                    selectedProgramId=(long) request.getSession().getAttribute("sessionActivePatientVisitProgram");
                    selectedKey=(String) request.getSession().getAttribute("sessionActivePatientVisitProgramKey");
                    logger.info("selectedKey :::::--------------::::"+selectedKey);
                }else{
                    if(progListArr!=null){
                        selectedProgramId=(Long)progListArr.get(0)[0];
                        selectedKey=(String)progListArr.get(0)[2];
                        request.getSession().setAttribute("sessionActivePatientVisitProgram",selectedProgramId);
                        request.getSession().setAttribute("sessionActivePatientVisitProgramKey",selectedKey);
                    }
                }
                model.addAttribute("activeProgramId", selectedProgramId);
                model.addAttribute("activeProgramKey", selectedKey);
                
                if (request.getSession().getAttribute("sessionActivePatientVisitProgram") != null) {
                    int facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
                    if(selectedKey.equals("key_antenatal")){
                    int totalpatientvisit = 0;
                    int totalpatientvisitbelow18 = 0;
                    int totalpatientvisit18andabove = 0;
                    long totalpatientsFemale = 0;

                    String[] paramspatienttotvisits = {"facilityid", "dateadded","progId"};
                    Object[] paramsValuespatienttot = {facilityId, new Date(), selectedProgramId};
                    String wherepatienttot = "WHERE r.facilityid=:facilityid AND r.dateadded=:dateadded AND r.programid=:progId";
                    totalpatientvisit = genericClassService.fetchRecordCount(Programstartisticsview.class, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot);

                    String[] paramspatientgender = {"facilityid", "dateadded","progId"};
                    Object[] paramsValuespatiengender = {facilityId, new Date(),selectedProgramId};
                    String[] fields5patientgender = {"COUNT(r.patientvisitid)", "r.gender"};
                    List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecordFunction(Programstartisticsview.class, fields5patientgender, "WHERE r.facilityid=:facilityid AND r.dateadded=:dateadded AND r.programid=:progId GROUP BY r.gender", paramspatientgender, paramsValuespatiengender, 0, 0);
                    if (objpatientgender != null) {
                        for (Object[] patienttotgender : objpatientgender) {
                            if ("Female".equals((String) patienttotgender[1])) {
                                totalpatientsFemale = (long) patienttotgender[0];
                                continue;
                            }
                        }
                    }

                    String[] paramspatienttotvisitsage = {"facilityid", "dateadded","progId"};
                    Object[] paramsValuespatienttotage = {facilityId, new Date(), selectedProgramId};
                    String[] fields5patienttotage = {"patientvisitid", "dob"};
                    List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Programstartisticsview.class, fields5patienttotage, "WHERE r.facilityid=:facilityid AND r.dateadded=:dateadded AND r.programid=:progId", paramspatienttotvisitsage, paramsValuespatienttotage);
                    if (objpatienttotage != null) {
                        for (Object[] patienttotage : objpatienttotage) {

                            int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                            int currentyear = Integer.parseInt(df.format(new Date()));
                            int estimatedage = currentyear - year;
                            if (estimatedage < 18) {
                                totalpatientvisitbelow18 += 1;
                            }
                            if (estimatedage >= 18) {
                                totalpatientvisit18andabove += 1;
                            }
                        }
                    }

                    model.addAttribute("totalpatientsFemale", totalpatientsFemale);
                    model.addAttribute("totalpatientvisit", totalpatientvisit);
                    model.addAttribute("totalpatientvisitbelow18", totalpatientvisitbelow18);
                    model.addAttribute("totalpatientvisit18andabove", totalpatientvisit18andabove);
                    
                        return "patientsManagement/antenatal/views/antenatalMain";
                    }
                }
                
                return "patientsManagement/antenatal/views/searchPatient";
            }
            if (activity.equals("b")) {
                long selectedProgramId=0;
                String selectedKey="";
                List<Object[]> progListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, new String[]{"programid", "programname", "programkey"}, "ORDER BY r.programname ASC", new String[]{}, new Object[]{});
                model.addAttribute("progListArr", progListArr);
                if (progListArr != null) {
                    for (Object[] obj : progListArr) {
                        if(((Long)obj[0])==id){
                            selectedProgramId = (Long) obj[0];
                            selectedKey = (String) obj[2];
                            request.getSession().setAttribute("sessionActivePatientVisitProgram", selectedProgramId);
                            request.getSession().setAttribute("sessionActivePatientVisitProgramKey", selectedKey);
                        }
                    }
                }
                if (request.getSession().getAttribute("sessionActivePatientVisitProgram") != null) {
                    int facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
                    if(selectedKey.equals("key_antenatal")){
                    int totalpatientvisit = 0;
                    int totalpatientvisitbelow18 = 0;
                    int totalpatientvisit18andabove = 0;
                    long totalpatientsFemale = 0;

                    String[] paramspatienttotvisits = {"facilityid", "dateadded","progId"};
                    Object[] paramsValuespatienttot = {facilityId, new Date(), selectedProgramId};
                    String wherepatienttot = "WHERE r.facilityid=:facilityid AND r.dateadded=:dateadded AND r.programid=:progId";
                    totalpatientvisit = genericClassService.fetchRecordCount(Programstartisticsview.class, wherepatienttot, paramspatienttotvisits, paramsValuespatienttot);

                    String[] paramspatientgender = {"facilityid", "dateadded","progId"};
                    Object[] paramsValuespatiengender = {facilityId, new Date(),selectedProgramId};
                    String[] fields5patientgender = {"COUNT(r.patientvisitid)", "r.gender"};
                    List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecordFunction(Programstartisticsview.class, fields5patientgender, "WHERE r.facilityid=:facilityid AND r.dateadded=:dateadded AND r.programid=:progId GROUP BY r.gender", paramspatientgender, paramsValuespatiengender, 0, 0);
                    if (objpatientgender != null) {
                        for (Object[] patienttotgender : objpatientgender) {
                            if ("Female".equals((String) patienttotgender[1])) {
                                totalpatientsFemale = (long) patienttotgender[0];
                                continue;
                            }
                        }
                    }

                    String[] paramspatienttotvisitsage = {"facilityid", "dateadded","progId"};
                    Object[] paramsValuespatienttotage = {facilityId, new Date(), selectedProgramId};
                    String[] fields5patienttotage = {"patientvisitid", "dob"};
                    List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Programstartisticsview.class, fields5patienttotage, "WHERE r.facilityid=:facilityid AND r.dateadded=:dateadded AND r.programid=:progId", paramspatienttotvisitsage, paramsValuespatienttotage);
                    if (objpatienttotage != null) {
                        for (Object[] patienttotage : objpatienttotage) {

                            int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                            int currentyear = Integer.parseInt(df.format(new Date()));
                            int estimatedage = currentyear - year;
                            if (estimatedage < 18) {
                                totalpatientvisitbelow18 += 1;
                            }
                            if (estimatedage >= 18) {
                                totalpatientvisit18andabove += 1;
                            }
                        }
                    }

                    model.addAttribute("totalpatientsFemale", totalpatientsFemale);
                    model.addAttribute("totalpatientvisit", totalpatientvisit);
                    model.addAttribute("totalpatientvisitbelow18", totalpatientvisitbelow18);
                    model.addAttribute("totalpatientvisit18andabove", totalpatientvisit18andabove);
                    model.addAttribute("activeProgramId", selectedProgramId);
                    model.addAttribute("activeProgramKey", selectedKey);
                    
                    
                        return "patientsManagement/antenatal/views/antenatalMain";
                    }
                }
                
                return "patientsManagement/antenatal/views/searchPatient";}
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("response", "Error");
        return "patientsManagement/antenatal/response";
    }
    
    @RequestMapping(value = "/searchPatient", method = RequestMethod.POST)
    public String searchPatient(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        List<Map> patients = new ArrayList<>();

        String[] params = {"othernames", "permutation"};
        Object[] paramsValues = {searchValue.replace(" ", "").toLowerCase() + "%", searchValue.replace(" ", "").toLowerCase() + "%"};
        String[] fields = {"personid", "othernames", "lastname", "firstname", "patientno", "currentaddress", "patientid", "telephone", "nextofkin", "nextofkincontact"};
        String where = "WHERE telephone LIKE :othernames OR patientno LIKE :othernames OR permutation1 LIKE :permutation OR permutation2 LIKE :permutation OR permutation3 LIKE :permutation OR permutation2 LIKE :othernames ORDER BY firstname, lastname, othernames";
        String selectedKey = (String) request.getSession().getAttribute("sessionActivePatientVisitProgramKey");
        if(selectedKey.equals("key_antenatal")){
            logger.info("In Here !!!!!");
            where = "WHERE gender='Female' AND (telephone LIKE :othernames OR patientno LIKE :othernames OR permutation1 LIKE :permutation OR permutation2 LIKE :permutation OR permutation3 LIKE :permutation OR permutation2 LIKE :othernames) ORDER BY firstname, lastname, othernames";
        }
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
        return "patientsManagement/antenatal/views/patientSearchResults";
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
            String[] fieldsvilla2 = {"villageid", "villagename"};
            List<Object[]> objPersonVillage2 = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fieldsvilla2, wherevilla2, paramsvill2, paramsValuesvilla2);
            if (objPersonVillage2 != null) {
                Object[] personlocationInfo2 = objPersonVillage2.get(0);
                patSearchedDetails.put("village", (String) personlocationInfo2[1]);

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
            
            long sessProgramId = (Long) request.getSession().getAttribute("sessionActivePatientVisitProgram");
            logger.info("sessProgramId :::::: "+sessProgramId);
            List<Object[]> progListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, new String[]{"programid", "programname", "programkey"}, "WHERE r.programid=:progId", new String[]{"progId"}, new Object[]{sessProgramId});
            if(progListArr!=null){
                model.addAttribute("progObjArr", progListArr.get(0));
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
            //Get Units
            Set<Long> unitServices = new HashSet<>();
            String[] params6 = {"facId","progId"};
            Object[] paramsValues6 = {facilityId,sessProgramId};
            String[] fields6 = {"facilityunitid", "serviceid"};
            String where6 = "WHERE r.facilityid=:facId AND r.program.programid=:progId";
            List<Object[]> unitservices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprogramservice.class, fields6, where6, params6, paramsValues6);
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
            params = new String [] { "patientid" };
            paramsValues = new Object [] { patientid };
            fields = new String [] { "patientvisitid", "facilityid" };
            where = "WHERE patientid=:patientid";
            List<Object[]> patientVisits = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, where, params, paramsValues);
            if(patientVisits != null && patientVisits.size() > 0){
                model.addAttribute("isnewpatient", Boolean.FALSE);
            }else {
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
            
            return "patientsManagement/antenatal/forms/patientVisitForm";
        } else {
            return "refresh";
        }
    }
    
    @RequestMapping(value = "/getUnitServices", method = RequestMethod.POST)
    public @ResponseBody
    String getUnitServices(HttpServletRequest request, Model model, @ModelAttribute("unitid") Integer unitid) {
        if (request.getSession().getAttribute("sessionActivePatientVisitProgram") != null) {
            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            
            List<Map> services = new ArrayList<>();
            String[] params = {"unitid","facId"};
            Object[] paramsValues = {unitid,facilityId};
            String[] fields = {"unitprogramserviceid","serviceid"};
            String where = "WHERE r.facilityunitid=:unitid AND r.facilityid=:facId";
            List<Object[]> unitServices = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprogramservice.class, fields, where, params, paramsValues);
            if (unitServices != null) {
                Map<String, Object> service;
                for (Object[] unitService : unitServices) {
                    service = new HashMap<>();
                    service.put("usid", unitService[1]);

                    String[] params2 = {"serviceid"};
                    Object[] paramsValues2 = {unitService[1]};
                    String[] fields2 = {"servicename"};
                    String where2 = "WHERE serviceid=:serviceid";
                    List<Object[]> serviceName = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, fields2, where2, params2, paramsValues2);
                    if (serviceName != null) {
                        service.put("serviceName", serviceName.get(0));
                    }
                    services.add(service);
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
            long selectedProgramId=(long) request.getSession().getAttribute("sessionActivePatientVisitProgram");
            
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
                
                Patientprogram pProg = new Patientprogram();
                pProg.setPatientvisitid(visit.getPatientvisitid());
                pProg.setProgramid(selectedProgramId);
                pProg.setStartdate(new Date());
                pProg.setStatus("Active");
                pProg.setTimein(new Date());
                
                pProg = (Patientprogram) genericClassService.saveOrUpdateRecordLoadObject(pProg);
                if (pProg == null) {
                    genericClassService.deleteRecordBySchemaByColumns(Patientvisit.class, new String[]{"patientvisitid"}, new Object[]{visit.getPatientvisitid()},"patient");
                    return "refresh";
                }
            }
            return patientVisitid;
        } else {
            return "refresh";
        }
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
        return "patientsManagement/forms/registerNewPatient";
    }
    @RequestMapping(value = "/antenatalTriage", method = RequestMethod.GET)
    public String antenatalTriage(Model model, HttpServletRequest request) throws FileNotFoundException, IOException {
        Integer facilityunitId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        int totalTriagePatients = 0;
        String[] params5todaypat = {"facilityunitid", "dateadded"};
        Object[] paramsValuestodaypat = {BigInteger.valueOf(facilityunitId.longValue()), new Date()};
        String[] fields5todaypat = {"patientprogramid"};
        List<Long> objtodaypat = (List<Long>) genericClassService.fetchRecord(Patientprogram.class, fields5todaypat, "WHERE facilityunitid=:facilityunitid AND startdate=:startdate", params5todaypat, paramsValuestodaypat);
        if (objtodaypat != null) {
            for (Long todaypat : objtodaypat) {
                String[] paramstriageid = {"servicekey"};
                Object[] paramsValuestriageid = {"key_triage"};
                String[] fieldstriageid = {"serviceid"};
                List<Integer> programpatientsvisitstriageid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fieldstriageid, "WHERE servicekey=:servicekey", paramstriageid, paramsValuestriageid);
                if (programpatientsvisitstriageid != null) {
                    String[] params = {"serviceid", "facilityunit"};
                    Object[] paramValues = {programpatientsvisitstriageid, (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                    String[] fields = {"facilityunitserviceid"};
                    String where = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                    List<Long> serviceid = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramValues);
                    if (serviceid != null) {
                        String[] paramspatienttot = {"unitserviceid", "patientvisitid", "serviced", "canceled"};
                        Object[] paramsValuespatienttot = {serviceid.get(0), BigInteger.valueOf(todaypat), true, false};
                        String wherepatienttot = "WHERE unitserviceid=:unitserviceid AND patientprogramid=:patientprogramid AND serviced=:serviced AND canceled=:canceled";
                        totalTriagePatients = genericClassService.fetchRecordCount(Servicequeue.class, wherepatienttot, paramspatienttot, paramsValuespatienttot);
                    }
                }
            }
        }
        model.addAttribute("totalTriagePatients", String.format("%,d", totalTriagePatients));
        return "patientsManagement/antenatal/views/triage";
    }
    
}
