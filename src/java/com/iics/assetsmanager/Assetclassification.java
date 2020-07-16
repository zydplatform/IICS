/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "assetclassification", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assetclassification.findAll", query = "SELECT a FROM Assetclassification a")
    , @NamedQuery(name = "Assetclassification.findByAssetclassificationid", query = "SELECT a FROM Assetclassification a WHERE a.assetclassificationid = :assetclassificationid")
    , @NamedQuery(name = "Assetclassification.findByClassificationname", query = "SELECT a FROM Assetclassification a WHERE a.classificationname = :classificationname")
    , @NamedQuery(name = "Assetclassification.findByAllocationtype", query = "SELECT a FROM Assetclassification a WHERE a.allocationtype = :allocationtype")
    , @NamedQuery(name = "Assetclassification.findByDateadded", query = "SELECT a FROM Assetclassification a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Assetclassification.findByDateupdated", query = "SELECT a FROM Assetclassification a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Assetclassification.findByAddedby", query = "SELECT a FROM Assetclassification a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Assetclassification.findByUpdatedby", query = "SELECT a FROM Assetclassification a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Assetclassification.findByMoreinfo", query = "SELECT a FROM Assetclassification a WHERE a.moreinfo = :moreinfo")})
public class Assetclassification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "assetclassificationid", nullable = false)
    private Integer assetclassificationid;
    @Size(max = 2147483647)
    @Column(name = "classificationname", length = 2147483647)
    private String classificationname;
    @Size(max = 2147483647)
    @Column(name = "allocationtype", length = 2147483647)
    private String allocationtype;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "moreinfo")
    private String moreinfo;
    @OneToMany(mappedBy = "assetclassificationid")
    private List<Assets> assetsList;

    public Assetclassification() {
    }

    public Assetclassification(Integer assetclassificationid) {
        this.assetclassificationid = assetclassificationid;
    }

    public Integer getAssetclassificationid() {
        return assetclassificationid;
    }

    public void setAssetclassificationid(Integer assetclassificationid) {
        this.assetclassificationid = assetclassificationid;
    }

    public String getClassificationname() {
        return classificationname;
    }

    public void setClassificationname(String classificationname) {
        this.classificationname = classificationname;
    }

    public String getAllocationtype() {
        return allocationtype;
    }

    public void setAllocationtype(String allocationtype) {
        this.allocationtype = allocationtype;
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

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public String getMoreinfo() {
        return moreinfo;
    }

    public void setMoreinfo(String moreinfo) {
        this.moreinfo = moreinfo;
    }

    @XmlTransient
    public List<Assets> getAssetsList() {
        return assetsList;
    }

    public void setAssetsList(List<Assets> assetsList) {
        this.assetsList = assetsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (assetclassificationid != null ? assetclassificationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Assetclassification)) {
            return false;
        }
        Assetclassification other = (Assetclassification) object;
        if ((this.assetclassificationid == null && other.assetclassificationid != null) || (this.assetclassificationid != null && !this.assetclassificationid.equals(other.assetclassificationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Assetclassification[ assetclassificationid=" + assetclassificationid + " ]";
    }

}
