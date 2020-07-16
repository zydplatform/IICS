/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.assetsmanager.Assetallocation;
import com.iics.assetsmanager.Assets;
import com.iics.assetsmanager.Facilityassets;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.store.Donations;
import com.iics.store.Donationsitems;
import com.iics.store.Donorprogram;
import com.iics.store.Facilitydonor;
import com.iics.store.Item;
import com.iics.store.Itempackage;
import com.iics.store.Medicalitem;
import com.iics.domain.Searchstaff;
import com.iics.domain.Systemuser;
import com.iics.store.Donationconsumption;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import com.iics.utils.StockActivityLog;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
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
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author SAMINUNU
 */
@Controller
@RequestMapping("/internaldonorprogram")
public class InternalDonorProgram {

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;
    private SimpleDateFormat formatterwithtime = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();

    @RequestMapping(value = "/donorProgramPane", method = RequestMethod.GET)
    public String donorProgramPane(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

        List<Map> donor = new ArrayList<>();

        String[] params1 = {"facilityid"};
        Object[] paramsValues1 = {facilityid};
        String where1 = "WHERE facilityid=:facilityid";
        String[] fields1 = {"donorprogramid", "facilitydonorid", "contactperson", "primarycontact", "secondarycontact", "email"};
        List<Object[]> dnrProg = (List<Object[]>) genericClassService.fetchRecord(Facilitydonor.class, fields1, where1, params1, paramsValues1);
        if (dnrProg != null) {
            Map<String, Object> dnrRow;
            for (Object[] dnr : dnrProg) {
                dnrRow = new HashMap<>();
                String[] params2 = {"donorprogramid"};
                Object[] paramsValues2 = {(Integer) dnr[0]};
                String[] fields2 = {"donorprogramid", "donorname", "origincountry", "donortype", "telno", "emial", "fax"};
                String where2 = "WHERE donorprogramid=:donorprogramid";
                List<Object[]> facilitydnrs = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fields2, where2, params2, paramsValues2);
                if (facilitydnrs != null) {

                    dnrRow.put("facilitydonorid", dnr[1]);
                    dnrRow.put("contactperson", dnr[2]);
                    dnrRow.put("primarycontact", dnr[3]);
                    dnrRow.put("secondarycontact", dnr[4]);
                    dnrRow.put("email", dnr[5]);

                    dnrRow.put("donorprogramid", facilitydnrs.get(0)[0]);
                    dnrRow.put("donorname", facilitydnrs.get(0)[1]);
                    dnrRow.put("origincountry", facilitydnrs.get(0)[2]);
                    dnrRow.put("donortype", facilitydnrs.get(0)[3]);
                    dnrRow.put("telno", facilitydnrs.get(0)[4]);
                    dnrRow.put("emial", facilitydnrs.get(0)[5]);
                    dnrRow.put("fax", facilitydnrs.get(0)[6]);

                }
                if (dnr[2] != null) {
                    String[] params8 = {"personid"};
                    Object[] paramsValues8 = {(Long) dnr[2]};
                    String where8 = "WHERE personid=:personid";
                    String[] fields8 = {"firstname", "lastname", "othernames"};
                    List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields8, where8, params8, paramsValues8);
                    if (personname != null) {
                        dnrRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1] + " " + personname.get(0)[2]);
                    }
                }
                donor.add(dnrRow);
            }
        }
        model.addAttribute("donorProgramList", donor);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/internaldonorprogram/donorMainPane";

    }

    @RequestMapping(value = "/manageDonorsPane", method = RequestMethod.GET)
    public String manageDonorsPane(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donations = new ArrayList<>();

        if (!"".equals(request.getParameter("contactperson"))) {
            int facilitydonorid = Integer.parseInt(request.getParameter("facilitydonorid"));
            Long contactperson = Long.parseLong(request.getParameter("contactperson"));
            String donorname = request.getParameter("donorname");
            String donortype = request.getParameter("donortype");
            String telno = request.getParameter("telno");
            String email = request.getParameter("email");
            String fax = request.getParameter("fax");
            String origincountry = request.getParameter("origincountry");
            String personname = request.getParameter("personname");
            String primarycontact = request.getParameter("primarycontact");
            String secondarycontact = request.getParameter("secondarycontact");
            String personEmail = request.getParameter("personEmail");

            model.addAttribute("contactperson", contactperson);
            model.addAttribute("facilitydonorid", facilitydonorid);
            model.addAttribute("donorname", donorname);
            model.addAttribute("donortype", donortype);
            model.addAttribute("telno", telno);
            model.addAttribute("email", email);
            model.addAttribute("fax", fax);
            model.addAttribute("origincountry", origincountry);
            model.addAttribute("personname", personname);
            model.addAttribute("primarycontact", primarycontact);
            model.addAttribute("secondarycontact", secondarycontact);
            model.addAttribute("personEmail", personEmail);

            String[] params2 = {"facilitydonorid"};
            Object[] paramsValues2 = {facilitydonorid};
            String[] fields2 = {"donationsid", "donorrefno", "receivedby", "datereceived"};
            String where2 = "WHERE facilitydonorid=:facilitydonorid";
            List<Object[]> facilitydnrs = (List<Object[]>) genericClassService.fetchRecord(Donations.class, fields2, where2, params2, paramsValues2);
            if (facilitydnrs != null) {
                Map<String, Object> donationRow;
                for (Object[] d : facilitydnrs) {
                    donationRow = new HashMap<>();

                    donationRow.put("donationsid", d[0]);
                    donationRow.put("donorrefno", d[1]);
                    donationRow.put("datereceived", new SimpleDateFormat("dd-MM-yyyy").format((Date) d[3]));

                    int donatedItems = 0;
                    String[] params9 = {"donationsid"};
                    Object[] paramsValues9 = {d[0]};
                    String where9 = "WHERE donationsid=:donationsid";
                    donatedItems = genericClassService.fetchRecordCount(Facilityassets.class, where9, params9, paramsValues9);
                    donationRow.put("donatedItemsCount", donatedItems);

                    int donatedMedicineItems = 0;
                    String[] params = {"donationsid", "itemtype"};
                    Object[] paramsValues = {d[0], "MEDICINE"};
                    String where = "WHERE donationsid=:donationsid AND itemtype=:itemtype";
                    donatedMedicineItems = genericClassService.fetchRecordCount(Donationsitems.class, where, params, paramsValues);
                    donationRow.put("donatedMedicineItemsCount", donatedMedicineItems);

                    int totalDonatedItems = donatedMedicineItems + donatedItems;
                    donationRow.put("totalDonatedItems", totalDonatedItems);

                    String[] params8 = {"personid"};
                    Object[] paramsValues8 = {(Long) d[2]};
                    String where8 = "WHERE personid=:personid";
                    String[] fields8 = {"firstname", "lastname", "othernames"};
                    List<Object[]> personnames = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields8, where8, params8, paramsValues8);
                    if (personnames != null) {
                        donationRow.put("personname", personnames.get(0)[0] + " " + personnames.get(0)[1] + " " + personnames.get(0)[2]);
                    }

                    donations.add(donationRow);

                }
            }

        } else {
            int facilitydonorid = Integer.parseInt(request.getParameter("facilitydonorid"));
            String donortype = request.getParameter("donortype");
            String telno = request.getParameter("telno");
            String email = request.getParameter("email");
            String fax = request.getParameter("fax");
            String origincountry = request.getParameter("origincountry");
            String donorname = request.getParameter("donorname");

            model.addAttribute("donorname", donorname);
            model.addAttribute("facilitydonorid", facilitydonorid);
            model.addAttribute("donortype", donortype);
            model.addAttribute("telno", telno);
            model.addAttribute("email", email);
            model.addAttribute("fax", fax);
            model.addAttribute("origincountry", origincountry);

            String[] params2 = {"facilitydonorid"};
            Object[] paramsValues2 = {facilitydonorid};
            String[] fields2 = {"donationsid", "donorrefno", "receivedby", "datereceived"};
            String where2 = "WHERE facilitydonorid=:facilitydonorid";
            List<Object[]> facilitydnrs = (List<Object[]>) genericClassService.fetchRecord(Donations.class, fields2, where2, params2, paramsValues2);
            if (facilitydnrs != null) {
                Map<String, Object> donationRow;
                for (Object[] d : facilitydnrs) {
                    donationRow = new HashMap<>();

                    donationRow.put("donationsid", d[0]);
                    donationRow.put("donorrefno", d[1]);
                    donationRow.put("datereceived", new SimpleDateFormat("dd-MM-yyyy").format((Date) d[3]));

                    int donatedItems = 0;
                    String[] params9 = {"donationsid"};
                    Object[] paramsValues9 = {d[0]};
                    String where9 = "WHERE donationsid=:donationsid";
                    donatedItems = genericClassService.fetchRecordCount(Facilityassets.class, where9, params9, paramsValues9);
                    donationRow.put("donatedItemsCount", donatedItems);

                    int donatedMedicineItems = 0;
                    String[] params = {"donationsid", "itemtype"};
                    Object[] paramsValues = {d[0], "MEDICINE"};
                    String where = "WHERE donationsid=:donationsid AND itemtype=:itemtype";
                    donatedMedicineItems = genericClassService.fetchRecordCount(Donationsitems.class, where, params, paramsValues);
                    donationRow.put("donatedMedicineItemsCount", donatedMedicineItems);

                    int totalDonatedItems = donatedMedicineItems + donatedItems;
                    donationRow.put("totalDonatedItems", totalDonatedItems);

                    String[] params8 = {"personid"};
                    Object[] paramsValues8 = {(Long) d[2]};
                    String where8 = "WHERE personid=:personid";
                    String[] fields8 = {"firstname", "lastname"};
                    List<Object[]> personnames = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields8, where8, params8, paramsValues8);
                    if (personnames != null) {
                        donationRow.put("personname", personnames.get(0)[0] + " " + personnames.get(0)[1]);
                    }

                    donations.add(donationRow);

                }
            }

        }
        model.addAttribute("donationsList", donations);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/internaldonorprogram/donors/views/manageDonorPane";

    }

    @RequestMapping(value = "/viewDonatedItems", method = RequestMethod.GET)
    public String viewDonatedItems(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donatedItems = new ArrayList<>();
        List<Map> otherDonatedItems = new ArrayList<>();

        int donationsid = Integer.parseInt(request.getParameter("donationsid"));
        String donorrefno = request.getParameter("donorrefno");

        model.addAttribute("donorrefno", donorrefno);
        model.addAttribute("donationsid", donationsid);
//Fetching Medicines and supplies donated.
        String[] params3 = {"donationsid", "itemtype"};
        Object[] paramsValues3 = {donationsid, "MEDICINE"};
        String[] fields3 = {"donationsitemsid", "medicalitemsid", "batchno", "expirydate", "qtydonated"};
        String where3 = "WHERE donationsid=:donationsid AND itemtype=:itemtype";
        List<Object[]> facilitydnrs3 = (List<Object[]>) genericClassService.fetchRecord(Donationsitems.class, fields3, where3, params3, paramsValues3);
        if (facilitydnrs3 != null) {
            Map<String, Object> itemsRow;
            for (Object[] di : facilitydnrs3) {
                itemsRow = new HashMap<>();
                DecimalFormat df = new DecimalFormat("#,###");
                
                String[] paramsx = {"donationsitemsid"};
                Object[] paramsValuesx = {di[0]};
                String[] fieldsx = {"consumerunit", "handedoverto", "handoverdate", "qtyhandedover"};
                String wherex = "WHERE donationsitemsid=:donationsitemsid";
                List<Object[]> round = (List<Object[]>) genericClassService.fetchRecord(Donationconsumption.class, fieldsx, wherex, paramsx, paramsValuesx);
                if (round != null) {
                    Map<String, Object> rounds;
                    List<Map> consumingUnits = new ArrayList<>();
                    for (Object[] rnds : round) {
                        rounds = new HashMap<>();
                        rounds.put("consumerunit", rnds[0]);
                        rounds.put("handedoverto", rnds[1]);
                        rounds.put("handoverdate",  new SimpleDateFormat("dd-MM-yyyy").format((Date) rnds[2]));
                        rounds.put("qtyhandedover", String.format("%,d", rnds[3]));
                        //fetching Unit
                        String[] paramsv = {"facilityunitid"};
                        Object[] paramsValuesv = {rnds[0]};
                        String[] fieldsv = {"facilityunitid", "facilityunitname"};
                        String wherev = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> facilityUnit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldsv, wherev, paramsv, paramsValuesv);
                        if (facilityUnit != null) {
                                rounds.put("id", facilityUnit.get(0)[0]);
                                rounds.put("facilityunitname", facilityUnit.get(0)[1]);
                            
                        }

                        //Fetching staff handed over to
                        String[] paramsPersondetailsDeliver = {"staffid"};
                        Object[] paramsValuesPersondetailsDeliver = {rnds[1]};
                        String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                        if (objPersondetailsDeliver != null) {
                            Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                            if (persondetailsDeliver[3] != null) {
                                rounds.put("handedto", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                            } else {
                                rounds.put("handedto", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                            }
                        }
                        consumingUnits.add(rounds);
                    }
                    itemsRow.put("donatedMedicineItemsFacUnitCount", consumingUnits.size());
                    itemsRow.put("comsumedAmt", consumingUnits);
                }else{
                    itemsRow.put("donatedMedicineItemsFacUnitCount", 0);
                }

                String[] params4 = {"itemid"};
                Object[] paramsValues4 = {di[1]};
                String[] fields4 = {"itemid", "medicalitemid"};
                String where4 = "WHERE itemid=:itemid";
                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields4, where4, params4, paramsValues4);
                if (items != null) {
                    for (Object[] medicItems : items) {
                        itemsRow.put("itemid", medicItems[0]);

                        String[] params5 = {"medicalitemid"};
                        Object[] paramsValues5 = {medicItems[1]};
                        String[] fields5 = {"medicalitemid", "genericname", "itemstrength"};
                        String where5 = "WHERE medicalitemid=:medicalitemid";
                        List<Object[]> items4 = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields5, where5, params5, paramsValues5);
                        if (items4 != null) {
                            for (Object[] it : items4) {
                                itemsRow.put("medicalitemid", it[0]);
                                itemsRow.put("genericname", it[1]);
                                itemsRow.put("itemstrength", it[2]);

                                itemsRow.put("donationsitemsid", di[0]);
                                itemsRow.put("medicalitemsid", di[1]);
                                itemsRow.put("batchno", di[2]);
                                itemsRow.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) di[3]));
                                itemsRow.put("qtydonated", df.format(di[4]));
                            }
                        }
                    }
                }
                donatedItems.add(itemsRow);
            }
        }
