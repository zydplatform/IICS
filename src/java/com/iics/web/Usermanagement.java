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
import com.iics.domain.Designation;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunits;
import com.iics.domain.Person;
import com.iics.domain.Questions;
import com.iics.domain.Requisition;
import com.iics.domain.Searchstaff;
import com.iics.domain.Staff;
import com.iics.domain.Systemuser;
import com.iics.domain.Userquestions;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author user
 */
@Controller
@RequestMapping("/usermanagement")
public class Usermanagement {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/internalAndexternal", method = RequestMethod.GET)
    public String Usermanagementmenu(Model model) {
        return "Usermanagement/Usermanagementmenu";
    }

    @RequestMapping(value = "/internalSystemuser", method = RequestMethod.GET)
    public String internalSystemuser(Model model) {
        return "Usermanagement/Internalsystemuser/Internalsystemusermenu";
    }

    @RequestMapping(value = "/registeruser", method = RequestMethod.GET)
    public String registeruser(Model model, HttpServletRequest request) {
        Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        List<Map> aplista = new ArrayList<>();
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, Boolean.TRUE};
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
                                requests2.put("staffid", (Long) req[3]);
                                aplista.add(requests2);
                            }
                        }
                    }
                }
            }
        }
        model.addAttribute("approvedrequestscount", aplista.size());
        List<Map> aplistd = new ArrayList<>();
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, Boolean.TRUE};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                for (Long staffid : staff) {
                    String[] params62 = {"staffid", "denied"};
                    Object[] paramsValues62 = {staffid, "Denied"};
                    String[] fields62 = {"requisitionid", "status", "recommender", "staffid", "links", "datecreated"};
                    String where62 = "WHERE staffid=:staffid AND status=:denied";
                    List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields62, where62, params62, paramsValues62);
                    Map<String, Object> requests2;
                    if (found62 != null) {
                        for (Object[] req : found62) {
                            requests2 = new HashMap<>();
                            if ((String) req[1] != null) {
                                requests2.put("staffid", (Long) req[3]);
                                aplistd.add(requests2);
                            }
                        }
                    }
                }
            }
        }
        model.addAttribute("deniedrequestscount", aplistd.size());

        List<Map> aplist = new ArrayList<>();
        String[] paramsr = {"facilityunitid", "active"};
        Object[] paramsValuesr = {facilityUnit, true};
        String[] fieldsr = {"staffid"};
        String wherer = "WHERE facilityunitid=:facilityunitid AND active=:active";
        List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsr, wherer, paramsr, paramsValuesr);
        if (staff != null) {
            for (Long staffid : staff) {
                String[] params62 = {"staffid", "approved"};
                Object[] paramsValues62 = {staffid, "approved"};
                String[] fields62 = {"requisitionid", "status", "recommender", "staffid", "links"};
                String where62 = "WHERE staffid=:staffid AND status=:approved";
                List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields62, where62, params62, paramsValues62);
                Map<String, Object> requests2;
                if (found62 != null) {
                    for (Object[] req : found62) {
                        requests2 = new HashMap<>();
                        if ((String) req[4] == null) {
                            requests2.put("staffid", req[3]);
                            aplist.add(requests2);
                        }
                    }
                }
            }
        }
        List<Map> requisitions = new ArrayList<>();
        String[] paramsr1 = {"facilityunitid", "active"};
        Object[] paramsValuesr1 = {facilityUnit, true};
        String[] fieldsr1 = {"staffid"};
        String wherer1 = "WHERE facilityunitid=:facilityunitid AND active=:active";
        List<Long> staff1 = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsr1, wherer1, paramsr1, paramsValuesr1);
        Map<String, Object> requistion;
        if (staff1 != null) {
            for (Long staffid : staff1) {
                requistion = new HashMap<>();
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = {staffid};
                String[] fields2 = {"requisitionid", "status"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Requisition.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {
                    if ((String) found2.get(0)[1] == null) {
                        for (Object[] cr : found2) {
                            requistion.put("requisitionid", cr[0]);
                            requisitions.add(requistion);
                        }
                    }
                }
            }
        }
        model.addAttribute("requisitions", requisitions.size());
        model.addAttribute("aplist", aplist.size());
        return "Usermanagement/Internalsystemuser/RegisterUser/Registeruser";
    }

    @RequestMapping(value = "/manageusers", method = RequestMethod.GET)
    public String manageusers(Model model
    ) {
        return "Usermanagement/Internalsystemuser/manageusers/manageUsers";
    }

    @RequestMapping(value = "/searchuser", method = RequestMethod.POST)
    String searchstaffs1(HttpServletRequest request, Model model,
            @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();

        List<Map> user = new ArrayList<>();
        String[] params = {"currFacility", "othernames", "permutation"};
        Object[] paramsValues = {Long.parseLong(facilityidsession), "%" + searchValue.replace(" ", "").toLowerCase() + "%", searchValue.replace(" ", "").toLowerCase() + "%"};
        String[] fields = {"staffid", "staffno", "firstname", "lastname", "personid", "othernames"};
        String where = "WHERE currentfacility=:currFacility AND (permutation1 LIKE :permutation OR permutation2 LIKE :permutation OR permutation3 LIKE :permutation OR permutation2 LIKE :othernames )ORDER BY firstname, othernames, lastname";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        if (found != null) {
            Map<String, Object> userrow;
            for (Object[] f : found) {
                userrow = new HashMap<>();
                userrow.put("staffid", (BigInteger) f[0]);
                userrow.put("staffno", (String) f[1]);
                userrow.put("firstname", (String) f[2]);
                userrow.put("lastname", (String) f[3]);
                userrow.put("personid", (BigInteger) f[4]);
                userrow.put("othernames", (String) f[5]);
                user.add(userrow);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("user", user);
        model.addAttribute("searchValue", searchValue);
        return "Usermanagement/Internalsystemuser/manageusers/usersearchresult";

    }

    @RequestMapping(value = "/registernewstaff", method = RequestMethod.GET)
    public String registernewstaff(HttpServletRequest request, Model model,
            @ModelAttribute("usersname") String searchedusername
    ) {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        String[] usernamesearch = searchedusername.split(" ");
        for (int i = 0; i < usernamesearch.length; i++) {
            if (usernamesearch.length == 1) {
                model.addAttribute("userFirstName", usernamesearch[0]);

            } else if (usernamesearch.length == 2) {
                model.addAttribute("userFirstName", usernamesearch[0]);
                model.addAttribute("userLastName", usernamesearch[1]);

            } else {
                model.addAttribute("userFirstName", usernamesearch[0]);
                model.addAttribute("userLastName", usernamesearch[1]);
                model.addAttribute("userOtherName", usernamesearch[2]);

            }
        }
        //Fetch designations
        List<Map> designations = new ArrayList<>();
        String[] params61 = {};
        Object[] paramsValues61 = {};
        String[] fields61 = {"designationname", "designationid"};
        String where61 = "ORDER BY designationname ASC";
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
        //Fetch units
        List<Map> units = new ArrayList<>();
        String[] params611 = {"facilityid"};
        Object[] paramsValues611 = {Long.parseLong(facilityidsession)};
        String[] fields1 = {"facilityunitid", "facilityunitname", "facilityid"};
        String where611 = "WHERE facilityid=:facilityid ";
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
        String staffnumber = "";
        int facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
        String[] params = {"facilityid"};
        Object[] paramsValues6 = {facilityId};
        String[] fields6 = {"facilitycode"};
        String where6 = "WHERE facilityid=:facilityid";
        List<String> found6 = (List<String>) genericClassService.fetchRecord(Facility.class, fields6, where6, params, paramsValues6);
        if (found6 != null) {
            staffnumber = generateStaffNumbers(found6.get(0));
        }
        String jsonCreatedmail = "";
        try {
            jsonCreatedmail = new ObjectMapper().writeValueAsString(emails);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonCreatedmail", jsonCreatedmail);
        model.addAttribute("units", units);
        model.addAttribute("designations", designations);
        model.addAttribute("StaffgenNumber", staffnumber);
        return "Usermanagement/Internalsystemuser/manageusers/views/Staffregform";
    }

    @RequestMapping(value = "/userdetails", method = RequestMethod.GET)
    public String userdetails(Model model, HttpServletRequest request
    ) {
        List<Map> stafffacilityunits = new ArrayList<>();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        String[] params = {"staffid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("staffid"))};
        String[] fields = {"staffid", "personid.personid", "designationid.designationid", "staffno"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);

        if (found != null) {
            Object[] fStaff = found.get(0);
            model.addAttribute("staffid", Long.parseLong(fStaff[0].toString()));
            model.addAttribute("personid", (Long) fStaff[1]);
            model.addAttribute("staffno", fStaff[3].toString());
            //Fetch units
            String[] params2 = {"staffid", "active"};
            Object[] paramsValues2 = {(Long) found.get(0)[0], Boolean.TRUE};
            String[] fields2 = {"facilityunitid", "facilityunitname"};
            String where2 = "WHERE staffid=:staffid AND active=:active";
            List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Facilityunits.class, fields2, where2, params2, paramsValues2);
            if (found2 != null) {
                Map<String, Object> unitdetails;
                for (Object[] staff : found2) {
                    unitdetails = new HashMap<>();
                    unitdetails.put("facilityunitid", staff[0]);
                    unitdetails.put("facilityunitname", staff[1]);
                    stafffacilityunits.add(unitdetails);
                }
            }
            //Fetch names
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
            //Fetch designation
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
            String[] fields4 = {"contactvalue", "contactdetailsid"};
            String where4 = "WHERE personid=:personid AND contacttype=:Email";
            List<Object[]> objContactDetails = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, fields4, where4, params4, paramsValues4);
            if (objContactDetails != null) {
                Object[] f1 = objContactDetails.get(0);
                model.addAttribute("contactvalue", f1[0]);
                model.addAttribute("contactdetailsid", f1[1]);

            }

            String[] params4p = {"personid", "PRIMARYCONTACT"};
            Object[] paramsValues4p = {(found.get(0)[1]), "PRIMARYCONTACT"};
            String[] fields4p = {"contactvalue", "contactdetailsid"};
            String where4p = "WHERE personid=:personid AND contacttype=:PRIMARYCONTACT";
            List<Object[]> objContactDetailsp = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, fields4p, where4p, params4p, paramsValues4p);
            if (objContactDetailsp != null) {
                Object[] f1p = objContactDetailsp.get(0);
                model.addAttribute("primarycontact", f1p[0]);
                model.addAttribute("primarycontactid", f1p[1]);

            }
            String[] params4s = {"personid", "Secondarycontact"};
            Object[] paramsValues4s = {(found.get(0)[1]), "SECONDARYCONTACT"};
            String[] fields4s = {"contactvalue", "contactdetailsid"};
            String where4s = "WHERE personid=:personid AND contacttype=:Secondarycontact";
            List<Object[]> objContactDetailss = (List<Object[]>) genericClassService.fetchRecord(Contactdetails.class, fields4s, where4s, params4s, paramsValues4s);
            if (objContactDetailss != null) {
                Object[] f1s = objContactDetailss.get(0);
                model.addAttribute("Secondarycontact", f1s[0]);
                model.addAttribute("secondarycontactid", f1s[1]);
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

        //Fetch all units in a facility
        List<Map> units = new ArrayList<>();
        String[] paramsunits = {"facilityid"};
        Object[] paramsValuesunist = {Long.parseLong(facilityidsession)};
        String[] fieldsunits = {"facilityunitid", "facilityunitname"};
        String whereunits = "WHERE facilityid=:facilityid";
        List<Object[]> foundunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldsunits, whereunits, paramsunits, paramsValuesunist);
        Map<String, Object> unitnames;

        if (foundunits != null) {
            for (Object[] req1 : foundunits) {
                unitnames = new HashMap<>();
                unitnames.put("facilityunitname", req1[1].toString());
                unitnames.put("facilityunitid", (long) req1[0]);
                units.add(unitnames);
            }
        }

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
        String jsonCreatedmail = "";
        String jsonstafffacilityunits = "";
        try {
            jsonCreatedmail = new ObjectMapper().writeValueAsString(emails);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        try {
            jsonstafffacilityunits = new ObjectMapper().writeValueAsString(stafffacilityunits);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonCreatedmail", jsonCreatedmail);
        model.addAttribute("jsonstafffacilityunitss", jsonstafffacilityunits);
        model.addAttribute("staffid", Long.parseLong(request.getParameter("staffid")));
        model.addAttribute("stafffacilityunits", stafffacilityunits.size());
        model.addAttribute("stafffacilityunitss", stafffacilityunits);
        model.addAttribute("designations", designations);
        model.addAttribute("units", units);
        return "Usermanagement/Internalsystemuser/manageusers/views/Userdetails";
    }

    @RequestMapping(value = "/savenewuser.htm")
    public final ModelAndView savenewuser(HttpServletRequest request) throws SQLException {
        Map<String, Object> model = new HashMap<String, Object>();
        String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        String personidsession = request.getSession().getAttribute("person_id").toString();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        Staff newStaff;
        try {

            Person persondetails = new Person();
            String fname = request.getParameter("fname");
            String lastname = request.getParameter("lastname");
            String othername = request.getParameter("othername");

            try {
                persondetails.setFirstname(fname);
                persondetails.setLastname(lastname);
                persondetails.setOthernames(othername);
                persondetails.setDatecreated(new Date());
                persondetails.setFacilityid(new Facility(Integer.parseInt(facilityidsession)));
                persondetails.setRegistrationpoint(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                persondetails = (Person) genericClassService.saveOrUpdateRecordLoadObject(persondetails);

            } catch (Exception ex) {
                System.out.println(ex);
            }

            if (persondetails != null) {
                newStaff = new Staff();
                String designationselect = request.getParameter("designationselect");
                String staffnumber = request.getParameter("staffnumber");

                newStaff.setPersonid(new Person(persondetails.getPersonid()));
                newStaff.setDesignationid(new Designation(Integer.parseInt(designationselect)));
                newStaff.setCreatedby(new Staff(Long.parseLong(staffidsession)));
                newStaff.setDatecreated(new Date());
                newStaff.setCurrentfacility(new Facility(Integer.parseInt(facilityidsession)));
                newStaff.setStaffno(staffnumber);
                newStaff = (Staff) genericClassService.saveOrUpdateRecordLoadObject(newStaff);
                if (newStaff != null) {
                    List<String> units = (ArrayList) new ObjectMapper().readValue(request.getParameter("unitselect"), List.class);
                    for (String unit : units) {
                        Stafffacilityunit staffunits = new Stafffacilityunit();
                        staffunits.setStaffid(newStaff.getStaffid());
                        staffunits.setFacilityunitid(Long.parseLong(unit));
                        staffunits.setActive(true);
                        genericClassService.saveOrUpdateRecordLoadObject(staffunits);
                    }
                }

                Contactdetails contacts = new Contactdetails();

                String emailflag = request.getParameter("emailflag");
                String email = request.getParameter("email");
                contacts.setContacttype(emailflag);
                contacts.setContactvalue(email);
                contacts.setPersonid(persondetails.getPersonid());
                genericClassService.saveOrUpdateRecordLoadObject(contacts);

                Contactdetails contact1 = new Contactdetails();

                String primarycontactflag = request.getParameter("primarycontactflag");
                String pcontact = request.getParameter("pcontact");
                contact1.setContacttype(primarycontactflag);
                contact1.setContactvalue(pcontact);
                contact1.setPersonid(persondetails.getPersonid());
                genericClassService.saveOrUpdateRecordLoadObject(contact1);

                Contactdetails contact2 = new Contactdetails();
                String secondarycontactflag = request.getParameter("secondarycontactflag");
                String scontact = request.getParameter("scontact");

                contact2.setContacttype(secondarycontactflag);
                contact2.setContactvalue(scontact);
                contact2.setPersonid(persondetails.getPersonid());
                genericClassService.saveOrUpdateRecordLoadObject(contact2);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ModelAndView("Usermanagement/Internalsystemuser/manageusers/manageUsers", "model", model);
    }

    @RequestMapping(value = "/updatefirstname", method = RequestMethod.POST)
    public @ResponseBody
    String updatefirstname(HttpServletRequest request
    ) {
        try {
            //update designations
            String firstname = request.getParameter("name");
            Long personid = Long.parseLong(request.getParameter("personid"));

            String[] columns = {"firstname"};
            Object[] columnValues = {firstname};
            String pk = "personid";
            Object pkValue = personid;
            genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");

        } catch (NumberFormatException ex) {
        }

        return "";
    }

    @RequestMapping(value = "/updatelastname", method = RequestMethod.POST)
    public @ResponseBody
    String updatelastname(HttpServletRequest request
    ) {
        try {
            //update designations
            String lastname = request.getParameter("lname");
            Long personid = Long.parseLong(request.getParameter("personid"));

            String[] columns = {"lastname"};
            Object[] columnValues = {lastname};
            String pk = "personid";
            Object pkValue = personid;
            genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/updateOthername", method = RequestMethod.POST)
    public @ResponseBody
    String updateOthername(HttpServletRequest request
    ) {
        try {
            //update designations
            String Othername = request.getParameter("Othername");
            Long personid = Long.parseLong(request.getParameter("personid"));

            String[] columns = {"othernames"};
            Object[] columnValues = {Othername};
            String pk = "personid";
            Object pkValue = personid;
            genericClassService.updateRecordSQLSchemaStyle(Person.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/updatemail", method = RequestMethod.POST)
    public @ResponseBody
    String updatemail(HttpServletRequest request
    ) {
        try {
            //update designations
            String email = request.getParameter("email");
            String contactdetailsid = (request.getParameter("contactdetailsid"));

            String[] columns = {"contactvalue"};
            Object[] columnValues = {email};
            String pk = "contactdetailsid";
            Object pkValue = Integer.parseInt(contactdetailsid);
            genericClassService.updateRecordSQLSchemaStyle(Contactdetails.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/updateprimarycontact", method = RequestMethod.POST)
    public @ResponseBody
    String updateprimarycontact(HttpServletRequest request
    ) {
        try {

            //update designations
            String PrimaryContact = request.getParameter("PrimaryContact");
            System.out.println("-------PrimaryContact------" + PrimaryContact);
            String primarycontactid = (request.getParameter("primarycontactid"));

            String[] columns = {"contactvalue"};
            Object[] columnValues = {PrimaryContact};
            String pk = "contactdetailsid";
            Object pkValue = Integer.parseInt(primarycontactid);
            genericClassService.updateRecordSQLSchemaStyle(Contactdetails.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/updatesecondarycontact", method = RequestMethod.POST)
    public @ResponseBody
    String updatesecondarycontact(HttpServletRequest request
    ) {
        try {
            //update designations
            String SecondaryContact = request.getParameter("SecondaryContact");
            String secondarycontactid = (request.getParameter("secondarycontactid"));

            String[] columns = {"contactvalue"};
            Object[] columnValues = {SecondaryContact};
            String pk = "contactdetailsid";
            Object pkValue = Integer.parseInt(secondarycontactid);
            genericClassService.updateRecordSQLSchemaStyle(Contactdetails.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/addmail", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView addmail(HttpServletRequest request
    ) {

        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Contactdetails contact = new Contactdetails();

            String contactvalue = request.getParameter("email");
            String contacttype = request.getParameter("contacttype");
            String personid = request.getParameter("personid");

            contact.setContactvalue(contactvalue);
            contact.setContacttype(contacttype);
            contact.setPersonid(Long.parseLong(personid));

            Object save = genericClassService.saveOrUpdateRecordLoadObject(contact);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("Usermanagement/Internalsystemuser/manageusers/views/Userdetails", "model", model);
    }

    @RequestMapping(value = "/addprimarycontact", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView addprimarycontact(HttpServletRequest request
    ) {

        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Contactdetails contact = new Contactdetails();

            String PrimaryContact = request.getParameter("PrimaryContact");
            String contacttype = request.getParameter("contacttype");
            String personid = request.getParameter("personid");
            System.out.println("----------PrimaryContact---------" + PrimaryContact);
            System.out.println("----------contacttype---------" + contacttype);
            System.out.println("----------personid---------" + personid);
            contact.setContactvalue(PrimaryContact);
            contact.setContacttype(contacttype);
            contact.setPersonid(Long.parseLong(personid));

            Object save = genericClassService.saveOrUpdateRecordLoadObject(contact);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("Usermanagement/Internalsystemuser/manageusers/views/Userdetails", "model", model);
    }

    @RequestMapping(value = "/addsecondarycontact", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView addsecondarycontact(HttpServletRequest request
    ) {

        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Contactdetails contact = new Contactdetails();
            String SecondaryContact = request.getParameter("SecondaryContact");
            String contacttype = request.getParameter("contacttype");
            String personid = request.getParameter("personid");

            contact.setContactvalue(SecondaryContact);
            contact.setContacttype(contacttype);
            contact.setPersonid(Long.parseLong(personid));

            Object save = genericClassService.saveOrUpdateRecordLoadObject(contact);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("Usermanagement/Internalsystemuser/manageusers/views/Userdetails", "model", model);
    }

    @RequestMapping(value = "/editdesignation", method = RequestMethod.POST)
    public @ResponseBody
    String editdesignation(HttpServletRequest request
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

    @RequestMapping(value = "/editstaffnumber", method = RequestMethod.POST)
    public @ResponseBody
    String editstaffnumber(HttpServletRequest request
    ) {
        try {
            //update designations
            String Staffnumber = request.getParameter("Staffnumber");
            Long staffid = Long.parseLong(request.getParameter("staffid"));

            String[] columns = {"staffno"};
            Object[] columnValues = {Staffnumber,};
            String pk = "staffid";
            Object pkValue = staffid;
            genericClassService.updateRecordSQLSchemaStyle(Staff.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/editunit", method = RequestMethod.POST)
    public @ResponseBody
    String editunit(HttpServletRequest request
    ) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            String[] params61 = {"staffid"};
            Object[] paramsValues61 = {Long.parseLong(request.getParameter("staffid"))};
            String[] fields61 = {"stafffacilityunitid"};
            String where61 = "WHERE staffid=:staffid";
            List<Long> stafffacilityunitid = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields61, where61, params61, paramsValues61);
            if (stafffacilityunitid != null) {
                for (Long stafffacilityunit : stafffacilityunitid) {
                    String[] columns = {"stafffacilityunitid"};
                    Object[] columnValues = {stafffacilityunit};
                    genericClassService.deleteRecordByByColumns("controlpanel.stafffacilityunit", columns, columnValues);
                }
            }

            List<String> units = (ArrayList) new ObjectMapper().readValue(request.getParameter("units"), List.class);
            //update designations
            for (String unit : units) {
                Stafffacilityunit staffunit = new Stafffacilityunit();
                String staffid = request.getParameter("staffid");
                staffunit.setStaffid(Long.parseLong(staffid));
                staffunit.setFacilityunitid(Long.parseLong(unit));
                staffunit.setActive(true);
                Object save = genericClassService.saveOrUpdateRecordLoadObject(staffunit);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    private String generateStaffNumbers(String shortname) {
        String name = shortname + "/";
        SimpleDateFormat f = new SimpleDateFormat("MMyy");
        String pattern = name + f.format(new Date()) + "/%";
        String staffNumber = "";

        String[] params = {"staffno"};
        Object[] paramsValues = {pattern};
        String[] fields = {"staffno"};
        String where = "WHERE staffno LIKE :staffno ORDER BY staffno DESC LIMIT 1";
        List<String> lastFacilityPatientno = (List<String>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);
        if (lastFacilityPatientno == null) {
            staffNumber = name + f.format(new Date()) + "/0001";
            return staffNumber;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilityPatientno.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        staffNumber = name + f.format(new Date()) + "/000" + newNo;
                        break;
                    case 2:
                        staffNumber = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 3:
                        staffNumber = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        staffNumber = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return staffNumber;
    }

    @RequestMapping(value = "/searchemail", method = RequestMethod.POST)
    public @ResponseBody
    String searchusername(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) {
        String results = "";
        if ("email".equals(request.getParameter("type"))) {
            String[] params = {"value"};
            Object[] paramsValues = {searchValue};
            String[] fields = {"contactvalue"};
            String where = "WHERE contactvalue=:value";
            List<String> found = (List<String>) genericClassService.fetchRecord(Contactdetails.class, fields, where, params, paramsValues);
            if (found != null) {
                results = "existing";
            } else {
                results = "notexisting";

            }
        } else {

        }
        return results;
    }

    @RequestMapping(value = "/retrievequestions", method = RequestMethod.POST)
    public @ResponseBody
    String retrievequestions(HttpServletRequest request, Model model, @ModelAttribute("inputmail") String inputmail) {
        String results = "";
        List<Map> qndata = new ArrayList<>();
        Map<String, Object> qn = new HashMap<>();
        String[] params = {"inputmail"};
        Object[] paramsValues = {inputmail};
        String[] fields = {"personid"};
        String where = "WHERE contactvalue=:inputmail";
        List<Long> found = (List<Long>) genericClassService.fetchRecord(Contactdetails.class, fields, where, params, paramsValues);
        if (found != null) {
            String[] params1 = {"personid"};
            Object[] paramsValues1 = {found.get(0)};
            String[] fields1 = {"systemuserid"};
            String where1 = "WHERE personid=:personid";
            List<Long> found1 = (List<Long>) genericClassService.fetchRecord(Systemuser.class, fields1, where1, params1, paramsValues1);
            if (found1 != null) {
                String[] params2 = {"systemuserid"};
                Object[] paramsValues2 = {found1.get(0)};
                String[] fields2 = {"questionsid"};
                String where2 = "WHERE systemuserid=:systemuserid";
                List<Integer> found2 = (List<Integer>) genericClassService.fetchRecord(Userquestions.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {

                    String[] params3 = {"questionsid"};
                    Object[] paramsValues3 = {found2.get(0)};
                    String[] fields3 = {"question"};
                    String where3 = "WHERE questionsid=:questionsid";
                    List<String> found3 = (List<String>) genericClassService.fetchRecord(Questions.class, fields3, where3, params3, paramsValues3);
                    if (found3 != null) {
                        qn.put("question", found3.get(0));
                        qn.put("systemuserid", found1.get(0));
                        qn.put("questionsid", found2.get(0));
                    }
                }
            }
        }
        qndata.add(qn);
        try {
            results = new ObjectMapper().writeValueAsString(qndata);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RegisterUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/submitanswer", method = RequestMethod.POST)
    public @ResponseBody
    String submitanswer(HttpServletRequest request, Model model, @ModelAttribute("qnid") String qnid, @ModelAttribute("answer") String answer, @ModelAttribute("userid") String userid) throws NoSuchAlgorithmException {
        String encryptedanswer = getMD5EncryptedValue(answer);
        String results = "";
        String[] params1 = {"questionsid", "userid"};
        Object[] paramsValues1 = {Integer.parseInt(qnid), Long.parseLong(userid)};
        String[] fields1 = {"answer"};
        String where1 = "WHERE questionsid=:questionsid AND systemuserid=:userid";
        List<String> found1 = (List<String>) genericClassService.fetchRecord(Userquestions.class, fields1, where1, params1, paramsValues1);
        if (found1 != null) {
            if (encryptedanswer == null ? found1.get(0) == null : encryptedanswer.equals(found1.get(0))) {
                results = "EQUAL";
            } else {
                results = "NOTEQUAL";

            }
        }
        return results;
    }

    public static String getMD5EncryptedValue(String answer) throws NoSuchAlgorithmException {
        final byte[] defaultBytes = answer.getBytes();
        final MessageDigest md5MsgDigest = MessageDigest.getInstance("MD5");
        md5MsgDigest.reset();
        md5MsgDigest.update(defaultBytes);
        final byte messageDigest[] = md5MsgDigest.digest();
        final StringBuffer hexString = new StringBuffer();
        for (final byte element : messageDigest) {
            final String hex = Integer.toHexString(0xFF & element);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        answer = hexString + "";
        return answer;
    }

    @RequestMapping(value = "/passwordrecoveryform", method = RequestMethod.GET)
    public String passwordrecoveryform(Model model, @ModelAttribute("userid") String userid) {
        model.addAttribute("systemuserid", userid);
        return "passwordrecovery";
    }

    @RequestMapping(value = "/save_recovered_credentials")
    @ResponseBody
    String save_recovered_credentials(HttpServletRequest request, Model model) throws NoSuchAlgorithmException {
        String results = "";
        String systemuserid = request.getParameter("systemuserid");
        String newusername = request.getParameter("newusername");
        String newpassword = request.getParameter("newpassword");
        String hashedpassword = getMD5EncryptedValue(newpassword);
        String[] columns = {"username", "password"};
        Object[] columnValues = {newusername, hashedpassword};
        String pk = "systemuserid";
        Object pkValue = Long.parseLong(systemuserid);
        genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        return results;
    }

    @RequestMapping(value = "/load_second_question", method = RequestMethod.POST)
    public @ResponseBody
    String load_second_question(HttpServletRequest request, Model model, @ModelAttribute("qnid1") String qnid1, @ModelAttribute("userid") String userid) {
        String results = "";
        List<Map> qndata = new ArrayList<>();
        Map<String, Object> qn = new HashMap<>();
        String[] params2 = {"systemuserid"};
        Object[] paramsValues2 = {Long.parseLong(userid)};
        String[] fields2 = {"questionsid"};
        String where2 = "WHERE systemuserid=:systemuserid";
        List<Integer> found2 = (List<Integer>) genericClassService.fetchRecord(Userquestions.class, fields2, where2, params2, paramsValues2);
        if (found2 != null) {
            for (Integer qnz : found2) {
                if (qnz != Integer.parseInt(qnid1)) {
                    String[] params3 = {"questionsid"};
                    Object[] paramsValues3 = {qnz};
                    String[] fields3 = {"question", "questionsid"};
                    String where3 = "WHERE questionsid=:questionsid";
                    List<Object[]> found3 = (List<Object[]>) genericClassService.fetchRecord(Questions.class, fields3, where3, params3, paramsValues3);
                    if (found3 != null) {
                        qn.put("question", found3.get(0)[0]);
                        qn.put("questionsid", (Integer) found3.get(0)[1]);
                        qn.put("systemuserid", userid);
                    }
                }
            }
            qndata.add(qn);
        }
        try {
            results = new ObjectMapper().writeValueAsString(qndata);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RegisterUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/load_third_question", method = RequestMethod.POST)
    public @ResponseBody
    String load_third_question(HttpServletRequest request, Model model, @ModelAttribute("qnid1") String qnid1, @ModelAttribute("qnid2") String qnid2, @ModelAttribute("userid") String userid) {
        String results = "";
        List<Map> qndata = new ArrayList<>();
        Map<String, Object> qn = new HashMap<>();
        String[] params2 = {"systemuserid"};
        Object[] paramsValues2 = {Long.parseLong(userid)};
        String[] fields2 = {"questionsid"};
        String where2 = "WHERE systemuserid=:systemuserid";
        List<Integer> found2 = (List<Integer>) genericClassService.fetchRecord(Userquestions.class, fields2, where2, params2, paramsValues2);
        if (found2 != null) {
            for (Integer qnz : found2) {
                if (qnz != Integer.parseInt(qnid1) && qnz != Integer.parseInt(qnid2)) {
                    String[] params3 = {"questionsid"};
                    Object[] paramsValues3 = {qnz};
                    String[] fields3 = {"question", "questionsid"};
                    String where3 = "WHERE questionsid=:questionsid";
                    List<Object[]> found3 = (List<Object[]>) genericClassService.fetchRecord(Questions.class, fields3, where3, params3, paramsValues3);
                    if (found3 != null) {
                        qn.put("question", found3.get(0)[0]);
                        qn.put("questionsid", (Integer) found3.get(0)[1]);
                        qn.put("systemuserid", userid);
                    }
                }
            }
            qndata.add(qn);
        }
        try {
            results = new ObjectMapper().writeValueAsString(qndata);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RegisterUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/staffunits", method = RequestMethod.GET)
    public String staffunits(HttpServletRequest request, Model model
    ) {
        String staffid = request.getParameter("staffid");
        List<Map> staffunits = new ArrayList<>();

        String[] params61 = {"staffid"};
        Object[] paramsValues61 = {BigInteger.valueOf(Long.parseLong(staffid))};
        String[] fields61 = {"facilityunitid", "facilityunitname", "active"};
        String where61 = "WHERE staffid=:staffid";
        List<Object[]> found61 = (List<Object[]>) genericClassService.fetchRecord(Facilityunits.class, fields61, where61, params61, paramsValues61);
        Map<String, Object> staffunitnames;

        if (found61 != null) {
            for (Object[] req1 : found61) {
                staffunitnames = new HashMap<>();
                staffunitnames.put("facilityunitid", (BigInteger) req1[0]);
                staffunitnames.put("facilityunitname", (String) req1[1]);
                staffunitnames.put("active", (Boolean) req1[2]);
                staffunits.add(staffunitnames);

                String[] params6 = {"facilityunitid", "staffid"};
                Object[] paramsValues6 = {(BigInteger) req1[0], Long.parseLong(staffid)};
                String[] fields6 = {"stafffacilityunitid"};
                String where6 = "WHERE facilityunitid=:facilityunitid AND staffid=:staffid";
                List<Long> found6 = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields6, where6, params6, paramsValues6);
                if (found6 != null) {
                    for (Long stf : found6) {
                        staffunitnames.put("stafffacilityunitid", stf);
                    }
                }

            }
        }
        model.addAttribute("staffid", staffid);
        model.addAttribute("staffunits", staffunits);
        return "Usermanagement/Internalsystemuser/manageusers/views/staffunits";
    }

    @RequestMapping(value = "/deactivateunit")
    @ResponseBody
    String deactivateunit(HttpServletRequest request, Model model) {
        String results = "";
        String stafffacilityunitid = (request.getParameter("stafffacilityunitid"));
        String[] columns = {"active"};
        Object[] columnValues = {Boolean.FALSE};
        String pk = "stafffacilityunitid";
        Object pkValue = Long.parseLong(stafffacilityunitid);
        genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunit.class, columns, columnValues, pk, pkValue, "controlpanel");

        return results;
    }

    @RequestMapping(value = "/activateunit")
    @ResponseBody
    String activateunit(HttpServletRequest request, Model model) {
        String results = "";
        String stafffacilityunitid = (request.getParameter("stafffacilityunitid"));
        String[] columns = {"active"};
        Object[] columnValues = {Boolean.TRUE};
        String pk = "stafffacilityunitid";
        Object pkValue = Long.parseLong(stafffacilityunitid);
        genericClassService.updateRecordSQLSchemaStyle(Stafffacilityunit.class, columns, columnValues, pk, pkValue, "controlpanel");

        return results;
    }

    @RequestMapping(value = "/facilityunits", method = RequestMethod.GET)
    public String facilityunits(HttpServletRequest request, Model model) {
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();
        String staffid = (request.getParameter("staffid"));
        List<Map> staffunits = new ArrayList<>();

        String[] params61 = {"facilityid"};
        Object[] paramsValues61 = {Long.parseLong(facilityidsession)};
        String[] fields61 = {"facilityunitid", "facilityunitname"};
        String where61 = "WHERE facilityid=:facilityid";
        List<Object[]> found61 = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields61, where61, params61, paramsValues61);
        Map<String, Object> staffunitnames;
        if (found61 != null) {
            for (Object[] units : found61) {
                staffunitnames = new HashMap<>();
                staffunitnames.put("facilityunitname", (String) units[1]);
                staffunitnames.put("facilityunitid", (Long) units[0]);
                staffunits.add(staffunitnames);
            }

        }
        model.addAttribute("staffid", staffid);
        model.addAttribute("staffunits", staffunits);
        return "Usermanagement/Internalsystemuser/manageusers/views/facilityunits";
    }

    @RequestMapping(value = "/savenewunit")
    @ResponseBody
    String savenewunit(HttpServletRequest request, Model model) {
        String results = "";
        String facilityunitid = (request.getParameter("facilityunitid"));
        String staffid = (request.getParameter("staffid"));
        Stafffacilityunit newunit = new Stafffacilityunit();

        newunit.setActive(true);
        newunit.setFacilityunitid(Long.parseLong(facilityunitid));
        newunit.setStaffid(Long.parseLong(staffid));
        genericClassService.saveOrUpdateRecordLoadObject(newunit);

        return results;
    }
    @RequestMapping(value = "/deactivateuser")
    @ResponseBody
    String deactivateuser(HttpServletRequest request, Model model) {
        String results = "";
        String systemuserid = (request.getParameter("systemuserid"));
        String[] columns = {"active"};
        Object[] columnValues = {Boolean.FALSE};
        String pk = "systemuserid";
        Object pkValue = Long.parseLong(systemuserid);
        System.out.println("-------systemuserid-------"+systemuserid);
        genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        return results;
    }
    @RequestMapping(value = "/activateuser")
    @ResponseBody
    String activateuser(HttpServletRequest request, Model model) {
        
        String results = "";
        String systemuserid = (request.getParameter("systemuserid"));
        System.out.println("-------systemuserid-------"+systemuserid);
        String[] columns = {"active"};
        Object[] columnValues = {Boolean.TRUE};
        String pk = "systemuserid";
        Object pkValue = Long.parseLong(systemuserid);
        genericClassService.updateRecordSQLSchemaStyle(Systemuser.class, columns, columnValues, pk, pkValue, "public");

        return results;
    }

}
