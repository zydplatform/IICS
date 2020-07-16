package com.iics.web.general;

import com.iics.controlpanel.Privilege;
import com.iics.controlpanel.Staffassignedrights;
import com.iics.domain.*;
import com.iics.service.GenericClassService;
import com.iics.store.Supplier;
import com.iics.suppliersplatform.domain.Supplierstaff;
import com.iics.utils.IICS;
import java.net.URL;
import java.security.Principal;
import java.util.*;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
//import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author samuelwam
 */
@Controller
public class MainController {

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    @Resource(name = "sessionRegistry")
    private SessionRegistryImpl sessionRegistry;
    private String username;

    /**
     * Handles and retrieves the common JSP page that everyone can see
     *
     * @param request
     * @param info
     * @return the name of the JSP page
     */
    @RequestMapping(value = "/index.htm")
    public ModelAndView getIndex(Model model, HttpServletRequest request, Principal principal, HttpServletResponse response) throws Exception {
        Long systemuserid = 0L;
        Object principalx = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        URL url = new URL(request.getRequestURL().toString());
        Integer port = url.getPort();
        IICS.BASE_URL = IICS.BASE_URL.replace("8085", port.toString());
        
//        if(principal == null){
//            return new ModelAndView("frontPage");
//        }
        
        if (principalx instanceof UserDetails) {
            this.username = ((UserDetails) principalx).getUsername();
        } else {
            this.username = principalx.toString();
        }
        System.out.println("~~~~~~~~~~~~~~~~~~~" + username);
        System.out.println("userrrrrrrrrrrrrrr" + username);
        String byt = request.getParameter("b");
        System.out.println("loading index " + byt);
        boolean selectLocation = false;
        String selectAttr = "";
        Systemuser systemuser = new Systemuser();
        logger.info("Principals Not Null ::::");
        String[] params = {"username","active"};
        Object[] paramsValues = {username,Boolean.TRUE};
        String[] fields = {"systemuserid", "username", "active", "personid.personid", "personid.firstname", "personid.lastname", "personid.othernames", "personid.imagepath", "password"};
        List<Object[]> user_s = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields, " WHERE r.username=:username AND r.active=:active", params, paramsValues);
        if (user_s != null) {
            Object[] ku = user_s.get(0);
            systemuserid = (long) ku[0];
            for (Object[] obj : user_s) {
                systemuser = new Systemuser((Long) obj[0]);
                systemuser.setUsername((String) obj[1]);
                systemuser.setActive((Boolean) obj[2]);
                Person person = new Person((Long) obj[3]);
                person.setFirstname((String) obj[4]);
                person.setLastname((String) obj[5]);
                person.setOthernames((String) obj[6]);
                person.setImagepath((String) obj[7]);
                systemuser.setPersonid(person);
                if (ku[6] != null && ((String)ku[6]).length() > 0) {
                    model.addAttribute("othername", ((String)ku[6]).charAt(0));
                }
                model.addAttribute("personObj", person);
                model.addAttribute("firstname",(String)ku[4] );
                model.addAttribute("lastname", (String)ku[5]);
                request.getSession().setAttribute("sessionActiveLoginothername", "");
                request.getSession().setAttribute("sessionActiveLoginfirstname",(String)ku[4]);
                request.getSession().setAttribute("sessionActiveLoginlastname",(String)ku[5]);
                model.addAttribute("username", username);
                model.addAttribute("password", (String) obj[8]);
                long personid = systemuser.getPersonid().getPersonid();
                request.getSession().setAttribute("person_id", personid);
                request.getSession().setAttribute("systemuserid", systemuser.getSystemuserid());
                request.getSession().setAttribute("systemuser", systemuser);

                //Check Change Session
                if (request.getSession().getAttribute("sessionChanged") == null) {
                    String[] params2 = {"pId"};
                    Object[] paramsValues2 = {person.getPersonid()};
                    String[] fields2 = {"facilityid.facilityid", "facilityid.facilityid"};
                    List<Object[]> personFacility = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields2, " WHERE r.personid=:pId AND r.facilityid IS NOT NULL", params2, paramsValues2);
                    logger.info("personFacility:::::::::::::"+personFacility);
                    if (personFacility != null && !personFacility.isEmpty() && personFacility.get(0)!= null) {
                        request.getSession().setAttribute("sessionPlatFormMode", "Facility");
                        for (Object[] obj2 : personFacility) {
                            request.getSession().setAttribute("sessionActiveLoginFacilityUnit", (Integer) obj2[0]);
                            request.getSession().setAttribute("sessionActiveLoginFacility", (Integer) obj2[1]);
                            request.getSession().setAttribute("sessionActiveLoginOrg", (Integer) obj2[1]);
                            request.getSession().setAttribute("sessionLoginFacilityUnit", (Integer) obj2[0]);
                            request.getSession().setAttribute("sessionLoginFacility", (Integer) obj2[1]);
                        }
                        String[] params3 = {"personid", "currentfacility"};
                        Object[] paramsValues3 = {personid, request.getSession().getAttribute("sessionActiveLoginFacility")};
                        String[] fields3 = {"staffid"};
                        String where3 = "WHERE personid=:personid AND currentfacility=:currentfacility";
                        List<Long> staffId = (List<Long>) genericClassService.fetchRecord(Staff.class, fields3, where3, params3, paramsValues3);
                        if (staffId != null) {
                            request.getSession().setAttribute("sessionActiveLoginStaffid", staffId.get(0));
                            String[] paramstaff = {"staffid"};
                            Object[] paramsValuestaff = {staffId.get(0)};
                            String[] fieldstaff = {"designationid.designationid"};
                            String wherestaff = "WHERE staffid=:staffid";
                            List<Integer> found1 = (List<Integer>) genericClassService.fetchRecord(Staff.class, fieldstaff, wherestaff, paramstaff, paramsValuestaff);
                            if (found1 != null) {
                                String[] paramsDes = {"designationid"};
                                Object[] paramsValuesDe = {found1.get(0)};
                                String[] fieldsDe = {"designationname"};
                                String whereDe = "WHERE designationid=:designationid";
                                List<String> founddesignation = (List<String>) genericClassService.fetchRecord(Designation.class, fieldsDe, whereDe, paramsDes, paramsValuesDe);
                                if (founddesignation != null) {
                                    String f = founddesignation.get(0);
                                    model.addAttribute("designationname", (String) f);
                                }
                            }
                        }
                    }else{
                        //-----Users From Suppliers Platform Logining In-----
                        logger.info("Suppliers PlatForm Loading ----------------*****");
                        List<Object[]> supplierStaffFacility = (List<Object[]>) genericClassService.fetchRecord(Person.class, new String[]{"supplier.supplierid","supplier.suppliername"}, " WHERE r.personid=:pId", params2, paramsValues2);
                            if (supplierStaffFacility != null && !supplierStaffFacility.isEmpty()) {
                                request.getSession().setAttribute("sessionPlatFormMode", "Supplier");
                                for (Object[] obj2 : supplierStaffFacility) {
                                //request.getSession().setAttribute("sessionActiveLoginSupplierUnit", (Long) obj2[0]);
                                request.getSession().setAttribute("sessionActiveLoginSupplier", (Long) obj2[0]);
                                //request.getSession().setAttribute("sessionLoginSupplierUnit", (Long) obj2[0]);
                                request.getSession().setAttribute("sessionLoginSupplier", (Long) obj2[0]);
                            }
                            String[] params3 = {"personid", "currentfacility"};
                            Object[] paramsValues3 = {personid, request.getSession().getAttribute("sessionActiveLoginSupplier")};
                            String[] fields3 = {"staffid"};
                            String where3 = "WHERE personid=:personid AND currentfacility=:currentfacility";
                            List<Long> staffId = (List<Long>) genericClassService.fetchRecord(Supplierstaff.class, fields3, where3, params3, paramsValues3);
                            if (staffId != null) {
                                request.getSession().setAttribute("sessionActiveLoginSupplierStaffid", staffId.get(0));
                                String[] paramstaff = {"staffid"};
                                Object[] paramsValuestaff = {staffId.get(0)};
                                String[] fieldstaff = {"designationid"};
                                String wherestaff = "WHERE staffid=:staffid";
                                List<Integer> found1 = (List<Integer>) genericClassService.fetchRecord(Supplierstaff.class, fieldstaff, wherestaff, paramstaff, paramsValuestaff);
                                if (found1 != null) {
                                    String[] paramsDes = {"designationid"};
                                    Object[] paramsValuesDe = {found1.get(0)};
                                    String[] fieldsDe = {"designationname"};
                                    String whereDe = "WHERE designationid=:designationid";
                                    List<String> founddesignation = (List<String>) genericClassService.fetchRecord(Designation.class, fieldsDe, whereDe, paramsDes, paramsValuesDe);
                                    if (founddesignation != null) {
                                        String f = founddesignation.get(0);
                                        model.addAttribute("designationname", (String) f);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    String[] paramsDes = {"staffid"};
                    Object[] paramsValuesDe = {request.getSession().getAttribute("sessionActiveLoginStaffid")};
                    String[] fieldsDe = {"designationname"};
                    String whereDe = "WHERE staffid=:staffid";
                    List<String> staffDesignation = (List<String>) genericClassService.fetchRecord(Searchstaff.class, fieldsDe, whereDe, paramsDes, paramsValuesDe);
                    if (staffDesignation != null) {
                        model.addAttribute("designationname", staffDesignation.get(0));
                    }
                }
            }
            logger.info("Checking If Staff Session Not NuLL");
            String[] params6 = {"systemuserid"};
            Object[] paramsValues6 = {systemuserid};
            String where6 = "WHERE systemuserid=:systemuserid";
            int questionCount = genericClassService.fetchRecordCount(Userquestions.class, where6, params6, paramsValues6);
            if (questionCount > 0) {
                //Loading Units and Access Rights, Check Mode
                String iicsPlatFormMode = (String) request.getSession().getAttribute("sessionPlatFormMode");
                //Users Under The IICS Facility Mode
                if (iicsPlatFormMode.equals("Facility")) {
                    if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
                        long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
                        if (request.getSession().getAttribute("sessionChanged") == null) {
                            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                            logger.info("Picked Staff :::: " + staffid + " @ Facility :::: " + facilityid);
                            int units=0;
                            List<Facilityunit> unitList = new ArrayList<Facilityunit>();
                            String[] field2 = {"facilityunitid", "facilityunitname"};
                            List<Object[]> fuListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, field2, "WHERE r.facilityid=:facId AND r.facilityunitid IN (SELECT sfu.facilityunitid FROM Stafffacilityunit sfu WHERE sfu.staffid=:sId AND sfu.active=:status AND sfu.facilityunitid IN (SELECT fu.facilityunitid FROM Facilityunit fu WHERE fu.facilityid=:facId)) AND r.facilityunitid IN (SELECT sar.facilityunitid FROM Staffassignedrights sar WHERE sar.facilityid=:facId AND sar.staffid=:sId) ORDER BY r.facilityunitname ASC", new String[]{"facId", "sId", "status"}, new Object[]{facilityid, staffid, true});
                            if (fuListArr != null) {
                                logger.info("fuListArr c: "+fuListArr.size());
                                units=unitList.size();
                                for (Object[] obj : fuListArr) {
                                    Facilityunit fu = new Facilityunit();
                                    fu.setFacilityunitid((Long) obj[0]);
                                    fu.setFacilityunitname((String) obj[1]);
                                    unitList.add(fu);
                                }
                            }
                            logger.info("Checked Units ::::"+units);
                            model.addAttribute("unitList", unitList);
                            if (unitList != null && !unitList.isEmpty()) {
                                model.addAttribute("unitSize", unitList.size());
                                model.addAttribute("activeUnit", unitList.get(0).getFacilityunitname());
                                model.addAttribute("activeUnitId", unitList.get(0).getFacilityunitid());
                                logger.info("Got Units ::::" + unitList.size());
                                long facilityunitid = unitList.get(0).getFacilityunitid();
                                request.getSession().setAttribute("sessionActiveLoginFacilityUnit", Integer.valueOf(String.valueOf(facilityunitid)));
                                request.getSession().setAttribute("sessionActiveLoginFacilityUnitObj", unitList.get(0));

                                String[] field3 = {"facilityid", "facilityname"};
                                List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field3, "WHERE r.facilityid IN (SELECT fu.facilityid FROM Facilityunit fu WHERE fu.facilityunitid=:fuId AND fu.facilityid=:facId)", new String[]{"facId", "fuId"}, new Object[]{facilityid, facilityunitid});
                                Facility facObj = new Facility();
                                if (facListArr != null) {
                                    for (Object[] obj : facListArr) {
                                        facObj.setFacilityid((Integer) obj[0]);
                                        facObj.setFacilityname((String) obj[1]);
                                    }
                                }
                                request.getSession().setAttribute("sessionActiveLoginFacilityObj", facObj);
                                model.addAttribute("facilityObj", facObj);

                                String[] params2 = {"sId", "fuId", "status","isactive"};
                                Object[] paramsValues2 = {staffid, facilityunitid, Boolean.TRUE,Boolean.TRUE};
                                String[] prvFields = {"privilegekey"};
                                logger.info("StaffId:"+staffid+" UnitId:"+facilityunitid);
                                List<String> accessrights = (List<String>) genericClassService.fetchRecord(Staffassignedrights.class, prvFields, "WHERE staffid=:sId AND facilityunitid=:fuId AND isactive=:status AND stafffacilityunitaccessrightprivstatus=:isactive", params2, paramsValues2);
                                logger.info("Fetching Rights Under Unit ::::" + facilityunitid + " @ " + unitList.get(0).getFacilityunitname()+" String List:::"+accessrights);
                                if (accessrights != null) {
                                    logger.info("Got Rights ::::" + accessrights.size());
                                    List<GrantedAuthority> authoritys = createAuthoritys(accessrights);
                                    model.addAttribute("accessrightsnumber", accessrights.size());
                                    List<String> li = new ArrayList<String>();
                                    if (authoritys != null) {
                                        //GrantedAuthority[] originalRoles = (GrantedAuthority[]) authoritys.toArray(new GrantedAuthority[0]);

                                        //Modify the Authentication object by adding the new roles and privileges.
                                        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(
                                                SecurityContextHolder.getContext().getAuthentication().getPrincipal(),
                                                SecurityContextHolder.getContext().getAuthentication().getCredentials(), authoritys));

                                        for (GrantedAuthority grantedAuthority : authoritys) {
                                            li.add(grantedAuthority.getAuthority());
                                            logger.info("grantedAuthority.getAuthority() :::::: " + grantedAuthority.getAuthority());
                                            request.getSession().setAttribute("authoritys", authoritys);
                                        }
                                        if (li.contains("ROLE_SUPERROOTADMIN") || li.contains("ROLE_ROOTADMIN") || li.contains("ROLE_SUPERADMIN")) {
                                            request.getSession().setAttribute("sessionSpecialPass", "Granted");
                                            selectLocation = true;
                                            List<Object[]> rListArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
                                            model.addAttribute("regionListArr", rListArr);
                                            logger.info("selectRegion---------------------TRUE");
                                        } else {
                                            request.getSession().setAttribute("sessionSpecialPass", "Denied");
                                        }
                                    }

                                } else {
                                    model.addAttribute("accessrightsnumber", 0);
                                    request.getSession().setAttribute("sessionSpecialPass", "Denied");
                                }
                            }else{
                                //No Units Assigned
                                model.addAttribute("accessrightsnumber", 0);
                                request.getSession().setAttribute("sessionSpecialPass", "Denied");
                            }
                        } else {
                            logger.info("Session Changed ::::");
                            Integer facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                            Integer facilityUnitid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());

                            List<Facilityunit> unitList = new ArrayList<>();
                            String[] paramsFu = {"facilityunitid"};
                            Object[] paramsValuesFu = {facilityUnitid};
                            String[] field2 = {"facilityunitname"};
                            String whereFu = "WHERE facilityunitid=:facilityunitid";
                            List<String> facilityUnitName = (List<String>) genericClassService.fetchRecord(Facilityunit.class, field2, whereFu, paramsFu, paramsValuesFu);
                            if (facilityUnitName != null) {
                                Facilityunit fu = new Facilityunit();
                                fu.setFacilityunitid(facilityUnitid.longValue());
                                fu.setFacilityunitname(facilityUnitName.get(0));
                                unitList.add(fu);
                            }
                            logger.info("Checked Units ::::");
                            model.addAttribute("unitList", unitList);
                            if (unitList.size() > 0) {
                                model.addAttribute("unitSize", unitList.size());
                                model.addAttribute("activeUnit", unitList.get(0).getFacilityunitname());
                                model.addAttribute("activeUnitId", unitList.get(0).getFacilityunitid());

                                long facilityunitid = unitList.get(0).getFacilityunitid();
                                request.getSession().setAttribute("sessionActiveLoginFacilityUnitObj", unitList.get(0));

                                String[] params3 = {"facilityid"};
                                Object[] paramValues3 = {facilityid};
                                String[] field3 = {"facilityname"};
                                String where3 = "WHERE facilityid=:facilityid";
                                List<String> facilityName = (List<String>) genericClassService.fetchRecord(Facility.class, field3, where3, params3, paramValues3);
                                Facility facObj = new Facility();
                                if (facilityName != null) {
                                    facObj.setFacilityid(facilityid);
                                    facObj.setFacilityname(facilityName.get(0));
                                }
                                request.getSession().setAttribute("sessionActiveLoginFacilityObj", facObj);
                                model.addAttribute("facilityObj", facObj);

                                String[] params2 = {"sId", "fuId", "status","isactive"};
                                Object[] paramsValues2 = {staffid, facilityunitid, Boolean.TRUE,Boolean.TRUE};
                                String[] prvFields = {"privilegekey"};
                                List<String> accessrights = (List<String>) genericClassService.fetchRecord(Staffassignedrights.class, prvFields, "WHERE staffid=:sId AND facilityunitid=:fuId AND isactive=:status AND stafffacilityunitaccessrightprivstatus=:isactive ", params2, paramsValues2);
                                logger.info("Fetching Rights Under Unit ::::" + facilityunitid + " @ " + unitList.get(0).getFacilityunitname());
                                if (accessrights != null) {
                                    logger.info("Got Rights ::::" + accessrights.size());
                                    List<GrantedAuthority> authoritys = createAuthoritys(accessrights);
                                    model.addAttribute("accessrightsnumber", accessrights.size());
                                    List<String> li = new ArrayList<>();
                                    if (authoritys != null) {
                                        //GrantedAuthority[] originalRoles = (GrantedAuthority[]) authoritys.toArray(new GrantedAuthority[0]);

                                        //Modify the Authentication object by adding the new roles and privileges.
                                        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(
                                                SecurityContextHolder.getContext().getAuthentication().getPrincipal(),
                                                SecurityContextHolder.getContext().getAuthentication().getCredentials(), authoritys));

                                        for (GrantedAuthority grantedAuthority : authoritys) {
                                            li.add(grantedAuthority.getAuthority());
                                            logger.info("grantedAuthority.getAuthority() :::::: " + grantedAuthority.getAuthority());
                                        }
                                        if (li.contains("ROLE_SUPERROOTADMIN") || li.contains("ROLE_ROOTADMIN") || li.contains("ROLE_SUPERADMIN")) {
                                            request.getSession().setAttribute("sessionSpecialPass", "Granted");
                                            selectLocation = true;
                                            List<Object[]> rListArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
                                            model.addAttribute("regionListArr", rListArr);
                                            logger.info("selectRegion---------------------TRUE");
                                        } else {
                                            request.getSession().setAttribute("sessionSpecialPass", "Denied");
                                        }
                                    }

                                } else {
                                    List<String> li = new ArrayList<String>();
                                    List<GrantedAuthority> authoritys = (List<GrantedAuthority>) request.getSession().getAttribute("authoritys");
                                    for (GrantedAuthority grantedAuthority : authoritys) {
                                        li.add(grantedAuthority.getAuthority());
                                    }
                                    if (!li.contains("ROLE_ROOTADMIN")) {
                                        model.addAttribute("accessrightsnumber", 0);
                                        request.getSession().setAttribute("sessionSpecialPass", "Denied");
                                    }
                                    
                                }
                            }
                        }
                    }else{
                        request.getSession().setAttribute("sessionSpecialPass", "Denied");
                    }
                    if (request.getSession().getAttribute("sessTimeOutLockScreen") != null) {
                        boolean state = (boolean) request.getSession().getAttribute("sessTimeOutLockScreen");
                        model.addAttribute("lockScreenState", state);
                    }
                    String SpecialPass = (String) request.getSession().getAttribute("sessionSpecialPass");
                    model.addAttribute("SpecialPass", SpecialPass);
                    if(SpecialPass.equals("Granted")){
                        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                        List<Facilityunit> unitList = new ArrayList<Facilityunit>();
                            String[] field2 = {"facilityunitid", "facilityunitname"};
                            List<Object[]> fuListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, field2, "WHERE r.facilityid=:facId AND r.active=:status ORDER BY r.facilityunitname ASC", new String[]{"facId", "status"}, new Object[]{facilityid, true});
                            if (fuListArr != null) {
                                for (Object[] obj : fuListArr) {
                                    Facilityunit fu = new Facilityunit();
                                    fu.setFacilityunitid((Long) obj[0]);
                                    fu.setFacilityunitname((String) obj[1]);
                                    unitList.add(fu);
                                }
                            }
                            model.addAttribute("unitList", unitList);
                    }
                    return new ModelAndView("dashboard", "model", model);
                }
                //Users Under The IICS Supplier Mode
                if (iicsPlatFormMode.equals("Supplier")) {
                    if (request.getSession().getAttribute("sessionActiveLoginSupplierStaffid") != null) {
                        long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginSupplierStaffid").toString());
                        int supplierid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginSupplier").toString());

                        logger.info("Picked Staff :::: " + staffid + " @ Supplier :::: " + supplierid);

                        String[] field3 = {"supplierid", "suppliername", "suppliercode"};
                        List<Object[]> supListArr = (List<Object[]>) genericClassService.fetchRecord(Supplier.class, field3, "WHERE r.supplierid=:facId", new String[]{"facId"}, new Object[]{supplierid});
                        Supplier supplierObj = new Supplier();
                        if (supListArr != null) {
                            for (Object[] obj : supListArr) {
                                supplierObj.setSupplierid((Long) obj[0]);
                                supplierObj.setSuppliername((String) obj[1]);
                                supplierObj.setSuppliercode((String) obj[2]);
                            }
                        }
                        request.getSession().setAttribute("sessionActiveLoginSupplierObj", supplierObj);
                        model.addAttribute("supplierObj", supplierObj);

                        String[] params2 = {"sId", "status"};
                        Object[] paramsValues2 = {staffid, Boolean.TRUE};
                        String[] prvFields = {"privilegekey"};
                        List<String> accessrights = (List<String>) genericClassService.fetchRecord(Privilege.class, prvFields, "WHERE r.privilegeid IN "
                                + "(SELECT asprv.supplierprivilege.privilege.privilegeid FROM Assignedprivilege asprv WHERE asprv.supplierstaff.staffid=:sId AND asprv.active=:status)"
                                + " AND r.active=:status", params2, paramsValues2);
                        logger.info("Fetching Rights Under Facility :::: " + supplierObj.getSuppliername());
                        if (accessrights != null) {
                            logger.info("Got Rights ::::" + accessrights.size());
                            List<GrantedAuthority> authoritys = createAuthoritys(accessrights);
                            model.addAttribute("accessrightsnumber", accessrights.size());
                            List<String> li = new ArrayList<String>();
                            if (authoritys != null) {
                                //Modify the Authentication object by adding the new roles and privileges.
                                SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(
                                        SecurityContextHolder.getContext().getAuthentication().getPrincipal(),
                                        SecurityContextHolder.getContext().getAuthentication().getCredentials(), authoritys));

                                for (GrantedAuthority grantedAuthority : authoritys) {
                                    li.add(grantedAuthority.getAuthority());
                                    logger.info("grantedAuthority.getAuthority() :::::: " + grantedAuthority.getAuthority());
                                }
                                if (li.contains("ROLE_ROOTADMIN") || li.contains("ROLE_SUPERADMIN")) {
                                    request.getSession().setAttribute("sessionSpecialPass", "Granted");
                                    selectLocation = true;
                                    List<Object[]> rListArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
                                    model.addAttribute("regionListArr", rListArr);
                                    logger.info("selectRegion---------------------TRUE");
                                } else {
                                    request.getSession().setAttribute("sessionSpecialPass", "Denied");
                                }
                            }
                        } else {
                            model.addAttribute("accessrightsnumber", 0);
                        }
                    }
                    if (request.getSession().getAttribute("sessTimeOutLockScreen") != null) {
                        boolean state = (boolean) request.getSession().getAttribute("sessTimeOutLockScreen");
                        model.addAttribute("lockScreenState", state);
                    }
                    return new ModelAndView("SupplierPlatform/dashboardSupplier", "model", model);
                }
            } else {
                List<Map> questionslist = new ArrayList<>();
                String[] paramsq = {};
                Object[] paramsValuesq = {};
                String[] fieldsq = {"questionsid", "question"};
                String whereq = "";
                List<Object[]> foundq = (List<Object[]>) genericClassService.fetchRecord(Questions.class, fieldsq, whereq, paramsq, paramsValuesq);
                Map<String, Object> questionsz;

                if (foundq != null) {
                    for (Object[] req : foundq) {
                        questionsz = new HashMap<>();
                        questionsz.put("Questionsid", (Integer) req[0]);
                        questionsz.put("question", (String) req[1]);
                        questionslist.add(questionsz);
                    }
                }
                model.addAttribute("questionslist", questionslist);
                model.addAttribute("systemuserid", systemuserid);
                return new ModelAndView("recoverySetup", "model", model);
            }
        }
        model.addAttribute("sessionChange", request.getSession().getAttribute("sessionChanged"));
        model.addAttribute("selectAttr", selectAttr);
        model.addAttribute("sysUser", systemuser);
        return new ModelAndView("frontPage", "model", model);
    }

    public List<GrantedAuthority> createAuthoritys(List<String> accessrights) {

        List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
        List<String> x = new ArrayList<String>();

        int i = 1;
        if (accessrights.size() > 0) {
            for (String accessright : accessrights) {
                if (accessright.length() > 0) {
                    if (x.size() < 1 && accessright.length() > 0) {
                        x.add(accessright);

                        list.add(new SimpleGrantedAuthority(accessright));
                    }
//                    logger.info("KEY: " + i + " " + accessright);
                    i += 1;
                    if (!x.contains(accessright) && accessright.length() > 0) {
                        list.add(new SimpleGrantedAuthority(accessright));
                        x.add(accessright);
                    }
                }
            }

            HashSet<GrantedAuthority> hashSetx = new HashSet<GrantedAuthority>(list);
            List<GrantedAuthority> grantedAuthoritys = new ArrayList<GrantedAuthority>(hashSetx);
            logger.info("¬¬¬¬¬¬¬¬¬¬¬" + grantedAuthoritys.size());
            return grantedAuthoritys;
        } else {
            return null;
        }
    }

    @RequestMapping(value = "/retrieveusers", method = RequestMethod.GET)
    public String retrieveusers(Model model, HttpServletRequest request) {
        List<Map> userList = new ArrayList<>();
        String[] params6 = {};
        Object[] paramsValues6 = {};
        String[] fields6 = {"username", "password"};
        String where6 = "";
        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields6, where6, params6, paramsValues6);
        Map<String, Object> users;

        if (found6 != null) {
            for (Object[] req : found6) {
                users = new HashMap<>();
                users.put("username", (String) req[0]);
                users.put("password", (String) req[1]);
                userList.add(users);
                model.addAttribute("userList", userList);
            }
        }
        return "frontpage";
    }

    private static final Logger LOG = Logger.getLogger(MainController.class.getName());

    @RequestMapping(value = "/unlock")
    public @ResponseBody
    String unlock(HttpServletRequest request, Principal principal, HttpServletResponse response) {
        String results = "";
        Object principalx = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principalx instanceof UserDetails) {
            this.username = ((UserDetails) principalx).getUsername();
        } else {
            this.username = principalx.toString();
        }
        String byt = "";
        byt = request.getParameter("b");
