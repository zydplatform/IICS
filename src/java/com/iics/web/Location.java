/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Audittraillocation;
import com.iics.domain.County;
import com.iics.domain.Trailcategory;
import java.text.BreakIterator;
import com.iics.domain.District;
import com.iics.domain.Facility;
import com.iics.domain.Locations;
import com.iics.domain.Nextofkin;
import com.iics.domain.Parish;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import java.security.Principal;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.iics.domain.Region;
//import com.iics.domain.Staff;
import com.iics.domain.Subcounty;
import com.iics.domain.Village;
import java.util.Date;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.io.IOException;
/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/locations")
public class Location {

    protected static Log logger = LogFactory.getLog("controller");

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/fetchDistricts", method = RequestMethod.POST)
    public @ResponseBody
    String fetchDistricts(HttpServletRequest request, Model model) {
        String jsondata = "";
        List<Map> locations = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"districtid", "districtname"};
        String where = "ORDER BY districtname";
        List<Object[]> locationDetails = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fields, where, params, paramsValues);
        if (locationDetails != null) {
            Map<String, Object> village;
            for (Object[] locationDetail : locationDetails) {
                village = new HashMap<>();
                village.put("id", (Integer) locationDetail[0]);
                village.put("name", (String) locationDetail[1]);
                locations.add(village);
            }
        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(locations);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsondata;
    }

    @RequestMapping(value = "/fetchDistrictVillages", method = RequestMethod.POST)
    public @ResponseBody
    String fetchDistrictVillages(HttpServletRequest request, Model model, @ModelAttribute("districtid") Integer district) {
        String jsondata = "";
        List<Map> locations = new ArrayList<>();
        String[] params = {"districtid"};
        Object[] paramsValues = {district};
//        String[] fields = {"villageid", "villagename", "subcountyname"};
        String[] fields = {"villageid", "villagename", "subcountyname", "parishname"};
        String where = "WHERE districtid=:districtid ORDER BY villagename";
        List<Object[]> locationDetails = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fields, where, params, paramsValues);
        if (locationDetails != null) {
            Map<String, Object> village;
            for (Object[] locationDetail : locationDetails) {
                village = new HashMap<>();
                village.put("id", (Integer) locationDetail[0]);
                village.put("village", (String) locationDetail[1]);
                village.put("subcounty", (String) locationDetail[2]);
                //
                village.put("parish", locationDetail[3]);
                //
                locations.add(village);
            }
        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(locations);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsondata;
    }

    @RequestMapping(value = "/manageLocations", method = RequestMethod.GET)
    public String init(Model model1) {
        // System.out.println(" karihe wa::");
        //Fetch Regions
        List<Region> regionList = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"regionid", "regionname"};
        String where = "";
        List<Object[]> region = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, where, params, paramsValues);
        Region regions;
        if (region != null) {
            for (Object[] reg : region) {
                regions = new Region();
                regions.setRegionid((Integer) reg[0]);
                regions.setRegionname((String) reg[1]);
                regionList.add(regions);
            } 
//             int Regions  = genericClassService.fetchRecordCount(Region.class, "", new String[]{}, new Object[]{});
//              model.put("totalRegions", Regions);
            model1.addAttribute("regionList", regionList);
        }
        return "controlPanel/universalPanel/location/view/listLocationTab";

    }

    @RequestMapping(value = "/updateregion", method = RequestMethod.POST)
    public @ResponseBody
    String updateregion(Model model, HttpServletRequest request) {
        String updateregionname = request.getParameter("updateregionname");
        //String updatedescription = request.getParameter("updatedescription");
        int regionid = Integer.parseInt(request.getParameter("regionid"));
        
        String[] columns = {"regionname"};
        Object[] columnValues = {updateregionname};
        String pk = "regionid";
        Object pkValue = regionid;

        String[] params = {"rID"};
        String[] fields = {"regionid", "regionname"};

        Object[] paramValues = {Long.parseLong(request.getParameter("regionid"))};
        List<Object[]> prevRegionObj = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, " WHERE r.regionid=:rID", params, paramValues);
       genericClassService.updateRecordSQLSchemaStyle(Region.class, columns, columnValues, pk, pkValue, "public");
        
        List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, " WHERE r.regionid=:rID", params, paramValues);
        if (checkObj != null) {
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            String sessAuditTrailCategory = "Location Management";
            String sessAuditTrailActivity = "Region";

            Audittraillocation al = new Audittraillocation();
            al.setCategory(sessAuditTrailCategory);
            al.setActivity(sessAuditTrailActivity);
            al.setDbaction("Update");
            al.setTimein(new Date());
            al.setPerson(new Person(pid));
            al.setAttrvalue((String) checkObj.get(0)[1]);
            al.setDescription("Updated Region");
            al.setCurlocationid((Integer) checkObj.get(0)[0]);
            al.setCurregion((String) checkObj.get(0)[1]);
//            al.setPrevlocationid((Integer) prevRegionObj.get(0)[0]);
            al.setPrevregion((String) prevRegionObj.get(0)[1]);
            al.setAdministered(false);
            al.setReflevel(0);
             logger.info("checkObj :::::xxx " + prevRegionObj.get(0)[1]);
            genericClassService.saveOrUpdateRecordLoadObject(al);
            
        }
        
        return "";
    }

    @RequestMapping(value = "/submitregion", method = RequestMethod.POST)
    public @ResponseBody
    String submitRegion(Model model, HttpServletRequest request) {
        Region region = new Region();
        String regionname = request.getParameter("regionname");
        //String description = request.getParameter("description");
        region.setRegionname(regionname);
        //Check Existing Facility Owner
        List<Object[]> existingRegion = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid"}, "WHERE LOWER(r.regionname)=:name", new String[]{"name"}, new Object[]{regionname.toLowerCase()});
        if (existingRegion != null) {
            return "Region " + regionname + " ALREADY EXISTS!";
        }
        genericClassService.saveOrUpdateRecordLoadObject(region);

        String[] params = {"rID"};
        String[] fields = {"regionid", "regionname"};

        Integer objectid = 0;
        objectid = region.getRegionid();
        Object[] paramValues = {objectid};
        List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, " WHERE r.regionid=:rID", params, paramValues);
        if (checkObj != null) {

            String sessAuditTrailCategory = "Location Management";
            String sessAuditTrailActivity = "Region";
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

            Audittraillocation al = new Audittraillocation();
            al.setCategory(sessAuditTrailCategory);
            al.setActivity(sessAuditTrailActivity);
            al.setDbaction("Add");
            al.setTimein(new Date());
            al.setPerson(new Person(pid));
            al.setAttrvalue((String) checkObj.get(0)[1]);
            al.setDescription("Added New Region");
            al.setCurlocationid((Integer) checkObj.get(0)[0]);
            al.setCurregion((String) checkObj.get(0)[1]);
            al.setAdministered(false);
            al.setReflevel(0);
            genericClassService.saveOrUpdateRecordLoadObject(al);
        }
        return "";
    }

    @RequestMapping(value = "/regions", method = RequestMethod.GET)
    public String viewregions(Model model) {
        //Fetch Facility Owners
        List<Region> regionList2 = new ArrayList<>();
        String[] paramsRegions2 = {};
        Object[] paramsValuesRegions2 = {};
        String[] fieldsRegions2 = {"regionid", "regionname"};
        String whereRegions2 = "";
        List<Object[]> region2 = (List<Object[]>) genericClassService.fetchRecord(Region.class, fieldsRegions2, whereRegions2, paramsRegions2, paramsValuesRegions2);
        Region reg2;
        if (region2 != null) {
            for (Object[] reg : region2) {
                reg2 = new Region();
                reg2.setRegionid((Integer) reg[0]);
                reg2.setRegionname((String) reg[1]);
                regionList2.add(reg2);
            }
            model.addAttribute("regionList", regionList2);
        }
        return "controlPanel/universalPanel/location/view/regionContent";
    }

    @RequestMapping(value = "/deleteRegion", method = RequestMethod.GET)
    public final ModelAndView deleteRegion(@RequestParam("act") String activity, @RequestParam("rID") int regionId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
       
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        try {
            String[] params = {"rID"};
            Object[] paramValues = {regionId};
            String[] fields = {"regionid", "regionname"};
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, " WHERE r.regionid=:rID", params, paramValues);
            if (checkObj != null) {
               model.put("checkObj", checkObj.get(0));  
            }

            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid"}, " WHERE r.regionid.regionid=:rID", new String[]{"rID"}, new Object[]{regionId});
            int success = object == null ? genericClassService.deleteRecordByByColumns(Region.class, new String[]{"regionid"}, new Object[]{regionId}) : 0;
            logger.info("successxxx ::::: " + success);
            if (success == 1) {
                model.put("deleted", true);
                model.put("successmessage", "Successfully Deleted Region: " + checkObj.get(0)[1]);
                
//                // Capture Trail Of Deleted Record
                long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                String sessAuditTrailCategory = "Location Management";
                String sessAuditTrailActivity = "Region";

                Audittraillocation al = new Audittraillocation();
                al.setCategory(sessAuditTrailCategory);
                al.setActivity(sessAuditTrailActivity);
                al.setDbaction("Delete");
                al.setTimein(new Date());
                al.setPerson(new Person(pid));
                al.setAttrvalue((String) checkObj.get(0)[1]);
                al.setDescription("Deleted Region");
                al.setPrevlocationid((Integer) checkObj.get(0)[0]);
                al.setPrevregion((String) checkObj.get(0)[1]);
                al.setAdministered(false);
                al.setReflevel(0);
                genericClassService.saveOrUpdateRecordLoadObject(al);
                
            }
            else {
                int count = genericClassService.fetchRecordCount(District.class, "WHERE r.regionid.regionid=:rID", new String[]{"rID"}, new Object[]{regionId});
                model.put("count", count);
                model.put("deleted", false);
                if (count > 0) {
                    //model.put("successmessage", "Failed to Delete Region: " + checkObj.get(0)[1] + " With <a href=\"#\"><strong>"+count+"</strong></a> Districts");
                    model.put("successmessage", "Failed to Delete Region: " + checkObj.get(0)[1] + " With <a href=\"#\" onClick=\"ajaxSubmitData('locations/manageLocationDiscard.htm', 'transfer-pane', 'act=a&i=" + regionId + "&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');\"><strong>" + count + "</strong></a> Districts");
                } else {
                    model.put("successmessage", "Failed to Delete Region: " + checkObj.get(0)[1] + ". Error Occured. Try Again!");
                }
            }
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardRegion", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardRegion", "model", model);
        }
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/manageLocationDiscard")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView manageLocationDiscard(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
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

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            List<Object[]> objListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                List<District> facList = new ArrayList<District>();

                String[] params = {"rID"};
                Object[] paramValues = {id};
                String[] regionFields = {"regionid", "regionname"};
                List<Object[]> regionArrList = (List<Object[]>) genericClassService.fetchRecord(Region.class, regionFields, " WHERE r.regionid!=:rID", params, paramValues);
                if (regionArrList != null) {
                    model.put("regionArrList", regionArrList);
                }
                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, "WHERE r.regionid.regionid=:Id ORDER BY r.districtname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("districts", districtArrList);
                if (districtArrList != null) {
                    model.put("size", districtArrList.size());
                }

                return new ModelAndView("controlPanel/universalPanel/location/forms/transferAttachment", "model", model);
            }
            if (activity.equals("c")) {
                List<Subcounty> facList = new ArrayList<Subcounty>();

                String[] params = {"cID"};
                Object[] paramValues = {id};
                String[] countyFields = {"countyid", "countyname"};
                List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, " WHERE r.countyid!=:cID", params, paramValues);
                if (countyArrList != null) {
                    model.put("countyArrList", countyArrList);
                }
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname"};
                List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, "WHERE r.countyid.countyid=:Id ORDER BY r.subcountyname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("subcounties", subcountyArrList);
                if (subcountyArrList != null) {
                    model.put("stransferCountyAttachmentize", subcountyArrList.size());
                }

                return new ModelAndView("controlPanel/universalPanel/location/forms/transferCountyAttachment", "model", model);
            }
            if (activity.equals("b")) {
                List<Parish> facList = new ArrayList<Parish>();

                String[] params = {"cID"};
                Object[] paramValues = {id};
                String[] countyFields = {"countyid", "countyname"};
                List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, " WHERE r.countyid!=:cID", params, paramValues);
                if (countyArrList != null) {
                    model.put("countyArrList", countyArrList);
                }
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname"};
                List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, "WHERE r.countyid.countyid=:Id ORDER BY r.subcountyname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("subcounties", subcountyArrList);
                if (subcountyArrList != null) {
                    model.put("size", subcountyArrList.size());
                }

                return new ModelAndView("controlPanel/universalPanel/location/forms/transferAttachment", "model", model);
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
    @RequestMapping(value = "/transferLocation.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferLocation(HttpServletRequest request, Principal principal) {
        logger.info("Received request totransfer location");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            List<Integer> ids = new ArrayList<Integer>();
            List<District> customList = new ArrayList<District>();
            int destinationId = Integer.parseInt(request.getParameter("regionid"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
            }
            int delete = 0;
            int transfer = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    genericClassService.updateRecordSQLStyle(District.class, new String[]{"regionid"}, new Object[]{destinationId}, "districtid", id);
                    int countTransfer = genericClassService.fetchRecordCount(District.class, "WHERE r.regionid.regionid=:Id AND r.districtid=:Id2", new String[]{"Id", "Id2"}, new Object[]{destinationId, id});
                    if (countTransfer > 0) {
                        transfer += 1;
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "District";
            }
            if (transfer > 0) {
                model.put("successmessage", transfer + " " + activeType + "(s) Successfully Transfered");
            } else {
                model.put("successmessage", "Transfer Was Not Successful!");
            }
            model.put("resp", true);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }
        model.put("activity", "update");
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
    }

    @RequestMapping(value = "/manageDistrict", method = RequestMethod.GET)
    public final ModelAndView manageDistrict(Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        System.out.println("ngwino ::::");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (request.getSession().getAttribute("regionObj") != null) {
                Region region = (Region) request.getSession().getAttribute("regionObj");
                model.put("region", region);
                String[] params = {"rID"};
                Object[] paramsValues = {region.getRegionid()};

                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> districts = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.regionid.regionid=:rID ORDER BY r.districtname ASC", params, paramsValues);

                model.put("districts", districts);
                model.put("size", districts.size());
            } else {
                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> districts = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " ORDER BY r.districtname ASC", null, null);

                int districtsInRegion = genericClassService.fetchRecordCount(District.class, "", new String[]{}, new Object[]{});
                model.put("totalDistricts", districtsInRegion);

                model.put("districts", districts);
                model.put("size", districts.size());
            }

            List<Region> regionsList = (List<Region>) genericClassService.fetchRecord(Region.class, new String[]{}, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regionsList);

            return new ModelAndView("controlPanel/universalPanel/location/view/districtContent", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/view/districtContent", "model", model);
        }
    }

    @RequestMapping(value = "/manageCounty", method = RequestMethod.GET)
    public final ModelAndView manageCounty(Principal principal, HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            int count = genericClassService.fetchRecordCount(County.class, "", new String[]{}, new Object[]{});
            model.put("count", count);

            if (request.getSession().getAttribute("districtObj") != null) {
                District district = (District) request.getSession().getAttribute("districtObj");
                model.put("district", district);
                String[] params = {"dID"};
                Object[] paramsValues = {district.getDistrictid()};
                String[] fields = {"countyid", "countyname", "district.districtname", "district.region.regionname"};
                List<Object[]> countys = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.district.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);
                model.put("countyList", countys);
            } else {
                String districtName = "";
                int countiesInDistrict = 0;
                List<Region> regList = new ArrayList<>();
                List<District> districtList = new ArrayList<>();

                List<Object[]> regionsList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", null, null);
                if (regionsList != null && !regionsList.isEmpty()) {
                    int regionid = (Integer) regionsList.get(0)[0];
                    model.put("regionid", regionid);
                    for (Object[] regObj : regionsList) {
                        Region reg = new Region();
                        reg.setRegionid((Integer) regObj[0]);
                        reg.setRegionname((String) regObj[1]);
                        regList.add(reg);
                    }
                    List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID ORDER BY r.districtname ASC", new String[]{"rID"}, new Object[]{regionid});
                    if (districtArrList != null && !districtArrList.isEmpty()) {
                        int districtid = (Integer) districtArrList.get(0)[0];
                        countiesInDistrict = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:dID", new String[]{"dID"}, new Object[]{districtid});
                        model.put("dCount", countiesInDistrict);
                        model.put("districtid", districtid);
                        for (Object[] distrObj : districtArrList) {
                            District d = new District();
                            d.setDistrictid((Integer) distrObj[0]);
                            d.setDistrictname((String) distrObj[1]);
                            districtList.add(d);
                            if (d.getDistrictid() == districtid) {
                                districtName = d.getDistrictname();
                                model.put("districtObj", d);
                            }
                        }
                        String[] params = {"dID"};
                        Object[] paramsValues = {districtid};
                        String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                        List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);
                        model.put("countyList", countysArrList);
                    }
                }
                int countiesIndistricts = genericClassService.fetchRecordCount(County.class, "", new String[]{}, new Object[]{});
                model.put("totalCounties", countiesIndistricts);
                model.put("regionsList", regList);
                model.put("districtList", districtList);
                model.put("title", districtName + " - Counties[" + countiesInDistrict + "]");
            }

            return new ModelAndView("controlPanel/universalPanel/location/view/countyContent", "model", model);
        } catch (Exception e) {
            e.printStackTrace();
            model.put("successmessage", "An error was encountered ,contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/view/countyContent", "model", model);
        }
    }

    @RequestMapping(value = "/manageSelectedLocation", method = RequestMethod.GET)
    public final ModelAndView manageSelectedLocation(Principal principal, @RequestParam("id") int id, @RequestParam("id2") int id2, HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            int count = genericClassService.fetchRecordCount(County.class, "", new String[]{}, new Object[]{});
            model.put("count", count);

            String districtName = "";
            int countiesInDistrict = 0;
            List<Region> regList = new ArrayList<>();
            List<District> districtList = new ArrayList<>();

            List<Object[]> regionsList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", null, null);
            if (regionsList != null && !regionsList.isEmpty()) {
                int regionid = id;
                model.put("regionid", regionid);
                for (Object[] regObj : regionsList) {
                    Region reg = new Region();
                    reg.setRegionid((Integer) regObj[0]);
                    reg.setRegionname((String) regObj[1]);
                    regList.add(reg);
                }
                List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID ORDER BY r.districtname ASC", new String[]{"rID"}, new Object[]{regionid});
                if (districtArrList != null && !districtArrList.isEmpty()) {
                    int districtid = id2;
                    countiesInDistrict = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:dID", new String[]{"dID"}, new Object[]{districtid});
                    model.put("dCount", countiesInDistrict);
                    model.put("districtid", districtid);
                    for (Object[] distrObj : districtArrList) {
                        District d = new District();
                        d.setDistrictid((Integer) distrObj[0]);
                        d.setDistrictname((String) distrObj[1]);
                        districtList.add(d);
                        if (d.getDistrictid() == districtid) {
                            districtName = d.getDistrictname();
                            model.put("districtObj", d);
                        }
                    }
                    String[] params = {"dID"};
                    Object[] paramsValues = {districtid};
                    String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                    List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);
                    model.put("countyList", countysArrList);
                }
            }
            model.put("regionsList", regList);
            model.put("districtList", districtList);
            model.put("title", districtName + " - Counties[" + countiesInDistrict + "]");

            return new ModelAndView("controlPanel/universalPanel/location/view/countyContent", "model", model);
        } catch (Exception e) {
            e.printStackTrace();
            model.put("successmessage", "An error was encountered ,contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/view/countyContent", "model", model);
        }
    }

    @RequestMapping("/addOrUpdateDistrict")
    @SuppressWarnings("CallToPrintStackTrace")
    public final ModelAndView addOrUpdateDistrict(HttpServletRequest request, @RequestParam("dID") int districtId, @RequestParam("act") String activity, Principal principal) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            District district = null;
            if (activity.equals("update")) {
                String[] params = {"dID"};
                Object[] paramValues = {districtId};
                String[] fields = {};
                district = (District) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues).get(0);
                model.put("district", district);
            }
            if (activity.equals("add2")) {
                activity = "add";
                String[] params = {"dID"};
                Object[] paramValues = {districtId};
                String[] fields = {};
                district = (District) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues).get(0);
                District d2 = new District();
                //d2.setRegion(district.getDistrictid());
                model.put("district", d2);
            }

            model.put("activity", activity);

            String[] fields = {};
            List<Region> regions = (List<Region>) genericClassService.fetchRecord(Region.class, fields, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regions);

            return new ModelAndView("controlPanel/universalPanel/location/forms/addDistrict", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/forms/addDistrict", "model", model);
        }
    }

    @RequestMapping(value = "/saveOrUpdateDistrict", method = RequestMethod.POST)
    public final ModelAndView saveOrUpdateDistrict(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        String activity = "update";
        //System.out.println("nibiki se ra::::::::::::::");
        try {
            String[] params = {"dID"};
            String[] fields = {"districtid", "districtname", "regionid.regionid", "regionid.regionname"};
            Integer objectid = 0;
            model.put("exists", true);
            model.put("deleted", false);

            if (!request.getParameter("districtid").equals("")) {
                objectid = Integer.parseInt(request.getParameter("districtid"));
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid"}, " WHERE "
                        + "lower(r.districtname)=:dName AND r.districtname=:dName2 AND r.regionid.regionid=:rID", new String[]{"dName", "dName2", "rID"}, new Object[]{request.getParameter("districtname").trim().toLowerCase(), request.getParameter("districtname").trim(), Integer.parseInt(request.getParameter("regionid"))});
                if (object != null) {
                    activity = "updateExists";
                    model.put("saved", false);
                    model.put("successmessage", "District: " + request.getParameter("districtname") + " Already Exists");
                } else {
                    Object[] paramValues = {Long.parseLong(request.getParameter("districtid"))};
                    List<Object[]> prevDistrictObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues);

                    genericClassService.updateRecordSQLStyle(District.class, new String[]{"districtname", "regionid"}, new Object[]{request.getParameter("districtname").trim(), Integer.parseInt(request.getParameter("regionid"))}, "districtid", Long.parseLong(request.getParameter("districtid")));

                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues);
                    if (checkObj != null) {

                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "District";
                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Update");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Updated District");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurdistrict((String) checkObj.get(0)[1]);
                        al.setCurregion((String) checkObj.get(0)[3]);
                        al.setPrevlocationid((Integer) prevDistrictObj.get(0)[0]);
                        al.setPrevdistrict((String) prevDistrictObj.get(0)[1]);
                        al.setPrevregion((String) prevDistrictObj.get(0)[3]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);

//                        model.put("checkObj", checkObj.get(0));
                    }
                    model.put("saved", true);
                    model.put("successmessage", "District: " + request.getParameter("districtname") + " Saved Successfully");
                }
            } else {
                activity = "add";
                District district = new District();
                district.setDistrictname(request.getParameter("districtname").trim());
                district.setRegionid(new Region(Integer.parseInt(request.getParameter("regionid"))));

                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid"}, " WHERE lower(r.districtname)=:dName", new String[]{"dName"}, new Object[]{request.getParameter("districtname").trim().toLowerCase()});
                if (object != null) {
                    activity = "addExists";
                    model.put("exists", false);
                    model.put("saved", false);
                    model.put("successmessage", "District: " + request.getParameter("districtname") + " Already Exists");
                } else {
                    model.put("exists", true);
                    genericClassService.saveOrUpdateRecordLoadObject(district);
                    objectid = district.getDistrictid();
                    model.put("saved", true);
                    model.put("successmessage", "District: " + request.getParameter("districtname") + " Saved Successfully");

                    Object[] paramValues = {objectid};
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues);
                    if (checkObj != null) {

                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "District";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Add");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Added New District");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurdistrict((String) checkObj.get(0)[1]);
                        al.setCurregion((String) checkObj.get(0)[3]);
                        al.setAdministered(false);
                        al.setReflevel(0);
                        genericClassService.saveOrUpdateRecordLoadObject(al);
//                        model.put("checkObj", checkObj.get(0));
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("exists", null);
            model.put("saved", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        model.put("activity", activity);

        return new ModelAndView("controlPanel/universalPanel/location/view/saveDistrict", "model", model);
    }

//    @RequestMapping(value = "/deleteDistrict", method = RequestMethod.GET)
//    public final ModelAndView deleteDistrict(@RequestParam("act") String activity, @RequestParam("id") int id, Principal principal, HttpServletRequest request) {
//        if (principal == null) {
//            return new ModelAndView("login");
//        }
//        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
//        Map<String, Object> model = new HashMap<String, Object>();
//        model.put("xxx", true);
//        model.put("activity", "delete");
//        Integer regionid = (Integer) genericClassService.fetchRecord(District.class, new String[]{"regionid.regionid"}, " WHERE r.districtid=:id", new String[]{"id"}, new Object[]{id}).get(0);
//        try {
//            System.out.println("God....+++++");
//            String[] params = {"id"};
//            Object[] paramValues = {id};
//            String[] fields = {"districtid", "districtname", "regionid.regionid", "regionid.regionname"};
//            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:id", params, paramValues);
//            if (checkObj != null) {
//                model.put("checkObj", checkObj.get(0));
//            }
//
//            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid"}, " WHERE r.districtid.districtid=:id", new String[]{"id"}, new Object[]{id});
//            int success = object == null ? genericClassService.deleteRecordById(District.class, "districtid", id) : 0;
//
//            if (success == 1) {
//                model.put("deleted", true);
//                model.put("successmessage", "Successfully Deleted District: " + checkObj.get(0)[1]);
//
//                // Capture Trail Of Deleted Record
//                String sessAuditTrailCategory = "Location Management";
//                String sessAuditTrailActivity = "District";
//
//                Audittraillocation al = new Audittraillocation();
//                al.setCategory(sessAuditTrailCategory);
//                al.setActivity(sessAuditTrailActivity);
//                al.setDbaction("Delete");
//                al.setTimein(new Date());
//                al.setPerson(new Person(pid));
//                al.setAttrvalue((String) checkObj.get(0)[1]);
//                al.setDescription("Deleted District");
//                al.setPrevlocationid((Integer) checkObj.get(0)[2]);//set prev region
//                al.setPrevdistrict((String) checkObj.get(0)[1]);
//                al.setPrevregion((String) checkObj.get(0)[3]);
//                al.setAdministered(false);
//                al.setReflevel(0);
//                genericClassService.saveOrUpdateRecordLoadObject(al);
//            } else {
//                int count = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:Id", new String[]{"Id"}, new Object[]{id});
//                model.put("count", count);
//                logger.info(" county oliwa..." + count);
//                model.put("deleted", false);
//                if (count > 0) {
//
//                    model.put("successmessage", "Failed to Delete District: " + checkObj.get(0)[1] + " With <a href=\"#\" onClick=\"ajaxSubmitData('locations/manageDistrictDiscard.htm', 'transfer-pane', 'act=a&i=" + id + "&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');\"><strong>" + count + "</strong></a> County");
//                } else {
//                    model.put("successmessage", "Failed to Delete District: " + checkObj.get(0)[1] + ". Error Occured. Try Again!");
//                }
//            }
//            return new ModelAndView("controlPanel/universalPanel/location/forms/discardDistrict", "model", model);
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            model.put("deleted", false);
//            model.put("successmessage", "An error occurred, contact admin");
//            return new ModelAndView("controlPanel/universalPanel/location/forms/discardDistrict", "model", model);
//        }
//
//    }

    @RequestMapping("/addOrUpdateCounty")
    @SuppressWarnings("CallToPrintStackTrace")
    public final ModelAndView addOrUpdateCounty(HttpServletRequest request, @RequestParam("cID") int countyId, @RequestParam("act") String activity, Principal principal) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            County county = null;
            if (activity.equals("update")) {
                String[] params = {"cID"};
                Object[] paramValues = {countyId};
                String[] fields = {};
                county = (County) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues).get(0);
                model.put("county", county);
            }
            if (activity.equals("add2")) {
                activity = "add";
                String[] params = {"cID"};
                Object[] paramValues = {countyId};
                String[] fields = {};
                county = (County) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues).get(0);
                County c2 = new County();
                c2.setDistrictid(county.getDistrictid());
                model.put("county", c2);
            }
            model.put("activity", activity);
            String[] fields = {};
            List<Region> regions = (List<Region>) genericClassService.fetchRecord(Region.class, fields, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regions);
            return new ModelAndView("controlPanel/universalPanel/location/forms/addCounty", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/forms/addCounty", "model", model);
        }
    }

    @RequestMapping(value = "/loadDistricts", method = RequestMethod.GET)
    public final ModelAndView loadDistricts(@RequestParam("loc") int location, @RequestParam("rID") Long regionid,
            Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        String[] params = {"rID"};
        Object[] paramsValues = {regionid};

        String[] fields = {"districtid", "districtname", "regionid.regionname"};
        List<Object[]> districts = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.regionid.regionid=:rID ORDER BY r.districtname ASC", params, paramsValues);
        //request.getSession().setAttribute("allData", false);
        model.put("districtList", districts);
        model.put("size", districts == null ? 0 : districts.size());
        System.out.println("Loc: " + location);
        if (location == 2) {
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'villageDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 3) {
            System.out.println("Loc:::::: " + location);
            model.put("link", "('loadCounties.htm', 'countyDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 4) {
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'countyDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 5) {
            System.out.println("Loc******* " + location);
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'countyDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 22) {
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'villageDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 33) {
            System.out.println("Loc:::::: " + location);
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'districtDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 44) {
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'countyDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 55) {
            System.out.println("Loc******* " + location);
            model.put("link", "ajaxSubmitData('loadCounties.htm', 'countyDivx', {dID: $(this).val(), loc: " + location + "}, 'GET');");
        }

        return new ModelAndView("controlPanel/universalPanel/location/loadDistricts", "model", model);
    }

    @RequestMapping(value = "/loadLocationVals", method = RequestMethod.GET)
    public final ModelAndView loadLocationVals(@RequestParam("act") int locationActivity, @RequestParam("locID") long locationid,
            Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        model.put("locationActivity", locationActivity);

        if (locationActivity == 1) {
            List<District> districtList = new ArrayList<>();
            List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID ORDER BY r.districtname ASC", new String[]{"rID"}, new Object[]{locationid});
            if (districtArrList != null && !districtArrList.isEmpty()) {
                for (Object[] distrObj : districtArrList) {
                    District d = new District();
                    d.setDistrictid((Integer) distrObj[0]);
                    d.setDistrictname((String) distrObj[1]);
                    districtList.add(d);
                }
            }
            model.put("districtList", districtList);
        }
        if (locationActivity == 2) {
            List<District> districtList = new ArrayList<>();
            List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID ORDER BY r.districtname ASC", new String[]{"rID"}, new Object[]{locationid});
            if (districtArrList != null && !districtArrList.isEmpty()) {
                for (Object[] distrObj : districtArrList) {
                    District d = new District();
                    d.setDistrictid((Integer) distrObj[0]);
                    d.setDistrictname((String) distrObj[1]);
                    districtList.add(d);
                }
            }
            model.put("districtList", districtList);
        }
        if (locationActivity == 3) {
            List<County> countyList = new ArrayList<>();
            List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{locationid});
            if (countyArrList != null && !countyArrList.isEmpty()) {
                for (Object[] countObj : countyArrList) {
                    County c = new County();
                    c.setCountyid((Integer) countObj[0]);
                    c.setCountyname((String) countObj[1]);
                    countyList.add(c);
                }
            }
            model.put("countyList", countyList);
        }
        return new ModelAndView("controlPanel/universalPanel/location/forms/loadSelectedLocations", "model", model);
    }

    @RequestMapping(value = "/loadCounties.htm", method = RequestMethod.GET)
    public final ModelAndView loadCounties(@RequestParam("loc") int location, @RequestParam("dID") Long districtid,
            Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        String[] params = {"dID"};
        Object[] paramsValues = {districtid};

        String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
        List<Object[]> countys = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);

        model.put("countyList", countys);
        model.put("size", countys == null ? 0 : countys.size());
        if (location == 2) {
            model.put("allData", false);
        }
        if (location == 3) {
            model.put("link", "ajaxSubmitData('loadSubCounties.htm', 'villageDivx', {cID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 4) {
            model.put("link", "ajaxSubmitData('loadSubCounties.htm', 'subcountyDivx', {cID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 5) {
            model.put("link", "ajaxSubmitData('loadSubCounties.htm', 'subcountyDivx', {cID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 22) {
            model.put("allData", false);
            model.put("link", "");
        }
        if (location == 33) {
            model.put("link", "ajaxSubmitData('loadSubCounties.htm', 'villageDivx', {cID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 44) {
            model.put("link", "ajaxSubmitData('loadSubCounties.htm', 'subcountyDivx', {cID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 55) {
            model.put("link", "ajaxSubmitData('loadSubCounties.htm', 'subcountyDivx', {cID: $(this).val(), loc: " + location + "}, 'GET');");
        }

        return new ModelAndView("controlPanel/universalPanel/location/loadCounties", "model", model);
    }

    @RequestMapping(value = "/saveOrUpdateCounty", method = RequestMethod.POST)
    public final ModelAndView saveOrUpdateCounty(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        String activity = "update";
        try {
            model.put("regionid", request.getParameter("regionid"));
            model.put("districtid", request.getParameter("districtid"));

            String[] params = {"cID"};
            String[] fields = {"countyid", "countyname", "districtid.districtid", "districtid.regionid.regionid",
                "districtid.districtname", "districtid.regionid.regionname"};

            Integer objectid = 0;
            model.put("exists", false);
            model.put("deleted", false);
            if (!request.getParameter("countyid").equals("")) {
                model.put("exists", true);
                objectid = Integer.parseInt(request.getParameter("countyid"));
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid"}, " WHERE "
                        + "lower(r.countyname)=:cName AND r.countyname=:cName2 AND r.districtid.districtid=:dID", new String[]{"cName", "cName2", "dID"}, new Object[]{request.getParameter("countyname").trim().toLowerCase(), request.getParameter("countyname").trim(), Integer.parseInt(request.getParameter("districtid").trim())});
                if (object != null) {
                    activity = "updateExists";
                    model.put("saved", false);
                    model.put("successmessage", "County: " + request.getParameter("countyname") + " Already Exists");
                } else {

                    Object[] paramValues = {Long.parseLong(request.getParameter("countyid"))};
                    List<Object[]> prevCountyObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues);

                    genericClassService.updateRecordSQLStyle(County.class, new String[]{"countyname", "districtid"}, new Object[]{request.getParameter("countyname").trim(), Integer.parseInt(request.getParameter("districtid"))}, "countyid", Long.parseLong(request.getParameter("countyid")));

                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues);
                    if (checkObj != null) {

                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "County";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Update");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Updated County");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurcounty((String) checkObj.get(0)[1]);
                        al.setCurdistrict((String) checkObj.get(0)[4]);
                        al.setCurregion((String) checkObj.get(0)[5]);
                        al.setPrevlocationid((Integer) prevCountyObj.get(0)[0]);
                        al.setPrevcounty((String) prevCountyObj.get(0)[1]);
                        al.setPrevdistrict((String) prevCountyObj.get(0)[4]);
                        al.setPrevregion((String) prevCountyObj.get(0)[5]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));

                    }

                    model.put("saved", true);
                    model.put("successmessage", "County: " + request.getParameter("countyname") + " Saved Successfully");
                }
            } else {
                activity = "add";
                County county = new County();
                county.setCountyname(request.getParameter("countyname").trim());
                county.setDistrictid(new District(Integer.parseInt(request.getParameter("districtid"))));

                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid"}, " WHERE lower(r.countyname)=:cName AND r.districtid.districtid=:dID", new String[]{"cName", "dID"}, new Object[]{request.getParameter("countyname").trim().toLowerCase(), Integer.parseInt(request.getParameter("districtid").trim())});
                if (object != null) {
                    activity = "addExists";
                    model.put("exists", false);
                    model.put("saved", false);
                    model.put("successmessage", "County: " + request.getParameter("countyname") + " Already Exists");
                } else {
                    model.put("exists", true);
                    genericClassService.saveOrUpdateRecordLoadObject(county);
                    objectid = county.getCountyid();
                    model.put("saved", true);
                    model.put("successmessage", "County: " + request.getParameter("countyname") + " Saved Successfully");

                    Object[] paramValues = {objectid};
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues);
                    if (checkObj != null) {

                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "County";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Add");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Added New County");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurcounty((String) checkObj.get(0)[1]);
                        al.setCurdistrict((String) checkObj.get(0)[4]);
                        al.setCurregion((String) checkObj.get(0)[5]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));
                    }

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("exists", null);
            model.put("saved", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        model.put("activity", activity);
        return new ModelAndView("controlPanel/universalPanel/location/view/saveCounty", "model", model);
    }