//Fetching Other Donated Items
        String[] paramse = {"donationsid", "isdonated"};
        Object[] paramsValuese = {donationsid, Boolean.TRUE};
        String[] fieldse = {"facilityassetsid", "assetsid", "assetqty", "itemspecification"};
        String wheree = "WHERE donationsid=:donationsid AND isdonated=:isdonated";
        List<Object[]> facilitydnrse = (List<Object[]>) genericClassService.fetchRecord(Facilityassets.class, fieldse, wheree, paramse, paramsValuese);
        if (facilitydnrse != null) {
            Map<String, Object> otherItemsRow;
            for (Object[] di : facilitydnrse) {
                otherItemsRow = new HashMap<>();
                String[] params4 = {"assetsid"};
                Object[] paramsValues4 = {di[1]};
                String[] fields4 = {"assetsid", "assetsname"};
                String where4 = "WHERE assetsid=:assetsid";
                List<Object[]> otheritems = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fields4, where4, params4, paramsValues4);
                if (otheritems != null) {
                    for (Object[] otherItems : otheritems) {
                        otherItemsRow.put("assetsid", otherItems[0]);
                        otherItemsRow.put("assetsname", otherItems[1]);

                        otherItemsRow.put("facilityassetsid", di[0]);
                        otherItemsRow.put("assetsid", di[1]);
                        otherItemsRow.put("assetqty", di[2]);
                        otherItemsRow.put("itemspecification", di[3]);

                    }
                }
                otherDonatedItems.add(otherItemsRow);
            }
        }

        model.addAttribute("donatedItemsList", donatedItems);
        model.addAttribute("otherDonatedItemsList", otherDonatedItems);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/internaldonorprogram/donations/views/viewDonatedItems";

    }

    @RequestMapping(value = "/viewDonationHistory", method = RequestMethod.GET)
    public String viewDonationHistory(HttpServletRequest request, Model model) {
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/internaldonorprogram/donors/views/donationHistrory";

    }

    @RequestMapping(value = "/viewDonationsToTransfer", method = RequestMethod.GET)
    public String viewDonationsToTransfer(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donor1 = new ArrayList<>();
        int handovertablesize = 0;
        int qtyhandedovernocommas = 0;
        int qtynocommas = 0;
        int qtydonatednocommas = 0;
        int qtyhandedovernocommas1 = 0;
        int qtynocommas1 = 0;
        int qtydonatednocommas1 = 0;

        String[] params1 = {"facilityid"};
        Object[] paramsValues1 = {facilityid};
        String where1 = "WHERE facilityid=:facilityid";
        String[] fields1 = {"facilitydonorid", "donorprogramid"};
        List<Object[]> dnrProg = (List<Object[]>) genericClassService.fetchRecord(Facilitydonor.class, fields1, where1, params1, paramsValues1);
        if (dnrProg != null) {
            Map<String, Object> dnrRow;
            for (Object[] dnr : dnrProg) {
                DecimalFormat df = new DecimalFormat("#,###");

                String[] paramsv = {"donorprogramid"};
                Object[] paramsValuesv = {dnr[1]};
                String[] fieldsv = {"donorprogramid", "donorname", "donortype"};
                String wherev = "WHERE donorprogramid=:donorprogramid";
                List<Object[]> facilitydnrsv = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fieldsv, wherev, paramsv, paramsValuesv);
                if (facilitydnrsv != null) {

                }

                String[] params2 = {"facilitydonorid"};
                Object[] paramsValues2 = {dnr[0]};
                String[] fields2 = {"donationsid", "donorrefno"};
                String where2 = "WHERE facilitydonorid=:facilitydonorid";
                List<Object[]> facilitydnrs = (List<Object[]>) genericClassService.fetchRecord(Donations.class, fields2, where2, params2, paramsValues2);
                if (facilitydnrs != null) {
                    for (Object[] d : facilitydnrs) {
                        String[] params3 = {"donationsid"};
                        Object[] paramsValues3 = {d[0]};
                        String[] fields3 = {"donationsitemsid", "medicalitemsid", "batchno", "expirydate", "qtydonated"};
                        String where3 = "WHERE donationsid=:donationsid";
                        List<Object[]> facilitydnrs3 = (List<Object[]>) genericClassService.fetchRecord(Donationsitems.class, fields3, where3, params3, paramsValues3);
                        if (facilitydnrs3 != null) {
                            for (Object[] v : facilitydnrs3) {
                                dnrRow = new HashMap<>();
                                String[] params = {"donationsitemsid"};
                                Object[] paramsValues6 = {v[0]};
                                String[] fields6 = {"donationconsumptionid", "qtyhandedover"};
                                String where6 = "WHERE donationsitemsid=:donationsitemsid";
                                List<Object[]> consp = (List<Object[]>) genericClassService.fetchRecord(Donationconsumption.class, fields6, where6, params, paramsValues6);
                                if (consp != null) {
                                    int sumx1m = 0;
                                    for (Object[] c : consp) {
                                        qtyhandedovernocommas = (Integer) c[1];
                                        qtynocommas = (Integer) v[4];
                                        sumx1m += qtyhandedovernocommas;
                                    }
                                    qtydonatednocommas = qtynocommas - sumx1m;
                                    dnrRow.put("qtydonated", df.format(qtydonatednocommas));
                                    dnrRow.put("qtydonatednocommas", qtydonatednocommas);

                                } else {
                                    dnrRow.put("qtydonated", df.format((v)[4]));
                                    dnrRow.put("qtydonatednocommas", v[4]);
                                }

                                String[] params4 = {"itempackageid", "isactive"};
                                Object[] paramsValues4 = {v[1], Boolean.TRUE};
                                String[] fields4 = {"itemid", "packagename"};
                                String where4 = "WHERE itempackageid=:itempackageid AND isactive=:isactive";
                                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields4, where4, params4, paramsValues4);
                                if (items != null) {
                                    //dnrRow.put("itemid", items.get(0)[0]);
                                    dnrRow.put("packagename", items.get(0)[1]);

                                    dnrRow.put("facilitydonorid", d[0]);
                                    dnrRow.put("donorrefno", d[1]);

                                    dnrRow.put("donorprogramid", dnr[1]);
                                    dnrRow.put("donorname", facilitydnrsv.get(0)[1]);
                                    dnrRow.put("donortype", facilitydnrsv.get(0)[2]);

                                }
                                dnrRow.put("donationsitemsid", v[0]);
                                dnrRow.put("itemid", v[1]);
                                dnrRow.put("batchno", v[2]);
                                dnrRow.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) v[3]));

                                donor1.add(dnrRow);

                            }

                        }

                    }
                }
            }
        }
        model.addAttribute("donorList", donor1);

        int itemHandoverListsize = donor1.size();
        handovertablesize = handovertablesize + itemHandoverListsize;

        model.addAttribute("handovertablesize", handovertablesize);

        String jsonDonatedItems = "";
        try {
            jsonDonatedItems = new ObjectMapper().writeValueAsString(donor1);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("donatedItemsJSON", jsonDonatedItems);
        model.addAttribute("donatedItemsJSONSize", jsonDonatedItems.length());

        String jsonFacUnits = "";
        List<Map> facUnits = new ArrayList<>();

        String[] paramsv = {"facilityid"};
        Object[] paramsValuesv = {facilityid};
        String[] fieldsv = {"facilityunitid", "facilityunitname"};
        String wherev = "WHERE facilityid=:facilityid";
        List<Object[]> facilityUnit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldsv, wherev, paramsv, paramsValuesv);
        if (facilityUnit != null) {
            Map<String, Object> dnrRow;
            for (Object[] unit : facilityUnit) {
                dnrRow = new HashMap<>();
                dnrRow.put("id", unit[0]);
                dnrRow.put("facilityunitname", unit[1]);

                facUnits.add(dnrRow);
            }
            model.addAttribute("FacUnit", facUnits);
        }

        try {
            jsonFacUnits = new ObjectMapper().writeValueAsString(facUnits);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonFacUnits", jsonFacUnits);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));

        return "inventoryAndSupplies/internaldonorprogram/donations/views/viewTransferDonations";
    }

    @RequestMapping(value = "/receiveSentDonations.htm", method = RequestMethod.GET)
    public String receiveSentDonations(HttpServletRequest request, Model model) {
        List<Map> readyDonationsList = new ArrayList<>();
        int handovertablesizes = 0;

        //Fetch Facility Orders
        String[] paramsfacilityunitReadyDonations = {"consumerunit", "isdelivered"};
        Object[] paramsValuesfacilitunitReadyDonations = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), false};
        String[] fieldsunitReadyDonations = {"donationconsumptionid", "handedoverto", "qtyhandedover", "handoverdate", "donationsitemsid", "handoverunit"};
        String whereunitReadyDonations = "WHERE consumerunit=:consumerunit AND isdelivered=:isdelivered";
        List<Object[]> objfunitReadyDonations = (List<Object[]>) genericClassService.fetchRecord(Donationconsumption.class, fieldsunitReadyDonations, whereunitReadyDonations, paramsfacilityunitReadyDonations, paramsValuesfacilitunitReadyDonations);
        if (objfunitReadyDonations != null) {
            Map<String, Object> mapReadyDonations;
            for (Object[] readyDonations : objfunitReadyDonations) {
                DecimalFormat df = new DecimalFormat("#,###");
                mapReadyDonations = new HashMap<>();
                mapReadyDonations.put("donationconsumptionid", readyDonations[0]);
                mapReadyDonations.put("staffid", readyDonations[1]);
                mapReadyDonations.put("qtyhandedovernocommas", readyDonations[2]);
                mapReadyDonations.put("qtyhandedover", df.format(readyDonations[2]));
                mapReadyDonations.put("donationsitemsid", readyDonations[4]);
                model.addAttribute("handoverdate", new SimpleDateFormat("dd-MM-yyyy").format((Date) readyDonations[3]));

                String[] params3 = {"donationsitemsid"};
                Object[] paramsValues3 = {readyDonations[4]};
                String[] fields3 = {"donationsitemsid", "medicalitemsid", "batchno", "expirydate", "donationsid"};
                String where3 = "WHERE donationsitemsid=:donationsitemsid";
                List<Object[]> facilitydnrs3 = (List<Object[]>) genericClassService.fetchRecord(Donationsitems.class, fields3, where3, params3, paramsValues3);
                if (facilitydnrs3 != null) {
                    for (Object[] v : facilitydnrs3) {

                        String[] paramsd = {"donationsid"};
                        Object[] paramsValuesd = {v[4]};
                        String[] fieldsd = {"donorrefno", "facilitydonorid"};
                        String whered = "WHERE donationsid=:donationsid";
                        List<Object[]> donations = (List<Object[]>) genericClassService.fetchRecord(Donations.class, fieldsd, whered, paramsd, paramsValuesd);
                        if (donations != null) {
                            for (Object[] d : donations) {
                                mapReadyDonations.put("donorrefno", d[0]);

                                String[] paramsf = {"facilitydonorid"};
                                Object[] paramsValuesf = {(Integer) d[1]};
                                String[] fieldsf = {"donorprogramid", "addedby"};
                                String wheref = "WHERE facilitydonorid=:facilitydonorid";
                                List<Object[]> facDonor = (List<Object[]>) genericClassService.fetchRecord(Facilitydonor.class, fieldsf, wheref, paramsf, paramsValuesf);
                                if (facDonor != null) {
                                    mapReadyDonations.put("donorprogramid", facDonor.get(0)[0]);
                                }
                            }

                        }

                        String[] params4 = {"itempackageid", "isactive"};
                        Object[] paramsValues4 = {v[1], Boolean.TRUE};
                        String[] fields4 = {"itemid", "packagename"};
                        String where4 = "WHERE itempackageid=:itempackageid AND isactive=:isactive";
                        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields4, where4, params4, paramsValues4);
                        if (items != null) {
                            //dnrRow.put("itemid", items.get(0)[0]);
                            mapReadyDonations.put("packagename", items.get(0)[1]);
                        }
                        mapReadyDonations.put("itemid", v[1]);
                        mapReadyDonations.put("batchno", v[2]);
                        mapReadyDonations.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) v[3]));
                    }

                }

                //Fetch Facility Units
