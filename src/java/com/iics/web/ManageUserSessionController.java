/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.controlpanel.Privilege;
import com.iics.domain.*;
import com.iics.domain.Location;
import com.iics.service.GenericClassService;
import java.security.Principal;
import java.text.BreakIterator;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
public class ManageUserSessionController {
    
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/changeUserLocation.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView changeUserLocation(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('changeUserLocation.htm', 'changeUnitSession', 'act=a&i=0&b=a&c=" + strVal2 + "&d=0', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);

            List<Object[]> foundObjs = new ArrayList<>();
            boolean selectLocation = false;
            String selectAttr = "";
            
            
            if (activity.equals("a")) {
                long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                logger.info("Picked Staff :::: " + staffid + " @ Facility :::: " + facilityid);

                List<Facilityunit> unitList = new ArrayList<Facilityunit>();
                String[] field2 = {"facilityunitid", "facilityunitname"};
                List<Object[]> fuListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, field2, "WHERE r.facilityid=:facId AND r.facilityunitid IN (SELECT sfu.facilityunitid FROM Stafffacilityunit sfu WHERE sfu.staffid=:sId AND sfu.active=:status AND sfu.facilityunitid IN (SELECT fu.facilityunitid FROM Facilityunit fu WHERE fu.facilityid=:facId)) ORDER BY r.facilityunitname ASC", new String[]{"facId", "sId", "status"}, new Object[]{facilityid, staffid, true});
                if (fuListArr != null) {
                    for (Object[] obj : fuListArr) {
                        Facilityunit fu = new Facilityunit();
                        fu.setFacilityunitid((Long) obj[0]);
                        fu.setFacilityunitname((String) obj[1]);
                        unitList.add(fu);
                    }
                }
                logger.info("Checked Units ::::");
                model.put("unitList", unitList);
                if (unitList != null && !unitList.isEmpty()) {
                    model.put("unitSize", unitList.size());
                    model.put("activeUnit", unitList.get(0).getFacilityunitname());
                    model.put("activeUnitId", unitList.get(0).getFacilityunitid());
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
                    model.put("facilityObj", facObj);

                    String[] params2 = {"sId", "fuId", "status"};
                    Object[] paramsValues2 = {staffid, facilityunitid, Boolean.TRUE};
                    String[] prvFields = {"privilegekey"};
                    List<String> accessrights = (List<String>) genericClassService.fetchRecord(Privilege.class, prvFields, "WHERE r.privilegeid IN "
                            + "(SELECT agr.privilegeid FROM Accessrightgroupprivilege agr WHERE agr.accessrightgroupprivilegeid IN "
                            + "(SELECT sfurp.accessrightgroupprivilegeid FROM Stafffacilityunitaccessrightprivilege sfurp WHERE sfurp.active=:status AND sfurp.stafffacilityunitid IN "
                            + "(SELECT sfu.stafffacilityunitid FROM Stafffacilityunit sfu WHERE sfu.staffid=:sId AND sfu.facilityunitid=:fuId)))"
                            + " AND r.active=:status", params2, paramsValues2);
                    logger.info("Fetching Rights Under Unit ::::" + facilityunitid + " @ " + unitList.get(0).getFacilityunitname());
                    if (accessrights != null) {
                        logger.info("Got Rights ::::" + accessrights.size());
                        List<GrantedAuthority> authoritys = createAuthoritys(accessrights);
//                        List<String> li = new ArrayList<String>();
                        if (authoritys != null) {
                            //GrantedAuthority[] originalRoles = (GrantedAuthority[]) authoritys.toArray(new GrantedAuthority[0]);

                            //Modify the Authentication object by adding the new roles and privileges.
                            SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(
                                    SecurityContextHolder.getContext().getAuthentication().getPrincipal(),
                                    SecurityContextHolder.getContext().getAuthentication().getCredentials(), authoritys));

//                            for (GrantedAuthority grantedAuthority : authoritys) {
//                                li.add(grantedAuthority.getAuthority());
//                            }
                            String sessionSpecialPass = "";
                            if(request.getSession().getAttribute("sessionSpecialPass")!=null){
                                sessionSpecialPass = request.getSession().getAttribute("sessionSpecialPass").toString();
                            }
                            if (sessionSpecialPass.equals("Granted")) {
                                selectLocation = true;
                                List<Object[]> rListArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
                                model.put("regionListArr", rListArr);
                                logger.info("selectRegion---------------------TRUE");
                            } 
                        }

                    }
                }

