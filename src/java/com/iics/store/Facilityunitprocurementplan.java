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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "facilityunitprocurementplan", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitprocurementplan.findAll", query = "SELECT f FROM Facilityunitprocurementplan f")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByFacilityunitprocurementplanid", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.facilityunitprocurementplanid = :facilityunitprocurementplanid")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByAddedby", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByAverageannualcomsumption", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.averageannualcomsumption = :averageannualcomsumption")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByAveragemonthlyconsumption", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.averagemonthlyconsumption = :averagemonthlyconsumption")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByApproved", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.approved = :approved")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByApprovalcomment", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.approvalcomment = :approvalcomment")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByStatus", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByDateadded", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByLastupdated", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.lastupdated = :lastupdated")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByLastupdatedby", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Facilityunitprocurementplan.findByAveragequarterconsumption", query = "SELECT f FROM Facilityunitprocurementplan f WHERE f.averagequarterconsumption = :averagequarterconsumption")})
public class Facilityunitprocurementplan implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityunitprocurementplanid", nullable = false)
    private Integer facilityunitprocurementplanid;
    @Column(name = "addedby")
    private BigInteger addedby;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "averageannualcomsumption", precision = 17, scale = 17)
    private Double averageannualcomsumption;
    @Column(name = "averagemonthlyconsumption", precision = 17, scale = 17)
    private Double averagemonthlyconsumption;
    @Column(name = "approved")
    private Boolean approved;
    @Size(max = 2147483647)
    @Column(name = "approvalcomment", length = 2147483647)
    private String approvalcomment;
    @Size(max = 2147483647)
    @Column(name = "status", length = 2147483647)
    private String status;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @Column(name = "averagequarterconsumption", precision = 17, scale = 17)
    private Double averagequarterconsumption;
    @JoinColumn(name = "facilityunitfinancialyearid", referencedColumnName = "facilityunitfinancialyearid")
    @ManyToOne
    private Facilityunitfinancialyear facilityunitfinancialyearid;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;

    public Facilityunitprocurementplan() {
    }

    public Facilityunitprocurementplan(Integer facilityunitprocurementplanid) {
        this.facilityunitprocurementplanid = facilityunitprocurementplanid;
    }

    public Integer getFacilityunitprocurementplanid() {
        return facilityunitprocurementplanid;
    }

    public void setFacilityunitprocurementplanid(Integer facilityunitprocurementplanid) {
        this.facilityunitprocurementplanid = facilityunitprocurementplanid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Double getAverageannualcomsumption() {
        return averageannualcomsumption;
    }

    public void setAverageannualcomsumption(Double averageannualcomsumption) {
        this.averageannualcomsumption = averageannualcomsumption;
    }

    public Double getAveragemonthlyconsumption() {
        return averagemonthlyconsumption;
    }

    public void setAveragemonthlyconsumption(Double averagemonthlyconsumption) {
        this.averagemonthlyconsumption = averagemonthlyconsumption;
    }

    public Boolean getApproved() {
        return approved;
    }

    public void setApproved(Boolean approved) {
        this.approved = approved;
    }

    public String getApprovalcomment() {
        return approvalcomment;
    }

    public void setApprovalcomment(String approvalcomment) {
        this.approvalcomment = approvalcomment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Double getAveragequarterconsumption() {
        return averagequarterconsumption;
    }

    public void setAveragequarterconsumption(Double averagequarterconsumption) {
        this.averagequarterconsumption = averagequarterconsumption;
    }

    public Facilityunitfinancialyear getFacilityunitfinancialyearid() {
        return facilityunitfinancialyearid;
    }

    public void setFacilityunitfinancialyearid(Facilityunitfinancialyear facilityunitfinancialyearid) {
        this.facilityunitfinancialyearid = facilityunitfinancialyearid;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitprocurementplanid != null ? facilityunitprocurementplanid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitprocurementplan)) {
            return false;
        }
        Facilityunitprocurementplan other = (Facilityunitprocurementplan) object;
        if ((this.facilityunitprocurementplanid == null && other.facilityunitprocurementplanid != null) || (this.facilityunitprocurementplanid != null && !this.facilityunitprocurementplanid.equals(other.facilityunitprocurementplanid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilityunitprocurementplan[ facilityunitprocurementplanid=" + facilityunitprocurementplanid + " ]";
    }
    
}
