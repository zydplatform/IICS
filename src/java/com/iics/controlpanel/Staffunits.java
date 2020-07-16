/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Grace-K
 */
@Entity
@Table(name = "staffunits", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffunits.findAll", query = "SELECT s FROM Staffunits s")
    , @NamedQuery(name = "Staffunits.findByStaffid", query = "SELECT s FROM Staffunits s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Staffunits.findByStafffacilityunitid", query = "SELECT s FROM Staffunits s WHERE s.stafffacilityunitid = :stafffacilityunitid")
    , @NamedQuery(name = "Staffunits.findByActive", query = "SELECT s FROM Staffunits s WHERE s.active = :active")
    , @NamedQuery(name = "Staffunits.findByFacilityunitid", query = "SELECT s FROM Staffunits s WHERE s.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Staffunits.findByFacilityunitname", query = "SELECT s FROM Staffunits s WHERE s.facilityunitname = :facilityunitname")})
public class Staffunits implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "staffid")
    private Long staffid;
    @Column(name = "stafffacilityunitid")
    private Long stafffacilityunitid;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "facilityunitid")
    private Long facilityunitid;
    @Size(max = 2147483647)
    @Column(name = "facilityunitname", length = 2147483647)
    private String facilityunitname;

    public Staffunits() {
    }

    public Long getStaffid() {
        return staffid;
    }

    public void setStaffid(Long staffid) {
        this.staffid = staffid;
    }

    public Long getStafffacilityunitid() {
        return stafffacilityunitid;
    }

    public void setStafffacilityunitid(Long stafffacilityunitid) {
        this.stafffacilityunitid = stafffacilityunitid;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }
    
}
