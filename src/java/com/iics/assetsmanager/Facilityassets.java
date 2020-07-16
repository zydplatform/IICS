/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "facilityassets", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityassets.findAll", query = "SELECT f FROM Facilityassets f")
    , @NamedQuery(name = "Facilityassets.findByFacilityassetsid", query = "SELECT f FROM Facilityassets f WHERE f.facilityassetsid = :facilityassetsid")
    , @NamedQuery(name = "Facilityassets.findByFacilityid", query = "SELECT f FROM Facilityassets f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilityassets.findByDonationsid", query = "SELECT f FROM Facilityassets f WHERE f.donationsid = :donationsid")
    , @NamedQuery(name = "Facilityassets.findByAssetsid", query = "SELECT f FROM Facilityassets f WHERE f.assetsid = :assetsid")
    , @NamedQuery(name = "Facilityassets.findByIsdonated", query = "SELECT f FROM Facilityassets f WHERE f.isdonated = :isdonated")
    , @NamedQuery(name = "Facilityassets.findByItemspecification", query = "SELECT f FROM Facilityassets f WHERE f.itemspecification = :itemspecification")
    , @NamedQuery(name = "Facilityassets.findBySerialno", query = "SELECT f FROM Facilityassets f WHERE f.serialno = :serialno")
    , @NamedQuery(name = "Facilityassets.findByAssetqty", query = "SELECT f FROM Facilityassets f WHERE f.assetqty = :assetqty")
    , @NamedQuery(name = "Facilityassets.findByOlddonatedqty", query = "SELECT f FROM Facilityassets f WHERE f.olddonatedqty = :olddonatedqty")
    , @NamedQuery(name = "Facilityassets.findByAllocated", query = "SELECT f FROM Facilityassets f WHERE f.olddonatedqty = :olddonatedqty")
    , @NamedQuery(name = "Facilityassets.findByDateadded", query = "SELECT f FROM Facilityassets f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityassets.findByDateupdated", query = "SELECT f FROM Facilityassets f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilityassets.findByAddedby", query = "SELECT f FROM Facilityassets f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityassets.findByUpdatedby", query = "SELECT f FROM Facilityassets f WHERE f.updatedby = :updatedby")})
public class Facilityassets implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityassetsid", nullable = false)
    private Long facilityassetsid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "donationsid")
    private Integer donationsid;
    @Column(name = "assetsid")
    private Integer assetsid;
    @Column(name = "isdonated")
    private Boolean isdonated;
    @Size(max = 2147483647)
    @Column(name = "itemspecification", length = 2147483647)
    private String itemspecification;
    @Size(max = 2147483647)
    @Column(name = "serialno", length = 2147483647)
    private String serialno;
    @Column(name = "assetqty")
    private Integer assetqty;
    @Size(max = 2147483647)
    @Column(name = "olddonatedqty")
    private Integer olddonatedqty;
    @Size(max = 2147483647)
    @Column(name = "allocated", length = 2147483647)
    private String allocated;
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

    public Facilityassets() {
    }

    public Facilityassets(Long facilityassetsid) {
        this.facilityassetsid = facilityassetsid;
    }

    public Long getFacilityassetsid() {
        return facilityassetsid;
    }

    public void setFacilityassetsid(Long facilityassetsid) {
        this.facilityassetsid = facilityassetsid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Integer getDonationsid() {
        return donationsid;
    }

    public void setDonationsid(Integer donationsid) {
        this.donationsid = donationsid;
    }

    public Integer getAssetsid() {
        return assetsid;
    }

    public void setAssetsid(Integer assetsid) {
        this.assetsid = assetsid;
    }

    public Boolean getIsdonated() {
        return isdonated;
    }

    public void setIsdonated(Boolean isdonated) {
        this.isdonated = isdonated;
    }

    public String getItemspecification() {
        return itemspecification;
    }

    public void setItemspecification(String itemspecification) {
        this.itemspecification = itemspecification;
    }

    public String getSerialno() {
        return serialno;
    }

    public void setSerialno(String serialno) {
        this.serialno = serialno;
    }

    public Integer getAssetqty() {
        return assetqty;
    }

    public void setAssetqty(Integer assetqty) {
        this.assetqty = assetqty;
    }

    public Integer getOlddonatedqty() {
        return olddonatedqty;
    }

    public void setOlddonatedqty(Integer olddonatedqty) {
        this.olddonatedqty = olddonatedqty;
    }

    public String getAllocated() {
        return allocated;
    }

    public void setAllocated(String allocated) {
        this.allocated = allocated;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityassetsid != null ? facilityassetsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityassets)) {
            return false;
        }
        Facilityassets other = (Facilityassets) object;
        if ((this.facilityassetsid == null && other.facilityassetsid != null) || (this.facilityassetsid != null && !this.facilityassetsid.equals(other.facilityassetsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Facilityassets[ facilityassetsid=" + facilityassetsid + " ]";
    }

}