//                String[] paramsfunits = {"facilityunitid"};
//                Object[] paramsValuesfunit = {(BigInteger)readyDonations[5]};
//                String wherefunit = "WHERE facilityunitid=:facilityunitid";
//                String[] fieldsfunit = {"facilityunitname"};
//                List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
//                if (facilityunitnames != null) {
//                    mapReadyDonations.put("handoverunit", facilityunitnames.get(0));
//                }
                //Query Staff details
                String[] paramsPersondetailsDeliver = {"staffid"};
                Object[] paramsValuesPersondetailsDeliver = {readyDonations[1]};
                String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                if (objPersondetailsDeliver != null) {
                    Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                    if (persondetailsDeliver[3] != null) {
                        model.addAttribute("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                    } else {
                        model.addAttribute("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                    }
                }

                readyDonationsList.add(mapReadyDonations);
            }

            int itemHandoverListsize = readyDonationsList.size();
            handovertablesizes = handovertablesizes + itemHandoverListsize;
            model.addAttribute("readyDonationsList", readyDonationsList);
            model.addAttribute("handovertablesizes", handovertablesizes);
            model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        }
        return "inventoryAndSupplies/inventory/views/receiveSentDonations/receiveSentDonationsPane";
    }

    @RequestMapping(value = "/transferOtherItems", method = RequestMethod.GET)
    public String transferOtherItems(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donor = new ArrayList<>();

        String[] params1 = {"facilityid"};
        Object[] paramsValues1 = {facilityid};
        String where1 = "WHERE facilityid=:facilityid";
        String[] fields1 = {"facilitydonorid"};
        List<Integer> dnrProg = (List<Integer>) genericClassService.fetchRecord(Facilitydonor.class, fields1, where1, params1, paramsValues1);
        if (dnrProg != null) {
            Map<String, Object> dnrRow;
            for (Integer dnr : dnrProg) {
                DecimalFormat df = new DecimalFormat("#,###");
                String[] params2 = {"facilitydonorid"};
                Object[] paramsValues2 = {dnr};
                String[] fields2 = {"donationsid"};
                String where2 = "WHERE facilitydonorid=:facilitydonorid";
                List<Integer> facilitydnrs = (List<Integer>) genericClassService.fetchRecord(Donations.class, fields2, where2, params2, paramsValues2);
                if (facilitydnrs != null) {
                    for (Integer d : facilitydnrs) {
                        String[] params3 = {"donationsid", "isdonated", "allocated"};
                        Object[] paramsValues3 = {d, Boolean.TRUE, "FULLYALLOCATED"};
                        String[] fields3 = {"facilityassetsid", "assetsid", "assetqty", "olddonatedqty", "itemspecification"};
                        String where3 = "WHERE donationsid=:donationsid AND isdonated=:isdonated AND allocated!=:allocated";
                        List<Object[]> facilitydnrs3 = (List<Object[]>) genericClassService.fetchRecord(Facilityassets.class, fields3, where3, params3, paramsValues3);
                        if (facilitydnrs3 != null) {
                            for (Object[] di : facilitydnrs3) {
                                dnrRow = new HashMap<>();
                                dnrRow.put("facilitydonorid", dnr);
                                String[] params4 = {"assetsid"};
                                Object[] paramsValues4 = {di[1]};
                                String[] fields4 = {"assetsid", "assetsname"};
                                String where4 = "WHERE assetsid=:assetsid";
                                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fields4, where4, params4, paramsValues4);
                                if (items != null) {
                                    dnrRow.put("assetsid", items.get(0)[0]);
                                    dnrRow.put("assetsname", items.get(0)[1]);
                                }
                                dnrRow.put("facilityassetsid", di[0]);
                                dnrRow.put("assetsid", di[1]);
                                dnrRow.put("assetqty", df.format(di[2]));
                                dnrRow.put("assetqtynocommas", di[2]);
                                dnrRow.put("olddonatedqty", di[3]);
                                dnrRow.put("itemspecification", di[4]);

                                donor.add(dnrRow);
                            }
                        }

                    }

                }
            }

        }
        model.addAttribute("otherDonorList", donor);
        String jsonOtherDonatedItems = "";
        try {
            jsonOtherDonatedItems = new ObjectMapper().writeValueAsString(donor);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("donatedOtherItemsJSON", jsonOtherDonatedItems);

        String jsonFacUnits = "";
        List<Map> facUnit = new ArrayList<>();

        String[] paramsv = {"facilityid"};
        Object[] paramsValuesv = {facilityid};
        String[] fieldsv = {"facilityunitid", "facilityunitname"};
        String wherev = "WHERE facilityid=:facilityid";
        List<Object[]> facilityUnit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldsv, wherev, paramsv, paramsValuesv);
        if (facilityUnit != null) {
            Map<String, Object> dnrRow;
            for (Object[] unit : facilityUnit) {
                dnrRow = new HashMap<>();
                dnrRow.put("id", unit[0]);
                dnrRow.put("name", unit[1]);

                facUnit.add(dnrRow);
            }
            model.addAttribute("FacUnits", facUnit);
        }

        try {
            jsonFacUnits = new ObjectMapper().writeValueAsString(facUnit);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonFacUnits", jsonFacUnits);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));

        return "inventoryAndSupplies/internaldonorprogram/donations/views/otherItems";

    }

    @RequestMapping(value = "/checkDonorName.htm")
    public @ResponseBody
    String checkDonorName(HttpServletRequest request, @ModelAttribute("donorname") String donorname) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        String results = "";
        //FETCHING FACILITY DONOR IDS
        List<Integer> facDonorIds = new ArrayList<>();
        String[] paramfacDonor = {"facilityid"};
        Object[] paramsValuesfacDonor = {facilityid};
        String wherefacDonor = "WHERE facilityid=:facilityid";
        String[] fieldsfacDonor = {"donorprogramid"};
        List<Integer> objfacDonor = (List<Integer>) genericClassService.fetchRecord(Facilitydonor.class, fieldsfacDonor, wherefacDonor, paramfacDonor, paramsValuesfacDonor);
        if (objfacDonor != null) {
            for (Integer component2 : objfacDonor) {

                String[] paramszr = {"donorprogramid", "donorname"};
                Object[] paramsValueszr = {component2, donorname.trim().toLowerCase() + "%"};
                String[] fieldszr = {"donorprogramid", "donorname"};
                String wherezr = "WHERE donorprogramid=:donorprogramid AND (LOWER(donorname) LIKE :donorname)";
                List<Object[]> donor = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fieldszr, wherezr, paramszr, paramsValueszr);
                if (donor != null) {
                    results = "existing";
                } else {
                    results = "not existing";
                }
            }
        }
        return results;
    }

    @RequestMapping(value = "/searchFacilityDonors", method = RequestMethod.POST)
    public @ResponseBody
    String searchFacilityDonors(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donors = new ArrayList<>();
        String results = "";

        //FETCHING UNIVERSAL DONOR IDS
        List<Integer> universalDonorIds = new ArrayList<>();
        String[] paramunidonors = {"donorname"};
        Object[] paramsValuesunidonors = {searchValue.trim().toLowerCase() + "%"};
        String whereunidonors = "WHERE (LOWER(donorname) LIKE :donorname)";
        String[] fieldsunidonors = {"donorprogramid"};
        List<Integer> objunidonors = (List<Integer>) genericClassService.fetchRecord(Donorprogram.class, fieldsunidonors, whereunidonors, paramunidonors, paramsValuesunidonors);
        if (objunidonors != null) {
            for (Integer lComps : objunidonors) {
                universalDonorIds.add(lComps);
            }
        }
//FETCHING FACILITY DONOR IDS
        List<Integer> facDonorIds = new ArrayList<>();
        String[] paramfacDonor = {"facilityid"};
        Object[] paramsValuesfacDonor = {facilityid};
        String wherefacDonor = "WHERE facilityid=:facilityid";
        String[] fieldsfacDonor = {"donorprogramid"};
        List<Integer> objfacDonor = (List<Integer>) genericClassService.fetchRecord(Facilitydonor.class, fieldsfacDonor, wherefacDonor, paramfacDonor, paramsValuesfacDonor);
        if (objfacDonor != null) {
            for (Integer component2 : objfacDonor) {
                facDonorIds.add(component2);
            }
        }
        //Remove already added donors to the facility
        universalDonorIds.removeAll(facDonorIds);

        for (int newGlobalDonorList : universalDonorIds) {
            try {
                String[] paramszr = {"donorprogramid"};
                Object[] paramsValueszr = {newGlobalDonorList};
                String[] fieldszr = {"donorprogramid", "donorname", "telno", "emial", "fax", "origincountry"};
                String wherezr = "WHERE donorprogramid=:donorprogramid";
                List<Object[]> donor = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fieldszr, wherezr, paramszr, paramsValueszr);
                if (donor != null) {
                    Map<String, Object> dnrs;
                    for (Object[] d : donor) {
                        dnrs = new HashMap<>();

                        dnrs.put("data", d[0]);
                        dnrs.put("value", d[1]);
                        dnrs.put("telno", d[2]);
                        dnrs.put("emial", d[3]);
                        dnrs.put("fax", d[4]);
                        dnrs.put("origincountry", d[5]);

                        donors.add(dnrs);
                    }

                }
                results = new ObjectMapper().writeValueAsString(donors);
            } catch (Exception ex) {
                System.out.println(ex);
            }
        }

        return results;
    }

    //checking donor name
    @RequestMapping(value = "/checkFacilityDonors", method = RequestMethod.POST)
    public @ResponseBody
    String checkFacilityDonors(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donors = new ArrayList<>();
        String results = "";

        //FETCHING UNIVERSAL DONOR IDS
        List<Integer> universalDonorIds = new ArrayList<>();
        String[] paramunidonors = {"donorname"};
        Object[] paramsValuesunidonors = {searchValue.trim().toLowerCase() + "%"};
        String whereunidonors = "WHERE (LOWER(donorname) LIKE :donorname)";
        String[] fieldsunidonors = {"donorprogramid"};
        List<Integer> objunidonors = (List<Integer>) genericClassService.fetchRecord(Donorprogram.class, fieldsunidonors, whereunidonors, paramunidonors, paramsValuesunidonors);
        if (objunidonors != null) {
            for (Integer lComps : objunidonors) {
                String[] paramfacDonor = {"facilityid", "donorprogramid"};
                Object[] paramsValuesfacDonor = {facilityid, lComps};
                String wherefacDonor = "WHERE facilityid=:facilityid AND donorprogramid=:donorprogramid";
                String[] fieldsfacDonor = {"donorprogramid"};
                List<Integer> objfacDonor = (List<Integer>) genericClassService.fetchRecord(Facilitydonor.class, fieldsfacDonor, wherefacDonor, paramfacDonor, paramsValuesfacDonor);
                if (objfacDonor != null) {
                    results = "existing";
                }
            }
        }
//FETCHING FACILITY DONOR IDS

        //Remove already added donors to the facility
//        universalDonorIds.removeAll(facDonorIds);
//
//        for (int newGlobalDonorList : universalDonorIds) {
//            System.out.println("----------------NEW DONORS newGlobalDonorList--------------------2222222222" + newGlobalDonorList);
//            try {
//                String[] paramszr = {"donorprogramid"};
//                Object[] paramsValueszr = {newGlobalDonorList};
//                String[] fieldszr = {"donorprogramid", "donorname", "telno", "emial", "fax", "origincountry"};
//                String wherezr = "WHERE donorprogramid=:donorprogramid";
//                List<Object[]> donor = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fieldszr, wherezr, paramszr, paramsValueszr);
//                if (donor != null) {
//                    Map<String, Object> dnrs;
//                    for (Object[] d : donor) {
//                        dnrs = new HashMap<>();
//
//                        dnrs.put("data", d[0]);
//                        dnrs.put("value", d[1]);
//                        dnrs.put("telno", d[2]);
//                        dnrs.put("emial", d[3]);
//                        dnrs.put("fax", d[4]);
//                        dnrs.put("origincountry", d[5]);
//
//                        donors.add(dnrs);
//                    }
//
//                }
//                results = new ObjectMapper().writeValueAsString(donors);
//            } catch (Exception ex) {
//                System.out.println(ex);
//            }
        return results;
    }

    @RequestMapping(value = "/searchIndividualFacilityDonors", method = RequestMethod.POST)
    public @ResponseBody
    String searchIndividualFacilityDonors(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donored = new ArrayList<>();
        String results = "";
        //FETCHING UNIVERSAL DONOR IDS
        List<Integer> universalDonorIds = new ArrayList<>();
        String[] paramunidonors1 = {"donorname","donortype"};
        Object[] paramsValuesunidonors1 = {searchValue.trim().toLowerCase() + "%","Individual"};
        String whereunidonors1 = "WHERE (LOWER(donorname) LIKE :donorname) AND donortype=:donortype";
        String[] fieldsunidonors1 = {"donorprogramid"};
        List<Integer> objunidonors1 = (List<Integer>) genericClassService.fetchRecord(Donorprogram.class, fieldsunidonors1, whereunidonors1, paramunidonors1, paramsValuesunidonors1);
        if (objunidonors1 != null) {
            for (Integer lComps1 : objunidonors1) {
                universalDonorIds.add(lComps1);
            }
        }

//FETCHING FACILITY DONOR IDS
        List<Integer> facDonorIds = new ArrayList<>();
        String[] paramfacDonor = {"facilityid"};
        Object[] paramsValuesfacDonor = {facilityid};
        String wherefacDonor = "WHERE facilityid=:facilityid";
        String[] fieldsfacDonor = {"donorprogramid"};
        List<Integer> objfacDonor = (List<Integer>) genericClassService.fetchRecord(Facilitydonor.class, fieldsfacDonor, wherefacDonor, paramfacDonor, paramsValuesfacDonor);
        if (objfacDonor != null) {
            for (Integer component2 : objfacDonor) {
                facDonorIds.add(component2);
            }
        }
        //Remove already added donors to the facility
        universalDonorIds.removeAll(facDonorIds);
        for (int newGlobalDonorList : universalDonorIds) {
            try {
                String[] paramszr = {"donorprogramid"};
                Object[] paramsValueszr = {newGlobalDonorList};
                String[] fieldszr = {"donorprogramid", "donorname", "telno", "fax", "emial", "origincountry"};
                String wherezr = "WHERE donorprogramid=:donorprogramid";
                List<Object[]> donor = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fieldszr, wherezr, paramszr, paramsValueszr);
                if (donor != null) {
                    Map<String, Object> dnrs;
                    for (Object[] d : donor) {
                        dnrs = new HashMap<>();

                        dnrs.put("data", d[0]);
                        dnrs.put("value", d[1]);
                        dnrs.put("primarycontact", d[2]);
                        dnrs.put("secondarycontact", d[3]);
                        dnrs.put("email", d[4]);
                        dnrs.put("origincountry", d[5]);
                        donored.add(dnrs);
                    }

                }
                results = new ObjectMapper().writeValueAsString(donored);
            } catch (Exception ex) {
                System.out.println(ex);
            }
        }

        return results;
    }

    @RequestMapping(value = "/searchFacilityContactPerson", method = RequestMethod.POST)
    public @ResponseBody
    String searchFacilityContactPerson(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> contactPerson = new ArrayList<>();
        String results = "";
        //Remove already added donors to the facility
        try {
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"contactperson", "primarycontact", "secondarycontact", "email"};
            String where = "";
            List<Object[]> contactPrsn = (List<Object[]>) genericClassService.fetchRecord(Facilitydonor.class, fields, where, params, paramsValues);
            if (contactPrsn != null) {
                Map<String, Object> facPrsn;
                for (Object[] c : contactPrsn) {
                    facPrsn = new HashMap<>();
                    if (c[0] != null) {
                        String[] params8 = {"personid"};
                        Object[] paramsValues8 = {c[0]};
                        String where8 = "WHERE personid=:personid";
                        String[] fields8 = {"firstname", "lastname", "othernames"};
                        List<Object[]> personnames = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields8, where8, params8, paramsValues8);
                        if (personnames != null) {
                            facPrsn.put("value", personnames.get(0)[0] + " " + personnames.get(0)[1] + " " + personnames.get(0)[2]);

                            facPrsn.put("data", c[0]);
                            facPrsn.put("firstname", personnames.get(0)[0]);
                            facPrsn.put("lastname", personnames.get(0)[1]);
                            facPrsn.put("othernames", personnames.get(0)[2]);
                            facPrsn.put("primarycontact", c[1]);
                            facPrsn.put("secondarycontact", c[2]);
                            facPrsn.put("email", c[3]);

                            contactPerson.add(facPrsn);
                        }
                    }

                }

            }
            results = new ObjectMapper().writeValueAsString(contactPerson);
        } catch (Exception ex) {
            System.out.println(ex);
        }

        return results;
    }

    @RequestMapping(value = "/searchItem", method = RequestMethod.GET)
    public String searchItem(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params = {"value", "name", "isactive"};
        Object[] paramsValues = {searchValue.trim().toLowerCase() + "%", searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
        String[] fields = {"itempackageid", "packagename", "packagequantity", "packname", "measure"};
        String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(itemcode) LIKE :value) ORDER BY packagename";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            Map<String, Object> classification;
            for (Object[] object : classficationList) {
                classification = new HashMap<>();
                classification.put("id", object[0]);
                classification.put("name", object[1]);
                classification.put("packqty", object[2]);
                classification.put("packname", object[3]);
                classification.put("measure", object[4]);
                itemsFound.add(classification);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("items", itemsFound);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/internaldonorprogram/donors/views/itemSearchResults";
    }

    @RequestMapping(value = "/registerNewDonor", method = RequestMethod.GET)
    public String registerNewDonor(HttpServletRequest request, Model model) {

        return "inventoryAndSupplies/internaldonorprogram/donors/forms/registerdonor";
    }

    @RequestMapping(value = "/editDonorDetails", method = RequestMethod.GET)
    public String editDonorDetails(HttpServletRequest request, Model model) {

        int facilitydonorid = Integer.parseInt(request.getParameter("facilitydonorid"));
        Long contactperson = Long.parseLong(request.getParameter("contactperson"));
        String primarycontact = request.getParameter("primarycontact");
        String secondarycontact = request.getParameter("secondarycontact");
        String email = request.getParameter("email");
        String personname = request.getParameter("personname");

        model.addAttribute("facilitydonorid", facilitydonorid);
        model.addAttribute("contactperson", contactperson);
        model.addAttribute("primarycontact", primarycontact);
        model.addAttribute("secondarycontact", secondarycontact);
        model.addAttribute("email", email);
        model.addAttribute("personname", personname);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/internaldonorprogram/donors/forms/editdonordetails";
    }

    @RequestMapping(value = "/updateDonorDetails", method = RequestMethod.POST)
    public @ResponseBody
    String updateDonorDetails(Model model, HttpServletRequest request) {
        int donorprogramid = Integer.parseInt(request.getParameter("donorprogramid"));
        String donorname = request.getParameter("donorname");
        Object updatedby = request.getSession().getAttribute("person_id");
        String telno = request.getParameter("donorname");
        String fax = request.getParameter("fax");
        String email = request.getParameter("email");
        String origincountry = request.getParameter("origincountry");
        String donortype = request.getParameter("donortype");

        String[] columns = {"donorname", "telno", "fax", "email", "origincountry", "donortype", "updatedby", "dateupdated"};
        Object[] columnValues = {donorname, telno, fax, email, origincountry, donortype, updatedby, new Date()};
        String pk = "donorprogramid";
        Object pkValue = donorprogramid;
        genericClassService.updateRecordSQLSchemaStyle(Donorprogram.class, columns, columnValues, pk, pkValue, "store");
        return "";
    }

    @RequestMapping(value = "/viewDonorDetails", method = RequestMethod.GET)
    public String viewDonorDetails(HttpServletRequest request, Model model) {

        int donorprogramid = Integer.parseInt(request.getParameter("donorprogramid"));
        String donorname = request.getParameter("donorname");
        String telno = request.getParameter("telno");
        String email = request.getParameter("email");
        String fax = request.getParameter("fax");

        model.addAttribute("donorprogramid", donorprogramid);
        model.addAttribute("donorname", donorname);
        model.addAttribute("telno", telno);
        model.addAttribute("email", email);
        model.addAttribute("fax", fax);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));

        return "inventoryAndSupplies/internaldonorprogram/donors/views/viewdonordetails";

    }

    @RequestMapping(value = "/fetchOtherDonorItems", method = RequestMethod.POST)
    public @ResponseBody
    String fetchOtherDonorItems(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String donoritemname) {
        String results = "";
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> donors = new ArrayList<>();
        //FETCHING UNIVERSAL DONOR IDS
        List<Integer> universalOtherItemsIds = new ArrayList<>();
        String[] paramuniitems = {"assetsname"};
        Object[] paramsValuesuniitems = {donoritemname.trim().toLowerCase() + "%"};
        String whereuniitems = "WHERE (LOWER(assetsname) LIKE :assetsname)";
        String[] fieldsuniitems = {"assetsid"};
        List<Integer> objuniotheritems = (List<Integer>) genericClassService.fetchRecord(Assets.class, fieldsuniitems, whereuniitems, paramuniitems, paramsValuesuniitems);
        if (objuniotheritems != null) {
            for (Integer dComps : objuniotheritems) {
                universalOtherItemsIds.add(dComps);
            }
        }
//FETCHING FACILITY DONOR IDS
        List<Integer> facOtherItemsIds = new ArrayList<>();
        String[] paramfacDonor = {"facilityid", "isdonated"};
        Object[] paramsValuesfacDonor = {facilityid, Boolean.TRUE};
        String wherefacDonor = "WHERE facilityid=:facilityid AND isdonated=:isdonated";
        String[] fieldsfacDonor = {"assetsid"};
        List<Integer> objFacOtherItems = (List<Integer>) genericClassService.fetchRecord(Facilityassets.class, fieldsfacDonor, wherefacDonor, paramfacDonor, paramsValuesfacDonor);
        if (objFacOtherItems != null) {
            for (Integer component2 : objFacOtherItems) {
                facOtherItemsIds.add(component2);
            }
        }
        //Remove already added donors to the facility
        universalOtherItemsIds.removeAll(facOtherItemsIds);
        for (int newGlobalOtherItemsList : universalOtherItemsIds) {
            try {
                String[] paramszr = {"assetsid"};
                Object[] paramsValueszr = {newGlobalOtherItemsList};
                String[] fieldszr = {"assetsid", "assetsname", "assettype"};
                String wherezr = "WHERE assetsid=:assetsid";
                List<Object[]> donor = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fieldszr, wherezr, paramszr, paramsValueszr);
                if (donor != null) {
                    Map<String, Object> dnrs;
                    for (Object[] d : donor) {
                        dnrs = new HashMap<>();
                        dnrs.put("data", d[0]);
                        dnrs.put("value", d[1]);
                        dnrs.put("assettype", d[2]);
                        donors.add(dnrs);
                    }

                }
                results = new ObjectMapper().writeValueAsString(donors);
            } catch (Exception ex) {
                System.out.println(ex);
            }
        }
        return results;
    }

    @RequestMapping(value = "/checkBatchNo.htm")
    public @ResponseBody
    String checkBatchNo(HttpServletRequest request) {
        String results = "";
        String batchnumber = request.getParameter("batchno");
        Long itemid = Long.parseLong(request.getParameter("itemid"));
        String[] params = {"batchnumber"};
        Object[] paramsValues = {batchnumber};
        String[] fields = {"batchnumber", "expirydate"};
        String where = "WHERE batchnumber =:batchnumber";
        List<Object[]> stockList = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramsValues);
        if (stockList != null) {
            results = new SimpleDateFormat("dd-MM-yyyy").format((Date) stockList.get(0)[1]);
        }
        return results;
    }

    @RequestMapping(value = "/saveDeliveredUnitDonorStock.htm", method = RequestMethod.GET)
    public @ResponseBody
    String saveDeliveredUnitDonorStock(Model model, HttpServletRequest request) throws IOException, ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            long currentFacilityUnitid = Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")));
            Set<Long> facilityorderitemsset2 = new HashSet<>();
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String result = "";
            String ordernumber = request.getParameter("ordernumber");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            BigInteger deliveredto = BigInteger.valueOf(Long.parseLong(request.getParameter("staffid")));

            String[] paramsysuser = {"username", "password"};
            Object[] paramsValuessysuser = {username, password};
            String[] fieldssysuser = {"systemuserid", "personid.personid", "active"};
            String wheresysuser = "WHERE username=:username AND password=:password";
            List<Object[]> objsysuser = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldssysuser, wheresysuser, paramsysuser, paramsValuessysuser);
            if (objsysuser != null) {
                for (Object[] systemuser : objsysuser) {
                    String[] parampersn = {"personid"};
                    Object[] paramsValuepersn = {systemuser[1]};
                    String wherepersn = "WHERE personid=:personid";
                    String[] fieldspersn = {"staffid"};
                    List<BigInteger> objpersn = (List<BigInteger>) genericClassService.fetchRecord(Searchstaff.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);

                    if (objpersn != null) {
                        if (objpersn.get(0).equals(deliveredto)) {
                            //save received unit items
                            List<Map> donateditemqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyreceivedvalues"), List.class);
                            for (Map itemone : donateditemqty) {
                                Long itemid = Long.parseLong(itemone.get("name").toString());
                                String batchno = itemone.get("batchno").toString();
                                String exiprydate = itemone.get("expirydate").toString();

                                int donationconsumptionid = Integer.parseInt(itemone.get("donationconsumptionid").toString());
                                int donorprogramid = Integer.parseInt(itemone.get("donorprogramid").toString());
                                String donorrefno = itemone.get("donorrefno").toString();

                                if (itemone.get("value") != "") {
                                    int quantityTransferred = Integer.parseInt(itemone.get("value").toString());

                                    String[] params = {"itemid", "batchnumber", "expirydate", "facilityunitid", "suppliertype"};
                                    Object[] paramsValues = {itemid, batchno, formatter.parse(exiprydate.replaceAll("/", "-")), currentFacilityUnitid, "DONOR"};
                                    String[] fields = {"itemid.itemid", "batchnumber", "expirydate", "quantityrecieved", "stockid"};
                                    String where = "WHERE itemid=:itemid AND batchnumber=:batchnumber AND expirydate=:expirydate AND facilityunitid=:facilityunitid AND suppliertype=:suppliertype";
                                    List<Object[]> stockList = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramsValues);
                                    if (stockList != null) {
                                        int oldQty = (Integer) stockList.get(0)[3];
                                        int totalQty = quantityTransferred + oldQty;
                                        String[] columns1 = {"quantityrecieved"};
                                        Object[] columnValues1 = {totalQty};
                                        String pk1 = "stockid";
                                        Object pkValue1 = (Long) stockList.get(0)[4];
                                        Object saveddonor = genericClassService.updateRecordSQLSchemaStyle(com.iics.store.Stock.class, columns1, columnValues1, pk1, pkValue1, "store");

                                        String[] columns2 = {"qtydelivered", "isdelivered", "deliveredto", "datedelivered"};
                                        Object[] columnValues2 = {quantityTransferred, Boolean.TRUE, objpersn.get(0), new Date()};
                                        String pk2 = "donationconsumptionid";
                                        Object pkValue2 = donationconsumptionid;
                                        genericClassService.updateRecordSQLSchemaStyle(Donationconsumption.class, columns2, columnValues2, pk2, pkValue2, "store");

                                        if (saveddonor != null) {
                                            new StockActivityLog(genericClassService, ((Long) stockList.get(0)[4]).intValue(), Integer.parseInt(objpersn.get(0).toString()), "IN", quantityTransferred, "DON", BigInteger.valueOf(donorprogramid), donorrefno).start();
                                            result = "success";
                                        } else {
                                            result = "Failed";
                                        }
                                    } else {
                                        com.iics.store.Stock itemStock = new com.iics.store.Stock();
                                        itemStock.setItemid(new Item(itemid));
                                        itemStock.setQuantityrecieved(quantityTransferred);
                                        itemStock.setDaterecieved(new Date());
                                        itemStock.setDateadded(new Date());
                                        itemStock.setRecievedby(currStaffId);
                                        itemStock.setFacilityunitid(BigInteger.valueOf(currentFacilityUnitid));
                                        itemStock.setSuppliertype("DONOR");
                                        itemStock.setShelvedstock(0);
                                        itemStock.setStockissued(0);
                                        itemStock.setSupplierid(BigInteger.valueOf(donationconsumptionid));
                                        if (batchno.length() >= 1) {
                                            itemStock.setBatchnumber(batchno);
                                        } else {
                                            itemStock.setBatchnumber("-");
                                        }
                                        if (!"".equals(exiprydate.toString())) {
                                            itemStock.setExpires(true);
                                            itemStock.setExpirydate(formatter.parse(exiprydate.toString().replaceAll("/", "-")));
                                        } else {
                                            itemStock.setExpires(false);
                                        }
                                        Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(itemStock);
                                        String[] columns2 = {"qtydelivered", "isdelivered", "deliveredto", "datedelivered"};
                                        Object[] columnValues2 = {quantityTransferred, Boolean.TRUE, objpersn.get(0), new Date()};
                                        String pk2 = "donationconsumptionid";
                                        Object pkValue2 = donationconsumptionid;
                                        genericClassService.updateRecordSQLSchemaStyle(Donationconsumption.class, columns2, columnValues2, pk2, pkValue2, "store");

                                        if (saveddonor != null) {
                                            new StockActivityLog(genericClassService, itemStock.getStockid().intValue(), Integer.parseInt(objpersn.get(0).toString()), "IN", itemStock.getQuantityrecieved(), "DON", BigInteger.valueOf(donorprogramid), donorrefno).start();
                                            result = "success";
                                        } else {
                                            result = "Failed";
                                        }
                                    }

                                }
                            }

                        } else {
                            result = "notgiventothisuser";
                        }
                    }
                }
            } else {
                result = "error";
            }
            return result;
        } else {
            return "refresh";
        }
    }

    private String generateFacilityDonorNo() {
        SimpleDateFormat f = new SimpleDateFormat("yy");
        String name = "D";
        String pattern = name + f.format(new Date()) + "/%";
        String donorNumber = "";

        String[] params = {"donorrefno"};
        Object[] paramsValues = {pattern};
        String[] fields = {"donorrefno"};
        String where = "WHERE donorrefno LIKE :donorrefno ORDER BY donorrefno DESC LIMIT 1";
        List<String> lastFacilityDonationno = (List<String>) genericClassService.fetchRecord(Donations.class, fields, where, params, paramsValues);
        if (lastFacilityDonationno == null) {
            donorNumber = name + f.format(new Date()) + "/001";
            return donorNumber;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilityDonationno.get(0).split("\\/")[1]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        donorNumber = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 2:
                        donorNumber = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        donorNumber = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }

        }
        return donorNumber;
    }

    @RequestMapping(value = "/makeDonation", method = RequestMethod.GET)
    public String MakeDonation(HttpServletRequest request, Model model, String generatefacilitydonorno, @ModelAttribute("facilitydonorid") int facilitydonorid, @ModelAttribute("donorname") String donorname) {
        String donorNumber = "";
        donorNumber = generateFacilityDonorNo();

        model.addAttribute("donorNumber", donorNumber);
        model.addAttribute("currentdate", new Date());
        model.addAttribute("facilitydonorid", facilitydonorid);
        model.addAttribute("donorname", donorname);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));

        return "inventoryAndSupplies/internaldonorprogram/donors/forms/makedonation";

    }

    @RequestMapping(value = "/saveDonorProgram.htm")
    public @ResponseBody
    String saveDonorProgram(Model model, HttpServletRequest request) {
        DateFormat formatter2;
        Date date;
        formatter2 = new SimpleDateFormat("dd-MMM-yy");
        String data = "";
        Set<Integer> donorprogramid = new HashSet<>();
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        try {

            String contactPrsnEmail = request.getParameter("contactPrsnEmail");
            String donorname = request.getParameter("donorname2");
            String country = request.getParameter("country2");
            String telno = request.getParameter("telno2");
            String email = request.getParameter("email2");
            String fax = request.getParameter("fax2");

            String donortype = request.getParameter("donortype2");
            String firstname = request.getParameter("firstname2");
            String lastname = request.getParameter("lastname2");
            String othername = request.getParameter("othername2");
            String primaryContact = request.getParameter("primaryContact");
            String secondaryContact = request.getParameter("secondaryContact");

            if (!"".equals(request.getParameter("personid"))) {
                Long personid = Long.parseLong(request.getParameter("personid"));
                Donorprogram saveDonors = new Donorprogram();
                saveDonors.setDonorname(donorname);
                saveDonors.setTelno(telno);
                saveDonors.setEmial(email);
                saveDonors.setOrigincountry(country);
                saveDonors.setFax(fax);
                saveDonors.setDateadded(new Date());
                saveDonors.setDateupdated(new Date());
                saveDonors.setAddedby(staffid);
                saveDonors.setUpdatedby(staffid);
                saveDonors.setDonortype(donortype);
                Object donorProgramSaved = genericClassService.saveOrUpdateRecordLoadObject(saveDonors);
                if (donorProgramSaved != null) {
                    int donorids = saveDonors.getDonorprogramid();
                    Facilitydonor facDnrs = new Facilitydonor();

                    facDnrs.setDonorprogramid(donorids);
                    facDnrs.setFacilityid(facilityid);
                    facDnrs.setDateadded(new Date());
                    facDnrs.setDateupdated(new Date());
                    facDnrs.setContactperson(personid);
                    facDnrs.setAddedby(staffid);
                    facDnrs.setUpdatedby(staffid);
                    facDnrs.setPrimarycontact(primaryContact);
                    facDnrs.setSecondarycontact(secondaryContact);
                    facDnrs.setEmail(contactPrsnEmail);

                    Object newDonation = genericClassService.saveOrUpdateRecordLoadObject(facDnrs);
                    if (newDonation != null) {
                        data = "saved";
                    }

                }

            } else {
                Donorprogram saveDonors = new Donorprogram();
                saveDonors.setDonorname(donorname);
                saveDonors.setTelno(telno);
                saveDonors.setEmial(email);
                saveDonors.setOrigincountry(country);
                saveDonors.setFax(fax);
                saveDonors.setDateadded(new Date());
                saveDonors.setDateupdated(new Date());
                saveDonors.setAddedby(staffid);
                saveDonors.setUpdatedby(staffid);
                saveDonors.setDonortype(donortype);
                Object donorProgramSaveds = genericClassService.saveOrUpdateRecordLoadObject(saveDonors);
                if (donorProgramSaveds != null) {
                    int donorids = saveDonors.getDonorprogramid();

                    Person contactPrsns = new Person();
                    contactPrsns.setFirstname(firstname);
                    contactPrsns.setLastname(lastname);
                    contactPrsns.setOthernames(othername);
                    contactPrsns.setRegistrationpoint(facilityUnitid);

                    Object contactPerson = genericClassService.saveOrUpdateRecordLoadObject(contactPrsns);
                    if (contactPerson != null) {
                        Long personid2 = contactPrsns.getPersonid();

                        Facilitydonor facDnrs = new Facilitydonor();

                        facDnrs.setDonorprogramid(donorids);
                        facDnrs.setFacilityid(facilityid);
                        facDnrs.setDateadded(new Date());
                        facDnrs.setDateupdated(new Date());
                        facDnrs.setContactperson(personid2);
                        facDnrs.setAddedby(staffid);
                        facDnrs.setUpdatedby(staffid);
                        facDnrs.setPrimarycontact(primaryContact);
                        facDnrs.setSecondarycontact(secondaryContact);
                        facDnrs.setEmail(contactPrsnEmail);

                        Object newDonation = genericClassService.saveOrUpdateRecordLoadObject(facDnrs);
                        if (newDonation != null) {
                            data = "saved";
                        }

                    }
                }
            }

        } catch (Exception ex) {
            System.out.println(ex);
        }
        return data;
    }

    //SAVING INDIVIDUAL DONOR
    @RequestMapping(value = "/saveIndividualDonorProgram.htm")
    public @ResponseBody
    String saveIndividualDonorProgram(Model model, HttpServletRequest request) {
        DateFormat formatter2;
        Date date;
        formatter2 = new SimpleDateFormat("dd-MMM-yy");
        String data = "";
        Set<Integer> donorprogramid = new HashSet<>();
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        try {
            String contactPrsnEmail = request.getParameter("contactPrsnEmail");
            String country = request.getParameter("country2");
            String donortype = request.getParameter("donortype2");
            String firstname = request.getParameter("firstname2");
            String lastname = request.getParameter("lastname2");
            String othername = request.getParameter("othername2");
            String primaryContact = request.getParameter("primaryContact");
            String secondaryContact = request.getParameter("secondaryContact");

            Donorprogram saveDonors = new Donorprogram();
            saveDonors.setOrigincountry(country);
            saveDonors.setDonorname(firstname + " " + lastname + " " + othername);
            saveDonors.setDateadded(new Date());
            saveDonors.setDateupdated(new Date());
            saveDonors.setAddedby(staffid);
            saveDonors.setUpdatedby(staffid);
            saveDonors.setDonortype(donortype);
            saveDonors.setTelno(primaryContact);
            saveDonors.setFax(secondaryContact);
            saveDonors.setEmial(contactPrsnEmail);
            Object donorProgramSaveds = genericClassService.saveOrUpdateRecordLoadObject(saveDonors);
            if (donorProgramSaveds != null) {
                int donorids = saveDonors.getDonorprogramid();
                Facilitydonor facDnrs = new Facilitydonor();

                facDnrs.setDonorprogramid(donorids);
                facDnrs.setFacilityid(facilityid);
                facDnrs.setDateadded(new Date());
                facDnrs.setDateupdated(new Date());
                facDnrs.setAddedby(staffid);
                facDnrs.setUpdatedby(staffid);

                Object newDonation = genericClassService.saveOrUpdateRecordLoadObject(facDnrs);
                if (newDonation != null) {
                    data = "saved";
                }

            }

        } catch (Exception ex) {
            System.out.println(ex);
        }
        return data;
    }

    //SAVING ORGANISATION FACILITY DONOR
    @RequestMapping(value = "/saveFacilityDonor.htm")
    public @ResponseBody
    String saveFacilityDonor(Model model, HttpServletRequest request, @ModelAttribute("donorid2") int donorprogramid, @ModelAttribute("personid") long personid, @ModelAttribute("firstname") String firstname, @ModelAttribute("lastname") String lastname, @ModelAttribute("othername") String othername, @ModelAttribute("primaryContact") String primaryContact, @ModelAttribute("secondaryContact") String secondaryContact, @ModelAttribute("contactPrsnEmail") String contactPrsnEmail) {
        DateFormat formatter2;
        Date date;
        formatter2 = new SimpleDateFormat("dd-MMM-yy");
        String data = "";
        Set<Integer> donorprogramids = new HashSet<>();
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        try {
            Facilitydonor facDnrs = new Facilitydonor();

            facDnrs.setDonorprogramid(donorprogramid);
            facDnrs.setFacilityid(facilityid);
            facDnrs.setDateadded(new Date());
            facDnrs.setDateupdated(new Date());
            facDnrs.setAddedby(staffid);
            facDnrs.setUpdatedby(staffid);

            facDnrs.setContactperson(personid);
            facDnrs.setPrimarycontact(primaryContact);
            facDnrs.setSecondarycontact(secondaryContact);
            facDnrs.setEmail(contactPrsnEmail);

            Object donorProgramSaved = genericClassService.saveOrUpdateRecordLoadObject(facDnrs);
            if (donorProgramSaved != null) {
                data = "saved";
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }

        return data;
    }

    //SAVING INDIVIDUAL FACILITY DONOR
    @RequestMapping(value = "/saveFacilityIndividualDonor.htm")
    public @ResponseBody
    String saveFacilityIndividualDonor(Model model, HttpServletRequest request, @ModelAttribute("donorid2") int facilitydonorid, @ModelAttribute("primaryContact") String primaryContact, @ModelAttribute("secondaryContact") String secondaryContact, @ModelAttribute("contactPrsnEmail") String contactPrsnEmail) {
        DateFormat formatter2;
        Date date;
        formatter2 = new SimpleDateFormat("dd-MMM-yy");
        String data = "";
        Set<Integer> donorprogramid = new HashSet<>();
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

        Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        try {
            Facilitydonor facDnrs = new Facilitydonor();
            facDnrs.setDonorprogramid(facilitydonorid);
            facDnrs.setFacilityid(facilityid);
            facDnrs.setDateadded(new Date());
            facDnrs.setDateupdated(new Date());
            facDnrs.setAddedby(staffid);
            facDnrs.setUpdatedby(staffid);
            facDnrs.setPrimarycontact(primaryContact);
            facDnrs.setSecondarycontact(secondaryContact);
            facDnrs.setEmail(contactPrsnEmail);

            Object donorProgramSaved = genericClassService.saveOrUpdateRecordLoadObject(facDnrs);
            if (donorProgramSaved != null) {
                data = "saved";
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }

        return data;
    }

    @RequestMapping(value = "/updateName", method = RequestMethod.POST)
    public @ResponseBody
    String updateName(Model model, HttpServletRequest request) {
        int donorprogramid = Integer.parseInt(request.getParameter("donorprogramid"));
        String updatedname = request.getParameter("updatedname");
        Object updatedby = request.getSession().getAttribute("person_id");

        String[] columns = {"donorname", "updatedby", "dateupdated"};
        Object[] columnValues = {updatedname, updatedby, new Date()};
        String pk = "donorprogramid";
        Object pkValue = donorprogramid;
        genericClassService.updateRecordSQLSchemaStyle(Donorprogram.class, columns, columnValues, pk, pkValue, "store");
        return "";
    }

    @RequestMapping(value = "/updateEmail", method = RequestMethod.POST)
    public @ResponseBody
    String updateEmail(Model model, HttpServletRequest request, @ModelAttribute("updateemail") String updateemail) {
        int donorprogramid = Integer.parseInt(request.getParameter("donorprogramid"));
        Object updatedby = request.getSession().getAttribute("person_id");

        String[] columns = {"emial", "updatedby", "dateupdated"};
        Object[] columnValues = {updateemail, updatedby, new Date()};
        String pk = "donorprogramid";
        Object pkValue = donorprogramid;
        genericClassService.updateRecordSQLSchemaStyle(Donorprogram.class, columns, columnValues, pk, pkValue, "store");
        return "";
    }

    @RequestMapping(value = "/updateTelNo", method = RequestMethod.POST)
    public @ResponseBody
    String updateTelNo(Model model, HttpServletRequest request) {
        int donorprogramid = Integer.parseInt(request.getParameter("donorprogramid"));
        String updatetelno = request.getParameter("updatetelno");
        Object updatedby = request.getSession().getAttribute("person_id");

        String[] columns = {"telno", "updatedby", "dateupdated"};
        Object[] columnValues = {updatetelno, updatedby, new Date()};
        String pk = "donorprogramid";
        Object pkValue = donorprogramid;
        genericClassService.updateRecordSQLSchemaStyle(Donorprogram.class, columns, columnValues, pk, pkValue, "store");
        return "";
    }

    @RequestMapping(value = "/updateFax", method = RequestMethod.POST)
    public @ResponseBody
    String updateFax(Model model, HttpServletRequest request) {
        int donorprogramid = Integer.parseInt(request.getParameter("donorprogramid"));
        String updatefax = request.getParameter("updatefax");
        Object updatedby = request.getSession().getAttribute("person_id");

        String[] columns = {"fax", "updatedby", "dateupdated"};
        Object[] columnValues = {updatefax, updatedby, new Date()};
        String pk = "donorprogramid";
        Object pkValue = donorprogramid;
        genericClassService.updateRecordSQLSchemaStyle(Donorprogram.class, columns, columnValues, pk, pkValue, "store");
        return "";
    }

    //SAVING DONATIONS MADE
    @RequestMapping(value = "/saveDonation", method = RequestMethod.POST)
    public @ResponseBody
    String saveDonation(HttpServletRequest request, Model model, @ModelAttribute("donoritems") String items, @ModelAttribute("otherdonoritems") String otherDonorItems, @ModelAttribute("donationno") String donationno, @ModelAttribute("donationDate") String donationDate, @ModelAttribute("facilitydonorid") int facilitydonorid) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
                SimpleDateFormat date = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);

                Donations donations = new Donations();

                donations.setDatereceived(formatter.parse(request.getParameter("donationDate").replaceAll("/", "-")));
                donations.setDonorrefno(donationno);
                donations.setFacilitydonorid(facilitydonorid);
                donations.setReceivedby(staffid);
                donations.setUpdatedby(staffid);
                donations.setDateupdated(new Date());

                Object saveDonations = genericClassService.saveOrUpdateRecordLoadObject(donations);
                if (saveDonations != null) {
                    int donationsid = donations.getDonationsid();
//SAVING DONATION OF MEDICAL ITEMS
                    List<Map> itemList = new ObjectMapper().readValue(items, List.class);
                    for (Map item : itemList) {
                        String[] params = {"medicalitemsid", "batchno", "expirydate"};
                        Object[] paramsValues = {Long.parseLong(item.get("itemid").toString()), (String) item.get("batch"), formatter.parse(item.get("expiry").toString().replaceAll("/", "-"))};
                        String[] fields = {"medicalitemsid", "batchno", "expirydate", "qtydonated", "donationsitemsid"};
                        String where = "WHERE medicalitemsid=:medicalitemsid AND batchno=:batchno AND expirydate=:expirydate";
                        List<Object[]> donatedList = (List<Object[]>) genericClassService.fetchRecord(Donationsitems.class, fields, where, params, paramsValues);
                        if (donatedList != null) {
                            int oldQty = (Integer) donatedList.get(0)[3];
                            int totalQty = (Integer) item.get("qty") + oldQty;

                            String expirydate = item.get("expiry").toString();
                            Donationsitems dntnItems = new Donationsitems();
                            dntnItems.setDonationsid(donationsid);
                            //updating quantity incase item already exits

                            dntnItems.setMedicalitemsid(Long.parseLong(item.get("itemid").toString()));
                            dntnItems.setDonationsid(donationsid);
                            dntnItems.setBatchno((String) item.get("batch"));
                            dntnItems.setExpirydate(formatter.parse(expirydate.replaceAll("/", "-")));
                            dntnItems.setQtydonated((Integer) item.get("qty"));
                            dntnItems.setItemtype("MEDICINE");
                            dntnItems.setDateupdated(new Date());
                            dntnItems.setDateadded(new Date());
                            dntnItems.setAddedby(staffid);
                            dntnItems.setUpdatedby(staffid);
                            if (((String) item.get("batch")).length() >= 1) {
                                dntnItems.setBatchno((String) item.get("batch"));
                            } else {
                                dntnItems.setBatchno("-");
                            }
                            Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(dntnItems);
                            if (saveddonor != null) {
                                results = "Saved";
                            } else {
                                results = "Failed";
                            }

                        } else {
                            //saving donation incase item doesnot exist
                            String expirydate = item.get("expiry").toString();
                            Donationsitems dntnItems = new Donationsitems();

                            dntnItems.setMedicalitemsid(Long.parseLong(item.get("itemid").toString()));
                            dntnItems.setDonationsid(donationsid);
                            dntnItems.setBatchno((String) item.get("batch"));
                            dntnItems.setExpirydate(formatter.parse(expirydate.replaceAll("/", "-")));
                            dntnItems.setQtydonated((Integer) item.get("qty"));
                            dntnItems.setItemtype("MEDICINE");
                            dntnItems.setDateupdated(new Date());
                            dntnItems.setDateadded(new Date());
                            dntnItems.setAddedby(staffid);
                            dntnItems.setUpdatedby(staffid);
                            if (((String) item.get("batch")).length() >= 1) {
                                dntnItems.setBatchno((String) item.get("batch"));
                            } else {
                                dntnItems.setBatchno("-");
                            }
                            Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(dntnItems);
                            if (saveddonor != null) {
                                results = "Saved";
                            } else {
                                results = "Failed";
                            }
                        }
                    }
                    //SAVING DONATION OF OTHER ITEMS

                    if (otherDonorItems.length() != 0) {
                        List<Map> otherItemList = new ObjectMapper().readValue(otherDonorItems, List.class);
                        for (Map others : otherItemList) {
                            //when otheritemid is there
                            Facilityassets dntnItems = new Facilityassets();

                            dntnItems.setAssetsid(Integer.parseInt(others.get("otheritemid").toString()));
                            dntnItems.setDonationsid(donationsid);
                            dntnItems.setAssetqty((Integer) others.get("newotherqty"));
                            dntnItems.setItemspecification((String) others.get("itemspecification"));
                            dntnItems.setAllocated("NO");
                            dntnItems.setIsdonated(Boolean.TRUE);
                            dntnItems.setDateupdated(new Date());
                            dntnItems.setDateadded(new Date());
                            dntnItems.setAddedby(staffid);
                            dntnItems.setUpdatedby(staffid);
                            Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(dntnItems);
                            if (saveddonor != null) {
                                results = "Saved";
                            } else {
                                results = "Failed";
                            }

                        }

                    }
                }
            } catch (Exception ex) {
                System.out.println(ex);
                return "Failed";
            }
        }
        return results;
    }

