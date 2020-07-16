/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
 * @author IICS
 */
@Entity
@Table(name = "stockactivity", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stockactivity.findAll", query = "SELECT s FROM Stockactivity s")
    , @NamedQuery(name = "Stockactivity.findByStockactivityid", query = "SELECT s FROM Stockactivity s WHERE s.stockactivityid = :stockactivityid")
    , @NamedQuery(name = "Stockactivity.findByActivityname", query = "SELECT s FROM Stockactivity s WHERE s.activityname = :activityname")
    , @NamedQuery(name = "Stockactivity.findByStartdate", query = "SELECT s FROM Stockactivity s WHERE s.startdate = :startdate")
    , @NamedQuery(name = "Stockactivity.findByEnddate", query = "SELECT s FROM Stockactivity s WHERE s.enddate = :enddate")
    , @NamedQuery(name = "Stockactivity.findByAddedby", query = "SELECT s FROM Stockactivity s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Stockactivity.findByDateadded", query = "SELECT s FROM Stockactivity s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Stockactivity.findByDateupdated", query = "SELECT s FROM Stockactivity s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Stockactivity.findByUpdatedby", query = "SELECT s FROM Stockactivity s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "Stockactivity.findByFacilityunitid", query = "SELECT s FROM Stockactivity s WHERE s.facilityunitid = :facilityunitid")})
public class Stockactivity implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "stockactivityid", nullable = false)
    private Long stockactivityid;
    @Size(max = 255)
    @Column(name = "activityname", length = 255)
    private String activityname;
    @Column(name = "startdate")
    @Temporal(TemporalType.DATE)
    private Date startdate;
    @Column(name = "enddate")
    @Temporal(TemporalType.DATE)
    private Date enddate;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @OneToMany(mappedBy = "stockactivityid")
    private List<Activityfollowup> activityfollowupList;
    @OneToMany(mappedBy = "stockactivityid")
    private List<Activitycell> activitycellList;

    public Stockactivity() {
    }

    public Stockactivity(Long stockactivityid) {
        this.stockactivityid = stockactivityid;
    }

    public Long getStockactivityid() {
        return stockactivityid;
    }

    public void setStockactivityid(Long stockactivityid) {
        this.stockactivityid = stockactivityid;
    }

    public String getActivityname() {
        return activityname;
    }

    public void setActivityname(String activityname) {
        this.activityname = activityname;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
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

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    @XmlTransient
    public List<Activityfollowup> getActivityfollowupList() {
        return activityfollowupList;
    }

    public void setActivityfollowupList(List<Activityfollowup> activityfollowupList) {
        this.activityfollowupList = activityfollowupList;
    }

    @XmlTransient
    public List<Activitycell> getActivitycellList() {
        return activitycellList;
    }

    public void setActivitycellList(List<Activitycell> activitycellList) {
        this.activitycellList = activitycellList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (stockactivityid != null ? stockactivityid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stockactivity)) {
            return false;
        }
        Stockactivity other = (Stockactivity) object;
        if ((this.stockactivityid == null && other.stockactivityid != null) || (this.stockactivityid != null && !this.stockactivityid.equals(other.stockactivityid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Stockactivity[ stockactivityid=" + stockactivityid + " ]";
    }
    
}
