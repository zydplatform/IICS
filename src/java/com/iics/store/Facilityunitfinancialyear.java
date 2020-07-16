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
@Table(name = "facilityunitfinancialyear", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitfinancialyear.findAll", query = "SELECT f FROM Facilityunitfinancialyear f")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByFacilityunitfinancialyearid", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.facilityunitfinancialyearid = :facilityunitfinancialyearid")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByFacilityunitid", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByAddedby", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByProccessingstage", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.proccessingstage = :proccessingstage")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByApprovalcomment", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.approvalcomment = :approvalcomment")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByDateadded", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByLastupdated", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.lastupdated = :lastupdated")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByLastupdatedby", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByFacilityunitlabel", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.facilityunitlabel = :facilityunitlabel")
    , @NamedQuery(name = "Facilityunitfinancialyear.findByConsolidated", query = "SELECT f FROM Facilityunitfinancialyear f WHERE f.consolidated = :consolidated")})
public class Facilityunitfinancialyear implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityunitfinancialyearid", nullable = false)
    private Integer facilityunitfinancialyearid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Size(max = 2147483647)
    @Column(name = "proccessingstage", length = 2147483647)
    private String proccessingstage;
    @Size(max = 2147483647)
    @Column(name = "approvalcomment", length = 2147483647)
    private String approvalcomment;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @Size(max = 2147483647)
    @Column(name = "facilityunitlabel", length = 2147483647)
    private String facilityunitlabel;
    @Column(name = "consolidated")
    private Boolean consolidated;
    @OneToMany(mappedBy = "facilityunitfinancialyearid")
    private List<Facilityunitprocurementplan> facilityunitprocurementplanList;
    @JoinColumn(name = "facilityfinancialyearid", referencedColumnName = "facilityfinancialyearid")
    @ManyToOne
    private Facilityfinancialyear facilityfinancialyearid;
    @JoinColumn(name = "orderperiodid", referencedColumnName = "orderperiodid")
    @ManyToOne
    private Orderperiod orderperiodid;

    public Facilityunitfinancialyear() {
    }

    public Facilityunitfinancialyear(Integer facilityunitfinancialyearid) {
        this.facilityunitfinancialyearid = facilityunitfinancialyearid;
    }

    public Integer getFacilityunitfinancialyearid() {
        return facilityunitfinancialyearid;
    }

    public void setFacilityunitfinancialyearid(Integer facilityunitfinancialyearid) {
        this.facilityunitfinancialyearid = facilityunitfinancialyearid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public String getProccessingstage() {
        return proccessingstage;
    }

    public void setProccessingstage(String proccessingstage) {
        this.proccessingstage = proccessingstage;
    }

    public String getApprovalcomment() {
        return approvalcomment;
    }

    public void setApprovalcomment(String approvalcomment) {
        this.approvalcomment = approvalcomment;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public BigInteger getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(BigInteger lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public String getFacilityunitlabel() {
        return facilityunitlabel;
    }

    public void setFacilityunitlabel(String facilityunitlabel) {
        this.facilityunitlabel = facilityunitlabel;
    }

    public Boolean getConsolidated() {
        return consolidated;
    }

    public void setConsolidated(Boolean consolidated) {
        this.consolidated = consolidated;
    }

    @XmlTransient
    public List<Facilityunitprocurementplan> getFacilityunitprocurementplanList() {
        return facilityunitprocurementplanList;
    }

    public void setFacilityunitprocurementplanList(List<Facilityunitprocurementplan> facilityunitprocurementplanList) {
        this.facilityunitprocurementplanList = facilityunitprocurementplanList;
    }

    public Facilityfinancialyear getFacilityfinancialyearid() {
        return facilityfinancialyearid;
    }

    public void setFacilityfinancialyearid(Facilityfinancialyear facilityfinancialyearid) {
        this.facilityfinancialyearid = facilityfinancialyearid;
    }

    public Orderperiod getOrderperiodid() {
        return orderperiodid;
    }

    public void setOrderperiodid(Orderperiod orderperiodid) {
        this.orderperiodid = orderperiodid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitfinancialyearid != null ? facilityunitfinancialyearid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitfinancialyear)) {
            return false;
        }
        Facilityunitfinancialyear other = (Facilityunitfinancialyear) object;
        if ((this.facilityunitfinancialyearid == null && other.facilityunitfinancialyearid != null) || (this.facilityunitfinancialyearid != null && !this.facilityunitfinancialyearid.equals(other.facilityunitfinancialyearid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilityunitfinancialyear[ facilityunitfinancialyearid=" + facilityunitfinancialyearid + " ]";
    }
    
}
