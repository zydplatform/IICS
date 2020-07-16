/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "servicedprescriptions", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicedprescriptions.findAll", query = "SELECT s FROM Servicedprescriptions s")
    , @NamedQuery(name = "Servicedprescriptions.findByServicedprescriptionid", query = "SELECT s FROM Servicedprescriptions s WHERE s.servicedprescriptionid = :servicedprescriptionid")
    , @NamedQuery(name = "Servicedprescriptions.findByIssueditems", query = "SELECT s FROM Servicedprescriptions s WHERE s.issueditems = :issueditems")
    , @NamedQuery(name = "Servicedprescriptions.findByNotissueditems", query = "SELECT s FROM Servicedprescriptions s WHERE s.notissueditems = :notissueditems")
    , @NamedQuery(name = "Servicedprescriptions.findByAddedby", query = "SELECT s FROM Servicedprescriptions s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Servicedprescriptions.findByDateadded", query = "SELECT s FROM Servicedprescriptions s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Servicedprescriptions.findByPrescriptionid", query = "SELECT s FROM Servicedprescriptions s WHERE s.prescriptionid = :prescriptionid")})
public class Servicedprescriptions implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "servicedprescriptionid")
    private Long servicedprescriptionid;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Column(name = "issueditems")
    private BigDecimal issueditems;
    @Basic(optional = false)
    @NotNull
    @Column(name = "notissueditems")
    private BigDecimal notissueditems;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Servicedprescriptions() {
    }

    public Servicedprescriptions(Long servicedprescriptionid) {
        this.servicedprescriptionid = servicedprescriptionid;
    }

    public Servicedprescriptions(Long servicedprescriptionid, BigDecimal issueditems, BigDecimal notissueditems, long addedby, Date dateadded, long prescriptionid) {
        this.servicedprescriptionid = servicedprescriptionid;
        this.issueditems = issueditems;
        this.notissueditems = notissueditems;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.prescriptionid = prescriptionid;
    }

    public Long getServicedprescriptionid() {
        return servicedprescriptionid;
    }

    public void setServicedprescriptionid(Long servicedprescriptionid) {
        this.servicedprescriptionid = servicedprescriptionid;
    }

    public BigDecimal getIssueditems() {
        return issueditems;
    }

    public void setIssueditems(BigDecimal issueditems) {
        this.issueditems = issueditems;
    }

    public BigDecimal getNotissueditems() {
        return notissueditems;
    }

    public void setNotissueditems(BigDecimal notissueditems) {
        this.notissueditems = notissueditems;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public long getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(long prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (servicedprescriptionid != null ? servicedprescriptionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Servicedprescriptions)) {
            return false;
        }
        Servicedprescriptions other = (Servicedprescriptions) object;
        if ((this.servicedprescriptionid == null && other.servicedprescriptionid != null) || (this.servicedprescriptionid != null && !this.servicedprescriptionid.equals(other.servicedprescriptionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Servicedprescriptions[ servicedprescriptionid=" + servicedprescriptionid + " ]";
    }
    
}
