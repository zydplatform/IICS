/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


/**
 *
 * @author user
 */
@Entity
@Table(name = "schedules", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Schedules.findAll", query = "SELECT s FROM Schedules s")
    , @NamedQuery(name = "Schedules.findBySchedulesid", query = "SELECT s FROM Schedules s WHERE s.schedulesid = :schedulesid")
    , @NamedQuery(name = "Schedules.findByStartdate", query = "SELECT s FROM Schedules s WHERE s.startdate = :startdate")
    , @NamedQuery(name = "Schedules.findByEnddate", query = "SELECT s FROM Schedules s WHERE s.enddate = :enddate")
    , @NamedQuery(name = "Schedules.findBySchedulestatus", query = "SELECT s FROM Schedules s WHERE s.schedulestatus = :schedulestatus")
    , @NamedQuery(name = "Schedules.findByStaffid", query = "SELECT s FROM Schedules s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Schedules.findByServiceid", query = "SELECT s FROM Schedules s WHERE s.serviceid = :serviceid")
    , @NamedQuery(name = "Schedules.findByDateadded", query = "SELECT s FROM Schedules s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Schedules.findByAddedby", query = "SELECT s FROM Schedules s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Schedules.findByDateupdated", query = "SELECT s FROM Schedules s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Schedules.findByUpdatedby", query = "SELECT s FROM Schedules s WHERE s.updatedby = :updatedby")})
public class Schedules implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "schedulesid", nullable = false)
    private Long schedulesid;
    @Size(max = 30)
    @Column(name = "startdate", length = 30)
    private String startdate;
    @Size(max = 30)
    @Column(name = "enddate", length = 30)
    private String enddate;
    @Size(max = 30)
    @Column(name = "schedulestatus", length = 30)
    private String schedulestatus;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "serviceid")
    private BigInteger serviceid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @OneToMany(mappedBy = "schedulesid")
    private List<Scheduleday> scheduledayList;

    public Schedules() {
    }

    public Schedules(Long schedulesid) {
        this.schedulesid = schedulesid;
    }

    public Long getSchedulesid() {
        return schedulesid;
    }

    public void setSchedulesid(Long schedulesid) {
        this.schedulesid = schedulesid;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public String getSchedulestatus() {
        return schedulestatus;
    }

    public void setSchedulestatus(String schedulestatus) {
        this.schedulestatus = schedulestatus;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public BigInteger getServiceid() {
        return serviceid;
    }

    public void setServiceid(BigInteger serviceid) {
        this.serviceid = serviceid;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    @XmlTransient
    public List<Scheduleday> getScheduledayList() {
        return scheduledayList;
    }

    public void setScheduledayList(List<Scheduleday> scheduledayList) {
        this.scheduledayList = scheduledayList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (schedulesid != null ? schedulesid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Schedules)) {
            return false;
        }
        Schedules other = (Schedules) object;
        if ((this.schedulesid == null && other.schedulesid != null) || (this.schedulesid != null && !this.schedulesid.equals(other.schedulesid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Schedules[ schedulesid=" + schedulesid + " ]";
    }
    
}
