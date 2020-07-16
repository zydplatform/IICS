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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.accessrightsgroup", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Accessrightsgroup.findAll", query = "SELECT a FROM Accessrightsgroup a")
    , @NamedQuery(name = "Accessrightsgroup.findByAccessrightsgroupid", query = "SELECT a FROM Accessrightsgroup a WHERE a.accessrightsgroupid = :accessrightsgroupid")
    , @NamedQuery(name = "Accessrightsgroup.findByAddedby", query = "SELECT a FROM Accessrightsgroup a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Accessrightsgroup.findByDateadded", query = "SELECT a FROM Accessrightsgroup a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Accessrightsgroup.findByLastupdated", query = "SELECT a FROM Accessrightsgroup a WHERE a.lastupdated = :lastupdated")
    , @NamedQuery(name = "Accessrightsgroup.findByLastupdatedby", query = "SELECT a FROM Accessrightsgroup a WHERE a.lastupdatedby = :lastupdatedby")})
public class Accessrightsgroup implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "accessrightsgroupid", nullable = false)
    private Integer accessrightsgroupid;
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
    @Column(name = "active")
    private Boolean active;
    @Column(name = "accessrightgroupname")
    private String accessrightgroupname;
    @Column(name = "facilityid")
    private Integer facilityid;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    @Column(name = "description")
    private String description;

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Accessrightsgroup() {
    }

    public Accessrightsgroup(Integer accessrightsgroupid) {
        this.accessrightsgroupid = accessrightsgroupid;
    }

    public Integer getAccessrightsgroupid() {
        return accessrightsgroupid;
    }

    public void setAccessrightsgroupid(Integer accessrightsgroupid) {
        this.accessrightsgroupid = accessrightsgroupid;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (accessrightsgroupid != null ? accessrightsgroupid.hashCode() : 0);
        return hash;
    }

    public String getAccessrightgroupname() {
        return accessrightgroupname;
    }

    public void setAccessrightgroupname(String accessrightgroupname) {
        this.accessrightgroupname = accessrightgroupname;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Accessrightsgroup)) {
            return false;
        }
        Accessrightsgroup other = (Accessrightsgroup) object;
        if ((this.accessrightsgroupid == null && other.accessrightsgroupid != null) || (this.accessrightsgroupid != null && !this.accessrightsgroupid.equals(other.accessrightsgroupid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Accessrightsgroup[ accessrightsgroupid=" + accessrightsgroupid + " ]";
    }
}
