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
 * @author HP
 */
@Entity
@Table(name = "prescription", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescription.findAll", query = "SELECT p FROM Prescription p")
    , @NamedQuery(name = "Prescription.findByPrescriptionid", query = "SELECT p FROM Prescription p WHERE p.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Prescription.findByDateprescribed", query = "SELECT p FROM Prescription p WHERE p.dateprescribed = :dateprescribed")
    , @NamedQuery(name = "Prescription.findByAddedby", query = "SELECT p FROM Prescription p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Prescription.findByLastupdatedby", query = "SELECT p FROM Prescription p WHERE p.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Prescription.findByLastupdated", query = "SELECT p FROM Prescription p WHERE p.lastupdated = :lastupdated")
    , @NamedQuery(name = "Prescription.findByOriginunitid", query = "SELECT p FROM Prescription p WHERE p.originunitid = :originunitid")
    , @NamedQuery(name = "Prescription.findByDestinationunitid", query = "SELECT p FROM Prescription p WHERE p.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Prescription.findByReferencenumber", query = "SELECT p FROM Prescription p WHERE p.referencenumber = :referencenumber")})
public class Prescription implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prescriptionid", nullable = false)
    private Long prescriptionid;
    @Column(name = "dateprescribed")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateprescribed;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "originunitid")
    private Long originunitid;
    @Column(name = "destinationunitid")
    private Long destinationunitid;
    @Column(name = "approvedby")
    private Long approvedby;
    @Column(name = "status")
    private String status;
    @Column(name = "dateapproved")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date dateapproved;
    @Column(name = "dateissued")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date dateissued;

    @Column(name = "patientvisitid")
    private Long patientvisitid;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "referencenumber")
    private String referencenumber;
    
    public Prescription() {

    }

    public Prescription(Long prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public Long getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(Long prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public Date getDateprescribed() {
        return dateprescribed;
    }

    public void setDateprescribed(Date dateprescribed) {
        this.dateprescribed = dateprescribed;
    }

    public Long getAddedby() {
        return addedby;
    }

    public Long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Long lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public Long getOriginunitid() {
        return originunitid;
    }

    public void setOriginunitid(Long originunitid) {
        this.originunitid = originunitid;
    }

    public Long getDestinationunitid() {
        return destinationunitid;
    }

    public void setDestinationunitid(Long destinationunitid) {
        this.destinationunitid = destinationunitid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (prescriptionid != null ? prescriptionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prescription)) {
            return false;
        }
        Prescription other = (Prescription) object;
        if ((this.prescriptionid == null && other.prescriptionid != null) || (this.prescriptionid != null && !this.prescriptionid.equals(other.prescriptionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Prescription[ prescriptionid=" + prescriptionid + " ]";
    }

    public Long getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(Long approvedby) {
        this.approvedby = approvedby;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }
    public String getReferencenumber() {
        return referencenumber;
    }

    public void setReferencenumber(String referencenumber) {
        this.referencenumber = referencenumber;
    }
}
