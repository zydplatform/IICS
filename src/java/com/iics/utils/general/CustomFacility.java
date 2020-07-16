/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.general;

import com.iics.domain.Facility;
import java.util.logging.Logger;

/**
 *
 * @author samuelwam
 */
public class CustomFacility {
    
    int facilityid;
    String facilityname;
    String facilitylevel;
    String facilitycode;
    String facilityowner;
    long facilitydepartmentid;
    String facilitydepartment;
    String status;
    int items;
    
    int regionid;
    String regionname;
    int districtid;
    String districtname;
    int countyid;
    String countyname;
    int subcountyid;
    String subcountyname;
    int parishid;
    String parishname;
    int villageid;
    String villagename;
    
    int northingminimum;
    int northingmaximum;
    int eastingmaximum;
    int eastingminimum;
    int elevationminimum;
    int elevationmaximum;
    
    String role;
    boolean pendingCode;
    boolean pendingLocation;
    boolean pendingGPS;
    boolean pendingApproval;
    
    Facility facility;
    
    String childrenAttached;
    boolean deleteSuccess;
    boolean saveSuccess;
    boolean confirmSuccess;
    
    
    /**
     * 
     * @return
     */
    public int getCountyid() {
        return countyid;
    }

    /**
     * 
     * @param countyid
     */
    public void setCountyid(int countyid) {
        this.countyid = countyid;
    }

    /**
     * 
     * @return
     */
    public String getCountyname() {
        return countyname;
    }

    /**
     * 
     * @param countyname
     */
    public void setCountyname(String countyname) {
        this.countyname = countyname;
    }

    /**
     * 
     * @return
     */
    public int getDistrictid() {
        return districtid;
    }

    /**
     * 
     * @param districtid
     */
    public void setDistrictid(int districtid) {
        this.districtid = districtid;
    }

    /**
     * 
     * @return
     */
    public String getDistrictname() {
        return districtname;
    }

    /**
     * 
     * @param districtname
     */
    public void setDistrictname(String districtname) {
        this.districtname = districtname;
    }

    /**
     * 
     * @return
     */
    public String getFacilitycode() {
        return facilitycode;
    }

    /**
     * 
     * @param facilitycode
     */
    public void setFacilitycode(String facilitycode) {
        this.facilitycode = facilitycode;
    }

    /**
     * 
     * @return
     */
    public String getFacilitydepartment() {
        return facilitydepartment;
    }

    /**
     * 
     * @param facilitydepartment
     */
    public void setFacilitydepartment(String facilitydepartment) {
        this.facilitydepartment = facilitydepartment;
    }

    /**
     * 
     * @return
     */
    public long getFacilitydepartmentid() {
        return facilitydepartmentid;
    }

    /**
     * 
     * @param facilitydepartmentid
     */
    public void setFacilitydepartmentid(long facilitydepartmentid) {
        this.facilitydepartmentid = facilitydepartmentid;
    }

    /**
     * 
     * @return
     */
    public int getFacilityid() {
        return facilityid;
    }

    /**
     * 
     * @param facilityid
     */
    public void setFacilityid(int facilityid) {
        this.facilityid = facilityid;
    }

    /**
     * 
     * @return
     */
    public String getFacilitylevel() {
        return facilitylevel;
    }

    /**
     * 
     * @param facilitylevel
     */
    public void setFacilitylevel(String facilitylevel) {
        this.facilitylevel = facilitylevel;
    }

    /**
     * 
     * @return
     */
    public String getFacilityname() {
        return facilityname;
    }

    /**
     * 
     * @param facilityname
     */
    public void setFacilityname(String facilityname) {
        this.facilityname = facilityname;
    }

    /**
     * 
     * @return
     */
    public String getFacilityowner() {
        return facilityowner;
    }

    /**
     * 
     * @param facilityowner
     */
    public void setFacilityowner(String facilityowner) {
        this.facilityowner = facilityowner;
    }

    /**
     * 
     * @return
     */
    public int getParishid() {
        return parishid;
    }

    /**
     * 
     * @param parishid
     */
    public void setParishid(int parishid) {
        this.parishid = parishid;
    }

    /**
     * 
     * @return
     */
    public String getParishname() {
        return parishname;
    }

    /**
     * 
     * @param parishname
     */
    public void setParishname(String parishname) {
        this.parishname = parishname;
    }

    /**
     * 
     * @return
     */
    public int getRegionid() {
        return regionid;
    }

    /**
     * 
     * @param regionid
     */
    public void setRegionid(int regionid) {
        this.regionid = regionid;
    }

    /**
     * 
     * @return
     */
    public String getRegionname() {
        return regionname;
    }

