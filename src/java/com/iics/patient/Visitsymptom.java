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
@Table(name = "visitsymptom", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Visitsymptom.findAll", query = "SELECT v FROM Visitsymptom v")
    , @NamedQuery(name = "Visitsymptom.findByVisitsymptomid", query = "SELECT v FROM Visitsymptom v WHERE v.visitsymptomid = :visitsymptomid")
    , @NamedQuery(name = "Visitsymptom.findBySymptomid", query = "SELECT v FROM Visitsymptom v WHERE v.symptomid = :symptomid")
    , @NamedQuery(name = "Visitsymptom.findByPatientvisitid", query = "SELECT v FROM Visitsymptom v WHERE v.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Visitsymptom.findByDateadded", query = "SELECT v FROM Visitsymptom v WHERE v.dateadded = :dateadded")
    , @NamedQuery(name = "Visitsymptom.findByAddedby", query = "SELECT v FROM Visitsymptom v WHERE v.addedby = :addedby")})
public class Visitsymptom implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "visitsymptomid", nullable = false)
    private Long visitsymptomid;
    @Column(name = "symptomid")
    private BigInteger symptomid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;

    public Visitsymptom() {
    }

    public Visitsymptom(Long visitsymptomid) {
        this.visitsymptomid = visitsymptomid;
    }

    public Long getVisitsymptomid() {
        return visitsymptomid;
    }

    public void setVisitsymptomid(Long visitsymptomid) {
        this.visitsymptomid = visitsymptomid;
    }

    public BigInteger getSymptomid() {
        return symptomid;
    }

    public void setSymptomid(BigInteger symptomid) {
        this.symptomid = symptomid;
    }

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (visitsymptomid != null ? visitsymptomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Visitsymptom)) {
            return false;
        }
        Visitsymptom other = (Visitsymptom) object;
        if ((this.visitsymptomid == null && other.visitsymptomid != null) || (this.visitsymptomid != null && !this.visitsymptomid.equals(other.visitsymptomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Visitsymptom[ visitsymptomid=" + visitsymptomid + " ]";
    }
    
}