//        String un = "";
        Map<String, Object> model = new HashMap<String, Object>();
//        if(principal!=null){
//            un = principal.getName();
//        }
        System.out.println("loading index " + byt);
        boolean selectLocation = false;
        String selectAttr = "";

        Systemuser systemuser = new Systemuser();
        logger.info("Principals Not Null ::::");

        String[] params = {"username"};
        Object[] paramsValues = {username};
        String[] fields = {"systemuserid", "username", "active",
            "personid.personid", "personid.firstname", "personid.lastname", "personid.othernames", "personid.imagepath", "password"};
        List<Object[]> user_s = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields, " WHERE r.username=:username", params, paramsValues);
        System.out.println("*********" + user_s);
        if (user_s != null) {
            for (Object[] obj : user_s) {
                systemuser = new Systemuser((Long) obj[0]);
                model.put("username", username);
                model.put("password", (String) obj[8]);
                results = username + "," + (String) obj[8];
                System.out.println("--------------------------------------------------" + results);
            }
        }
        return results;
    }

    @RequestMapping(value = "/lockscreen", method = RequestMethod.GET)
    public String lockscreen(HttpServletRequest request, Principal principal, HttpServletResponse response, Model model) throws Exception {
        Object principalx = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principalx instanceof UserDetails) {
            this.username = ((UserDetails) principalx).getUsername();
        } else {
            this.username = principalx.toString();
        }
        System.out.println("~~~~~~~~~~~~~~~~~~~" + username);
        model.addAttribute("username", username);

        return "lockScreen";
    }

    @RequestMapping(value = "/homepageicon", method = RequestMethod.GET)
    public String controlPanelMenu(Model model) {
        return "homepageicon";
    }
    
    @RequestMapping(value = "/checkSessionState", method = RequestMethod.GET)
    public @ResponseBody
    String checkSessionState(HttpServletRequest request, Model model, Principal principal) {
        logger.info("------------Checking Session-------------!!");
        if (principal == null) {
            logger.info("User Session Expired!!");
            return "Expired";
        }else{
            logger.info("User Session Still Active!!");
            return "Active";
        }
    }
    
    @RequestMapping(value = "/logSessionTimeOut", method = RequestMethod.GET)
    public String logSessionTimeOut(HttpServletRequest request, Model model, @RequestParam("act") String activity, @RequestParam("c") String state) {
        if(activity.equals("a")){
            boolean setState = Boolean.parseBoolean(state);
            request.getSession().setAttribute("sessTimeOutLockScreen", setState);
        }
        return "";
    }
    @RequestMapping(value="/loginerror", method=RequestMethod.GET)
    public ModelAndView loginError(HttpServletRequest request, HttpSession session){
        Map<String, Object> model = new HashMap<>();
        Authentication a = SecurityContextHolder.getContext().getAuthentication(); 
        try {           
        } catch(Exception ex){
            System.out.println(ex);
        }
        return new ModelAndView("loginerror", model);
    }
}
