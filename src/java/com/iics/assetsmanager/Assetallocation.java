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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "assetallocation", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assetallocation.findAll", query = "SELECT a FROM Assetallocation a")
    , @NamedQuery(name = "Assetallocation.findByAssetallocationid", query = "SELECT a FROM Assetallocation a WHERE a.assetallocationid = :assetallocationid")
    , @NamedQuery(name = "Assetallocation.findByQtyallocated", query = "SELECT a FROM Assetallocation a WHERE a.qtyallocated = :qtyallocated")
    , @NamedQuery(name = "Assetallocation.findByAssetcurrentlocation", query = "SELECT a FROM Assetallocation a WHERE a.assetcurrentlocation = :assetcurrentlocation")
    , @NamedQuery(name = "Assetallocation.findByAssetoldlocation", query = "SELECT a FROM Assetallocation a WHERE a.assetoldlocation = :assetoldlocation")
    , @NamedQuery(name = "Assetallocation.findByIsactive", query = "SELECT a FROM Assetallocation a WHERE a.isactive = :isactive")
    , @NamedQuery(name = "Assetallocation.findByDateallocated", query = "SELECT a FROM Assetallocation a WHERE a.dateallocated = :dateallocated")
    , @NamedQuery(name = "Assetallocation.findByAllocatedby", query = "SELECT a FROM Assetallocation a WHERE a.allocatedby = :allocatedby")
    , @NamedQuery(name = "Assetallocation.findByDateupdated", query = "SELECT a FROM Assetallocation a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Assetallocation.findByUpdatedby", query = "SELECT a FROM Assetallocation a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Assetallocation.findByFacilityunitid", query = "SELECT a FROM Assetallocation a WHERE a.facilityunitid = :facilityunitid")})
public class Assetallocation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "assetallocationid", nullable = false)
    private Integer assetallocationid;
    @Column(name = "qtyallocated")
    private Integer qtyallocated;
    @Size(max = 2147483647)
    @Column(name = "assetcurrentlocation", length = 2147483647)
    private Integer assetcurrentlocation;
    @Size(max = 2147483647)
    @Column(name = "assetoldlocation", length = 2147483647)
    private Integer assetoldlocation;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "dateallocated")
    @Temporal(TemporalType.DATE)
    private Date dateallocated;
    @Column(name = "allocatedby")
    private Long allocatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "facilityassetsid")
    private Long facilityassetsid;
    @Column(name = "blockroomid")
    private Integer blockroomid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;

    public Assetallocation() {
    }

    public Assetallocation(Integer assetallocationid) {
        this.assetallocationid = assetallocationid;
    }

    public Integer getAssetallocationid() {
        return assetallocationid;
    }

    public void setAssetallocationid(Integer assetallocationid) {
        this.assetallocationid = assetallocationid;
    }

    public Integer getQtyallocated() {
        return qtyallocated;
    }

    public void setQtyallocated(Integer qtyallocated) {
        this.qtyallocated = qtyallocated;
    }

    public Integer getAssetcurrentlocation() {
        return assetcurrentlocation;
    }

    public void setAssetcurrentlocation(Integer assetcurrentlocation) {
        this.assetcurrentlocation = assetcurrentlocation;
    }

    public Integer getAssetoldlocation() {
        return assetoldlocation;
    }

    public void setAssetoldlocation(Integer assetoldlocation) {
        this.assetoldlocation = assetoldlocation;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Date getDateallocated() {
        return dateallocated;
    }

    public void setDateallocated(Date dateallocated) {
        this.dateallocated = dateallocated;
    }

    public Long getAllocatedby() {
        return allocatedby;
    }

    public void setAllocatedby(Long allocatedby) {
        this.allocatedby = allocatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Long getFacilityassetsid() {
        return facilityassetsid;
    }

    public void setFacilityassetsid(Long facilityassetsid) {
        this.facilityassetsid = facilityassetsid;
    }

    public Integer getBlockroomid() {
        return blockroomid;
    }

    public void setBlockroomid(Integer blockroomid) {
        this.blockroomid = blockroomid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (assetallocationid != null ? assetallocationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Assetallocation)) {
            return false;
        }
        Assetallocation other = (Assetallocation) object;
        if ((this.assetallocationid == null && other.assetallocationid != null) || (this.assetallocationid != null && !this.assetallocationid.equals(other.assetallocationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Assetallocation[ assetallocationid=" + assetallocationid + " ]";
    }

}
