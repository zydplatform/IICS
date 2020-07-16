/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.filemanager;

import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.filemanger.ViewFileLocation;
import com.iics.service.GenericClassService;
import com.iics.store.Bayrow;
import com.iics.store.Bayrowcell;
import com.iics.store.Zone;
import com.iics.store.Zonebay;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;




/**
 *
 * @author IICS
 */

@Service("manageLocationService")
public class ManageLocationService {

    boolean searchState = false;
    

    public List<Map> fetchAllFacilityUnits(int facilityid,GenericClassService genericClassService) {
        List<Map> facilityunitlist = new ArrayList<>();
        Map<String, Object> fileObject;
        String[] params = {"facilityid"};
        Object[] paramsValues = {facilityid};
        String[] fields = {"facilityunitid", "facilityunitname"};
        String where = "WHERE facilityid=:facilityid";
        List<Object[]> fileObjList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
        if (fileObjList != null) {
            for (Object[] x : fileObjList) {
                fileObject = new HashMap();
                fileObject.put("facilityunitid", x[0]);
                fileObject.put("facilityunitname", x[1]);
                facilityunitlist.add(fileObject);
            }
        }
        return facilityunitlist;
    }

    public List<Map> getFacilityUnit(long facilityunitid,GenericClassService genericClassService) {
        List<Map> facilityunitlist = new ArrayList<>();
        Map<String, Object> fileObject;
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {facilityunitid};
        String[] fields = {"facilityunitid", "facilityunitname"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> fileObjList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
        if (fileObjList != null) {
            for (Object[] x : fileObjList) {
                fileObject = new HashMap();
                fileObject.put("facilityunitid", x[0]);
                fileObject.put("facilityunitname", x[1]);
                facilityunitlist.add(fileObject);
            }
        }
        return facilityunitlist;
    }

    public List<Map> fetchZones(Long facilityunitid,GenericClassService genericClassService) {
        List<Map> facilityunitlist = new ArrayList<>();
        Map<String, Object> ZoneObject;
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {facilityunitid};
        String[] fields = {"zoneid", "zonelabel"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> fileObjList = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fields, where, params, paramsValues);
        if (fileObjList != null) {
            for (Object[] x : fileObjList) {
                ZoneObject = new HashMap();
                    ZoneObject.put("zoneid", x[0]);
                    ZoneObject.put("zoneName", x[1]);
                    facilityunitlist.add(ZoneObject);
            }
        }
        return facilityunitlist;
    }

    public List<Map> fetchAllBays(int id, int storagemechanismid,GenericClassService genericClassService) {
        List<Map> baylist = new ArrayList<>();
        Map<String, Object> bayObject;
        String[] params = {"zoneid"};
        Object[] paramsValues = {id};
        String[] fields = {"zonebayid", "baylabel", "storagemechanismid.storagemechanismid"};
        String where = "WHERE zoneid=:zoneid";
        List<Object[]> bayObjList = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields, where, params, paramsValues);
        if (bayObjList != null) {
            for (Object[] x : bayObjList) {
                bayObject = new HashMap();
                if (Integer.parseInt(x[2].toString()) == storagemechanismid) {
                    bayObject.put("zonebayid", x[0]);
                    bayObject.put("baylabel", x[1]);
                    baylist.add(bayObject);
                }

            }
        }
        return baylist;
    }
  public List<Map> fetchAllBayRows(int id,GenericClassService genericClassService) {
        List<Map> bayrowlist = new ArrayList<>();
        Map<String, Object> bayRowObject;
        String[] params = {"zonebayid"};
        Object[] paramsValues = {id};
        String[] fields = {"bayrowid", "rowlabel"};
        String where = "WHERE zonebayid=:zonebayid";
        List<Object[]> bayRowObjList = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields, where, params, paramsValues);
        if (bayRowObjList != null) {
            for (Object[] x : bayRowObjList) {
                bayRowObject = new HashMap();
                bayRowObject.put("bayrowid", x[0]);
                 bayRowObject.put("rowlabel", x[1]);
                    bayrowlist.add(bayRowObject);

            }
        }
        return bayrowlist;
    }
    public List<Map> locationDetails(String fileno,GenericClassService genericClassService) {
        List<Map> loc = new ArrayList<>();
        Map<String, Object> locObject;
        String[] params = {"fileno"};
        Object[] paramsValues = {fileno};

        String[] fields = {"zoneid", "zonelabel", "zonebayid",
            "baylabel", "bayrowid", "rowlabel", "bayrowcellid", "celllabel", "locationid"};
        String where = "WHERE fileno=:fileno";
        List<Object[]> fileObjList = (List<Object[]>) genericClassService.fetchRecord(ViewFileLocation.class, fields, where, params, paramsValues);
        setSearchState(false);
        if (fileObjList != null) {
            for (Object[] x : fileObjList) {
                locObject = new HashMap();
                locObject.put("zoneid", x[0]);
                locObject.put("zonelabel", x[1]);
                locObject.put("zonebayid", x[2]);
                locObject.put("baylabel", x[3]);
                locObject.put("bayrowid", x[4]);
                locObject.put("rowlabel", x[5]);
                locObject.put("bayrowcellid", x[6]);
                locObject.put("celllabel", x[7]);
                locObject.put("locationid", x[8]);
                locObject.put("Status", true);
                setSearchState(true);
                loc.add(locObject);
            }
        }
        return loc;
    }

    public List<Map> fetchCells(int id,int storagetypeid,GenericClassService genericClassService) {
        List<Map> cellslist = new ArrayList<>();
        Map<String, Object> fileObject;
        String[] params = {"bayrowid"};
        Object[] paramsValues = {id};
        String[] fields = {"bayrowcellid", "celllabel"};
        String where = "WHERE bayrowid=:bayrowid";
        List<Object[]> fileObjList = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields, where, params, paramsValues);
        if (fileObjList != null) {
            for (Object[] x : fileObjList) {
                fileObject = new HashMap();
                fileObject.put("bayrowcellid", x[0]);
                fileObject.put("celllabel", x[1]);
                cellslist.add(fileObject);
            }
        }
        return cellslist;
    }

    public List<Map> getCurrentFacilityUnitId(long staffId,GenericClassService genericClassService) {
        //facility unit name
        Map<String, Object> facilityunitObject = new HashMap();
        List<Map> facilityunitList = new ArrayList<>();
        String[] params = {"staffid"};
        Object[] paramsValues = {staffId};
        String[] fields = {"facilityunitid"};
        String where = "WHERE staffid=:staffid";

        List<Object[]> result = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
        if (result != null) {
            for (Object[] unit : result) {
                facilityunitObject = new HashMap();
                facilityunitObject.put("facilityunitid", unit[0]);
                facilityunitList.add(facilityunitObject);
                System.out.println("got facilityunitid" + unit[0]);
            }

        }
        return facilityunitList;
    }

    public Map getFaciltyName(String facility,GenericClassService genericClassService) {
        List<Map> facilitylist = new ArrayList<>();
        Map<String, Object> fileObject = new HashMap();;
        int facilityid = Integer.parseInt(facility);
        String[] params = {"facilityid"};
        Object[] paramsValues = {facilityid};
        String[] fields = {"facilityid", "facilityname"};
        String where = "WHERE facilityid=:facilityid";
        List<Object[]> fileObjList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
        if (fileObjList != null) {
            for (Object[] x : fileObjList) {

                fileObject.put("facilityid", x[0]);
                fileObject.put("facilityname", x[1]);
                facilitylist.add(fileObject);
            }
        }
        return fileObject;
    }

    public boolean isSearchState() {
        return searchState;
    }

    public void setSearchState(boolean searchState) {
        this.searchState = searchState;
    }

}
