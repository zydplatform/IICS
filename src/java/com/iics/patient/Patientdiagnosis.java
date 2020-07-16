/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patientdiagnosis", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientdiagnosis.findAll", query = "SELECT p FROM Patientdiagnosis p")
    , @NamedQuery(name = "Patientdiagnosis.findByPatientdiagnosisid", query = "SELECT p FROM Patientdiagnosis p WHERE p.patientdiagnosisid = :patientdiagnosisid")
    , @NamedQuery(name = "Patientdiagnosis.findByDiseaseid", query = "SELECT p FROM Patientdiagnosis p WHERE p.diseaseid = :diseaseid")
    , @NamedQuery(name = "Patientdiagnosis.findByPatientvisitid", query = "SELECT p FROM Patientdiagnosis p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Patientdiagnosis.findByIsconfirmed", query = "SELECT p FROM Patientdiagnosis p WHERE p.isconfirmed = :isconfirmed")
    , @NamedQuery(name = "Patientdiagnosis.findByDateadded", query = "SELECT p FROM Patientdiagnosis p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientdiagnosis.findByAddedby", query = "SELECT p FROM Patientdiagnosis p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientdiagnosis.findByRank", query = "SELECT p FROM Patientdiagnosis p WHERE p.rank = :rank")
    , @NamedQuery(name = "Patientdiagnosis.findByLastupdated", query = "SELECT p FROM Patientdiagnosis p WHERE p.lastupdated = :lastupdated")
    , @NamedQuery(name = "Patientdiagnosis.findByLastupdatedby", query = "SELECT p FROM Patientdiagnosis p WHERE p.lastupdatedby = :lastupdatedby")})
public class Patientdiagnosis implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "patientdiagnosisid", nullable = false)
    private Long patientdiagnosisid;
    @Column(name = "diseaseid")
    private BigInteger diseaseid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "isconfirmed")
    private Boolean isconfirmed;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "rank")
    private Integer rank;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;

    public Patientdiagnosis() {
    }

    public Patientdiagnosis(Long patientdiagnosisid) {
        this.patientdiagnosisid = patientdiagnosisid;
    }

    public Long getPatientdiagnosisid() {
        return patientdiagnosisid;
    }

    public void setPatientdiagnosisid(Long patientdiagnosisid) {
        this.patientdiagnosisid = patientdiagnosisid;
    }

    public BigInteger getDiseaseid() {
        return diseaseid;
    }

    public void setDiseaseid(BigInteger diseaseid) {
        this.diseaseid = diseaseid;
    }

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public Boolean getIsconfirmed() {
        return isconfirmed;
    }

    public void setIsconfirmed(Boolean isconfirmed) {
        this.isconfirmed = isconfirmed;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (patientdiagnosisid != null ? patientdiagnosisid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientdiagnosis)) {
            return false;
        }
        Patientdiagnosis other = (Patientdiagnosis) object;
        if ((this.patientdiagnosisid == null && other.patientdiagnosisid != null) || (this.patientdiagnosisid != null && !this.patientdiagnosisid.equals(other.patientdiagnosisid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientdiagnosis[ patientdiagnosisid=" + patientdiagnosisid + " ]";
    }
    
}