//    /**
//     *
//     * @param principal
//     * @return
//     */
//    @RequestMapping("/manageDistrictDiscard")
//    @SuppressWarnings("CallToThreadDumpStack")
//    public final ModelAndView manageDistrictDiscard(Principal principal, HttpServletRequest request,
//            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
//            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
//            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
//            @RequestParam("sStr") String searchPhrase) {
//        if (principal == null) {
//            return new ModelAndView("refresh");
//        }
//        Map<String, Object> model = new HashMap<String, Object>();
//        try {
//            model.put("act", activity);
//            model.put("b", strVal);
//            model.put("i", id);
//            model.put("c", strVal2);
//            model.put("d", id2);
//            model.put("ofst", offset);
//            model.put("maxR", maxResults);
//            model.put("sStr", searchPhrase);
//
//            request.getSession().setAttribute("sessPagingOffSet", offset);
//            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
//            request.getSession().setAttribute("vsearch", searchPhrase);
//
//            List<Object[]> objListArr = new ArrayList<Object[]>();
//
//            if (activity.equals("a")) {
//                List<County> facList = new ArrayList<County>();
//
//                String[] params = {"dID"};
//                Object[] paramValues = {id};
//                String[] districtFields = {"districtid", "districtname"};
//                List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, districtFields, " WHERE r.districtid!=:dID", params, paramValues);
//                if (districtArrList != null) {
//                    model.put("districtArrList", districtArrList);
//                }
//                String[] fields = {"countyid", "countyname", "districtid.districtname"};
//                List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, "WHERE r.districtid.districtid=:Id ORDER BY r.countyname ASC", new String[]{"Id"}, new Object[]{id});
//                model.put("counties", countyArrList);
//                if (countyArrList != null) {
//                    model.put("stransferDistrictAttachmentize", countyArrList.size());
//                }
//
//                return new ModelAndView("controlPanel/universalPanel/location/forms/transferDistrictAttachment", "model", model);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
//        return new ModelAndView("response", "model", model);
//    }
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/transferDistrict.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferDistrict(HttpServletRequest request, Principal principal) {
        logger.info("Received request to transfer district");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            List<Integer> ids = new ArrayList<Integer>();
            List<County> customList = new ArrayList<County>();
            int destinationId = Integer.parseInt(request.getParameter("districtid"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferDistrictResponse", "model", model);
            }
            int delete = 0;
            int transfer = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    genericClassService.updateRecordSQLStyle(County.class, new String[]{"districtid"}, new Object[]{destinationId}, "countyid", id);
                    int countTransfer = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:Id AND r.countyid=:Id2", new String[]{"Id", "Id2"}, new Object[]{destinationId, id});
                    if (countTransfer > 0) {
                        transfer += 1;
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "County";
            }
            if (transfer > 0) {
                model.put("successmessage", transfer + " " + activeType + "(s) Successfully Transfered");
            } else {
                model.put("successmessage", "Transfer Was Not Successful!");
            }
            model.put("resp", true);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }
        model.put("activity", "update");
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferDistrictResponse", "model", model);
    }

    @RequestMapping(value = "/quickSearchLocationByTerm", method = RequestMethod.POST)
    public @ResponseBody
    String quickSearchLocationByTerm(HttpServletRequest request, Model model, @ModelAttribute("sTerm") String searchTerm, @ModelAttribute("sVal") String searchValue) {

        logger.info("searchTerm ::::: " + searchTerm + " searchValue ::::: " + searchValue);
        List<Region> regionList = new ArrayList();
        List<District> districtList = new ArrayList();
        List<County> countyList = new ArrayList();
        List<Subcounty> subCountyList = new ArrayList();
        List<Parish> parishList = new ArrayList();
        List<Village> villageList = new ArrayList();

        List<Object[]> foundObjs = new ArrayList<>();

        if (searchTerm.equals("c")) {
            String[] fields = {"regionid", "regionname"};
            String where = "";
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.regionname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.regionname ASC";
            foundObjs = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, where, params, paramsValues);

            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Region r = new Region();
                    r.setRegionid((Integer) obj[0]);
                    r.setRegionname((String) obj[1]);
                    regionList.add(r);
                }
            }
            Location parser = new Location();
            return parser.regionToJSON(regionList);
        }
        if (searchTerm.equals("d")) {
            String[] fields = {"districtid", "districtname", "regionid.regionid", "regionid.regionname"};
            String where = "";
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.districtname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.districtname ASC";
            foundObjs = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, where, params, paramsValues);

            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    District d = new District();
                    d.setDistrictid((Integer) obj[0]);
                    d.setDistrictname((String) obj[1]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[2]);
                    r.setRegionname((String) obj[3]);
                    d.setRegionid(r);
                    districtList.add(d);
                }
            }
            Location parser = new Location();
            return parser.districtToJSON(districtList);
        }
        if (searchTerm.equals("e")) {
            String[] fields = {"countyid", "countyname", "districtid.districtid", "districtid.districtname", "districtid.regionid.regionid", "districtid.regionid.regionname"};
            String where = "";
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.countyname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.countyname ASC";
            foundObjs = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, where, params, paramsValues);

            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    County c = new County();
                    c.setCountyid((Integer) obj[0]);
                    c.setCountyname((String) obj[1]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[2]);
                    d.setDistrictname((String) obj[3]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[4]);
                    r.setRegionname((String) obj[5]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    countyList.add(c);
                }
            }
            Location parser = new Location();
            return parser.countyToJSON(countyList);
        }
        if (searchTerm.equals("m")) {
            String[] fields = {"subcountyid", "subcountyname", "countyid.countyid", "countyid.countyname", "countyid.districtid.districtid", "countyid.districtid.districtname", "countyid.districtid.regionid.regionid", "countyid.districtid.regionid.regionname"};
            String where = "";
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.subcountyname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.subcountyname ASC";
            foundObjs = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, where, params, paramsValues);

            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Subcounty sc = new Subcounty();
                    sc.setSubcountyid((Integer) obj[0]);
                    sc.setSubcountyname((String) obj[1]);
                    County c = new County();
                    c.setCountyid((Integer) obj[2]);
                    c.setCountyname((String) obj[3]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[4]);
                    d.setDistrictname((String) obj[5]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[6]);
                    r.setRegionname((String) obj[7]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    sc.setCountyid(c);
                    subCountyList.add(sc);
                }
            }
            Location parser = new Location();
            return parser.subcountyToJSON(subCountyList);
        }

        if (searchTerm.equals("g")) {
            String[] fields = {"parishid", "parishname", "subcountyid.subcountyid", "subcountyid.subcountyname", "subcountyid.countyid.countyid", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtid", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionid", "subcountyid.countyid.districtid.regionid.regionname"};
            String where = "";
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.parishname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.parishname ASC";
            foundObjs = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, where, params, paramsValues);

            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Parish p = new Parish();
                    p.setParishid((Integer) obj[0]);
                    p.setParishname((String) obj[1]);
                    Subcounty sc = new Subcounty();
                    sc.setSubcountyid((Integer) obj[2]);
                    sc.setSubcountyname((String) obj[3]);
                    County c = new County();
                    c.setCountyid((Integer) obj[4]);
                    c.setCountyname((String) obj[5]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[6]);
                    d.setDistrictname((String) obj[7]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[8]);
                    r.setRegionname((String) obj[9]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    sc.setCountyid(c);
                    p.setSubcountyid(sc);
                    parishList.add(p);
                }
            }
            Location parser = new Location();
            return parser.parishToJSON(parishList);
        }
        if (searchTerm.equals("n")) {
            String[] fields = {"villageid", "villagename", "parishid.parishid", "parishid.parishname", "parishid.subcountyid.subcountyid", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyid", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtid", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionid", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
            String where = "";
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.villagename) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.villagename ASC";
            foundObjs = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, where, params, paramsValues);

            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Village v = new Village();
                    v.setVillageid((Integer) obj[0]);
                    v.setVillagename((String) obj[1]);
                    Parish p = new Parish();
                    p.setParishid((Integer) obj[2]);
                    p.setParishname((String) obj[3]);
                    Subcounty sc = new Subcounty();
                    sc.setSubcountyid((Integer) obj[4]);
                    sc.setSubcountyname((String) obj[5]);
                    County c = new County();
                    c.setCountyid((Integer) obj[6]);
                    c.setCountyname((String) obj[7]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[8]);
                    d.setDistrictname((String) obj[9]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[10]);
                    r.setRegionname((String) obj[11]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    sc.setCountyid(c);
                    p.setSubcountyid(sc);
                    v.setParishid(p);
                    villageList.add(v);
                }
            }
            Location parser = new Location();
            return parser.villageToJSON(villageList);
        }

        Location parser = new Location();
        return parser.regionToJSON(regionList);
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/getSearchedLocation")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView getSearchedLocation(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
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

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            if (activity.equals("a")) {
                String districtName = "";
                int countiesInDistrict = 0;
                String[] params = {"dID"};
                Object[] paramsValues = {id};
                List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.districtid=:dID", params, paramsValues);
                if (districtArrObj != null) {
                    districtName = (String) districtArrObj.get(0)[1];
                }

                String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);
                if (countysArrList != null) {
                    countiesInDistrict = countysArrList.size();
                }
                model.put("countyList", countysArrList);
                model.put("title", districtName + " - Counties[" + countiesInDistrict + "]");
                return new ModelAndView("controlPanel/universalPanel/location/view/searchedCounty", "model", model);
            }

            if (activity.equals("e")) {
                String[] params = {"cID"};
                Object[] paramsValues = {id};
                String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", params, paramsValues);
                model.put("countyList", countysArrList);
                model.put("title", "Searched County");
                return new ModelAndView("controlPanel/universalPanel/location/view/searchedCounty", "model", model);
            }
            if (activity.equals("f")) {
                String subcountyName = "";
                int parishesInsubcount = 0;
                String[] params = {"scID"};
                Object[] paramsValues = {id};
                List<Object[]> subcountyArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.subcountyid=:scID", params, paramsValues);
                if (subcountyArrObj != null) {
                    subcountyName = (String) subcountyArrObj.get(0)[1];
                }
                String[] fields = {"parishid", "parishname", "subcounty.subcountyname", "subcounty.county.countyname", "subcounty.county.district.districtname", "subcounty.county.district.region.regionname"};
                List<Object[]> parishesArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", params, paramsValues);

                if (parishesArrList != null) {
                    parishesInsubcount = parishesArrList.size();
                }
                model.put("parishList", parishesArrList);
                model.put("title", subcountyName + " - Parishes[" + parishesInsubcount + "]");
                return new ModelAndView("controlPanel/universalPanel/location/view/searchedParishes", "model", model);
            }
            if (activity.equals("g")) {
                String subCountyName = "";
                int parishesInSubCounty = 0;
                String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname", "subcountyid.subcountyid",};
                List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", new String[]{"pID"}, new Object[]{id});
                if (parishArrList != null && !parishArrList.isEmpty()) {

                    int subcountyid = (Integer) parishArrList.get(0)[6];
                    List<Object[]> subCountysArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.subcountyid=:scID", new String[]{"scID"}, new Object[]{subcountyid});
                    Subcounty sc = new Subcounty();
                    if (subCountysArrObj != null && !subCountysArrObj.isEmpty()) {
                        for (Object[] obj : subCountysArrObj) {
                            sc = new Subcounty((Integer) obj[0]);
                            sc.setSubcountyname((String) obj[1]);
                        }
                        parishesInSubCounty = genericClassService.fetchRecordCount(Parish.class, "WHERE r.subcountyid.subcountyid=:Id", new String[]{"Id"}, new Object[]{subcountyid});
                    }
                    model.put("subCountyObj", sc);
                    model.put("title", subCountyName + " - Parishes[" + parishesInSubCounty + "]");
                    model.put("parishList", parishArrList);
                    model.put("size", parishesInSubCounty);
                }
                model.put("mainActivity", "Parish");
                model.put("b", "d");
                model.put("act", "b");

                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
            }
            if (activity.equals("n")) {
                String parishName = "";
                int villagesInParish = 0;
                String[] fields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname", "parishid.parishid",};
                List<Object[]> villageArrList = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID ORDER BY r.villagename ASC", new String[]{"vID"}, new Object[]{id});
                if (villageArrList != null && !villageArrList.isEmpty()) {

                    int parishid = (Integer) villageArrList.get(0)[7];
                    List<Object[]> parishArrObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, " WHERE r.parishid=:pID", new String[]{"pID"}, new Object[]{parishid});
                    Parish p = new Parish();
                    if (parishArrObj != null && !parishArrObj.isEmpty()) {
                        for (Object[] obj : parishArrObj) {
                            p = new Parish((Integer) obj[0]);
                            p.setParishname((String) obj[1]);
                        }
                        villagesInParish = genericClassService.fetchRecordCount(Village.class, "WHERE r.parishid.parishid=:Id", new String[]{"Id"}, new Object[]{parishid});
                    }
                    model.put("parishObj", p);
                    model.put("title", parishName + " - Villages[" + villagesInParish + "]");
                    model.put("villageList", villageArrList);
                    model.put("size", villagesInParish);
                }
                model.put("mainActivity", "Village");
                model.put("b", "e");
                model.put("act", "b");

                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
            }
            if (activity.equals("m")) {
                String countyName = "";
                int subcountiesInCounty = 0;
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname", "countyid.countyid",};
                List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", new String[]{"scID"}, new Object[]{id});
                if (subcountyArrList != null && !subcountyArrList.isEmpty()) {

                    int countyid = (Integer) subcountyArrList.get(0)[5];
                    List<Object[]> countysArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.countyid=:cID", new String[]{"cID"}, new Object[]{countyid});
                    County c = new County();
                    if (countysArrObj != null && !countysArrObj.isEmpty()) {
                        for (Object[] obj : countysArrObj) {
                            c = new County((Integer) obj[0]);
                            c.setCountyname((String) obj[1]);
                        }
                        subcountiesInCounty = genericClassService.fetchRecordCount(Subcounty.class, "WHERE  r.countyid.countyid=:Id", new String[]{"Id"}, new Object[]{countyid});
                    }
                    model.put("CountyObj", c);
                    model.put("title", countyName + " - Subcounties[" + subcountiesInCounty + "]");
                    model.put("subCountyList", subcountyArrList);
                    model.put("size", subcountiesInCounty);
                }
                model.put("mainActivity", "Subcounty");
                model.put("b", "c");
                model.put("act", "b");

                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
            }

            if (activity.equals("h")) {
                String countyName = "";
                int subcountiesInCounty = 0;
                String[] params = {"cID"};
                Object[] paramsValues = {id};
                List<Object[]> countyArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.countyid=:cID", params, paramsValues);
                if (countyArrObj != null) {
                    countyName = (String) countyArrObj.get(0)[1];
                }
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                List<Object[]> subcountysArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", params, paramsValues);

                if (subcountysArrList != null) {
                    subcountiesInCounty = subcountysArrList.size();
                }
                model.put("subcountyList", subcountysArrList);
                model.put("title", countyName + " - Sub Counties[" + subcountiesInCounty + "]");
                return new ModelAndView("controlPanel/universalPanel/location/view/searchedSubCounty", "model", model);
            }
            if (activity.equals("e1")) {
                String[] params = {"sID"};
                Object[] paramsValues = {id};
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                List<Object[]> subcountysArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:sID ORDER BY r.subcountyname ASC", params, paramsValues);
                model.put("subcountyList", subcountysArrList);
                model.put("title", "Searched Sub  County");
                return new ModelAndView("controlPanel/universalPanel/location/view/searchedSubCounty", "model", model);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

    public String regionToJSON(List<Region> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getRegionid() + "\",\"name\":\"" + list.get(x).getRegionname() + "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getRegionid() + "\",\"name\":\"" + list.get(size - 1).getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: Region:" + response);
        return response;
    }

    public String districtToJSON(List<District> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getDistrictid() + "\",\"name\":\"" + list.get(x).getDistrictname() + "\",\"region\":\"" + list.get(x).getRegionid().getRegionname() + "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getDistrictid() + "\",\"name\":\"" + list.get(size - 1).getDistrictname() + "\",\"region\":\"" + list.get(size - 1).getRegionid().getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: District:" + response);
        return response;
    }

    public String countyToJSON(List<County> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getCountyid() + "\",\"name\":\"" + list.get(x).getCountyname() + "\",\"district\":\"" + list.get(x).getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(x).getDistrictid().getRegionid().getRegionname() + "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getCountyid() + "\",\"name\":\"" + list.get(size - 1).getCountyname() + "\",\"district\":\"" + list.get(size - 1).getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(size - 1).getDistrictid().getRegionid().getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: County:" + response);
        return response;
    }

    public String subcountyToJSON(List<Subcounty> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getSubcountyid() + "\",\"name\":\"" + list.get(x).getSubcountyname() + "\",\"county\":\"" + list.get(x).getCountyid().getCountyname() + "\",\"district\":\"" + list.get(x).getCountyid().getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(x).getCountyid().getDistrictid().getRegionid().getRegionname() + "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getSubcountyid() + "\",\"name\":\"" + list.get(size - 1).getSubcountyname() + "\",\"county\":\"" + list.get(size - 1).getCountyid().getCountyname() + "\",\"district\":\"" + list.get(size - 1).getCountyid().getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(size - 1).getCountyid().getDistrictid().getRegionid().getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: Sub-County:" + response);
        return response;
    }

    public String parishToJSON(List<Parish> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getParishid() + "\",\"name\":\"" + list.get(x).getParishname() + "\",\"subcounty\":\"" + list.get(x).getSubcountyid().getSubcountyname() + "\",\"county\":\"" + list.get(x).getSubcountyid().getCountyid().getCountyname() + "\",\"district\":\"" + list.get(x).getSubcountyid().getCountyid().getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(x).getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname() + "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getParishid() + "\",\"name\":\"" + list.get(size - 1).getParishname() + "\",\"subcounty\":\"" + list.get(size - 1).getSubcountyid().getSubcountyname() + "\",\"county\":\"" + list.get(size - 1).getSubcountyid().getCountyid().getCountyname() + "\",\"district\":\"" + list.get(size - 1).getSubcountyid().getCountyid().getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(size - 1).getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: Parish:" + response);
        return response;
    }

    public String villageToJSON(List<Village> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getVillageid() + "\",\"name\":\"" + list.get(x).getVillagename() + "\",\"parish\":\"" + list.get(x).getParishid().getParishname() + "\",\"subcounty\":\"" + list.get(x).getParishid().getSubcountyid().getSubcountyname() + "\",\"county\":\"" + list.get(x).getParishid().getSubcountyid().getCountyid().getCountyname() + "\",\"district\":\"" + list.get(x).getParishid().getSubcountyid().getCountyid().getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(x).getParishid().getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname() + "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getVillageid() + "\",\"name\":\"" + list.get(size - 1).getVillagename() + "\",\"parish\":\"" + list.get(size - 1).getParishid().getParishname() + "\",\"subcounty\":\"" + list.get(size - 1).getParishid().getSubcountyid().getSubcountyname() + "\",\"county\":\"" + list.get(size - 1).getParishid().getSubcountyid().getCountyid().getCountyname() + "\",\"district\":\"" + list.get(size - 1).getParishid().getSubcountyid().getCountyid().getDistrictid().getDistrictname() + "\",\"region\":\"" + list.get(size - 1).getParishid().getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: Village:" + response);
        return response;
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/manageCountyDiscard")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView manageCountyDiscard(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
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

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            List<Object[]> objListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                List<Subcounty> facList = new ArrayList<Subcounty>();

                String[] params = {"cID"};
                Object[] paramValues = {id};
                String[] countyFields = {"countyid", "countyname"};
                List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, " WHERE r.countyid!=:cID", params, paramValues);
                if (countyArrList != null) {
                    model.put("countyArrList", countyArrList);
                }
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname"};
                List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, "WHERE r.countyid.countyid=:Id ORDER BY r.subcountyname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("subcounties", subcountyArrList);
                if (subcountyArrList != null) {
                    model.put("stransferCountyAttachmentize", subcountyArrList.size());
                }

                return new ModelAndView("controlPanel/universalPanel/location/forms/transferCountyAttachment", "model", model);
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
    @RequestMapping(value = "/transferCounty.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferCounty(HttpServletRequest request, Principal principal) {
        logger.info("Received request to transfer County");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            List<Integer> ids = new ArrayList<Integer>();
            List<Subcounty> customList = new ArrayList<Subcounty>();
            int destinationId = Integer.parseInt(request.getParameter("countyid"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferCountyResponse", "model", model);
            }
            int delete = 0;
            int transfer = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    genericClassService.updateRecordSQLStyle(Subcounty.class, new String[]{"countyid"}, new Object[]{destinationId}, "subcountyid", id);
                    int countTransfer = genericClassService.fetchRecordCount(Subcounty.class, "WHERE r.countyid.countyid=:Id AND r.subcountyid=:Id2", new String[]{"Id", "Id2"}, new Object[]{destinationId, id});
                    if (countTransfer > 0) {
                        transfer += 1;
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "SubCounty";
            }
            if (transfer > 0) {
                model.put("successmessage", transfer + " " + activeType + "(s) Successfully Transfered");
            } else {
                model.put("successmessage", "Transfer Was Not Successful!");
            }
            model.put("resp", true);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }
        model.put("activity", "update");
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferCountyResponse", "model", model);
    }

    @RequestMapping(value = "/deleteCounty", method = RequestMethod.GET)
    public final ModelAndView deleteCounty(@RequestParam("act") String activity, @RequestParam("cID") int countyId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }

        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        //Integer districtid = (Integer) genericClassService.fetchRecord(County.class, new String[]{"districtid.districtid"}, " WHERE r.countyid=:id", new String[]{"id"}, new Object[]{countyId}).get(0);
        Integer districtid = (Integer) genericClassService.fetchRecord(County.class, new String[]{"districtid.districtid"}, " WHERE r.countyid=:cID", new String[]{"cID"}, new Object[]{countyId}).get(0);
        try {
            System.out.println("God....+++++");
            String[] params = {"cID"};
            Object[] paramValues = {countyId};
            String[] fields = {"countyid", "countyname", "districtid.districtid", "districtid.districtname", "districtid.regionid.regionid", "districtid.regionid.regionname"};
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues);
            if (checkObj != null) {
                model.put("checkObj", checkObj.get(0));
            }

            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid"}, " WHERE r.countyid.countyid=:cID", new String[]{"cID"}, new Object[]{countyId});
            int success = object == null ? genericClassService.deleteRecordById(County.class, "countyid", countyId) : 0;

            if (success == 1) {
                model.put("deleted", true);
                model.put("successmessage", "Successfully Deleted County: " + checkObj.get(0)[1]);

                // Capture Trail Of Deleted Record
                String sessAuditTrailCategory = "Location Management";
                String sessAuditTrailActivity = "County";

                Audittraillocation al = new Audittraillocation();
                al.setCategory(sessAuditTrailCategory);
                al.setActivity(sessAuditTrailActivity);
                al.setDbaction("Delete");
                al.setTimein(new Date());
                al.setPerson(new Person(pid));
                al.setAttrvalue((String) checkObj.get(0)[1]);
                al.setDescription("Deleted County");
                al.setPrevlocationid((Integer) checkObj.get(0)[2]);//set previ district
                al.setPrevcounty((String) checkObj.get(0)[1]);
                al.setPrevdistrict((String) checkObj.get(0)[3]);
                al.setPrevregion((String) checkObj.get(0)[5]);
                al.setAdministered(false);
                al.setReflevel(0);
                genericClassService.saveOrUpdateRecordLoadObject(al);

            } else {
                int count = genericClassService.fetchRecordCount(Subcounty.class, "WHERE r.countyid.countyid=:cID", new String[]{"cID"}, new Object[]{countyId});
                model.put("count", count);
                logger.info(" check Mik..." + count);
                model.put("deleted", false);
                if (count > 0) {

                    model.put("successmessage", "Failed to Delete County: " + checkObj.get(0)[1] + " With <a href=\"#\" onClick=\"ajaxSubmitData('locations/manageCountyDiscardx.htm', 'transfer-pane', 'act=a&i=" + countyId + "&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');\"><strong>" + count + "</strong></a> Sub-County");
                } else {
                    model.put("successmessage", "Failed to Delete County: " + checkObj.get(0)[1] + ". Error Occured. Try Again!");
                }
            }
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardCounty", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardCounty", "model", model);
        }

    }

    @RequestMapping(value = "/deleteDistrictx", method = RequestMethod.GET)
    public final ModelAndView deleteDistrictx(@RequestParam("act") String activity, @RequestParam("dID") int districtId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        try {
            String[] params = {"dID"};
            Object[] paramValues = {districtId};
            String[] fields = {"districtid", "districtname", "regionid.regionid", "regionid.regionname"};
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues);
            if (checkObj != null) {
                model.put("checkObj", checkObj.get(0));
            }
            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid"}, " WHERE r.districtid.districtid=:dID", new String[]{"dID"}, new Object[]{districtId});
            int success = object == null ? genericClassService.deleteRecordByByColumns(District.class, new String[]{"districtid"}, new Object[]{districtId}) : 0;
            logger.info("success ::::: " + success);
            if (success == 1) {
                model.put("deleted", true);
                model.put("successmessage", "Successfully Deleted District: " + checkObj.get(0)[1]);
                // Capture Trail Of Deleted Record
                String sessAuditTrailCategory = "Location Management";
                String sessAuditTrailActivity = "District";
                Audittraillocation al = new Audittraillocation();
                al.setCategory(sessAuditTrailCategory);
                al.setActivity(sessAuditTrailActivity);
                al.setDbaction("Delete");
                al.setTimein(new Date());
                al.setPerson(new Person(pid));
                al.setAttrvalue((String) checkObj.get(0)[1]);
                al.setDescription("Deleted District");
                al.setPrevlocationid((Integer) checkObj.get(0)[2]);//set Region
                al.setPrevdistrict((String) checkObj.get(0)[1]);
                al.setPrevregion((String) checkObj.get(0)[3]);
                al.setAdministered(false);
                al.setReflevel(0);
                genericClassService.saveOrUpdateRecordLoadObject(al);
            } else {
                int count = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:dID", new String[]{"dID"}, new Object[]{districtId});
                model.put("count", count);
                model.put("deleted", false);
                if (count > 0) {
                    //model.put("successmessage", "Failed to Delete Region: " + checkObj.get(0)[1] + " With <a href=\"#\"><strong>"+count+"</strong></a> Districts");
                    model.put("successmessage", "Failed to Delete District: " + checkObj.get(0)[1] + " With <a href=\"#\" onClick=\"ajaxSubmitData('locations/manageDistrictDiscardx.htm', 'transfer-pane', 'act=a&i=" + districtId + "&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');\"><strong>" + count + "</strong></a> County");
                } else {
                    model.put("successmessage", "Failed to Delete District: " + checkObj.get(0)[1] + ". Error Occured. Try Again!");
                }
            }
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardDistrict", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardDistrict", "model", model);
        }
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/manageDistrictDiscardx")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView manageDistrictDiscardx(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
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

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            List<Object[]> objListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                List<County> facList = new ArrayList<County>();

                String[] params = {"dID"};
                Object[] paramValues = {id};
                String[] districtFields = {"districtid", "districtname"};
                List<Object[]> districtArrList = (List<Object[]>) genericClassService.fetchRecord(District.class, districtFields, " WHERE r.districtid!=:dID", params, paramValues);
                if (districtArrList != null) {
                    model.put("districtArrList", districtArrList);
                }
                String[] fields = {"countyid", "countyname", "districtid.districtname"};
                List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, "WHERE r.districtid.districtid=:Id ORDER BY r.countyname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("counties", countyArrList);
                if (countyArrList != null) {
                    model.put("size", countyArrList.size());
                }

                return new ModelAndView("controlPanel/universalPanel/location/forms/transferDistrictAttachment", "model", model);
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
    @RequestMapping(value = "/transferDistrictLocation.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferDistrictLocation(HttpServletRequest request, Principal principal) {
        logger.info("Received request totransfer location");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            List<Integer> ids = new ArrayList<Integer>();
            List<District> customList = new ArrayList<District>();
            int destinationId = Integer.parseInt(request.getParameter("regionid"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
            }
            int delete = 0;
            int transfer = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    genericClassService.updateRecordSQLStyle(District.class, new String[]{"regionid"}, new Object[]{destinationId}, "districtid", id);
                    int countTransfer = genericClassService.fetchRecordCount(District.class, "WHERE r.regionid.regionid=:Id AND r.districtid=:Id2", new String[]{"Id", "Id2"}, new Object[]{destinationId, id});
                    if (countTransfer > 0) {
                        transfer += 1;
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "District";
            }
            if (transfer > 0) {
                model.put("successmessage", transfer + " " + activeType + "(s) Successfully Transfered");
            } else {
                model.put("successmessage", "Transfer Was Not Successful!");
            }
            model.put("resp", true);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }
        model.put("activity", "update");
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
    }

    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/transferDistrictLocationx.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferDistrictLocationx(HttpServletRequest request, Principal principal) {
        logger.info("Received request to transfer location");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            List<Integer> ids = new ArrayList<Integer>();
            List<County> customList = new ArrayList<County>();
            int destinationId = Integer.parseInt(request.getParameter("districtid"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
            }
            int delete = 0;
            int transfer = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    genericClassService.updateRecordSQLStyle(County.class, new String[]{"districtid"}, new Object[]{destinationId}, "countyid", id);
                    int countTransfer = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:Id AND r.countyid=:Id2", new String[]{"Id", "Id2"}, new Object[]{destinationId, id});
                    if (countTransfer > 0) {
                        transfer += 1;
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "County";
            }
            if (transfer > 0) {
                model.put("successmessage", transfer + " " + activeType + "(s) Successfully Transfered");
            } else {
                model.put("successmessage", "Transfer Was Not Successful!");
            }
            model.put("resp", true);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }
        model.put("activity", "update");
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/manageCountyDiscardx")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView manageCountyDiscardx(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
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

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            List<Object[]> objListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                List<Subcounty> facList = new ArrayList<Subcounty>();

                String[] params = {"cID"};
                Object[] paramValues = {id};
                String[] countyFields = {"countyid", "countyname"};
                List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, " WHERE r.countyid!=:cID", params, paramValues);
                if (countyArrList != null) {
                    model.put("countyArrList", countyArrList);
                }
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname"};
                List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, "WHERE r.countyid.countyid=:Id ORDER BY r.subcountyname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("subcounties", subcountyArrList);
                if (subcountyArrList != null) {
                    model.put("size", subcountyArrList.size());
                }

                return new ModelAndView("controlPanel/universalPanel/location/forms/transferCountyAttachment", "model", model);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

    @RequestMapping("/addOrUpdateSubCounty")
    @SuppressWarnings("CallToPrintStackTrace")
    public final ModelAndView addOrUpdateSubCounty(HttpServletRequest request, @RequestParam("scID") int subcountyId, @RequestParam("act") String activity, Principal principal) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            Subcounty subcounty = null;
            if (activity.equals("update")) {
                String[] params = {"scID"};
                Object[] paramValues = {subcountyId};
                String[] fields = {};
                subcounty = (Subcounty) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues).get(0);
                model.put("subcounty", subcounty);
                System.out.println("===============" + subcounty + "===============");
            }
            if (activity.equals("add2")) {
                activity = "add";
                String[] params = {"scID"};
                Object[] paramValues = {subcountyId};
                String[] fields = {};
                subcounty = (Subcounty) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues).get(0);
                Subcounty s2 = new Subcounty();
                s2.setCountyid(subcounty.getCountyid());
                model.put("subcounty", s2);
            }

            model.put("activity", activity);
            String[] fields = {};

            List<Region> regions = (List<Region>) genericClassService.fetchRecord(Region.class, fields, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regions);
            return new ModelAndView("controlPanel/universalPanel/location/forms/addSubCounty", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered , try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/forms/addSubCounty", "model", model);
        }
    }

    @RequestMapping(value = "/loadSubCounties.htm", method = RequestMethod.GET)
    public final ModelAndView loadSubCounties(@RequestParam("loc") int location, @RequestParam("cID") Long countyid,
            Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        String[] params = {"cID"};
        Object[] paramsValues = {countyid};
        String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
        List<Object[]> subcountys = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", params, paramsValues);

        model.put("subCountyList", subcountys);
        model.put("size", subcountys == null ? 0 : subcountys.size());

        if (location == 3) {
            model.put("allData", false);
        }
        if (location == 4) {
            model.put("link", "ajaxSubmitData('loadParishes.htm', 'villageDivx', {scID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 5) {
            model.put("link", "ajaxSubmitData('loadParishes.htm', 'parishDivx', {scID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 33) {
            model.put("allData", false);
            model.put("link", "");
        }
        if (location == 44) {
            model.put("link", "ajaxSubmitData('loadParishes.htm', 'villageDivx', {scID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 55) {
            model.put("link", "ajaxSubmitData('loadParishes.htm', 'parishDivx', {scID: $(this).val(), loc: " + location + "}, 'GET');");
        }

        return new ModelAndView("controlPanel/universalPanel/location/loadSubcounties", "model", model);
    }

    @RequestMapping(value = "/saveOrUpdateSubCounty", method = RequestMethod.POST)
    public final ModelAndView saveOrUpdateSubCounty(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        String activity = "update";
        try {
            String[] params = {"scID"};
            String[] fields = {"subcountyid", "subcountyname", "countyid.countyid", "countyid.districtid.districtid", "countyid.districtid.regionid.regionid",
                "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};

            Integer objectid = 0;
            model.put("exists", false);
            model.put("deleted", false);
        if (request.getParameter("subcountyid") != null) {
                model.put("exists", true);
                objectid = Integer.parseInt(request.getParameter("subcountyid"));
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid"}, " WHERE "
                        + "lower(r.subcountyname)=:scName AND r.subcountyname=:scName2 AND r.countyid.countyid=:cID", new String[]{"scName", "scName2", "cID"}, new Object[]{request.getParameter("subcountyname").trim().toLowerCase(), request.getParameter("subcountyname").trim(), Integer.parseInt(request.getParameter("countyid").trim())});
                if (object != null) {
                    activity = "updateExists";
                    model.put("saved", false);
                    model.put("successmessage", "Sub County: " + request.getParameter("scname") + " Already Exists");
                } else {
                    Object[] paramValues = {Long.parseLong(request.getParameter("subcountyid"))};
                    List<Object[]> prevSubcountyObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);

                    genericClassService.updateRecordSQLStyle(Subcounty.class, new String[]{"subcountyname", "countyid"}, new Object[]{request.getParameter("subcountyname").trim(), Integer.parseInt(request.getParameter("countyid"))}, "subcountyid", Long.parseLong(request.getParameter("subcountyid")));

                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
                    if (checkObj != null) {

                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Subcounty";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Update");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Updated Sub-County");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCursubcounty((String) checkObj.get(0)[1]);
                        al.setCurcounty((String) checkObj.get(0)[5]);
                        al.setCurdistrict((String) checkObj.get(0)[6]);
                        al.setCurregion((String) checkObj.get(0)[7]);
                        al.setPrevlocationid((Integer) prevSubcountyObj.get(0)[0]);
                        al.setPrevsubcounty((String) prevSubcountyObj.get(0)[1]);
                        al.setPrevcounty((String) prevSubcountyObj.get(0)[5]);
                        al.setPrevdistrict((String) prevSubcountyObj.get(0)[6]);
                        al.setPrevregion((String) prevSubcountyObj.get(0)[7]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));

                    }

                    model.put("saved", true);
                    model.put("successmessage", "Sub County: " + request.getParameter("subcountyname") + " Saved Successfully");
                }
            } else {
                activity = "add";
                model.put("exists", true);
                Subcounty subcounty = new Subcounty();
                subcounty.setSubcountyname(request.getParameter("scname"));
                logger.info("parent :::::::::::: " + request.getParameter("parent"));
                logger.info("sub name :::::::::::: " + request.getParameter("scname"));
                subcounty.setCountyid(new County(Integer.parseInt(request.getParameter("parent"))));

                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid"}, " WHERE lower(r.subcountyname)=:scName AND r.countyid.countyid=:cID", new String[]{"scName", "cID"}, new Object[]{request.getParameter("scname").trim().toLowerCase(), Integer.parseInt(request.getParameter("parent").trim())});
                if (object != null) {
                    activity = "addExists";
                    model.put("saved", false);
                    model.put("successmessage", "Sub County: " + request.getParameter("subcountyname") + " Already Exists");
                } else {
                    genericClassService.saveOrUpdateRecordLoadObject(subcounty);
                    objectid = subcounty.getSubcountyid();
                    model.put("saved", true);
                    model.put("successmessage", "Sub County: " + request.getParameter("subcountyname") + " Saved Successfully");

                    Object[] paramValues = {objectid};
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
                    if (checkObj != null) {

                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Subcounty";
                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Add");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Added New Sub-County");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCursubcounty((String) checkObj.get(0)[1]);
                        al.setCurcounty((String) checkObj.get(0)[5]);
                        al.setCurdistrict((String) checkObj.get(0)[6]);
                        al.setCurregion((String) checkObj.get(0)[7]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);

                        model.put("checkObj", checkObj.get(0));
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("exists", null);
            model.put("saved", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        model.put("activity", activity);
        return new ModelAndView("controlPanel/universalPanel/location/view/saveCounty", "model", model);
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/manageSubCountyDiscard")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView manageSubCountyDiscard(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
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

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            List<Object[]> objListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                List<Parish> facList = new ArrayList<Parish>();

                String[] params = {"scID"};
                Object[] paramValues = {id};
                String[] subcountyFields = {"subcountyid", "subcountyname"};
                List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, " WHERE r.subcountyid!=:scID", params, paramValues);
                if (subcountyArrList != null) {
                    model.put("subcountyArrList", subcountyArrList);
                }
                String[] fields = {"parishid", "parishname", "subcountyid.subcountyname"};
                List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, "WHERE r.subcountyid.subcountyid=:Id ORDER BY r.parishname ASC", new String[]{"Id"}, new Object[]{id});
                model.put("parishes", parishArrList);
                if (parishArrList != null) {
                    model.put("size", parishArrList.size());
                }
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferSubCountyAttachment", "model", model);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

//    @RequestMapping(value = "/searchTransferLoc.htm", method = RequestMethod.GET)
//    @SuppressWarnings({"CallToThreadDumpStack", "CallToPrintStackTrace"})
//    public ModelAndView searchTransferLoc(@RequestParam("act") String activity, @RequestParam("st") String term,
//            @RequestParam("v1") long id, HttpServletRequest request, Principal principal) {
//        Map<String, Object> model = new HashMap<String, Object>();
//        try {
//            if (principal == null) {
//                return new ModelAndView("login");
//            }
//            if (activity.equals("sc")) {
//                String[] params = {"scID"};
//                Object[] paramsValues = {id};
//                String[] fields = {"subcountyid", "subcountyname", "county.countyname", "county.district.districtname", "county.district.region.regionname"};
//                List<Object[]> subcountys = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, paramsValues);
//                if (subcountys != null) {
//                    model.put("location", subcountys.get(0));
//                }
//
//                List<Region> regionsList = (List<Region>) genericClassService.fetchRecord(Region.class, new String[]{}, " ORDER BY r.regionname ASC", null, null);
//                model.put("regionsList", regionsList);
//                if (term.equals("village")) {
//                    model.put("title", "Villages");
//                    model.put("btn", "Transfer Village");
//                }
//                if (term.equals("parish")) {
//                    model.put("title", "Parishes");
//                    model.put("btn", "Transfer Parish");
//                }
//
//            }
//            String[] params = {"locID"};
//            Object[] paramsValues = {id};
//
//            model.put("activity", activity);
//            model.put("term", term);
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.put("successmessage", "Error Occured!");
//        }
//        return new ModelAndView("controlPanel/universalPanel/location/forms/transferAttachmentForm", "model", model);
//    }
    @RequestMapping(value = "/searchTransferLoc", method = RequestMethod.GET)
    @SuppressWarnings({"CallToThreadDumpStack", "CallToPrintStackTrace"})
    public ModelAndView searchTransferLoc(@RequestParam("act") String activity, @RequestParam("st") String term,
            @RequestParam("v1") long id, HttpServletRequest request, Principal principal) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            model.put("activity", activity);
            model.put("term", term);

            if (activity.equals("sc")) {
                String[] params = {"scID"};
                Object[] paramsValues = {id};
                String[] fields = {"subcountyid", "subcountyname", "county.countyname", "county.district.districtname", "county.district.region.regionname"};
                List<Object[]> subcountys = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, paramsValues);
                if (subcountys != null) {
                    model.put("location", subcountys.get(0));
                }

                List<Region> regionsList = (List<Region>) genericClassService.fetchRecord(Region.class, new String[]{}, " ORDER BY r.regionname ASC", null, null);
                model.put("regionsList", regionsList);
                if (term.equals("village")) {
                    model.put("title", "Villages");
                    model.put("btn", "Transfer Village");
                }
                if (term.equals("parish")) {
                    model.put("title", "Parishes");
                    model.put("btn", "Transfer Parish");
                }
            }

            String[] params = {"locID"};
            Object[] paramsValues = {id};

            logger.info("Here ------------- activity:" + activity);
            if (activity.equals("v1d")) {
                logger.info("********activity*********:" + activity);
                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> districts = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.regionid.regionid=:locID ORDER BY r.districtname ASC", params, paramsValues);
                model.put("districtList", districts);
                model.put("link", "ajaxSubmitData('locations/searchTransferLoc.htm', 'countyDivx', 'act=v1c&v1='+this.value+'&st=" + term + "', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);
            }
            if (activity.equals("v1c")) {
                String[] fields = {"countyid", "countyname"};
                List<Object[]> countys = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:locID ORDER BY r.countyname ASC", params, paramsValues);
                model.put("countyList", countys);
                model.put("link", "ajaxSubmitData('locations/searchTransferLoc.htm', 'subcountyDivx', 'act=v1sc&v1='+this.value+'&st=" + term + "', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);
            }
            if (activity.equals("v1sc")) {
                String[] fields = {"subcountyid", "subcountyname"};
                List<Object[]> subcountys = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.countyid.countyid=:locID ORDER BY r.subcountyname ASC", params, paramsValues);
                model.put("subcountyList", subcountys);
                model.put("link", "ajaxSubmitData('locations/searchTransferLoc.htm', 'parishDivx', 'act=v1p&v1='+this.value+'&st=" + term + "', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);
            }
            if (activity.equals("v1p")) {
                String[] fields = {"parishid", "parishname"};
                List<Object[]> parishes = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:locID ORDER BY r.parishname ASC", params, paramsValues);
                model.put("parishList", parishes);
                model.put("link", "ajaxSubmitData('locations/searchTransferLoc.htm', 'villageDivx', 'act=v1v&v1='+this.value+'&st=" + term + "', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);
            }
            if (activity.equals("v1v")) {
                String[] fields = {"villageid", "villagename"};
                List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.parishid.parishid=:locID ORDER BY r.villagename ASC", params, paramsValues);
                model.put("villageList", villages);
                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.put("successmessage", "Error Occured!");
        }
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferAttachmentForm", "model", model);
    }

    @RequestMapping(value = "/deleteSubCounty.htm", method = RequestMethod.GET)
    public final ModelAndView deleteSubCounty(@RequestParam("act") String activity, @RequestParam("scID") int subcountyId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        Integer countyid = (Integer) genericClassService.fetchRecord(Subcounty.class, new String[]{"countyid.countyid"}, " WHERE r.subcountyid=:scID", new String[]{"scID"}, new Object[]{subcountyId}).get(0);

        try {
            String[] params = {"scID"};
            Object[] paramValues = {subcountyId};
            String[] fields = {"subcountyid", "subcountyname", "countyid.countyid", "countyid.districtid.districtid", "countyid.districtid.regionid.regionid",
                "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
            
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
            if (checkObj != null) {
                model.put("checkObj", checkObj.get(0));
            }
            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid"}, " WHERE r.subcountyid.subcountyid=:scID", new String[]{"scID"}, new Object[]{subcountyId});
            int success = object == null ? genericClassService.deleteRecordById(Subcounty.class, "subcountyid", subcountyId) : 0;

            if (success == 1) {
                 model.put("deleted", true);
                model.put("successmessage", "Successfully Deleted Sub County: " + checkObj.get(0)[1]);
                //Trail of deleted record
                long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                String sessAuditTrailCategory = "Location Management";
                String sessAuditTrailActivity = "Subcounty";

                Audittraillocation al = new Audittraillocation();
                al.setCategory(sessAuditTrailCategory);
                al.setActivity(sessAuditTrailActivity);
                al.setDbaction("Delete");
                al.setTimein(new Date());
                al.setPerson(new Person(pid));
                al.setAttrvalue((String) checkObj.get(0)[1]);
                al.setDescription("Deleted Sub-County");
                al.setPrevlocationid((Integer) checkObj.get(0)[2]);//set county
                al.setPrevsubcounty((String) checkObj.get(0)[1]);
                al.setPrevcounty((String) checkObj.get(0)[5]);
                al.setPrevdistrict((String) checkObj.get(0)[6]);
                al.setPrevregion((String) checkObj.get(0)[7]);
                al.setAdministered(false);
                al.setReflevel(0);
                genericClassService.saveOrUpdateRecordLoadObject(al);
      
            }
            else {
                int count = genericClassService.fetchRecordCount(Parish.class, "WHERE r.subcountyid.subcountyid=:scID", new String[]{"scID"}, new Object[]{subcountyId});
                model.put("count", count);
                logger.info(" check well..." + count);
                model.put("deleted", false);
                if (count > 0) {

                    model.put("successmessage", "Failed to Delete Sub County:: " + checkObj.get(0)[1] + " With <a href=\"#\" onClick=\"ajaxSubmitData('locations/manageSubCountyDiscard.htm', 'transfer-pane', 'act=a&i=" + subcountyId + "&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');\"><strong>" + count + "</strong></a> Parishes");
                } else {
                    model.put("successmessage", "Failed to Delete Sub County:: " + checkObj.get(0)[1] + ". Error Occured. Try Again!");
                }
            }
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardSubCounty", "model", model);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardSubCounty", "model", model);
        }
    }

    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/transferSubCounty", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferSubCounty(HttpServletRequest request, Principal principal) {
        logger.info("Received request to transfer County");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            List<Integer> ids = new ArrayList<Integer>();
            List<Parish> customList = new ArrayList<Parish>();
            int destinationId = Integer.parseInt(request.getParameter("subcountyid"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
            }
            int delete = 0;
            int transfer = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    genericClassService.updateRecordSQLStyle(Parish.class, new String[]{"subcountyid"}, new Object[]{destinationId}, "parishid", id);
                    int countTransfer = genericClassService.fetchRecordCount(Parish.class, "WHERE r.subcountyid.subcountyid=:Id AND r.parishid=:Id2", new String[]{"Id", "Id2"}, new Object[]{destinationId, id});
                    if (countTransfer > 0) {
                        transfer += 1;
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "Parish";
            }
            if (transfer > 0) {
                model.put("successmessage", transfer + " " + activeType + "(s) Successfully Transfered");
            } else {
                model.put("successmessage", "Transfer Was Not Successful!");
            }
            model.put("resp", true);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }
        model.put("activity", "update");
        return new ModelAndView("controlPanel/universalPanel/location/forms/transferResponse", "model", model);
    }

    @RequestMapping(value = "/manageParish", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView manageParish(HttpServletRequest request, Principal principal,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            model.put("mainActivity", "Parish");

            if (activity.equals("a")) {
                String subCountyName = "";
                int parishesInSubCounty = 0;
                List<Region> regList = new ArrayList<>();
                List<District> distList = new ArrayList<>();
                List<County> countyList = new ArrayList<>();
                List<Subcounty> subCountyList = new ArrayList<>();
                List<Parish> parishList = new ArrayList<>();

                List<Object[]> regionsList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", null, null);
                if (regionsList != null && !regionsList.isEmpty()) {
                    int regionid = (Integer) regionsList.get(0)[0];
                    model.put("regionid", regionid);
                    for (Object[] regObj : regionsList) {
                        Region reg = new Region();
                        reg.setRegionid((Integer) regObj[0]);
                        reg.setRegionname((String) regObj[1]);
                        regList.add(reg);
                    }

                    List<Object[]> districtsList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.regionid.regionid=:rId ORDER BY r.districtname ASC", new String[]{"rId"}, new Object[]{regionid});
                    if (districtsList != null && !districtsList.isEmpty()) {
                        int districtid = (Integer) districtsList.get(0)[0];
                        model.put("districtid", districtid);
                        for (Object[] distObj : districtsList) {
                            District dist = new District();
                            dist.setDistrictid((Integer) distObj[0]);
                            dist.setDistrictname((String) distObj[1]);
                            distList.add(dist);
                        }

                        List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{districtid});
                        if (countyArrList != null && !countyArrList.isEmpty()) {
                            int countyid = (Integer) countyArrList.get(0)[0];
                            model.put("countyid", countyid);
                            for (Object[] counObj : countyArrList) {
                                County c = new County();
                                c.setCountyid((Integer) counObj[0]);
                                c.setCountyname((String) counObj[1]);
                                countyList.add(c);
                            }

                            List<Object[]> subCountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", new String[]{"cID"}, new Object[]{countyid});
                            if (subCountyArrList != null && !subCountyArrList.isEmpty()) {
                                int subcountyid = (Integer) subCountyArrList.get(0)[0];
                                model.put("subcountyid", subcountyid);
                                for (Object[] subcObj : subCountyArrList) {
                                    Subcounty sc = new Subcounty();
                                    sc.setSubcountyid((Integer) subcObj[0]);
                                    sc.setSubcountyname((String) subcObj[1]);
                                    subCountyList.add(sc);
                                    if (sc.getSubcountyid() == subcountyid) {
                                        subCountyName = sc.getSubcountyname();
                                        model.put("subCountyObj", sc);
                                    }
                                }

                                String[] params = {"scID"};
                                Object[] paramsValues = {subcountyid};
                                String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                                List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", params, paramsValues);
                                if (parishArrList != null && !parishArrList.isEmpty()) {
                                    model.put("size", parishArrList.size());
                                    parishesInSubCounty = parishArrList.size();
                                }
                                model.put("parishList", parishArrList);
                            }
                        }
                    }
                }
                int parishesInCountry = genericClassService.fetchRecordCount(Parish.class, "", new String[]{}, new Object[]{});
                model.put("totalParishes", parishesInCountry);

                model.put("regionsList", regList);
                model.put("districtList", distList);
                model.put("countyList", countyList);
                model.put("subCountyList", subCountyList);
                model.put("title", subCountyName + " - Parishes[" + parishesInSubCounty + "]");

            }
            if (activity.equals("b")) {
                if (strVal.equals("a")) {// Load Districts
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID", new String[]{"rID"}, new Object[]{id});
                    model.put("districtList", districtArrObj);
                }
                if (strVal.equals("b")) {// Load Countys
                    String[] fields = {"countyid", "countyname"};
                    List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{id});
                    model.put("countyList", countysArrList);
                }
                if (strVal.equals("c")) {// Load Sub-Countys
                    List<Object[]> subCountysArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.countyid.countyid=:cID", new String[]{"cID"}, new Object[]{id});
                    model.put("subCountyList", subCountysArrList);
                }
                if (strVal.equals("d")) {// Load Parishes
                    String subCountyName = "";
                    int parishesInSubCounty = 0;
                    String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                    List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", new String[]{"scID"}, new Object[]{id});
                    if (parishArrList != null && !parishArrList.isEmpty()) {
                        model.put("size", parishArrList.size());
                        parishesInSubCounty = parishArrList.size();

                    }
                    List<Object[]> subCountysArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.subcountyid=:scID", new String[]{"scID"}, new Object[]{id});
                    Subcounty sc = new Subcounty();
                    if (subCountysArrObj != null && !subCountysArrObj.isEmpty()) {
                        for (Object[] obj : subCountysArrObj) {
                            sc = new Subcounty((Integer) obj[0]);
                            sc.setSubcountyname((String) obj[1]);
                        }
                    }
                    model.put("subCountyObj", sc);
                    model.put("title", subCountyName + " - Parishes[" + parishesInSubCounty + "]");
                    model.put("parishList", parishArrList);
                }
                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
            }

            return new ModelAndView("controlPanel/universalPanel/location/view/parishContent", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/view/subCountyContent", "model", model);
        }
    }

//    @RequestMapping(value = "/manageParish", method = RequestMethod.GET)
//    @SuppressWarnings("CallToThreadDumpStack")
//    public ModelAndView manageParish(HttpServletRequest request, Principal principal,
//            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
//            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
//            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
//            @RequestParam("sStr") String searchPhrase) {
//        Map<String, Object> model = new HashMap<String, Object>();
//        try {
//            if (principal == null) {
//                return new ModelAndView("login");
//            }
//            model.put("act", activity);
//            model.put("b", strVal);
//            model.put("i", id);
//            model.put("c", strVal2);
//            model.put("d", id2);
//            model.put("ofst", offset);
//            model.put("maxR", maxResults);
//            model.put("sStr", searchPhrase);
//
//            model.put("mainActivity", "Parish");
//
//            if (activity.equals("a")) {
//                String subCountyName = "";
//                int parishesInSubCounty = 0;
//                List<Region> regList = new ArrayList<>();
//                List<District> distList = new ArrayList<>();
//                List<County> countyList = new ArrayList<>();
//                List<Subcounty> subCountyList = new ArrayList<>();
//                List<Parish> parishList = new ArrayList<>();
//
//                List<Object[]> regionsList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", null, null);
//                if (regionsList != null && !regionsList.isEmpty()) {
//                    int regionid = (Integer) regionsList.get(0)[0];
//                    model.put("regionid", regionid);
//                    for (Object[] regObj : regionsList) {
//                        Region reg = new Region();
//                        reg.setRegionid((Integer) regObj[0]);
//                        reg.setRegionname((String) regObj[1]);
//                        regList.add(reg);
//                    }
//
//                    List<Object[]> districtsList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.regionid.regionid=:rId ORDER BY r.districtname ASC", new String[]{"rId"}, new Object[]{regionid});
//                    if (districtsList != null && !districtsList.isEmpty()) {
//                        int districtid = (Integer) districtsList.get(0)[0];
//                        model.put("districtid", districtid);
//                        for (Object[] distObj : districtsList) {
//                            District dist = new District();
//                            dist.setDistrictid((Integer) distObj[0]);
//                            dist.setDistrictname((String) distObj[1]);
//                            distList.add(dist);
//                        }
//
//                        List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{districtid});
//                        if (countyArrList != null && !countyArrList.isEmpty()) {
//                            int countyid = (Integer) countyArrList.get(0)[0];
//                            model.put("countyid", countyid);
//                            for (Object[] counObj : countyArrList) {
//                                County c = new County();
//                                c.setCountyid((Integer) counObj[0]);
//                                c.setCountyname((String) counObj[1]);
//                                countyList.add(c);
//                            }
//
//                            List<Object[]> subCountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", new String[]{"cID"}, new Object[]{countyid});
//                            if (subCountyArrList != null && !subCountyArrList.isEmpty()) {
//                                int subcountyid = (Integer) subCountyArrList.get(0)[0];
//                                model.put("subcountyid", subcountyid);
//                                for (Object[] subcObj : subCountyArrList) {
//                                    Subcounty sc = new Subcounty();
//                                    sc.setSubcountyid((Integer) subcObj[0]);
//                                    sc.setSubcountyname((String) subcObj[1]);
//                                    subCountyList.add(sc);
//                                    if (sc.getSubcountyid() == subcountyid) {
//                                        subCountyName = sc.getSubcountyname();
//                                        model.put("subCountyObj", sc);
//                                    }
//                                }
//
//                                String[] params = {"scID"};
//                                Object[] paramsValues = {subcountyid};
//                                String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
//                                List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", params, paramsValues);
//                                if (parishArrList != null && !parishArrList.isEmpty()) {
//                                    model.put("size", parishArrList.size());
//                                    parishesInSubCounty = parishArrList.size();
//                                }
//                                model.put("parishList", parishArrList);
//                            }
//                        }
//                    }
//                }
//                int parishesInCountry = genericClassService.fetchRecordCount(Parish.class, "", new String[]{}, new Object[]{});
//                model.put("totalParishes", parishesInCountry);
//
//                model.put("regionsList", regList);
//                model.put("districtList", distList);
//                model.put("countyList", countyList);
//                model.put("subCountyList", subCountyList);
//                model.put("title", subCountyName + " - Parishes[" + parishesInSubCounty + "]");
//
//            }
//            if (activity.equals("b")) {
//                if (strVal.equals("a")) {// Load Districts
//                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID", new String[]{"rID"}, new Object[]{id});
//                    model.put("districtList", districtArrObj);
//                }
//                if (strVal.equals("b")) {// Load Countys
//                    String[] fields = {"countyid", "countyname"};
//                    List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{id});
//                    model.put("countyList", countysArrList);
//                }
//                if (strVal.equals("c")) {// Load Sub-Countys
//                    List<Object[]> subCountysArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.countyid.countyid=:cID", new String[]{"cID"}, new Object[]{id});
//                    model.put("subCountyList", subCountysArrList);
//                }
//                if (strVal.equals("d")) {// Load Parishes
//                    String subCountyName = "";
//                    int parishesInSubCounty = 0;
//                    String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
//                    List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", new String[]{"scID"}, new Object[]{id});
//                    if (parishArrList != null && !parishArrList.isEmpty()) {
//                        model.put("size", parishArrList.size());
//                        parishesInSubCounty = parishArrList.size();
//
//                    }
//                    List<Object[]> subCountysArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.subcountyid=:scID", new String[]{"scID"}, new Object[]{id});
//                    Subcounty sc = new Subcounty();
//                    if (subCountysArrObj != null && !subCountysArrObj.isEmpty()) {
//                        for (Object[] obj : subCountysArrObj) {
//                            sc = new Subcounty((Integer) obj[0]);
//                            sc.setSubcountyname((String) obj[1]);
//                        }
//                    }
//                    model.put("subCountyObj", sc);
//                    model.put("title", subCountyName + " - Parishes[" + parishesInSubCounty + "]");
//                    model.put("parishList", parishArrList);
//                }
//                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
//            }
//
//            return new ModelAndView("controlPanel/universalPanel/location/view/parishContent", "model", model);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
//            return new ModelAndView("controlPanel/universalPanel/location/view/subCountyContent", "model", model);
//        }
//    }
    @RequestMapping(value = "/manageVillage", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView manageVillage(HttpServletRequest request, Principal principal,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            model.put("mainActivity", "Village");

            if (activity.equals("a")) {
                String parishName = "";
                int villagesInParish = 0;
                List<Region> regList = new ArrayList<>();
                List<District> distList = new ArrayList<>();
                List<County> countyList = new ArrayList<>();
                List<Subcounty> subCountyList = new ArrayList<>();
                List<Parish> parishList = new ArrayList<>();

                List<Object[]> regionsList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", null, null);
                if (regionsList != null && !regionsList.isEmpty()) {
                    int regionid = (Integer) regionsList.get(0)[0];
                    model.put("regionid", regionid);
                    for (Object[] regObj : regionsList) {
                        Region reg = new Region();
                        reg.setRegionid((Integer) regObj[0]);
                        reg.setRegionname((String) regObj[1]);
                        regList.add(reg);
                    }

                    List<Object[]> districtsList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.regionid.regionid=:rId ORDER BY r.districtname ASC", new String[]{"rId"}, new Object[]{regionid});
                    if (districtsList != null && !districtsList.isEmpty()) {
                        int districtid = (Integer) districtsList.get(0)[0];
                        model.put("districtid", districtid);
                        for (Object[] distObj : districtsList) {
                            District dist = new District();
                            dist.setDistrictid((Integer) distObj[0]);
                            dist.setDistrictname((String) distObj[1]);
                            distList.add(dist);
                        }

                        List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{districtid});
                        if (countyArrList != null && !countyArrList.isEmpty()) {
                            int countyid = (Integer) countyArrList.get(0)[0];
                            model.put("countyid", countyid);
                            for (Object[] counObj : countyArrList) {
                                County c = new County();
                                c.setCountyid((Integer) counObj[0]);
                                c.setCountyname((String) counObj[1]);
                                countyList.add(c);
                            }

                            List<Object[]> subCountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", new String[]{"cID"}, new Object[]{countyid});
                            if (subCountyArrList != null && !subCountyArrList.isEmpty()) {
                                int subcountyid = (Integer) subCountyArrList.get(0)[0];
                                model.put("subcountyid", subcountyid);
                                for (Object[] subcObj : subCountyArrList) {
                                    Subcounty sc = new Subcounty();
                                    sc.setSubcountyid((Integer) subcObj[0]);
                                    sc.setSubcountyname((String) subcObj[1]);
                                    subCountyList.add(sc);
                                }

                                List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, "WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", new String[]{"scID"}, new Object[]{subcountyid});
                                if (parishArrList != null && !parishArrList.isEmpty()) {
                                    int parishid = (Integer) parishArrList.get(0)[0];
                                    model.put("parishid", parishid);
                                    for (Object[] pObj : parishArrList) {
                                        Parish p = new Parish();
                                        p.setParishid((Integer) pObj[0]);
                                        p.setParishname((String) pObj[1]);
                                        parishList.add(p);
                                        if (p.getParishid() == parishid) {
                                            parishName = p.getParishname();
                                            model.put("parishObj", p);
                                        }
                                    }

                                    String[] params = {"pID"};
                                    Object[] paramsValues = {parishid};
                                    String[] fields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
                                    List<Object[]> villageArrList = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.parishid.parishid=:pID ORDER BY r.villagename ASC", params, paramsValues);
                                    if (villageArrList != null && !villageArrList.isEmpty()) {
                                        model.put("size", villageArrList.size());
                                        villagesInParish = villageArrList.size();
                                    }
                                    model.put("villageList", villageArrList);
                                }
                            }
                        }
                    }
                }
                int villageInCountry = genericClassService.fetchRecordCount(Village.class, "", new String[]{}, new Object[]{});
                model.put("totalVillages", villageInCountry);

                model.put("regionsList", regList);
                model.put("districtList", distList);
                model.put("countyList", countyList);
                model.put("subCountyList", subCountyList);
                model.put("parishList", parishList);
                model.put("title", parishName + " - Villages[" + villagesInParish + "]");

            }
            if (activity.equals("b")) {
                if (strVal.equals("a")) {// Load Districts
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID", new String[]{"rID"}, new Object[]{id});
                    model.put("districtList", districtArrObj);
                }
                if (strVal.equals("b")) {// Load Countys
                    String[] fields = {"countyid", "countyname"};
                    List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{id});
                    model.put("countyList", countysArrList);
                }
                if (strVal.equals("c")) {// Load Sub-Countys
                    List<Object[]> subCountysArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, " WHERE r.countyid.countyid=:cID", new String[]{"cID"}, new Object[]{id});
                    model.put("subCountyList", subCountysArrList);
                }
                if (strVal.equals("d")) {// Load Parishes
                    List<Object[]> parishArrList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", new String[]{"scID"}, new Object[]{id});
                    model.put("parishList", parishArrList);
                }
                if (strVal.equals("e")) {// Load Parishes
                    String subCountyName = "";
                    int villagesInParish = 0;
                    String[] fields = {"villageid", "villagename", "parishid.parishid", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
                    List<Object[]> villageArrList = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.parishid.parishid=:pID ORDER BY r.villagename ASC", new String[]{"pID"}, new Object[]{id});
                    if (villageArrList != null && !villageArrList.isEmpty()) {
                        model.put("size", villageArrList.size());
                        villagesInParish = villageArrList.size();
                    }

                    List<Object[]> parishArrObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, " WHERE r.parishid=:pID", new String[]{"pID"}, new Object[]{id});
                    Parish p = new Parish();
                    if (parishArrObj != null && !parishArrObj.isEmpty()) {
                        for (Object[] obj : parishArrObj) {
                            p = new Parish((Integer) obj[0]);
                            p.setParishname((String) obj[1]);
                        }
                    }
                    model.put("parishObj", p);
                    model.put("title", p.getParishname() + " - Parishes[" + villagesInParish + "]");
                    model.put("villageList", villageArrList);
                }
                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
            }

            return new ModelAndView("controlPanel/universalPanel/location/view/villageContent", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/view/subCountyContent", "model", model);
        }
    }
    @RequestMapping(value = "/deleteParish", method = RequestMethod.GET)
    public final ModelAndView deleteParish(@RequestParam("act") String activity, @RequestParam("pID") int parishId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        Integer subcountyid = (Integer) genericClassService.fetchRecord(Parish.class, new String[]{"subcountyid.subcountyid"}, " WHERE r.parishid=:pID", new String[]{"pID"}, new Object[]{parishId}).get(0);

        try {

            String[] params = {"pID"};
            Object[] paramValues = {parishId};
            String[] fields = {"parishid", "parishname", "subcountyid.subcountyid", "subcountyid.countyid.countyid", "subcountyid.countyid.districtid.districtid", "subcountyid.countyid.districtid.regionid.regionid",
                "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID", params, paramValues);
            if (checkObj != null) {
                model.put("checkObj", checkObj.get(0));
            }

            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid"}, " WHERE r.parishid.parishid=:pID", new String[]{"pID"}, new Object[]{parishId});
            int success = object == null ? genericClassService.deleteRecordById(Parish.class, "parishid", parishId) : 0;

            if (success == 1) {
                model.put("deleted", true);
                model.put("successmessage", "Successfully Deleted Parish: " + checkObj.get(0)[1]);

                String sessAuditTrailCategory = "Location Management";
                String sessAuditTrailActivity = "Parish";
                Audittraillocation al = new Audittraillocation();
                al.setCategory(sessAuditTrailCategory);
                al.setActivity(sessAuditTrailActivity);
                al.setDbaction("Delete");
                al.setTimein(new Date());
                al.setPerson(new Person(pid));
                al.setDescription("Deleted Parish");
                al.setAttrvalue((String) checkObj.get(0)[1]);
                al.setPrevlocationid((Integer) checkObj.get(0)[2]);
                al.setPrevparish((String) checkObj.get(0)[1]);
                al.setPrevsubcounty((String) checkObj.get(0)[6]);
                al.setPrevcounty((String) checkObj.get(0)[7]);
                al.setPrevdistrict((String) checkObj.get(0)[8]);
                al.setPrevregion((String) checkObj.get(0)[9]);
                al.setAdministered(false);
                al.setReflevel(0);
                genericClassService.saveOrUpdateRecordLoadObject(al);

            } else {
                int count = genericClassService.fetchRecordCount(Village.class, "WHERE r.parishid.parishid=:Id", new String[]{"Id"}, new Object[]{parishId});
                model.put("count", count);
                logger.info(" check well..." + count);
                model.put("deleted", false);
                if (count > 0) {
                    model.put("successmessage", "Failed to Delete Parish:: " + checkObj.get(0)[1] + " With <a href=\"#\" onClick=\"ajaxSubmitData('locations/manageParishDiscard.htm', 'transfer-pane', 'act=a&i=" + parishId + "&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');\"><strong>" + count + "</strong></a> Village(s)");
                } else {
                    model.put("successmessage", "Failed to Delete Parish:: " + checkObj.get(0)[1] + ". Error Occured. Try Again!");
                }
            } 
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardParish", "model", model);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
            return new ModelAndView("controlPanel/universalPanel/location/forms/discardParish", "model", model);
        }
    }

    @RequestMapping(value = "/deleteVillage", method = RequestMethod.GET)
    public final ModelAndView deleteVillage(@RequestParam("act") String activity, @RequestParam("vID") int villageId, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("xxx", true);
        model.put("activity", "delete");
        Integer parishid = (Integer) genericClassService.fetchRecord(Village.class, new String[]{"parishid.parishid"}, " WHERE r.villageid=:vID", new String[]{"vID"}, new Object[]{villageId}).get(0);
        String villagename = (String) genericClassService.fetchRecord(Village.class, new String[]{"villagename"}, " WHERE r.villageid=:vID", new String[]{"vID"}, new Object[]{villageId}).get(0);

        try {
            String[] params = {"vID"};
            Object[] paramValues = {villageId};
            String[] fields = {"villageid", "villagename", "parishid.parishid", "parishid.subcountyid.subcountyid", "parishid.subcountyid.countyid.countyid", "parishid.subcountyid.countyid.districtid.districtid", "parishid.subcountyid.countyid.districtid.regionid.regionid",
                "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};

            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID", params, paramValues);
            if (checkObj != null) {
                if (checkObj != null) {
                    model.put("checkObj", checkObj.get(0));
                }
            }
            List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Location.class, new String[]{"locationid", "facilityid.facilityname"}, " WHERE r.villageid.villageid=:vID", new String[]{"vID"}, new Object[]{villageId});
            int success = object == null ? genericClassService.deleteRecordById(Village.class, "villageid", villageId) : 0;
            if (success == 1) {
                model.put("deleted", true);
                model.put("successmessage", "Successfully Deleted Village: " + checkObj.get(0)[1]);

                // Capture Trail Of Deleted Record
                String sessAuditTrailCategory = "Location Management";
                String sessAuditTrailActivity = "Village";

                Audittraillocation al = new Audittraillocation();
                al.setCategory(sessAuditTrailCategory);
                al.setActivity(sessAuditTrailActivity);
                al.setDbaction("Delete");
                al.setTimein(new Date());
                al.setPerson(new Person(pid));
                al.setAttrvalue((String) checkObj.get(0)[1]);
                al.setDescription("Deleted Village");
                al.setPrevlocationid((Integer) checkObj.get(0)[2]);//Set Previous Parish
                al.setPrevvillage((String) checkObj.get(0)[1]);
                al.setPrevparish((String) checkObj.get(0)[7]);
                al.setPrevsubcounty((String) checkObj.get(0)[8]);
                al.setPrevcounty((String) checkObj.get(0)[9]);
                al.setPrevdistrict((String) checkObj.get(0)[10]);
                al.setPrevregion((String) checkObj.get(0)[11]);
                al.setAdministered(false);
                al.setReflevel(0);
                genericClassService.saveOrUpdateRecordLoadObject(al);
            } else {
                model.put("deleted", false);
                model.put("successmessage", "Failed to Delete Village: " + checkObj.get(0)[1] + ", has <strong>" + object.size()
                        + "</strong> reference(s) From Facility. <br/>Please Delete These From The Faciliy Management Module.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "Failed to Delete Village<br/>Please Transfer Staff From Parish level.");
        }
        return new ModelAndView("controlPanel/universalPanel/location/forms/discardVillage", "model", model);
    }

    @RequestMapping("/addOrUpdateVillage")
    @SuppressWarnings("CallToPrintStackTrace")
    public final ModelAndView addOrUpdateVillage(HttpServletRequest request, @RequestParam("vID") int villageId, @RequestParam("act") String activity, Principal principal) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            Village village = null;
            if (activity.equals("update")) {
                String[] params = {"vID"};
                Object[] paramValues = {villageId};
                String[] fields = {};
                village = (Village) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID", params, paramValues).get(0);
                model.put("village", village);
            }
            if (activity.equals("add2")) {
                activity = "add";
                String[] params = {"vID"};
                Object[] paramValues = {villageId};
                String[] fields = {};
                village = (Village) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID", params, paramValues).get(0);
                Village v2 = new Village();
                v2.setParishid(village.getParishid());
                model.put("village", v2);
            }

            model.put("activity", activity);
            String[] fields = {};
            List<Region> regions = (List<Region>) genericClassService.fetchRecord(Region.class, fields, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regions);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered, try again or contact your systems administrator ");
        }
        return new ModelAndView("controlPanel/universalPanel/location/forms/addVillage", "model", model);
    }

    @RequestMapping(value = "/saveOrUpdateVillage", method = RequestMethod.POST)
    public final ModelAndView saveOrUpdateVillage(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        String activity = "update";
        try {
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            String[] params = {"vID"};
            String[] fields = {"villageid", "villagename", "parishid.parishid", "parishid.subcountyid.subcountyid", "parishid.subcountyid.countyid.countyid", "parishid.subcountyid.countyid.districtid.districtid", "parishid.subcountyid.countyid.districtid.regionid.regionid",
                "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};

            Integer objectid = 0;
            model.put("exists", false);
            model.put("deleted", false);
            if (request.getParameter("villageid") != null) {
                model.put("exists", true);
                objectid = Integer.parseInt(request.getParameter("villageid"));
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid"}, " WHERE "
                        + "lower(r.villagename)=:vName AND r.villagename=:vName2 AND r.parishid.parishid=:pID", new String[]{"vName", "vName2", "pID"}, new Object[]{request.getParameter("villagename").trim().toLowerCase(), request.getParameter("villagename").trim(), Integer.parseInt(request.getParameter("parishid").trim())});

                if (object != null) {
                    activity = "updateExists";
                    model.put("saved", false);
                    model.put("vID", Long.parseLong(request.getParameter("villageid")));
                    model.put("vName", request.getParameter("villagename"));
                    model.put("successmessage", "Village: " + request.getParameter("villagename") + " Already Exists");
                } else {
                    Object[] paramValues = {Long.parseLong(request.getParameter("villageid"))};
                    List<Object[]> prevVilObj = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID", params, paramValues);

                    genericClassService.updateRecordSQLStyle(Village.class, new String[]{"villagename", "parishid"}, new Object[]{request.getParameter("villagename").trim(), Integer.parseInt(request.getParameter("parishid"))}, "villageid", Long.parseLong(request.getParameter("villageid")));

                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID", params, paramValues);
                    if (checkObj != null) {

                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Village";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Update");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Updated Village");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurvillage((String) checkObj.get(0)[1]);
                        al.setCurparish((String) checkObj.get(0)[7]);
                        al.setCursubcounty((String) checkObj.get(0)[8]);
                        al.setCurcounty((String) checkObj.get(0)[9]);
                        al.setCurdistrict((String) checkObj.get(0)[10]);
                        al.setCurregion((String) checkObj.get(0)[11]);
                        al.setPrevlocationid((Integer) prevVilObj.get(0)[0]);
                        al.setPrevvillage((String) prevVilObj.get(0)[1]);
                        al.setPrevparish((String) prevVilObj.get(0)[7]);
                        al.setPrevsubcounty((String) prevVilObj.get(0)[8]);
                        al.setPrevcounty((String) prevVilObj.get(0)[9]);
                        al.setPrevdistrict((String) prevVilObj.get(0)[10]);
                        al.setPrevregion((String) prevVilObj.get(0)[11]);
                        al.setAdministered(false);
                        al.setReflevel(0);
                        genericClassService.saveOrUpdateRecordLoadObject(al);

                        model.put("checkObj", checkObj.get(0));
                    }

                    model.put("saved", true);
                    model.put("successmessage", "Village: " + request.getParameter("villagename") + " Saved Successfully");
                }
            } else {

                activity = "add";
                model.put("exists", true);
                Village village = new Village();
                village.setVillagename(request.getParameter("vname"));
                village.setParishid(new Parish(Integer.parseInt(request.getParameter("parent"))));
                logger.info("...........urihe ...." + request.getParameter("vname"));
                model.put("exists", true);
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid"}, " WHERE lower(r.villagename)=:vName AND r.parishid.parishid=:pID", new String[]{"vName", "pID"}, new Object[]{request.getParameter("vname").trim().toLowerCase(), Integer.parseInt(request.getParameter("parent").trim())});
                if (object != null) {
                    activity = "addExists";
                    model.put("saved", false);
                    //model.put("updatable", false);
                    model.put("successmessage", "Village: " + request.getParameter("villagename") + " Already Exists");
                } else {
                    genericClassService.saveOrUpdateRecordLoadObject(village);
                    objectid = village.getVillageid();
                    Object[] paramValues = {objectid};
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID", params, paramValues);
                    if (checkObj != null) {
                        model.put("checkObj", checkObj.get(0));
                        model.put("saved", true);
////                    model.put("updatable", true);
                        model.put("successmessage", "Village: " + request.getParameter("villagename") + " Saved Successfully");

                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Village";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Add");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Added Village");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurvillage((String) checkObj.get(0)[1]);
                        al.setCurparish((String) checkObj.get(0)[7]);
                        al.setCursubcounty((String) checkObj.get(0)[8]);
                        al.setCurcounty((String) checkObj.get(0)[9]);
                        al.setCurdistrict((String) checkObj.get(0)[10]);
                        al.setCurregion((String) checkObj.get(0)[11]);
                        al.setAdministered(false);
                        al.setReflevel(0);
                        al.setAdministered(false);
                        al.setReflevel(0);
                        genericClassService.saveOrUpdateRecordLoadObject(al);

                    } else {
                        model.put("saved", false);
                        model.put("successmessage", "Error, Village: " + request.getParameter("villagename") + " Not Saved");
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.put("exists", null);
            model.put("saved", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        model.put("activity", activity);
        return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
    }

    @RequestMapping(value = "/saveOrUpdateParish", method = RequestMethod.POST) 
    public final ModelAndView saveOrUpdateParish(HttpServletRequest request) {
        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
        Map<String, Object> model = new HashMap<String, Object>();
        String activity = "update";
        try {
            String[] params = {"pID"};
            String[] fields = {"parishid", "parishname", "subcountyid.subcountyid", "subcountyid.countyid.countyid", "subcountyid.countyid.districtid.districtid", "subcountyid.countyid.districtid.regionid.regionid",
                "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};

            Integer objectid = 0;
            model.put("exists", false);
            model.put("deleted", false);
            if (request.getParameter("parishid") != null) {
                model.put("exists", true);
                objectid = Integer.parseInt(request.getParameter("parishid"));
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid"}, " WHERE "
                        + "lower(r.parishname)=:pName AND r.parishname=:pName2 AND r.subcountyid.subcountyid=:scID", new String[]{"pName", "pName2", "scID"}, new Object[]{request.getParameter("parishname").trim().toLowerCase(), request.getParameter("parishname").trim(), Integer.parseInt(request.getParameter("subcountyid").trim())});
                if (object != null) {
                    activity = "updateExists";
                    model.put("saved", false);
                    model.put("successmessage", "Parish: " + request.getParameter("parishname") + " Already Exists");
                } else {
                    Object[] paramValues = {Long.parseLong(request.getParameter("parishid"))};
                    List<Object[]> prevParishObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID", params, paramValues);

                    genericClassService.updateRecordSQLStyle(Parish.class, new String[]{"parishname", "subcountyid"}, new Object[]{request.getParameter("parishname").trim(), Integer.parseInt(request.getParameter("subcountyid"))}, "parishid", Long.parseLong(request.getParameter("parishid")));

                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID", params, paramValues);
                    if (checkObj != null) {

                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Parish";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Update");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Updated Parish");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurparish((String) checkObj.get(0)[1]);
                        al.setCursubcounty((String) checkObj.get(0)[6]);
                        al.setCurcounty((String) checkObj.get(0)[7]);
                        al.setCurdistrict((String) checkObj.get(0)[8]);
                        al.setCurregion((String) checkObj.get(0)[9]);
                        al.setPrevlocationid((Integer) prevParishObj.get(0)[0]);
                        al.setPrevparish((String) prevParishObj.get(0)[1]);
                        al.setPrevsubcounty((String) prevParishObj.get(0)[6]);
                        al.setPrevcounty((String) prevParishObj.get(0)[7]);
                        al.setPrevdistrict((String) prevParishObj.get(0)[8]);
                        al.setPrevregion((String) prevParishObj.get(0)[9]);
                        al.setAdministered(false);
                        al.setReflevel(0);
                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));

                    }

                    model.put("saved", true);
                    model.put("successmessage", "Parish: " + request.getParameter("parishname") + " Saved Successfully");
                }
            } else {
                activity = "add";
                model.put("exists", true);
                Parish parish = new Parish();
                parish.setParishname(request.getParameter("pname"));
                logger.info("parent :::::::::::: " + request.getParameter("parent"));
                logger.info("parish name :::::::::::: " + request.getParameter("pname"));
                parish.setSubcountyid(new Subcounty(Integer.parseInt(request.getParameter("parent"))));

                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid"}, " WHERE lower(r.parishname)=:pName AND r.subcountyid.subcountyid=:scID", new String[]{"pName", "scID"}, new Object[]{request.getParameter("pname").trim().toLowerCase(), Integer.parseInt(request.getParameter("parent").trim())});
                if (object != null) {
                    activity = "addExists";
                    model.put("exists", false);
                    model.put("saved", false);
                    model.put("successmessage", "Parish: " + request.getParameter("parishname") + " Already Exists");
                } else {
                    model.put("exists", true);
                    genericClassService.saveOrUpdateRecordLoadObject(parish);
                    objectid = parish.getParishid();
                    model.put("saved", true);
                    model.put("successmessage", "Parish: " + request.getParameter("parishname") + " Saved Successfully");

                    Object[] paramValues = {objectid};
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID", params, paramValues);
                    if (checkObj != null) {

                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Parish";

                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Add");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Added New Parish");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCurparish((String) checkObj.get(0)[1]);
                        al.setCursubcounty((String) checkObj.get(0)[6]);
                        al.setCurcounty((String) checkObj.get(0)[7]);
                        al.setCurdistrict((String) checkObj.get(0)[8]);
                        al.setCurregion((String) checkObj.get(0)[9]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            model.put("exists", null);
            model.put("saved", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        model.put("activity", activity);
        return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
    }

    @RequestMapping("/addOrUpdateParish")
    @SuppressWarnings("CallToPrintStackTrace")
    public final ModelAndView addOrUpdateParish(HttpServletRequest request, @RequestParam("pID") int parishId, @RequestParam("act") String activity, Principal principal) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            Parish parish = null;
            if (activity.equals("update")) {
                String[] params = {"pID"};
                Object[] paramValues = {parishId};
                String[] fields = {};
                parish = (Parish) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID", params, paramValues).get(0);
                model.put("parish", parish);
            }
            if (activity.equals("add2")) {
                activity = "add";
                String[] params = {"pID"};
                Object[] paramValues = {parishId};
                String[] fields = {};
                parish = (Parish) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID", params, paramValues).get(0);
                Parish p2 = new Parish();
                p2.setSubcountyid(parish.getSubcountyid());
                model.put("parish", p2);
            } else {
                if (parish != null) {
                    model.put("linkClose", "ajaxSubmitData('loadParishes.htm', 'villageDivx', {scID:" + parish.getSubcountyid().getSubcountyid() + ", loc:4}, 'GET');");
                }
            }
            model.put("activity", activity);
            String[] fields = {};
            List<Region> regions = (List<Region>) genericClassService.fetchRecord(Region.class, fields, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regions);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
        }
        return new ModelAndView("controlPanel/universalPanel/location/forms/addParish", "model", model);
    }

    @RequestMapping(value = "/managesubCounty", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView managesubCounty(HttpServletRequest request, Principal principal,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            model.put("mainActivity", "Subcounty");

            if (activity.equals("a")) {
                String countyName = "";
                int subcountiesInCounty = 0;
                List<Region> regList = new ArrayList<>();
                List<District> distList = new ArrayList<>();
                List<County> countyList = new ArrayList<>();
                List<Subcounty> subcountyList = new ArrayList<>();

                List<Object[]> regionsList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, " ORDER BY r.regionname ASC", null, null);
                if (regionsList != null && !regionsList.isEmpty()) {
                    int regionid = (Integer) regionsList.get(0)[0];
                    model.put("regionid", regionid);
                    for (Object[] regObj : regionsList) {
                        Region reg = new Region();
                        reg.setRegionid((Integer) regObj[0]);
                        reg.setRegionname((String) regObj[1]);
                        regList.add(reg);
                    }

                    List<Object[]> districtsList = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.regionid.regionid=:rId ORDER BY r.districtname ASC", new String[]{"rId"}, new Object[]{regionid});
                    if (districtsList != null && !districtsList.isEmpty()) {
                        int districtid = (Integer) districtsList.get(0)[0];
                        model.put("districtid", districtid);
                        for (Object[] distObj : districtsList) {
                            District dist = new District();
                            dist.setDistrictid((Integer) distObj[0]);
                            dist.setDistrictname((String) distObj[1]);
                            distList.add(dist);
                        }

                        List<Object[]> countyArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname  ASC", new String[]{"dID"}, new Object[]{districtid});
                        if (countyArrList != null && !countyArrList.isEmpty()) {
                            int countyid = (Integer) countyArrList.get(0)[0];
                            model.put("countyid", countyid);
                            for (Object[] counObj : countyArrList) {
                                County c = new County();
                                c.setCountyid((Integer) counObj[0]);
                                c.setCountyname((String) counObj[1]);
                                countyList.add(c);
                                if (c.getCountyid() == countyid) {
                                    countyName = c.getCountyname();
                                    model.put("countyObj", c);
                                }
                            }

                            String[] params = {"cID"};
                            Object[] paramsValues = {countyid};
                            String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                            List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", params, paramsValues);
                            if (subcountyArrList != null && !subcountyArrList.isEmpty()) {
                                model.put("size", subcountyArrList.size());
                                subcountiesInCounty = subcountyArrList.size();
                            }
                            model.put("subcountyList", subcountyArrList);
                        }
                    }
                }

                int subcountiesInCountyy = genericClassService.fetchRecordCount(Subcounty.class, "", new String[]{}, new Object[]{});
                model.put("totalSubcounties", subcountiesInCountyy);

                model.put("regionsList", regList);
                model.put("districtList", distList);
                model.put("countyList", countyList);
                model.put("subCountyList", subcountyList);
                model.put("title", countyName + " - Subcounties[" + subcountiesInCounty + "]");
            }

            if (activity.equals("b")) {
                if (strVal.equals("a")) {// Load Districts
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, " WHERE r.regionid.regionid=:rID", new String[]{"rID"}, new Object[]{id});
                    model.put("districtList", districtArrObj);
                }
                if (strVal.equals("b")) {// Load Countys
                    String[] fields = {"countyid", "countyname"};
                    List<Object[]> countysArrList = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", new String[]{"dID"}, new Object[]{id});
                    model.put("countyList", countysArrList);
                }

                if (strVal.equals("c")) {// Load Sub-Countys
                    String countyName = "";
                    int subcountiesInCounty = 0;
                    String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                    List<Object[]> subcountyArrList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", new String[]{"cID"}, new Object[]{id});
                    if (subcountyArrList != null && !subcountyArrList.isEmpty()) {
                        model.put("size", subcountyArrList.size());
                        subcountiesInCounty = subcountyArrList.size();

                    }
                    List<Object[]> countysArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, " WHERE r.countyid=:cID", new String[]{"cID"}, new Object[]{id});
                    County c = new County();
                    if (countysArrObj != null && !countysArrObj.isEmpty()) {
                        for (Object[] obj : countysArrObj) {
                            c = new County((Integer) obj[0]);
                            c.setCountyname((String) obj[1]);
                        }
                    }
                    model.put("countyArrObj", c);
                    model.put("title", countyName + " - Subcounties[" + subcountiesInCounty + "]");
                    model.put("subCountyList", subcountyArrList);
                }
                return new ModelAndView("controlPanel/universalPanel/location/forms/selectsView", "model", model);
            }

            return new ModelAndView("controlPanel/universalPanel/location/view/subCountyContent", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("successmessage", "An error was encountered when processing your request, try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/view/subCountyContent", "model", model);
        }
    }

    @RequestMapping(value = "/loadParishes", method = RequestMethod.GET)
    public final ModelAndView loadParishes(@RequestParam("loc") int location, @RequestParam("scID") Long subcountyid,
            Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        String[] params = {"scID"};
        Object[] paramsValues = {subcountyid};

        String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
        List<Object[]> parishList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", params, paramsValues);
        model.put("parishList", parishList);
        model.put("size", parishList == null ? 0 : parishList.size());
        if (location == 5) {
            model.put("link", "ajaxSubmitData('loadVillages.htm', 'villageDivx', {pID: $(this).val(), loc: " + location + "}, 'GET');");
        }
        if (location == 44) {
            model.put("allData", false);
            model.put("link", "");
        }
        if (location == 55) {
            model.put("link", "ajaxSubmitData('loadVillages.htm', 'villageDivx', {pID: $(this).val(), loc: " + location + "}, 'GET');");
        }

        return new ModelAndView("controlPanel/universalPanel/location/loadParishes", "model", model);
    }

    @RequestMapping(value = "/loadVillages", method = RequestMethod.GET)
    public final ModelAndView loadVillages(@RequestParam("loc") int location, @RequestParam("pID") Long parishid,
            Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        if (location == 5) {
            String[] params = {"pID"};
            Object[] paramsValues = {parishid};

            String[] fields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
            List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.parishid.parishid=:pID ORDER BY r.villagename ASC", params, paramsValues);

            model.put("villagesList", villages);
            model.put("size", villages == null ? 0 : villages.size());

        }
        if (location == 55) {
//     
            model.put("link", "");
        }

        return new ModelAndView("controlPanel/universalPanel/location/loadVillages", "model", model);
    }

    @RequestMapping(value = "/manageLocationSelected", method = RequestMethod.GET)
    public final ModelAndView manageLocationSelected(@RequestParam("locId") long locationid, @RequestParam("act") String activity,
            @RequestParam("st") String term, @RequestParam("v2") long paramVal, Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            String[] param = {"locId"};
            Object[] paramsValue = {locationid};
            String[] facilityFields = {"locationid", "facilityid.facilityid"};
            String[] personFields = {"personid"};
            String[] villageFields = {"villageid"};
            String[] parishFields = {"parishid"};
            String[] subcountyFields = {"subcountyid"};
            String[] countyFields = {"countyid"};

            if (activity.equals("v")) {
                boolean attachments = false;
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.villageid=:locId", param, paramsValue);
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
                String[] params = {"vID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"villageid", "villagename", "parish.parishname", "parish.subcounty.subcountyname", "parish.subcounty.county.countyname", "parish.subcounty.county.district.districtname", "parish.subcounty.county.district.region.regionname"};
                List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID ORDER BY r.villagename ASC", params, paramsValues);
                if (villages != null) {
                    model.put("village", villages.get(0));
                }

                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageVillage", "model", model);
            }

            if (activity.equals("p")) {
                boolean attachments = false;
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.parishid=:locId", param, paramsValue);
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parish.parishid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }

                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
                model.put("village", village);

                String[] params = {"pID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"parishid", "parishname", "subcounty.subcountyname", "subcounty.county.countyname", "subcounty.county.district.districtname", "subcounty.county.district.region.regionname"};
                List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", params, paramsValues);
                if (villages != null) {
                    model.put("parish", villages.get(0));
                }

                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/manageParish", "model", model);
            }

            if (activity.equals("sc")) {
                boolean attachments = false;
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(com.iics.domain.Location.class, facilityFields, "WHERE r.villageid.parishid.subcountyid.subcountyid=:locId", param, paramsValue);
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

//            //Check personList1
//            List personPrevVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.previousaddress.parishid.subcountyid.subcountyid=:locId", param, paramsValue);
//            int pPrevVil=0;
//            if(personPrevVillObjList!=null && !personPrevVillObjList.isEmpty()){
//                pPrevVil=personPrevVillObjList.size();
//                attachments=true;
//            }
//            //Check personList2
//            List personLastVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.lastaddressid.parishid.subcountyid.subcountyid=:locId", param, paramsValue);
//            int pLstVil=0;
//            if(personLastVillObjList!=null && !personLastVillObjList.isEmpty()){
//                pLstVil=personLastVillObjList.size();
//                attachments=true;
//            }
                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parishid.subcountyid.subcountyid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }
                //Check ParishList
                List parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, "WHERE r.subcountyid.subcountyid=:locId", param, paramsValue);
                int parish = 0;
                if (parishObjList != null && !parishObjList.isEmpty()) {
                    parish = parishObjList.size();
                    attachments = true;
                }

                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
                model.put("village", village);
                model.put("parish", parish);

                String[] params = {"scID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                List<Object[]> subcountys = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, paramsValues);
                if (subcountys != null) {
                    model.put("subcounty", subcountys.get(0));
                }

                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageSubCounty", "model", model);
            }
            if (activity.equals("c")) {
                boolean attachments = false;
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.subcounty.county.countyid=:locId", param, paramsValue);
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parish.subcounty.county.countyid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }
                //Check ParishList
                List parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, "WHERE r.subcounty.county.countyid=:locId", param, paramsValue);
                int parish = 0;
                if (parishObjList != null && !parishObjList.isEmpty()) {
                    parish = parishObjList.size();
                    attachments = true;
                }
                //Check Sub-County List
                List subCountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, "WHERE r.county.countyid=:locId", param, paramsValue);
                int subcounty = 0;
                if (subCountyObjList != null && !subCountyObjList.isEmpty()) {
                    subcounty = subCountyObjList.size();
                    attachments = true;
                }

                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
                model.put("village", village);
                model.put("parish", parish);
                model.put("subcounty", subcounty);

                String[] params = {"cID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"countyid", "countyname", "district.districtname", "district.region.regionname"};
                List<Object[]> countys = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", params, paramsValues);
                if (countys != null) {
                    model.put("county", countys.get(0));
                }

                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/manageCounty", "model", model);
            }
            if (activity.equals("d")) {
                boolean attachments = false;
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.subcounty.county.district.districtid=:locId", param, paramsValue);
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parish.subcounty.county.district.districtid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }
                //Check ParishList
                List parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, "WHERE r.subcounty.county.district.districtid=:locId", param, paramsValue);
                int parish = 0;
                if (parishObjList != null && !parishObjList.isEmpty()) {
                    parish = parishObjList.size();
                    attachments = true;
                }
                //Check Sub-County List
                List subCountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, "WHERE r.county.district.districtid=:locId", param, paramsValue);
                int subcounty = 0;
                if (subCountyObjList != null && !subCountyObjList.isEmpty()) {
                    subcounty = subCountyObjList.size();
                    attachments = true;
                }
                //Check County List
                List countyObjList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, "WHERE r.district.districtid=:locId", param, paramsValue);
                int county = 0;
                if (countyObjList != null && !countyObjList.isEmpty()) {
                    county = countyObjList.size();
                    attachments = true;
                }
                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
                model.put("village", village);
                model.put("parish", parish);
                model.put("subcounty", subcounty);
                model.put("county", county);

                String[] params = {"dID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"districtid", "districtname", "region.regionname"};
                List<Object[]> districts = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", params, paramsValues);
                if (districts != null) {
                    model.put("district", districts.get(0));
                }

                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrict", "model", model);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
    }

