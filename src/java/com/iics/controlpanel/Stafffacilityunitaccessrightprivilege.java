/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "controlpanel.stafffacilityunitaccessrightprivilege", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findAll", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s")
    , @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findByStafffacilityunitaccessrightprivilegeid", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s WHERE s.stafffacilityunitaccessrightprivilegeid = :stafffacilityunitaccessrightprivilegeid")
    , @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findByActive", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s WHERE s.active = :active")
    , @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findByAddedby", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findByDateadded", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findByLastupdated", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s WHERE s.lastupdated = :lastupdated")
    , @NamedQuery(name = "Stafffacilityunitaccessrightprivilege.findByLastupdatedby", query = "SELECT s FROM Stafffacilityunitaccessrightprivilege s WHERE s.lastupdatedby = :lastupdatedby")})
public class Stafffacilityunitaccessrightprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "stafffacilityunitaccessrightprivilegeid", nullable = false)
    private Integer stafffacilityunitaccessrightprivilegeid;
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
    @Column(name = "accessrightgroupprivilegeid")
    private Integer accessrightgroupprivilegeid;
    @Column(name = "isrecalled")
    private Boolean isrecalled;

    public Long getStafffacilityunitid() {
        return stafffacilityunitid;
    }

    public void setStafffacilityunitid(Long stafffacilityunitid) {
        this.stafffacilityunitid = stafffacilityunitid;
    }
    @Column(name = "stafffacilityunitid")
    private Long stafffacilityunitid;
    public Stafffacilityunitaccessrightprivilege() {
    }

    public Stafffacilityunitaccessrightprivilege(Integer stafffacilityunitaccessrightprivilegeid) {
        this.stafffacilityunitaccessrightprivilegeid = stafffacilityunitaccessrightprivilegeid;
    }

    public Integer getStafffacilityunitaccessrightprivilegeid() {
        return stafffacilityunitaccessrightprivilegeid;
    }

    public void setStafffacilityunitaccessrightprivilegeid(Integer stafffacilityunitaccessrightprivilegeid) {
        this.stafffacilityunitaccessrightprivilegeid = stafffacilityunitaccessrightprivilegeid;
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

    public Integer getAccessrightgroupprivilegeid() {
        return accessrightgroupprivilegeid;
    }

    public void setAccessrightgroupprivilegeid(Integer accessrightgroupprivilegeid) {
        this.accessrightgroupprivilegeid = accessrightgroupprivilegeid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (stafffacilityunitaccessrightprivilegeid != null ? stafffacilityunitaccessrightprivilegeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stafffacilityunitaccessrightprivilege)) {
            return false;
        }
        Stafffacilityunitaccessrightprivilege other = (Stafffacilityunitaccessrightprivilege) object;
        if ((this.stafffacilityunitaccessrightprivilegeid == null && other.stafffacilityunitaccessrightprivilegeid != null) || (this.stafffacilityunitaccessrightprivilegeid != null && !this.stafffacilityunitaccessrightprivilegeid.equals(other.stafffacilityunitaccessrightprivilegeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Stafffacilityunitaccessrightprivilege[ stafffacilityunitaccessrightprivilegeid=" + stafffacilityunitaccessrightprivilegeid + " ]";
    }

    public Boolean getIsrecalled() {
        return isrecalled;
    }

    public void setIsrecalled(Boolean isrecalled) {
        this.isrecalled = isrecalled;
    }
    
}
