/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Contactdetails;
import java.util.Date;
import java.text.SimpleDateFormat;
import com.iics.domain.Requisition;
import com.iics.domain.Designation;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunits;
import com.iics.domain.Person;
import com.iics.domain.Questions;
import com.iics.domain.Searchstaff;
import com.iics.domain.Staff;
import com.iics.domain.Systemuser;
import com.iics.domain.Userquestions;
import com.iics.service.GenericClassService;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.math.BigInteger;

/**
 *
 * @author IICS PROJECT
 */
@Controller
public class RegisterUser {

    @Autowired
    GenericClassService genericClassService;
    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");

    @RequestMapping(value = "/searchstaffs1", method = RequestMethod.POST)
    String searchstaffs1(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        List<Map> staff = new ArrayList<>();
        String[] params = {"currFacility", "othernames", "permutation"};
        Object[] paramsValues = {Long.parseLong(facilityidsession), "%" + searchValue.replace(" ", "").toLowerCase() + "%", searchValue.replace(" ", "").toLowerCase() + "%"};
        String[] fields = {"staffid", "staffno", "firstname", "lastname", "personid", "othernames"};
        String where = "WHERE currentfacility=:currFacility AND (permutation1 LIKE :permutation OR permutation2 LIKE :permutation OR permutation3 LIKE :permutation OR permutation2 LIKE :othernames )ORDER BY firstname, othernames, lastname";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        if (found != null) {
            Map<String, Object> staffRow;
            for (Object[] f : found) {
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {(BigInteger) f[0]};
                String where2 = "WHERE staffid=:staffid";
                int requests = genericClassService.fetchRecordCount(Requisition.class, where2, params2, paramsValues2);
                if (requests <= 0) {
                    staffRow = new HashMap<>();
                    staffRow.put("staffid", (BigInteger) f[0]);
                    staffRow.put("staffno", (String) f[1]);
                    staffRow.put("firstname", (String) f[2]);
                    staffRow.put("lastname", (String) f[3]);
                    staffRow.put("personid", (BigInteger) f[4]);
                    staffRow.put("othernames", (String) f[5]);
                    staff.add(staffRow);
                }

            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("staff", staff);
        model.addAttribute("searchValue", searchValue);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/staffsearchlist";
    }

    @RequestMapping(value = "/staffdetails", method = RequestMethod.GET)
    public String StaffDetails(Model model, HttpServletRequest request) {
        List<Map> stafffacilityunits = new ArrayList<>();
        Long satffid = 0L;
        Long peresonid = 0L;
        String personidsession = request.getSession().getAttribute("person_id").toString();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        List<Map> designations = new ArrayList<>();
        String[] params61 = {"facilityid"};
        Object[] paramsValues61 = {Long.parseLong(facilityidsession)};
        String[] fields61 = {"designationname", "designationid"};
        String where61 = "WHERE facilityid=:facilityid";
        List<Object[]> found61 = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields61, where61, params61, paramsValues61);
        Map<String, Object> designationnames;

        if (found61 != null) {
            for (Object[] req1 : found61) {
                designationnames = new HashMap<>();
                designationnames.put("designationname", req1[0].toString());
                designationnames.put("designationid", (Integer) req1[1]);
                designations.add(designationnames);
            }
        }
        List<Map> units = new ArrayList<>();
        String[] params611 = {"facilityid"};
        Object[] paramsValues611 = {Long.parseLong(facilityidsession)};
        String[] fields1 = {"facilityunitid", "facilityunitname", "facilityid"};
        String where611 = "WHERE facilityid=:facilityid";
        List<Object[]> found611 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, where611, params611, paramsValues611);
        Map<String, Object> unitnames;

        if (found611 != null) {
            for (Object[] requnit : found611) {
                unitnames = new HashMap<>();
                unitnames.put("facilityunitid", (Long) requnit[0]);
                unitnames.put("facilityunitname", requnit[1].toString());
                units.add(unitnames);

            }
        }
        String[] params = {"staffid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("staffid"))};
        String[] fields = {"staffid", "personid.personid", "designationid.designationid", "staffno"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);
        if (found != null) {
            Object[] fStaff = found.get(0);
            model.addAttribute("staffid", Long.parseLong(fStaff[0].toString()));
            satffid = Long.parseLong(fStaff[0].toString());
            model.addAttribute("personid", (Long) fStaff[1]);
            peresonid = (Long) fStaff[1];

            String[] params2 = {"staffid"};
            Object[] paramsValues2 = {(Long) found.get(0)[0]};
            String[] fields2 = {"facilityunitid", "facilityunitname"};
            String where2 = "WHERE staffid=:staffid";
            List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Facilityunits.class, fields2, where2, params2, paramsValues2);
            if (found2 != null) {
                Map<String, Object> unitdetails;
                for (Object[] staff : found2) {
                    unitdetails = new HashMap<>();
                    unitdetails.put("facilityunitname", staff[1]);
                    stafffacilityunits.add(unitdetails);
                }
            }
            String[] params1 = {"personid"};
            Object[] paramsValues1 = {(Long) (found.get(0)[1])};
            String[] fields111 = {"firstname", "lastname", "facilityid.facilityid", "othernames"};
            String where1 = "WHERE personid=:personid";
            List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields111, where1, params1, paramsValues1);
            if (found1 != null) {
                Object[] f = found1.get(0);
                model.addAttribute("firstname", (String) f[0]);
                model.addAttribute("lastname", (String) f[1]);
                model.addAttribute("othernames", (String) f[3]);
            }
            //Designation name
            if (found.get(0)[2] != null) {
                String[] params3 = {"designationid"};
                Object[] paramsValues3 = {(Integer) found.get(0)[2]};
                String[] fields3 = {"designationname"};
                String where3 = "WHERE designationid=:designationid";
                List<String> founddesignation = (List<String>) genericClassService.fetchRecord(Designation.class, fields3, where3, params3, paramsValues3);
                if (founddesignation != null) {
                    String f = founddesignation.get(0);
                    model.addAttribute("designationname", (String) f);
                }
            }
            //contact details
            String[] params4 = {"personid", "Email"};
            Object[] paramsValues4 = {(found.get(0)[1]), "EMAIL"};
            String[] fields4 = {"contactvalue"};
            String where4 = "WHERE personid=:personid AND contacttype=:Email";
            List<String> objContactDetails = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields4, where4, params4, paramsValues4);
            if (objContactDetails != null) {
                String f1 = objContactDetails.get(0);
                model.addAttribute("contactvalue", (String) f1);
            }
            //primary contact
            String[] params22 = {"personid", "primaryconract"};
            Object[] paramsValues22 = {(found.get(0)[1]), "PRIMARYCONTACT"};
            String[] fields22 = {"contactvalue"};
            String where22 = "WHERE personid=:personid AND contacttype=:primaryconract";
            List<String> objpContactDetails = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields22, where22, params22, paramsValues22);
            if (objpContactDetails != null) {
                String f1 = objpContactDetails.get(0);
                model.addAttribute("primarycontact", (String) f1);
            }
        }
        List<Map> emails = new ArrayList<>();
        String[] paramse = {};
        Object[] paramsValues6e = {};
        String[] fields6e = {"contactvalue"};
        String where6e = "";
        List<String> found6e = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields6e, where6e, paramse, paramsValues6e);
        Map<String, Object> emailcontact;
        if (found6e != null) {
            for (String req : found6e) {
                emailcontact = new HashMap<>();
                emailcontact.put("contactvalue", (req));
                emails.add(emailcontact);
            }
        }
        String jsonCreatedzone = "";
        try {
            jsonCreatedzone = new ObjectMapper().writeValueAsString(emails);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        Set<Long> assignedstaffs = new HashSet<>();
        List<Map> requisitionStaff = new ArrayList<>();
        String[] params6 = {};
        Object[] paramsValues6 = {};
        String[] fields6 = {"requisitionid", "status", "recommender", "staffid"};
        String where6 = "";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> requistions;
        if (found6 != null) {
            for (Object[] req : found6) {
                requistions = new HashMap<>();
                requistions.put("staffidu", ((Long) req[3]));
                requisitionStaff.add(requistions);
                assignedstaffs.add((Long) req[3]);
            }
        }

        Set<Long> assignedusers = new HashSet<>();
        List<Map> users = new ArrayList<>();
        String[] params6u = {};
        Object[] paramsValues6u = {};
        String[] fields6u = {"personid.personid"};
        String where6u = "";
        List<Long> found6u = (List<Long>) genericClassService.fetchRecord(Systemuser.class, fields6u, where6u, params6u, paramsValues6u);
        Map<String, Object> userids;
        if (found6u != null) {
            for (Long req : found6u) {
                userids = new HashMap<>();
                userids.put("personid", req);

                users.add(userids);
                assignedusers.add(req);
            }
        }
        if (assignedstaffs.contains(satffid)) {
            model.addAttribute("requestsent", "sent");
        } else {
            model.addAttribute("requestsent", "notsent");
        }
        if (assignedusers.contains(peresonid)) {

            model.addAttribute("alreadyuser", "yes");
        } else {

            model.addAttribute("alreadyuser", "no");
        }

        String jsonstafffacilityunits = "";
        try {
            jsonstafffacilityunits = new ObjectMapper().writeValueAsString(stafffacilityunits);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonstafffacilityunitss", jsonstafffacilityunits);
        model.addAttribute("staffid", Long.parseLong(request.getParameter("staffid")));
        model.addAttribute("stafffacilityunits", stafffacilityunits.size());
        model.addAttribute("stafffacilityunitss", stafffacilityunits);
        model.addAttribute("requisitionStaff", requisitionStaff);
        model.addAttribute("users", users);
        model.addAttribute("designations", designations);
        model.addAttribute("units", units);
        model.addAttribute("jsonCreatedzone", jsonCreatedzone);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/searchresult";
    }

    @RequestMapping(value = "/saverequests", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView SaveRequests(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Requisition dcategory = new Requisition();
            String staffid = request.getParameter("staffid");
            Object recommendername = request.getSession().getAttribute("person_id");
            String status = request.getParameter("status");

            dcategory.setStaffid(Long.parseLong(staffid));
            dcategory.setRecommender((Long) recommendername);
            dcategory.setDatecreated(new Date());
            dcategory.setStatus(status);
            Object save = genericClassService.saveOrUpdateRecordLoadObject(dcategory);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("Usermanagement/Internalsystemuser/RegisterUser/views/searchresult", "model", model);
    }

    @RequestMapping(value = "/savemail", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView savemail(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Contactdetails contact = new Contactdetails();

            String contactvalue = request.getParameter("emailofUser");
            String contacttype = request.getParameter("email");
            String personid = request.getParameter("personid");
            contact.setContactvalue(contactvalue);
            contact.setContacttype(contacttype);
            contact.setPersonid(Long.parseLong(personid));
            Object save = genericClassService.saveOrUpdateRecordLoadObject(contact);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("Usermanagement/Internalsystemuser/RegisterUser/views/searchresult", "model", model);
    }

    @RequestMapping(value = "/retrievesavedrequests", method = RequestMethod.GET)
    public String retrieveSavedRequests(Model model, HttpServletRequest request) {
        List<Map> requisitionList = new ArrayList<>();
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                for (Long staffid : staff) {
                    String[] params62 = {"staffid"};
                    Object[] paramsValues62 = {staffid};
                    String[] fields62 = {"requisitionid", "status", "recommender", "staffid", "links"};
                    String where62 = "WHERE staffid=:staffid";
                    List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields62, where62, params62, paramsValues62);
                    Map<String, Object> requests2;
                    if (found62 != null) {
                        for (Object[] req : found62) {
                            requests2 = new HashMap<>();
                            if ((String) req[1] == null) {
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
                                        requests2.put("reqfirstname", (String) f7[0]);
                                        requests2.put("reqlastname", (String) f7[1]);
                                        requests2.put("reqothernames", (String) f7[2]);

                                    }
                                    int noOfUnits = 0;
                                    String[] params1 = {"staffid", "active"};
                                    Object[] paramsValues1 = {(Long) req[3], Boolean.TRUE};
                                    String where1 = "WHERE staffid=:staffid AND active=:active";
                                    noOfUnits = genericClassService.fetchRecordCount(Stafffacilityunit.class, where1, params1, paramsValues1);
                                    requests2.put("noOfUnits", noOfUnits);
                                    requests2.put("requisitionid", (Integer) req[0]);
                                    requests2.put("status", (String) req[1]);
                                    requests2.put("recommender", ((Long) req[2]));
                                    requests2.put("personid", (BigInteger) f8[3]);
                                    requests2.put("firstname", (String) f8[4]);
                                    requests2.put("lastname", (String) f8[0]);
                                    requests2.put("othernames", (String) f8[1]);
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
                                requisitionList.add(requests2);
                            }

                        }
                    }
                }
            }
            model.addAttribute("requisitionList", requisitionList);
            return "Usermanagement/Internalsystemuser/RegisterUser/views/requisitionlisttable";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/activate", method = RequestMethod.GET)
    public String controlPanelMenu(Model model, @ModelAttribute("id") String links, HttpServletRequest request) {
        String[] paramsL = {"links"};
        Object[] paramsValuesL = {links};
        String[] fieldsL = {"links", "staffid"};
        String whereL = "WHERE links=:links";
        List<Object[]> foundL = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fieldsL, whereL, paramsL, paramsValuesL);
        if (foundL != null) {
            Object[] f = foundL.get(0);
            model.addAttribute("staffid", (Long) f[1]);
            String[] params4 = {"staffid"};
            Object[] paramsValues4 = {(foundL.get(0)[1])};
            String[] fields4 = {"personid.personid"};
            String where4 = "WHERE staffid=:staffid";
            List<Long> objContactDetails = (List<Long>) genericClassService.fetchRecord(Staff.class, fields4, where4, params4, paramsValues4);
            if (objContactDetails != null) {
                String[] paramsR = {"personid"};
                Object[] paramsValuesR = {(objContactDetails.get(0))};
                String[] fieldsR = {"firstname", "lastname"};
                String whereR = "WHERE personid=:personid";
                List<Object[]> objContactDetailsR = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsR, whereR, paramsR, paramsValuesR);
                if (objContactDetailsR != null) {
                    Object[] fr = objContactDetailsR.get(0);
                    model.addAttribute("firstname", fr[0].toString());
                    model.addAttribute("lastname", fr[1].toString());

                }
                String[] paramsRU = {"personid"};
                Object[] paramsValuesRU = {(objContactDetails.get(0))};
                String[] fieldsRU = {"username", "password"};
                String whereRU = "WHERE personid=:personid";
                List<Object[]> objContactDetailsRU = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldsRU, whereRU, paramsRU, paramsValuesRU);
                if (objContactDetailsR != null) {
                    Object[] fr = objContactDetailsR.get(0);
                    model.addAttribute("username", fr[0].toString());
                    model.addAttribute("password", fr[1].toString());
                }
            }
        }

        List<Map> questionslist = new ArrayList<>();
        String[] params6 = {};
        Object[] paramsValues6 = {};
        String[] fields6 = {"questionsid", "question"};
        String where6 = "";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Questions.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> questionsz;

        if (found6 != null) {
            for (Object[] req : found6) {
                questionsz = new HashMap<>();
                questionsz.put("Questionsid", (Integer) req[0]);
                questionsz.put("question", (String) req[1]);
                questionslist.add(questionsz);

            }
        }

        model.addAttribute("questionslist", questionslist);
        model.addAttribute("id", links);
        return "newuserregistration";
    }

    @RequestMapping(value = "/adddesignation", method = RequestMethod.POST)
    public @ResponseBody
    String adddesignation(HttpServletRequest request
    ) {
        try {
            //update designations
            int designationid = Integer.parseInt(request.getParameter("designationselect"));
            Long staffid = Long.parseLong(request.getParameter("staffid"));

            String[] columns = {"staffid", "designationid"};
            Object[] columnValues = {staffid, designationid,};
            String pk = "staffid";
            Object pkValue = staffid;
            genericClassService.updateRecordSQLSchemaStyle(Staff.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/saveunit.htm")
    public final ModelAndView saveunit(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            List<String> units = (ArrayList) new ObjectMapper().readValue(request.getParameter("facilityunitset"), List.class);
            for (String unit : units) {
                Stafffacilityunit staffunit = new Stafffacilityunit();

                String staffid = request.getParameter("staffid");
                staffunit.setStaffid(Long.parseLong(staffid));
                staffunit.setFacilityunitid(Long.parseLong(unit));
                Object save = genericClassService.saveOrUpdateRecordLoadObject(staffunit);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ModelAndView("Usermanagement/Internalsystemuser/RegisterUser/views/searchresult", "model", model);
    }

    @RequestMapping(value = "/deniedrequest", method = RequestMethod.POST)
    public @ResponseBody
    String deniedrequest(HttpServletRequest request) {
        try {
            //update status

            String reasonfordenial = request.getParameter("reasonfordenial");
            String status = request.getParameter("status");
            String requisitionid = request.getParameter("requisitionid");
            String[] columns = {"reasonfordenial", "status", "datedenied"};
            Object[] columnValues = {reasonfordenial, status, new Date()};
            String pk = "requisitionid";
            Object pkValue = Integer.parseInt(requisitionid);
            genericClassService.updateRecordSQLSchemaStyle(Requisition.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/acceptedrequest", method = RequestMethod.POST)
    public @ResponseBody
    String acceptedrequest(HttpServletRequest request) {
        try {
            //update status

            int requisitionid = Integer.parseInt(request.getParameter("requisitionid"));
            String status = request.getParameter("status");
            String[] columns = {"status", "dateapproved"};
            Object[] columnValues = {status, new Date()};
            String pk = "requisitionid";
            Object pkValue = requisitionid;
            genericClassService.updateRecordSQLSchemaStyle(Requisition.class, columns, columnValues, pk, pkValue, "public");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    @RequestMapping(value = "/resendrequest", method = RequestMethod.POST)
    public @ResponseBody
    String resendrequest(HttpServletRequest request) {
        try {
            //resend request
            String requisitionid = request.getParameter("requisitionid");

            String[] columns = {"requisitionid"};
            Object[] columnValues = {Integer.parseInt(requisitionid)};
            genericClassService.deleteRecordByByColumns("public.requisition", columns, columnValues);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "/removefromlist", method = RequestMethod.POST)
    public @ResponseBody
    String removefromlist(HttpServletRequest request) {
        try {
            //remove request
            String requisitionid = request.getParameter("requisitionid");

            String[] columns = {"requisitionid"};
            Object[] columnValues = {Integer.parseInt(requisitionid)};
            genericClassService.deleteRecordByByColumns("public.requisition", columns, columnValues);
        } catch (Exception ex) {
            System.out.println(ex);
            ex.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "/requeststatus", method = RequestMethod.GET)
    public String requeststatus(Model model, HttpServletRequest request) {

        return "Usermanagement/Internalsystemuser/RegisterUser/views/deniedapprovedrequests";
    }

    @RequestMapping(value = "/getstaffdetails")
    public @ResponseBody
    String getstaffdetails(HttpServletRequest request) {
        String results = "";
        List<Map> staffdetails = new ArrayList<>();
        Map<String, Object> staff = new HashMap<>();
        String[] params = {"staffid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("staffid"))};
        String[] fields = {"staffid", "personid.personid", "designationid.designationid", "staffno"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);

        if (found != null) {
            Object[] fStaff = found.get(0);
            staff.put("staffid", Long.parseLong(fStaff[0].toString()));
            staff.put("personid", (Long) fStaff[1]);

            List<Map> unitsd = new ArrayList<>();
            String[] params2 = {"staffid"};
            Object[] paramsValues2 = {(Long) found.get(0)[0]};
            String[] fields2 = {"facilityunitid", "stafffacilityunitid"};
            String where2 = "WHERE staffid=:staffid";
            List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fields2, where2, params2, paramsValues2);
            if (found2 != null) {
                Map<String, Object> unitdetails;
                for (Object[] staffd : found2) {
                    unitdetails = new HashMap<>();
                    String[] params5 = {"facilityunitid"};
                    Object[] paramsValues5 = {(Long) staffd[0]};
                    String[] fields5 = {"facilityunitname"};
                    String where5 = "WHERE facilityunitid=:facilityunitid";
                    List<String> objFacilityUnitDetails = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5, where5, params5, paramsValues5);
                    if (objFacilityUnitDetails != null) {
                        unitdetails.put("facilityunitname", objFacilityUnitDetails.get(0));
                        unitdetails.put("facilityunitid", (Long) staffd[0]);
                        unitsd.add(unitdetails);
                    }
                }

            }

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

            String[] params10 = {"designationid"};
            Object[] paramsValues10 = {(Integer) (found.get(0)[2])};
            String[] fields10 = {"designationname"};
            String where10 = "WHERE designationid=:designationid";
            List<String> found10 = (List<String>) genericClassService.fetchRecord(Designation.class, fields10, where10, params10, paramsValues10);

            if (found10 != null) {
                String f10 = found10.get(0);
                staff.put("designationname", (String) f10);

            }
            String[] params4 = {"personid"};
            Object[] paramsValues4 = {(Long) (found.get(0)[1])};
            String[] fields4 = {"contactvalue"};
            String where4 = "WHERE personid=:personid";
            List<String> found11 = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields4, where4, params4, paramsValues4);

            if (found11 != null) {
                String f11 = found11.get(0);
                staff.put("contactvalue", (String) f11);
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

    @RequestMapping(value = "/searchuser", method = RequestMethod.POST)
    public @ResponseBody
    String searchuser(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) {
        String results = "";
        if ("username".equals(request.getParameter("type"))) {
            String[] params = {"value"};
            Object[] paramsValues = {searchValue.toLowerCase()};
            String[] fields = {"username"};
            String where = "WHERE username=:value";
            List<String> found = (List<String>) genericClassService.fetchRecord(Systemuser.class, fields, where, params, paramsValues);
            if (found != null) {
                results = "existing";
            } else {
                results = "notexisting";
            }
        } else {
            String[] params = {"value"};
            Object[] paramsValues = {searchValue};
            String[] fields = {"password"};
            String where = "WHERE password=:value";
            List<String> found = (List<String>) genericClassService.fetchRecord(Systemuser.class, fields, where, params, paramsValues);
            if (found != null) {
                results = "existing";

            } else {
                results = "notexisting";

            }
        }
        return results;
    }

    @RequestMapping(value = "/savequestions.htm")
    public final ModelAndView savequestions(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        try {
            List<Map> questions = (ArrayList) new ObjectMapper().readValue(request.getParameter("QuestionsAnswers"), List.class);
            for (Map qn : questions) {
                Userquestions selectedqn = new Userquestions();
                String systemuserid = request.getParameter("systemuserid");

                String id = qn.get("qnid").toString();
                String answer = qn.get("answer").toString();

                selectedqn.setSystemuserid(Long.parseLong(systemuserid));
                selectedqn.setQuestionsid(Integer.parseInt(id));
                selectedqn.setAnswer(answer);
                Object save = genericClassService.saveOrUpdateRecordLoadObject(selectedqn);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ModelAndView("recoverySetup", "model", model);
    }

    @RequestMapping(value = "/getusername")
    public @ResponseBody
    String getusername(HttpServletRequest request) {
        String results = "";
        List<Map> userdetails = new ArrayList<>();
        Map<String, Object> user = new HashMap<>();
        String[] params = {"systemuserid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("systemuserid"))};
        String[] fields = {"username", "password"};
        String where = "WHERE systemuserid=:systemuserid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields, where, params, paramsValues);

        if (found != null) {
            Object[] fStaff = found.get(0);
            user.put("username", (fStaff[0].toString()));
            user.put("password", fStaff[1].toString());

        }
        userdetails.add(user);
        try {
            results = new ObjectMapper().writeValueAsString(userdetails);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RegisterUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/searchusername", method = RequestMethod.POST)
    public @ResponseBody
    String searchusername(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) {
        String results = "";
        if ("username".equals(request.getParameter("type"))) {
            String[] params = {"value"};
            Object[] paramsValues = {searchValue};
            String[] fields = {"username"};
            String where = "WHERE username=:value";
            List<String> found = (List<String>) genericClassService.fetchRecord(Systemuser.class, fields, where, params, paramsValues);
            if (found != null) {

                results = "existing";
            } else {
                results = "notexisting";

            }
        } else {

        }
        return results;
    }

    @RequestMapping(value = "/updateusername", method = RequestMethod.POST)
    public @ResponseBody
    String updateusername(HttpServletRequest request) {
        try {
            //update status
            String systemuserid = request.getParameter("systemuserid");
            String nusername = request.getParameter("nusername");
            String[] columns = {"username"};
            Object[] columnValues = {nusername};
            String pk = "systemuserid";
            Object pkValue = Long.parseLong(systemuserid);
            genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/editusername", method = RequestMethod.POST)
    public @ResponseBody
    String editusername(HttpServletRequest request) {
        try {
            //update status
            String systemuserid = request.getParameter("systemuserid");
            String nusername = request.getParameter("nusername");
            String[] columns = {"username"};
            Object[] columnValues = {nusername};
            String pk = "systemuserid";
            Object pkValue = Long.parseLong(systemuserid);
            genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/updatepass", method = RequestMethod.POST)
    public @ResponseBody
    String updatepass(HttpServletRequest request) {
        try {
            //update status
            String systemuserid = request.getParameter("systemuserid");
            String nusername = request.getParameter("nusername");
            String[] columns = {"password"};
            Object[] columnValues = {nusername};

            String pk = "systemuserid";
            Object pkValue = Long.parseLong(systemuserid);
            genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/editpassword", method = RequestMethod.POST)
    public @ResponseBody
    String editpassword(HttpServletRequest request) {
        try {
            //update status
            String systemuserid = request.getParameter("systemuserid");
            String hash = request.getParameter("hash");
            String[] columns = {"password"};
            Object[] columnValues = {hash};

            String pk = "systemuserid";
            Object pkValue = Long.parseLong(systemuserid);
            genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/reloadrecycle", method = RequestMethod.GET)
    public String reloadrecycle(Model model) {
        List<Map> requisitionList1 = new ArrayList<>();
        String[] params6 = {"denied"};
        Object[] paramsValues6 = {"Denied"};
        String[] fields6 = {"requisitionid", "status", "recommender", "staffid", "reasonfordenial"};
        String where6 = "WHERE status=:denied";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> requests;

        if (found6 != null) {
            for (Object[] req : found6) {
                requests = new HashMap<>();
                requests.put("status", (String) req[1]);
                requests.put("reasonfordenial", (String) req[4]);
                requests.put("staffid", (long) req[3]);
                requests.put("requisitionid", Integer.parseInt(req[0].toString()));

                //Query Staff 
                String[] params8 = {"staffid"};
                Object[] paramsValues8 = {(long) req[3]};
                String[] fields8 = {"personid.personid", "designationid.designationid"};
                String where8 = "WHERE staffid=:staffid";
                List<Object[]> found8 = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields8, where8, params8, paramsValues8);
                if (found8 != null) {
                    Object[] f8 = found8.get(0);
                    String[] params9 = {"personid"};
                    Object[] paramsValues9 = {f8[0]};
                    String[] fields9 = {"firstname", "lastname", "facilityid.facilityid"};
                    String where9 = "WHERE personid=:personid";
                    List<Object[]> found9 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields9, where9, params9, paramsValues9);
                    if (found9 != null) {
                        Object[] f9 = found9.get(0);
                        requests.put("stafffirstname", (String) f9[0]);
                        requests.put("stafflastname", (String) f9[1]);
                    }
                }
                requisitionList1.add(requests);
            }
        }
        model.addAttribute("requisitionList1", requisitionList1.size());
        model.addAttribute("requisitionList11", requisitionList1);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/recyclerequest";
    }

    @RequestMapping(value = "/stafflist", method = RequestMethod.GET)
    public String stafflist(Model model, HttpServletRequest request) {
        List<Map> stafflists = new ArrayList<>();
        List<Map> facilityunits = new ArrayList<>();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();

        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                Map<String, Object> userrow;
                for (Long staffid : staff) {
                    userrow = new HashMap<>();
                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {BigInteger.valueOf(staffid)};
                    String[] fields2 = {"staffid", "staffno", "firstname", "lastname", "personid", "othernames", "designationname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (staffDetails != null) {
                        userrow.put("staffid", (BigInteger) staffDetails.get(0)[0]);
                        userrow.put("staffno", (String) staffDetails.get(0)[1]);
                        userrow.put("firstname", (String) staffDetails.get(0)[2]);
                        userrow.put("lastname", (String) staffDetails.get(0)[3]);
                        userrow.put("personid", (BigInteger) staffDetails.get(0)[4]);
                        userrow.put("othernames", (String) staffDetails.get(0)[5]);
                        userrow.put("designationname", (String) staffDetails.get(0)[6]);

                        String[] params3 = {"staffid"};
                        Object[] paramsValues3 = {(BigInteger) staffDetails.get(0)[0]};
                        String[] fields3 = {"datecreated", "createdby.staffid"};
                        String where3 = "WHERE staffid=:staffid";
                        List<Object[]> foundstaff = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields3, where3, params3, paramsValues3);
                        if (foundstaff != null) {
                            userrow.put("datecreated", new SimpleDateFormat("dd-MM-yyyy").format((Date) foundstaff.get(0)[0]));

                            String[] params1 = {"staffid"};
                            Object[] paramsValues1 = {(long) foundstaff.get(0)[1]};
                            String[] fields1 = {"firstname", "lastname", "othernames"};
                            String where1 = "WHERE staffid=:staffid";
                            List<Object[]> foundstaff1 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields1, where1, params1, paramsValues1);
                            if (foundstaff1 != null) {
                                userrow.put("firstnamer", (String) foundstaff1.get(0)[0]);
                                userrow.put("lastnamer", (String) foundstaff1.get(0)[1]);
                                userrow.put("othernamesr", (String) foundstaff1.get(0)[2]);
                            }
                        }
                    }
                    stafflists.add(userrow);
                }
            }
        }
        String[] params6 = {"facilityid"};
        Object[] paramsValues6 = {Integer.parseInt(facilityidsession)};
        String[] fields6 = {"facilityunitid", "facilityunitname"};
        String where6 = "WHERE facilityid=:facilityid";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> units;
        if (found6 != null) {
            for (Object[] req : found6) {
                units = new HashMap<>();
                units.put("facilityunitid", (Long) req[0]);
                units.put("facilityunitname", (String) req[1]);
                facilityunits.add(units);

            }
        }

        model.addAttribute("stafflists", stafflists);
        model.addAttribute("facilityunits", facilityunits);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/stafflist";
    }

    @RequestMapping(value = "/viewapprovedreqs", method = RequestMethod.GET)
    public String viewapprovedreqs(Model model, HttpServletRequest request) {
        List<Map> approvedreqs = new ArrayList<>();
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                for (Long staffid : staff) {
                    String[] params62 = {"staffid", "approved"};
                    Object[] paramsValues62 = {staffid, "approved"};
                    String[] fields62 = {"requisitionid", "status", "recommender", "staffid", "links", "datecreated"};
                    String where62 = "WHERE staffid=:staffid AND status=:approved";
                    List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields62, where62, params62, paramsValues62);
                    Map<String, Object> requests2;
                    if (found62 != null) {
                        for (Object[] req : found62) {
                            requests2 = new HashMap<>();
                            if ((String) req[4] != null) {
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
                                        requests2.put("firstnamer", (String) f7[0]);
                                        requests2.put("lastnamer", (String) f7[1]);
                                        requests2.put("othernamesr", (String) f7[2]);
                                    }
                                    String[] param = {"personid"};
                                    Object[] paramsValuess = {(BigInteger) f8[3]};
                                    String[] fieldss = {"systemuserid","active"};
                                    String wheres = "WHERE personid=:personid";
                                    List<Object[]> founds = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldss, wheres, param, paramsValuess);
                                    if (founds != null) {
                                        Object[] f7 = founds.get(0);
                                        requests2.put("systemuserid", (Long)f7[0]);
                                        requests2.put("active", (Boolean)f7[1]);
                                    }
                                    int noOfUnits = 0;
                                    String[] params1 = {"staffid", "active"};
                                    Object[] paramsValues1 = {(Long) req[3], Boolean.TRUE};
                                    String where1 = "WHERE staffid=:staffid AND active=:active";
                                    noOfUnits = genericClassService.fetchRecordCount(Stafffacilityunit.class, where1, params1, paramsValues1);
                                    requests2.put("noOfUnits", noOfUnits);
                                    requests2.put("personid", (BigInteger) f8[3]);
                                    requests2.put("datecreated", new SimpleDateFormat("dd-MM-yyyy").format((Date) req[5]));
                                    requests2.put("firstname", (String) f8[4]);
                                    requests2.put("lastname", (String) f8[0]);
                                    requests2.put("othernames", (String) f8[1]);
                                    requests2.put("designationname", (String) f8[2]);
                                }
                                approvedreqs.add(requests2);
                            }

                        }
                    }
                }
            }
        }
        model.addAttribute("approvedreqs", approvedreqs);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/approvedrequests";
    }

    @RequestMapping(value = "/viewdeniedrequests", method = RequestMethod.GET)
    public String viewdeniedrequests(Model model, HttpServletRequest request) {
        List<Map> deniedrequests = new ArrayList<>();
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                for (Long staffid : staff) {
                    String[] params62 = {"staffid", "denied"};
                    Object[] paramsValues62 = {staffid, "Denied"};
                    String[] fields62 = {"requisitionid", "status", "recommender", "staffid", "links", "datedenied", "reasonfordenial"};
                    String where62 = "WHERE staffid=:staffid AND status=:denied";
                    List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields62, where62, params62, paramsValues62);
                    Map<String, Object> requests2;
                    if (found62 != null) {
                        for (Object[] req : found62) {
                            requests2 = new HashMap<>();
                            if ((String) req[1] != null) {
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
                                        requests2.put("firstnamer", (String) f7[0]);
                                        requests2.put("lastnamer", (String) f7[1]);
                                        requests2.put("othernamesr", (String) f7[2]);

                                    }
                                    int noOfUnits = 0;
                                    String[] params1 = {"staffid", "active"};
                                    Object[] paramsValues1 = {(Long) req[3], Boolean.TRUE};
                                    String where1 = "WHERE staffid=:staffid AND active=:active";
                                    noOfUnits = genericClassService.fetchRecordCount(Stafffacilityunit.class, where1, params1, paramsValues1);
                                    requests2.put("noOfUnits", noOfUnits);
                                    requests2.put("personid", (BigInteger) f8[3]);
                                    requests2.put("datedenied", new SimpleDateFormat("dd-MM-yyyy").format((Date) req[5]));
                                    requests2.put("reasonfordenial", (String) req[6]);
                                    requests2.put("firstname", (String) f8[4]);
                                    requests2.put("lastname", (String) f8[0]);
                                    requests2.put("othernames", (String) f8[1]);
                                    requests2.put("designationname", (String) f8[2]);
                                }
                                deniedrequests.add(requests2);
                            }

                        }
                    }
                }
            }
        }
        model.addAttribute("deniedrequests", deniedrequests);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/deniedrequests";
    }

    @RequestMapping(value = "/Viewunits", method = RequestMethod.GET)
    public String Viewunits(Model model, HttpServletRequest request) {
        String staffid = request.getParameter("staffid");
        List<Map> staffunits = new ArrayList<>();

        String[] params61 = {"staffid", "active"};
        Object[] paramsValues61 = {BigInteger.valueOf(Long.parseLong(staffid)), Boolean.TRUE};
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
        return "Usermanagement/Internalsystemuser/RegisterUser/views/primarysatffunits";
    }

    @RequestMapping(value = "/allStaff", method = RequestMethod.GET)
    public String allStaff(Model model, HttpServletRequest request) {
        List<Map> stafflists = new ArrayList<>();
        List<Map> facilityunits = new ArrayList<>();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        String[] params2 = {"currentfacility"};
        Object[] paramsValues2 = {Integer.parseInt(facilityidsession)};
        String[] fields2 = {"staffid", "staffno", "firstname", "lastname", "personid", "othernames", "designationname"};
        String where2 = "WHERE currentfacility=:currentfacility";
        List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
        if (staffDetails != null) {
            Map<String, Object> userrow;
            for (Object[] stf : staffDetails) {
                userrow = new HashMap<>();
                userrow.put("staffid", (BigInteger) stf[0]);
                userrow.put("staffno", (String) stf[1]);
                userrow.put("firstname", (String) stf[2]);
                userrow.put("lastname", (String) stf[3]);
                userrow.put("personid", (BigInteger) stf[4]);
                userrow.put("othernames", (String) stf[5]);
                userrow.put("designationname", (String) stf[6]);

                String[] params3 = {"staffid"};
                Object[] paramsValues3 = {(BigInteger) staffDetails.get(0)[0]};
                String[] fields3 = {"datecreated", "createdby.staffid"};
                String where3 = "WHERE staffid=:staffid";
                List<Object[]> foundstaff = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields3, where3, params3, paramsValues3);
                if (foundstaff != null) {
                    userrow.put("datecreated", new SimpleDateFormat("dd-MM-yyyy").format((Date) foundstaff.get(0)[0]));

                    String[] params1 = {"staffid"};
                    Object[] paramsValues1 = {(long) foundstaff.get(0)[1]};
                    String[] fields1 = {"firstname", "lastname", "othernames"};
                    String where1 = "WHERE staffid=:staffid";
                    List<Object[]> foundstaff1 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields1, where1, params1, paramsValues1);
                    if (foundstaff1 != null) {
                        userrow.put("firstnamer", (String) foundstaff1.get(0)[0]);
                        userrow.put("lastnamer", (String) foundstaff1.get(0)[1]);
                        userrow.put("othernamesr", (String) foundstaff1.get(0)[2]);
                    }
                }
                stafflists.add(userrow);
            }
        }
        String[] params6 = {"facilityid"};
        Object[] paramsValues6 = {Integer.parseInt(facilityidsession)};
        String[] fields6 = {"facilityunitid", "facilityunitname"};
        String where6 = "WHERE facilityid=:facilityid";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> units;
        if (found6 != null) {
            for (Object[] req : found6) {
                units = new HashMap<>();
                units.put("facilityunitid", (Long) req[0]);
                units.put("facilityunitname", (String) req[1]);
                facilityunits.add(units);

            }
        }
        model.addAttribute("stafflists", stafflists);
        model.addAttribute("facilityunits", facilityunits);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/stafflist";
    }

    @RequestMapping(value = "/unitstafflist", method = RequestMethod.GET)
    public String unitstafflist(Model model, HttpServletRequest request) {
        List<Map> stafflists = new ArrayList<>();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        List<Map> facilityunits = new ArrayList<>();

        Integer facilityUnit = Integer.parseInt(request.getParameter("selectedFacilityUnitid"));
        String[] params = {"facilityunitid", "active"};
        Object[] paramsValues = {facilityUnit, true};
        String[] fields = {"staffid"};
        String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
        List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
        if (staff != null) {
            Map<String, Object> userrow;
            for (Long staffid : staff) {
                userrow = new HashMap<>();
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {BigInteger.valueOf(staffid)};
                String[] fields2 = {"staffid", "staffno", "firstname", "lastname", "personid", "othernames", "designationname"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                if (staffDetails != null) {
                    userrow.put("staffid", (BigInteger) staffDetails.get(0)[0]);
                    userrow.put("staffno", (String) staffDetails.get(0)[1]);
                    userrow.put("firstname", (String) staffDetails.get(0)[2]);
                    userrow.put("lastname", (String) staffDetails.get(0)[3]);
                    userrow.put("personid", (BigInteger) staffDetails.get(0)[4]);
                    userrow.put("othernames", (String) staffDetails.get(0)[5]);
                    userrow.put("designationname", (String) staffDetails.get(0)[6]);

                    String[] params3 = {"staffid"};
                    Object[] paramsValues3 = {(BigInteger) staffDetails.get(0)[0]};
                    String[] fields3 = {"datecreated", "createdby.staffid"};
                    String where3 = "WHERE staffid=:staffid";
                    List<Object[]> foundstaff = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields3, where3, params3, paramsValues3);
                    if (foundstaff != null) {
                        userrow.put("datecreated", new SimpleDateFormat("dd-MM-yyyy").format((Date) foundstaff.get(0)[0]));
                        String[] params1 = {"staffid"};
                        Object[] paramsValues1 = {(long) foundstaff.get(0)[1]};
                        String[] fields1 = {"firstname", "lastname", "othernames"};
                        String where1 = "WHERE staffid=:staffid";
                        List<Object[]> foundstaff1 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields1, where1, params1, paramsValues1);
                        if (foundstaff1 != null) {
                            userrow.put("firstnamer", (String) foundstaff1.get(0)[0]);
                            userrow.put("lastnamer", (String) foundstaff1.get(0)[1]);
                            userrow.put("othernamesr", (String) foundstaff1.get(0)[2]);
                        }
                    }
                }
                stafflists.add(userrow);
            }
        }

        String[] params6 = {"facilityid"};
        Object[] paramsValues6 = {Integer.parseInt(facilityidsession)};
        String[] fields6 = {"facilityunitid", "facilityunitname"};
        String where6 = "WHERE facilityid=:facilityid";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> units;
        if (found6 != null) {
            for (Object[] req : found6) {
                units = new HashMap<>();
                units.put("facilityunitid", (Long) req[0]);
                units.put("facilityunitname", (String) req[1]);
                facilityunits.add(units);

            }
        }

        model.addAttribute("facilityunits", facilityunits);
        model.addAttribute("stafflists", stafflists);
        return "Usermanagement/Internalsystemuser/RegisterUser/views/stafflist";
    }
    @RequestMapping(value = "/viewstaffdetails", method = RequestMethod.GET)
    public String viewstaffdetails(Model model, HttpServletRequest request) {
        String staffid = request.getParameter("staffid");
        String personid = request.getParameter("personid");
        String[] params6 = {"personid","EMAIL"};
        Object[] paramsValues6 = {Long.parseLong(personid),"EMAIL"};
        String[] fields6 = {"contactvalue"};
        String where6 = "WHERE personid=:personid AND contacttype=:EMAIL";
        List<String> found6 = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields6, where6, params6, paramsValues6);
        if (found6 != null) {
            model.addAttribute("email",found6.get(0));
        }
        String[] params = {"personid","PRIMARYCONTACT"};
        Object[] paramsValues = {Long.parseLong(personid),"PRIMARYCONTACT"};
        String[] fields = {"contactvalue"};
        String where = "WHERE personid=:personid AND contacttype=:PRIMARYCONTACT";
        List<String> found = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields, where, params, paramsValues);
        if (found != null) {
            model.addAttribute("primaryphonecontact",found.get(0));
        }
        String[] paramss = {"personid","SECONDARYCONTACT"};
        Object[] paramsValuess = {Long.parseLong(personid),"SECONDARYCONTACT"};
        String[] fieldss = {"contactvalue"};
        String wheres = "WHERE personid=:personid AND contacttype=:SECONDARYCONTACT";
        List<String> founds = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fieldss, wheres, paramss, paramsValuess);
        if (founds != null) {
            model.addAttribute("secondaryphonecontact",founds.get(0));
        }
        String[] paramsss = {"staffid"};
        Object[] paramsValuesss = {Long.parseLong(staffid)};
        String[] fieldsss = {"staffno"};
        String wheress = "WHERE staffid=:staffid";
        List<String> foundss = (List<String>) genericClassService.fetchRecord(Staff.class, fieldsss, wheress, paramsss, paramsValuesss);
        if (foundss != null) {
            model.addAttribute("staffno",foundss.get(0));
        }
        return "Usermanagement/Internalsystemuser/RegisterUser/views/staffinfo";
    }
}