//    @RequestMapping(value = "/loadLocationAttachment.htm", method = RequestMethod.GET)
//    @SuppressWarnings("CallToPrintStackTrace")
//    public final ModelAndView loadLocationAttachment(@RequestParam("act") String activity, @RequestParam("st") String term, 
//    @RequestParam("v1") long locationid, @RequestParam("v2") String strVal, Principal principal, HttpServletRequest request) {
//        if (principal == null) {
//            return new ModelAndView("login");
//        }
//        Map<String, Object> model = new HashMap<String, Object>();
//        try {
//        model.put("activity", activity);
//        model.put("term", term);
//        
//        String[] param = {"locId"};
//        Object[] paramsValue = {locationid};
//        String[] facilityFields = {"locationid","facility.facilityid","facility.facilitycode","facility.facilityname","facility.facilitylevel.facilitylevelname","facility.facilitylevel.shortname","facility.facilityowner.ownername"};
//        String[] personFields = {"personid","firstname","lastname","othernames","gender","dob","nationality",
//            "fathersfirstname","fatherslastname","fathersothernames","mothersfirstname","motherslastname","mothersothernames"};
//        String[] nokFields = {"nextofkinid","fullname","person.firstname","person.lastname","person.othernames","person.gender","person.dob","person.nationality",
//            "person.fathersfirstname","person.fatherslastname","person.fathersothernames","person.mothersfirstname","person.motherslastname","person.mothersothernames"};
//        String[] extOrdFields = {"externalorganizationid","facilitycode","organizationname","isuniversalorg","goodssupplier","servicessuplier"};
//        String[] villageFields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
//        String[] parishFields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
//        String[] subcountyFields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
//        String[] countyFields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
//        
//        if(activity.equals("v")){
//            String[] params = {"vID"};
//            Object[] paramsValues = {locationid};
//            String[] fields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parish.subcounty.county.countyname", "parish.subcounty.county.district.districtname", "parish.subcounty.county.district.region.regionname"};
//            List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID ORDER BY r.villagename ASC", params, paramsValues);
//            if(villages!=null){
//                model.put("location", villages.get(0));
//            }
//            
//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.villageid=:locId ORDER BY r.facility.facilityname ASC", param, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facility Under "+villages.get(0)[1]+" Village, "+villages.get(0)[4]+" County In "+villages.get(0)[5]+" District.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
//            
//            
//            //Check personList
//            if(term.equals("curVillage")){
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.village.villageid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                    if(personCurVillObjList!=null && !personCurVillObjList.isEmpty()){
//                        model.put("size", personCurVillObjList.size());
//                    }
//                model.put("locationTitle", "Manage Person Currently Under "+villages.get(0)[1]+" Village, "+villages.get(0)[4]+" County In "+villages.get(0)[5]+" District.");    
//                model.put("personList", personCurVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//           
//            //Check personList2
//            if(term.equals("lastVillage")){
//                List personLastVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.lastaddress.villageid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                if(personLastVillObjList!=null && !personLastVillObjList.isEmpty()){
//                    model.put("size", personLastVillObjList.size());
//                }
//               model.put("locationTitle", "Manage Person Previously Under "+villages.get(0)[1]+" Village, "+villages.get(0)[4]+" County In "+villages.get(0)[5]+" District.");    
//               model.put("personList", personLastVillObjList);
//               return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//                    
//        }
//        
//        if(activity.equals("p")){
//            String[] params = {"pID"};
//            Object[] paramsValues = {locationid};
//            String[] fields = {"parishid", "parishname", "subcounty.subcountyname", "subcounty.county.countyname", "subcounty.county.district.districtname", "subcounty.county.district.region.regionname"};
//            List<Object[]> parish = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", params, paramsValues);
//            if(parish!=null){
//                model.put("location", parish.get(0));
//            }
//            
//            //Check VillageList
//            if(term.equals("village")){
//                List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parish.parishid=:pID ORDER BY r.villagename ASC", params, paramsValues);
//                if(villageObjList!=null && !villageObjList.isEmpty()){
//                    model.put("size", villageObjList.size());
//                }
//                model.put("locationTitle", "Manage Villages Under "+parish.get(0)[1]+" Parish, "+parish.get(0)[3]+" County In "+parish.get(0)[4]+" District.");
//                model.put("villageList", villageObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageParishVillage", "model", model);
//            }
//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.parishid=:locId ORDER BY r.facility.facilityname ASC", param, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facilities Under "+parish.get(0)[1]+" Parish, "+parish.get(0)[3]+" County In "+parish.get(0)[4]+" District.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
//            
//            //Check nextofkinList
//            if(term.equals("nok")){
//                List nextOfKinObjList = (List<Object[]>) genericClassService.fetchRecord(Nextofkin.class, nokFields, "WHERE r.village.parish.parishid=:locId ORDER BY r.fullname ASC", param, paramsValue);
//                if(nextOfKinObjList!=null && !nextOfKinObjList.isEmpty()){
//                    model.put("size", nextOfKinObjList.size());
//                }
//                model.put("locationTitle", "Manage Next of Kins Under "+parish.get(0)[1]+" Parish, "+parish.get(0)[3]+" County In "+parish.get(0)[4]+" District.");
//                model.put("nokList", nextOfKinObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageNOK", "model", model);
//            }
//            //Check personList
//            if(term.equals("curVillage")){
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.village.parish.parishid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                    if(personCurVillObjList!=null && !personCurVillObjList.isEmpty()){
//                        model.put("size", personCurVillObjList.size());
//                    }
//                model.put("locationTitle", "Manage Person Currently Under "+parish.get(0)[1]+" Parish, "+parish.get(0)[3]+" County In "+parish.get(0)[4]+" District.");
//                model.put("personList", personCurVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList1
//            if(term.equals("prevVillage")){
//                List personPrevVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.previousaddress.parish.parishid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                if(personPrevVillObjList!=null && !personPrevVillObjList.isEmpty()){
//                    model.put("size", personPrevVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Recently Under "+parish.get(0)[1]+" Parish, "+parish.get(0)[3]+" County In "+parish.get(0)[4]+" District.");
//                model.put("personList", personPrevVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList2
//            if(term.equals("lastVillage")){
//                List personLastVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.lastaddress.parish.parishid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                if(personLastVillObjList!=null && !personLastVillObjList.isEmpty()){
//                    model.put("size", personLastVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Previously Under "+parish.get(0)[1]+" Parish, "+parish.get(0)[3]+" County In "+parish.get(0)[4]+" District.");
//                model.put("personList", personLastVillObjList);
//               return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//                    
//        }
//        
//        if(activity.equals("sc")){
//            String[] params = {"scID"};
//            Object[] paramsValues = {locationid};
//            String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
//            List<Object[]> subcounty = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, paramsValues);
//            if(subcounty!=null){
//                model.put("location", subcounty.get(0));
//            }
//            
//            //Check VillageList
//            if(term.equals("village")){
//                List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parishid.subcountyid.subcountyid=:scID ORDER BY r.villagename ASC", params, paramsValues);
//                if(villageObjList!=null && !villageObjList.isEmpty()){
//                    model.put("size", villageObjList.size());
//                }
//                model.put("locationTitle", "Manage Villages Under Sub-County "+subcounty.get(0)[1]+", "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("villageList", villageObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageSubCountyVillage", "model", model);
//            }
//            
//            //Check ParishList
//            if(term.equals("parish")){
//                List<Object[]> parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", params, paramsValues);
//                if(parishObjList!=null && !parishObjList.isEmpty()){
//                    model.put("size", parishObjList.size());
//                }
//                model.put("locationTitle", "Manage Parishes Under Sub-County "+subcounty.get(0)[1]+", "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("parishList", parishObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageSubCountyParish", "model", model);
//            }
//            
//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.villageid.parishid.subcountyid.subcountyid=:locId ORDER BY r.facilityid.facilityname ASC", param, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facilities Under "+subcounty.get(0)[1]+" Sub-County, "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
//            
//            
//            //Check personList
//            if(term.equals("curVillage")){
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.village.parish.subcounty.subcountyid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                    if(personCurVillObjList!=null && !personCurVillObjList.isEmpty()){
//                        model.put("size", personCurVillObjList.size());
//                    }
//                model.put("locationTitle", "Manage Person Currently Under "+subcounty.get(0)[1]+" Sub-County, "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("personList", personCurVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList1
//            if(term.equals("prevVillage")){
//                List personPrevVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.previousaddress.parish.subcounty.subcountyid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                if(personPrevVillObjList!=null && !personPrevVillObjList.isEmpty()){
//                    model.put("size", personPrevVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Recently Under "+subcounty.get(0)[1]+" Sub-County, "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("personList", personPrevVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList2
//            if(term.equals("lastVillage")){
//                List personLastVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.lastaddress.parish.subcounty.subcountyid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
//                if(personLastVillObjList!=null && !personLastVillObjList.isEmpty()){
//                    model.put("size", personLastVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Previously Under "+subcounty.get(0)[1]+" Sub-County, "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("personList", personLastVillObjList);
//               return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//                 
//        }
//        
//        if(activity.equals("c")){
//            String[] params = {"cID"};
//            Object[] paramsValues = {locationid};
//            String[] fields = {"countyid", "countyname", "district.districtname", "district.region.regionname"};
//            List<Object[]> county = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", params, paramsValues);
//            if(county!=null){
//                model.put("location", county.get(0));
//            }
//            
//            //Check VillageList
//            if(term.equals("village")){
//                List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parish.subcounty.county.countyid=:cID ORDER BY r.villagename ASC", params, paramsValues);
//                if(villageObjList!=null && !villageObjList.isEmpty()){
//                    model.put("size", villageObjList.size());
//                }
//                model.put("locationTitle", "Manage Villages Under County "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("villageList", villageObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageCountyVillage", "model", model);
//            }
//            
//            //Check ParishList
//            if(term.equals("parish")){
//                List<Object[]> parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, " WHERE r.subcounty.county.countyid=:cID ORDER BY r.parishname ASC", params, paramsValues);
//                if(parishObjList!=null && !parishObjList.isEmpty()){
//                    model.put("size", parishObjList.size());
//                }
//                model.put("locationTitle", "Manage Parishes Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("parishList", parishObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageCountyParish", "model", model);
//            }
//            
//            //Check SubcountyList
//            if(term.equals("subcounty")){
//                List<Object[]> subcountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", params, paramsValues);
//                if(subcountyObjList!=null && !subcountyObjList.isEmpty()){
//                    model.put("size", subcountyObjList.size());
//                }
//                model.put("locationTitle", "Manage Sub-Counties Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("subcountyList", subcountyObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageCountySubCounty", "model", model);
//            }
//            
//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.subcounty.county.countyid=:cID ORDER BY r.facility.facilityname ASC", params, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facilities Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
//            
//            //Check nextofkinList
//            if(term.equals("nok")){
//                List nextOfKinObjList = (List<Object[]>) genericClassService.fetchRecord(Nextofkin.class, nokFields, "WHERE r.village.parish.subcounty.county.countyid=:cID ORDER BY r.fullname ASC", params, paramsValue);
//                if(nextOfKinObjList!=null && !nextOfKinObjList.isEmpty()){
//                    model.put("size", nextOfKinObjList.size());
//                }
//                model.put("locationTitle", "Manage Next of Kins Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("nokList", nextOfKinObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageNOK", "model", model);
//            }
//            //Check personList
//            if(term.equals("curVillage")){
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.village.parish.subcounty.county.countyid=:cID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
//                    if(personCurVillObjList!=null && !personCurVillObjList.isEmpty()){
//                        model.put("size", personCurVillObjList.size());
//                    }
//                model.put("locationTitle", "Manage Person Currently Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("personList", personCurVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList1
//            if(term.equals("prevVillage")){
//                List personPrevVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.previousaddress.parish.subcounty.county.countyid=:cID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
//                if(personPrevVillObjList!=null && !personPrevVillObjList.isEmpty()){
//                    model.put("size", personPrevVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Recently Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("personList", personPrevVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList2
//            if(term.equals("lastVillage")){
//                List personLastVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.lastaddress.parish.subcounty.county.countyid=:cID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
//                if(personLastVillObjList!=null && !personLastVillObjList.isEmpty()){
//                    model.put("size", personLastVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Previously Under County: "+county.get(0)[1]+", "+county.get(0)[2]+" District In "+county.get(0)[3]+" Region.");
//                model.put("personList", personLastVillObjList);
//               return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//                       
//        }
//        
//        if(activity.equals("d")){
//            String[] params = {"dID"};
//            Object[] paramsValues = {locationid};
//            String[] fields = {"districtid", "districtname", "region.regionname"};
//            List<Object[]> district = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", params, paramsValues);
//            if(district!=null){
//                model.put("location", district.get(0));
//            }
//            
//            //Check VillageList
//            if(term.equals("village")){
//                List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parish.subcounty.county.district.districtid=:dID ORDER BY r.villagename ASC", params, paramsValues);
//                if(villageObjList!=null && !villageObjList.isEmpty()){
//                    model.put("size", villageObjList.size());
//                }
//                model.put("locationTitle", "Manage Villages Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("villageList", villageObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrictVillage", "model", model);
//            }
//            
//            //Check ParishList
//            if(term.equals("parish")){
//                List<Object[]> parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, " WHERE r.subcounty.county.district.districtid=:dID ORDER BY r.parishname ASC", params, paramsValues);
//                if(parishObjList!=null && !parishObjList.isEmpty()){
//                    model.put("size", parishObjList.size());
//                }
//                model.put("locationTitle", "Manage Parishes Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("parishList", parishObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrictParish", "model", model);
//            }
//            
//            //Check SubcountyList
//            if(term.equals("subcounty")){
//                List<Object[]> subcountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, " WHERE r.county.district.districtid=:dID ORDER BY r.subcountyname ASC", params, paramsValues);
//                if(subcountyObjList!=null && !subcountyObjList.isEmpty()){
//                    model.put("size", subcountyObjList.size());
//                }
//                model.put("locationTitle", "Manage Sub-Counties Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("subcountyList", subcountyObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/manageDistrictSubCounty", "model", model);
//            }
//            
//            //Check CountyList
//            if(term.equals("county")){
//                List<Object[]> countyObjList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, " WHERE r.district.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);
//                if(countyObjList!=null && !countyObjList.isEmpty()){
//                    model.put("size", countyObjList.size());
//                }
//                model.put("locationTitle", "Manage Counties Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("countyList", countyObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/manageDistrictCounty", "model", model);
//            }
//            
//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.subcounty.county.district.districtid=:dID ORDER BY r.facility.facilityname ASC", params, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facilities Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
//            
//            //Check nextofkinList
//            if(term.equals("nok")){
//                List nextOfKinObjList = (List<Object[]>) genericClassService.fetchRecord(Nextofkin.class, nokFields, "WHERE r.village.parish.subcounty.county.district.districtid=:dID ORDER BY r.fullname ASC", params, paramsValue);
//                if(nextOfKinObjList!=null && !nextOfKinObjList.isEmpty()){
//                    model.put("size", nextOfKinObjList.size());
//                }
//                model.put("locationTitle", "Manage Next of Kins Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("nokList", nextOfKinObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageNOK", "model", model);
//            }
//            //Check personList
//            if(term.equals("curVillage")){
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.village.parish.subcounty.county.district.districtid=:dID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
//                    if(personCurVillObjList!=null && !personCurVillObjList.isEmpty()){
//                        model.put("size", personCurVillObjList.size());
//                    }
//                model.put("locationTitle", "Manage Person Currently Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("personList", personCurVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList1
//            if(term.equals("prevVillage")){
//                List personPrevVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.previousaddress.parish.subcounty.county.district.districtid=:dID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
//                if(personPrevVillObjList!=null && !personPrevVillObjList.isEmpty()){
//                    model.put("size", personPrevVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Recently Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("personList", personPrevVillObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//            //Check personList2
//            if(term.equals("lastVillage")){
//                List personLastVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.lastaddress.parish.subcounty.county.district.districtid=:dID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
//                if(personLastVillObjList!=null && !personLastVillObjList.isEmpty()){
//                    model.put("size", personLastVillObjList.size());
//                }
//                model.put("locationTitle", "Manage Person Previously Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("personList", personLastVillObjList);
//               return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
//            }
//                  
//        }
//            
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            model.put("successmessage", "Error Occured!");
//        }
//        return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
//    }
    @RequestMapping(value = "/manageSelectedLoc", method = RequestMethod.GET)
    public final ModelAndView manageSelectedLocObj(@RequestParam("id") long locationid, @RequestParam("act") String activity,
            @RequestParam("st") String term, @RequestParam("v2") long paramVal, Principal principal, HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            String[] param = {"locId"};
            Object[] paramsValue = {locationid};
            String[] facilityFields = {"facilityid"};
            String[] personFields = {"personid"};
            String[] nokFields = {"person.personid"};
            String[] villageFields = {"villageid"};
            String[] parishFields = {"parishid"};
            String[] subcountyFields = {"subcountyid"};
            String[] countyFields = {"countyid"};

            model.put("locId", locationid);

            if (activity.equals("v")) {
                boolean attachments = false;

                String[] fields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
                List<Object[]> villageArrObj = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, "  WHERE r.villageid=:vID ORDER BY r.villagename ASC", new String[]{"vID"}, new Object[]{locationid});
                if (villageArrObj != null) {
                    model.put("villageObjc", villageArrObj.get(0));
                }
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.villageid.villageid=:id", new String[]{"id"}, new Object[]{locationid});
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

//                //Check personList
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.currentaddress.villageid=:locId", param, paramsValue);
//                int pCurVil = 0;
//                if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
//                    pCurVil = personCurVillObjList.size();
//                    attachments = true;
//                }
                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
//                model.put("pCurVil", pCurVil);

                String[] params = {"vID"};
                Object[] paramsValues = {locationid};
                List<Object[]> facilities = (List<Object[]>) genericClassService.fetchRecord(Location.class, fields, " WHERE r.villageid.villageid=:vID ORDER BY r.facilityname ASC", params, paramsValues);
                if (facilities != null) {
                    model.put("facility", facilities.get(0));
                }

                model.put("activity", activity);
                model.put("scope", term);
                return new ModelAndView("controlPanel/universalPanel/location/forms/manageVillage", "model", model);
            }

            if (activity.equals("p")) {
                boolean attachments = false;
                String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                List<Object[]> parishArrObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", new String[]{"pID"}, new Object[]{locationid});
                if (parishArrObj != null) {
                    model.put("parishObj", parishArrObj.get(0));
                }
                //Check locationList/Facilities
                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facilityFields, "WHERE r.village.parishid.parishid=:locId", param, paramsValue);
                int facility = 0;
                if (facilityObjList != null && !facilityObjList.isEmpty()) {
                    facility = facilityObjList.size();
                    attachments = true;
                }

                //Check personList
                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.currentaddress.parishid.parishid=:locId", param, paramsValue);
                int pCurVil = 0;
                if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
                    pCurVil = personCurVillObjList.size();
                    attachments = true;
                }

                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parishid.parishid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }

                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("facility", facility);
                model.put("pCurVil", pCurVil);
                model.put("village", village);

                String[] params = {"pID"};
                Object[] paramsValues = {locationid};
                List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", params, paramsValues);
                if (villages != null) {
                    model.put("parish", villages.get(0));
                }
                model.put("scope", term);
                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/forms/manageParish", "model", model);
            }

            if (activity.equals("sc")) {
                boolean attachments = false;
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};

                List<Object[]> subcountyArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", new String[]{"scID"}, new Object[]{locationid});
                if (subcountyArrObj != null) {
                    model.put("subcountyObj", subcountyArrObj.get(0));
                }
