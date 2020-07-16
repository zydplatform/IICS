/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilityunit;
import com.iics.service.GenericClassService;
import com.iics.store.Facilitycatalogue;
import com.iics.store.Item;
import com.iics.store.Itempackage;
import com.iics.store.Unitcatalogue;
import com.iics.store.Unitcatalogueitem;
import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
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

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/catalogue")
public class Catalogue {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/loadUnitCatalogPane.htm", method = RequestMethod.GET)
    public String loadUnitCatalogPane(Model model, HttpServletRequest request, @ModelAttribute("tab") Integer tab) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> allClassifications = new ArrayList<>();
            List<Map> catalogueClassifications = new ArrayList<>();

            String[] params = {"catitemstatus"};
            Object[] paramsValues = {"PENDING"};
            String[] fields = {"itemclassificationid", "classificationname"};
            String where = "WHERE catitemstatus=:catitemstatus ORDER BY classificationname GROUP BY itemclassificationid,classificationname";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields, where, params, paramsValues);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    classification = new HashMap<>();
                    classification.put("id", object[0]);
                    classification.put("name", object[1]);
                    allClassifications.add(classification);
                }
            }

            String[] params2 = {"facilityunitid", "catitemstatus"};
            Object[] paramsValues2 = {facilityUnit, "APPROVED"};
            String[] fields2 = {"itemclassificationid", "classificationname"};
            String where2 = "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus GROUP BY itemclassificationid,classificationname ORDER BY classificationname";
            List<Object[]> catlogClassifications = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields2, where2, params2, paramsValues2);
            if (catlogClassifications != null) {
                Map<String, Object> classification;
                for (Object[] object : catlogClassifications) {
                    classification = new HashMap<>();
                    classification.put("id", object[0]);
                    classification.put("name", object[1]);
                    catalogueClassifications.add(classification);
                }
            }

            String[] params3 = {"facilityunitid", "catitemstatus"};
            Object[] paramsValues3 = {facilityUnit, "PENDING"};
            String where3 = "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus";
            int pending = genericClassService.fetchRecordCount(Unitcatalogue.class, where3, params3, paramsValues3);

            model.addAttribute("tab", tab);
            model.addAttribute("pending", pending);
            model.addAttribute("catClasses", catalogueClassifications);
            model.addAttribute("allClassifications", allClassifications);
            return "inventoryAndSupplies/unitCatalogue/catalogPane";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchUnitCatalogueItems", method = RequestMethod.GET)
    public String fetchUnitClassificationStock(HttpServletRequest request, Model model, @ModelAttribute("issupplies") boolean issupplies) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> catItems = new ArrayList<>();

            String[] params = {"facilityunitid", "catitemstatus", "issupplies"};
            Object[] paramsValues = {facilityUnit, "PENDING", issupplies};
            String where = "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus AND issupplies=:issupplies ORDER BY packagename";
            String[] fields = {"unitcatalogueitemid", "packagename", "itemstrength", "itemform", "specification"};
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields, where, params, paramsValues);
            if (classficationList != null) {
                Map<String, Object> catItem;
                for (Object[] object : classficationList) {
                    catItem = new HashMap<>();
                    catItem.put("id", object[0]);
                    catItem.put("name", object[1]);
                    catItem.put("strength", object[2]);
                    catItem.put("formname", object[3]);
                    catItem.put("specification", object[4]);
                    catItems.add(catItem);
                }
            }
            model.addAttribute("items", catItems);
            if (issupplies) {
                return "inventoryAndSupplies/unitCatalogue/supplies";
            } else {
                return "inventoryAndSupplies/unitCatalogue/items";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchItem", method = RequestMethod.GET)
    public String searchItem(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"issupplies", "value", "name", "isactive"};
        Object[] paramsValues = {false, searchValue.trim().toLowerCase() + "%", searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
        String[] fields = {"itempackageid", "packagename", "categoryname", "itemform", "itemstrength"};
        String where = "WHERE issupplies=:issupplies AND isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY packagename";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            Map<String, Object> item;
            for (Object[] object : classficationList) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("name", object[1]);
                item.put("cat", object[2]);
                item.put("form", object[3]);
                item.put("strength", object[4]);
                itemsFound.add(item);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("items", itemsFound);
        return "inventoryAndSupplies/unitCatalogue/itemSearchResults";
    }

    @RequestMapping(value = "/searchSupplies", method = RequestMethod.GET)
    public String searchSupplies(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"issupplies", "value", "name", "isactive"};
        Object[] paramsValues = {true, searchValue.trim().toLowerCase() + "%", searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
        String[] fields = {"itempackageid", "packagename", "specification"};
        String where = "WHERE issupplies=:issupplies AND isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY packagename";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            Map<String, Object> item;
            for (Object[] object : classficationList) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("name", object[1]);
                item.put("specification", object[2]);
                itemsFound.add(item);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("items", itemsFound);
        return "inventoryAndSupplies/unitCatalogue/suppliesSearchResults";
    }

    @RequestMapping(value = "/saveCatalogItems", method = RequestMethod.POST)
    public @ResponseBody
    String saveCatalogItems(HttpServletRequest request, Model model, @ModelAttribute("items") String itemsJSON) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            try {
                List itemList = new ObjectMapper().readValue(itemsJSON, List.class);
                for (Object itemid : itemList) {
                    String[] params = {"facilityunitid", "itemid"};
                    Object[] paramsValues = {BigInteger.valueOf(facilityUnitid), ((Integer) itemid).longValue()};
                    String where = "WHERE facilityunitid=:facilityunitid AND itemid=:itemid";
                    int catItemCount = genericClassService.fetchRecordCount(Unitcatalogueitem.class, where, params, paramsValues);
                    if (catItemCount <= 0) {
                        Unitcatalogueitem catItem = new Unitcatalogueitem();
                        catItem.setItemid(new Item(((Integer) itemid).longValue()));
                        catItem.setCatitemstatus("PENDING");
                        catItem.setIsactive(true);
                        catItem.setFacilityunitid(BigInteger.valueOf(facilityUnitid));
                        catItem.setUpdatedby(BigInteger.valueOf(staffid));
                        catItem.setDateadded(new Date());
                        catItem.setDateupdated(new Date());
                        genericClassService.saveOrUpdateRecordLoadObject(catItem);
                    }
                }
                return "Saved";
            } catch (IOException e) {
                return "Failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/deleteCatItem", method = RequestMethod.POST)
    public @ResponseBody
    String deleteCatItem(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"unitcatalogueitemid"};
            Object[] columnValues = {itemid};
            int result = genericClassService.deleteRecordByByColumns("store.unitcatalogueitem", columns, columnValues);
            if (result != 0) {
                return "deleted";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/activateCatItem", method = RequestMethod.POST)
    public @ResponseBody
    String activateCatItem(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemid, @ModelAttribute("value") boolean value) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"isactive"};
            Object[] columnValues = {value};
            String pk = "unitcatalogueitemid";
            Object pkValue = new BigInteger(itemid.toString());
            int result = genericClassService.updateRecordSQLSchemaStyle(Unitcatalogueitem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/loadFacilityCatalogPane.htm", method = RequestMethod.GET)
    public String loadFacilityCatalogPane(Model model, HttpServletRequest request) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            Integer facilityid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            List<Map> facilityUnits = new ArrayList<>();
            List<Map> catalogueClassifications = new ArrayList<>();

            String[] params = {"facilityid", "active"};
            Object[] paramsValues = {facilityid, Boolean.TRUE};
            String[] fields = {"facilityunitid", "facilityunitname"};
            String where = "WHERE facilityid=:facilityid AND active=:active ORDER BY facilityunitname";
            List<Object[]> facilityUnitList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (facilityUnitList != null) {
                Map<String, Object> facilityUnit;
                for (Object[] object : facilityUnitList) {
                    String[] params2 = {"facilityunitid", "catitemstatus"};
                    Object[] paramsValues2 = {object[0], "PENDING"};
                    String where2 = "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus";
                    int itemCount = genericClassService.fetchRecordCount(Unitcatalogueitem.class, where2, params2, paramsValues2);
                    if (itemCount > 0) {
                        facilityUnit = new HashMap<>();
                        facilityUnit.put("id", object[0]);
                        facilityUnit.put("name", object[1]);
                        facilityUnits.add(facilityUnit);
                    }
                }
            }

            String[] params2 = {"facilityid"};
            Object[] paramsValues2 = {facilityid};
            String[] fields2 = {"itemclassificationid", "classificationname"};
            String where2 = "WHERE facilityid=:facilityid GROUP BY itemclassificationid,classificationname ORDER BY classificationname";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Facilitycatalogue.class, fields2, where2, params2, paramsValues2);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    classification = new HashMap<>();
                    classification.put("id", object[0]);
                    classification.put("name", object[1]);
                    catalogueClassifications.add(classification);
                }
            }
            model.addAttribute("catClasses", catalogueClassifications);
            model.addAttribute("facilityUnits", facilityUnits);
            return "inventoryAndSupplies/facilityCatalogue/facilityCataloguePane";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchCataloguePendingItems.htm", method = RequestMethod.POST)
    public String fetchCataloguePendingItems(Model model, HttpServletRequest request, @ModelAttribute("facilityUnit") Integer facilityUnitid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> items = new ArrayList<>();

            String[] params = {"facilityunitid", "catitemstatus"};
            Object[] paramsValues = {facilityUnitid, "PENDING"};
            String[] fields = {"unitcatalogueitemid", "packagename", "itemform", "itemstrength", "specification"};
            String where = "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus ORDER BY packagename";
            List<Object[]> facilityUnitList = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields, where, params, paramsValues);
            if (facilityUnitList != null) {
                Map<String, Object> catalogueItem;
                for (Object[] object : facilityUnitList) {
                    catalogueItem = new HashMap<>();
                    catalogueItem.put("id", object[0]);
                    catalogueItem.put("name", object[1]);
                    catalogueItem.put("form", object[2]);
                    catalogueItem.put("strength", object[3]);
                    catalogueItem.put("specification", object[4]);
                    items.add(catalogueItem);
                }
            }
            model.addAttribute("items", items);
            return "inventoryAndSupplies/facilityCatalogue/approve/unapprovedItems";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnitPendingItems.htm", method = RequestMethod.GET)
    public String fetchUnitPendingItems(Model model, HttpServletRequest request, @ModelAttribute("issupplies") boolean issupplies) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> items = new ArrayList<>();

            String[] params = {"facilityunitid", "catitemstatus", "issupplies"};
            Object[] paramsValues = {facilityUnitid, "PENDING", issupplies};
            String[] fields = {"unitcatalogueitemid", "packagename", "itemform", "itemstrength", "specification"};
            String where = "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus AND issupplies=:issupplies ORDER BY packagename";
            List<Object[]> facilityUnitList = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields, where, params, paramsValues);
            if (facilityUnitList != null) {
                Map<String, Object> catalogueItem;
                for (Object[] object : facilityUnitList) {
                    catalogueItem = new HashMap<>();
                    catalogueItem.put("id", object[0]);
                    catalogueItem.put("name", object[1]);
                    catalogueItem.put("form", object[2]);
                    catalogueItem.put("strength", object[3]);
                    catalogueItem.put("specification", object[4]);
                    items.add(catalogueItem);
                }
            }
            model.addAttribute("items", items);
            if (issupplies) {
                return "inventoryAndSupplies/facilityCatalogue/approve/unapprovedSupplies";
            } else {
                return "inventoryAndSupplies/facilityCatalogue/approve/unapprovedItems";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/approveCatItem", method = RequestMethod.POST)
    public @ResponseBody
    String approveCatItem(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemid, @ModelAttribute("value") boolean value) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Object staffid = request.getSession().getAttribute("sessionActiveLoginStaffid");
            String[] columns = {"catitemstatus", "updatedby", "dateupdated"};
            Object[] columnValues = {"APPROVED", staffid, new Date()};
            String pk = "unitcatalogueitemid";
            Object pkValue = new BigInteger(itemid.toString());
            int result = genericClassService.updateRecordSQLSchemaStyle(Unitcatalogueitem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchFacilityCatalogueItems.htm", method = RequestMethod.GET)
    public String fetchFacilityCatalogueItems(Model model, HttpServletRequest request, @ModelAttribute("issupplies") boolean issupplies) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            Integer facilityid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            List<Map> items = new ArrayList<>();

            String[] params = {"facilityid", "issupplies"};
            Object[] paramsValues = {facilityid, issupplies};
            String[] fields = {"itemid", "packagename", "itemform", "itemstrength", "specification"};
            String where = "WHERE facilityid=:facilityid AND issupplies=:issupplies ORDER BY packagename";
            List<Object[]> categoryList = (List<Object[]>) genericClassService.fetchRecord(Facilitycatalogue.class, fields, where, params, paramsValues);
            if (categoryList != null) {
                Map<String, Object> item;
                for (Object[] object : categoryList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    item.put("form", object[2]);
                    item.put("strength", object[3]);
                    item.put("specification", object[4]);
                    items.add(item);
                }
            }
            model.addAttribute("items", items);
            if (issupplies) {
                return "inventoryAndSupplies/facilityCatalogue/generalCatalogue/catalogueCategorySupplies";
            } else {
                return "inventoryAndSupplies/facilityCatalogue/generalCatalogue/catalogueCategoryItems";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnitCatalogueApprovedItems.htm", method = RequestMethod.GET)
    public String fetchUnitCatalogueApprovedItems(Model model, HttpServletRequest request, @ModelAttribute("issupplies") boolean issupplies) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> items = new ArrayList<>();

            String[] params = {"facilityunitid", "issupplies", "catitemstatus"};
            Object[] paramsValues = {facilityUnitid, issupplies, "APPROVED"};
            String[] fields = {"unitcatalogueitemid", "packagename", "itemform", "isactive", "itemstrength", "specification"};
            String where = "WHERE facilityunitid=:facilityunitid AND issupplies=:issupplies AND catitemstatus=:catitemstatus ORDER BY packagename";
            List<Object[]> categoryList = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields, where, params, paramsValues);
            if (categoryList != null) {
                Map<String, Object> item;
                for (Object[] object : categoryList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    item.put("form", object[2]);
                    if (object[3] != null) {
                        if ((boolean) object[3]) {
                            item.put("active", "checked");
                        } else {
                            item.put("active", "checked");
                        }
                    } else {
                        item.put("active", "");
                    }
                    item.put("strength", object[4]);
                    item.put("specification", object[5]);
                    items.add(item);
                }
            }
            model.addAttribute("items", items);
            if (issupplies) {
                return "inventoryAndSupplies/unitCatalogue/approved/approvedSupplies";
            } else {
                return "inventoryAndSupplies/unitCatalogue/approved/approvedItems";
            }
        } else {
            return "refresh";
        }
    }
}
