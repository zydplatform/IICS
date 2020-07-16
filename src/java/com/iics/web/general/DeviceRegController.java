/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web.general;

import com.iics.devicedomain.Registereddevice;
import com.iics.devicedomain.Devicemanufacturer;
import com.iics.devicedomain.Computerloghistory;
import com.iics.devicedomain.Deviceregistrationrequest;
import com.iics.devicedomain.*;
import com.iics.domain.Facility;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.utils.OsCheck;
import java.security.Principal;
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
import org.springframework.security.core.session.SessionRegistryImpl;
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
public class DeviceRegController {
    
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    @Resource(name = "sessionRegistry")
    private SessionRegistryImpl sessionRegistry;
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/deviceManuSetting.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView deviceManuSetting(Principal principal, HttpServletRequest request,
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

            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                
            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] fields = {"devicemanufacturerid", "manufacturer", "active", "released", "dateadded", "person.firstname", "person.lastname"};

            List<Devicemanufacturer> deviceList = new ArrayList<Devicemanufacturer>();
            List<Object[]> deviceListArr = new ArrayList<Object[]>();
            
            if (activity.equals("tab")) {
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/deviceRegTabs", "model", model);
            }
            if (activity.equals("a")) {
                String[] params = {};
                Object[] paramsValues = {};
                if (maxResults == 0) {
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, fields, "ORDER BY r.manufacturer ASC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Devicemanufacturer.class, "", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Devicemanufacturer.class, fields, "ORDER BY r.manufacturer ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, fields, "ORDER BY r.manufacturer ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("manuListArr", deviceListArr);
                if (deviceListArr != null) {
                    for (Object[] obj : deviceListArr) {
                        Devicemanufacturer device = new Devicemanufacturer((Long) obj[0]);
                        device.setManufacturer((String) obj[1]);
                        device.setActive((Boolean) obj[2]);
                        device.setReleased((Boolean) obj[3]);
                        device.setDateadded((Date)obj[4]);
                        Person p = new Person();
                        p.setFirstname((String)obj[5]);
                        p.setLastname((String)obj[6]);
                        device.setPerson(p);

                        deviceList.add(device);
                    }
                    model.put("size", deviceList.size());
                }
                model.put("deviceList", deviceList);
                model.put("facilityType", "Device Manufacturer");
//                logger.info("Return Main List :::::: deviceList :::: "+deviceList);
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/mainList", "model", model);
            }
            
            if (activity.equals("a2")) {
                List<Registereddevice> regdDeviceList = new ArrayList<Registereddevice>();
                boolean state=true;
                if(strVal.equals("b")){
                    state=false;
                }
                model.put("state", state);
                
                String[] regdDevFields = {"registereddeviceid", "macaddress", "physicalcondition", "active", "devicetype", "operatingsystem", "devicename", "serialnumber", "dateadded", "devicemanufacturer.devicemanufacturerid", "devicemanufacturer.manufacturer", "person.firstname", "person.lastname"};
                String[] params = {"facId","state"};
                Object[] paramsValues = {facilityid,state};
                if (maxResults == 0) {
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Registereddevice.class, regdDevFields, "WHERE r.facility.facilityid=:facId AND r.active=:state ORDER BY r.dateadded DESC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Registereddevice.class, "WHERE r.facility.facilityid=:facId AND r.active=:state", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Registereddevice.class, regdDevFields, "WHERE r.facility.facilityid=:facId AND r.active=:state ORDER BY r.dateadded ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Registereddevice.class, regdDevFields, "WHERE r.facility.facilityid=:facId AND r.active=:state ORDER BY r.dateadded ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("devListArr", deviceListArr);
                if (deviceListArr != null) {
                    for (Object[] obj : deviceListArr) {
                        //"registereddeviceid", "macaddress", "physicalcondition", "active", "devicetype", "operatingsystem", "devicename", "serialnumber", "dateadded",
                        //"devicemanufacturer.devicemanufacturerid", "devicemanufacturer.manufacturer", "person.firstname", "person.lastname"
                        Registereddevice device = new Registereddevice((Long) obj[0]);
                        String macAdd=(String) obj[1];
                        macAdd = macAdd.substring(macAdd.lastIndexOf(":") + 1);
                        device.setMacaddress(macAdd);
                        device.setPhysicalcondition((String) obj[2]);
                        device.setActive((Boolean) obj[3]);
                        device.setDevicetype((String) obj[4]);
                        device.setOperatingsystem((String) obj[5]);
                        device.setDevicename((String) obj[6]);
                        device.setSerialnumber((String) obj[7]);
                        device.setDateadded((Date)obj[8]);
                        Devicemanufacturer devM = new Devicemanufacturer((Long) obj[9]);
                        devM.setManufacturer((String) obj[10]);
                        device.setDevicemanufacturer(devM);
                        Person p = new Person();
                        p.setFirstname((String)obj[11]);
                        p.setLastname((String)obj[12]);
                        device.setPerson(p);
                        regdDeviceList.add(device);
                    }
                    model.put("size", regdDeviceList.size());
                }
                model.put("deviceList", regdDeviceList);
                model.put("facilityType", "Registered Device");

                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/registeredList", "model", model);
            }
            if (activity.equals("a3")) {
                List<Deviceregistrationrequest> unRegdDeviceList = new ArrayList<Deviceregistrationrequest>();
                
                String[] regdDevFields = {"requestid", "isregistered", "daterequested", "serialnumber", "person.firstname", "person.lastname", 
                    "computerlogid.computerloghistoryid", "computerlogid.computername", "computerlogid.device","computerlogid.ipaddress", "computerlogid.macaddress"};
                String[] params = {"facId"};
                Object[] paramsValues = {facilityid};
                if (maxResults == 0) {
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.facility.facilityid=:facId ORDER BY r.daterequested DESC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Deviceregistrationrequest.class, "WHERE r.facility.facilityid=:facId", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Deviceregistrationrequest.class, regdDevFields, "WHERE r.facility.facilityid=:facId ORDER BY r.daterequested ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.facility.facilityid=:facId ORDER BY r.daterequested ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("devListArr", deviceListArr);
                if (deviceListArr != null) {
                    for (Object[] obj : deviceListArr) {
                        Deviceregistrationrequest device = new Deviceregistrationrequest((Long) obj[0]);
                        device.setIsregistered((Boolean) obj[1]);
                        device.setDaterequested((Date) obj[2]);
                        device.setSerialnumber((String) obj[3]);
                        Person p = new Person();
                        p.setFirstname((String) obj[4]);
                        p.setLastname((String) obj[5]);
                        Computerloghistory clh = new Computerloghistory((Long) obj[6]);
                        clh.setComputername((String) obj[7]);
                        clh.setDevice((String) obj[8]);
                        clh.setIpaddress((String) obj[10]);
                        String macAdd=(String) obj[11];
                        macAdd = macAdd.substring(macAdd.lastIndexOf(":") + 1);
                        clh.setMacaddress(macAdd);
                        device.setComputerlogid(Long.parseLong(clh.toString()));
                        unRegdDeviceList.add(device);
                    }
                    model.put("size", unRegdDeviceList.size());
                }
                model.put("deviceList", unRegdDeviceList);
                model.put("facilityType", "Un Registered Device");

                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/unRegisteredList", "model", model);
            }
            if (activity.equals("a4")) {
                List<Deviceregistrationrequest> unRegdDeviceList = new ArrayList<Deviceregistrationrequest>();
                String[] regdDevFields = {"requestid", "isregistered", "daterequested", "serialnumber"};
                String[] params = {};
                Object[] paramsValues = {};
                if (maxResults == 0) {
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.requestid NOT IN (SELECT a.devicerequestid FROM Registereddevice a) ORDER BY r.daterequested DESC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Deviceregistrationrequest.class, "WHERE r.requestid NOT IN (SELECT a.devicerequestid FROM Registereddevice a)", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Deviceregistrationrequest.class, regdDevFields, "WHERE r.requestid NOT IN (SELECT a.devicerequestid FROM Registereddevice a) ORDER BY r.daterequested ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.requestid NOT IN (SELECT a.devicerequestid FROM Registereddevice a) ORDER BY r.daterequested ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("devListArr", deviceListArr);
                if (deviceListArr != null) {
                    for (Object[] obj : deviceListArr) {
                        Deviceregistrationrequest device = new Deviceregistrationrequest((Long) obj[0]);
                        device.setIsregistered((Boolean) obj[1]);
                        device.setDaterequested((Date) obj[2]);
                        device.setSerialnumber((String) obj[3]);
//                        Person p = new Person();
//                        p.setFirstname((String) obj[4]);
//                        p.setLastname((String) obj[5]);
//                        Computerloghistory clh = new Computerloghistory((Long) obj[6]);
//                        clh.setComputername((String) obj[7]);
//                        clh.setDevice((String) obj[8]);
//                        clh.setIpaddress((String) obj[10]);
//                        String macAdd=(String) obj[11];
//                        macAdd = macAdd.substring(macAdd.lastIndexOf(":") + 1);
//                        clh.setMacaddress(macAdd);
//                        device.setComputerlogid(Long.parseLong(clh.toString()));
                        unRegdDeviceList.add(device);
                    }
                    model.put("size", unRegdDeviceList.size());
                }
                model.put("deviceList", unRegdDeviceList);
                model.put("facilityType", "Un Registered Device");

                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/unRegisteredList", "model", model);
            }
            
            if (activity.equals("b") || activity.equals("c")) {
                if (activity.equals("c")) {
                    model.put("facilityType", "Device Manufacturer");
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, fields, "WHERE r.devicemanufacturerid=:Id", params, paramsValues);
                    if (deviceListArr != null) {
                        model.put("manuObjArr", deviceListArr.get(0));
                    }
                }
                
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/forms/formDeviceManu", "model", model);
            }
            if (activity.equals("c2")) {
                String[] regdDevFields = {"requestid", "isregistered", "daterequested", "serialnumber", "person.firstname", "person.lastname", "requestnote", 
                    "computerloghistory.computerloghistoryid", "computerloghistory.computername", "computerloghistory.device","computerloghistory.ipaddress", "computerloghistory.macaddress", "computerloghistory.operatingsystem", 
                    "devicemanufacturer.devicemanufacturerid", "devicemanufacturer.manufacturer", "physicalcondition", "operatingsystem"};
                
                    model.put("facilityType", "Device Registration");
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.requestid=:Id", params, paramsValues);
                    if (deviceListArr != null) {
                        Deviceregistrationrequest device = new Deviceregistrationrequest(id);
                        for (Object[] obj : deviceListArr) {
                            device.setIsregistered((Boolean) obj[1]);
                            device.setDaterequested((Date) obj[2]);
                            device.setSerialnumber((String) obj[3]);
                            Person p = new Person();
                            p.setFirstname((String) obj[4]);
                            p.setLastname((String) obj[5]);
                            device.setRequestnote((String)obj[6]);
                            Computerloghistory clh = new Computerloghistory((Long) obj[7]);
                            clh.setComputername((String) obj[8]);
                            clh.setDevice((String) obj[9]);
                            clh.setIpaddress((String) obj[11]);
                            String macAdd = (String) obj[12];
                            macAdd = macAdd.substring(macAdd.lastIndexOf(":") + 1);
                            clh.setMacaddress(macAdd);
                            clh.setOperatingsystem((String) obj[13]);
                            device.setComputerlogid(Long.parseLong(clh.toString()));
                            Devicemanufacturer manu = new Devicemanufacturer((Long) obj[14]);
                            manu.setManufacturer((String) obj[15]);
                            device.setPhysicalcondition((String) obj[16]);
                            device.setOperatingsystem((String) obj[17]);
                        }
                        model.put("devObj", device);
                    }                    
                
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/forms/formRegDevice", "model", model);
            }
            if (activity.equals("c3")) {
                String[] regdDevFields ={"registereddeviceid", "macaddress", "physicalcondition", "active", "devicetype", "operatingsystem", "devicename", "serialnumber", "dateadded", "devicemanufacturer.devicemanufacturerid", "devicemanufacturer.manufacturer", "person.firstname", "person.lastname"};
                
                    model.put("facilityType", "Registered Device");
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Registereddevice.class, regdDevFields, "WHERE r.registereddeviceid=:Id", params, paramsValues);
                    if (deviceListArr != null) {
                        Registereddevice device = new Registereddevice(id);
                        for (Object[] obj : deviceListArr) {
                            String macAdd=(String) obj[1];
                            macAdd = macAdd.substring(macAdd.lastIndexOf(":") + 1);
                            device.setMacaddress(macAdd);
                            device.setPhysicalcondition((String) obj[2]);
                            device.setActive((Boolean) obj[3]);
                            device.setDevicetype((String) obj[4]);
                            device.setOperatingsystem((String) obj[5]);
                            device.setDevicename((String) obj[6]);
                            device.setSerialnumber((String) obj[7]);
                            device.setDateadded((Date)obj[8]);
                            Devicemanufacturer devM = new Devicemanufacturer((Long) obj[9]);
                            devM.setManufacturer((String) obj[10]);
                            device.setDevicemanufacturer(devM);
                            Person p = new Person();
                            p.setFirstname((String)obj[11]);
                            p.setLastname((String)obj[12]);
                            device.setPerson(p);
                        }
                        model.put("devObj", device);
                    }
                
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/forms/formRegdDevice", "model", model);
            }
            if (activity.equals("d")) {
                //View All Details Impl
            }            
            if (activity.equals("e")) {
                model.put("serverid", id2);
                List<Devicemanufacturer> customList = new ArrayList<Devicemanufacturer>();
                
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> manuArrList = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, fields, "WHERE r.devicemanufacturerid=:Id", params, paramsValues);
                if (manuArrList != null) {
                    int success = 0;
                    genericClassService.deleteRecordByByColumns(Devicemanufacturer.class, new String[]{"devicemanufacturerid"}, new Object[]{id});
                    //Checking for successful deletion
                    int deleted = genericClassService.fetchRecordCount(Devicemanufacturer.class, "WHERE r.devicemanufacturerid=:Id", new String[]{"Id"}, new Object[]{id});
                    if (deleted==0) {
                        Devicemanufacturer manuObj = new Devicemanufacturer((Long) manuArrList.get(0)[0]);
                        manuObj.setManufacturer((String) manuArrList.get(0)[1]);
                        manuObj.setDescription("Deleted");
                        manuObj.setActive(true);
                        customList.add(manuObj);
                    } else {
                        Devicemanufacturer manuObj = new Devicemanufacturer((Long) manuArrList.get(0)[0]);
                        manuObj.setManufacturer((String) manuArrList.get(0)[1]);
                        manuObj.setActive(false);
                        manuObj.setDescription("<span class='text4'>Not Deleted</span>");
                        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Registereddevice.class, new String[]{"registereddeviceid"}, " WHERE r.devicemanufacturer.devicemanufacturerid=:mID", new String[]{"mID"}, new Object[]{id});
                        if (object != null) {
                            logger.info("Registered Devices Attached ::: " + object.size() + " For Id: " + id);
                            String str = "";
                            if (object.size() == 1) {
                                str = "1 Registered Device Attached";
                            } else {
                                str = object.size() + " Registered Devices Attached";
                            }
                            manuObj.setDescription(str);
                        } else {
                            manuObj.setDescription("Not Deleted, No Attachments!");
                        }
                        customList.add(manuObj);
                    }
                }

                model.put("deviceList", customList);
                if (customList != null) {
                    model.put("size", customList.size());
                }
                model.put("returnURL", "ajaxSubmitData('deviceManuSetting.htm', 'panel_overview', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');");
                //model.put("returnURL", request.getSession().getAttribute("sessReturnSearchedFacilityUrl").toString());
                model.put("mainActivity", "Device Manufacturer");
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/views/response", "model", model);
            }
            if (activity.equals("e2")) {
                List<Registereddevice> customList = new ArrayList<Registereddevice>();
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                
                String[] regdDevFields ={"registereddeviceid", "macaddress", "physicalcondition", "active", "devicetype", "operatingsystem", "devicename", "serialnumber"};
                List<Object[]> deviceArrList = (List<Object[]>) genericClassService.fetchRecord(Registereddevice.class, regdDevFields, "WHERE r.registereddeviceid=:Id", params, paramsValues);
                if (deviceArrList != null) {
                    int success = 0;
                    genericClassService.deleteRecordBySchemaByColumns(Registereddevice.class, new String[]{"registereddeviceid"}, new Object[]{id}, "accessdevice");
                    //Checking for successful deletion
                    int deleted = genericClassService.fetchRecordCount(Registereddevice.class, "WHERE r.registereddeviceid=:Id", new String[]{"Id"}, new Object[]{id});
                    if (deleted==0) {
                        model.put("resp", true);
                        model.put("respMessage", "Device Successfully Deleted From Access List");
                    } else {
                        model.put("resp", false);
                        model.put("respMessage", "<span class='text4'>Device Not Deleted From Access List</span>");
                    }
                }

                if (deviceArrList != null) {
                    model.put("deviceList", deviceArrList.get(0));
                }
                model.put("act", "a2");
                model.put("mainActivity", "Device Manufacturer");
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/forms/deleteResponse", "model", model);
            }
            if (activity.equals("e3")) {
                List<Deviceregistrationrequest> customList = new ArrayList<Deviceregistrationrequest>();
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                String[] regdDevFields = {"requestid", "isregistered", "daterequested", "serialnumber", "person.firstname", "person.lastname",
                    "computerloghistory.computerloghistoryid", "computerloghistory.computername", "computerloghistory.device","computerloghistory.ipaddress", "computerloghistory.macaddress"};
                
                List<Object[]> deviceArrList = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.requestid=:Id", params, paramsValues);
                if (deviceArrList != null) {
                    int success = 0;
                    genericClassService.deleteRecordBySchemaByColumns(Deviceregistrationrequest.class, new String[]{"requestid"}, new Object[]{id}, "accessdevice");
                    //Checking for successful deletion
                    int deleted = genericClassService.fetchRecordCount(Deviceregistrationrequest.class, "WHERE r.requestid=:Id", new String[]{"Id"}, new Object[]{id});
                    if (deleted==0) {
                        model.put("resp", true);
                        model.put("respMessage", "Device Successfully Deleted From Requests List");
                    } else {
                        model.put("resp", false);
                        model.put("respMessage", "<span class='text4'>Device Not Deleted From Requests List</span>");
                    }
                }

                if (deviceArrList != null) {
                    model.put("deviceList", deviceArrList.get(0));
                }
                model.put("act", "a4");
                model.put("mainActivity", "Device Manufacturer");
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/forms/deleteResponse", "model", model);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/regDeviceManufacturer.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView regDeviceManufacturer(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Update Device Manufacturer");
        Map<String, Object> model = new HashMap<String, Object>();
        List<Devicemanufacturer> customList = new ArrayList<Devicemanufacturer>();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long manuId = 0;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                manuId = Integer.parseInt(request.getParameter("cref"));
                updateActivity = true;
            }
            String manufacturer = request.getParameter("mname");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            
            logger.info("updateActivity ::: " + updateActivity);
            
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            
            String[] param2 = {"name"};
            Object[] paramsValue2 = {manufacturer.toLowerCase()};
            String[] field2 = {"devicemanufacturerid", "manufacturer", "active"};
            List<Object[]> existingRsrcList = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, field2, "WHERE lower(r.manufacturer)=:name", param2, paramsValue2);
            if (existingRsrcList != null) {
                boolean exist = false;
                List<Devicemanufacturer> existingList = new ArrayList<Devicemanufacturer>();
                for (Object[] obj : existingRsrcList) {
                    Devicemanufacturer mObj = new Devicemanufacturer((Long) obj[0]);
                        mObj.setManufacturer((String) obj[1]);
                        mObj.setDescription("Already Registered!");
                        mObj.setReleased(false);
                        
                    existingList.add(mObj);
                    exist = true;
                    if (manuId == (Long) obj[0]) {
                        exist = false;
                    }
                }
                model.put("resp", false);
                model.put("errorMessage", "Already Existing Manufacturer Name");
                model.put("deviceList", existingList);
                if (exist == true) {
                    model.put("mainActivity", "Device Manufacturer");
                    return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/views/response", "model", model);
                }
            }
            
            Devicemanufacturer mObj = new Devicemanufacturer();
                mObj.setManufacturer(manufacturer);
                mObj.setActive(status);
                
            if (updateActivity==false) {
                mObj.setDateadded(new Date());
                mObj.setPerson(new Person(pid));

                genericClassService.saveOrUpdateRecordLoadObject(mObj);
                
                List<Object[]> savedList = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, field2, "WHERE r.devicemanufacturerid=:Id", new String[]{"Id"}, new Object[]{mObj.getDevicemanufacturerid()});
                if (savedList != null) {
                    mObj.setDescription("Added!");
                    model.put("resp", true);
                    model.put("respMessage", "Successfully Added");
                }else{
                    mObj.setDescription("<span class='text4'>Not Added</span>");
                    model.put("resp", false);
                    model.put("respMessage", "FAILED!!");
                }
            }else {
                mObj.setDevicemanufacturerid(manuId);
                mObj.setDateupdated(new Date());
                mObj.setPerson1(new Person(pid));
                mObj.setDescription("Updated");
                
                genericClassService.updateRecordSQLSchemaStyle(Devicemanufacturer.class, new String[]{"manufacturer", "active", "updatedby", "dateupdated"},
                        new Object[]{manufacturer, status, pid, new Date()}, "devicemanufacturerid", manuId,"accessdevice");
                model.put("resp", true);
                model.put("successMessage", "Successfully Update Device Manufacturer");
            }
            customList.add(mObj);
            
            model.put("deviceList", customList);
            if (customList != null) {
                model.put("size", customList.size());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("activity", "update");
        model.put("mainActivity", "Device Manufacturer");
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/views/response", "model", model);
    }
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/deleteDeviceManufac.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView deleteDeviceManufac(HttpServletRequest request, Principal principal) {
        logger.info("Received request to delete Device manufacturer");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            model.put("act", request.getParameter("act"));
            model.put("a", request.getParameter("a"));
            model.put("b", request.getParameter("b"));
            model.put("c", request.getParameter("c"));
            model.put("d", request.getParameter("d"));
            model.put("i", request.getParameter("i"));
            
//            model.put("categoryid", Integer.parseInt(request.getParameter("i")));
            
            List<Long> ids = new ArrayList<Long>();
            List<Devicemanufacturer> customList = new ArrayList<Devicemanufacturer>();

            int count = Integer.parseInt(request.getParameter("itemSize"));
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj2" + i) != null) {
                        long id = Long.parseLong(request.getParameter("selectObj2" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Record Submitted");
                model.put("mainActivity", "Device Manufacturer");
                return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/views/response", "model", model);
            }
            for (Long id : ids) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                String[] fields = {"devicemanufacturerid", "manufacturer","active"};
                List<Object[]> manuArrList = (List<Object[]>) genericClassService.fetchRecord(Devicemanufacturer.class, fields, "WHERE r.devicemanufacturerid=:Id", params, paramsValues);
                if(manuArrList!=null){
                    int success = 0;
                    genericClassService.deleteRecordByByColumns(Devicemanufacturer.class, new String[]{"devicemanufacturerid"}, new Object[]{id});
                    //Checking for successful deletion
                    if (genericClassService.fetchRecord(Devicemanufacturer.class, fields, "WHERE r.devicemanufacturerid=:Id", params, paramsValues)==null) {
                        logger.info("Response :Deleted:: ");
                        Devicemanufacturer manuObj = new Devicemanufacturer((Long) manuArrList.get(0)[0]);
                        manuObj.setManufacturer((String) manuArrList.get(0)[1]);
                        manuObj.setDescription("Deleted");
                        manuObj.setActive(true);
                        customList.add(manuObj);
                    } else {
                        Devicemanufacturer manuObj = new Devicemanufacturer((Long) manuArrList.get(0)[0]);
                        manuObj.setManufacturer((String) manuArrList.get(0)[1]);
                        manuObj.setActive(false);                        
                        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Registereddevice.class, new String[]{"registereddeviceid"}, " WHERE r.devicemanufacturer.devicemanufacturerid=:mID", new String[]{"mID"}, new Object[]{id});
                        if (object != null) {
                            logger.info("Registered Devices Attached ::: " + object.size() + " For Id: " + id);
                            String str = "";
                            if (object.size() == 1) {
                                str = "1 Registered Device Attached";
                            } else {
                                str = object.size() + " Registered Devices Attached";
                            }
                            manuObj.setDescription(str);
                        } else {
                            manuObj.setDescription("N/A");
                        }
                        customList.add(manuObj);
                    }
                }
            }
            model.put("deviceList", customList);
            if (customList != null) {
                model.put("size", customList.size());
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("mainActivity", "Device Manufacturer");
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/Manufacturer/views/response", "model", model);
    }
    
    @RequestMapping("/requestDeviceReg.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView requestDeviceReg(Principal principal, HttpServletRequest request,
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
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("mainActivity", "Device Registration");
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/views/response", "model", model);
    }
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/requestDeviceReg.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView requestDeviceReg(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Log Device Reg Request");
        Map<String, Object> model = new HashMap<String, Object>();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }      
            long manuId = Integer.parseInt(request.getParameter("manufacturer"));
            String phyCondition = request.getParameter("cond");
            String osName = request.getParameter("osname");
            String note = request.getParameter("note");
            String serialnumber = request.getParameter("serial");
                        
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            Computerloghistory logHistory = (Computerloghistory) request.getSession().getAttribute("computerloghistory");
                        
            Deviceregistrationrequest regObj = new Deviceregistrationrequest();
            regObj.setComputerlogid(Long.parseLong(logHistory.toString()));
            regObj.setIsregistered(false);
            regObj.setDaterequested(new Date());
            regObj.setRequestnote(note);
            regObj.setSerialnumber(serialnumber);
