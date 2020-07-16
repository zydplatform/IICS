/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.facilityunitsupplierschedule", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitsupplierschedule.findAll", query = "SELECT f FROM Facilityunitsupplierschedule f")
    , @NamedQuery(name = "Facilityunitsupplierschedule.findByFacilityunitsupplierscheduleid", query = "SELECT f FROM Facilityunitsupplierschedule f WHERE f.facilityunitsupplierscheduleid = :facilityunitsupplierscheduleid")
    , @NamedQuery(name = "Facilityunitsupplierschedule.findByActive", query = "SELECT f FROM Facilityunitsupplierschedule f WHERE f.active = :active")
    , @NamedQuery(name = "Facilityunitsupplierschedule.findByAddedby", query = "SELECT f FROM Facilityunitsupplierschedule f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitsupplierschedule.findByDateadded", query = "SELECT f FROM Facilityunitsupplierschedule f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitsupplierschedule.findByLastupdated", query = "SELECT f FROM Facilityunitsupplierschedule f WHERE f.lastupdated = :lastupdated")
    , @NamedQuery(name = "Facilityunitsupplierschedule.findByLastupdatedby", query = "SELECT f FROM Facilityunitsupplierschedule f WHERE f.lastupdatedby = :lastupdatedby")})
public class Facilityunitsupplierschedule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitsupplierscheduleid", nullable = false)
    private Integer facilityunitsupplierscheduleid;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    @Column(name = "facilityunitsupplierid")
    private Integer facilityunitsupplierid;
    @Column(name = "scheduleid")
    private Integer scheduleid;
    
    @Column(name = "facilityscheduleid")
    private Long facilityscheduleid;

    public Facilityunitsupplierschedule() {
    }

    public Facilityunitsupplierschedule(Integer facilityunitsupplierscheduleid) {
        this.facilityunitsupplierscheduleid = facilityunitsupplierscheduleid;
    }

    public Integer getFacilityunitsupplierscheduleid() {
        return facilityunitsupplierscheduleid;
    }

    public void setFacilityunitsupplierscheduleid(Integer facilityunitsupplierscheduleid) {
        this.facilityunitsupplierscheduleid = facilityunitsupplierscheduleid;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public Long getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Long lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public Integer getFacilityunitsupplierid() {
        return facilityunitsupplierid;
    }

    public void setFacilityunitsupplierid(Integer facilityunitsupplierid) {
        this.facilityunitsupplierid = facilityunitsupplierid;
    }

    public Integer getScheduleid() {
        return scheduleid;
    }

    public void setScheduleid(Integer scheduleid) {
        this.scheduleid = scheduleid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitsupplierscheduleid != null ? facilityunitsupplierscheduleid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitsupplierschedule)) {
            return false;
        }
        Facilityunitsupplierschedule other = (Facilityunitsupplierschedule) object;
        if ((this.facilityunitsupplierscheduleid == null && other.facilityunitsupplierscheduleid != null) || (this.facilityunitsupplierscheduleid != null && !this.facilityunitsupplierscheduleid.equals(other.facilityunitsupplierscheduleid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Facilityunitsupplierschedule[ facilityunitsupplierscheduleid=" + facilityunitsupplierscheduleid + " ]";
    }

    public Long getFacilityscheduleid() {
        return facilityscheduleid;
    }

    public void setFacilityscheduleid(Long facilityscheduleid) {
        this.facilityscheduleid = facilityscheduleid;
    }

}
