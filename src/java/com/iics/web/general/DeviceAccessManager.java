/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.general;

import com.iics.devicedomain.*;
import com.iics.domain.Facility;
import com.iics.domain.Facilitylevel;
import com.iics.domain.Person;
import com.iics.domain.Region;
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import com.iics.utils.general.LoggedInUserObj;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
/**
 *
 * @author samuelwam
 */

@Controller
public class DeviceAccessManager {
    
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    @Resource(name = "sessionRegistry")
    private SessionRegistryImpl sessionRegistry;
    
    public String getDevice(HttpServletRequest request) {
        Device device = DeviceUtils.getCurrentDevice(request);
        String msg = "";
        if (device.isMobile()) {
            logger.info("msg = ---------------------Hello mobile user!---------------------");
            return "mobile";
        } else if (device.isTablet()) {
            logger.info("msg = ---------------------Hello tablet user!---------------------");
            return "tablet";
        } else {
            logger.info("msg = ---------------------Hello desktop user!---------------------");
            return "normal";
        }
        //return ;
    }

    
    @RequestMapping(value = "/onlineUsers.htm", method = RequestMethod.GET)
    public final ModelAndView onlineUsers(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {

            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);
            //Get all logged-in user details: facility and user object
            
            if (activity.equals("a")) {
                logger.info("users ::::::: OLINE CHECK ::::::::::: SIZE:" + sessionRegistry.getAllPrincipals().size());

                List<LoggedInUserObj> inUserObjects = new ArrayList<LoggedInUserObj>();
                List<Region> regionList = new ArrayList<Region>();
                List<Object> users = (List<Object>) sessionRegistry.getAllPrincipals();
                
                for (Object object : users) {
                    User user = null;
                    if (object instanceof User) {
                        user = (User) object;
                        String username = user.getUsername();
                        if (sessionRegistry.getSessionInformation(username) != null) {
                            List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"facility.village.parishid.subcountyid.countyid.districtid.regionid.regionid", "facility.village.parishid.subcountyid.countyid.districtid.regionid.regionname", "accessdate"}, "WHERE LOWER(r.useraccount)=:uName AND r.logdate=current_date ORDER BY r.accessdate DESC LIMIT 1", new String[]{"uName"}, new Object[]{username.toLowerCase()});
                            logger.info("facListArr ------------------ "+facListArr);
                            if (facListArr != null) {
                                for (Object[] obj : facListArr) {
                                    LoggedInUserObj logObj = new LoggedInUserObj();
                                    Region r = new Region((Integer)obj[0]);
                                    r.setRegionname((String)obj[1]);
                                    logObj.setRegion(r);
                                    List<Object[]> userListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"useraccount"}, "WHERE r.facility.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:Id AND r.logdate=current_date", new String[]{"Id"}, new Object[]{(Integer)obj[0]});
                                    int usersOnline = 0;
                                    if (userListArr != null) {
                                        usersOnline=userListArr.size();
                                    }
                                    logObj.setCount(usersOnline);
                                    if(!regionList.contains(r)){
                                        logger.info("Add Region ------------------ "+(String)obj[1]);
                                        inUserObjects.add(logObj);
                                    }
                                    regionList.add(r);
                                }
                            }
                        }
                    }
                }
                if(inUserObjects!=null){
                    logger.info("inUserObjects ------------------ "+inUserObjects.size());
                    model.put("size", inUserObjects.size());
                }
                model.put("onlineUserRegion", inUserObjects);
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/OnlineUsers/onlineMain", "model", model);
            }
            if (activity.equals("b")) {
                logger.info("users ::::::: OLINE CHECK ::::::::::: SIZE:" + sessionRegistry.getAllPrincipals().size());
                model.put("d", id);
                Region regionObj = new Region();
                List<Object[]> regionObjArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "WHERE r.regionid=:Id", new String[]{"Id"}, new Object[]{id});
                if(regionObjArr!=null){
                    for (Object[] obj : regionObjArr) {
                        regionObj.setRegionname((String)obj[1]);
                    }
                }            
                model.put("regionObj", regionObj);
                
                List<LoggedInUserObj> inUserObjects = new ArrayList<LoggedInUserObj>();
                List<Facility> facilityList = new ArrayList<Facility>();
                List<Object> users = (List<Object>) sessionRegistry.getAllPrincipals();
                
                for (Object object : users) {
                    User user = null;
                    if (object instanceof User) {
                        user = (User) object;
                        String username = user.getUsername();
                        if (sessionRegistry.getSessionInformation(username) != null) {
                            List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"facility.facilityid", "facility.facilityname", "facility.facilitylevelid.facilitylevelname", "accessdate"}, "WHERE LOWER(r.useraccount)=:uName AND r.logdate=current_date AND r.facility.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:Id ORDER BY r.accessdate, r.facility.facilityname DESC LIMIT 1", new String[]{"uName","Id"}, new Object[]{username.toLowerCase(),id});
                            logger.info("facListArr ------------------ "+facListArr);
                            if (facListArr != null) {
                                for (Object[] obj : facListArr) {
                                    LoggedInUserObj logObj = new LoggedInUserObj();
                                    Facility f = new Facility((Integer)obj[0]);
                                    f.setFacilityname((String)obj[1]);
                                    Facilitylevel fl = new Facilitylevel();
                                    fl.setFacilitylevelname((String)obj[2]);
                                    f.setFacilitylevelid(fl);
                                    logObj.setFacility(f);
                                    List<Object[]> userListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"useraccount"}, "WHERE r.facility.facilityid=:Id AND r.logdate=current_date", new String[]{"Id"}, new Object[]{(Integer)obj[0]});
                                    int usersOnline = 0;
                                    if (userListArr != null) {
                                        usersOnline=userListArr.size();
                                    }
                                    logObj.setCount(usersOnline);
                                    if(!facilityList.contains(f)){
                                        logger.info("Add Facility ------------------ "+(String)obj[1]);
                                        inUserObjects.add(logObj);
                                    }
                                    facilityList.add(f);
                                }
                            }
                        }
                    }
                }
                if(inUserObjects!=null){
                    logger.info("inUserObjects ------------------ "+inUserObjects.size());
                    model.put("size", inUserObjects.size());
                }
                model.put("onlineUserRegion", inUserObjects);
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/OnlineUsers/onlineFacility", "model", model);
            }
            if (activity.equals("c")) {
                Facility usersFacilityObj = new Facility();
                List<Object[]> facObjArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid", "facilityname", "facilitylevelid.facilitylevelname"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{id});
                if (facObjArr != null) {
                    for (Object[] obj : facObjArr) {
                        usersFacilityObj = new Facility((Integer) obj[0]);
                        usersFacilityObj.setFacilityname((String) obj[1]);
                        Facilitylevel fl = new Facilitylevel();
                        fl.setFacilitylevelname((String) obj[2]);
                        usersFacilityObj.setFacilitylevelid(fl);
                    }
                }
                model.put("usersFacilityObj", usersFacilityObj);
                
                //Return All Online Users in Facility
                List<Object> users = (List<Object>) sessionRegistry.getAllPrincipals();
                logger.info("users ::::::: OLINE CHECK ::::::::::::: User:" + sessionRegistry.getAllPrincipals().size());

                List<LoggedInUserObj> inUserObjects = new ArrayList<>();
                for (Object object : users) {
                    User user = null;
                    String username = "";
                    //Make user the object from the sessionregistry is of type User so that u retrieve the username
                    if (object instanceof User) {

                        LoggedInUserObj inUserObject = new LoggedInUserObj();
                        user = (User) object;
                        username = user.getUsername();

                        if (sessionRegistry.getSessionInformation(username) != null) {
                            sessionRegistry.getSessionInformation(username).expireNow();
                            
                            List<Object[]> userLogListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"computerloghistoryid", "facility.facilityid", "facility.facilityname", "accessdate"}, "WHERE LOWER(r.useraccount)=:uName AND r.facility.facilityid=:fId ORDER BY r.accessdate DESC LIMIT 1", new String[]{"uName", "fId"}, new Object[]{username.toLowerCase(), id});
                            if (userLogListArr != null) {
                                //Get the systemuser object and person details of the logged-in user
                                Systemuser systemuser = new Systemuser();
                                String[] fields = {"systemuserid", "username", "active", "personid.personid", "personid.firstname", "personid.lastname"};
                                String[] params = {"uname"};
                                Object[] paramsValues = {user.getUsername()};
                                List<Object[]> userListArr = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields, "WHERE r.active=TRUE AND r.username=:uname", params, paramsValues);
                                if (userListArr != null) {
                                    logger.info("~~~~~~~~userListArr:: " + userListArr.size());
                                    for (Object[] obj : userListArr) {
                                        systemuser.setSystemuserid((Long) obj[0]);
                                        systemuser.setUsername(obj[1].toString());
                                        systemuser.setActive((Boolean) obj[2]);
                                        Person p = new Person();
                                        p.setPersonid((Long) obj[3]);
                                        p.setFirstname((String) obj[4]);
                                        p.setLastname((String) obj[5]);
                                        systemuser.setPersonid(p);
                                    }
                                }
                                inUserObject.setSystemuser(systemuser);
                                inUserObject.setUser(user);
                                inUserObjects.add(inUserObject);
                                
                                for (Object[] obj : userLogListArr) {
                                    Computerloghistory log = new Computerloghistory();
                                    log.setComputerloghistoryid((Long) obj[0]);
                                    inUserObject.setComputerloghistory(log);
                                    inUserObject.setAccessdate((Date) obj[3]);
                                    String duration = durationTimeDiff((Date) obj[3]);
                                    inUserObject.setDuration(duration);
                                }
                            }
                        }
                    }
                }
                model.put("onLineUsers", inUserObjects);
                if (inUserObjects != null && !inUserObjects.isEmpty()) {
                    logger.info("Found Users: " + inUserObjects.size());
                    model.put("size", inUserObjects.size());
                }
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/OnlineUsers/onlineUsers", "model", model);
            }
            if (activity.equals("d")) {
                //Remove Selected Online User on System
                Region regionObj = new Region();
                List<Object[]> regionObjArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "WHERE r.regionid=:Id", new String[]{"Id"}, new Object[]{id2});
                if(regionObjArr!=null){
                    for (Object[] obj : regionObjArr) {
                        regionObj.setRegionname((String)obj[1]);
                    }
                }            
                model.put("regionObj", regionObj);
                
                List<LoggedInUserObj> inUserObjects = new ArrayList<LoggedInUserObj>();
                List<Facility> facilityList = new ArrayList<Facility>();
                String expierUserName="";
                List<Object[]> userObjArr = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, new String[]{"systemuserid","username"}, "WHERE r.personid.personid=:Id", new String[]{"Id"}, new Object[]{id});
                if(userObjArr!=null){
                    for (Object[] obj : userObjArr) {
                        logger.info("Found User :::: "+(String)obj[1]+ " To Expire !!!");
                        expierUserName=(String)obj[1];
                    }
                }            
                for (Object principalObj : sessionRegistry.getAllPrincipals()) {
                    if (principalObj instanceof User) {
                        UserDetails userDetails = (UserDetails) principalObj;
                        if (userDetails.getUsername().equals(expierUserName)) {
                            for (SessionInformation information : sessionRegistry.getAllSessions(userDetails, true)) {
                                information.expireNow();
                                logger.info("Exired User :::: "+expierUserName+ "!!! Info: "+information);
                            }
                        }
                    }
                }
                
                List<Object> users = (List<Object>) sessionRegistry.getAllPrincipals();
                for (Object object : users) {
                    User user = null;
                    if (object instanceof User) {
                        user = (User) object;
                        String username = user.getUsername();
                        logger.info("Checking User :::: "+username+ " After Expire !!!");
                        if (sessionRegistry.getSessionInformation(username) != null) {
                            List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"facility.facilityid", "facility.facilityname", "facility.facilitylevelid.facilitylevelname", "accessdate"}, "WHERE LOWER(r.useraccount)=:uName AND r.logdate=current_date AND r.facility.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:Id ORDER BY r.accessdate, r.facility.facilityname DESC LIMIT 1", new String[]{"uName","Id"}, new Object[]{username.toLowerCase(),id});
                            logger.info("facListArr ------------------ "+facListArr);
                            if (facListArr != null) {
                                for (Object[] obj : facListArr) {
                                    LoggedInUserObj logObj = new LoggedInUserObj();
                                    Facility f = new Facility((Integer)obj[0]);
                                    f.setFacilityname((String)obj[1]);
                                    Facilitylevel fl = new Facilitylevel();
                                    fl.setFacilitylevelname((String)obj[2]);
                                    f.setFacilitylevelid(fl);
                                    logObj.setFacility(f);
                                    List<Object[]> userListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"useraccount"}, "WHERE r.facility.facilityid=:Id AND r.logdate=current_date", new String[]{"Id"}, new Object[]{(Integer)obj[0]});
                                    int usersOnline = 0;
                                    if (userListArr != null) {
                                        usersOnline=userListArr.size();
                                    }
                                    logObj.setCount(usersOnline);
                                    if(!facilityList.contains(f)){
                                        logger.info("Add Facility ------------------ "+(String)obj[1]);
                                        inUserObjects.add(logObj);
                                    }
                                    facilityList.add(f);
                                }
                            }
                        }
                    }
                }
                if(inUserObjects!=null){
                    logger.info("inUserObjects ------------------ "+inUserObjects.size());
                    model.put("size", inUserObjects.size());
                }
                model.put("onlineUserRegion", inUserObjects);
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/OnlineUsers/onlineFacility", "model", model);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/OnlineUsers/onlineUsers", "model", model);
    }

    public List<LoggedInUserObj> getLoggedUsersObjectList(List<Object> users) throws ClassCastException {
        try {
            List<LoggedInUserObj> inUserObjects = new ArrayList<LoggedInUserObj>();

            //For each object in session registry, get the user and his corresponsing facilityid
            
            for (Object object : users) {
                User user = null;
                String username = "";
                //Make user the object from the sessionregistry is of type User so that u retrieve the username
                if (object instanceof User) {
                    LoggedInUserObj inUserObject = new LoggedInUserObj();
                    user = (User) object;
                    username = user.getUsername();

                    //Get the systemuser object and person details of the logged-in user
                    Systemuser systemuser = new Systemuser();
                    String[] fields = {"systemuserid", "username", "active", "personid.personid", "personid.firstname", "personid.lastname"};
                    String[] params = {"uname"};
                    Object[] paramsValues = {user.getUsername()};
                    List<Object[]> userListArr = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fields, "WHERE r.active=TRUE AND r.username=:uname", params, paramsValues);
                    if (userListArr != null) {
                        logger.info("~~~~~~~~userListArr:: " + userListArr.size());
                        for (Object[] obj : userListArr) {
                            systemuser.setSystemuserid((Long) obj[0]);
                            systemuser.setUsername(obj[1].toString());
                            systemuser.setActive((Boolean) obj[2]);
                            Person p = new Person();
                            p.setPersonid((Long) obj[3]);
                            p.setFirstname((String) obj[4]);
                            p.setLastname((String) obj[5]);
                            systemuser.setPersonid(p);
                        }
                    }

                    inUserObject.setSystemuser(systemuser);
                    inUserObject.setUser(user);

                    //Check if the user had selected a location after logging in
                    if (sessionRegistry.getSessionInformation(username) != null) {
//                        logger.info("Here Here----" + sessionRegistry.getSessionInformation(username).getPrincipal().toString());
                        List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Computerloghistory.class, new String[]{"computerloghistoryid", "facility.facilityid", "facility.facilityname", "accessdate"}, "WHERE LOWER(r.useraccount)=:uName ORDER BY r.accessdate DESC LIMIT 1", new String[]{"uName"}, new Object[]{username.toLowerCase()});
                        Facility fac = new Facility();
                        if (facListArr != null) {
                            for (Object[] obj : facListArr) {
                                Computerloghistory log = new Computerloghistory();
                                log.setComputerloghistoryid((Long)obj[0]);
                                inUserObject.setComputerloghistory(log);
                                fac.setFacilityid((Integer) obj[1]);
                                fac.setFacilityname((String) obj[2]);
                                inUserObject.setAccessdate((Date) obj[3]);
                                String duration = durationTimeDiff((Date) obj[3]);
                                inUserObject.setDuration(duration);
                                
                            }
                        }
                        inUserObject.setFacility(fac);

                        logger.info("User: " + inUserObject.getSystemuser().getUsername() + " Fac ID: " + inUserObject.getFacility().getFacilityid()+" Log ::::::"+inUserObject.getComputerloghistory().getComputerloghistoryid()+" Date: "+inUserObject.getAccessdate());
                    }
                    inUserObjects.add(inUserObject);
                }
            }

            return inUserObjects;
        } catch (Exception ce) {
            ce.printStackTrace();
            return null;
        }
    }
    
    String durationTimeDiff(Date accessDate) {
        long timeDifferenceMilliseconds = new Date().getTime() - accessDate.getTime();
        long diffSeconds = timeDifferenceMilliseconds / 1000;
        long diffMinutes = timeDifferenceMilliseconds / (60 * 1000);
        long diffHours = timeDifferenceMilliseconds / (60 * 60 * 1000);
        long diffDays = timeDifferenceMilliseconds / (60 * 60 * 1000 * 24);
        long diffWeeks = timeDifferenceMilliseconds / (60 * 60 * 1000 * 24 * 7);
        long diffMonths = (long) (timeDifferenceMilliseconds / (60 * 60 * 1000 * 24 * 30.41666666));
        long diffYears = (long) (timeDifferenceMilliseconds / (1000 * 60 * 60 * 24 * 365));

        if (diffSeconds < 1) {
            return "one sec ago";
        } else if (diffMinutes < 1) {
            return diffSeconds + " seconds ago";
        } else if (diffHours < 1) {
            return diffMinutes + " minutes ago";
        } else if (diffDays < 1) {
            return diffHours + " hours ago";
        } else if (diffWeeks < 1) {
            return diffDays + " days ago";
        } else if (diffMonths < 1) {
            return diffWeeks + " weeks ago";
        } else if (diffYears < 12) {
            return diffMonths + " months ago";
        } else {
            return diffYears + " years ago";
        }
    }
}
