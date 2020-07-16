/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
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
 * @author IICS
 */
@Entity
@Table(name = "unservicedprescriptionitemsreasons", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unservicedprescriptionitemsreasons.findAll", query = "SELECT u FROM Unservicedprescriptionitemsreasons u")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByReasonid", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.reasonid = :reasonid")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByReason", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.reason = :reason")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByAddedby", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.addedby = :addedby")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByDateadded", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.dateadded = :dateadded")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByUpdatedby", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.updatedby = :updatedby")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByDateupdated", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.dateupdated = :dateupdated")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByNewprescriptionitemsid", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Unservicedprescriptionitemsreasons.findByPrescriptionid", query = "SELECT u FROM Unservicedprescriptionitemsreasons u WHERE u.prescriptionid = :prescriptionid")})
public class Unservicedprescriptionitemsreasons implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "reasonid")
    private Long reasonid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "reason")
    private String reason;
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
    @Column(name = "updatedby")
    private long updatedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Basic(optional = false)
    @NotNull
    @Column(name = "newprescriptionitemsid")
    private long newprescriptionitemsid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Unservicedprescriptionitemsreasons() {
    }

    public Unservicedprescriptionitemsreasons(Long reasonid) {
        this.reasonid = reasonid;
    }

    public Unservicedprescriptionitemsreasons(Long reasonid, String reason, long addedby, Date dateadded, long updatedby, Date dateupdated, long newprescriptionitemsid, long prescriptionid) {
        this.reasonid = reasonid;
        this.reason = reason;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.updatedby = updatedby;
        this.dateupdated = dateupdated;
        this.newprescriptionitemsid = newprescriptionitemsid;
        this.prescriptionid = prescriptionid;
    }

    public Long getReasonid() {
        return reasonid;
    }

    public void setReasonid(Long reasonid) {
        this.reasonid = reasonid;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

    public long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public long getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(long newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
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
        hash += (reasonid != null ? reasonid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Unservicedprescriptionitemsreasons)) {
            return false;
        }
        Unservicedprescriptionitemsreasons other = (Unservicedprescriptionitemsreasons) object;
        if ((this.reasonid == null && other.reasonid != null) || (this.reasonid != null && !this.reasonid.equals(other.reasonid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Unservicedprescriptionitemsreasons[ reasonid=" + reasonid + " ]";
    }
    
}
