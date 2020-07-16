/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "controlpanel.autoactivityrunsetting", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Autoactivityrunsetting.findAll", query = "SELECT a FROM Autoactivityrunsetting a")
    , @NamedQuery(name = "Autoactivityrunsetting.findByAutoactivityrunsettingid", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.autoactivityrunsettingid = :autoactivityrunsettingid")
    , @NamedQuery(name = "Autoactivityrunsetting.findByFormattedruntime", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.formattedruntime = :formattedruntime")
    , @NamedQuery(name = "Autoactivityrunsetting.findByActivityname", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.activityname = :activityname")
    , @NamedQuery(name = "Autoactivityrunsetting.findByIffinished", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.iffinished = :iffinished")
    , @NamedQuery(name = "Autoactivityrunsetting.findByEndtime", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.endtime = :endtime")
    , @NamedQuery(name = "Autoactivityrunsetting.findByStarttime", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.starttime = :starttime")
    , @NamedQuery(name = "Autoactivityrunsetting.findByAdded", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.added = :added")
    , @NamedQuery(name = "Autoactivityrunsetting.findByDescription", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.description = :description")
    , @NamedQuery(name = "Autoactivityrunsetting.findByBeanname", query = "SELECT a FROM Autoactivityrunsetting a WHERE a.beanname = :beanname")})
public class Autoactivityrunsetting implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "autoactivityrunsettingid", nullable = false)
    private Long autoactivityrunsettingid;
    @Column(name = "formattedruntime")
    @Temporal(TemporalType.TIME)
    private Date formattedruntime;
    @Size(max = 2147483647)
    @Column(name = "activityname", length = 2147483647)
    private String activityname;
    @Column(name = "iffinished")
    private Boolean iffinished;
    @Column(name = "endtime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endtime;
    @Column(name = "starttime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttime;
    @Column(name = "added")
    private Boolean added;
    @Size(max = 255)
    @Column(name = "description", length = 255)
    private String description;
    @Size(max = 255)
    @Column(name = "beanname", length = 255)
    private String beanname;
    @OneToMany(mappedBy = "autoactivityrunsetting")
    private List<Services> servicesList;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    
    public Autoactivityrunsetting() {
    }

    public Autoactivityrunsetting(Long autoactivityrunsettingid) {
        this.autoactivityrunsettingid = autoactivityrunsettingid;
    }

    public Long getAutoactivityrunsettingid() {
        return autoactivityrunsettingid;
    }

    public void setAutoactivityrunsettingid(Long autoactivityrunsettingid) {
        this.autoactivityrunsettingid = autoactivityrunsettingid;
    }

    public Date getFormattedruntime() {
        return formattedruntime;
    }

    public void setFormattedruntime(Date formattedruntime) {
        this.formattedruntime = formattedruntime;
    }

    public String getActivityname() {
        return activityname;
    }

    public void setActivityname(String activityname) {
        this.activityname = activityname;
    }

    public Boolean getIffinished() {
        return iffinished;
    }

    public void setIffinished(Boolean iffinished) {
        this.iffinished = iffinished;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Boolean getAdded() {
        return added;
    }

    public void setAdded(Boolean added) {
        this.added = added;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBeanname() {
        return beanname;
    }

    public void setBeanname(String beanname) {
        this.beanname = beanname;
    }

    @XmlTransient
    public List<Services> getServicesList() {
        return servicesList;
    }

    public void setServicesList(List<Services> servicesList) {
        this.servicesList = servicesList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (autoactivityrunsettingid != null ? autoactivityrunsettingid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Autoactivityrunsetting)) {
            return false;
        }
        Autoactivityrunsetting other = (Autoactivityrunsetting) object;
        if ((this.autoactivityrunsettingid == null && other.autoactivityrunsettingid != null) || (this.autoactivityrunsettingid != null && !this.autoactivityrunsettingid.equals(other.autoactivityrunsettingid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Autoactivityrunsetting[ autoactivityrunsettingid=" + autoactivityrunsettingid + " ]";
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Long lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

}
