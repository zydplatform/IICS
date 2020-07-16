/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

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
 * @author user
 */
@Entity
@Table(name = "facilityunits", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunits.findAll", query = "SELECT f FROM Facilityunits f")
    , @NamedQuery(name = "Facilityunits.findByStaffid", query = "SELECT f FROM Facilityunits f WHERE f.staffid = :staffid")
    , @NamedQuery(name = "Facilityunits.findByFacilityunitid", query = "SELECT f FROM Facilityunits f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunits.findByFacilityunitname", query = "SELECT f FROM Facilityunits f WHERE f.facilityunitname = :facilityunitname")})
public class Facilityunits implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 2147483647)
    @Column(name = "facilityunitname", length = 2147483647)
    private String facilityunitname;
    @Column(name = "active", nullable = false)
    private boolean active;

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
    public Facilityunits() {
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }
    
}
