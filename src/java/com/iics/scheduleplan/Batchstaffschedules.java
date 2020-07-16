/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.scheduleplan;

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
@Table(name = "scheduleplan.batchstaffschedules", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Batchstaffschedules.findAll", query = "SELECT b FROM Batchstaffschedules b")
    , @NamedQuery(name = "Batchstaffschedules.findByServiceid", query = "SELECT b FROM Batchstaffschedules b WHERE b.serviceid = :serviceid")
    , @NamedQuery(name = "Batchstaffschedules.findByServicename", query = "SELECT b FROM Batchstaffschedules b WHERE b.servicename = :servicename")
    , @NamedQuery(name = "Batchstaffschedules.findByFacilityunitid", query = "SELECT b FROM Batchstaffschedules b WHERE b.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Batchstaffschedules.findByServicedayplanid", query = "SELECT b FROM Batchstaffschedules b WHERE b.servicedayplanid = :servicedayplanid")
    , @NamedQuery(name = "Batchstaffschedules.findByServicedayid", query = "SELECT b FROM Batchstaffschedules b WHERE b.servicedayid = :servicedayid")
    , @NamedQuery(name = "Batchstaffschedules.findByDesiredstaff", query = "SELECT b FROM Batchstaffschedules b WHERE b.desiredstaff = :desiredstaff")
    , @NamedQuery(name = "Batchstaffschedules.findByStarttime", query = "SELECT b FROM Batchstaffschedules b WHERE b.starttime = :starttime")
    , @NamedQuery(name = "Batchstaffschedules.findByEndtime", query = "SELECT b FROM Batchstaffschedules b WHERE b.endtime = :endtime")
    , @NamedQuery(name = "Batchstaffschedules.findByStaffserviceid", query = "SELECT b FROM Batchstaffschedules b WHERE b.staffserviceid = :staffserviceid")
    , @NamedQuery(name = "Batchstaffschedules.findByStaffid", query = "SELECT b FROM Batchstaffschedules b WHERE b.staffid = :staffid")
    , @NamedQuery(name = "Batchstaffschedules.findByWorkinghours", query = "SELECT b FROM Batchstaffschedules b WHERE b.workinghours = :workinghours")})
public class Batchstaffschedules implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "serviceid")
    @Id
    private BigInteger serviceid;
    @Size(max = 255)
    @Column(name = "servicename", length = 255)
    private String servicename;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "servicedayplanid")
    private BigInteger servicedayplanid;
    @Column(name = "servicedayid")
    private Integer servicedayid;
    @Column(name = "desiredstaff")
    private Integer desiredstaff;
    @Size(max = 30)
    @Column(name = "starttime", length = 30)
    private String starttime;
    @Size(max = 30)
    @Column(name = "endtime", length = 30)
    private String endtime;
    @Column(name = "staffserviceid")
    private BigInteger staffserviceid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "workinghours")
    private Integer workinghours;

    public Batchstaffschedules() {
    }

    public BigInteger getServiceid() {
        return serviceid;
    }

    public void setServiceid(BigInteger serviceid) {
        this.serviceid = serviceid;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public BigInteger getServicedayplanid() {
        return servicedayplanid;
    }

    public void setServicedayplanid(BigInteger servicedayplanid) {
        this.servicedayplanid = servicedayplanid;
    }

    public Integer getServicedayid() {
        return servicedayid;
    }

    public void setServicedayid(Integer servicedayid) {
        this.servicedayid = servicedayid;
    }

    public Integer getDesiredstaff() {
        return desiredstaff;
    }

    public void setDesiredstaff(Integer desiredstaff) {
        this.desiredstaff = desiredstaff;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setStarttime(String starttime) {
        this.starttime = starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public BigInteger getStaffserviceid() {
        return staffserviceid;
    }

    public void setStaffserviceid(BigInteger staffserviceid) {
        this.staffserviceid = staffserviceid;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public Integer getWorkinghours() {
        return workinghours;
    }

    public void setWorkinghours(Integer workinghours) {
        this.workinghours = workinghours;
    }
    
}