//                //Check locationList/Facilities
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facilityFields, "WHERE r.village.parishid.parishid=:locId", param, paramsValue);
//                int facility = 0;
//                if (facilityObjList != null && !facilityObjList.isEmpty()) {
//                    facility = facilityObjList.size();
//                    attachments = true;
//                    logger.info("0-----------" +facilityObjList.size());
//                }
                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parishid.subcountyid.subcountyid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                    logger.info("uuuuuuuu-----------" + villageObjList.size());
                }

                //Check ParishList
                List parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, "WHERE r.subcountyid.subcountyid=:locId", param, paramsValue);
                int parish = 0;
                if (parishObjList != null && !parishObjList.isEmpty()) {
                    parish = parishObjList.size();
                    attachments = true;

                }
                logger.info("attachments-----------" + attachments);
                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
//                model.put("facility", facility);
                model.put("village", village);
                model.put("parish", parish);

                String[] params = {"scID"};
                Object[] paramsValues = {locationid};
                List<Object[]> parishes = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, paramsValues);
                if (parishes != null) {
                    model.put("subcounty", parishes.get(0));
                }
                model.put("scope", term);
                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageSubCounty", "model", model);
            }

            if (activity.equals("c")) {
                boolean attachments = false;
                String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                List<Object[]> countyArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", new String[]{"cID"}, new Object[]{locationid});
                if (countyArrObj != null) {
                    model.put("countyObj", countyArrObj.get(0));
                }

                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parishid.subcountyid.countyid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }
                //Check ParishList
                List parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, "WHERE r.subcountyid.countyid=:locId", param, paramsValue);
                int parish = 0;
                if (parishObjList != null && !parishObjList.isEmpty()) {
                    parish = parishObjList.size();
                    attachments = true;
                }
                //Check Sub-County List
                List subCountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, "WHERE r.countyid.countyid=:locId", param, paramsValue);
                int subcounty = 0;
                if (subCountyObjList != null && !subCountyObjList.isEmpty()) {
                    subcounty = subCountyObjList.size();
                    attachments = true;
                }

                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
                model.put("village", village);
                model.put("parish", parish);
                model.put("subcounty", subcounty);

                String[] params = {"cID"};
                Object[] paramsValues = {locationid};
