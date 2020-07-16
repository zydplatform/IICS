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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "suppliesorder", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Suppliesorder.findAll", query = "SELECT s FROM Suppliesorder s")
    , @NamedQuery(name = "Suppliesorder.findBySuppliesorderid", query = "SELECT s FROM Suppliesorder s WHERE s.suppliesorderid = :suppliesorderid")
    , @NamedQuery(name = "Suppliesorder.findByFacilityunitid", query = "SELECT s FROM Suppliesorder s WHERE s.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Suppliesorder.findByIsemergency", query = "SELECT s FROM Suppliesorder s WHERE s.isemergency = :isemergency")
    , @NamedQuery(name = "Suppliesorder.findByRequestedby", query = "SELECT s FROM Suppliesorder s WHERE s.requestedby = :requestedby")
    , @NamedQuery(name = "Suppliesorder.findByDaterequested", query = "SELECT s FROM Suppliesorder s WHERE s.daterequested = :daterequested")
    , @NamedQuery(name = "Suppliesorder.findByStatus", query = "SELECT s FROM Suppliesorder s WHERE s.status = :status")
    , @NamedQuery(name = "Suppliesorder.findByOrderno", query = "SELECT s FROM Suppliesorder s WHERE s.orderno = :orderno")
    , @NamedQuery(name = "Suppliesorder.findByDateissued", query = "SELECT s FROM Suppliesorder s WHERE s.dateissued = :dateissued")
    , @NamedQuery(name = "Suppliesorder.findByIssuedby", query = "SELECT s FROM Suppliesorder s WHERE s.issuedby = :issuedby")
    , @NamedQuery(name = "Suppliesorder.findByApprovedby", query = "SELECT s FROM Suppliesorder s WHERE s.approvedby = :approvedby")
    , @NamedQuery(name = "Suppliesorder.findByDateapproved", query = "SELECT s FROM Suppliesorder s WHERE s.dateapproved = :dateapproved")
    , @NamedQuery(name = "Suppliesorder.findByIssuedto", query = "SELECT s FROM Suppliesorder s WHERE s.issuedto = :issuedto")})
public class Suppliesorder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "suppliesorderid", nullable = false)
    private Long suppliesorderid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "isemergency")
    private Boolean isemergency;
    @Column(name = "requestedby")
    private BigInteger requestedby;
    @Column(name = "daterequested")
    @Temporal(TemporalType.DATE)
    private Date daterequested;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Size(max = 255)
    @Column(name = "orderno", length = 255)
    private String orderno;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "issuedby")
    private BigInteger issuedby;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @Column(name = "issuedto")
    private BigInteger issuedto;
    @Column(name = "addedby")
    private BigInteger addedby;

    public Suppliesorder() {
    }

    public Suppliesorder(Long suppliesorderid) {
        this.suppliesorderid = suppliesorderid;
    }

    public Long getSuppliesorderid() {
        return suppliesorderid;
    }

    public void setSuppliesorderid(Long suppliesorderid) {
        this.suppliesorderid = suppliesorderid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Boolean getIsemergency() {
        return isemergency;
    }

    public void setIsemergency(Boolean isemergency) {
        this.isemergency = isemergency;
    }

    public BigInteger getRequestedby() {
        return requestedby;
    }

    public void setRequestedby(BigInteger requestedby) {
        this.requestedby = requestedby;
    }

    public Date getDaterequested() {
        return daterequested;
    }

    public void setDaterequested(Date daterequested) {
        this.daterequested = daterequested;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrderno() {
        return orderno;
    }

    public void setOrderno(String orderno) {
        this.orderno = orderno;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public BigInteger getIssuedby() {
        return issuedby;
    }

    public void setIssuedby(BigInteger issuedby) {
        this.issuedby = issuedby;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public BigInteger getIssuedto() {
        return issuedto;
    }

    public void setIssuedto(BigInteger issuedto) {
        this.issuedto = issuedto;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (suppliesorderid != null ? suppliesorderid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Suppliesorder)) {
            return false;
        }
        Suppliesorder other = (Suppliesorder) object;
        if ((this.suppliesorderid == null && other.suppliesorderid != null) || (this.suppliesorderid != null && !this.suppliesorderid.equals(other.suppliesorderid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Suppliesorder[ suppliesorderid=" + suppliesorderid + " ]";
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }
    
}