                return new ModelAndView("lockScreen", "model", model);
            }
            if (activity.equals("b")) {
                if (strVal.equals("a")) {
                    String sessionSpecialPass = "";
                    if (request.getSession().getAttribute("sessionSpecialPass") != null) {
                        sessionSpecialPass = request.getSession().getAttribute("sessionSpecialPass").toString();
                    }
                    if (sessionSpecialPass.equals("Granted")) {
                        List<Region> regionList = new ArrayList();
                        String[] fields = {"regionid", "regionname"};
                        String where = "";
                        String[] params = {};
                        Object[] paramsValues = {};
                        where = " ORDER BY r.regionname ASC";
                        foundObjs = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, where, params, paramsValues);
                        if (foundObjs != null) {
                            for (Object[] obj : foundObjs) {
                                Region r = new Region();
                                r.setRegionid((Integer) obj[0]);
                                r.setRegionname((String) obj[1]);
                                regionList.add(r);
                            }
                        }
                        model.put("mainActivity", "region");
                        model.put("regionList", regionList);
                    }
                    if (sessionSpecialPass.equals("Facility")) {
                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        List<Facility> facilityList = new ArrayList();
                        foundObjs = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid", "facilityname","shortname"}, "WHERE r.facilityid IN (SELECT s.facilityid FROM Staff s WHERE s.personid.personid=:pId AND s.staffstate=:status)", new String[]{"pId","status"}, new Object[]{pid,true});
                        if (foundObjs != null) {
                            for (Object[] obj : foundObjs) {
                                Facility f = new Facility();
                                f.setFacilityid((Integer) obj[0]);
                                f.setFacilityname((String) obj[1]);
                                f.setShortname((String) obj[2]);
                                facilityList.add(f);
                            }
                        }
                        model.put("mainActivity", "facility");
                        model.put("facilityList", facilityList);
                    }
                    
                }
                if (strVal.equals("b")) {
                    List<District> districtList = new ArrayList();
                    String[] fields = {"districtid", "districtname"};
                    String[] params = {"regionId"};
                    Object[] paramsValues = {id};
                    String where = "WHERE r.regionid.regionid=:regionId ORDER BY r.districtname ASC";
                    foundObjs = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, where, params, paramsValues);
                    if (foundObjs != null) {
                        for (Object[] obj : foundObjs) {
                            District d = new District();
                            d.setDistrictid((Integer) obj[0]);
                            d.setDistrictname((String) obj[1]);
                            districtList.add(d);
                        }
                    }
                    model.put("mainActivity", "district");
                    model.put("districtList", districtList);
                }
                if (strVal.equals("c")) {
                    //--------TEMPORARY :::UPDATE :::: LOAD ALL FOR ROOTADMIN AND ONLY ASSIGNED FACILITIES TO STAFF
                    Facilitydomain domainObj = (Facilitydomain) request.getSession().getAttribute("sessionActiveLoginDomain");
                    String[] fields = {"facilityid", "facilityname", "facilitycode", "facilitylevelid.facilitylevelname", "facilitylevelid.shortname"};
                    List<Facility> facilityList = new ArrayList<Facility>();
                    List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.village.parishid.subcountyid.countyid.districtid=:locId AND r.facilitylevelid.facilitydomain=:domainId ORDER BY r.facilityname ASC", new String[]{"locId","domainId"}, new Object[]{id,domainObj.getFacilitydomainid()});
                    if (facListArr != null) {
                        for (Object[] obj : facListArr) {
                            Facility fac = new Facility();
                            fac.setFacilityid((Integer) obj[0]);
                            fac.setFacilityname((String) obj[1]);
                            fac.setFacilitycode((String) obj[2]);
                            Facilitylevel fl = new Facilitylevel();
                            fl.setFacilitylevelname((String) obj[3]);
                            fac.setShortname((String) obj[4]);
                            fac.setFacilitylevelid(fl);
                            facilityList.add(fac);
                        }
                    }
                    model.put("mainActivity", "facility");
                    model.put("facilityList", facilityList);
                }
                if (strVal.equals("d")) {
                    model.put("mainActivity", "resetSession");
                    request.getSession().setAttribute("sessionActiveLoginFacility", id);
                    request.getSession().setAttribute("sessionChangedUserSession", true);
                    request.getSession().setAttribute("sessionSetActiveLoginFacilityUnitObj", null);
                }
                if (strVal.equals("e")) {
                    model.put("mainActivity", "endSession");
                    request.getSession().setAttribute("sessionChangedUserSession", null);
                    request.getSession().setAttribute("sessionSetActiveLoginFacilityUnitObj", null);
                }
                if (strVal.equals("f")) {
                    int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                    
                    String[] field2 = {"facilityunitid", "facilityunitname"};
                    Facilityunit fu = new Facilityunit(id);
                    List<Object[]> fuListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, field2, "WHERE r.facilityid=:facId AND r.facilityunitid=:Id", new String[]{"facId","Id"}, new Object[]{facilityid,id});
                    if (fuListArr != null) {
                        for (Object[] obj : fuListArr) {
                            fu.setFacilityunitname((String) obj[1]);
                        }
                    }else{
                        request.getSession().setAttribute("sessionSetActiveLoginFacilityUnitObj", null);
                    }
                    request.getSession().setAttribute("sessionActiveLoginFacilityUnit", Integer.valueOf(String.valueOf(id)));
                    request.getSession().setAttribute("sessionActiveLoginFacilityUnitObj", fu);
                    request.getSession().setAttribute("sessionChangedUserSession", true);
                    model.put("mainActivity", "setUnitSession");
                }
                return new ModelAndView("controlPanel/localSettingsPanel/ChangeSession/locationsLoader", "model", model);
            }
            
            } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
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
    
}
