/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "package", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Package.findAll", query = "SELECT p FROM Package p")
    , @NamedQuery(name = "Package.findByPackageid", query = "SELECT p FROM Package p WHERE p.packageid = :packageid")
    , @NamedQuery(name = "Package.findByPacketno", query = "SELECT p FROM Package p WHERE p.packetno = :packetno")
    , @NamedQuery(name = "Package.findByEachpacket", query = "SELECT p FROM Package p WHERE p.eachpacket = :eachpacket")
    , @NamedQuery(name = "Package.findByStatus", query = "SELECT p FROM Package p WHERE p.status = :status")
    , @NamedQuery(name = "Package.findByDatecreated", query = "SELECT p FROM Package p WHERE p.datecreated = :datecreated")
    , @NamedQuery(name = "Package.findByCreatedby", query = "SELECT p FROM Package p WHERE p.createdby = :createdby")
    , @NamedQuery(name = "Package.findByUpdatedby", query = "SELECT p FROM Package p WHERE p.updatedby = :updatedby")
    , @NamedQuery(name = "Package.findByDateupdated", query = "SELECT p FROM Package p WHERE p.dateupdated = :dateupdated")
    , @NamedQuery(name = "Package.findByTotalqtypicked", query = "SELECT p FROM Package p WHERE p.totalqtypicked = :totalqtypicked")
    , @NamedQuery(name = "Package.findByFacilityunitid", query = "SELECT p FROM Package p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Package.findByStockid", query = "SELECT p FROM Package p WHERE p.stockid = :stockid")})
public class Package implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "packageid")
    private Integer packageid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "packetno")
    private int packetno;
    @Basic(optional = false)
    @NotNull
    @Column(name = "eachpacket")
    private int eachpacket;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "status")
    private String status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "datecreated")
    @Temporal(TemporalType.DATE)
    private Date datecreated;
    @Basic(optional = false)
    @NotNull
    @Column(name = "createdby")
    private long createdby;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Basic(optional = false)
    @NotNull
    @Column(name = "totalqtypicked")
    private int totalqtypicked;
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitid")
    private long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "stockid")
    private long stockid;

    public Package() {
    }

    public Package(Integer packageid) {
        this.packageid = packageid;
    }

    public Package(Integer packageid, int packetno, int eachpacket, String status, Date datecreated, long createdby, int totalqtypicked, long facilityunitid, long stockid) {
        this.packageid = packageid;
        this.packetno = packetno;
        this.eachpacket = eachpacket;
        this.status = status;
        this.datecreated = datecreated;
        this.createdby = createdby;
        this.totalqtypicked = totalqtypicked;
        this.facilityunitid = facilityunitid;
        this.stockid = stockid;
    }

    public Integer getPackageid() {
        return packageid;
    }

    public void setPackageid(Integer packageid) {
        this.packageid = packageid;
    }

    public int getPacketno() {
        return packetno;
    }

    public void setPacketno(int packetno) {
        this.packetno = packetno;
    }

    public int getEachpacket() {
        return eachpacket;
    }

    public void setEachpacket(int eachpacket) {
        this.eachpacket = eachpacket;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public long getCreatedby() {
        return createdby;
    }

    public void setCreatedby(long createdby) {
        this.createdby = createdby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public int getTotalqtypicked() {
        return totalqtypicked;
    }

    public void setTotalqtypicked(int totalqtypicked) {
        this.totalqtypicked = totalqtypicked;
    }

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public long getStockid() {
        return stockid;
    }

    public void setStockid(long stockid) {
        this.stockid = stockid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (packageid != null ? packageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Package)) {
            return false;
        }
        Package other = (Package) object;
        if ((this.packageid == null && other.packageid != null) || (this.packageid != null && !this.packageid.equals(other.packageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Package[ packageid=" + packageid + " ]";
    }
    
}
