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
@Table(name = "assets", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assets.findAll", query = "SELECT a FROM Assets a")
    , @NamedQuery(name = "Assets.findByAssetsid", query = "SELECT a FROM Assets a WHERE a.assetsid = :assetsid")
    , @NamedQuery(name = "Assets.findByAssetsname", query = "SELECT a FROM Assets a WHERE a.assetsname = :assetsname")
    , @NamedQuery(name = "Assets.findByDateadded", query = "SELECT a FROM Assets a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Assets.findByDateupdated", query = "SELECT a FROM Assets a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Assets.findByAddedby", query = "SELECT a FROM Assets a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Assets.findByUpdatedby", query = "SELECT a FROM Assets a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Assets.findByAssettype", query = "SELECT a FROM Assets a WHERE a.assettype = :assettype")
    , @NamedQuery(name = "Assets.findByIsservicable", query = "SELECT a FROM Assets a WHERE a.isservicable = :isservicable")
    , @NamedQuery(name = "Assets.findByMoreinfo", query = "SELECT a FROM Assets a WHERE a.moreinfo = :moreinfo")})
public class Assets implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "assetsid", nullable = false)
    private Integer assetsid;
    @Size(max = 2147483647)
    @Column(name = "assetsname", length = 2147483647)
    private String assetsname;
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
    @Column(name = "assetclassificationid")
    private Integer assetclassificationid;
    @Column(name = "isservicable")
    private Boolean isservicable;
    @Column(name = "assettype")
    private String assettype;
    @Column(name = "moreinfo")
    private String moreinfo;
    @OneToMany(mappedBy = "assetsid")
    private List<Facilityassets> facilityassetsList;

    public Assets() {
    }

    public Assets(Integer assetsid) {
        this.assetsid = assetsid;
    }

    public Integer getAssetsid() {
        return assetsid;
    }

    public void setAssetsid(Integer assetsid) {
        this.assetsid = assetsid;
    }

    public String getAssetsname() {
        return assetsname;
    }

    public void setAssetsname(String assetsname) {
        this.assetsname = assetsname;
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

    public Integer getAssetclassificationid() {
        return assetclassificationid;
    }

    public void setAssetclassificationid(Integer assetclassificationid) {
        this.assetclassificationid = assetclassificationid;
    }

    public Boolean getIsservicable() {
        return isservicable;
    }

    public void setIsservicable(Boolean isservicable) {
        this.isservicable = isservicable;
    }

    public String getAssettype() {
        return assettype;
    }

    public void setAssettype(String assettype) {
        this.assettype = assettype;
    }

    public String getMoreinfo() {
        return moreinfo;
    }

    public void setMoreinfo(String moreinfo) {
        this.moreinfo = moreinfo;
    }

    @XmlTransient
   
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (assetsid != null ? assetsid.hashCode() : 0);
        return hash;
    }

    public List<Facilityassets> getFacilityassetsList() {
        return facilityassetsList;
    }

    public void setFacilityassetsList(List<Facilityassets> facilityassetsList) {
        this.facilityassetsList = facilityassetsList;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Assets)) {
            return false;
        }
        Assets other = (Assets) object;
        if ((this.assetsid == null && other.assetsid != null) || (this.assetsid != null && !this.assetsid.equals(other.assetsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Assets[ assetsid=" + assetsid + " ]";
    }

}
