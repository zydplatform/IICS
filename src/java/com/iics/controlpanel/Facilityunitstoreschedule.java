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
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.facilityunitstoreschedule", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitstoreschedule.findAll", query = "SELECT f FROM Facilityunitstoreschedule f")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByFacilityunitsupplierid", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.facilityunitsupplierid = :facilityunitsupplierid")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByFacilityunitid", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByStatus", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByIsactive", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.isactive = :isactive")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByFacilityunitname", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.facilityunitname = :facilityunitname")
    , @NamedQuery(name = "Facilityunitstoreschedule.findBySupplierid", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.supplierid = :supplierid")
    , @NamedQuery(name = "Facilityunitstoreschedule.findBySuppliertype", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.suppliertype = :suppliertype")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByFacilityunitsupplierscheduleid", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.facilityunitsupplierscheduleid = :facilityunitsupplierscheduleid")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByScheduleid", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.scheduleid = :scheduleid")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByFacilityscheduleid", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.facilityscheduleid = :facilityscheduleid")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByActive", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.active = :active")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByScheduledayname", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.scheduledayname = :scheduledayname")
    , @NamedQuery(name = "Facilityunitstoreschedule.findByAbbreviation", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.abbreviation = :abbreviation")
    , @NamedQuery(name = "Facilityunitstoreschedule.findBySchedulename", query = "SELECT f FROM Facilityunitstoreschedule f WHERE f.schedulename = :schedulename")})
public class Facilityunitstoreschedule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "facilityunitsupplierid")
    private Integer facilityunitsupplierid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 50)
    @Column(name = "status", length = 50)
    private String status;
    @Column(name = "isactive")
    private Boolean isactive;
    @Size(max = 2147483647)
    @Column(name = "facilityunitname", length = 2147483647)
    private String facilityunitname;
    @Column(name = "supplierid")
    private BigInteger supplierid;
    @Size(max = 100)
    @Column(name = "suppliertype", length = 100)
    private String suppliertype;
    @Id
    @Column(name = "facilityunitsupplierscheduleid")
    private Integer facilityunitsupplierscheduleid;
    @Column(name = "scheduleid")
    private Integer scheduleid;
    @Column(name = "facilityscheduleid")
    private BigInteger facilityscheduleid;
    @Column(name = "active")
    private Boolean active;
    @Size(max = 100)
    @Column(name = "scheduledayname", length = 100)
    private String scheduledayname;
    @Size(max = 20)
    @Column(name = "abbreviation", length = 20)
    private String abbreviation;
    @Size(max = 2147483647)
    @Column(name = "schedulename", length = 2147483647)
    private String schedulename;

    public Facilityunitstoreschedule() {
    }

    public Integer getFacilityunitsupplierid() {
        return facilityunitsupplierid;
    }

    public void setFacilityunitsupplierid(Integer facilityunitsupplierid) {
        this.facilityunitsupplierid = facilityunitsupplierid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }

    public BigInteger getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(BigInteger supplierid) {
        this.supplierid = supplierid;
    }

    public String getSuppliertype() {
        return suppliertype;
    }

    public void setSuppliertype(String suppliertype) {
        this.suppliertype = suppliertype;
    }

    public Integer getFacilityunitsupplierscheduleid() {
        return facilityunitsupplierscheduleid;
    }

    public void setFacilityunitsupplierscheduleid(Integer facilityunitsupplierscheduleid) {
        this.facilityunitsupplierscheduleid = facilityunitsupplierscheduleid;
    }

    public Integer getScheduleid() {
        return scheduleid;
    }

    public void setScheduleid(Integer scheduleid) {
        this.scheduleid = scheduleid;
    }

    public BigInteger getFacilityscheduleid() {
        return facilityscheduleid;
    }

    public void setFacilityscheduleid(BigInteger facilityscheduleid) {
        this.facilityscheduleid = facilityscheduleid;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getScheduledayname() {
        return scheduledayname;
    }

    public void setScheduledayname(String scheduledayname) {
        this.scheduledayname = scheduledayname;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    public String getSchedulename() {
        return schedulename;
    }

    public void setSchedulename(String schedulename) {
        this.schedulename = schedulename;
    }
    
}
