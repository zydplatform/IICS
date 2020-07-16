/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilitylevel;
import com.iics.service.GenericClassService;
import com.iics.store.Itemcategories;
import com.iics.store.Itemcategorisation;
import com.iics.store.Itemcategory;
import com.iics.store.Itemclassification;
import com.iics.store.Item;
import com.iics.store.Itemadministeringtype;
import com.iics.store.Itemform;
import com.iics.store.Itempackage;
import com.iics.store.Medicalitem;
import com.iics.store.Packages;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/essentialmedicinesandsupplieslist")
public class EssentialMedicinesAndSuppliesList {

    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/essentialmedicinesandsupplieslisthome.htm", method = RequestMethod.GET)
    public String essentialmedicinesandsupplieslisthome(Model model, HttpServletRequest request) {
        List<Map> classificationsFound = new ArrayList<>();
        List<Itemcategory> allSysubcategorys = new ArrayList<>();
        String[] params3 = {};
        Object[] paramsValues3 = {};
        String[] fields3 = {"itemcategoryid", "categoryname", "parentid"};
        List<Object[]> categoriesubcategory = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields3, "WHERE parentid IS NOT NULL", params3, paramsValues3);
        if (categoriesubcategory != null) {
            for (Object[] categoriesub : categoriesubcategory) {
                Itemcategory itemcategory = new Itemcategory();
                itemcategory.setCategoryname((String) categoriesub[1]);
                itemcategory.setItemcategoryid((Long) categoriesub[0]);
                itemcategory.setParentid((Long) categoriesub[2]);
                allSysubcategorys.add(itemcategory);
            }
        }

