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
@Table(name = "triagevalidationskip", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Triagevalidationskip.findAll", query = "SELECT t FROM Triagevalidationskip t")
    , @NamedQuery(name = "Triagevalidationskip.findByTriagevalidationskipid", query = "SELECT t FROM Triagevalidationskip t WHERE t.triagevalidationskipid = :triagevalidationskipid")
    , @NamedQuery(name = "Triagevalidationskip.findBySkippedfield", query = "SELECT t FROM Triagevalidationskip t WHERE t.skippedfield = :skippedfield")
    , @NamedQuery(name = "Triagevalidationskip.findByReason", query = "SELECT t FROM Triagevalidationskip t WHERE t.reason = :reason")
    , @NamedQuery(name = "Triagevalidationskip.findByAddedby", query = "SELECT t FROM Triagevalidationskip t WHERE t.addedby = :addedby")
    , @NamedQuery(name = "Triagevalidationskip.findByDateadded", query = "SELECT t FROM Triagevalidationskip t WHERE t.dateadded = :dateadded")
    , @NamedQuery(name = "Triagevalidationskip.findByFacilityunitid", query = "SELECT t FROM Triagevalidationskip t WHERE t.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Triagevalidationskip.findByPatientvisitid", query = "SELECT t FROM Triagevalidationskip t WHERE t.patientvisitid = :patientvisitid")})
public class Triagevalidationskip implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "triagevalidationskipid")
    private Long triagevalidationskipid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "skippedfield")
    private String skippedfield;
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
    @Column(name = "facilityunitid")
    private long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "patientvisitid")
    private long patientvisitid;

    public Triagevalidationskip() {
    }

    public Triagevalidationskip(Long triagevalidationskipid) {
        this.triagevalidationskipid = triagevalidationskipid;
    }

    public Triagevalidationskip(Long triagevalidationskipid, String skippedfield, String reason, long addedby, Date dateadded, long facilityunitid, long patientvisitid) {
        this.triagevalidationskipid = triagevalidationskipid;
        this.skippedfield = skippedfield;
        this.reason = reason;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.facilityunitid = facilityunitid;
        this.patientvisitid = patientvisitid;
    }

    public Long getTriagevalidationskipid() {
        return triagevalidationskipid;
    }

    public void setTriagevalidationskipid(Long triagevalidationskipid) {
        this.triagevalidationskipid = triagevalidationskipid;
    }

    public String getSkippedfield() {
        return skippedfield;
    }

    public void setSkippedfield(String skippedfield) {
        this.skippedfield = skippedfield;
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

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (triagevalidationskipid != null ? triagevalidationskipid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Triagevalidationskip)) {
            return false;
        }
        Triagevalidationskip other = (Triagevalidationskip) object;
        if ((this.triagevalidationskipid == null && other.triagevalidationskipid != null) || (this.triagevalidationskipid != null && !this.triagevalidationskipid.equals(other.triagevalidationskipid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Triagevalidationskip[ triagevalidationskipid=" + triagevalidationskipid + " ]";
    }
    
}