//    TRANSFERING STOCK TO FACILITY UNITS
    @RequestMapping(value = "/saveEditedDonorProgramInfo", method = RequestMethod.POST)
    public @ResponseBody
    String saveEditedDonorProgramInfo(HttpServletRequest request, Model model,
            @ModelAttribute("donoritems") String items
    ) {

        String results = "";

        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
                SimpleDateFormat date = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);

                int personid = Integer.parseInt(request.getParameter("personid"));
                String contactpersonname = request.getParameter("contactpersonname");
                String priContact = request.getParameter("priContact");
                String secContact = request.getParameter("secContact");
                String personemail = request.getParameter("personemail");
                int facilitydonorid = Integer.parseInt(request.getParameter("facilitydonorid"));

                String[] columns = {"primarycontact", "secondarycontact", "email", "updatedby", "dateupdated"};
                Object[] columnValues = {priContact, secContact, personemail, staffid, new Date()};
                String pk = "facilitydonorid";
                Object pkValue = facilitydonorid;
                Object Updated = genericClassService.updateRecordSQLSchemaStyle(Facilitydonor.class,
                        columns, columnValues, pk, pkValue, "store");
                if (Updated != null) {
                    results = "success";
                } else {
                    results = "Failed";
                }

            } catch (Exception ex) {
                System.out.println(ex);
                return "Failed";
            }
        } else {
        }

        return results;
    }

    @RequestMapping(value = "/saveDonorStock", method = RequestMethod.GET)
    public @ResponseBody
    String saveDonorStock(HttpServletRequest request, Model model) {
        String result = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String personidsession = request.getSession().getAttribute("person_id").toString();
            Set<Long> facilitydonoritemsset2 = new HashSet<>();
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            Integer facilityUnitid = Integer.parseInt(request.getParameter("facilityunitid"));

            String[] paramsysuser = {"username", "password"};
            Object[] paramsValuessysuser = {username, password};
            String[] fieldssysuser = {"systemuserid", "personid.personid", "active"};
            String wheresysuser = "WHERE username=:username AND password=:password";
            List<Object[]> objsysuser = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldssysuser, wheresysuser, paramsysuser, paramsValuessysuser);
            if (objsysuser != null) {
                Object[] itemdetails = objsysuser.get(0);
//                if ((Integer.parseInt(personidsession)) == Integer.parseInt(String.valueOf(itemdetails[1]))) {
////                    result = "sameuser";
//                } else {
                for (Object[] systemuser : objsysuser) {
                    String[] parampersn = {"personid"};
                    Object[] paramsValuepersn = {systemuser[1]};
                    String wherepersn = "WHERE personid=:personid";
                    String[] fieldspersn = {"staffid", "personid"};
                    List<Object[]> objpersn = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
                    if (objpersn != null) {
                        Object[] person = objpersn.get(0);
                        String[] paramstafffacilityunit = {"staffid", "facilityunitid"};
                        Object[] paramsValuestafffacilityunit = {person[0], facilityUnitid};
                        String wherestafffacilityunit = "WHERE staffid=:staffid AND facilityunitid=:facilityunitid";
                        String[] fieldsstafffacilityunit = {"stafffacilityunitid", "facilityunitid"};
                        List<Object[]> objstafffacilityunit = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsstafffacilityunit, wherestafffacilityunit, paramstafffacilityunit, paramsValuestafffacilityunit);
                        if (objstafffacilityunit != null) {
                            try {
                                List<Map> donateditemqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtydonatedvalues"), List.class);
                                for (Map itemone : donateditemqty) {
                                    Long itemid = Long.parseLong(itemone.get("name").toString());
                                    String batchno = itemone.get("batchno").toString();
                                    String exiprydate = itemone.get("expirydate").toString();

                                    int quantityTransferred = Integer.parseInt(String.valueOf(itemone.get("value")));
                                    int qtydonated = Integer.parseInt(itemone.get("qtydonated").toString());
                                    int remainingQty = Integer.parseInt(itemone.get("discrepancy").toString());
                                    int donorprogramid = Integer.parseInt(itemone.get("donorprogramid").toString());

                                    if (itemone.get("value") != "") {
                                        int donationsitemsid = Integer.parseInt(itemone.get("donationsitemsid").toString());
                                        Donationconsumption consumption = new Donationconsumption();
                                        consumption.setDonationsitemsid(donationsitemsid);
                                        consumption.setHandedoverto((BigInteger) person[0]);
                                        consumption.setQtyhandedover(quantityTransferred);
                                        consumption.setHandoverdate(new Date());
                                        consumption.setConsumerunit(BigInteger.valueOf(facilityUnitid));
                                        consumption.setIsdelivered(Boolean.FALSE);
                                        Object saveConsumption = genericClassService.saveOrUpdateRecordLoadObject(consumption);
                                        if (saveConsumption != null) {
                                            result = "success";
//                                            int donationconsumptionid = consumption.getDonationconsumptionid();
//                                            String[] params = {"itemid", "batchnumber", "expirydate", "facilityunitid", "suppliertype"};
//                                            Object[] paramsValues = {itemid, batchno, formatter.parse(exiprydate.replaceAll("/", "-")), facilityUnitid, "DONOR"};
//                                            String[] fields = {"itemid.itemid", "batchnumber", "expirydate", "quantityrecieved", "stockid"};
//                                            String where = "WHERE itemid=:itemid AND batchnumber=:batchnumber AND expirydate=:expirydate AND facilityunitid=:facilityunitid AND suppliertype=:suppliertype";
//                                            List<Object[]> stockList = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramsValues);
//                                            if (stockList != null) {
//                                                int oldQty = (Integer) stockList.get(0)[3];
//                                                int totalQty = quantityTransferred + oldQty;
//                                                String[] columns1 = {"quantityrecieved"};
//                                                Object[] columnValues1 = {totalQty};
//                                                String pk1 = "stockid";
//                                                Object pkValue1 = (Long) stockList.get(0)[4];
//                                                Object saveddonor = genericClassService.updateRecordSQLSchemaStyle(com.iics.store.Stock.class, columns1, columnValues1, pk1, pkValue1, "store");
//                                                if (saveddonor != null) {
//                                                    new StockActivityLog(genericClassService, ((Long) stockList.get(0)[4]).intValue(), Integer.parseInt(person[0].toString()), "IN", quantityTransferred, "DON", BigInteger.valueOf(donorprogramid), donorrefno).start();
//                                                    result = "success";
//                                                } else {
//                                                    result = "Failed";
//                                                }
//                                            } else {
//                                                com.iics.store.Stock itemStock = new com.iics.store.Stock();
//                                                itemStock.setItemid(new Item(itemid));
//                                                itemStock.setQuantityrecieved(quantityTransferred);
//                                                itemStock.setDaterecieved(new Date());
//                                                itemStock.setDateadded(new Date());
//                                                itemStock.setRecievedby(staffid);
//                                                itemStock.setFacilityunitid(BigInteger.valueOf(facilityUnitid));
//                                                itemStock.setSuppliertype("DONOR");
//                                                itemStock.setShelvedstock(0);
//                                                itemStock.setStockissued(0);
//                                                itemStock.setSupplierid(BigInteger.valueOf(donationconsumptionid));
//                                                if (batchno.length() >= 1) {
//                                                    itemStock.setBatchnumber(batchno);
//                                                } else {
//                                                    itemStock.setBatchnumber("-");
//                                                }
//                                                if (!"".equals(exiprydate.toString())) {
//                                                    itemStock.setExpires(true);
//                                                    itemStock.setExpirydate(formatter.parse(exiprydate.toString().replaceAll("/", "-")));
//                                                } else {
//                                                    itemStock.setExpires(false);
//                                                }
//                                                Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(itemStock);
//                                                if (saveddonor != null) {
//                                                    new StockActivityLog(genericClassService, itemStock.getStockid().intValue(), Integer.parseInt(person[0].toString()), "IN", itemStock.getQuantityrecieved(), "DON", BigInteger.valueOf(donorprogramid), donorrefno).start();
//                                                    result = "success";
//                                                } else {
//                                                    result = "Failed";
//                                                }
//                                            }
                                        } else {
                                            result = "Failed";
                                        }

                                    }
                                }
                            } catch (Exception ex) {
                                System.out.println("ERROR ON SAVE qty delivered:" + ex);
                            }
                        } else {
                            result = "doesnotbelongtoanyunit";
                        }
                    }
                }