//            String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                List<Object[]> subcounties = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", params, paramsValues);
                if (subcounties != null) {
                    model.put("county", subcounties.get(0));
                }
                model.put("scope", term);
                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/forms/manageCounty", "model", model);
            }
            if (activity.equals("d")) {
                boolean attachments = false;
                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", new String[]{"dID"}, new Object[]{locationid});
                if (districtArrObj != null) {
                    model.put("districtObj", districtArrObj.get(0));
                }
//                //Check locationList/Facilities
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.subcounty.county.district.districtid=:locId", param, paramsValue);
//                int facility = 0;
//                if (facilityObjList != null && !facilityObjList.isEmpty()) {
//                    facility = facilityObjList.size();
//                    attachments = true;
//                }

//                //Check personList
//                List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.village.parish.subcounty.county.district.districtid=:locId", param, paramsValue);
//                int pCurVil = 0;
//                if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
//                    pCurVil = personCurVillObjList.size();
//                    attachments = true;
//                }
                //Check VillageList
                List villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, "WHERE r.parishid.subcountyid.countyid.districtid.districtid=:locId", param, paramsValue);
                int village = 0;
                if (villageObjList != null && !villageObjList.isEmpty()) {
                    village = villageObjList.size();
                    attachments = true;
                }
                //Check ParishList
                List parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, "WHERE r.subcountyid.countyid.districtid.districtid=:locId", param, paramsValue);
                int parish = 0;
                if (parishObjList != null && !parishObjList.isEmpty()) {
                    parish = parishObjList.size();
                    attachments = true;
                }
                //Check Sub-County List
                List subCountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, "WHERE r.countyid.districtid.districtid=:locId", param, paramsValue);
                int subcounty = 0;
                if (subCountyObjList != null && !subCountyObjList.isEmpty()) {
                    subcounty = subCountyObjList.size();
                    attachments = true;
                }
                //Check County List
                List countyObjList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, "WHERE r.districtid.districtid=:locId", param, paramsValue);
                int county = 0;
                if (countyObjList != null && !countyObjList.isEmpty()) {
                    county = countyObjList.size();
                    attachments = true;
                }
                //Check facilityexternalsupplierList
                model.put("attachments", attachments);
