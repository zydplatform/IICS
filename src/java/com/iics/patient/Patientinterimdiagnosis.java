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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "patientinterimdiagnosis", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientinterimdiagnosis.findAll", query = "SELECT p FROM Patientinterimdiagnosis p")
    , @NamedQuery(name = "Patientinterimdiagnosis.findByDiagnosisid", query = "SELECT p FROM Patientinterimdiagnosis p WHERE p.diagnosisid = :diagnosisid")
    , @NamedQuery(name = "Patientinterimdiagnosis.findByInterimdiagnosis", query = "SELECT p FROM Patientinterimdiagnosis p WHERE p.interimdiagnosis = :interimdiagnosis")
    , @NamedQuery(name = "Patientinterimdiagnosis.findByDateadded", query = "SELECT p FROM Patientinterimdiagnosis p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientinterimdiagnosis.findByFacilityunitid", query = "SELECT p FROM Patientinterimdiagnosis p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Patientinterimdiagnosis.findByAddedby", query = "SELECT p FROM Patientinterimdiagnosis p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientinterimdiagnosis.findByPatientvisitid", query = "SELECT p FROM Patientinterimdiagnosis p WHERE p.patientvisitid = :patientvisitid")})
public class Patientinterimdiagnosis implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "diagnosisid")
    private Long diagnosisid;
    @Size(max = 256)
    @Column(name = "interimdiagnosis")
    private String interimdiagnosis;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;

    public Patientinterimdiagnosis() {
    }

    public Patientinterimdiagnosis(Long diagnosisid) {
        this.diagnosisid = diagnosisid;
    }

    public Long getDiagnosisid() {
        return diagnosisid;
    }

    public void setDiagnosisid(Long diagnosisid) {
        this.diagnosisid = diagnosisid;
    }

    public String getInterimdiagnosis() {
        return interimdiagnosis;
    }

    public void setInterimdiagnosis(String interimdiagnosis) {
        this.interimdiagnosis = interimdiagnosis;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
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

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (diagnosisid != null ? diagnosisid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientinterimdiagnosis)) {
            return false;
        }
        Patientinterimdiagnosis other = (Patientinterimdiagnosis) object;
        if ((this.diagnosisid == null && other.diagnosisid != null) || (this.diagnosisid != null && !this.diagnosisid.equals(other.diagnosisid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientinterimdiagnosis[ diagnosisid=" + diagnosisid + " ]";
    }
    
}
