/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Locations;
import com.iics.service.GenericClassService;
import com.iics.store.Item;
import com.iics.store.Itemcategories;
import com.iics.store.Itemcategorisation;
import com.iics.store.Itemcategory;
import com.iics.store.Itemclassification;
import com.iics.store.Itempackage;
import com.iics.store.Medicalitem;
import com.iics.store.Supplier;
import com.iics.store.Supplieritem;
import com.iics.store.Supplieritemcategories;
import java.io.IOException;
import java.text.SimpleDateFormat;
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
 * @author IICS
 */
@Controller
@RequestMapping("/externalsuppliers")
public class ExternalSuppliers {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/saveSupplier", method = RequestMethod.POST)
    public @ResponseBody
    String saveSupplier(HttpServletRequest request, Model model, @ModelAttribute("data") String data) {
        try {
            Map<String, Object> supplierData = new ObjectMapper().readValue(data, Map.class);
            Supplier supplier = new Supplier();
            supplier.setSuppliername((String) supplierData.get("name"));
            supplier.setSuppliercode((String) supplierData.get("code"));
            supplier.setOperations((String) supplierData.get("operations"));
            supplier.setOfficetel((String) supplierData.get("tel"));
            supplier.setEmailaddress((String) supplierData.get("email"));
            supplier.setPhysicaladdress((String) supplierData.get("phy"));
            supplier.setPostaladdress((String) supplierData.get("post"));
            supplier.setFax((String) supplierData.get("fax"));
            supplier.setVillageid((Integer) supplierData.get("villageid"));
            supplier.setActive(true);
            supplier.setTin((String) supplierData.get("tin"));
            supplier = (Supplier) genericClassService.saveOrUpdateRecordLoadObject(supplier);

            System.out.println(supplierData);
            if (supplier.getSupplierid() != null) {
                return supplier.getSupplierid().toString();
            } else {
                return "failed";
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return "failed";
    }

    @RequestMapping(value = "/initSupplierPane", method = RequestMethod.GET)
    public String initSupplierPane(Model model, @ModelAttribute("tab") String tab) {
        List<Map> supplierList = new ArrayList<>();

        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"supplierid", "suppliername", "suppliercode", "physicaladdress", "active", "officetel", "emailaddress", "postaladdress", "tin", "villageid"};
        String where = "ORDER BY suppliername";
        List<Object[]> suppliers = (List<Object[]>) genericClassService.fetchRecord(Supplier.class, fields, where, params, paramsValues);
        if (suppliers != null) {
            Map<String, Object> supplier;
            for (Object[] object : suppliers) {
                supplier = new HashMap<>();
                supplier.put("id", object[0]);
                supplier.put("name", object[1]);
                supplier.put("code", object[2]);
                supplier.put("phy", object[3]);
                if (object[4] != null) {
                    if ((boolean) object[4]) {
                        supplier.put("status", "checked");
                    } else {
                        supplier.put("status", "");
                    }
                } else {
                    supplier.put("status", "");
                }
                supplier.put("tel", object[5]);
                supplier.put("email", object[6]);
                supplier.put("post", object[7]);
                supplier.put("tin", object[8]);
                String[] params2 = {"villageid"};
                Object[] paramsValues2 = {object[9]};
                String[] fields2 = {"villagename", "subcountyname", "districtname"};
                String where2 = "WHERE villageid=:villageid";
                List<Object[]> location = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fields2, where2, params2, paramsValues2);
                if (location != null) {
                    supplier.put("vil", location.get(0)[0]);
                    supplier.put("sub", location.get(0)[1]);
                    supplier.put("dis", location.get(0)[2]);
                }
                supplierList.add(supplier);
            }
        }

        List<Map> allClassifications = new ArrayList<>();
        String[] params2 = {"isactive"};
        Object[] paramsValues2 = {Boolean.TRUE};
        String[] fields2 = {"itemclassificationid", "classificationname"};
        String where2 = "WHERE isactive=:isactive ORDER BY classificationname";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields2, where2, params2, paramsValues2);
        if (classficationList != null) {
            Map<String, Object> classification;
            for (Object[] object : classficationList) {
                classification = new HashMap<>();
                classification.put("id", object[0]);
                classification.put("name", object[1]);
                allClassifications.add(classification);
            }
        }
        model.addAttribute("tab", tab);
        model.addAttribute("suppliers", supplierList);
        model.addAttribute("allClassifications", allClassifications);
        return "controlPanel/universalPanel/externalSuppliers/supplierCatologue/views/supplierPane";
    }

    @RequestMapping(value = "/activateSupplier", method = RequestMethod.POST)
    public @ResponseBody
    String activateSupplier(HttpServletRequest request, Model model, @ModelAttribute("id") Integer supplierid, @ModelAttribute("value") boolean value) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"active"};
            Object[] columnValues = {value};
            String pk = "supplierid";
            Object pkValue = supplierid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Supplier.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUpdateForm", method = RequestMethod.POST)
    public String fetchUnitClassificationStock(HttpServletRequest request, Model model, @ModelAttribute("supplierid") Integer supplierid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Map<String, Object> supplier = new HashMap<>();
            List<Map> districts = new ArrayList<>();

            String[] params = {"supplierid"};
            Object[] paramsValues = {supplierid};
            String[] fields = {"supplierid", "suppliername", "suppliercode", "physicaladdress", "officetel", "emailaddress", "postaladdress", "tin", "villageid", "operations", "fax"};
            String where = "WHERE supplierid=:supplierid";
            List<Object[]> suppliers = (List<Object[]>) genericClassService.fetchRecord(Supplier.class, fields, where, params, paramsValues);
            if (suppliers != null) {
                Object[] object = suppliers.get(0);
                supplier.put("id", object[0]);
                supplier.put("name", object[1]);
                supplier.put("code", object[2]);
                if (object[3] != null) {
                    String[] phy = ((String) object[3]).split("<br>");
                    supplier.put("str", phy[1]);
                    supplier.put("plo", phy[0]);
                } else {
                    supplier.put("str", "");
                    supplier.put("plo", "");
                }
                supplier.put("tel", object[4]);
                supplier.put("email", object[5]);
                supplier.put("post", object[6]);
                supplier.put("tin", object[7]);
                supplier.put("vil", object[8]);
                String[] params2 = {"villageid"};
                Object[] paramsValues2 = {object[8]};
                String[] fields2 = {"districtid"};
                String where2 = "WHERE villageid=:villageid";
                List<Object> location = (List<Object>) genericClassService.fetchRecord(Locations.class, fields2, where2, params2, paramsValues2);
                if (location != null) {
                    supplier.put("dis", location.get(0));
                }
                supplier.put("opr", object[9]);
                supplier.put("fax", object[10]);
            }

            String[] params2 = {};
            Object[] paramsValues2 = {};
            String[] fields2 = {"districtid", "districtname"};
            String where2 = "GROUP BY districtid, districtname ORDER BY districtname";
            List<Object[]> location = (List<Object[]>) genericClassService.fetchRecord(Locations.class, fields2, where2, params2, paramsValues2);
            if (location != null) {
                Map<String, Object> district;
                for (Object[] dis : location) {
                    district = new HashMap<>();
                    district.put("id", dis[0]);
                    district.put("name", dis[1]);
                    districts.add(district);
                }
            }
            model.addAttribute("supplier", supplier);
            model.addAttribute("districts", districts);
            return "controlPanel/universalPanel/externalSuppliers/supplierCatologue/forms/updateSupplier";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/updateSupplier", method = RequestMethod.POST)
    public @ResponseBody
    String updateSupplier(HttpServletRequest request, Model model, @ModelAttribute("data") String data) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            try {
                Map<String, Object> supplierData = new ObjectMapper().readValue(data, Map.class);
                String[] columns = {"suppliername", "suppliercode", "physicaladdress", "officetel", "emailaddress", "postaladdress", "tin", "villageid", "operations", "fax"};
                Object[] columnValues = {(String) supplierData.get("name"), (String) supplierData.get("code"), (String) supplierData.get("phy"), (String) supplierData.get("tel"), (String) supplierData.get("email"), (String) supplierData.get("post"), (String) supplierData.get("tin"), (Integer) supplierData.get("villageid"), (String) supplierData.get("operations"), (String) supplierData.get("fax")};
                String pk = "supplierid";
                Object pkValue = ((Integer) supplierData.get("id")).longValue();
                int result = genericClassService.updateRecordSQLSchemaStyle(Supplier.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    return "updated";
                } else {
                    return "failed";
                }
            } catch (IOException ex) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchSupplierItems", method = RequestMethod.GET)
    public String fetchSupplierItems(Model model, @ModelAttribute("supplierid") Integer supplierid) {
        List<Map> items = new ArrayList<>();
        List<Map> Classifications = new ArrayList<>();
        String[] params = {"supplierid"};
        Object[] paramsValues = {supplierid};
        String[] fields = {"supplieritemid", "itemcode", "packagename", "packsize", "itemcost", "isrestricted"};
        String where = "WHERE supplierid=:supplierid ORDER BY packagename";
        List<Object[]> itemList = (List<Object[]>) genericClassService.fetchRecord(Supplieritemcategories.class, fields, where, params, paramsValues);
        if (itemList != null) {
            Map<String, Object> item;
            for (Object[] object : itemList) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("code", object[1]);
                item.put("name", object[2]);
                item.put("pack", object[3]);
                if (object[4] != null) {
                    item.put("cost", String.format("%,.0f", (double) object[4]));
                } else {
                    item.put("cost", String.format("%,.0f", 0.0));
                }
                item.put("res", object[5]);
                items.add(item);
            }
        }

        String[] params2 = {"supplierid"};
        Object[] paramsValues2 = {supplierid};
        String[] fields2 = {"itemclassificationid", "classificationname"};
        String where2 = "WHERE supplierid=:supplierid GROUP BY itemclassificationid, classificationname ORDER BY classificationname";
        List<Object[]> classificationList = (List<Object[]>) genericClassService.fetchRecord(Supplieritemcategories.class, fields2, where2, params2, paramsValues2);
        if (classificationList != null) {
            Map<String, Object> classification;
            for (Object[] object : classificationList) {
                classification = new HashMap<>();
                classification.put("id", object[0]);
                classification.put("name", object[1]);
                Classifications.add(classification);
            }
        }
        model.addAttribute("items", items);
        model.addAttribute("classifications", Classifications);
        return "controlPanel/universalPanel/externalSuppliers/supplierCatologue/views/supplierItems";
    }

    @RequestMapping(value = "/searchItem", method = RequestMethod.GET)
    public String searchItem(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"value", "name", "isactive"};
        Object[] paramsValues = {searchValue.trim().toLowerCase() + "%", "%" + searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
        String[] fields = {"itempackageid", "packagename", "categoryname", "itemformid", "itemcode"};
        String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value) ORDER BY packagename";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            Map<String, Object> item;
            for (Object[] object : classficationList) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("name", object[1]);
                item.put("cat", object[2]);
                itemsFound.add(item);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("items", itemsFound);
        return "controlPanel/universalPanel/externalSuppliers/supplierCatologue/views/itemSearchResults";
    }

    @RequestMapping(value = "/saveSupplierCatalogue", method = RequestMethod.POST)
    public @ResponseBody
    String saveSupplierCatalogue(HttpServletRequest request, Model model, @ModelAttribute("supplierid") Integer supplierid, @ModelAttribute("items") String items) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            try {
                List<Map> supplierItems = new ObjectMapper().readValue(items, List.class);
                for (Map supplierItem : supplierItems) {
                    Supplieritem item = new Supplieritem();
                    item.setSupplierid(new Supplier(supplierid.longValue()));
                    item.setItemid(new Item(Long.parseLong(supplierItem.get("id").toString())));
                    item.setItemcode((String) supplierItem.get("code"));
                    item.setPacksize(Integer.parseInt(supplierItem.get("pack").toString()));
                    item.setItemcost(Double.parseDouble(supplierItem.get("cost").toString()));
                    item.setIsrestricted((boolean) supplierItem.get("res"));
                    genericClassService.saveOrUpdateRecordLoadObject(item);
                }
                return "saved";
            } catch (IOException ex) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchClassificationCategories_json", method = RequestMethod.POST)
    public @ResponseBody
    String fetchClassificationCategoriesjson(Model model, @ModelAttribute("supplierid") Integer supplierid, @ModelAttribute("classification") Integer classificationid) {
        List<Map> categories = new ArrayList<>();
        String[] params = {"supplierid", "itemclassificationid"};
        Object[] paramsValues = {supplierid, classificationid};
        String[] fields = {"itemcategoryid", "categoryname"};
        String where = "WHERE supplierid=:supplierid AND itemclassificationid=:itemclassificationid GROUP BY itemcategoryid, categoryname ORDER BY categoryname";
        List<Object[]> categoryList = (List<Object[]>) genericClassService.fetchRecord(Supplieritemcategories.class, fields, where, params, paramsValues);
        if (categoryList != null) {
            Map<String, Object> category;
            for (Object[] object : categoryList) {
                category = new HashMap<>();
                category.put("id", object[0]);
                category.put("name", object[1]);
                categories.add(category);
            }
        }
        String response = "";
        try {
            response = new ObjectMapper().writeValueAsString(categories);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return response;
    }

    @RequestMapping(value = "/filterCatalogItems", method = RequestMethod.POST)
    public String filterCatalogItems(Model model, @ModelAttribute("supplierid") Integer supplierid, @ModelAttribute("cat") Integer categoryid, @ModelAttribute("cla") Integer classificationid) {
        List<Map> categoryItems = new ArrayList<>();
        List<Map> Classifications = new ArrayList<>();
        String[] params;
        Object[] paramsValues;
        String where;
        if (categoryid == 0) {
            params = new String[]{"supplierid", "itemclassificationid"};
            paramsValues = new Object[]{supplierid, classificationid};
            where = "WHERE supplierid=:supplierid AND itemclassificationid=:itemclassificationid ORDER BY packagename";
        } else {
            params = new String[]{"supplierid", "categoryid"};
            paramsValues = new Object[]{supplierid, categoryid};
            where = "WHERE supplierid=:supplierid AND itemcategoryid=:categoryid ORDER BY packagename";
        }
        String[] fields = {"supplieritemid", "itemcode", "packagename", "packsize", "itemcost", "isrestricted"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Supplieritemcategories.class, fields, where, params, paramsValues);
        if (items != null) {
            Map<String, Object> item;
            for (Object[] object : items) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("code", object[1]);
                item.put("name", object[2]);
                item.put("pack", object[3]);
                if (object[4] != null) {
                    item.put("cost", String.format("%,.0f", (double) object[4]));
                } else {
                    item.put("cost", String.format("%,.0f", 0.0));
                }
                item.put("res", object[5]);
                categoryItems.add(item);
            }
        }

        String[] params2 = {"supplierid"};
        Object[] paramsValues2 = {supplierid};
        String[] fields2 = {"itemclassificationid", "classificationname"};
        String where2 = "WHERE supplierid=:supplierid GROUP BY itemclassificationid, classificationname ORDER BY classificationname";
        List<Object[]> classificationList = (List<Object[]>) genericClassService.fetchRecord(Supplieritemcategories.class, fields2, where2, params2, paramsValues2);
        if (classificationList != null) {
            Map<String, Object> classification;
            for (Object[] object : classificationList) {
                classification = new HashMap<>();
                classification.put("id", object[0]);
                classification.put("name", object[1]);
                Classifications.add(classification);
            }
        }
        model.addAttribute("items", categoryItems);
        model.addAttribute("classifications", Classifications);
        return "controlPanel/universalPanel/externalSuppliers/supplierCatologue/views/supplierItems";
    }

    @RequestMapping(value = "/updateCatalogItem", method = RequestMethod.POST)
    public @ResponseBody
    String updateCatalogItem(HttpServletRequest request, Model model, @ModelAttribute("id") Integer supplieritemid, @ModelAttribute("code") String code, @ModelAttribute("pack") Integer pack, @ModelAttribute("cost") String cost, @ModelAttribute("res") boolean isrestricted) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"itemcode", "packsize", "itemcost", "isrestricted"};
            Object[] columnValues = {code, pack, Double.parseDouble(cost), isrestricted};
            String pk = "supplieritemid";
            Object pkValue = supplieritemid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Supplieritem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/filterItemCode", method = RequestMethod.POST)
    public @ResponseBody
    String filterItemCode(Model model, @ModelAttribute("supplierid") Integer supplierid, @ModelAttribute("itemCode") String itemCode) {
        String[] params = {"supplierid", "itemcode"};
        Object[] paramsValues = {supplierid, itemCode.toLowerCase()};
        String[] fields = {"packagename"};
        String where = "WHERE supplierid=:supplierid AND LOWER(itemcode)=:itemcode";
        List<String> categoryList = (List<String>) genericClassService.fetchRecord(Supplieritemcategories.class, fields, where, params, paramsValues);
        if (categoryList != null) {
            return categoryList.get(0);
        }
        return "none";
    }

    //One time code reset
    @RequestMapping(value = "/codes", method = RequestMethod.GET)
    public @ResponseBody
    String codes(Model model) {
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"itemid"};
        String where = "";
        List<Object> items = (List<Object>) genericClassService.fetchRecord(Item.class, fields, where, params, paramsValues);
        if (items != null) {
            int i = 1;
            for (Object object : items) {
                String[] columns = {"itemcode"};
                Object[] columnValues = {generateCode(i++)};
                String pk = "itemid";
                Object pkValue = object;
                genericClassService.updateRecordSQLSchemaStyle(Item.class, columns, columnValues, pk, pkValue, "store");
            }
        }
        return "done";
    }

    //One time code reset
    @RequestMapping(value = "/clean", method = RequestMethod.GET)
    public @ResponseBody
    String clean(Model model) {
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"itemid"};
        String where = "";
        List<Object> items = (List<Object>) genericClassService.fetchRecord(Item.class, fields, where, params, paramsValues);
        if (items != null) {
            int i = 1;
            for (Object object : items) {
                String[] params2 = {"itemid"};
                Object[] paramsValues2 = {object};
                String where2 = "WHERE itemid=:itemid";
                int count = genericClassService.fetchRecordCount(Itemcategorisation.class, where2, params2, paramsValues2);
                if (count <= 0) {
                    Itemcategorisation itemCat = new Itemcategorisation();
                    itemCat.setIsactive(true);
                    itemCat.setItemcategoryid(new Itemcategory(((Integer)147).longValue()));
                    itemCat.setItemid(new Medicalitem((Long)object));
                    genericClassService.saveOrUpdateRecordLoadObject(itemCat);
                }
            }
        }
        return "cleaned";
    }

    private String generateCode(int i) {
        String value = String.valueOf(i);
        SimpleDateFormat f = new SimpleDateFormat("yy");
        switch (value.length()) {
            case 1:
                return "IICS" + f.format(new Date()) + "000" + value;
            case 2:
                return "IICS" + f.format(new Date()) + "00" + value;
            case 3:
                return "IICS" + f.format(new Date()) + "0" + value;
            default:
                return "IICS" + f.format(new Date()) + value;
        }
    }
}