    /**
     * 
     * @param regionname
     */
    public void setRegionname(String regionname) {
        this.regionname = regionname;
    }

    /**
     * 
     * @return
     */
    public String getRole() {
        return role;
    }

    /**
     * 
     * @param role
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * 
     * @return
     */
    public String getStatus() {
        return status;
    }

    /**
     * 
     * @param status
     */
    public void setStatus(String status) {
        this.status = status;
    }
    
    /**
     * 
     * @return
     */
    public int getSubcountyid() {
        return subcountyid;
    }

    /**
     * 
     * @param subcountyid
     */
    public void setSubcountyid(int subcountyid) {
        this.subcountyid = subcountyid;
    }

    /**
     * 
     * @return
     */
    public String getSubcountyname() {
        return subcountyname;
    }

    /**
     * 
     * @param subcountyname
     */
    public void setSubcountyname(String subcountyname) {
        this.subcountyname = subcountyname;
    }

    /**
     * 
     * @return
     */
    public int getVillageid() {
        return villageid;
    }

    /**
     * 
     * @param villageid
     */
    public void setVillageid(int villageid) {
        this.villageid = villageid;
    }

    /**
     * 
     * @return
     */
    public String getVillagename() {
        return villagename;
    }

    /**
     * 
     * @param villagename
     */
    public void setVillagename(String villagename) {
        this.villagename = villagename;
    }

    /**
     * 
     * @return
     */
    public int getEastingmaximum() {
        return eastingmaximum;
    }

    /**
     * 
     * @param eastingmaximum
     */
    public void setEastingmaximum(int eastingmaximum) {
        this.eastingmaximum = eastingmaximum;
    }

    /**
     * 
     * @return
     */
    public int getEastingminimum() {
        return eastingminimum;
    }

    /**
     * 
     * @param eastingminimum
     */
    public void setEastingminimum(int eastingminimum) {
        this.eastingminimum = eastingminimum;
    }

    /**
     * 
     * @return
     */
    public int getElevationmaximum() {
        return elevationmaximum;
    }

    /**
     * 
     * @param elevationmaximum
     */
    public void setElevationmaximum(int elevationmaximum) {
        this.elevationmaximum = elevationmaximum;
    }

    /**
     * 
     * @return
     */
    public int getElevationminimum() {
        return elevationminimum;
    }

    /**
     * 
     * @param elevationminimum
     */
    public void setElevationminimum(int elevationminimum) {
        this.elevationminimum = elevationminimum;
    }

    /**
     * 
     * @return
     */
    public int getNorthingmaximum() {
        return northingmaximum;
    }

    /**
     * 
     * @param northingmaximum
     */
    public void setNorthingmaximum(int northingmaximum) {
        this.northingmaximum = northingmaximum;
    }

    /**
     * 
     * @return
     */
    public int getNorthingminimum() {
        return northingminimum;
    }

    /**
     * 
     * @param northingminimum
     */
    public void setNorthingminimum(int northingminimum) {
        this.northingminimum = northingminimum;
    }

    public boolean getPendingApproval() {
        return pendingApproval;
    }

    public void setPendingApproval(boolean pendingApproval) {
        this.pendingApproval = pendingApproval;
    }

    public boolean getPendingCode() {
        return pendingCode;
    }

    public void setPendingCode(boolean pendingCode) {
        this.pendingCode = pendingCode;
    }

    public boolean getPendingGPS() {
        return pendingGPS;
    }

    public void setPendingGPS(boolean pendingGPS) {
        this.pendingGPS = pendingGPS;
    }

    public boolean getPendingLocation() {
        return pendingLocation;
    }

    public void setPendingLocation(boolean pendingLocation) {
        this.pendingLocation = pendingLocation;
    }

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public String getChildrenAttached() {
        return childrenAttached;
    }

    public void setChildrenAttached(String childrenAttached) {
        this.childrenAttached = childrenAttached;
    }

    public boolean isConfirmSuccess() {
        return confirmSuccess;
    }

    public void setConfirmSuccess(boolean confirmSuccess) {
        this.confirmSuccess = confirmSuccess;
    }

    public boolean isDeleteSuccess() {
        return deleteSuccess;
    }

    public void setDeleteSuccess(boolean deleteSuccess) {
        this.deleteSuccess = deleteSuccess;
    }

    public boolean isSaveSuccess() {
        return saveSuccess;
    }

    public void setSaveSuccess(boolean saveSuccess) {
        this.saveSuccess = saveSuccess;
    }

    public int getItems() {
        return items;
    }

    public void setItems(int items) {
        this.items = items;
    }
    
    
    private static final Logger LOG = Logger.getLogger(CustomFacility.class.getName());
}
