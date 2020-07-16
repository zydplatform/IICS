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
@Table(name = "controlpanel.accessrightgroupprivilege", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Accessrightgroupprivilege.findAll", query = "SELECT a FROM Accessrightgroupprivilege a")
    , @NamedQuery(name = "Accessrightgroupprivilege.findByAccessrightgroupprivilegeid", query = "SELECT a FROM Accessrightgroupprivilege a WHERE a.accessrightgroupprivilegeid = :accessrightgroupprivilegeid")
    , @NamedQuery(name = "Accessrightgroupprivilege.findByAddedby", query = "SELECT a FROM Accessrightgroupprivilege a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Accessrightgroupprivilege.findByDateadded", query = "SELECT a FROM Accessrightgroupprivilege a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Accessrightgroupprivilege.findByUpdatedby", query = "SELECT a FROM Accessrightgroupprivilege a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Accessrightgroupprivilege.findByDateupdated", query = "SELECT a FROM Accessrightgroupprivilege a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Accessrightgroupprivilege.findByActive", query = "SELECT a FROM Accessrightgroupprivilege a WHERE a.active = :active")})
public class Accessrightgroupprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "accessrightgroupprivilegeid", nullable = false)
    private Integer accessrightgroupprivilegeid;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "accessrightsgroupid")
    private Integer accessrightsgroupid;
    @Column(name = "facilityprivilegeid")
    private Long facilityprivilegeid;
    
    @Column(name = "privilegeid")
    private Long privilegeid;
    
    @Column(name = "isrecalled")
    private Boolean isrecalled;
    
    public Long getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(Long privilegeid) {
        this.privilegeid = privilegeid;
    }

    public Accessrightgroupprivilege() {
    }

    public Accessrightgroupprivilege(Integer accessrightgroupprivilegeid) {
        this.accessrightgroupprivilegeid = accessrightgroupprivilegeid;
    }

    public Integer getAccessrightgroupprivilegeid() {
        return accessrightgroupprivilegeid;
    }

    public void setAccessrightgroupprivilegeid(Integer accessrightgroupprivilegeid) {
        this.accessrightgroupprivilegeid = accessrightgroupprivilegeid;
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

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getAccessrightsgroupid() {
        return accessrightsgroupid;
    }

    public void setAccessrightsgroupid(Integer accessrightsgroupid) {
        this.accessrightsgroupid = accessrightsgroupid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (accessrightgroupprivilegeid != null ? accessrightgroupprivilegeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Accessrightgroupprivilege)) {
            return false;
        }
        Accessrightgroupprivilege other = (Accessrightgroupprivilege) object;
        if ((this.accessrightgroupprivilegeid == null && other.accessrightgroupprivilegeid != null) || (this.accessrightgroupprivilegeid != null && !this.accessrightgroupprivilegeid.equals(other.accessrightgroupprivilegeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Accessrightgroupprivilege[ accessrightgroupprivilegeid=" + accessrightgroupprivilegeid + " ]";
    }

    public Long getFacilityprivilegeid() {
        return facilityprivilegeid;
    }

    public void setFacilityprivilegeid(Long facilityprivilegeid) {
        this.facilityprivilegeid = facilityprivilegeid;
    }

    public Boolean getIsrecalled() {
        return isrecalled;
    }

    public void setIsrecalled(Boolean isrecalled) {
        this.isrecalled = isrecalled;
    }

}
