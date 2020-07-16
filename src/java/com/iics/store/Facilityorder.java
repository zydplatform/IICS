/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
 * @author IICS
 */
@Entity
@Table(name = "facilityorder", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityorder.findAll", query = "SELECT f FROM Facilityorder f")
    , @NamedQuery(name = "Facilityorder.findByFacilityorderid", query = "SELECT f FROM Facilityorder f WHERE f.facilityorderid = :facilityorderid")
    , @NamedQuery(name = "Facilityorder.findByOriginstore", query = "SELECT f FROM Facilityorder f WHERE f.originstore = :originstore")
    , @NamedQuery(name = "Facilityorder.findByIsemergency", query = "SELECT f FROM Facilityorder f WHERE f.isemergency = :isemergency")
    , @NamedQuery(name = "Facilityorder.findByPreparedby", query = "SELECT f FROM Facilityorder f WHERE f.preparedby = :preparedby")
    , @NamedQuery(name = "Facilityorder.findByDateprepared", query = "SELECT f FROM Facilityorder f WHERE f.dateprepared = :dateprepared")
    , @NamedQuery(name = "Facilityorder.findByDatepicked", query = "SELECT f FROM Facilityorder f WHERE f.datepicked = :datepicked")
    , @NamedQuery(name = "Facilityorder.findByStatus", query = "SELECT f FROM Facilityorder f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityorder.findByApproved", query = "SELECT f FROM Facilityorder f WHERE f.approved = :approved")
    , @NamedQuery(name = "Facilityorder.findByApprovedby", query = "SELECT f FROM Facilityorder f WHERE f.approvedby = :approvedby")
    , @NamedQuery(name = "Facilityorder.findByExternalfacilityordersid", query = "SELECT f FROM Facilityorder f WHERE f.externalfacilityordersid = :externalfacilityordersid")
    , @NamedQuery(name = "Facilityorder.findByApprovalcomment", query = "SELECT f FROM Facilityorder f WHERE f.approvalcomment = :approvalcomment")
    , @NamedQuery(name = "Facilityorder.findByFacilityorderno", query = "SELECT f FROM Facilityorder f WHERE f.facilityorderno = :facilityorderno")
    , @NamedQuery(name = "Facilityorder.findByDateneeded", query = "SELECT f FROM Facilityorder f WHERE f.dateneeded = :dateneeded")
    , @NamedQuery(name = "Facilityorder.findByOrdertype", query = "SELECT f FROM Facilityorder f WHERE f.ordertype = :ordertype")
    , @NamedQuery(name = "Facilityorder.findByDestinationstore", query = "SELECT f FROM Facilityorder f WHERE f.destinationstore = :destinationstore")})
public class Facilityorder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityorderid", nullable = false)
    private Long facilityorderid;
    @Column(name = "originstore")
    private BigInteger originstore;
    @Column(name = "isemergency")
    private Boolean isemergency;
    @Column(name = "preparedby")
    private BigInteger preparedby;
    @Column(name = "dateprepared")
    @Temporal(TemporalType.DATE)
    private Date dateprepared;
    @Column(name = "datepicked")
    @Temporal(TemporalType.DATE)
    private Date datepicked;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Column(name = "approved")
    private Boolean approved;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @Column(name = "externalfacilityordersid")
    private Integer externalfacilityordersid;
    @Size(max = 255)
    @Column(name = "approvalcomment", length = 255)
    private String approvalcomment;
    @Size(max = 2147483647)
    @Column(name = "facilityorderno", length = 2147483647)
    private String facilityorderno;
    @Column(name = "dateneeded")
    @Temporal(TemporalType.DATE)
    private Date dateneeded;
    @Column(name = "ordertype", length = 2147483647)
    private String ordertype;
    @Column(name = "destinationstore")
    private BigInteger destinationstore;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @Column(name = "taken")
    private Boolean taken;
    @Column(name = "datetaken")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date datetaken;

    public Facilityorder() {
    }

    public Facilityorder(Long facilityorderid) {
        this.facilityorderid = facilityorderid;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public Long getFacilityorderid() {
        return facilityorderid;
    }

    public void setFacilityorderid(Long facilityorderid) {
        this.facilityorderid = facilityorderid;
    }

    public BigInteger getOriginstore() {
        return originstore;
    }

    public void setOriginstore(BigInteger originstore) {
        this.originstore = originstore;
    }

    public Boolean getIsemergency() {
        return isemergency;
    }

    public void setIsemergency(Boolean isemergency) {
        this.isemergency = isemergency;
    }

    public BigInteger getPreparedby() {
        return preparedby;
    }

    public void setPreparedby(BigInteger preparedby) {
        this.preparedby = preparedby;
    }

    public Date getDateprepared() {
        return dateprepared;
    }

    public void setDateprepared(Date dateprepared) {
        this.dateprepared = dateprepared;
    }

    public Date getDatepicked() {
        return datepicked;
    }

    public void setDatepicked(Date datepicked) {
        this.datepicked = datepicked;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getApproved() {
        return approved;
    }

    public void setApproved(Boolean approved) {
        this.approved = approved;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
    }

    public Integer getExternalfacilityordersid() {
        return externalfacilityordersid;
    }

    public void setExternalfacilityordersid(Integer externalfacilityordersid) {
        this.externalfacilityordersid = externalfacilityordersid;
    }

    public String getApprovalcomment() {
        return approvalcomment;
    }

    public void setApprovalcomment(String approvalcomment) {
        this.approvalcomment = approvalcomment;
    }

    public String getFacilityorderno() {
        return facilityorderno;
    }

    public void setFacilityorderno(String facilityorderno) {
        this.facilityorderno = facilityorderno;
    }

    public Date getDateneeded() {
        return dateneeded;
    }

    public void setDateneeded(Date dateneeded) {
        this.dateneeded = dateneeded;
    }

    public String getOrdertype() {
        return ordertype;
    }

    public void setOrdertype(String ordertype) {
        this.ordertype = ordertype;
    }

    public BigInteger getDestinationstore() {
        return destinationstore;
    }

    public void setDestinationstore(BigInteger destinationstore) {
        this.destinationstore = destinationstore;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityorderid != null ? facilityorderid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityorder)) {
            return false;
        }
        Facilityorder other = (Facilityorder) object;
        if ((this.facilityorderid == null && other.facilityorderid != null) || (this.facilityorderid != null && !this.facilityorderid.equals(other.facilityorderid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilityorder[ facilityorderid=" + facilityorderid + " ]";
    }

    public Boolean getTaken() {
        return taken;
    }

    public void setTaken(Boolean taken) {
        this.taken = taken;
    }

    public Date getDatetaken() {
        return datetaken;
    }

    public void setDatetaken(Date datetaken) {
        this.datetaken = datetaken;
    }
}
