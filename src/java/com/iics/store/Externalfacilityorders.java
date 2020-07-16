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
@Table(name = "externalfacilityorders", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Externalfacilityorders.findAll", query = "SELECT e FROM Externalfacilityorders e")
    , @NamedQuery(name = "Externalfacilityorders.findByExternalfacilityordersid", query = "SELECT e FROM Externalfacilityorders e WHERE e.externalfacilityordersid = :externalfacilityordersid")
    , @NamedQuery(name = "Externalfacilityorders.findByNeworderno", query = "SELECT e FROM Externalfacilityorders e WHERE e.neworderno = :neworderno")
    , @NamedQuery(name = "Externalfacilityorders.findByApprovalstartdate", query = "SELECT e FROM Externalfacilityorders e WHERE e.approvalstartdate = :approvalstartdate")
    , @NamedQuery(name = "Externalfacilityorders.findByApprovalenddate", query = "SELECT e FROM Externalfacilityorders e WHERE e.approvalenddate = :approvalenddate")
    , @NamedQuery(name = "Externalfacilityorders.findByOrderingstart", query = "SELECT e FROM Externalfacilityorders e WHERE e.orderingstart = :orderingstart")
    , @NamedQuery(name = "Externalfacilityorders.findByOrderingenddate", query = "SELECT e FROM Externalfacilityorders e WHERE e.orderingenddate = :orderingenddate")
    , @NamedQuery(name = "Externalfacilityorders.findByApprovedby", query = "SELECT e FROM Externalfacilityorders e WHERE e.approvedby = :approvedby")
    , @NamedQuery(name = "Externalfacilityorders.findByOrderstatus", query = "SELECT e FROM Externalfacilityorders e WHERE e.orderstatus = :orderstatus")
    , @NamedQuery(name = "Externalfacilityorders.findByDateapproved", query = "SELECT e FROM Externalfacilityorders e WHERE e.dateapproved = :dateapproved")
    , @NamedQuery(name = "Externalfacilityorders.findByIsactive", query = "SELECT e FROM Externalfacilityorders e WHERE e.isactive = :isactive")
    , @NamedQuery(name = "Externalfacilityorders.findByFacilityid", query = "SELECT e FROM Externalfacilityorders e WHERE e.facilityid = :facilityid")})
public class Externalfacilityorders implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "externalfacilityordersid", nullable = false)
    private Integer externalfacilityordersid;
    @Size(max = 2147483647)
    @Column(name = "neworderno", length = 2147483647)
    private String neworderno;
    @Column(name = "approvalstartdate")
    @Temporal(TemporalType.DATE)
    private Date approvalstartdate;
    @Column(name = "approvalenddate")
    @Temporal(TemporalType.DATE)
    private Date approvalenddate;
    @Column(name = "orderingstart")
    @Temporal(TemporalType.DATE)
    private Date orderingstart;
    @Column(name = "orderingenddate")
    @Temporal(TemporalType.DATE)
    private Date orderingenddate;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @Size(max = 2147483647)
    @Column(name = "orderstatus", length = 2147483647)
    private String orderstatus;
    @Column(name = "isactive", length = 2147483647)
    private Boolean isactive;
     @Column(name = "facilityid")
    private Integer facilityid;
     @Column(name = "supplierid")
    private Long supplierid;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @OneToMany(mappedBy = "externalfacilityordersid")
    private List<Facilityorder> facilityorderList;

    public Externalfacilityorders() {
    }

    public Externalfacilityorders(Integer externalfacilityordersid) {
        this.externalfacilityordersid = externalfacilityordersid;
    }

    public Integer getExternalfacilityordersid() {
        return externalfacilityordersid;
    }

    public void setExternalfacilityordersid(Integer externalfacilityordersid) {
        this.externalfacilityordersid = externalfacilityordersid;
    }

    public String getNeworderno() {
        return neworderno;
    }

    public void setNeworderno(String neworderno) {
        this.neworderno = neworderno;
    }

    public Date getApprovalstartdate() {
        return approvalstartdate;
    }

    public void setApprovalstartdate(Date approvalstartdate) {
        this.approvalstartdate = approvalstartdate;
    }

    public Date getApprovalenddate() {
        return approvalenddate;
    }

    public void setApprovalenddate(Date approvalenddate) {
        this.approvalenddate = approvalenddate;
    }

    public Date getOrderingstart() {
        return orderingstart;
    }

    public void setOrderingstart(Date orderingstart) {
        this.orderingstart = orderingstart;
    }

    public Date getOrderingenddate() {
        return orderingenddate;
    }

    public void setOrderingenddate(Date orderingenddate) {
        this.orderingenddate = orderingenddate;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
    }

    public String getOrderstatus() {
        return orderstatus;
    }

    public void setOrderstatus(String orderstatus) {
        this.orderstatus = orderstatus;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Long getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(Long supplierid) {
        this.supplierid = supplierid;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    @XmlTransient
    public List<Facilityorder> getFacilityorderList() {
        return facilityorderList;
    }

    public void setFacilityorderList(List<Facilityorder> facilityorderList) {
        this.facilityorderList = facilityorderList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (externalfacilityordersid != null ? externalfacilityordersid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Externalfacilityorders)) {
            return false;
        }
        Externalfacilityorders other = (Externalfacilityorders) object;
        if ((this.externalfacilityordersid == null && other.externalfacilityordersid != null) || (this.externalfacilityordersid != null && !this.externalfacilityordersid.equals(other.externalfacilityordersid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Externalfacilityorders[ externalfacilityordersid=" + externalfacilityordersid + " ]";
    }

}