//            if(OsCheck.getOperatingSystemType()!=null){
//                regObj.setOperatingsystem(""+OsCheck.getOperatingSystemType());
//            }else{
//                regObj.setOperatingsystem(osName);
//            }
            regObj.setOperatingsystem(osName);
            regObj.setPhysicalcondition(phyCondition);
            
            genericClassService.saveOrUpdateRecordLoadObject(regObj);
                
            List<Object[]> savedList = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, new String[]{"requestid"}, "WHERE r.requestid=:Id", new String[]{"Id"}, new Object[]{regObj.getRequestid()});
            if (savedList != null) {
                model.put("resp", true);
                model.put("respMessage", "Successfully Submited Device Registration Request");
            } else {
                model.put("resp", false);
                model.put("respMessage", "FAILED!! Device Registration Request Not Submited");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("activity", "update");
        model.put("mainActivity", "Device Registration");
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/responseLogRequest", "model", model);
    }
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/regPendingNetDevice.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView regPendingNetDevice(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Permit Device Reg Request");
        Map<String, Object> model = new HashMap<String, Object>();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long regReqId = Long.parseLong(request.getParameter("cref"));
            long manuId = Integer.parseInt(request.getParameter("manufacturer"));
            long comLogId = Long.parseLong(request.getParameter("logId"));
            String phyCondition = request.getParameter("cond");
            boolean approvalRequest = Boolean.parseBoolean(request.getParameter("status"));
            
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            
            Deviceregistrationrequest device = new Deviceregistrationrequest(regReqId);
            String[] regdDevFields = {"requestid", "isregistered", "daterequested", "serialnumber", "person.firstname", "person.lastname",
                "computerloghistory.computerloghistoryid", "computerloghistory.computername", "computerloghistory.device","computerloghistory.ipaddress", "computerloghistory.macaddress", "operatingsystem"};
            List<Object[]> deviceListArr = (List<Object[]>) genericClassService.fetchRecord(Deviceregistrationrequest.class, regdDevFields, "WHERE r.requestid=:Id", new String[]{"Id"}, new Object[]{regReqId});
            if (deviceListArr != null) {
                for (Object[] obj : deviceListArr) {
                    device.setIsregistered((Boolean) obj[1]);
                    device.setDaterequested((Date) obj[2]);
                    device.setSerialnumber((String) obj[3]);
                    Person p = new Person();
                    p.setFirstname((String) obj[4]);
                    p.setLastname((String) obj[5]);
                    Computerloghistory clh = new Computerloghistory((Long) obj[6]);
                    clh.setComputername((String) obj[7]);
                    clh.setDevice((String) obj[8]);

                    clh.setIpaddress((String) obj[10]);
                    String macAdd = (String) obj[11];
//                    macAdd = macAdd.substring(macAdd.lastIndexOf(":") + 1);
                    clh.setMacaddress(macAdd);
                    clh.setOperatingsystem((String) obj[12]);
                    device.setComputerlogid(Long.parseLong(clh.toString()));
                }
            }
            Registereddevice regObj = new Registereddevice();
            regObj.setActive(approvalRequest);
            regObj.setDateadded(new Date());
            regObj.setDevicename("");
            regObj.setDevicetype("");
            regObj.setPerson(new Person(pid));
            //regObj.setFacility(new Facility(facilityid));
            regObj.setMacaddress("");
            regObj.setPhysicalcondition(phyCondition);
            regObj.setSerialnumber("");
            regObj.setDateapproved(new Date());
            regObj.setPerson2(new Person(pid));
            regObj.setOperatingsystem("");
            regObj.setDevicerequestid(device.getRequestid());

            genericClassService.saveOrUpdateRecordLoadObject(regObj);

            List<Object[]> savedList = (List<Object[]>) genericClassService.fetchRecord(Registereddevice.class, new String[]{"registereddeviceid"}, "WHERE r.registereddeviceid=:Id", new String[]{"Id"}, new Object[]{regObj.getRegistereddeviceid()});
            if (savedList != null) {
                model.put("resp", true);
                model.put("respMessage", "Successfully Submited Request");
            } else {
                model.put("resp", false);
                model.put("respMessage", "FAILED!! Request Not Submited");
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("activity", "update");
        model.put("mainActivity", "Device Registration");
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/views/response", "model", model);
    }
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/manageRegdNetDevice.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView manageRegdNetDevice(HttpServletRequest request, Principal principal) {
        logger.info("Received Manage Registered Device State");
        Map<String, Object> model = new HashMap<String, Object>();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long regdReqId = Long.parseLong(request.getParameter("cref"));
            boolean accessRequest = Boolean.parseBoolean(request.getParameter("status"));
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            
            String stateReq="Grant";
            if(accessRequest==false){
                stateReq="Deny";
            }
             genericClassService.updateRecordSQLSchemaStyle(Registereddevice.class, new String[]{"active", "updatedby"},
                        new Object[]{accessRequest, pid}, "registereddeviceid", regdReqId,"accessdevice");
                
            List<Object> savedList = (List<Object>) genericClassService.fetchRecord(Registereddevice.class, new String[]{"active"}, "WHERE r.registereddeviceid=:Id", new String[]{"Id"}, new Object[]{regdReqId});
            if (savedList != null) {
                boolean state=(Boolean) savedList.get(0);
                if(state==accessRequest){
                    model.put("resp", true);
                    model.put("respMessage", "Request To "+stateReq+" Device Access Was Successfull");
                }else{
                    model.put("resp", false);
                    model.put("respMessage", "Failed To "+stateReq+" Device Access!");
                }
            } else {
                model.put("resp", false);
                model.put("respMessage", "Error Occurred!! Request Not Submited");
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("activity", "update");
        model.put("mainActivity", "Registered Device");
        return new ModelAndView("controlPanel/universalPanel/NetworkDevices/DeviceReg/views/response2", "model", model);
    }
    
    
}
