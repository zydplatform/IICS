/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.filemanger;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patient.viewlocation", catalog = "iics_database")
public class ViewFileLocation {
    @Column(name = "locationid")
    @Id
    private Integer locationid;
   @Column(name = "fileno")
    private String fileno;
     @Column(name = "zoneid")
    private Integer zoneid;
    @Size(max = 255)
    @Column(name = "zonelabel", length = 255)
    private String zonelabel;
    @Column(name = "zonebayid")
    private Integer zonebayid;
    @Size(max = 255)
    @Column(name = "baylabel", length = 255)
    private String baylabel;
    @Column(name = "bayrowid")
    private Integer bayrowid;
    @Size(max = 255)
    @Column(name = "rowlabel", length = 255)
    private String rowlabel;
    @Column(name = "bayrowcellid")
    private Integer bayrowcellid;
    @Size(max = 255)
    @Column(name = "celllabel", length = 255)
    private String celllabel;
    @Size(max = 255)
    @Column(name = "facilityunitname", length = 255)
    private String facilityunitname;
    public Integer getLocationid() {
        return locationid;
    }

    public void setLocationid(Integer locationid) {
        this.locationid = locationid;
    }

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

 

    public Integer getZoneid() {
        return zoneid;
    }

    public void setZoneid(Integer zoneid) {
        this.zoneid = zoneid;
    }

    public String getZonelabel() {
        return zonelabel;
    }

    public void setZonelabel(String zonelabel) {
        this.zonelabel = zonelabel;
    }

    public Integer getZonebayid() {
        return zonebayid;
    }

    public void setZonebayid(Integer zonebayid) {
        this.zonebayid = zonebayid;
    }

    public String getBaylabel() {
        return baylabel;
    }

    public void setBaylabel(String baylabel) {
        this.baylabel = baylabel;
    }

    public Integer getBayrowid() {
        return bayrowid;
    }

    public void setBayrowid(Integer bayrowid) {
        this.bayrowid = bayrowid;
    }

    public String getRowlabel() {
        return rowlabel;
    }

    public void setRowlabel(String rowlabel) {
        this.rowlabel = rowlabel;
    }

    public Integer getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(Integer bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public String getCelllabel() {
        return celllabel;
    }

    public void setCelllabel(String celllabel) {
        this.celllabel = celllabel;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }
    
}