//                model.put("facility", facility);
//                model.put("pCurVil", pCurVil);
                model.put("village", village);
                model.put("parish", parish);
                model.put("subcounty", subcounty);
                model.put("county", county);

                String[] params = {"dID"};
                Object[] paramsValues = {locationid};
                List<Object[]> districts = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", params, paramsValues);
                if (districts != null) {
                    model.put("district", districts.get(0));
                }
                model.put("scope", term);
                model.put("activity", activity);
                return new ModelAndView("controlPanel/universalPanel/location/forms/manageDistrict", "model", model);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("deleted", false);
            model.put("successmessage", "An error occurred, contact admin");
        }
        return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
    }

    @RequestMapping(value = "/loadLocationAttachment", method = RequestMethod.GET)
    @SuppressWarnings("CallToPrintStackTrace")
    public final ModelAndView loadLocationAttachment(@RequestParam("act") String activity, @RequestParam("st") String term,
            @RequestParam("v1") long locationid, @RequestParam("v2") String strVal, Principal principal, HttpServletRequest request) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("activity", activity);
            model.put("term", term);

            String[] param = {"locId"};
            Object[] paramsValue = {locationid};
            String[] facilityFields = {"facilityid", "facilitycode", "facilityname", "facilitylevelid.facilitylevelname", "facilitylevelid.shortname"};
            String[] personFields = {"personid", "firstname", "lastname", "othernames", "gender", "dob", "nationality", "currentaddress.villagename"};
            String[] villageFields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
            String[] parishFields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
            String[] subcountyFields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
            String[] countyFields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};

            if (activity.equals("v")) {
                String[] params = {"vID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"villageid", "villagename", "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
                List<Object[]> villages = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, " WHERE r.villageid=:vID ORDER BY r.villagename ASC", params, paramsValues);
                if (villages != null) {
                    model.put("location", villages.get(0));
                }

                //Check locationList/Facilities
                if (term.equals("facility")) {
                    List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facilityFields, "WHERE r.village.villageid=:locId ORDER BY r.facilityname ASC", param, paramsValue);
                    if (facilityObjList != null && !facilityObjList.isEmpty()) {
                        model.put("size", facilityObjList.size());
                    }
                    model.put("locationTitle", "Manage Facility Under " + villages.get(0)[1] + " Village, " + villages.get(0)[4] + " County In " + villages.get(0)[5] + " District.");
                    model.put("facilityList", facilityObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
                }

                //Check personList
                if (term.equals("curVillage")) {
                    List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.currentaddress.villageid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
                    if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
                        model.put("size", personCurVillObjList.size());
                    }
                    model.put("locationTitle", "Manage Person Currently Under " + villages.get(0)[1] + " Village, " + villages.get(0)[4] + " County In " + villages.get(0)[5] + " District.");
                    model.put("personList", personCurVillObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
                }
            }

            if (activity.equals("p")) {
                String[] params = {"pID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                List<Object[]> parish = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, "WHERE r.parishid=:pID ORDER BY r.parishname ASC", params, paramsValues);
                if (parish != null) {
                    model.put("location", parish.get(0));
                }

                //Check VillageList
                if (term.equals("village")) {
                    List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parishid.parishid=:pID ORDER BY r.villagename ASC", params, paramsValues);
                    if (villageObjList != null && !villageObjList.isEmpty()) {
                        model.put("size", villageObjList.size());
                    }
                    model.put("locationTitle", "Manage Villages Under " + parish.get(0)[1] + " Parish, " + parish.get(0)[3] + " County In " + parish.get(0)[4] + " District.");
                    model.put("villageList", villageObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageParishVillage", "model", model);
                }
                //Check locationList/Facilities
                if (term.equals("facility")) {
                    List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facilityFields, "WHERE r.village.parishid.parishid=:locId ORDER BY r.facilityname ASC", param, paramsValue);
                    if (facilityObjList != null && !facilityObjList.isEmpty()) {
                        model.put("size", facilityObjList.size());
                    }
                    model.put("locationTitle", "Manage Facilities Under " + parish.get(0)[1] + " Parish, " + parish.get(0)[3] + " County In " + parish.get(0)[4] + " District.");
                    model.put("facilityList", facilityObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
                }

                //Check personList
                if (term.equals("curVillage")) {
                    List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.currentaddress.parishid.parishid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
                    if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
                        model.put("size", personCurVillObjList.size());
                    }
                    model.put("locationTitle", "Manage Person Currently Under " + parish.get(0)[1] + " Parish, " + parish.get(0)[3] + " County In " + parish.get(0)[4] + " District.");
                    model.put("personList", personCurVillObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
                }
            }
            if (activity.equals("sc")) {
                String[] params = {"scID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                List<Object[]> subcounty = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, paramsValues);
                if (subcounty != null) {
                    model.put("location", subcounty.get(0));
                }

                //Check VillageList
                if (term.equals("village")) {
                    List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parishid.subcountyid.subcountyid=:scID ORDER BY r.villagename ASC", params, paramsValues);
                    logger.info("Here -----------------------lstArr" + villageObjList.size());
                    if (villageObjList != null && !villageObjList.isEmpty()) {
                        model.put("size", villageObjList.size());
                    }
                    model.put("locationTitle", "Manage Villages Under Sub-County " + subcounty.get(0)[1] + ", " + subcounty.get(0)[2] + " County In " + subcounty.get(0)[3] + " District.");
                    model.put("villageList", villageObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageSubCountyVillage", "model", model);
                }

                //Check ParishList
                if (term.equals("parish")) {
                    List<Object[]> parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, " WHERE r.subcountyid.subcountyid=:scID ORDER BY r.parishname ASC", params, paramsValues);
                    if (parishObjList != null && !parishObjList.isEmpty()) {
                        model.put("size", parishObjList.size());
                    }
                    model.put("locationTitle", "Manage Parishes Under Sub-County " + subcounty.get(0)[1] + ", " + subcounty.get(0)[2] + " County In " + subcounty.get(0)[3] + " District.");
                    model.put("parishList", parishObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageSubCountyParish", "model", model);
                }

//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.village.parish.subcounty.subcountyid=:locId ORDER BY r.facility.facilityname ASC", param, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facilities Under "+subcounty.get(0)[1]+" Sub-County, "+subcounty.get(0)[2]+" County In "+subcounty.get(0)[3]+" District.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
                //Check personList
                if (term.equals("curVillage")) {
                    List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.villageid.parishid.subcountyid.subcountyid=:locId ORDER BY r.firstname,r.lastname,r.othernames ASC", param, paramsValue);
                    if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
                        model.put("size", personCurVillObjList.size());
                    }
                    model.put("locationTitle", "Manage Person Currently Under " + subcounty.get(0)[1] + " Sub-County, " + subcounty.get(0)[2] + " County In " + subcounty.get(0)[3] + " District.");
                    model.put("personList", personCurVillObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
                }
            }
            if (activity.equals("c")) {
                String[] params = {"cID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                List<Object[]> county = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", params, paramsValues);
                if (county != null) {
                    model.put("location", county.get(0));
                }

                //Check VillageList
                if (term.equals("village")) {
                    List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parishid.subcountyid.countyid.countyid=:cID ORDER BY r.villagename ASC", params, paramsValues);
                    if (villageObjList != null && !villageObjList.isEmpty()) {
                        model.put("size", villageObjList.size());
                    }
                    model.put("locationTitle", "Manage Villages Under County " + county.get(0)[1] + ", " + county.get(0)[2] + " District In " + county.get(0)[3] + " Region.");
                    model.put("villageList", villageObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageCountyVillage", "model", model);
                }

                //Check ParishList
                if (term.equals("parish")) {
                    List<Object[]> parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, " WHERE r.subcountyid.countyid.countyid=:cID ORDER BY r.parishname ASC", params, paramsValues);
                    if (parishObjList != null && !parishObjList.isEmpty()) {
                        model.put("size", parishObjList.size());
                    }
                    model.put("locationTitle", "Manage Parishes Under County: " + county.get(0)[1] + ", " + county.get(0)[2] + " District In " + county.get(0)[3] + " Region.");
                    model.put("parishList", parishObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageCountyParish", "model", model);
                }

                //Check SubcountyList
                if (term.equals("subcounty")) {
                    List<Object[]> subcountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, " WHERE r.countyid.countyid=:cID ORDER BY r.subcountyname ASC", params, paramsValues);
                    if (subcountyObjList != null && !subcountyObjList.isEmpty()) {
                        model.put("size", subcountyObjList.size());
                    }
                    model.put("locationTitle", "Manage Sub-Counties Under County: " + county.get(0)[1] + ", " + county.get(0)[2] + " District In " + county.get(0)[3] + " Region.");
                    model.put("subcountyList", subcountyObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageCountySubCounty", "model", model);
                }

//                //Check locationList/Facilities
//                if (term.equals("facility")) {
//                    List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.villageid.parishid.subcountyid.countyid.countyid=:cID ORDER BY r.facilityid.facilityname ASC", params, paramsValue);
//                    if (facilityObjList != null && !facilityObjList.isEmpty()) {
//                        model.put("size", facilityObjList.size());
//                    }
//                    model.put("locationTitle", "Manage Facilities Under County: " + county.get(0)[1] + ", " + county.get(0)[2] + " District In " + county.get(0)[3] + " Region.");
//                    model.put("facilityList", facilityObjList);
//                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//                }
                //Check personList
                if (term.equals("curVillage")) {
                    List personCurVillObjList = (List<Object[]>) genericClassService.fetchRecord(Person.class, personFields, "WHERE r.villageid.parishid.subcountyid.countyid.countyid=:cID ORDER BY r.firstname,r.lastname,r.othernames ASC", params, paramsValue);
                    if (personCurVillObjList != null && !personCurVillObjList.isEmpty()) {
                        model.put("size", personCurVillObjList.size());
                    }
                    model.put("locationTitle", "Manage Person Currently Under County: " + county.get(0)[1] + ", " + county.get(0)[2] + " District In " + county.get(0)[3] + " Region.");
                    model.put("personList", personCurVillObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/managePerson", "model", model);
                }
            }
            if (activity.equals("d")) {
                String[] params = {"dID"};
                Object[] paramsValues = {locationid};
                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> district = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", params, paramsValues);
                if (district != null) {
                    model.put("location", district.get(0));
                }
                //Check CountyList
                if (term.equals("county")) {
                    List<Object[]> countyObjList = (List<Object[]>) genericClassService.fetchRecord(County.class, countyFields, " WHERE r.districtid.districtid=:dID ORDER BY r.countyname ASC", params, paramsValues);
                    if (countyObjList != null && !countyObjList.isEmpty()) {
                        model.put("size", countyObjList.size());
                    }
                    model.put("locationTitle", "Manage Counties Under District: " + district.get(0)[1] + ", " + district.get(0)[2] + " Region.");
                    model.put("countyList", countyObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrictCounty", "model", model);
                }

                //Check SubcountyList
                if (term.equals("subcounty")) {
                    List<Object[]> subcountyObjList = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subcountyFields, " WHERE r.countyid.districtid.districtid=:dID ORDER BY r.subcountyname ASC", params, paramsValues);
                    if (subcountyObjList != null && !subcountyObjList.isEmpty()) {
                        model.put("size", subcountyObjList.size());
                    }
                    model.put("locationTitle", "Manage Sub-Counties Under District: " + district.get(0)[1] + ", " + district.get(0)[2] + " Region.");
                    model.put("subcountyList", subcountyObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrictSubCounty", "model", model);
                }

                //Check VillageList
                if (term.equals("village")) {
                    List<Object[]> villageObjList = (List<Object[]>) genericClassService.fetchRecord(Village.class, villageFields, " WHERE r.parishid.subcountyid.countyid.districtid.districtid=:dID ORDER BY r.villagename ASC", params, paramsValues);
                    if (villageObjList != null && !villageObjList.isEmpty()) {
                        model.put("size", villageObjList.size());
                    }
                    model.put("locationTitle", "Manage Villages Under District: " + district.get(0)[1] + ", " + district.get(0)[2] + " Region.");
                    model.put("villageList", villageObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrictVillage", "model", model);
                }
                //Check ParishList
                if (term.equals("parish")) {
                    List<Object[]> parishObjList = (List<Object[]>) genericClassService.fetchRecord(Parish.class, parishFields, " WHERE r.subcountyid.countyid.districtid.districtid=:dID ORDER BY r.parishname ASC", params, paramsValues);
                    if (parishObjList != null && !parishObjList.isEmpty()) {
                        model.put("size", parishObjList.size());
                    }
                    model.put("locationTitle", "Manage Parishes Under District: " + district.get(0)[1] + ", " + district.get(0)[2] + " Region.");
                    model.put("parishList", parishObjList);
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/manageDistrictParish", "model", model);
                }
//            //Check locationList/Facilities
//            if(term.equals("facility")){
//                List facilityObjList = (List<Object[]>) genericClassService.fetchRecord(Location.class, facilityFields, "WHERE r.villageid.parishid.subcountyid.countyid.district.districtid=:dID ORDER BY r.facilityid.facilityname ASC", params, paramsValue);
//                if(facilityObjList!=null && !facilityObjList.isEmpty()){
//                    model.put("size", facilityObjList.size());
//                }
//                model.put("locationTitle", "Manage Facilities Under District: "+district.get(0)[1]+", "+district.get(0)[2]+" Region.");
//                model.put("facilityList", facilityObjList);
//                return new ModelAndView("controlPanel/universalPanel/location/Manage/manageFacility", "model", model);
//            }
//               
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "Error Occured!");
        }
        return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
    }

    @RequestMapping(value = "/searchTransferLoc", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView searchTransferLocObj(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get form for Village Transfer");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
             long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
//            String[] params = {"vID"};
//            String[] fields = {"villageid", "villagename", "parishid.parishid", "parishid.subcountyid.subcountyid", "parishid.subcountyid.countyid.countyid", "parishid.subcountyid.countyid.districtid.districtid", "parishid.subcountyid.countyid.districtid.regionid.regionid",
//                "parishid.parishname", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtname", "parishid.subcountyid.countyid.districtid.regionid.regionname"};

            int count = Integer.parseInt(request.getParameter("itemSize"));
            long locationid = Long.parseLong(request.getParameter("locId"));
            String term = request.getParameter("term");
            String activity = request.getParameter("activity");
            String locActivity = request.getParameter("locActivity");
            List<Integer> transferIds = new ArrayList<Integer>();

            String saveParish = request.getParameter("parishid");
            String updateFac_Person_Village = request.getParameter("villageid");

            model.put("term", term);
            model.put("activity", activity);

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("checkObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("checkObj" + i));
                        int id = Integer.parseInt(request.getParameter("checkObj" + i));
                        transferIds.add(id);
                    }
                }
                logger.info("saveParish......... " + saveParish + " activity........... " + activity);
                if (saveParish != null && !saveParish.equals("0") && locActivity.equals("villageTransfer")) {
                    //
                    int parishId = Integer.parseInt(saveParish);
                    int transfer = 0;
                    String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                    List<Object[]> parishArrObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", new String[]{"pID"}, new Object[]{parishId});
                    if (parishArrObj != null) {
                        model.put("parishObj", parishArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Village.class, new String[]{"parishid"}, new Object[]{parishId}, "villageid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Village.class, "WHERE r.parishid.parishid=:Id AND r.villageid=:Id2", new String[]{"Id", "Id2"}, new Object[]{parishId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Village Succesfully Transfered To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Villages Succesfully Transfered To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Villages <b>Failed</b> To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (updateFac_Person_Village != null && !updateFac_Person_Village.equals("0") && locActivity.equals("facilityTransfer")) {
                    //
                    int parishId = Integer.parseInt(saveParish);
                    int villageId = Integer.parseInt(updateFac_Person_Village);
                    int transfer = 0;
                    String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                    List<Object[]> parishArrObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", new String[]{"pID"}, new Object[]{parishId});
                    if (parishArrObj != null) {
                        model.put("parishObj", parishArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Facility.class, new String[]{"villageid"}, new Object[]{villageId}, "facilityid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Facility.class, "WHERE r.village.parishid.parishid=:Id AND r.facilityid=:Id2", new String[]{"Id", "Id2"}, new Object[]{parishId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Facility Succesfully Transfered To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Facilities Succesfully Transfered To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Facilities <b>Failed</b> To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (updateFac_Person_Village != null && !updateFac_Person_Village.equals("0") && locActivity.equals("personTransfer")) {
                    //
                    int parishId = Integer.parseInt(saveParish);
                    int villageId = Integer.parseInt(updateFac_Person_Village);
                    int transfer = 0;
                    String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
                    List<Object[]> parishArrObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", new String[]{"pID"}, new Object[]{parishId});
                    if (parishArrObj != null) {
                        model.put("parishObj", parishArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Person.class, new String[]{"currentaddress"}, new Object[]{villageId}, "personid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Person.class, "WHERE r.currentaddress.parishid.parishid=:Id AND r.personid=:Id2", new String[]{"Id", "Id2"}, new Object[]{parishId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " User/Client Succesfully Transfered To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Users/Clients Succesfully Transfered To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Users/Clients <b>Failed</b> To Parish: " + parishArrObj.get(0)[1] + " Under Sub-County: " + parishArrObj.get(0)[2] + " County: " + parishArrObj.get(0)[3] + " District: " + parishArrObj.get(0)[4] + " Region: " + parishArrObj.get(0)[5]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }

            }
            int no = 0;
            if (transferIds != null) {
                no = transferIds.size();
                model.put("transferSize", transferIds.size());
            }
            String[] params = {"pID"};
            Object[] paramsValues = {locationid};
            String[] fields = {"parishid", "parishname", "subcountyid.subcountyname", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtname", "subcountyid.countyid.districtid.regionid.regionname"};
            List<Object[]> parish = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, " WHERE r.parishid=:pID ORDER BY r.parishname ASC", params, paramsValues);
            if (parish != null) {
                model.put("location", parish.get(0));
            }

            List<Object[]> regionsArrList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regionsArrList);
            if (term.equals("village")) {
                if (no == 1) {
                    model.put("title", no + " Village");
                } else {
                    model.put("title", no + " Villages");
                }

                model.put("btn", "Transfer Village");
            }
            if (term.equals("facility")) {
                if (no == 1) {
                    model.put("title", no + " Facility");
                } else {
                    model.put("title", no + " Facilities");
                }

                model.put("btn", "Transfer Facility");
            }
            if (term.equals("curVillage")) {
                if (no == 1) {
                    model.put("title", no + " Client/User");
                } else {
                    model.put("title", no + " Clients/Users");
                }

                model.put("btn", "Transfer Client/User");
            }

            return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("GeneralAdmin/DomainProject/DomainSettings/forms/createEntryFields", "model", model);
        }
    }

    @RequestMapping(value = "/searchSubcountyTransfer", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView searchSubcountyTransfer(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get form for Village Transfer");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            int count = Integer.parseInt(request.getParameter("itemSize"));
            long locationid = Long.parseLong(request.getParameter("locId"));
            String term = request.getParameter("term");
            String activity = request.getParameter("activity");
            String locActivity = request.getParameter("locActivity");
            List<Integer> transferIds = new ArrayList<Integer>();
            String saveSubcounty = request.getParameter("subcountyid");
            String updateSubcVillage = request.getParameter("villageid");
            model.put("term", term);
            model.put("activity", activity);

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("checkObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("checkObj" + i));
                        int id = Integer.parseInt(request.getParameter("checkObj" + i));
                        transferIds.add(id);
                    }
                }
                logger.info("saveSubcounty......... " + saveSubcounty + " activity........... " + activity);
                if (saveSubcounty != null && !saveSubcounty.equals("0") && locActivity.equals("parishTransfer")) {
                    //Transfer Parish To Another Subcounty
                    int subcountyId = Integer.parseInt(saveSubcounty);
                    int transfer = 0;
                    String[] params = {"scID"};
                    String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                    List<Object[]> subcountyArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", new String[]{"scID"}, new Object[]{subcountyId});
                    if (subcountyArrObj != null) {
                        model.put("subcountyObj", subcountyArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                    Object[] paramValues = {Long.parseLong(request.getParameter("subcountyid"))};
                    List<Object[]> prevSubcountyObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
                        genericClassService.updateRecordSQLStyle(Parish.class, new String[]{"subcountyid"}, new Object[]{subcountyId}, "parishid", transferId);
                        List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
                        int countTransfer = genericClassService.fetchRecordCount(Parish.class, "WHERE r.subcountyid.subcountyid=:Id AND r.parishid=:Id2", new String[]{"Id", "Id2"}, new Object[]{subcountyId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                            
                            
                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Subcounty";
                           if(checkObj != null){
//                        Audittraillocation al = new Audittraillocation();
//                        al.setCategory(sessAuditTrailCategory);
//                        al.setActivity(sessAuditTrailActivity);
//                        al.setDbaction("Transfer");
//                        al.setTimein(new Date());
//                        al.setPerson(new Person(pid));
//                        al.setAttrvalue((String) checkObj.get(0)[1]);
//                        al.setDescription("Transfered Sub-County");
//                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
//                        al.setCursubcounty((String) checkObj.get(0)[1]);
//                        al.setCurcounty((String) checkObj.get(0)[2]);
//                        al.setCurdistrict((String) checkObj.get(0)[3]);
//                        al.setCurregion((String) checkObj.get(0)[4]);
//                        al.setPrevlocationid((Integer) prevSubcountyObj.get(0)[0]);
//                        al.setPrevsubcounty((String) prevSubcountyObj.get(0)[1]);
//                        al.setPrevcounty((String) prevSubcountyObj.get(0)[2]);
//                        al.setPrevdistrict((String) prevSubcountyObj.get(0)[3]);
//                        al.setPrevregion((String) prevSubcountyObj.get(0)[4]);
//                        al.setAdministered(false);
//                        al.setReflevel(0);
//
//                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));  
                           }
                            
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Parish Succesfully Transfered To Subcounty: " + subcountyArrObj.get(0)[1] + " Under County: " + subcountyArrObj.get(0)[2] + " District: " + subcountyArrObj.get(0)[3] + " Region: " + subcountyArrObj.get(0)[4]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Parishes Succesfully Transfered To Subcounty: " + subcountyArrObj.get(0)[1] + " Under County: " + subcountyArrObj.get(0)[2] + " District: " + subcountyArrObj.get(0)[3] + " Region: " + subcountyArrObj.get(0)[4]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Parishes <b>Failed</b> To Subcounty: " + subcountyArrObj.get(0)[1] + " Under County: " + subcountyArrObj.get(0)[2] + " District: " + subcountyArrObj.get(0)[3] + " Region: " + subcountyArrObj.get(0)[4]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (saveSubcounty != null && !saveSubcounty.equals("0") && locActivity.equals("villageTransfer")) {
                    //
                    int subcountyId = Integer.parseInt(saveSubcounty);
                    int transfer = 0;
                    String[] params = {"scID"};
                    String[] fields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                    List<Object[]> subcountyArrObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", new String[]{"scID"}, new Object[]{subcountyId});
                    if (subcountyArrObj != null) {
                        model.put("subcountyObj", subcountyArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        Object[] paramValues = {Long.parseLong(request.getParameter("subcountyid"))};
                      List<Object[]> prevSubcountyObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
                      List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues);
                     genericClassService.updateRecordSQLStyle(Village.class, new String[]{"subcountyid"}, new Object[]{subcountyId}, "villageid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Village.class, "WHERE r.villageid.parishid.subcountyid.subcountyid=:Id AND r.villageid=:Id2", new String[]{"Id", "Id2"}, new Object[]{subcountyId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                         long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                        String sessAuditTrailCategory = "Location Management";
                        String sessAuditTrailActivity = "Subcounty";
                           if(checkObj != null){
                        Audittraillocation al = new Audittraillocation();
                        al.setCategory(sessAuditTrailCategory);
                        al.setActivity(sessAuditTrailActivity);
                        al.setDbaction("Transfer");
                        al.setTimein(new Date());
                        al.setPerson(new Person(pid));
                        al.setAttrvalue((String) checkObj.get(0)[1]);
                        al.setDescription("Transfered Sub-County");
                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
                        al.setCursubcounty((String) checkObj.get(0)[1]);
                        al.setCurcounty((String) checkObj.get(0)[2]);
                        al.setCurdistrict((String) checkObj.get(0)[3]);
                        al.setCurregion((String) checkObj.get(0)[4]);
                        al.setPrevlocationid((Integer) prevSubcountyObj.get(0)[0]);
                        al.setPrevsubcounty((String) prevSubcountyObj.get(0)[1]);
                        al.setPrevcounty((String) prevSubcountyObj.get(0)[2]);
                        al.setPrevdistrict((String) prevSubcountyObj.get(0)[3]);
                        al.setPrevregion((String) prevSubcountyObj.get(0)[4]);
                        al.setAdministered(false);
                        al.setReflevel(0);

                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));  
                           }   
                            
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Village Succesfully Transfered To Sub-County: " + subcountyArrObj.get(0)[1] + " Under County: " + subcountyArrObj.get(0)[2] + " District: " + subcountyArrObj.get(0)[3] + " Region: " + subcountyArrObj.get(0)[4]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Villages Succesfully Transfered To Sub-County: " + subcountyArrObj.get(0)[1] + " Under County: " + subcountyArrObj.get(0)[2] + " District: " + subcountyArrObj.get(0)[3] + " Region: " + subcountyArrObj.get(0)[4]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Villages <b>Failed</b> To Sub-County: " + subcountyArrObj.get(0)[1] + " Under County: " + subcountyArrObj.get(0)[2] + " District: " + subcountyArrObj.get(0)[3] + " Region: " + subcountyArrObj.get(0)[4]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }

                int no = 0;
                if (transferIds != null) {
                    no = transferIds.size();
                    model.put("transferSize", transferIds.size());
                }

                String[] params = {"scID"};
                Object[] Values = {locationid};
                String[] subfields = {"subcountyid", "subcountyname", "countyid.countyname", "countyid.districtid.districtname", "countyid.districtid.regionid.regionname"};
                List<Object[]> subcounty = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, subfields, " WHERE r.subcountyid=:scID ORDER BY r.subcountyname ASC", params, Values);
                if (subcounty != null) {
                    model.put("location", subcounty.get(0));
                }

                List<Object[]> regionsArrList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "ORDER BY r.regionname ASC", null, null);
                model.put("regionsList", regionsArrList);
                if (term.equals("village")) {
                    if (no == 1) {
                        model.put("title", no + " Village");
                    } else {
                        model.put("title", no + " Villages");
                    }

                    model.put("btn", "Transfer Village");
                }

                if (term.equals("parish")) {
                    if (no == 1) {
                        model.put("title", no + " parish");
                    } else {
                        model.put("title", no + " parishes");
                    }

                    model.put("btn", "Transfer Parish");
                }

                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("GeneralAdmin/DomainProject/DomainSettings/forms/createEntryFields", "model", model);
    }
    
     @RequestMapping(value = "/searchCountyTransfer", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView searchCountyTransfer(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get form for county Transfer");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            int count = Integer.parseInt(request.getParameter("itemSize"));
            long locationid = Long.parseLong(request.getParameter("locId"));
            String term = request.getParameter("term");
            String activity = request.getParameter("activity");
            String locActivity = request.getParameter("locActivity");
            List<Integer> transferIds = new ArrayList<Integer>();
            String saveCounty = request.getParameter("countyid");
            String updateCountyVillage = request.getParameter("villageid");
            String updateCountyParish = request.getParameter("parishid");
            model.put("term", term);
            model.put("activity", activity);

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("checkObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("checkObj" + i));
                        int id = Integer.parseInt(request.getParameter("checkObj" + i));
                        transferIds.add(id);
                    }
                }
                logger.info("saveCounty......... " + saveCounty + " activity........... " + activity);
                if (saveCounty != null && !saveCounty.equals("0") && locActivity.equals("subcountyTransfer")) {
                    //Transfer Subcounty To Another County
                    int countyId = Integer.parseInt(saveCounty);
                    int transfer = 0;
                    String[] params = {"cID"};
                    String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                    List<Object[]> countyArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", new String[]{"cID"}, new Object[]{countyId});
                    if (countyArrObj != null) {
                        model.put("countyArrObj", countyArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        
                    Object[] paramValues = {Long.parseLong(request.getParameter("countyid"))};
                    List<Object[]> prevCountyObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues);
                        genericClassService.updateRecordSQLStyle(Subcounty.class, new String[]{"countyid"}, new Object[]{countyId}, "subcountyid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Subcounty.class, "WHERE r.countyid.countyid=:Id AND r.subcountyid=:Id2", new String[]{"Id", "Id2"}, new Object[]{countyId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                            
                            
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID", params, paramValues);
                    if (checkObj != null) {

//                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
//                        String sessAuditTrailCategory = "Location Management";
//                        String sessAuditTrailActivity = "County";
//
//                        Audittraillocation al = new Audittraillocation();
//                        al.setCategory(sessAuditTrailCategory);
//                        al.setActivity(sessAuditTrailActivity);
//                        al.setDbaction("Transfer");
//                        al.setTimein(new Date());
//                        al.setPerson(new Person(pid));
//                        al.setAttrvalue((String) checkObj.get(0)[1]);
//                        al.setDescription("Transfered County");
//                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
//                        al.setCurcounty((String) checkObj.get(0)[1]);
//                        al.setCurdistrict((String) checkObj.get(0)[2]);
//                        al.setCurregion((String) checkObj.get(0)[3]);
//                        al.setPrevlocationid((Integer) prevCountyObj.get(0)[0]);
//                        al.setPrevcounty((String) prevCountyObj.get(0)[1]);
//                        al.setPrevdistrict((String) prevCountyObj.get(0)[2]);
//                        al.setPrevregion((String) prevCountyObj.get(0)[3]);
//                        al.setAdministered(false);
//                        al.setReflevel(0);
//
//                        genericClassService.saveOrUpdateRecordLoadObject(al);
                        model.put("checkObj", checkObj.get(0));

                    }  
                            
                            
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Subcounty Succesfully Transfered To county: " + countyArrObj.get(0)[1] + " Under  District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Subcounties Succesfully Transfered To County: " + countyArrObj.get(0)[1] + " Under District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Sub Counties <b>Failed</b> To County: " + countyArrObj.get(0)[1] + " Under  District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (saveCounty != null && !saveCounty.equals("0") && locActivity.equals("parishTransfer")) {
                    //Transfer 
                    int countyId = Integer.parseInt(saveCounty);
                    int transfer = 0;
                    String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                    List<Object[]> countyArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", new String[]{"cID"}, new Object[]{countyId});
                    if (countyArrObj != null) {
                        model.put("countyObj", countyArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Parish.class, new String[]{"countyid"}, new Object[]{countyId}, "parishid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Parish.class, "WHERE r.parishid.subcountyid.countyid=:Id AND r.parishid=:Id2", new String[]{"Id", "Id2"}, new Object[]{countyId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Parish Succesfully Transfered To County: " + countyArrObj.get(0)[1] + " Under  District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Parishes Succesfully Transfered To County: " + countyArrObj.get(0)[1] + " Under  District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Parishes <b>Failed</b> To County: " + countyArrObj.get(0)[1] + " Under District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (saveCounty != null && !saveCounty.equals("0") && locActivity.equals("villageTransfer")) {
                    //Transfer 
                    int countyId = Integer.parseInt(saveCounty);
                    int transfer = 0;
                    String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                    List<Object[]> countyArrObj = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", new String[]{"cID"}, new Object[]{countyId});
                    if (countyArrObj != null) {
                        model.put("countyObj", countyArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Village.class, new String[]{"countyid"}, new Object[]{countyId}, "villageid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Village.class, "WHERE r.villageid.parishid.subcountyid.countyid=:Id AND r.villageid=:Id2", new String[]{"Id", "Id2"}, new Object[]{countyId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Village Succesfully Transfered To County: " + countyArrObj.get(0)[1] + " Under  District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Villages Succesfully Transfered To County: " + countyArrObj.get(0)[1] + " Under  District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Villages <b>Failed</b> To County: " + countyArrObj.get(0)[1] + " Under District: " + countyArrObj.get(0)[2] + " Region: " + countyArrObj.get(0)[3]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }

                int no = 0;
                if (transferIds != null) {
                    no = transferIds.size();
                    model.put("transferSize", transferIds.size());
                }

                String[] params = {"cID"};
                Object[] Values = {locationid};
                String[] fields = {"countyid", "countyname", "districtid.districtname", "districtid.regionid.regionname"};
                List<Object[]> county = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, " WHERE r.countyid=:cID ORDER BY r.countyname ASC", params, Values);
                if (county != null) {
                    model.put("location", county.get(0));
                }

                List<Object[]> regionsArrList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "ORDER BY r.regionname ASC", null, null);
                model.put("regionsList", regionsArrList);
                if (term.equals("village")) {
                    if (no == 1) {
                        model.put("title", no + " Village");
                    } else {
                        model.put("title", no + " Villages");
                    }

                    model.put("btn", "Transfer Village");
                }

                if (term.equals("parish")) {
                    if (no == 1) {
                        model.put("title", no + " parish");
                    } else {
                        model.put("title", no + " parishes");
                    }

                    model.put("btn", "Transfer Parish");
                }
                 if (term.equals("subcounty")) {
                    if (no == 1) {
                        model.put("title", no + " subcounty");
                    } else {
                        model.put("title", no + " subcounties");
                    }

                    model.put("btn", "Transfer subcounty");
                }

                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("GeneralAdmin/DomainProject/DomainSettings/forms/createEntryFields", "model", model);
    }

    @RequestMapping(value = "/saveSubcountyx", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView saveSubcountyx(HttpServletRequest request, Principal principal) {
        logger.info("Received request to save a subcounty");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Subcounty> addSubcountyList = new ArrayList<Subcounty>();
            List<Subcounty> existingSubcountyList = new ArrayList<Subcounty>();
            List<Subcounty> addedSubcountyList = new ArrayList<Subcounty>();
            List<Subcounty> failedSubcountyList = new ArrayList<Subcounty>();
            model.put("activity", activity);
            long psid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("scName" + i) != null) {
                        logger.info("Posted Subcounty...... " + request.getParameter("scName" + i));
                        String scName = request.getParameter("scName" + i);

                        String subcountyName = "";
                        BreakIterator wordBreaker = BreakIterator.getWordInstance();
                        String str = scName.trim();
                        wordBreaker.setText(str);
                        int end = 0;
                        for (int start = wordBreaker.first();
                                (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                            String word = str.substring(start, end);
                            String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                            if (end != 0) {
                                subcountyName += joined_word;
                            }
                        }

                        Subcounty subcounty = new Subcounty();
                        //Check Existing Subcounty
                        int countExistingSubcounty = genericClassService.fetchRecordCount(Subcounty.class, "WHERE LOWER(r.subcoun)=:name", new String[]{"name"}, new Object[]{subcountyName.toLowerCase()});
                        if (countExistingSubcounty > 0) {
                            subcounty.setSubcountyname(subcountyName);
                            existingSubcountyList.add(subcounty);
                        } else {
                            subcounty.setSubcountyname(subcountyName);
                            addSubcountyList.add(subcounty);
                        }
                    }
                }
                if (addSubcountyList != null && !addSubcountyList.isEmpty()) {
                    for (Subcounty subcounty : addSubcountyList) {
                        genericClassService.saveOrUpdateRecordLoadObject(subcounty);
                        int addedPolicy = genericClassService.fetchRecordCount(Subcounty.class, "WHERE subcountyid=:scId", new String[]{"scId"}, new Object[]{subcounty.getSubcountyid()});
                        if (addedPolicy > 0) {
                            addedSubcountyList.add(subcounty);
                        } else {
                            failedSubcountyList.add(subcounty);
                        }
                    }
                    model.put("addedSubcountyList", addedSubcountyList);
                    if (addedSubcountyList != null && !addedSubcountyList.isEmpty()) {
                        model.put("mainActivity", "AddSubcounty");
                        model.put("resp", true);
                        if (addedSubcountyList.size() == 1) {
                            model.put("successMessage", "Successfully Saved " + addedSubcountyList.size() + " Subcounty");
                        } else {
                            model.put("successMessage", "Successfully Saved " + addedSubcountyList.size() + " Subcounties");
                        }
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Saving New Subcounty Failed!");
                    }
                    model.put("failedSubcountyList", failedSubcountyList);
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "No Valid Subcounties To Be Added!");
                }
                logger.info("saveSubcounty......... " + addSubcountyList.size() + " activity........... " + activity);

            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Subcounties Added!");
            }

            return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/location/view/saveLocation", "model", model);
        }

    }

    @RequestMapping(value = "/saveSubcounty", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView saveSubcounty(HttpServletRequest request, @RequestParam("scID") int subcountyId, @RequestParam("act") String activity, Principal principal) {
        logger.info("Received request to save a subcounty");
        Map<String, Object> model = new HashMap<String, Object>();
        try {

            Subcounty subcounty = null;
            if (activity.equals("add2")) {
                activity = "add";
                String[] params = {"scID"};
                Object[] paramValues = {subcountyId};
                String[] fields = {};
                subcounty = (Subcounty) genericClassService.fetchRecord(Subcounty.class, fields, " WHERE r.subcountyid=:scID", params, paramValues).get(0);
                Subcounty s2 = new Subcounty();
                s2.setCountyid(subcounty.getCountyid());
                model.put("subcounty", s2);
            }

            model.put("activity", activity);
            String[] fields = {};

            List<Region> regions = (List<Region>) genericClassService.fetchRecord(Region.class, fields, " ORDER BY r.regionname ASC", null, null);
            model.put("regionsList", regions);
            return new ModelAndView("controlPanel/universalPanel/location/forms/addSubCounty", "model", model);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("successmessage", "An error was encountered , try again or contact your systems administrator ");
            return new ModelAndView("controlPanel/universalPanel/location/forms/addSubCounty", "model", model);
        }
    }

    @RequestMapping(value = "/searchDistictTransferLoc", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView searchDistictTransferLoc(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get form for Village Transfer");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            int count = Integer.parseInt(request.getParameter("itemSize"));
            long locationid = Long.parseLong(request.getParameter("locId"));
            String term = request.getParameter("term");
            String activity = request.getParameter("activity");
            String locActivity = request.getParameter("locActivity");
            List<Integer> transferIds = new ArrayList<Integer>();
            String saveDistrict = request.getParameter("districtid");
//            String updateDistrictVillage = request.getParameter("villageid");            
            model.put("term", term);
            model.put("activity", activity);

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("checkObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("checkObj" + i));
                        int id = Integer.parseInt(request.getParameter("checkObj" + i));
                        transferIds.add(id);
                    }
                }
                logger.info("saveDistrict......... " + saveDistrict + " activity........... " + activity);

                if (saveDistrict != null && !saveDistrict.equals("0") && locActivity.equals("countyTransfer")) {
                    //Transfer Counties To Another District
                    int districtId = Integer.parseInt(saveDistrict);
                    int transfer = 0;
                    String[] fields = {"districtid", "districtname", "regionid.regionname"};
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", new String[]{"dID"}, new Object[]{districtId});
                    if (districtArrObj != null) {
                        model.put("districtObj", districtArrObj.get(0));
                    }
                    for (Integer transferId : transferIds) {
                    String[] params = {"dID"};
                    Object[] paramValues = {Long.parseLong(request.getParameter("districtid"))};
                        genericClassService.updateRecordSQLStyle(County.class, new String[]{"districtid"}, new Object[]{districtId}, "countyid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(County.class, "WHERE r.districtid.districtid=:Id AND r.countyid=:Id2", new String[]{"Id", "Id2"}, new Object[]{districtId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                            
                    List<Object[]> prevDistrictObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues);
                    List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID", params, paramValues);
                    if (checkObj != null) {
//
//                        long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
//                        String sessAuditTrailCategory = "Location Management";
//                        String sessAuditTrailActivity = "District";
//                        Audittraillocation al = new Audittraillocation();
//                        al.setCategory(sessAuditTrailCategory);
//                        al.setActivity(sessAuditTrailActivity);
//                        al.setDbaction("Transfer");
//                        al.setTimein(new Date());
//                        al.setPerson(new Person(pid));
//                        al.setAttrvalue((String) checkObj.get(0)[1]);
//                        al.setDescription("Transfered District");
//                        al.setCurlocationid((Integer) checkObj.get(0)[0]);
//                        al.setCurdistrict((String) checkObj.get(0)[1]);
//                        al.setCurregion((String) checkObj.get(0)[2]);
//                        al.setPrevlocationid((Integer) prevDistrictObj.get(0)[0]);
//                        al.setPrevdistrict((String) prevDistrictObj.get(0)[1]);
//                        al.setPrevregion((String) prevDistrictObj.get(0)[2]);
//                        al.setAdministered(false);
//                        al.setReflevel(0);
//
//                        genericClassService.saveOrUpdateRecordLoadObject(al);

                        model.put("checkObj", checkObj.get(0));
                    }    
                            
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " County Succesfully Transfered To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[2]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Counties Succesfully Transfered To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[2]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Counties <b>Failed</b> To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[2]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (saveDistrict != null && !saveDistrict.equals("0") && locActivity.equals("subcountyTransfer")) {
                    //Transfer Sub Counties To Another District
                    int districtId = Integer.parseInt(saveDistrict);
                    int transfer = 0;
                    String[] fields = {"districtid", "districtname", "regionid.regionname"};
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", new String[]{"dID"}, new Object[]{districtId});
                    if (districtArrObj != null) {
                        model.put("districtObj", districtArrObj.get(0));
                    }
                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Subcounty.class, new String[]{"districtid"}, new Object[]{districtId}, "subcountyid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Subcounty.class, "WHERE  r.districtid.districtid=:Id AND r.subcountyid=:Id2", new String[]{"Id", "Id2"}, new Object[]{districtId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Sub County Succesfully Transfered To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[2]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Sub Counties Succesfully Transfered To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[2]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Sub Counties <b>Failed</b> To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[2]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }
                if (saveDistrict != null && !saveDistrict.equals("0") && locActivity.equals("parishTransfer")) {
                    //Transfer Parish To Another District
                    int districtId = Integer.parseInt(saveDistrict);
                    int transfer = 0;
                    String[] fields = {"districtid", "districtname", "regionid.regionname"};
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", new String[]{"dID"}, new Object[]{districtId});
                    if (districtArrObj != null) {
                        model.put("districtObj", districtArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Parish.class, new String[]{"districtid"}, new Object[]{districtId}, "parishid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Parish.class, "WHERE r.districtid.districtid=:dId AND r.parishid=:Id2", new String[]{"Id", "Id2"}, new Object[]{districtId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Parish Succesfully Transfered To District: " + districtArrObj.get(0)[1] + "Under Region:" + districtArrObj.get(0)[2]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Parishes Succesfully Transfered To District: " + districtArrObj.get(0)[1] + "Under Region:" + districtArrObj.get(0)[2]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Parishes <b>Failed</b> To District: " + districtArrObj.get(0)[1] + " Under Region: " + districtArrObj.get(0)[2]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }

                if (saveDistrict != null && !saveDistrict.equals("0") && locActivity.equals("villageTransfer")) {
                    //
                    int districtId = Integer.parseInt(saveDistrict);
                    int transfer = 0;
                    String[] fields = {"districtid", "districtname", "regionid.regionname"};
                    List<Object[]> districtArrObj = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname  ASC", new String[]{"dID"}, new Object[]{districtId});
                    if (districtArrObj != null) {
                        model.put("districtObj", districtArrObj.get(0));
                    }

                    for (Integer transferId : transferIds) {
                        genericClassService.updateRecordSQLStyle(Village.class, new String[]{"districtid"}, new Object[]{districtId}, "villageid", transferId);
                        int countTransfer = genericClassService.fetchRecordCount(Village.class, "WHERE r.districtid.districtid=:Id AND r.villageid=:Id2", new String[]{"Id", "Id2"}, new Object[]{districtId, transferId});
                        if (countTransfer > 0) {
                            transfer += 1;
                        }
                    }
                    if (transfer == 1) {
                        model.put("title", transfer + " Village Succesfully Transfered To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[5]);
                    }
                    if (transfer > 1) {
                        model.put("title", transfer + " Villages Succesfully Transfered To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[5]);
                    }
                    if (transfer == 0) {
                        model.put("title", "Transfer Of Villages <b>Failed</b> To District: " + districtArrObj.get(0)[1] + " Region: " + districtArrObj.get(0)[5]);
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Manage/transferResponse", "model", model);
                }

                int no = 0;
                if (transferIds != null) {
                    no = transferIds.size();
                    model.put("transferSize", transferIds.size());
                }

                String[] params = {"dID"};
                Object[] Values = {locationid};
                String[] fields = {"districtid", "districtname", "regionid.regionname"};
                List<Object[]> district = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, " WHERE r.districtid=:dID ORDER BY r.districtname ASC", params, Values);
                if (district != null) {
                    model.put("location", district.get(0));
                }

                List<Object[]> regionsArrList = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "ORDER BY r.regionname ASC", null, null);
                model.put("regionsList", regionsArrList);
                if (term.equals("village")) {
                    if (no == 1) {
                        model.put("title", no + " Village");
                    } else {
                        model.put("title", no + " Villages");
                    }

                    model.put("btn", "Transfer Village");
                }
                if (term.equals("county")) {
                    if (no == 1) {
                        model.put("title", no + " county");
                    } else {
                        model.put("title", no + " counties");
                    }

                    model.put("btn", "Transfer county");
                }
                if (term.equals("subcounty")) {
                    if (no == 1) {
                        model.put("title", no + " subcounty");
                    } else {
                        model.put("title", no + " subcounties");
                    }

                    model.put("btn", "Transfer subcounty");
                }

                if (term.equals("parish")) {
                    if (no == 1) {
                        model.put("title", no + " parish");
                    } else {
                        model.put("title", no + " parishes");
                    }

                    model.put("btn", "Transfer Parish");
                }

                return new ModelAndView("controlPanel/universalPanel/location/Manage/formTransferAttachment", "model", model);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("GeneralAdmin/DomainProject/DomainSettings/forms/createEntryFields", "model", model);
    }

    @RequestMapping(value = "/locationsAuditor.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView locationsAuditor(@RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal,@RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> model = new HashMap<String, Object>();
        try {

            String[] field1 = {"activity"};
            String[] field2 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                "person.firstname", "person.lastname", "person.othernames", 
                "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "curvillage", "curparish",
                "cursubcounty", "curcounty", "curdistrict", "curregion", "curlocationid", "prevlocationid", "transferactivity", "administered", "reflevel"};

            List<Audittraillocation> auditList = new ArrayList<Audittraillocation>();
            if (activity.equals("b")) {
                request.getSession().setAttribute("sessAuditTrailCategory", searchPhrase);
                String sessAuditTrailCategory = request.getSession().getAttribute("sessAuditTrailCategory").toString();
                model.put("atCategory", sessAuditTrailCategory);
                List<String> activityList = new ArrayList<String>();
                String[] param = {"cat"};
                Object[] paramsValue = {searchPhrase};
                List<Object> audActivityList = (List<Object>) genericClassService.fetchRecord(Audittraillocation.class, new String[]{"activity"}, "WHERE r.category=:cat ORDER BY r.activity ASC ", param, paramsValue);
                if (audActivityList != null) {
                    for (Object object : audActivityList) {
                        activityList.add((String) object);
                    }
                }
                model.put("audActivityList", activityList);
                model.put("formActivity", "Activity List");
                return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/selects", "model", model);
            }

            if (activity.equals("c")) {
                String sessAuditTrailCategory = request.getSession().getAttribute("sessAuditTrailCategory").toString();
                request.getSession().setAttribute("sessAuditTrailActivity", searchPhrase);
                String sessAuditTrailActivity = request.getSession().getAttribute("sessAuditTrailActivity").toString();
                model.put("atActivity", sessAuditTrailActivity);
                String[] param = {"cat", "act", "state"};
                Object[] paramsValue = {sessAuditTrailCategory, searchPhrase, false};
                List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecordFunction(Audittraillocation.class,
                        new String[]{"r.dbaction, COUNT(r.dbaction)"}, "WHERE r.category=:cat AND r.activity=:act AND r.administered=:state GROUP BY r.dbaction ORDER BY r.dbaction ASC ", param, paramsValue, offset, maxResults);
                //SUM(CASE WHEN r.administered=true THEN 1 ELSE 0 END)
                if (audActivityList != null) {
                    for (Object[] object : audActivityList) {
                        Audittraillocation trail = new Audittraillocation();
                        trail.setDbaction((String) object[0]);
                        logger.info("Actiond::::: " + (String) object[0] + " Countd ::::: " + object[1]);
                        trail.setAudit((Long) object[1]);
                        auditList.add(trail);
                    }
                }
                model.put("audActivityList", auditList);
                model.put("formActivity", "Activity List");
                return new ModelAndView("controlPanel/universalPanel/location/Audits/views/db_Actions", "model", model);
            }
            if (activity.equals("d")) {
                String sessAuditTrailCategory = request.getSession().getAttribute("sessAuditTrailCategory").toString();
                String sessAuditTrailActivity = request.getSession().getAttribute("sessAuditTrailActivity").toString();
                model.put("category", sessAuditTrailCategory);
                model.put("activity", sessAuditTrailActivity);
                model.put("dbaction", searchPhrase);
                // Village Updated
                if (sessAuditTrailActivity.equals("Village")) {
                    String[] param2 = {"cat","audAct","status","dbAction"};
                    Object[] paramsValue2 = {sessAuditTrailCategory,sessAuditTrailActivity,false,searchPhrase};
                    List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.administered=:status AND r.dbaction=:dbAction ORDER BY r.timein, r.activity, r.description, r.dbaction ASC ", param2, paramsValue2);
                    model.put("audActivityList", audActivityList);
                }            
                
                if (sessAuditTrailActivity.equals("Parish")) {
                    String[] param2 = {"cat","audAct","status","dbAction"};
                    Object[] paramsValue2 = {sessAuditTrailCategory,sessAuditTrailActivity,false,searchPhrase};
                    List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.administered=:status AND r.dbaction=:dbAction ORDER BY r.timein, r.activity, r.description, r.dbaction ASC ", param2, paramsValue2);
                    model.put("audActivityList1", audActivityList);
                }
                if (sessAuditTrailActivity.equals("Subcounty")) {
                    String[] param2 = {"cat","audAct","status","dbAction"};
                    Object[] paramsValue2 = {sessAuditTrailCategory,sessAuditTrailActivity,false,searchPhrase};
                    List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.administered=:status AND r.dbaction=:dbAction ORDER BY r.timein, r.activity, r.description, r.dbaction ASC ", param2, paramsValue2);
                    model.put("audActivityList2", audActivityList);
                }
                if (sessAuditTrailActivity.equals("County")) {
                    String[] param2 = {"cat","audAct","status","dbAction"};
                    Object[] paramsValue2 = {sessAuditTrailCategory,sessAuditTrailActivity,false,searchPhrase};
                    List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.administered=:status AND r.dbaction=:dbAction ORDER BY r.timein, r.activity, r.description, r.dbaction ASC ", param2, paramsValue2);
                    model.put("audActivityList3", audActivityList);
                }
                if (sessAuditTrailActivity.equals("District")) {
                    String[] param2 = {"cat","audAct","status","dbAction"};
                    Object[] paramsValue2 = {sessAuditTrailCategory,sessAuditTrailActivity,false,searchPhrase};
                    List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.administered=:status AND r.dbaction=:dbAction ORDER BY r.timein, r.activity, r.description, r.dbaction ASC ", param2, paramsValue2);
                    model.put("audActivityList4", audActivityList);
                }
                if (sessAuditTrailActivity.equals("Region")) {
                    String[] param2 = {"cat","audAct","status","dbAction"};
                    Object[] paramsValue2 = {sessAuditTrailCategory,sessAuditTrailActivity,false,searchPhrase};
                    List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.administered=:status AND r.dbaction=:dbAction ORDER BY r.timein, r.activity, r.description, r.dbaction ASC ", param2, paramsValue2);
                    model.put("audActivityList5", audActivityList);
                }
                
                
                return new ModelAndView("controlPanel/universalPanel/location/Audits/views/updateAudits", "model", model);
            }
      
           if (activity.equals("e")) {
                String sessAuditTrailCategory = request.getSession().getAttribute("sessAuditTrailCategory").toString();
                String sessAuditTrailActivity = request.getSession().getAttribute("sessAuditTrailActivity").toString();
                model.put("category", sessAuditTrailCategory);
                model.put("activity", sessAuditTrailActivity);
                model.put("dbaction", searchPhrase);
                // Village Updated
                if (sessAuditTrailActivity.equals("Village")) {
                    String[] param2 = {"cat", "audAct", "dbAction", "Id"};
                    Object[] paramsValue2 = {sessAuditTrailCategory, sessAuditTrailActivity, searchPhrase, id};
                    if(searchPhrase.equals("Update")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                        }
                    }
                    if(searchPhrase.equals("Delete")){
                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                            "person.firstname", "person.lastname", "person.othernames",
                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                            logger.info("audActivityList.get(0)"+audActivityList.get(0));
                        }
                        List<Object[]> checkDestinationObj = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid","parishname"}, "WHERE r.parishid=:Id", new String[]{"Id"},  new Object[]{(Integer)audActivityList.get(0)[16]});
                        logger.info("checkDestinationObj :::::::: "+checkDestinationObj);
                        if(checkDestinationObj!=null && !checkDestinationObj.isEmpty()){
                            model.put("parishObj", checkDestinationObj); 
                        }
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageVillage", "model", model);
                }
                // Parish Updated
                if (sessAuditTrailActivity.equals("Parish")) {
                    String[] param2 = {"cat", "audAct", "dbAction", "Id"};
                    Object[] paramsValue2 = {sessAuditTrailCategory, sessAuditTrailActivity, searchPhrase, id};
                    if(searchPhrase.equals("Update")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                        }
                    }
                    if(searchPhrase.equals("Delete")){
                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                            "person.firstname", "person.lastname", "person.othernames",
                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                            logger.info("audActivityList.get(0)"+audActivityList.get(0));
                        }
                        List<Object[]> checkDestinationObj = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid","subcountyname"}, "WHERE r.subcountyid=:Id", new String[]{"Id"},  new Object[]{(Integer)audActivityList.get(0)[16]});
                        logger.info("checkDestinationObj :::::::: "+checkDestinationObj);
                        if(checkDestinationObj!=null && !checkDestinationObj.isEmpty()){
                            model.put("subcountyObj", checkDestinationObj); 
                        }
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageParish", "model", model);
                }
                // District Updated
               if(sessAuditTrailActivity.equals("District")){
                   String[] param2 = {"cat","audAct","dbAction","Id"};
                   Object[] paramsValue2 = {sessAuditTrailCategory, sessAuditTrailActivity, searchPhrase, id};
                   if(searchPhrase.equals("Update")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                        }
                    }
                   if(searchPhrase.equals("Delete")){
                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                            "person.firstname", "person.lastname", "person.othernames",
                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                            logger.info("audActivityList.get(0)"+audActivityList.get(0));
                        }
                        List<Object[]> checkDestinationObj = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid","regionname"}, "WHERE r.regionid=:Id", new String[]{"Id"},  new Object[]{(Integer)audActivityList.get(0)[16]});
                        logger.info("checkDestinationObj :::::::: "+checkDestinationObj);
                        if(checkDestinationObj!=null && !checkDestinationObj.isEmpty()){
                            model.put("regionObj", checkDestinationObj); 
                        }
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageDistrict", "model", model);
           }
               // County Updated
               if(sessAuditTrailActivity.equals("County")){
                   String[] param2 = {"cat","audAct","dbAction","Id"};
                   Object[] paramsValue2 = {sessAuditTrailCategory, sessAuditTrailActivity, searchPhrase, id};
                   if(searchPhrase.equals("Update")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                        }
                    }
                   if(searchPhrase.equals("Delete")){
                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                            "person.firstname", "person.lastname", "person.othernames",
                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                            logger.info("audActivityList.get(0)"+audActivityList.get(0));
                        }
                        List<Object[]> checkDestinationObj = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid","districtname"}, "WHERE r.districtid=:Id", new String[]{"Id"},  new Object[]{(Integer)audActivityList.get(0)[16]});
                        logger.info("checkDestinationObj :::::::: "+checkDestinationObj);
                        if(checkDestinationObj!=null && !checkDestinationObj.isEmpty()){
                            model.put("districtObj", checkDestinationObj); 
                        }
                    }
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageCounty", "model", model);
           }
                // County Updated
               if(sessAuditTrailActivity.equals("Subcounty")){
                   String[] param2 = {"cat","audAct","dbAction","Id"};
                   Object[] paramsValue2 = {sessAuditTrailCategory, sessAuditTrailActivity, searchPhrase, id};
                   if(searchPhrase.equals("Update")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                        }
                    }
//                   if(searchPhrase.equals("Transfer")){
//                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
//                        if(audActivityList!=null && !audActivityList.isEmpty()){
//                            model.put("audObj", audActivityList.get(0));
//                        }
//                    }
                    if(searchPhrase.equals("Delete")){
                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                            "person.firstname", "person.lastname", "person.othernames",
                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                            logger.info("audActivityList.get(0)"+audActivityList.get(0));
                        }
                        
                    }
                    
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageSubcounty", "model", model);
           }
               //Region Update
           
               if(sessAuditTrailActivity.equals("Region")){
                   String[] param2 = {"cat","audAct","dbAction","Id"};
                   Object[] paramsValue2 = {sessAuditTrailCategory, sessAuditTrailActivity, searchPhrase, id};
                   if(searchPhrase.equals("Update")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                        }
                    }
                      if(searchPhrase.equals("Delete")){
                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                            "person.firstname", "person.lastname", "person.othernames",
                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.category=:cat AND r.activity=:audAct AND r.audit=:Id AND r.dbaction=:dbAction ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0)); 
                            logger.info("audActivityList.get(0)"+audActivityList.get(0));
                        }
//                        List<Object[]> checkDestinationObj = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid","countyname"}, "WHERE r.countyid=:Id", new String[]{"Id"},  new Object[]{(Integer)audActivityList.get(0)[16]});
//                        logger.info("checkDestinationObj :::::::: "+checkDestinationObj);
//                        if(checkDestinationObj!=null && !checkDestinationObj.isEmpty()){
//                            model.put("countyObj", checkDestinationObj); 
//                        }
                    }
                   
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageRegion", "model", model);
           }
               
               
            }
            
            if (activity.equals("f")) {
                String sessAuditTrailCategory = request.getSession().getAttribute("sessAuditTrailCategory").toString();
                String sessAuditTrailActivity = request.getSession().getAttribute("sessAuditTrailActivity").toString();
                model.put("category", sessAuditTrailCategory);
                model.put("activity", sessAuditTrailActivity);
                model.put("dbaction", searchPhrase);
                if (sessAuditTrailActivity.equals("Village")) {
                    String[] param2 = {"Id"};
                    Object[] paramsValue2 = {id};
                    boolean success=true;
                    if(searchPhrase.equals("Update") || searchPhrase.equals("Transfer")){
                        
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                            if(searchPhrase.equals("Update")){
                                genericClassService.updateRecordSQLStyle(Village.class, new String[]{"villagename"}, new Object[]{audActivityList.get(0)[10]}, "villageid", id2);
                                //Check Success or Not !!!
                                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                            }
                            if(searchPhrase.equals("Transfer")){
                                //Not Yet Cartered For
                                
                            }
                        }
                    }
                       if (searchPhrase.equals("Delete")) {
                            String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                                "person.firstname", "person.lastname", "person.othernames",
                                "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                            List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.audit=:Id ", param2, paramsValue2);
                            if (audActivityList != null && !audActivityList.isEmpty()) {
                                model.put("audObj", audActivityList.get(0));
                                // Previous Location Is Parish ID :: prev_Vil
                                Village addObj = new Village();
                                addObj.setVillagename((String) audActivityList.get(0)[10]);
                                int parishId = Integer.parseInt(id2 + "");
                                addObj.setParishid(new Parish(parishId));
                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
                                int count = genericClassService.fetchRecordCount(Village.class, "WHERE r.villageid=:vID", new String[]{"vID"}, new Object[]{addObj.getVillageid()});
                                if (count > 0) {
                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                                } else {
                                    success = false;
                                }
                            }
                        }
                        model.put("success", success);
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model); 
                    }
                    
                   
                
            
//                    if (searchPhrase.equals("Delete")) {
//                        String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
//                            "person.firstname", "person.lastname", "person.othernames",
//                            "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};
//
//                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.audit=:Id ", param2, paramsValue2);
//                        if (audActivityList != null && !audActivityList.isEmpty()) {
//                            model.put("audObj", audActivityList.get(0));
//
//                            if (searchPhrase.equals("Delete")) {
//                                // Previous Location Is Parish ID :: prev_Vil
//                                Village addObj = new Village();
//                                addObj.setVillagename((String) audActivityList.get(0)[10]);
//                                int parishId = Integer.parseInt(id2 + "");
//                                addObj.setParishid(new Parish(parishId));
//                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
//                                int count = genericClassService.fetchRecordCount(Village.class, "WHERE r.villageid=:vID", new String[]{"vID"}, new Object[]{addObj.getVillageid()});
//                                if (count > 0) {
//                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
//                                } else {
//                                    success = false;
//                                }
//                            }
//                        }
//                    }
                    
////                    model.put("success", success);
//                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);
//                }
                if (sessAuditTrailActivity.equals("Subcounty")) {
                    String[] param2 = {"Id"};
                    Object[] paramsValue2 = {id};
                    boolean success=true;
                    if(searchPhrase.equals("Update") || searchPhrase.equals("Transfer") || searchPhrase.equals("Delete")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                            if(searchPhrase.equals("Update")){
                                genericClassService.updateRecordSQLStyle(Subcounty.class, new String[]{"subcountyname"}, new Object[]{audActivityList.get(0)[12]}, "subcountyid", id2);
                                //Check Success or Not !!!
                                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                            }
                            if(searchPhrase.equals("Transfer")){
                                //Not Yet Cartered For
                            }
                            if(searchPhrase.equals("Delete")){
                                String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                                "person.firstname", "person.lastname", "person.othernames",
                                "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                            List<Object[]> audActivityList1 = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.audit=:Id ", param2, paramsValue2);
                            if (audActivityList1 != null && !audActivityList1.isEmpty()) {
                                model.put("audObj", audActivityList1.get(0));
                                // Previous location Is County ID :: prev_subcounty
                                Subcounty addObj =  new Subcounty();
                                addObj.setSubcountyname((String) audActivityList1.get(0)[12]);
                                
                                int countyId=Integer.parseInt(id2+"");
                                addObj.setCountyid(new County(countyId));
                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
                                int count = genericClassService.fetchRecordCount(Subcounty.class, "WHERE r.subcountyid=:scID", new String[]{"scID"}, new Object[]{addObj.getSubcountyid()});
                                if (count > 0) {
                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                                }
                                else{
                                    success=false;
                                 }
                            }
                        }
                    }
                    
                    
                    model.put("success", success);
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);
                }
                }
                if (sessAuditTrailActivity.equals("Parish")) {
                    String[] param2 = {"Id"};
                    Object[] paramsValue2 = {id};
                    boolean success=true;
                    if(searchPhrase.equals("Update") || searchPhrase.equals("Transfer") || searchPhrase.equals("Delete")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                            if(searchPhrase.equals("Update")){
                                genericClassService.updateRecordSQLStyle(Parish.class, new String[]{"parishname"}, new Object[]{audActivityList.get(0)[11]}, "parishid", id2);
                                //Check Success or Not !!!
                                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                            }
                            if(searchPhrase.equals("Transfer")){
                                //Not Yet Cartered For
                            }
                            if (searchPhrase.equals("Delete")) {
                            String[] field3 = {"audit", "timein", "category", "activity", "dbaction", "attrvalue", "description",
                                "person.firstname", "person.lastname", "person.othernames",
                                "prevvillage", "prevparish", "prevsubcounty", "prevcounty", "prevdistrict", "prevregion", "prevlocationid", "transferactivity", "administered", "reflevel"};

                            List<Object[]> audActivityList1 = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field3, "WHERE r.audit=:Id ", param2, paramsValue2);
                            if (audActivityList1 != null && !audActivityList1.isEmpty()) {
                                model.put("audObj", audActivityList1.get(0));
                                // Previous Location Is Subcounty ID :: prev_subcounty
                                Parish addObj = new Parish();
                                addObj.setParishname((String) audActivityList1.get(0)[11]);
                                int subcountyId = Integer.parseInt(id2 + "");
                                addObj.setSubcountyid(new Subcounty(subcountyId));
                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
                                int count = genericClassService.fetchRecordCount(Parish.class, "WHERE r.parishid=:pID", new String[]{"pID"}, new Object[]{addObj.getParishid()});
                                if (count > 0) {
                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                                } else {
                                    success = false;
                                }
                            }
                        }
                        }
                    }
                    
                    model.put("success", success);
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);
                }
                if (sessAuditTrailActivity.equals("County")) {
                    String[] param2 = {"Id"};
                    Object[] paramsValue2 = {id};
                    boolean success=true;
                    if(searchPhrase.equals("Update") || searchPhrase.equals("Transfer") || searchPhrase.equals("Delete")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                            if(searchPhrase.equals("Update")){
                                genericClassService.updateRecordSQLStyle(County.class, new String[]{"countyname"}, new Object[]{audActivityList.get(0)[13]}, "countyid", id2);
                                //Check Success or Not !!!
                                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                            }
                            if(searchPhrase.equals("Transfer")){
                                //Not Yet Cartered For
                            }
                            if(searchPhrase.equals("Delete")){
                                // Previous location Is Ditrcit ID :: prev_County
                                County addObj =  new County();
                                addObj.setCountyname((String) audActivityList.get(0)[14]);
                                
                                int districtId=Integer.parseInt(id2+"");
                                addObj.setDistrictid(new District(districtId));
                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
                                int count = genericClassService.fetchRecordCount(County.class, "WHERE r.countyid=:cID", new String[]{"cID"}, new Object[]{addObj.getCountyid()});
                                if (count > 0) {
                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                                }
                                else{
                                    success=false;
                                }
                            }
                        }
                        
                    }
                    
                    model.put("success", success);
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);
                }
                if (sessAuditTrailActivity.equals("District")) {
                    String[] param2 = {"Id"};
                    Object[] paramsValue2 = {id};
                    boolean success=true;
                    if(searchPhrase.equals("Update") || searchPhrase.equals("Transfer") || searchPhrase.equals("Delete")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                            if(searchPhrase.equals("Update")){
                                genericClassService.updateRecordSQLStyle(District.class, new String[]{"districtname"}, new Object[]{audActivityList.get(0)[14]}, "districtid", id2);
                                //Check Success or Not !!!
                                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                            }
                            if(searchPhrase.equals("Transfer")){
                                //Not Yet Cartered For
                            }
                            if(searchPhrase.equals("Delete")){
                                // Previous location Is Region ID :: prev_district
                                District addObj  = new District();
                                addObj.setDistrictname((String) audActivityList.get(0)[14]);
                                                                
                                int regionId=Integer.parseInt(id2+"");
                                addObj.setRegionid(new Region(regionId));
                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
                                int count = genericClassService.fetchRecordCount(District.class, "WHERE r.districtid=:dID", new String[]{"dID"}, new Object[]{addObj.getDistrictid()});
                                if (count > 0) {
                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                                }
                                else{
                                    success=false;
                                 }
                            }
                        }
                    }
                    
                    
                    model.put("success", success);
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);
                }
                if (sessAuditTrailActivity.equals("Region")) {
                    String[] param2 = {"Id"};
                    Object[] paramsValue2 = {id};
                    boolean success=true;
                    if(searchPhrase.equals("Update") || searchPhrase.equals("Transfer") || searchPhrase.equals("Delete")){
                        List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                        if(audActivityList!=null && !audActivityList.isEmpty()){
                            model.put("audObj", audActivityList.get(0));
                            if(searchPhrase.equals("Update")){
                                genericClassService.updateRecordSQLStyle(Region.class, new String[]{"regionname"}, new Object[]{audActivityList.get(0)[15]}, "regionid", id2);
                                //Check Success or Not !!!
                                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                            }
                            if(searchPhrase.equals("Transfer")){
                                //Not Yet Cartered For
                            }
                            if(searchPhrase.equals("Delete")){
//                                // Previous location Is Region ID :: prev_district
//                                Region addObj  = new Region();
//                                addObj.setRegionname((String) audActivityList.get(0)[15]);
//                                 
//                                genericClassService.saveOrUpdateRecordLoadObject(addObj);
//                                int count = genericClassService.fetchRecordCount(Region.class, "WHERE r.regionid=:rID", new String[]{"rID"}, new Object[]{addObj.getRegionid()});
//                                if (count > 0) {
//                                    genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
//                                }
//                                else{
//                                    success=false;
//                                 }
                            }
                        }
                    }
                    
                     model.put("success", success);
                    return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);
                }
            }
            
            if (activity.equals("g")) {
                String sessAuditTrailCategory = request.getSession().getAttribute("sessAuditTrailCategory").toString();
                String sessAuditTrailActivity = request.getSession().getAttribute("sessAuditTrailActivity").toString();
                model.put("category", sessAuditTrailCategory);
                model.put("activity", sessAuditTrailActivity);
                model.put("dbaction", searchPhrase);
                boolean success=true;
                
                String[] param2 = {"Id"};
                Object[] paramsValue2 = {id};
                List<Object[]> audActivityList = (List<Object[]>) genericClassService.fetchRecord(Audittraillocation.class, field2, "WHERE r.audit=:Id ", param2, paramsValue2);
                if (audActivityList != null && !audActivityList.isEmpty()) {
                    model.put("audObj", audActivityList.get(0));
                }

                //Approves change made as captured in Audit Table
                //Works For All Instanse (Village,Parish,Sub-COunty etc)
                //Update, Set Status == true // Goes off listed items
                genericClassService.updateRecordSQLStyle(Audittraillocation.class, new String[]{"administered"}, new Object[]{true}, "audit", id);
                model.put("success", success);
                return new ModelAndView("controlPanel/universalPanel/location/Audits/forms/manageResponse", "model", model);        
            }
            
                 }catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("controlPanel/universalPanel/location/Audits/main", "model", model);
    

}
    
    @RequestMapping(value = "/trailcategory", method = RequestMethod.GET)
    public String trailcategory(Model model, HttpServletRequest request) {
        List<Trailcategory> trailcategorylist = new ArrayList<>();
        
        String[] params = {"trailcategoryid"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacility")))};
        String[] fields = {"trailcategoryid", "trailcategoryname", "description"};
        List<Object[]> trailcategories = (List<Object[]>) genericClassService.fetchRecord(Trailcategory.class, fields, "WHERE trailcategoryid=:trailcategoryid", params, paramsValues);
        if (trailcategories  != null) {
            for (Object[] trailcat : trailcategories) {
                Trailcategory trailcategory= new Trailcategory();
                trailcategory.setDescription((String) trailcat[2]);
                trailcategory.setTrailcategoryid((Integer) trailcat[0]);
                trailcategory.setTrailcategoryname((String) trailcat[1]);
                trailcategorylist .add(trailcategory);
            }
        }
         model.addAttribute("trailcategories", trailcategorylist);
        return "controlPanel/localSettingsPanel/audits/forms/trailregistration";
    }
    
    @RequestMapping(value = "/saveorupdatetrailcategory.htm")
    public @ResponseBody
    String saveorupdatetrailcategory(Model model, HttpServletRequest request) {
        String results = "";
        if ("save".equals(request.getParameter("type"))) {
            Trailcategory trailcategory = new Trailcategory();
          trailcategory.setDescription(request.getParameter("description"));
          trailcategory.setTrailcategoryname(request.getParameter("trailcategoryname"));
            
            Object save = genericClassService.saveOrUpdateRecordLoadObject(trailcategory);
            if (save != null) {
                results = "success";
            }
        } else {
            String[] columns = {"trailcategoryname", "description"};
            Object[] columnValues = {request.getParameter("trailcategoryname"), request.getParameter("description")};
            String pk = "trailcategoryid";
            Object pkValue = Long.parseLong(request.getParameter("trailcategoryid"));

            int result = genericClassService.updateRecordSQLSchemaStyle(Trailcategory.class, columns, columnValues, pk, pkValue, "locations");
            if (result != 0) {
                results = "success";
            }
        }

        return results;
    }
     @RequestMapping(value = "/deleteRecoveryCategory.htm")
    public @ResponseBody
    String deleteRecoveryCategory(Model model, HttpServletRequest request) {
        String results = "";
        String[] params1 = {"trailcategoryid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("trailcategoryid"))};
        
        String[] columns = {"trailcategoryid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("trailcategoryid"))};
            int result = genericClassService.deleteRecordByByColumns("locations.trailcategory", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        
        return results;
    }
}
    
//@RequestMapping(value = "/addoreditRegion")
//    public @ResponseBody
//    String addoreditRegion(HttpServletRequest request, Model model, @ModelAttribute("regionName") String regionname, @ModelAttribute("type") int typexz) {
//        String msg = "";
//        if (typexz == 1) {
//            Region region = new Region();
//            region.setRegionname(regionname);
//            Object saved = genericClassService.saveOrUpdateRecordLoadObject(regionname);
//            if (saved != null) {
//                msg = "success";
//            } else {
//                msg = "failure";
//            }
//        } else if (typexz == 2) {
//            try {
//                List<Map> regionObj = (ArrayList<Map>) new ObjectMapper().readValue(regionname , List.class);
//                int regionid = Integer.parseInt(regionObj.get(0).get("stypeid").toString());
//                String regionName = regionObj.get(0).get("regname").toString();
//                String[] columns = {"regionname"};
//                Object[] columnValues = {regionName};
//                String PrimaryKey = "regionName";
//                Object PkValue = regionid;
//                Object saved = genericClassService.updateRecordSQLSchemaStyle(Region.class, columns, columnValues, PrimaryKey, PkValue, "public");
//                if (saved != null) {
//                    msg = "success";
//                } else {
//                    msg = "failure";
//                }
//            } catch (IOException ex) {
//                System.out.println(ex);
//            }
//        }
//        return msg;
//    }
    


 