//                }
            } else {
                result = "error";
            }
        } else {
            return "refresh";
        }
        return result;
    }

    @RequestMapping(value = "/saveOtherItemDonorStock", method = RequestMethod.GET)
    public @ResponseBody
    String saveOtherItemDonorStock(HttpServletRequest request, Model model) {
        String result = "";
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String personidsession = request.getSession().getAttribute("person_id").toString();
            Set<Long> facilitydonoritemsset2 = new HashSet<>();
            Integer facilityUnitid = Integer.parseInt(request.getParameter("facilityunitid"));
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String[] paramsysuser = {"username", "password"};
            Object[] paramsValuessysuser = {username, password};
            String[] fieldssysuser = {"systemuserid", "personid.personid", "active"};
            String wheresysuser = "WHERE username=:username AND password=:password";
            List<Object[]> objsysuser = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldssysuser, wheresysuser, paramsysuser, paramsValuessysuser);
            if (objsysuser != null) {
                Object[] itemdetails = objsysuser.get(0);
                if ((Integer.parseInt(personidsession)) == Integer.parseInt(String.valueOf(itemdetails[1]))) {
                    result = "sameuser";
                } else {
                    for (Object[] systemuser : objsysuser) {
                        String[] parampersn = {"personid"};
                        Object[] paramsValuepersn = {systemuser[1]};
                        String wherepersn = "WHERE personid=:personid";
                        String[] fieldspersn = {"staffid", "personid"};
                        List<Object[]> objpersn = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
                        if (objpersn != null) {
                            Object[] person = objpersn.get(0);

                            String[] paramstafffacilityunit = {"staffid", "facilityunitid"};
                            Object[] paramsValuestafffacilityunit = {person[0], facilityUnitid};
                            String wherestafffacilityunit = "WHERE staffid=:staffid AND facilityunitid=:facilityunitid";
                            String[] fieldsstafffacilityunit = {"stafffacilityunitid", "facilityunitid"};
                            List<Object[]> objstafffacilityunit = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsstafffacilityunit, wherestafffacilityunit, paramstafffacilityunit, paramsValuestafffacilityunit);
                            if (objstafffacilityunit != null) {
                                try {
                                    List<Map> donatedptheritemqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyOtherDonatedValues"), List.class);
                                    for (Map itemtwo : donatedptheritemqty) {
                                        //Integer assetsid = Integer.parseInt(itemtwo.get("name").toString());
                                        String itemspecification = itemtwo.get("itemspecification").toString();
                                        int quantityTransferred = Integer.parseInt(String.valueOf(itemtwo.get("value")));
                                        int qtydonated = Integer.parseInt(itemtwo.get("qtydonated").toString());
                                        int remainingQty = Integer.parseInt(itemtwo.get("discrepancy").toString());

                                        if (itemtwo.get("value") != "") {
                                            Long facilityassetsid = Long.parseLong(itemtwo.get("facilityassetsid").toString());
                                            String[] params = {"facilityassetsid", "itemspecification", "isdonated", "allocated", "allocated"};
                                            Object[] paramsValues = {facilityassetsid, itemspecification, Boolean.TRUE, "NO", "PARTIALYALLOCATED"};
                                            String[] fields = {"facilityassetsid", "itemspecification", "assetqty", "olddonatedqty"};
                                            String where = "WHERE facilityassetsid=:facilityassetsid AND itemspecification=:itemspecification AND isdonated=:isdonated AND allocated=:allocated AND allocated=:allocated";
                                            List<Object[]> assetList = (List<Object[]>) genericClassService.fetchRecord(Facilityassets.class, fields, where, params, paramsValues);
                                            if (assetList != null) {
                                                int oldQty = (Integer) assetList.get(0)[2];
                                                int totalQty = quantityTransferred + oldQty;

                                                Assetallocation assetStock = new Assetallocation();
                                                assetStock.setFacilityassetsid(facilityassetsid);
                                                assetStock.setAllocatedby(staffid);
                                                assetStock.setQtyallocated(totalQty);
                                                assetStock.setFacilityunitid(BigInteger.valueOf(facilityUnitid));
                                                assetStock.setDateallocated(new Date());
                                                assetStock.setDateupdated(new Date());
                                                assetStock.setUpdatedby(staffid);

                                                if (remainingQty == 0) {
                                                    String[] columns = {"allocated", "assetqty", "olddonatedqty"};
                                                    Object[] columnValues = {"FULLYALLOCATED", qtydonated, qtydonated};
                                                    String pk = "facilityassetsid";
                                                    Object pkValue = facilityassetsid;
                                                    genericClassService.updateRecordSQLSchemaStyle(Facilityassets.class, columns, columnValues, pk, pkValue, "assetsmanager");

                                                } else {
                                                    String[] columns = {"allocated", "assetqty", "olddonatedqty"};
                                                    Object[] columnValues = {"PARTIALYALLOCATED", qtydonated, qtydonated};
                                                    String pk = "facilityassetsid";
                                                    Object pkValue = facilityassetsid;
                                                    genericClassService.updateRecordSQLSchemaStyle(Facilityassets.class, columns, columnValues, pk, pkValue, "assetsmanager");

                                                }

                                                Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(assetStock);
                                                if (saveddonor != null) {
                                                    result = "success";
                                                } else {
                                                    result = "Failed";
                                                }

                                            } else {
                                                Assetallocation assetStock = new Assetallocation();
                                                assetStock.setFacilityassetsid(facilityassetsid);
                                                assetStock.setAllocatedby(staffid);
                                                assetStock.setFacilityunitid(BigInteger.valueOf(facilityUnitid));
                                                assetStock.setQtyallocated(qtydonated);
                                                assetStock.setDateallocated(new Date());
                                                assetStock.setDateupdated(new Date());
                                                assetStock.setUpdatedby(staffid);

                                                if (remainingQty == 0) {
                                                    String[] columns = {"allocated", "assetqty", "olddonatedqty"};
                                                    Object[] columnValues = {"FULLYALLOCATED", qtydonated, qtydonated};
                                                    String pk = "facilityassetsid";
                                                    Object pkValue = facilityassetsid;
                                                    genericClassService.updateRecordSQLSchemaStyle(Facilityassets.class, columns, columnValues, pk, pkValue, "assetsmanager");

                                                } else {
                                                    String[] columns = {"allocated", "assetqty", "olddonatedqty"};
                                                    Object[] columnValues = {"PARTIALLYALLOCATED", remainingQty, qtydonated};
                                                    String pk = "facilityassetsid";
                                                    Object pkValue = facilityassetsid;
                                                    genericClassService.updateRecordSQLSchemaStyle(Facilityassets.class, columns, columnValues, pk, pkValue, "assetsmanager");

                                                }
                                                Object saveddonor = genericClassService.saveOrUpdateRecordLoadObject(assetStock);
                                                if (saveddonor != null) {
                                                    result = "success";
                                                } else {
                                                    result = "Failed";
                                                }
                                            }
                                        }
                                    }
                                } catch (Exception ex) {
                                    System.out.println("ERROR ON SAVE qty delivered:" + ex);
                                }
                            } else {
                                result = "doesnotbelongtoanyunit";
                            }
                        }
                    }
                }
            } else {
                result = "error";
            }
        } else {
            return "refresh";
        }
        return result;
    }

    @RequestMapping(value = "/donationPrintOut", method = RequestMethod.GET)
    public String DonationPrintOut(HttpServletRequest request, Model model, @ModelAttribute("donationsid") int donationsid, @ModelAttribute("donorrefno") String donorrefno) {
        try {
            List<Map> medicalItemDonor = new ArrayList<>();
            List<Map> otherItemDonor = new ArrayList<>();
            DecimalFormat df = new DecimalFormat("#,###");
            model.addAttribute("donationsid", donationsid);
            model.addAttribute("donorrefno", donorrefno);

            //Fetching donated items
            String[] params3 = {"donationsid", "isdonated"};
            Object[] paramsValues3 = {donationsid, Boolean.TRUE};
            String[] fields3 = {"facilityassetsid", "assetsid", "assetqty", "itemspecification"};
            String where3 = "WHERE donationsid=:donationsid AND isdonated=:isdonated";
            List<Object[]> otheritems = (List<Object[]>) genericClassService.fetchRecord(Facilityassets.class, fields3, where3, params3, paramsValues3);
            if (otheritems != null) {
                Map<String, Object> otherItemDonationPrint;
                for (Object[] ot : otheritems) {
                    otherItemDonationPrint = new HashMap<>();

                    otherItemDonationPrint.put("assetqty", df.format(ot[2]));
                    otherItemDonationPrint.put("itemspecification", ot[3]);

                    String[] params4 = {"assetsid"};
                    Object[] paramsValues4 = {ot[1]};
                    String[] fields4 = {"assetsid", "assetsname"};
                    String where4 = "WHERE assetsid=:assetsid";
                    List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fields4, where4, params4, paramsValues4);
                    if (items != null) {
                        otherItemDonationPrint.put("assetsid", items.get(0)[0]);
                        otherItemDonationPrint.put("assetsname", items.get(0)[1]);
                    }
                    otherItemDonor.add(otherItemDonationPrint);
                }
                model.addAttribute("otherItemDonorHistoryList", otherItemDonor);
            }

            //fetching medicines and supplies
            String[] params4 = {"donationsid", "itemtype"};
            Object[] paramsValues4 = {donationsid, "MEDICINE"};
            String[] fields4 = {"donationsitemsid", "medicalitemsid", "qtydonated", "batchno", "expirydate"};
            String where4 = "WHERE donationsid=:donationsid AND itemtype=:itemtype";
            List<Object[]> medicines = (List<Object[]>) genericClassService.fetchRecord(Donationsitems.class, fields4, where4, params4, paramsValues4);
            if (medicines != null) {
                Map<String, Object> medicalItemDonationPrint;
                for (Object[] di : medicines) {
                    medicalItemDonationPrint = new HashMap<>();

                    medicalItemDonationPrint.put("donationsitemsid", di[0]);
                    medicalItemDonationPrint.put("medicalitemsid", di[1]);
                    medicalItemDonationPrint.put("qtydonated", df.format(di[2]));
                    medicalItemDonationPrint.put("batchno", di[3]);
                    medicalItemDonationPrint.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) di[4]));

                    String[] paramsitem = {"itempackageid", "isactive"};
                    Object[] paramsValuesitem = {di[1], Boolean.TRUE};
                    String[] fieldsitem = {"itemid", "packagename"};
                    String whereitem = "WHERE itempackageid=:itempackageid AND isactive=:isactive";
                    List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitem, whereitem, paramsitem, paramsValuesitem);
                    if (items != null) {
                        medicalItemDonationPrint.put("itemid", items.get(0)[0]);
                        medicalItemDonationPrint.put("packagename", items.get(0)[1]);
                    }
                    medicalItemDonor.add(medicalItemDonationPrint);
                }
                model.addAttribute("medicalItemDonorHistoryList", medicalItemDonor);
            }

            //Fetching facilitydonor details
            String[] params5 = {"donationsid"};
            Object[] paramsValues5 = {donationsid};
            String where5 = "WHERE donationsid=:donationsid";
            String[] fields5 = {"donationsid", "facilitydonorid", "receivedby", "datereceived"};
            List<Object[]> donations5 = (List<Object[]>) genericClassService.fetchRecord(Donations.class, fields5, where5, params5, paramsValues5);
            if (donations5 != null) {
                for (Object[] dnt : donations5) {
                    String[] params1 = {"facilitydonorid"};
                    Object[] paramsValues1 = {dnt[1]};
                    String where1 = "WHERE facilitydonorid=:facilitydonorid";
                    String[] fields1 = {"donorprogramid", "contactperson", "primarycontact", "secondarycontact", "email"};
                    List<Object[]> facDonor = (List<Object[]>) genericClassService.fetchRecord(Facilitydonor.class, fields1, where1, params1, paramsValues1);
                    if (facDonor != null) {

                        model.addAttribute("primarycontact", facDonor.get(0)[2]);
                        model.addAttribute("secondarycontact", facDonor.get(0)[3]);
                        model.addAttribute("email", facDonor.get(0)[4]);

                        //PRINT DONATIONS DETAILS UNDER DONATIONSID
                        model.addAttribute("facilitydonorid", dnt[1]);
                        model.addAttribute("receivedby", dnt[2]);
                        model.addAttribute("datereceived", new SimpleDateFormat("dd-MM-yyyy").format((Date) dnt[3]));

                        //person details for person whom received the donation
                        String[] params0 = {"personid"};
                        Object[] paramsValues0 = {(Long) dnt[2]};
                        String where0 = "WHERE personid=:personid";
                        String[] fields0 = {"firstname", "lastname"};
                        List<Object[]> personnames0 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields0, where0, params0, paramsValues0);
                        if (personnames0 != null) {
                            model.addAttribute("receivedby", personnames0.get(0)[0] + " " + personnames0.get(0)[1]);
                        }

                        String[] params2 = {"personid"};
                        Object[] paramsValues2 = {(Long) facDonor.get(0)[1]};
                        String where2 = "WHERE personid=:personid";
                        String[] fields2 = {"firstname", "lastname", "othernames"};
                        List<Object[]> personnames = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields2, where2, params2, paramsValues2);
                        if (personnames != null) {
                            model.addAttribute("personname", personnames.get(0)[0] + " " + personnames.get(0)[1] + " " + personnames.get(0)[2]);
                        }

                        String[] paramsd = {"donorprogramid"};
                        Object[] paramsValuesd = {(Integer) facDonor.get(0)[0]};
                        String whered = "WHERE donorprogramid=:donorprogramid";
                        String[] fieldsd = {"donorname", "telno", "emial", "fax", "origincountry", "donortype"};
                        List<Object[]> prg = (List<Object[]>) genericClassService.fetchRecord(Donorprogram.class, fieldsd, whered, paramsd, paramsValuesd);
                        if (prg != null) {
                            model.addAttribute("donorname", prg.get(0)[0]);
                            model.addAttribute("telno", prg.get(0)[1]);
                            model.addAttribute("emial", prg.get(0)[2]);
                            model.addAttribute("fax", prg.get(0)[3]);
                            model.addAttribute("origincountry", prg.get(0)[4]);
                            model.addAttribute("donortype", prg.get(0)[5]);
                        }

                    }
                }

            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return "inventoryAndSupplies/internaldonorprogram/donations/views/donationPrintOut";
    }

    @RequestMapping(value = "/printDonationDetails", method = RequestMethod.GET)
    public @ResponseBody
    String printDonationDetails(HttpServletRequest request, Model model, @ModelAttribute("donationsid") int donationsid,@ModelAttribute("donorrefno") String donorrefno) {
        String baseEncode = "";
        String facility = ((Facility) request.getSession().getAttribute("sessionActiveLoginFacilityObj")).getFacilityname();

        String url = IICS.BASE_URL + "internaldonorprogram/donationPrintOut.htm?&donationsid=" + donationsid + "&donorrefno=" + donorrefno;
        String path = getDonationHistoryPath() + donationsid + ".pdf";
        PdfWriter pdfWriter;
        Document document = new Document();
        try {
            pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
            document.setPageSize(PageSize.A4);
            document.open();

            URL myWebPage = new URL(url);
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

    public String getDonationHistoryPath() {
        File file;
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                file = new File("C:/iicsReports/donors/donationdetails");
                path = "C:/iicsReports/donors/donationdetails/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/donors/donationdetails");
                path = "/home/iicsReports/donors/donationdetails/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/donors/donationdetails");
                path = "/Users/iicsReports/donors/donationdetails/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
    }

    public static byte[] loadFileAsBytesArray(String fileName) throws Exception {
        File file = new File(fileName);
        int length = (int) file.length();
        BufferedInputStream reader = new BufferedInputStream(new FileInputStream(file));
        byte[] bytes = new byte[length];
        reader.read(bytes, 0, length);
        reader.close();
        return bytes;
    }
}