        String[] params5 = {"isactive", "ismedicine", "hasparent"};
        Object[] paramsValues5 = {Boolean.TRUE, Boolean.TRUE, Boolean.FALSE};
        String[] fields5 = {"itemclassificationid", "classificationname"};
        String where5 = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND hasparent=:hasparent ORDER BY r.classificationname ASC";
        List<Object[]> classsification5 = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields5, where5, params5, paramsValues5);
        if (classsification5 != null) {
            Map<String, Object> classificationRow;
            for (Object[] classsifications : classsification5) {
                classificationRow = new HashMap<>();
                classificationRow.put("itemclassificationid", classsifications[0]);
                classificationRow.put("classificationname", classsifications[1]);

                List<Map> classificationFound = new ArrayList<>();
                String[] params = {"isactive", "ismedicine", "parentid"};
                Object[] paramsValues = {Boolean.TRUE, Boolean.TRUE, classsifications[0]};
                String[] fields = {"itemclassificationid", "classificationname"};
                String where = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND parentid=:parentid ORDER BY r.classificationname ASC";
                List<Object[]> classsification = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);

                if (classsification != null) {
                    Map<String, Object> classificationsRow;
                    for (Object[] classsificationdet : classsification) {
                        classificationsRow = new HashMap<>();

                        classificationsRow.put("itemclassificationid", classsificationdet[0]);
                        classificationsRow.put("classificationname", classsificationdet[1]);

                        String[] params2 = {"itemclassificationid"};
                        Object[] paramsValues2 = {classsificationdet[0]};
                        String[] fields2 = {"itemcategoryid", "categoryname"};
                        List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE r.parentid IS NULL AND itemclassificationid=:itemclassificationid", params2, paramsValues2);
                        List<Map> categorysFound = new ArrayList<>();
                        if (classificationcategories != null) {
                            Map<String, Object> categorysRow;
                            for (Object[] classificationcategory : classificationcategories) {
                                categorysRow = new HashMap<>();
                                categorysRow.put("itemcategoryid", classificationcategory[0]);
                                categorysRow.put("categoryname", classificationcategory[1]);

                                int subCategorys = 0;
                                List<Long> subCategoryId = new ArrayList<>();
                                if (!allSysubcategorys.isEmpty()) {
                                    for (Itemcategory itemcategory : allSysubcategorys) {
                                        if (((Long) classificationcategory[0]).intValue() == itemcategory.getParentid().intValue()) {
                                            subCategorys = subCategorys + 1;
                                            subCategoryId.add(itemcategory.getItemcategoryid());
                                        }
                                    }
                                }

                                categorysRow.put("size", subCategorys);
                                if (subCategorys > 0) {
                                    categorysRow.put("subCategory", getcategorysubcategory(subCategoryId, allSysubcategorys));
                                }
                                categorysFound.add(categorysRow);
                            }
                        }
                        classificationsRow.put("categorysFound", categorysFound);
                        classificationsRow.put("size", categorysFound.size());
                        classificationFound.add(classificationsRow);
                    }
                }
                classificationRow.put("classificationsFound", classificationFound);
                classificationRow.put("size", classificationFound.size());

                classificationsFound.add(classificationRow);
            }
        }
        model.addAttribute("groupClassificationsFound", classificationsFound);

        String[] params2 = {};
        Object[] paramsValues2 = {};
        String[] fields2 = {"packagesid", "packagename"};
        List<Object[]> itemsdesrciptions = (List<Object[]>) genericClassService.fetchRecord(Packages.class, fields2, "", params2, paramsValues2);
        if (itemsdesrciptions != null) {
            model.addAttribute("descriptionsize", itemsdesrciptions.size() - 1);
        } else {
            model.addAttribute("descriptionsize", 0);
        }
        return "controlPanel/universalPanel/essentialmedicine/EssentialMedicinesAndSuppliesHome";
    }

    private List<Map> getcategorysubcategory(List<Long> subCategoryId, List<Itemcategory> allSysubcategorys) {
        List<Map> categorysFound = new ArrayList<>();
        Map<String, Object> categorysRow;
        for (Itemcategory itemcategorys : allSysubcategorys) {
            categorysRow = new HashMap<>();
            if (subCategoryId.contains(itemcategorys.getItemcategoryid())) {
                categorysRow.put("itemcategoryid", itemcategorys.getItemcategoryid());
                categorysRow.put("categoryname", itemcategorys.getCategoryname());
                int subCategorys = 0;
                List<Long> subCategorysubId = new ArrayList<>();
                for (Itemcategory itemcategory : allSysubcategorys) {
                    if ((itemcategorys.getItemcategoryid()).intValue() == itemcategory.getParentid().intValue()) {
                        subCategorys = subCategorys + 1;
                        subCategorysubId.add(itemcategory.getItemcategoryid());
                    }
                }
                categorysRow.put("size", subCategorys);
                if (subCategorys > 0) {
                    categorysRow.put("subCategory", getcategorysubcategory(subCategorysubId, allSysubcategorys));
                }
                categorysFound.add(categorysRow);
            }
        }
        return categorysFound;
    }

    @RequestMapping(value = "/savenewitemclassification.htm")
    public @ResponseBody
    String savenewitemclassification(HttpServletRequest request) {
        String response = "";
        if ("classification".equals(request.getParameter("type"))) {
            Itemclassification itemclassification = new Itemclassification();
            itemclassification.setClassificationname(request.getParameter("classificationname"));
            itemclassification.setClassificationdescription(request.getParameter("classificationdesc"));
            itemclassification.setParentid(Long.parseLong(request.getParameter("Itemclassificationid")));
            itemclassification.setIsactive(true);
            itemclassification.setIsmedicine(true);
            itemclassification.setHasparent(Boolean.TRUE);
            itemclassification.setIsdeleted(Boolean.FALSE);

            genericClassService.saveOrUpdateRecordLoadObject(itemclassification);

        } else if ("category".equals(request.getParameter("type"))) {
            Itemcategory itemcategory = new Itemcategory();
            itemcategory.setCategorydescription(request.getParameter("categorydesc"));
            itemcategory.setCategoryname(request.getParameter("categoryname"));
            itemcategory.setIsactive(true);
            itemcategory.setItemclassificationid(new Itemclassification(Long.parseLong(request.getParameter("classificationid"))));
            genericClassService.saveOrUpdateRecordLoadObject(itemcategory);

        } else if ("item".equals(request.getParameter("type"))) {
            Medicalitem item = new Medicalitem();
            item.setGenericname(request.getParameter("itemname"));
            item.setIsactive(Boolean.TRUE);
            if ("Yes".equals(request.getParameter("isspecial"))) {
                item.setIsspecial(Boolean.TRUE);
            } else {
                item.setIsspecial(Boolean.FALSE);
            }
            item.setPacksize(0);
            item.setIssupplies(Boolean.FALSE);
            item.setRestricted(false);
            item.setItemformid(new Itemform(19));
            item.setItemadministeringtypeid(new Itemadministeringtype(1));
            item.setItemform(request.getParameter("dosageform"));
            item.setLevelofuse(Integer.parseInt(request.getParameter("level")));
            item.setItemusage(request.getParameter("useclass"));
            item.setItemstrength(request.getParameter("strength"));
            item.setItemsource("ems");
            item.setIsdeleted(Boolean.FALSE);

            Object save = genericClassService.saveOrUpdateRecordLoadObject(item);
            if (save != null) {
                Itemcategorisation itemcategorisation = new Itemcategorisation();
                itemcategorisation.setIsactive(true);
                itemcategorisation.setItemid(item);
                itemcategorisation.setUpdatedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));

                itemcategorisation.setItemcategoryid(new Itemcategory(Long.parseLong(request.getParameter("Itemcategoryid"))));
                Object saves = genericClassService.saveOrUpdateRecordLoadObject(itemcategorisation);

                Item item1 = new Item();
                item1.setDateadded(new Date());
                item1.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                item1.setQty(1);
                item1.setIsactive(Boolean.TRUE);
                item1.setMedicalitemid(new Medicalitem(item.getMedicalitemid()));
                item1.setPackagesid(new Packages(Long.parseLong(String.valueOf(1))));
                genericClassService.saveOrUpdateRecordLoadObject(item1);
                response = item.getMedicalitemid().toString();
            }

        } else if ("subcategory".equals(request.getParameter("type"))) {
            Itemcategory itemcategory = new Itemcategory();
            itemcategory.setCategorydescription(request.getParameter("categorydesc"));
            itemcategory.setCategoryname(request.getParameter("categoryname"));
            itemcategory.setIsactive(true);

            itemcategory.setParentid(Long.parseLong(request.getParameter("Itemcategoryid")));
            itemcategory.setItemclassificationid(new Itemclassification(Long.parseLong(request.getParameter("classificationid"))));
            genericClassService.saveOrUpdateRecordLoadObject(itemcategory);
        }

        return response;
    }

    @RequestMapping(value = "/getclassificationcategories.htm", method = RequestMethod.GET)
    public String getclassificationcategories(Model model, HttpServletRequest request) {
        List<Map> categorysFound = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            String[] params2 = {"itemclassificationid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemclassificationid"))};
            String[] fields2 = {"itemcategoryid", "categoryname", "isactive", "categorydescription"};
            List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE r.parentid IS NULL AND itemclassificationid=:itemclassificationid", params2, paramsValues2);

            if (classificationcategories != null) {
                Map<String, Object> categorysRow;
                for (Object[] classificationcategory : classificationcategories) {
                    categorysRow = new HashMap<>();
                    categorysRow.put("itemcategoryid", classificationcategory[0]);
                    categorysRow.put("categoryname", classificationcategory[1]);
                    categorysRow.put("isactive", classificationcategory[2]);
                    categorysRow.put("categorydescription", classificationcategory[3]);
                    categorysFound.add(categorysRow);
                }
            }
            model.addAttribute("act", request.getParameter("act"));
        } else if ("c".equals(request.getParameter("act"))) {

            String[] params = {"itemcategoryid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields = {"itemcategorisationid", "itemid.medicalitemid"};
            String where = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> categoryitems = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields, where, params, paramsValues);
            if (categoryitems != null) {
                Map<String, Object> categorysRow;
                for (Object[] categoryitem : categoryitems) {
                    categorysRow = new HashMap<>();
                    String[] params2 = {"medicalitemid"};
                    Object[] paramsValues2 = {categoryitem[1]};
                    String[] fields2 = {"genericname", "itemstrength", "levelofuse", "isspecial", "itemadministeringtypeid", "itemusage", "itemform", "isactive"};
                    List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
                    categorysRow.put("genericname", genericname.get(0)[0]);
                    categorysRow.put("itemstrength", genericname.get(0)[1]);
                    categorysRow.put("isspecial", genericname.get(0)[3]);
                    categorysRow.put("itemusage", genericname.get(0)[5]);
                    categorysRow.put("itemid", categoryitem[1]);
                    categorysRow.put("isactive", genericname.get(0)[7]);
                    categorysRow.put("dosageform", genericname.get(0)[6]);
                    String[] params6 = {"facilitylevelid"};
                    Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
                    String[] fields6 = {"shortname"};
                    String where6 = "WHERE facilitylevelid=:facilitylevelid";
                    List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
                    if (levelofuse != null) {
                        categorysRow.put("levelofuse", levelofuse.get(0));
                    } else {
                        categorysRow.put("levelofuse", "N/A");
                    }
                    String[] paramsl = {"medicalitemid", "isactive"};
                    Object[] paramsValuesl = {categoryitem[1], Boolean.TRUE};
                    String wherel = "WHERE medicalitemid=:medicalitemid AND isactive=:isactive";
                    int packages = genericClassService.fetchRecordCount(Item.class, wherel, paramsl, paramsValuesl);
                    categorysRow.put("itempackages", packages);
                    categorysFound.add(categorysRow);
                }
            }
            model.addAttribute("act", request.getParameter("act"));
            model.addAttribute("itemcategoryid", request.getParameter("itemcategoryid"));
        } else {
            model.addAttribute("type", request.getParameter("type"));
            model.addAttribute("act", request.getParameter("act"));
        }

        model.addAttribute("categorysFound", categorysFound);

        return "controlPanel/universalPanel/essentialmedicine/views/category";
    }

    @RequestMapping(value = "/getcategorysubcategory.htm")
    public @ResponseBody
    String getcategorysubcategory(Model model, HttpServletRequest request) {
        String response = "";
        String result = "";

        String[] params2 = {"parentid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemcategoryid"))};
        String[] fields2 = {"itemcategoryid", "categoryname"};
        List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE parentid=:parentid", params2, paramsValues2);

        if (classificationcategories != null) {

            String[] params6 = {"itemcategoryid"};
            Object[] paramsValues6 = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields6 = {"itemcategorisationid", "itemid.medicalitemid"};
            List<Object[]> classificationcategoriesitems = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields6, "WHERE itemcategoryid=:itemcategoryid", params6, paramsValues6);
            if (classificationcategoriesitems != null) {
                result = "categoryanditems";
                response = "all";
            } else {
                result = "category";
                response = "all";
            }

        } else {
            String[] params = {"itemcategoryid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields = {"itemcategorisationid", "itemid.medicalitemid"};
            String where = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> categoryitems = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields, where, params, paramsValues);
            if (categoryitems != null) {
                result = "items";
                response = "all";
            } else {
                result = "null";
                response = "allnull";
            }
        }
        return response + "~" + result;
    }

    @RequestMapping(value = "/getcategoriessubcategorylist.htm", method = RequestMethod.GET)
    public String getcategoriessubcategory(Model model, HttpServletRequest request) {
        List<Map> categorysFound = new ArrayList<>();
        String[] params2 = {"parentid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemcategoryid"))};
        String[] fields2 = {"itemcategoryid", "categoryname", "isactive", "categorydescription"};
        List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE parentid=:parentid", params2, paramsValues2);
        if (classificationcategories != null) {
            Map<String, Object> categorysRow;
            for (Object[] itemcategory : classificationcategories) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemcategoryid", itemcategory[0]);
                categorysRow.put("categoryname", itemcategory[1]);
                categorysRow.put("isactive", itemcategory[2]);
                categorysRow.put("categorydescription", itemcategory[3]);
                categorysFound.add(categorysRow);
            }
        }
        model.addAttribute("categorysFound", categorysFound);
        model.addAttribute("act", request.getParameter("act"));
        model.addAttribute("type", request.getParameter("type"));
        return "controlPanel/universalPanel/essentialmedicine/views/category";
    }

    @RequestMapping(value = "/addnewitemform.htm", method = RequestMethod.GET)
    public String addnewitemform(Model model, HttpServletRequest request) {

        List<Map> levelsFound = new ArrayList<>();
        String[] paramsl = {};
        Object[] paramsValuesl = {};
        String[] fieldsl = {"facilitylevelid", "shortname"};
        String wherel = "";
        List<Object[]> levels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fieldsl, wherel, paramsl, paramsValuesl);
        if (levels != null) {
            Map<String, Object> levelRow;
            for (Object[] level : levels) {
                levelRow = new HashMap<>();
                levelRow.put("facilitylevelid", level[0]);
                levelRow.put("shortname", level[1]);
                levelsFound.add(levelRow);
            }
        }
        model.addAttribute("levelsFound", levelsFound);
        model.addAttribute("classificationname", request.getParameter("classificationname"));
        model.addAttribute("categoryname", request.getParameter("categoryname"));
        return "controlPanel/universalPanel/essentialmedicine/forms/itemForm";
    }

    @RequestMapping(value = "/searchitem.htm", method = RequestMethod.GET)
    public String searchitem(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"value", "name", "isactive", "issupplies", "itemisdeleted"};
        Object[] paramsValues = {request.getParameter("name").trim().toLowerCase() + "%", "%" + request.getParameter("name").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.FALSE, Boolean.FALSE};
        String[] fields = {"itemid", "fullname", "categoryname", "itemclassificationid", "classificationname", "itemcategoryid"};
        String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND itemisdeleted=:itemisdeleted AND (LOWER(fullname) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY fullname";
        List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
        if (itemsList != null) {
            Map<String, Object> itemRow;
            for (Object[] item : itemsList) {
                itemRow = new HashMap<>();
                itemRow.put("itemid", item[0]);
                itemRow.put("genericname", item[1]);
                itemRow.put("categoryname", item[2]);
                itemRow.put("itemclassificationid", item[3]);
                itemRow.put("classificationname", item[4]);
                itemRow.put("itemcategoryid", item[5]);
                itemsFound.add(itemRow);
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("name", request.getParameter("name"));
        return "controlPanel/universalPanel/essentialmedicine/views/searchResults";
    }

    private Set<Long> getParentCategory(Long itemcategoryid) {
        Set<Long> assigned = new HashSet<>();
        String[] params = {"itemcategoryid"};
        Object[] paramsValues = {itemcategoryid};
        String[] fields = {"parentid","isactive"};
        String where = "WHERE itemcategoryid=:itemcategoryid";
        List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields, where, params, paramsValues);
        if (itemsList.get(0)[0] != null) {
            assigned.add((Long)itemsList.get(0)[0]);
            getParentCategory((Long)itemsList.get(0)[0]);
        }
        return assigned;
    }

    private List<Map> generateSubCategory(Long itemcategoryid, Set<Long> assigned) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"parentid"};
        Object[] paramsValues = {itemcategoryid};
        String[] fields = {"itemcategoryid", "categoryname"};
        String where = "WHERE parentid=:parentid";
        List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields, where, params, paramsValues);
        if (itemsList != null) {
            Map<String, Object> categorysRow;
            for (Object[] items : itemsList) {
                if (assigned.contains((Long) items[0])) {
                    categorysRow = new HashMap<>();
                    categorysRow.put("itemcategoryid", items[0]);
                    categorysRow.put("categoryname", items[1]);
                    categorysRow.put("size", generateSubCategory((Long) items[0], assigned).size());
                    categorysRow.put("SubCategory", generateSubCategory((Long) items[0], assigned));
                    itemsFound.add(categorysRow);
                }
            }

        }
        return itemsFound;
    }

    @RequestMapping(value = "/getitemtreeclassification.htm", method = RequestMethod.GET)
    public String getitemtreeclassification(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String result_view = "";
        if ("a".equals(request.getParameter("act"))) {
            Set<Long> assigned = new HashSet<>();

            String[] params = {"itemcategoryid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields = {"parentid","isactive"};
            String where = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields, where, params, paramsValues);
            assigned.add(Long.parseLong(request.getParameter("itemcategoryid")));
            if (itemsList.get(0)[0] != null) {

                assigned.add((Long)itemsList.get(0)[0]);
                Set<Long> assign = getParentCategory((Long)itemsList.get(0)[0]);
                if (assign.size() > 0) {
                    for (Long set : assign) {
                        assigned.add(set);
                    }
                }

            }
            Map<String, Object> categorysRow;
            if (!assigned.isEmpty()) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemclassificationid", request.getParameter("itemclassificationid"));
                categorysRow.put("classificationname", request.getParameter("classificationname"));

                String[] params2 = {"itemclassificationid"};
                Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemclassificationid"))};
                String[] fields2 = {"itemcategoryid", "categoryname"};
                String where2 = "WHERE r.itemclassificationid.itemclassificationid=:itemclassificationid AND r.parentid IS NULL";
                List<Object[]> itemsList2 = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, where2, params2, paramsValues2);
                List<Map> subCategoryFound = new ArrayList<>();
                if (itemsList2 != null) {
                    Map<String, Object> subcategoryRow;
                    for (Object[] itemcategoryid : itemsList2) {
                        subcategoryRow = new HashMap<>();
                        if (assigned.contains((Long) itemcategoryid[0])) {
                            subcategoryRow.put("itemcategoryid", itemcategoryid[0]);
                            subcategoryRow.put("categoryname", itemcategoryid[1]);

                            subcategoryRow.put("SubCategory", generateSubCategory((Long) itemcategoryid[0], assigned));
                            subcategoryRow.put("size", generateSubCategory((Long) itemcategoryid[0], assigned).size());

                            subCategoryFound.add(subcategoryRow);
                        }

                    }
                }
                categorysRow.put("SubCategory", subCategoryFound);
                itemsFound.add(categorysRow);
            }
            model.addAttribute("classificationname", request.getParameter("classificationname"));
            model.addAttribute("itemsFound", itemsFound);
            try {
                model.addAttribute("itemsFoundList", new ObjectMapper().writeValueAsString(itemsFound));
            } catch (JsonProcessingException e) {
            }
            result_view = "controlPanel/universalPanel/essentialmedicine/views/itemStructure";
        } else if ("b".equals(request.getParameter("act"))) {
            Map<String, Object> categorysRow;
            String[] params2 = {"medicalitemid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemid"))};
            String[] fields2 = {"genericname", "itemstrength", "levelofuse", "isspecial", "itemadministeringtypeid", "itemusage", "itemform", "isactive"};
            List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
            if (genericname != null) {
                categorysRow = new HashMap<>();
                model.addAttribute("name", genericname.get(0)[0]);
                categorysRow.put("itemstrength", genericname.get(0)[1]);
                categorysRow.put("isspecial", genericname.get(0)[3]);
                categorysRow.put("itemusage", genericname.get(0)[5]);
                categorysRow.put("isactive", genericname.get(0)[7]);
                categorysRow.put("dosageform", genericname.get(0)[6]);
                String[] params6 = {"facilitylevelid"};
                Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
                String[] fields6 = {"shortname"};
                String where6 = "WHERE facilitylevelid=:facilitylevelid";
                List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
                if (levelofuse.get(0) != null) {
                    categorysRow.put("levelofuse", levelofuse.get(0));
                } else {
                    categorysRow.put("levelofuse", "N/A");
                }
                String[] paramsl = {"medicalitemid", "isactive"};
                Object[] paramsValuesl = {Long.parseLong(request.getParameter("itemid")), Boolean.TRUE};
                String[] fieldsl = {"itemid", "qty"};
                String wherel = "WHERE medicalitemid=:medicalitemid AND isactive=:isactive";
                List<Object[]> itempackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fieldsl, wherel, paramsl, paramsValuesl);
                if (itempackages != null) {
                    categorysRow.put("itempackages", itempackages.size());
                } else {
                    categorysRow.put("itempackages", 0);
                }
                itemsFound.add(categorysRow);
            }
            result_view = "controlPanel/universalPanel/essentialmedicine/views/itemDetails";
        }
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("itemid", request.getParameter("itemid"));
        return result_view;
    }

    @RequestMapping(value = "/activateordeactivateitemorcategory.htm")
    public @ResponseBody
    String activateordeactivateitemorcategory(Model model, HttpServletRequest request) {
        String response = "";
        if ("deactivate".equals(request.getParameter("type"))) {
            String[] columns = {"isactive"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "medicalitemid";
            Object pkValue = Long.parseLong(request.getParameter("itemid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Medicalitem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        } else {
            String[] columns = {"isactive"};
            Object[] columnValues = {Boolean.TRUE};
            String pk = "medicalitemid";
            Object pkValue = Long.parseLong(request.getParameter("itemid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Medicalitem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        }
        return response;
    }

    @RequestMapping(value = "/activatedordeactivatedcategory.htm")
    public @ResponseBody
    String activatedordeactivatedcategory(Model model, HttpServletRequest request) {
        String response = "";
        if ("activate".equals(request.getParameter("type"))) {
            String[] columns = {"isactive"};
            Object[] columnValues = {Boolean.TRUE};
            String pk = "itemcategoryid";
            Object pkValue = Long.parseLong(request.getParameter("itemcategoryid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemcategory.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        } else {
            String[] columns = {"isactive"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "itemcategoryid";
            Object pkValue = Long.parseLong(request.getParameter("itemcategoryid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemcategory.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        }
        return response;
    }

    @RequestMapping(value = "/deletecategoryitem.htm")
    public @ResponseBody
    String deletecategoryitem(Model model, HttpServletRequest request) {
        String response = "";
        String[] params7 = {"itemid"};
        Object[] paramsValues7 = {Long.parseLong(request.getParameter("itemid"))};
        String[] fields7 = {"itemcategorisationid"};
        String where7 = "WHERE r.itemid.medicalitemid=:itemid";
        List<Long> itemcategorisationid = (List<Long>) genericClassService.fetchRecord(Itemcategorisation.class, fields7, where7, params7, paramsValues7);
        if (itemcategorisationid != null) {
            for (Long itemcategorisation : itemcategorisationid) {
                String[] columns = {"itemcategorisationid"};
                Object[] columnValues = {itemcategorisation};
                int result = genericClassService.deleteRecordByByColumns("store.itemcategorisation", columns, columnValues);
                if (result != 0) {

                    String[] paramsl = {"medicalitemid"};
                    Object[] paramsValuesl = {Long.parseLong(request.getParameter("itemid"))};
                    String[] fieldsl = {"itemid", "qty"};
                    String wherel = "WHERE medicalitemid=:medicalitemid";
                    List<Object[]> itempackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fieldsl, wherel, paramsl, paramsValuesl);
                    if (itempackages != null) {
                        for (Object[] itempackage : itempackages) {
                            String[] columns1 = {"itemid"};
                            Object[] columnValues1 = {itempackage[0]};
                            int result1 = genericClassService.deleteRecordByByColumns("store.item", columns1, columnValues1);
                            if (result1 != 0) {
                            }
                        }
                    }

                    String[] columns1 = {"medicalitemid"};
                    Object[] columnValues1 = {Long.parseLong(request.getParameter("itemid"))};
                    int result1 = genericClassService.deleteRecordByByColumns("store.medicalitem", columns1, columnValues1);
                    if (result1 != 0) {
                        response = "deleted";
                    }
                }
            }

        }

        return response;
    }

    @RequestMapping(value = "/editclassificationcategoryitem.htm", method = RequestMethod.GET)
    public String editclassificationcategoryitem(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params2 = {"medicalitemid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemid"))};
        String[] fields2 = {"genericname", "itemstrength", "levelofuse", "isspecial", "itemadministeringtypeid", "itemusage", "itemform", "isactive"};
        List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
        if (genericname != null) {

            model.addAttribute("name", genericname.get(0)[0]);
            model.addAttribute("itemstrength", genericname.get(0)[1]);
            model.addAttribute("isspecial", genericname.get(0)[3]);
            model.addAttribute("itemusage", genericname.get(0)[5]);
            model.addAttribute("isactive", genericname.get(0)[7]);
            model.addAttribute("dosageform", genericname.get(0)[6]);
            String[] params6 = {"facilitylevelid"};
            Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
            String[] fields6 = {"shortname"};
            String where6 = "WHERE facilitylevelid=:facilitylevelid";
            List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
            if (levelofuse.get(0) != null) {
                model.addAttribute("levelofuse", levelofuse.get(0));
                model.addAttribute("facilitylevelid", genericname.get(0)[2]);
            } else {
                model.addAttribute("levelofuse", "N/A");
            }
        }
        String[] params8 = {};
        Object[] paramsValues8 = {};
        String[] fields8 = {"shortname", "facilitylevelid"};
        String where8 = "";
        List<Object[]> levelofuse8 = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields8, where8, params8, paramsValues8);
        if (levelofuse8 != null) {
            Map<String, Object> categorysRow;
            for (Object[] level : levelofuse8) {
                categorysRow = new HashMap<>();
                categorysRow.put("shortname", level[0]);
                categorysRow.put("facilitylevelid", level[1]);
                itemsFound.add(categorysRow);
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        return "controlPanel/universalPanel/essentialmedicine/forms/itemEdit";
    }

    @RequestMapping(value = "/updatecategoryitem.htm")
    public @ResponseBody
    String updatecategoryitem(Model model, HttpServletRequest request) {
        String response = "";
        if ("Yes".equals(request.getParameter("isspecial"))) {
            String[] columns = {"genericname", "itemstrength", "itemusage", "isspecial", "itemform", "levelofuse"};
            Object[] columnValues = {request.getParameter("itemname"), request.getParameter("strength"), request.getParameter("useclass"), Boolean.TRUE, request.getParameter("dosageform"), Integer.parseInt(request.getParameter("level"))};
            String pk = "medicalitemid";
            Object pkValue = Long.parseLong(request.getParameter("itemid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Medicalitem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        } else {
            String[] columns = {"genericname", "itemstrength", "itemusage", "isspecial", "itemform", "levelofuse"};
            Object[] columnValues = {request.getParameter("itemname"), request.getParameter("strength"), request.getParameter("useclass"), Boolean.FALSE, request.getParameter("dosageform"), Integer.parseInt(request.getParameter("level"))};
            String pk = "medicalitemid";
            Object pkValue = Long.parseLong(request.getParameter("itemid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Medicalitem.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        }

        return response;
    }

    @RequestMapping(value = "/checkexistingcategoryitemname.htm")
    public @ResponseBody
    String checkexistingcategoryitemname(Model model, HttpServletRequest request) {
        String response = "";

        String[] params8 = {"genericname"};
        Object[] paramsValues8 = {request.getParameter("value")};
        String[] fields8 = {"medicalitemid", "genericname"};
        String where8 = "WHERE genericname=:genericname";
        List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields8, where8, params8, paramsValues8);
        if (genericname != null) {
            response = ((Long) genericname.get(0)[0]).toString();
        } else {
            response = "success";
        }
        return response;
    }

    @RequestMapping(value = "/deletingclassificationcategory.htm")
    public @ResponseBody
    String deletingclassificationcategory(Model model, HttpServletRequest request) {
        String response = "";
        String[] params2 = {"parentid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemcategoryid"))};
        String[] fields2 = {"itemcategoryid", "categoryname", "isactive"};
        List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE parentid=:parentid", params2, paramsValues2);
        if (classificationcategories != null) {
            response = "failed";
        } else {
            String[] params8 = {"itemcategoryid"};
            Object[] paramsValues8 = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields8 = {"itemcategorisationid", "isactive"};
            String where8 = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields8, where8, params8, paramsValues8);
            if (genericname != null) {
                response = "failed";
            } else {
                String[] columns1 = {"itemcategoryid"};
                Object[] columnValues1 = {Long.parseLong(request.getParameter("itemcategoryid"))};
                int result1 = genericClassService.deleteRecordByByColumns("store.itemcategory", columns1, columnValues1);
                if (result1 != 0) {
                    String[] params3 = {"parentid"};
                    Object[] paramsValues3 = {Long.parseLong(request.getParameter("parentItemcategoryid"))};
                    String[] fields3 = {"itemcategoryid", "categoryname", "isactive"};
                    List<Object[]> test = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields3, "WHERE parentid=:parentid", params3, paramsValues3);
                    if (test != null) {
                        response = "hassubcomponents";
                    } else {
                        response = "hasno";
                    }
                }
            }
        }

        return response;
    }

    @RequestMapping(value = "/updatecategory.htm")
    public @ResponseBody
    String updatecategory(Model model, HttpServletRequest request) {
        String response = "";
        String[] columns = {"categoryname", "categorydescription"};
        Object[] columnValues = {request.getParameter("categoryname"), request.getParameter("categorydescription")};
        String pk = "itemcategoryid";
        Object pkValue = Long.parseLong(request.getParameter("itemcategoryid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Itemcategory.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            response = "success";
        }
        return response;
    }

    @RequestMapping(value = "/essentialsupplieslist.htm", method = RequestMethod.GET)
    public String essentialsupplieslist(Model model, HttpServletRequest request) {
        List<Map> classificationsFound = new ArrayList<>();

        List<Itemcategory> allSysubcategorys = new ArrayList<>();
        String[] params3 = {};
        Object[] paramsValues3 = {};
        String[] fields3 = {"itemcategoryid", "categoryname", "parentid"};
        List<Object[]> categoriesubcategory = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields3, "WHERE parentid IS NOT NULL", params3, paramsValues3);
        if (categoriesubcategory != null) {
            for (Object[] categoriesub : categoriesubcategory) {
                Itemcategory itemcategory = new Itemcategory();
                itemcategory.setCategoryname((String) categoriesub[1]);
                itemcategory.setItemcategoryid((Long) categoriesub[0]);
                itemcategory.setParentid((Long) categoriesub[2]);
                allSysubcategorys.add(itemcategory);
            }
        }

        String[] params5 = {"isactive", "ismedicine", "hasparent"};
        Object[] paramsValues5 = {Boolean.TRUE, Boolean.FALSE, Boolean.FALSE};
        String[] fields5 = {"itemclassificationid", "classificationname"};
        String where5 = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND hasparent=:hasparent ORDER BY r.classificationname ASC";
        List<Object[]> classsification5 = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields5, where5, params5, paramsValues5);
        if (classsification5 != null) {
            Map<String, Object> classificationRow;
            for (Object[] classs : classsification5) {
                classificationRow = new HashMap<>();
                classificationRow.put("itemclassificationid", classs[0]);
                classificationRow.put("classificationname", classs[1]);

                List<Map> classificationFound = new ArrayList<>();

                String[] params = {"isactive", "ismedicine", "parentid"};
                Object[] paramsValues = {Boolean.TRUE, Boolean.FALSE, classs[0]};
                String[] fields = {"itemclassificationid", "classificationname"};
                String where = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND parentid=:parentid ORDER BY r.classificationname ASC";
                List<Object[]> classsification = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);

                if (classsification != null) {
                    Map<String, Object> classificationsRow;
                    for (Object[] classsificationdet : classsification) {

                        classificationsRow = new HashMap<>();

                        classificationsRow.put("itemclassificationid", classsificationdet[0]);
                        classificationsRow.put("classificationname", classsificationdet[1]);

                        String[] params2 = {"itemclassificationid"};
                        Object[] paramsValues2 = {classsificationdet[0]};
                        String[] fields2 = {"itemcategoryid", "categoryname"};
                        List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE r.parentid IS NULL AND itemclassificationid=:itemclassificationid", params2, paramsValues2);
                        List<Map> categorysFound = new ArrayList<>();
                        if (classificationcategories != null) {
                            Map<String, Object> categorysRow;
                            for (Object[] classificationcategory : classificationcategories) {
                                categorysRow = new HashMap<>();
                                categorysRow.put("itemcategoryid", classificationcategory[0]);
                                categorysRow.put("categoryname", classificationcategory[1]);

                                int subCategorys = 0;
                                List<Long> subCategoryId = new ArrayList<>();
                                if (!allSysubcategorys.isEmpty()) {
                                    for (Itemcategory itemcategory : allSysubcategorys) {
                                        if (((Long) classificationcategory[0]).intValue() == itemcategory.getParentid().intValue()) {
                                            subCategorys = subCategorys + 1;
                                            subCategoryId.add(itemcategory.getItemcategoryid());
                                        }
                                    }
                                }

                                categorysRow.put("size", subCategorys);
                                if (subCategorys > 0) {
                                    categorysRow.put("subCategory", getcategorysubcategory(subCategoryId, allSysubcategorys));
                                }
                                categorysFound.add(categorysRow);
                            }
                        }
                        classificationsRow.put("categorysFound", categorysFound);
                        classificationsRow.put("size", categorysFound.size());
                        classificationFound.add(classificationsRow);
                    }
                }
                classificationRow.put("categoryclassFound", classificationFound);
                classificationRow.put("size", classificationFound.size());
                classificationsFound.add(classificationRow);
            }
        }

        model.addAttribute("classificationsFound", classificationsFound);
        try {
            model.addAttribute("groupClassificationsFoundsiz", new ObjectMapper().writeValueAsString(classificationsFound));
        } catch (Exception e) {
        }
        return "controlPanel/universalPanel/essentialmedicine/supplies/EssentialSuppliesHome";
    }

    //suppllies
    @RequestMapping(value = "/savenewsuppliesclassification.htm")
    public @ResponseBody
    String savenewsuppliesclassification(HttpServletRequest request) {
        String response = "";
        if ("classification".equals(request.getParameter("type"))) {
            Itemclassification itemclassification = new Itemclassification();
            itemclassification.setClassificationname(request.getParameter("classificationname"));
            itemclassification.setClassificationdescription(request.getParameter("classificationdesc"));
            itemclassification.setIsactive(true);
            itemclassification.setIsmedicine(false);
            itemclassification.setParentid(Long.parseLong(request.getParameter("parentid")));
            itemclassification.setHasparent(Boolean.TRUE);
            itemclassification.setIsdeleted(Boolean.FALSE);
            genericClassService.saveOrUpdateRecordLoadObject(itemclassification);

        } else if ("category".equals(request.getParameter("type"))) {
            Itemcategory itemcategory = new Itemcategory();
            itemcategory.setCategorydescription(request.getParameter("categorydesc"));
            itemcategory.setCategoryname(request.getParameter("categoryname"));
            itemcategory.setIsactive(true);
            itemcategory.setItemclassificationid(new Itemclassification(Long.parseLong(request.getParameter("classificationid"))));
            genericClassService.saveOrUpdateRecordLoadObject(itemcategory);

        } else if ("item".equals(request.getParameter("type"))) {
            Medicalitem item = new Medicalitem();
            item.setGenericname(request.getParameter("itemname"));
            item.setIsactive(Boolean.TRUE);
            item.setIsspecial(Boolean.FALSE);
            item.setItemadministeringtypeid(new Itemadministeringtype(1));
            item.setItemformid(new Itemform(19));
            item.setPacksize(0);
            item.setIsspecial(Boolean.valueOf(request.getParameter("isspecial")));

            item.setIssupplies(Boolean.TRUE);
            item.setRestricted(false);
            item.setLevelofuse(Integer.parseInt(request.getParameter("level")));
            item.setItemusage(request.getParameter("useclass"));
            item.setSpecification(request.getParameter("specification"));
            item.setIsdeleted(Boolean.FALSE);
            item.setItemsource("ems");

            Object save = genericClassService.saveOrUpdateRecordLoadObject(item);
            if (save != null) {
                Itemcategorisation itemcategorisation = new Itemcategorisation();
                itemcategorisation.setIsactive(true);
                itemcategorisation.setItemid(item);
                itemcategorisation.setUpdatedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));

                itemcategorisation.setItemcategoryid(new Itemcategory(Long.parseLong(request.getParameter("Itemcategoryid"))));
                genericClassService.saveOrUpdateRecordLoadObject(itemcategorisation);

                Item item1 = new Item();
                item1.setDateadded(new Date());
                item1.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                item1.setQty(1);
                item1.setIsactive(Boolean.TRUE);
                item1.setMedicalitemid(new Medicalitem(item.getMedicalitemid()));
                item1.setPackagesid(new Packages(Long.parseLong(String.valueOf(1))));
                genericClassService.saveOrUpdateRecordLoadObject(item1);

                response = item.getMedicalitemid().toString();
            }

        } else if ("subcategory".equals(request.getParameter("type"))) {
            Itemcategory itemcategory = new Itemcategory();
            itemcategory.setCategorydescription(request.getParameter("categorydesc"));
            itemcategory.setCategoryname(request.getParameter("categoryname"));
            itemcategory.setIsactive(true);

            itemcategory.setParentid(Long.parseLong(request.getParameter("Itemcategoryid")));
            itemcategory.setItemclassificationid(new Itemclassification(Long.parseLong(request.getParameter("classificationid"))));
            genericClassService.saveOrUpdateRecordLoadObject(itemcategory);
        }
        return response;
    }

    @RequestMapping(value = "/getsuppliesclassificationcategories.htm", method = RequestMethod.GET)
    public String getsuppliesclassificationcategories(Model model, HttpServletRequest request) {
        List<Map> categorysFound = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            String[] params2 = {"itemclassificationid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemclassificationid"))};
            String[] fields2 = {"itemcategoryid", "categoryname", "isactive", "categorydescription"};
            List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE r.parentid IS NULL AND itemclassificationid=:itemclassificationid", params2, paramsValues2);

            if (classificationcategories != null) {
                Map<String, Object> categorysRow;
                for (Object[] classificationcategory : classificationcategories) {
                    categorysRow = new HashMap<>();
                    categorysRow.put("itemcategoryid", classificationcategory[0]);
                    categorysRow.put("categoryname", classificationcategory[1]);
                    categorysRow.put("isactive", classificationcategory[2]);
                    categorysRow.put("categorydescription", classificationcategory[3]);
                    categorysFound.add(categorysRow);
                }
            }
            model.addAttribute("act", request.getParameter("act"));
        } else if ("c".equals(request.getParameter("act"))) {

            String[] params = {"itemcategoryid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields = {"itemcategorisationid", "itemid.medicalitemid"};
            String where = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> categoryitems = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields, where, params, paramsValues);
            if (categoryitems != null) {
                Map<String, Object> categorysRow;
                for (Object[] categoryitem : categoryitems) {
                    categorysRow = new HashMap<>();
                    String[] params2 = {"medicalitemid"};
                    Object[] paramsValues2 = {categoryitem[1]};
                    String[] fields2 = {"genericname", "itemstrength", "levelofuse", "specification", "itemadministeringtypeid", "itemusage", "isactive", "isspecial"};
                    List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
                    categorysRow.put("genericname", genericname.get(0)[0]);
                    categorysRow.put("specification", genericname.get(0)[3]);
                    categorysRow.put("itemusage", genericname.get(0)[5]);
                    categorysRow.put("itemid", categoryitem[1]);
                    categorysRow.put("isactive", genericname.get(0)[6]);
                    categorysRow.put("isspecial", genericname.get(0)[7]);
                    String[] params6 = {"facilitylevelid"};
                    Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
                    String[] fields6 = {"shortname"};
                    String where6 = "WHERE facilitylevelid=:facilitylevelid";
                    List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
                    if (levelofuse.get(0) != null) {
                        categorysRow.put("levelofuse", levelofuse.get(0));
                    } else {
                        categorysRow.put("levelofuse", "N/A");
                    }

                    String[] paramsl = {"medicalitemid", "isactive"};
                    Object[] paramsValuesl = {categoryitem[1], Boolean.TRUE};
                    String[] fieldsl = {"itemid", "qty"};
                    String wherel = "WHERE medicalitemid=:medicalitemid AND isactive=:isactive";
                    List<Object[]> itempackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fieldsl, wherel, paramsl, paramsValuesl);
                    if (itempackages != null) {
                        categorysRow.put("itempackages", itempackages.size());
                    } else {
                        categorysRow.put("itempackages", 0);
                    }
                    categorysFound.add(categorysRow);
                }
            }
            model.addAttribute("act", request.getParameter("act"));
            model.addAttribute("itemcategoryid", request.getParameter("itemcategoryid"));
        } else {
            model.addAttribute("type", request.getParameter("type"));
            model.addAttribute("act", request.getParameter("act"));
        }

        model.addAttribute("categorysFound", categorysFound);

        return "controlPanel/universalPanel/essentialmedicine/supplies/views/categoryOrItems";
    }

    @RequestMapping(value = "/addnewsuppliesitemform.htm", method = RequestMethod.GET)
    public String addnewsuppliesitemform(Model model, HttpServletRequest request) {
        List<Map> levelsFound = new ArrayList<>();
        String[] paramsl = {};
        Object[] paramsValuesl = {};
        String[] fieldsl = {"facilitylevelid", "shortname"};
        String wherel = "";
        List<Object[]> levels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fieldsl, wherel, paramsl, paramsValuesl);
        if (levels != null) {
            Map<String, Object> levelRow;
            for (Object[] level : levels) {
                levelRow = new HashMap<>();
                levelRow.put("facilitylevelid", level[0]);
                levelRow.put("shortname", level[1]);
                levelsFound.add(levelRow);
            }
        }
        model.addAttribute("levelsFound", levelsFound);
        model.addAttribute("classificationname", request.getParameter("classificationname"));
        model.addAttribute("categoryname", request.getParameter("categoryname"));
        return "controlPanel/universalPanel/essentialmedicine/supplies/forms/itemForm";
    }

    @RequestMapping(value = "/editsuppliesclassificationcategoryitem.htm", method = RequestMethod.GET)
    public String editsuppliesclassificationcategoryitem(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params2 = {"medicalitemid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemid"))};
        String[] fields2 = {"genericname", "itemstrength", "levelofuse", "specification", "itemadministeringtypeid", "itemusage", "isactive", "isspecial"};
        List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
        if (genericname != null) {
            model.addAttribute("name", genericname.get(0)[0]);
            model.addAttribute("specification", genericname.get(0)[3]);
            model.addAttribute("itemusage", genericname.get(0)[5]);
            model.addAttribute("isactive", genericname.get(0)[6]);
            model.addAttribute("isspecial", genericname.get(0)[7]);
            String[] params6 = {"facilitylevelid"};
            Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
            String[] fields6 = {"shortname"};
            String where6 = "WHERE facilitylevelid=:facilitylevelid";
            List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
            if (levelofuse.get(0) != null) {
                model.addAttribute("levelofuse", levelofuse.get(0));
                model.addAttribute("facilitylevelid", genericname.get(0)[2]);
            } else {
                model.addAttribute("levelofuse", "N/A");
            }
        }
        String[] params8 = {};
        Object[] paramsValues8 = {};
        String[] fields8 = {"shortname", "facilitylevelid"};
        String where8 = "";
        List<Object[]> levelofuse8 = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields8, where8, params8, paramsValues8);
        if (levelofuse8 != null) {
            Map<String, Object> categorysRow;
            for (Object[] level : levelofuse8) {
                categorysRow = new HashMap<>();
                categorysRow.put("shortname", level[0]);
                categorysRow.put("facilitylevelid", level[1]);
                itemsFound.add(categorysRow);
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        return "controlPanel/universalPanel/essentialmedicine/supplies/forms/itemEdit";
    }

    @RequestMapping(value = "/updatesuppliescategoryitem.htm")
    public @ResponseBody
    String updatesuppliescategoryitem(Model model, HttpServletRequest request) {
        String response = "";
        String[] columns = {"genericname", "itemusage", "levelofuse", "specification", "isspecial"};
        Object[] columnValues = {request.getParameter("itemname"), request.getParameter("useclass"), Integer.parseInt(request.getParameter("level")), request.getParameter("specification"), Boolean.valueOf(request.getParameter("isspecial"))};
        String pk = "medicalitemid";
        Object pkValue = Long.parseLong(request.getParameter("itemid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Medicalitem.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            response = "success";
        }

        return response;
    }

    @RequestMapping(value = "/getsuppliescategoriessubcategorylist.htm", method = RequestMethod.GET)
    public String getsuppliescategoriessubcategorylist(Model model, HttpServletRequest request) {
        List<Map> categorysFound = new ArrayList<>();
        List<Map> itemsFound = new ArrayList<>();
        String results_view = "";
        if ("f".equals(request.getParameter("act"))) {
            String[] params5 = {"parentid"};
            Object[] paramsValues5 = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields5 = {"itemcategoryid", "categoryname", "isactive", "categorydescription"};
            List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields5, "WHERE parentid=:parentid", params5, paramsValues5);
            if (classificationcategories != null) {
                Map<String, Object> categorysRow;
                for (Object[] itemcategory : classificationcategories) {
                    categorysRow = new HashMap<>();
                    categorysRow.put("itemcategoryid", itemcategory[0]);
                    categorysRow.put("categoryname", itemcategory[1]);
                    categorysRow.put("isactive", itemcategory[2]);
                    categorysRow.put("categorydescription", itemcategory[3]);
                    categorysFound.add(categorysRow);
                }
            }

            String[] params = {"itemcategoryid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields = {"itemcategorisationid", "itemid.medicalitemid"};
            String where = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> categoryitems = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields, where, params, paramsValues);
            if (categoryitems != null) {
                Map<String, Object> categoryitemsRow;
                for (Object[] categoryitem : categoryitems) {
                    categoryitemsRow = new HashMap<>();
                    String[] params2 = {"medicalitemid"};
                    Object[] paramsValues2 = {categoryitem[1]};
                    String[] fields2 = {"genericname", "itemstrength", "levelofuse", "specification", "itemadministeringtypeid", "itemusage", "isactive", "isspecial"};
                    List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
                    categoryitemsRow.put("genericname", genericname.get(0)[0]);
                    categoryitemsRow.put("specification", genericname.get(0)[3]);
                    categoryitemsRow.put("itemusage", genericname.get(0)[5]);
                    categoryitemsRow.put("itemid", categoryitem[1]);
                    categoryitemsRow.put("isactive", genericname.get(0)[6]);
                    categoryitemsRow.put("isspecial", genericname.get(0)[7]);
                    String[] params6 = {"facilitylevelid"};
                    Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
                    String[] fields6 = {"shortname"};
                    String where6 = "WHERE facilitylevelid=:facilitylevelid";
                    List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
                    if (levelofuse.get(0) != null) {
                        categoryitemsRow.put("levelofuse", levelofuse.get(0));
                    } else {
                        categoryitemsRow.put("levelofuse", "N/A");
                    }

                    String[] paramsl = {"medicalitemid", "isactive"};
                    Object[] paramsValuesl = {categoryitem[1], Boolean.TRUE};
                    String[] fieldsl = {"itemid", "qty"};
                    String wherel = "WHERE medicalitemid=:medicalitemid AND isactive=:isactive";
                    List<Object[]> itempackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fieldsl, wherel, paramsl, paramsValuesl);
                    if (itempackages != null) {
                        categoryitemsRow.put("itempackages", itempackages.size());
                    } else {
                        categoryitemsRow.put("itempackages", 0);
                    }
                    itemsFound.add(categoryitemsRow);
                }
            }
            model.addAttribute("itemsFound", itemsFound);
            results_view = "controlPanel/universalPanel/essentialmedicine/supplies/views/categoryAndItems";
        } else {
            String[] params2 = {"parentid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields2 = {"itemcategoryid", "categoryname", "isactive", "categorydescription"};
            List<Object[]> classificationcategories = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE parentid=:parentid", params2, paramsValues2);
            if (classificationcategories != null) {
                Map<String, Object> categorysRow;
                for (Object[] itemcategory : classificationcategories) {
                    categorysRow = new HashMap<>();
                    categorysRow.put("itemcategoryid", itemcategory[0]);
                    categorysRow.put("categoryname", itemcategory[1]);
                    categorysRow.put("isactive", itemcategory[2]);
                    categorysRow.put("categorydescription", itemcategory[3]);
                    categorysFound.add(categorysRow);
                }
            }
            results_view = "controlPanel/universalPanel/essentialmedicine/supplies/views/categoryOrItems";
        }

        model.addAttribute("categorysFound", categorysFound);
        model.addAttribute("act", request.getParameter("act"));
        model.addAttribute("type", request.getParameter("type"));
        model.addAttribute("itemcategoryid", request.getParameter("itemcategoryid"));
        return results_view;
    }

    @RequestMapping(value = "/newgroupclassification.htm")
    public @ResponseBody
    String newgroupclassification(Model model, HttpServletRequest request) {
        String response = "";
        Itemclassification itemclassification = new Itemclassification();
        itemclassification.setClassificationdescription(request.getParameter("moreinfo"));
        itemclassification.setIsmedicine(true);
        itemclassification.setHasparent(Boolean.FALSE);
        itemclassification.setIsactive(true);
        itemclassification.setIsdeleted(Boolean.FALSE);
        itemclassification.setClassificationname(request.getParameter("name").toUpperCase());
        genericClassService.saveOrUpdateRecordLoadObject(itemclassification);

        return response;
    }

    @RequestMapping(value = "/getgroupClassificationCategory.htm", method = RequestMethod.GET)
    public String getgroupClassificationCategory(Model model, HttpServletRequest request) {
        List<Map> classificationFound = new ArrayList<>();
        String[] params = {"isactive", "ismedicine", "parentid"};
        Object[] paramsValues = {Boolean.TRUE, Boolean.TRUE, Long.parseLong(request.getParameter("itemclassificationid"))};
        String[] fields = {"itemclassificationid", "classificationname", "isactive", "classificationdescription"};
        String where = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND parentid=:parentid ORDER BY r.classificationname ASC";
        List<Object[]> classsification = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (classsification != null) {
            Map<String, Object> categorysRow;
            for (Object[] classs : classsification) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemclassificationid", classs[0]);
                categorysRow.put("classificationname", classs[1]);
                categorysRow.put("isactive", classs[2]);
                categorysRow.put("classificationdescription", classs[3]);
                classificationFound.add(categorysRow);
            }
        }
        model.addAttribute("classificationFound", classificationFound);
        model.addAttribute("itemclassificationid", request.getParameter("itemclassificationid"));
        return "controlPanel/universalPanel/essentialmedicine/views/groupClassificationCategory";
    }

    @RequestMapping(value = "/addexistinggroupclassifications.htm", method = RequestMethod.GET)
    public String addexistinggroupclassifications(Model model, HttpServletRequest request) {
        List<Map> classificationsFound = new ArrayList<>();
        String[] params = {"isactive", "ismedicine", "hasparent"};
        Object[] paramsValues = {Boolean.TRUE, Boolean.TRUE, Boolean.TRUE};
        String[] fields = {"itemclassificationid", "classificationname"};
        String where = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND hasparent=:hasparent AND r.parentid IS NULL ORDER BY r.classificationname ASC";
        List<Object[]> classsification = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (classsification != null) {
            Map<String, Object> categorysRow;
            for (Object[] classs : classsification) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemclassificationid", classs[0]);
                categorysRow.put("classificationname", classs[1]);
                classificationsFound.add(categorysRow);
            }
        }
        model.addAttribute("classificationsFound", classificationsFound);
        return "controlPanel/universalPanel/essentialmedicine/forms/existingClassification";
    }

    @RequestMapping(value = "/addexistinggroupclassificationselected.htm")
    public @ResponseBody
    String addexistinggroupclassificationselected(Model model, HttpServletRequest request) {
        String response = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String item1 : item) {
                String[] columns = {"parentid"};
                Object[] columnValues = {Long.parseLong(request.getParameter("Itemclassificationid"))};
                String pk = "itemclassificationid";
                Object pkValue = Long.parseLong(item1);
                int result = genericClassService.updateRecordSQLSchemaStyle(Itemclassification.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    response = "success";
                }
            }
        } catch (IOException | NumberFormatException e) {

        }
        return response;
    }

    @RequestMapping(value = "/getexistingsuppliesclassification.htm", method = RequestMethod.GET)
    public String getexistingsuppliesclassification(Model model, HttpServletRequest request) {
        List<Map> classificationsFound = new ArrayList<>();
        String[] params5 = {"isactive", "ismedicine", "hasparent"};
        Object[] paramsValues5 = {Boolean.TRUE, Boolean.FALSE, Boolean.TRUE};
        String[] fields5 = {"itemclassificationid", "classificationname"};
        String where5 = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND hasparent=:hasparent ORDER BY r.classificationname ASC";
        List<Object[]> classsification5 = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields5, where5, params5, paramsValues5);
        if (classsification5 != null) {
            Map<String, Object> classificationRow;
            for (Object[] classs : classsification5) {
                classificationRow = new HashMap<>();
                classificationRow.put("itemclassificationid", classs[0]);
                classificationRow.put("classificationname", classs[1]);
                classificationsFound.add(classificationRow);
            }
        }
        model.addAttribute("classificationsFound", classificationsFound);
        return "controlPanel/universalPanel/essentialmedicine/supplies/forms/existingSuppliesClassification";
    }

    @RequestMapping(value = "/savesundriesgroupsclassifications.htm")
    public @ResponseBody
    String savesundriesgroupsclassifications(Model model, HttpServletRequest request) {
        String response = "";
        Itemclassification itemclassification = new Itemclassification();
        itemclassification.setClassificationname(request.getParameter("name"));
        itemclassification.setHasparent(Boolean.FALSE);
        itemclassification.setClassificationdescription(request.getParameter("moreinfo"));
        itemclassification.setIsactive(true);
        itemclassification.setIsmedicine(false);
        itemclassification.setIsdeleted(Boolean.FALSE);
        genericClassService.saveOrUpdateRecordLoadObject(itemclassification);
        return response;
    }

    @RequestMapping(value = "/getsuppliesgroupsclassificationcategories.htm", method = RequestMethod.GET)
    public String getsuppliesgroupsclassificationcategories(Model model, HttpServletRequest request) {
        List<Map> classificationFound = new ArrayList<>();
        String[] params = {"isactive", "ismedicine", "parentid"};
        Object[] paramsValues = {Boolean.TRUE, Boolean.FALSE, Long.parseLong(request.getParameter("itemclassificationid"))};
        String[] fields = {"itemclassificationid", "classificationname", "isactive", "classificationdescription"};
        String where = "WHERE isactive=:isactive AND ismedicine=:ismedicine AND parentid=:parentid ORDER BY r.classificationname ASC";
        List<Object[]> classsification = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (classsification != null) {
            Map<String, Object> categorysRow;
            for (Object[] classs : classsification) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemclassificationid", classs[0]);
                categorysRow.put("classificationname", classs[1]);
                categorysRow.put("isactive", classs[2]);
                categorysRow.put("classificationdescription", classs[3]);
                classificationFound.add(categorysRow);
            }
        }
        model.addAttribute("classificationFound", classificationFound);
        model.addAttribute("itemclassificationid", request.getParameter("itemclassificationid"));
        return "controlPanel/universalPanel/essentialmedicine/supplies/views/groupClassificationCategory";
    }

    @RequestMapping(value = "/itempackages.htm", method = RequestMethod.GET)
    public String itempackages(Model model, HttpServletRequest request) {
        List<Map> itemPackagesFound = new ArrayList<>();
        String[] params = {"medicalitemid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("itemid"))};
        String[] fields = {"itemid", "packagesid", "qty", "isactive"};
        String where = "WHERE medicalitemid=:medicalitemid";
        List<Object[]> itemspackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields, where, params, paramsValues);
        if (itemspackages != null) {
            Map<String, Object> packagesRow;
            for (Object[] itemspackage : itemspackages) {
                packagesRow = new HashMap<>();

                String[] params5 = {"packagesid"};
                Object[] paramsValues5 = {itemspackage[1]};
                String[] fields5 = {"packagename"};
                String where5 = "WHERE packagesid=:packagesid";
                List<String> packagename = (List<String>) genericClassService.fetchRecord(Packages.class, fields5, where5, params5, paramsValues5);
                if (packagename != null) {
                    packagesRow.put("itemid", itemspackage[0]);
                    packagesRow.put("qty", itemspackage[2]);
                    packagesRow.put("isactive", itemspackage[3]);
                    packagesRow.put("packagename", packagename.get(0));
                    itemPackagesFound.add(packagesRow);
                }
            }
        }
        model.addAttribute("itemPackagesFound", itemPackagesFound);
        model.addAttribute("itemid", request.getParameter("itemid"));
        model.addAttribute("size", itemPackagesFound.size());
        return "controlPanel/universalPanel/essentialmedicine/views/itemPackages";
    }

    @RequestMapping(value = "/addnewItemPackSizie.htm", method = RequestMethod.GET)
    public String addnewItemPackSizie(Model model, HttpServletRequest request) {
        List<Map> PackagesFound = new ArrayList<>();

        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"packagesid", "packagename"};
        String where = "";
        List<Object[]> packages = (List<Object[]>) genericClassService.fetchRecord(Packages.class, fields, where, params, paramsValues);
        if (packages != null) {
            Map<String, Object> packagesRow;
            for (Object[] packagez : packages) {
                packagesRow = new HashMap<>();
                if (((Long) packagez[0]).intValue() != 1) {
                    packagesRow.put("packagesid", packagez[0]);
                    packagesRow.put("packagename", packagez[1]);
                    PackagesFound.add(packagesRow);
                }
            }
        }
        model.addAttribute("PackagesFound", PackagesFound);
        return "controlPanel/universalPanel/essentialmedicine/forms/addNewItemPack";
    }

    @RequestMapping(value = "/saveitempackagesizes.htm")
    public @ResponseBody
    String saveitempackagesizes(Model model, HttpServletRequest request) {
        String response = "";
        Item itempackages = new Item();
        itempackages.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
        itempackages.setDateadded(new Date());
        itempackages.setIsactive(Boolean.TRUE);
        itempackages.setMedicalitemid(new Medicalitem(Long.parseLong(request.getParameter("itemid"))));
        itempackages.setPackagesid(new Packages(Long.parseLong(request.getParameter("ItemPack"))));
        itempackages.setQty(Integer.parseInt(request.getParameter("itempacksizes")));
        Object save = genericClassService.saveOrUpdateRecordLoadObject(itempackages);
        return response;
    }

    @RequestMapping(value = "/itemsundriespackages.htm", method = RequestMethod.GET)
    public String itemsundriespackages(Model model, HttpServletRequest request) {
        List<Map> itemPackagesFound = new ArrayList<>();
        String[] params = {"medicalitemid", "isactive"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("itemid")), Boolean.TRUE};
        String[] fields = {"itemid", "packagesid", "qty"};
        String where = "WHERE medicalitemid=:medicalitemid AND isactive=:isactive";
        List<Object[]> itemspackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields, where, params, paramsValues);
        if (itemspackages != null) {
            Map<String, Object> packagesRow;
            for (Object[] itemspackage : itemspackages) {
                packagesRow = new HashMap<>();

                String[] params5 = {"packagesid"};
                Object[] paramsValues5 = {itemspackage[1]};
                String[] fields5 = {"packagename"};
                String where5 = "WHERE packagesid=:packagesid";
                List<Object[]> packagename = (List<Object[]>) genericClassService.fetchRecord(Packages.class, fields5, where5, params5, paramsValues5);
                if (packagename != null) {
                    packagesRow.put("itempackagesid", itemspackage[0]);
                    packagesRow.put("qty", itemspackage[2]);
                    packagesRow.put("isactive", true);
                    packagesRow.put("packagename", packagename.get(0));
                    itemPackagesFound.add(packagesRow);
                }
            }
        }
        model.addAttribute("itemPackagesFound", itemPackagesFound);
        model.addAttribute("itemid", request.getParameter("itemid"));
        return "controlPanel/universalPanel/essentialmedicine/supplies/views/itemPackages";
    }

    @RequestMapping(value = "/searchsundriesitem.htm", method = RequestMethod.GET)
    public String searchsundriesitem(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"value", "name", "isactive", "issupplies", "itemisdeleted"};
        Object[] paramsValues = {request.getParameter("name").trim().toLowerCase() + "%", "%" + request.getParameter("name").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.TRUE, Boolean.FALSE};
        String[] fields = {"itemid", "fullname", "categoryname", "itemclassificationid", "classificationname", "itemcategoryid"};
        String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND itemisdeleted=:itemisdeleted AND (LOWER(fullname) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY fullname";
        List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
        if (itemsList != null) {
            Map<String, Object> itemRow;
            for (Object[] item : itemsList) {
                itemRow = new HashMap<>();
                itemRow.put("itemid", item[0]);
                itemRow.put("genericname", item[1]);
                itemRow.put("categoryname", item[2]);
                itemRow.put("itemclassificationid", item[3]);
                itemRow.put("classificationname", item[4]);
                itemRow.put("itemcategoryid", item[5]);
                itemsFound.add(itemRow);
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("name", request.getParameter("name"));
        return "controlPanel/universalPanel/essentialmedicine/supplies/views/searchResults";
    }

    @RequestMapping(value = "/getitemsundriestreeclassification.htm", method = RequestMethod.GET)
    public String getitemsundriestreeclassification(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String result_view = "";
        if ("a".equals(request.getParameter("act"))) {
            Set<Long> assigned = new HashSet<>();

            String[] params = {"itemcategoryid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("itemcategoryid"))};
            String[] fields = {"parentid","isactive"};
            String where = "WHERE itemcategoryid=:itemcategoryid";
            List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields, where, params, paramsValues);
            assigned.add(Long.parseLong(request.getParameter("itemcategoryid")));
            if (itemsList.get(0)[0] != null) {
                assigned.add((Long)itemsList.get(0)[0]);
                Set<Long> assign = getParentCategory((Long)itemsList.get(0)[0]);
                for (Long set : assign) {
                    assigned.add(set);
                }
            }
            Map<String, Object> categorysRow;
            if (!assigned.isEmpty()) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemclassificationid", request.getParameter("itemclassificationid"));
                categorysRow.put("classificationname", request.getParameter("classificationname"));

                String[] params2 = {"itemclassificationid"};
                Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemclassificationid"))};
                String[] fields2 = {"itemcategoryid", "categoryname"};
                String where2 = "WHERE r.itemclassificationid.itemclassificationid=:itemclassificationid AND r.parentid IS NULL";
                List<Object[]> itemsList2 = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, where2, params2, paramsValues2);
                List<Map> subCategoryFound = new ArrayList<>();
                if (itemsList2 != null) {
                    Map<String, Object> subcategoryRow;
                    for (Object[] itemcategoryid : itemsList2) {
                        subcategoryRow = new HashMap<>();
                        if (assigned.contains((Long) itemcategoryid[0])) {
                            subcategoryRow.put("itemcategoryid", itemcategoryid[0]);
                            subcategoryRow.put("categoryname", itemcategoryid[1]);

                            subcategoryRow.put("SubCategory", generateSubCategory((Long) itemcategoryid[0], assigned));
                            subcategoryRow.put("size", generateSubCategory((Long) itemcategoryid[0], assigned).size());

                            subCategoryFound.add(subcategoryRow);
                        }

                    }
                }
                categorysRow.put("SubCategory", subCategoryFound);
                itemsFound.add(categorysRow);
            }
            model.addAttribute("classificationname", request.getParameter("classificationname"));
            model.addAttribute("itemsFound", itemsFound);
            try {
                model.addAttribute("itemsFoundList", new ObjectMapper().writeValueAsString(itemsFound));
            } catch (JsonProcessingException e) {
            }
            result_view = "controlPanel/universalPanel/essentialmedicine/supplies/views/itemStructure";
        } else if ("b".equals(request.getParameter("act"))) {
            Map<String, Object> categorysRow;
            String[] params2 = {"medicalitemid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("itemid"))};
            String[] fields2 = {"genericname", "itemstrength", "levelofuse", "isspecial", "itemadministeringtypeid", "itemusage", "specification", "isactive"};
            List<Object[]> genericname = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
            if (genericname != null) {
                categorysRow = new HashMap<>();
                model.addAttribute("name", genericname.get(0)[0]);
                categorysRow.put("itemstrength", genericname.get(0)[1]);
                categorysRow.put("isspecial", genericname.get(0)[3]);
                categorysRow.put("itemusage", genericname.get(0)[5]);
                categorysRow.put("isactive", genericname.get(0)[7]);
                categorysRow.put("specification", genericname.get(0)[6]);

                String[] params6 = {"facilitylevelid"};
                Object[] paramsValues6 = {(Integer) genericname.get(0)[2]};
                String[] fields6 = {"shortname"};
                String where6 = "WHERE facilitylevelid=:facilitylevelid";
                List<String> levelofuse = (List<String>) genericClassService.fetchRecord(Facilitylevel.class, fields6, where6, params6, paramsValues6);
                if (levelofuse.get(0) != null) {
                    categorysRow.put("levelofuse", levelofuse.get(0));
                } else {
                    categorysRow.put("levelofuse", "N/A");
                }
                String[] paramsl = {"medicalitemid", "isactive"};
                Object[] paramsValuesl = {Long.parseLong(request.getParameter("itemid")), Boolean.TRUE};
                String[] fieldsl = {"itemid", "qty"};
                String wherel = "WHERE medicalitemid=:medicalitemid AND isactive=:isactive";
                List<Object[]> itempackages = (List<Object[]>) genericClassService.fetchRecord(Item.class, fieldsl, wherel, paramsl, paramsValuesl);
                if (itempackages != null) {
                    categorysRow.put("itempackages", itempackages.size());
                } else {
                    categorysRow.put("itempackages", 0);
                }
                itemsFound.add(categorysRow);
            }
            result_view = "controlPanel/universalPanel/essentialmedicine/supplies/views/itemDetails";
        }
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("itemid", request.getParameter("itemid"));
        return result_view;
    }

    @RequestMapping(value = "/deletedessentiallistmedicines.htm", method = RequestMethod.GET)
    public String deletedessentiallistmedicines(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params = {"itemisdeleted"};
        Object[] paramsValues = {Boolean.TRUE};
        String[] fields = {"itemid", "fullname"};
        String where = "WHERE itemisdeleted=:itemisdeleted ORDER BY fullname";
        List<Object[]> itemsLists = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
        if (itemsLists != null) {
            Map<String, Object> itemsRow;
            for (Object[] itemsList : itemsLists) {
                itemsRow = new HashMap<>();
                itemsRow.put("itemid", itemsList[0]);
                itemsRow.put("fullname", itemsList[1]);

                itemsFound.add(itemsRow);
//                String[] params1 = {"itemid"};
//                Object[] paramsValues1 = {itemsList[0]};
//                String[] fields1 = {"itemid", "packagename"};
//                String where1 = "WHERE itemid=:itemid ORDER BY packagename";
//                List<Object[]> itemsLists1 = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, where1, params1, paramsValues1);
//                if (itemsLists1 != null) {
//                   
//                }
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        return "controlPanel/universalPanel/essentialmedicine/deleted/deletedItemsHome";
    }

    @RequestMapping(value = "/addnewdeleteditems.htm", method = RequestMethod.GET)
    public String addnewdeleteditems(Model model, HttpServletRequest request) {
        String[] params = {"isdeleted"};
        Object[] paramsValues = {Boolean.TRUE};
        String[] fields = {"itemclassificationid", "classificationdescription"};
        String where = "WHERE isdeleted=:isdeleted";
        List<Object[]> deleteditemsLists = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (deleteditemsLists != null) {
            String[] params2 = {"itemclassificationid"};
            Object[] paramsValues2 = {deleteditemsLists.get(0)[0]};
            String[] fields2 = {"itemcategoryid", "categoryname"};
            List<Object[]> deleteditemscat = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE itemclassificationid=:itemclassificationid", params2, paramsValues2);
            if (deleteditemscat != null) {
                model.addAttribute("itemcategoryid", deleteditemscat.get(0)[0]);
            } else {
                Itemcategory itemcategory = new Itemcategory();
                itemcategory.setCategorydescription("Deleted Essential Medicines");
                itemcategory.setCategoryname("Un Allocated");
                itemcategory.setIsactive(false);
                itemcategory.setItemclassificationid(new Itemclassification((Long) deleteditemsLists.get(0)[0]));
                Object save2 = genericClassService.saveOrUpdateRecordLoadObject(itemcategory);
                if (save2 != null) {
                    model.addAttribute("itemcategoryid", itemcategory.getItemcategoryid());
                }
            }
        } else {
            Itemclassification itemclassification = new Itemclassification();
            itemclassification.setIsdeleted(Boolean.TRUE);
            itemclassification.setClassificationdescription("Essential medicines list deleted Items");
            itemclassification.setIsactive(false);
            itemclassification.setHasparent(Boolean.FALSE);
            itemclassification.setIsmedicine(true);
            itemclassification.setClassificationname("Un Allocated");
            Object save = genericClassService.saveOrUpdateRecordLoadObject(itemclassification);
            if (save != null) {
                Itemcategory itemcategory = new Itemcategory();
                itemcategory.setCategorydescription("Deleted Essential Medicines");
                itemcategory.setCategoryname("Un Allocated");
                itemcategory.setIsactive(false);
                itemcategory.setItemclassificationid(itemclassification);
                Object save2 = genericClassService.saveOrUpdateRecordLoadObject(itemcategory);
                if (save2 != null) {
                    model.addAttribute("itemcategoryid", itemcategory.getItemcategoryid());
                }
            }
        }
        return "controlPanel/universalPanel/essentialmedicine/deleted/forms/addItems";
    }

    @RequestMapping(value = "/savenewessentialistdeleteditems.htm")
    public @ResponseBody
    String savenewessentialistdeleteditems(Model model, HttpServletRequest request) {
        String response = "";
        Medicalitem item = new Medicalitem();
        item.setGenericname(request.getParameter("name"));
        item.setIsactive(Boolean.TRUE);
        item.setIsspecial(Boolean.FALSE);
        item.setIsdeleted(Boolean.TRUE);
        item.setItemform(request.getParameter("itemform"));
        item.setItemstrength(request.getParameter("strength"));
        item.setRestricted(true);
        item.setPacksize(0);
        item.setItemadministeringtypeid(new Itemadministeringtype(1));
        item.setItemformid(new Itemform(19));
        item.setIssupplies(Boolean.FALSE);
        item.setItemsource("ems");

        Object save = genericClassService.saveOrUpdateRecordLoadObject(item);
        if (save != null) {
            Itemcategorisation itemcategorisation = new Itemcategorisation();
            itemcategorisation.setIsactive(true);
            itemcategorisation.setItemid(new Medicalitem(item.getMedicalitemid()));
            itemcategorisation.setItemcategoryid(new Itemcategory(Long.parseLong(request.getParameter("itemcategoryid"))));
            itemcategorisation.setUpdatedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            itemcategorisation.setUpdatetime(new Date());
            Object saved = genericClassService.saveOrUpdateRecordLoadObject(itemcategorisation);

            Item item1 = new Item();
            item1.setDateadded(new Date());
            item1.setAddedby((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
            item1.setQty(1);
            item1.setIsactive(Boolean.TRUE);
            item1.setMedicalitemid(new Medicalitem(item.getMedicalitemid()));
            item1.setPackagesid(new Packages(Long.parseLong(String.valueOf(1))));
            genericClassService.saveOrUpdateRecordLoadObject(item1);
        }
        response = String.valueOf(item.getMedicalitemid());
        return response;
    }

    @RequestMapping(value = "/checkforexistingdeleteditem.htm")
    public @ResponseBody
    String checkforexistingdeleteditem(Model model, HttpServletRequest request) {
        String response = "not";
        String[] params = {"value"};
        Object[] paramsValues = {request.getParameter("item").trim().toLowerCase()};
        String[] fields = {"medicalitemid", "genericname"};
        String where = "WHERE genericname=:value";
        List<Object[]> itemsList = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields, where, params, paramsValues);
        if (itemsList != null) {
            response = "existing";
        }
        return response;
    }

    @RequestMapping(value = "/deletedEssentialDeletedMedicinesListItems.htm")
    public @ResponseBody
    String deletedEssentialDeletedMedicinesListItems(Model model, HttpServletRequest request) {
        String results = "";

        String[] params = {"itemid"};
        Object[] paramsValues = {new Medicalitem(Long.parseLong(request.getParameter("itemid")))};
        String[] fields = {"itemcategorisationid"};
        String where = "WHERE itemid=:itemid";
        List<Long> itemcategorisationid = (List<Long>) genericClassService.fetchRecord(Itemcategorisation.class, fields, where, params, paramsValues);
        if (itemcategorisationid != null) {
            String[] columns = {"itemcategorisationid"};
            Object[] columnValues = {itemcategorisationid.get(0)};
            int result = genericClassService.deleteRecordByByColumns("store.itemcategorisation", columns, columnValues);
            if (result != 0) {
                String[] columns2 = {"medicalitemid"};
                Object[] columnValues2 = {Long.parseLong(request.getParameter("itemid"))};
                int result2 = genericClassService.deleteRecordByByColumns("store.medicalitem", columns2, columnValues2);
                if (result2 != 0) {
                    results = "deleted";
                }
            }
        }

        return results;
    }

    @RequestMapping(value = "/activateDeletedEssentialItems.htm")
    public @ResponseBody
    String activateDeletedEssentialItems(Model model, HttpServletRequest request) {
        String results = "";
        String[] columns = {"isdeleted"};
        Object[] columnValues = {Boolean.FALSE};
        String pk = "medicalitemid";
        Object pkValue = Long.parseLong(request.getParameter("itemid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Medicalitem.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/updateClassificationDetails.htm")
    public @ResponseBody
    String updateClassificationDetails(Model model, HttpServletRequest request) {
        String results = "";
        String[] columns = {"classificationname"};
        Object[] columnValues = {request.getParameter("name")};
        String pk = "itemclassificationid";
        Object pkValue = Long.parseLong(request.getParameter("classissificationid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Itemclassification.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/deleteClassification.htm")
    public @ResponseBody
    String deleteClassification(Model model, HttpServletRequest request) {
        String results = "";

        String[] params = {"parentid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("classissificationid"))};
        String[] fields = {"itemclassificationid"};
        String where = "WHERE parentid=:parentid";
        List<Long> itemcategorisationid = (List<Long>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (itemcategorisationid != null) {
            results = String.valueOf(itemcategorisationid.size());
        } else {
            String[] columns = {"itemclassificationid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("classissificationid"))};
            int result = genericClassService.deleteRecordByByColumns("store.itemclassification", columns, columnValues);
            if (result != 0) {
                results = "deleted";
            }
        }

        return results;
    }

    @RequestMapping(value = "/transferclassificationcategories.htm", method = RequestMethod.GET)
    public String transferclassificationcategories(Model model, HttpServletRequest request) {
        List<Map> categorysFound = new ArrayList<>();
        String[] params = {"parentid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("classissificationid"))};
        String[] fields = {"itemclassificationid", "classificationname"};
        String where = "WHERE parentid=:parentid";
        List<Object[]> itemcategorisations = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (itemcategorisations != null) {
            Map<String, Object> categorysRow;
            for (Object[] itemcategorisation : itemcategorisations) {
                categorysRow = new HashMap<>();
                categorysRow.put("itemclassificationid", itemcategorisation[0]);
                categorysRow.put("classificationname", itemcategorisation[1]);
                categorysFound.add(categorysRow);
            }
        }
        List<Map> categoryFound = new ArrayList<>();
        String[] params2 = {};
        Object[] paramsValues2 = {};
        String[] fields2 = {"itemclassificationid", "classificationname"};
        List<Object[]> classifications = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields2, "WHERE parentid IS NULL AND isdeleted=FALSE AND hasparent=FALSE AND ismedicine=TRUE", params2, paramsValues2);
        if (classifications != null) {
            Map<String, Object> categorysRow;
            for (Object[] classification : classifications) {
                categorysRow = new HashMap<>();
                if (Long.parseLong(request.getParameter("classissificationid")) != (Long) classification[0]) {
                    categorysRow.put("itemclassificationid", classification[0]);
                    categorysRow.put("classificationname", classification[1]);
                    categoryFound.add(categorysRow);
                }
            }
        }
        model.addAttribute("categorysFound", categorysFound);
        model.addAttribute("categoryFound", categoryFound);
        return "controlPanel/universalPanel/essentialmedicine/forms/transferCategories";
    }

    @RequestMapping(value = "/disableitempackagings.htm")
    public @ResponseBody
    String disableitempackagings(Model model, HttpServletRequest request) {
        String results = "";
        if ("disable".equals(request.getParameter("type"))) {
            String[] columns = {"isactive"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "itemid";
            Object pkValue = Long.parseLong(request.getParameter("itemid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Item.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] columns = {"isactive"};
            Object[] columnValues = {Boolean.TRUE};
            String pk = "itemid";
            Object pkValue = Long.parseLong(request.getParameter("itemid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Item.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }

        return results;
    }

    @RequestMapping(value = "/getitemsdescriptionspacks.htm", method = RequestMethod.GET)
    public String getitemsdescriptionspacks(Model model, HttpServletRequest request) {
        List<Map> packsFound = new ArrayList<>();
        String[] params2 = {};
        Object[] paramsValues2 = {};
        String[] fields2 = {"packagesid", "packagename"};
        List<Object[]> itmpackages = (List<Object[]>) genericClassService.fetchRecord(Packages.class, fields2, "", params2, paramsValues2);
        if (itmpackages != null) {
            Map<String, Object> packsRow;
            for (Object[] itmpackage : itmpackages) {
                packsRow = new HashMap<>();
                if (((Long) itmpackage[0]).intValue() != 1) {
                    packsRow.put("packagesid", itmpackage[0]);
                    packsRow.put("packagename", itmpackage[1]);
                    packsFound.add(packsRow);
                }
            }
        }
        model.addAttribute("packsFound", packsFound);
        return "controlPanel/universalPanel/essentialmedicine/itemPacks";
    }

    @RequestMapping(value = "/updateitemdescriptions.htm")
    public @ResponseBody
    String updateitemdescriptions(Model model, HttpServletRequest request) {
        String results = "";
        if ("update".equals(request.getParameter("type"))) {
            String[] columns = {"packagename"};
            Object[] columnValues = {request.getParameter("name")};
            String pk = "packagesid";
            Object pkValue = Long.parseLong(request.getParameter("packagesid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Packages.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] params2 = {"packagesid"};
            Object[] paramsValues2 = {BigInteger.valueOf(Long.parseLong(request.getParameter("packagesid")))};
            String[] fields2 = {"itempackageid", "itemid"};
            List<Object[]> itemspacks = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields2, "WHERE packagesid=:packagesid", params2, paramsValues2);
            if (itemspacks != null) {
                results = "comps";
            } else {
                String[] columns = {"packagesid"};
                Object[] columnValues = {Long.parseLong(request.getParameter("packagesid"))};
                int result = genericClassService.deleteRecordByByColumns("store.packages", columns, columnValues);
                if (result != 0) {
                    results = "deleted";
                }
            }
        }

        return results;
    }

    @RequestMapping(value = "/addnewitemdescrips.htm", method = RequestMethod.GET)
    public String addNewPacks(Model model, HttpServletRequest request) {

        return "controlPanel/universalPanel/essentialmedicine/addNewPacks";
    }

    @RequestMapping(value = "/savenewitemdescriptions.htm")
    public @ResponseBody
    String savenewitemdescriptions(Model model, HttpServletRequest request) {
        String results = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (String item1 : item) {
                Packages packages = new Packages();
                packages.setDateadded(new Date());
                packages.setPackagename(item1);
                packages.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
                genericClassService.saveOrUpdateRecordLoadObject(packages);
            }
        } catch (Exception e) {
        }

        return results;
    }

    @RequestMapping(value = "/deleteSectionSundriesClassifications.htm")
    public @ResponseBody
    String deleteSectionSundriesClassifications(Model model, HttpServletRequest request) {
        String results = "";

        String[] params2 = {"itemclassificationid"};
        Object[] paramsValues2 = {new Itemclassification(Long.parseLong(request.getParameter("itemclassificationid")))};
        String[] fields2 = {"itemcategoryid", "categoryname"};
        List<Object[]> itemscategorys = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields2, "WHERE itemclassificationid=:itemclassificationid", params2, paramsValues2);
        if (itemscategorys != null) {
            results = "comps";
        } else {
            String[] columns = {"itemclassificationid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("itemclassificationid"))};
            int result = genericClassService.deleteRecordByByColumns("store.itemclassification", columns, columnValues);
            if (result != 0) {
                results = "deleted";
            }
        }
        return results;
    }

    @RequestMapping(value = "/updateClassificationsundriesDetails.htm")
    public @ResponseBody
    String updateClassificationsundriesDetails(Model model, HttpServletRequest request) {
        String results = "";
        String[] columns = {"classificationname", "classificationdescription"};
        Object[] columnValues = {request.getParameter("name").toUpperCase(), request.getParameter("descname")};
        String pk = "itemclassificationid";
        Object pkValue = Long.parseLong(request.getParameter("itemclassificationid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Itemclassification.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/deleteSuppliesgroupClassification.htm")
    public @ResponseBody
    String deleteSuppliesgroupClassification(Model model, HttpServletRequest request) {
        String results = "";

        String[] params2 = {"parentid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("classificationid"))};
        String[] fields2 = {"itemcategoryid", "categoryname"};
        List<Object[]> itemscategorys = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields2, "WHERE parentid=:parentid", params2, paramsValues2);
        if (itemscategorys != null) {
            results = "comps";
        } else {
            String[] columns = {"itemclassificationid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("classificationid"))};
            int result = genericClassService.deleteRecordByByColumns("store.itemclassification", columns, columnValues);
            if (result != 0) {
                results = "deleted";
            }
        }
        return results;
    }

    @RequestMapping(value = "/updateSuppliesClassificationDetails.htm")
    public @ResponseBody
    String updateSuppliesClassificationDetails(Model model, HttpServletRequest request) {
        String results = "";
        String[] columns = {"classificationname"};
        Object[] columnValues = {request.getParameter("name").toUpperCase()};
        String pk = "itemclassificationid";
        Object pkValue = Long.parseLong(request.getParameter("classificationid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Itemclassification.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/addnewItemStrength.htm", method = RequestMethod.GET)
    public String addnewItemStrength(Model model, HttpServletRequest request) {
        String results_view = "";
        String[] params2 = {"medicalitemid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("medicalitemid"))};
        String[] fields2 = {"genericname", "itemform", "issupplies", "specification"};
        List<Object[]> itemsStrengths = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
        if (itemsStrengths != null) {
            model.addAttribute("genericname", itemsStrengths.get(0)[0]);
            if ((Boolean) itemsStrengths.get(0)[2]) {

                model.addAttribute("issupplies", "yes");
                model.addAttribute("specification", itemsStrengths.get(0)[3]);
                results_view = "controlPanel/universalPanel/essentialmedicine/addItemSuppliesSpecification";
            } else {

                model.addAttribute("issupplies", "no");
                model.addAttribute("itemform", itemsStrengths.get(0)[1]);
                results_view = "controlPanel/universalPanel/essentialmedicine/addItemStrength";
            }
        }
        model.addAttribute("medicalitemid", request.getParameter("medicalitemid"));
        return results_view;
    }

    @RequestMapping(value = "/saveaddnewItemStrength.htm")
    public @ResponseBody
    String saveaddnewItemStrength(Model model, HttpServletRequest request) {
        String results = "";
        try {
            String[] params2 = {"medicalitemid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("medicalitemid"))};
            String[] fields2 = {"isspecial", "levelofuse", "issupplies", "itemusage", "isdeleted", "isactive"};
            List<Object[]> itemsStrengths = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
            if (itemsStrengths != null) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Medicalitem medicalitem = new Medicalitem();
                    medicalitem.setGenericname((String) map.get("itemname"));
                    medicalitem.setIsactive((Boolean) itemsStrengths.get(0)[5]);
                    medicalitem.setIsspecial((Boolean) itemsStrengths.get(0)[0]);
                    medicalitem.setIsdeleted((Boolean) itemsStrengths.get(0)[4]);
                    medicalitem.setIssupplies((Boolean) itemsStrengths.get(0)[2]);
                    medicalitem.setItemform((String) map.get("itemform"));
                    medicalitem.setItemsource("added");
                    medicalitem.setItemstrength((String) map.get("itemstregth"));
                    medicalitem.setLevelofuse((Integer) itemsStrengths.get(0)[1]);
                    medicalitem.setRestricted(false);
                    medicalitem.setPacksize(0);
                    medicalitem.setItemformid(new Itemform(19));
                    medicalitem.setItemadministeringtypeid(new Itemadministeringtype(1));
                    medicalitem.setItemusage((String) itemsStrengths.get(0)[3]);

                    Object save = genericClassService.saveOrUpdateRecordLoadObject(medicalitem);
                    if (save != null) {
                        String[] params = {"itemid"};
                        Object[] paramsValues = {Long.parseLong(request.getParameter("medicalitemid"))};
                        String[] fields = {"itemcategoryid.itemcategoryid", "isactive"};
                        List<Object[]> itemscategorys = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields, "WHERE itemid=:itemid", params, paramsValues);
                        if (itemscategorys != null) {
                            Itemcategorisation itemcategorisation = new Itemcategorisation();
                            itemcategorisation.setIsactive((Boolean) itemscategorys.get(0)[1]);
                            itemcategorisation.setItemid(new Medicalitem(medicalitem.getMedicalitemid()));
                            itemcategorisation.setItemcategoryid(new Itemcategory((Long) itemscategorys.get(0)[0]));
                            genericClassService.saveOrUpdateRecordLoadObject(itemcategorisation);

                            Item item2 = new Item();
                            item2.setDateadded(new Date());
                            item2.setIsactive(Boolean.TRUE);
                            item2.setMeasure("Tablet");
                            item2.setPackagesid(new Packages(Long.parseLong("1")));
                            item2.setMedicalitemid(medicalitem);
                            item2.setQty(1);
                            genericClassService.saveOrUpdateRecordLoadObject(item2);
                        }
                    }
                }
            }

        } catch (Exception e) {
        }
        return results;
    }

    @RequestMapping(value = "/saveaddnewItemSpecification.htm")
    public @ResponseBody
    String saveaddnewItemSpecification(Model model, HttpServletRequest request) {
        String results = "";
        try {
            String[] params2 = {"medicalitemid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("medicalitemid"))};
            String[] fields2 = {"isspecial", "levelofuse", "issupplies", "itemusage", "isdeleted", "isactive"};
            List<Object[]> itemsStrengths = (List<Object[]>) genericClassService.fetchRecord(Medicalitem.class, fields2, "WHERE medicalitemid=:medicalitemid", params2, paramsValues2);
            if (itemsStrengths != null) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Medicalitem medicalitem = new Medicalitem();
                    medicalitem.setGenericname((String) map.get("itemname"));
                    medicalitem.setIsactive((Boolean) itemsStrengths.get(0)[5]);
                    medicalitem.setIsspecial((Boolean) itemsStrengths.get(0)[0]);
                    medicalitem.setIsdeleted((Boolean) itemsStrengths.get(0)[4]);
                    medicalitem.setIssupplies((Boolean) itemsStrengths.get(0)[2]);
                    medicalitem.setItemsource("added");
                    medicalitem.setSpecification((String) map.get("itemspecification"));
                    medicalitem.setLevelofuse((Integer) itemsStrengths.get(0)[1]);
                    medicalitem.setRestricted(false);
                    medicalitem.setPacksize(0);
                    medicalitem.setItemformid(new Itemform(19));
                    medicalitem.setItemadministeringtypeid(new Itemadministeringtype(1));
                    medicalitem.setItemusage((String) itemsStrengths.get(0)[3]);

                    Object save = genericClassService.saveOrUpdateRecordLoadObject(medicalitem);
                    if (save != null) {
                        String[] params = {"itemid"};
                        Object[] paramsValues = {Long.parseLong(request.getParameter("medicalitemid"))};
                        String[] fields = {"itemcategoryid.itemcategoryid", "isactive"};
                        List<Object[]> itemscategorys = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, fields, "WHERE itemid=:itemid", params, paramsValues);
                        if (itemscategorys != null) {
                            Itemcategorisation itemcategorisation = new Itemcategorisation();
                            itemcategorisation.setIsactive((Boolean) itemscategorys.get(0)[1]);
                            itemcategorisation.setItemid(new Medicalitem(medicalitem.getMedicalitemid()));
                            itemcategorisation.setItemcategoryid(new Itemcategory((Long) itemscategorys.get(0)[0]));
                            genericClassService.saveOrUpdateRecordLoadObject(itemcategorisation);

                            Item item2 = new Item();
                            item2.setDateadded(new Date());
                            item2.setIsactive(Boolean.TRUE);
                            item2.setMeasure("Metre");
                            item2.setPackagesid(new Packages(Long.parseLong("1")));
                            item2.setMedicalitemid(medicalitem);
                            item2.setQty(1);
                            genericClassService.saveOrUpdateRecordLoadObject(item2);
                        }
                    }
                }
            }

        } catch (Exception e) {
        }
        return results;
    }
}
