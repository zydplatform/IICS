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
 * @author HP
 */
@Entity
@Table(name = "patientobservation", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientobservation.findAll", query = "SELECT p FROM Patientobservation p")
    , @NamedQuery(name = "Patientobservation.findByPatientobservationid", query = "SELECT p FROM Patientobservation p WHERE p.patientobservationid = :patientobservationid")
    , @NamedQuery(name = "Patientobservation.findByObservation", query = "SELECT p FROM Patientobservation p WHERE p.observation = :observation")
    , @NamedQuery(name = "Patientobservation.findByAddedby", query = "SELECT p FROM Patientobservation p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientobservation.findByDateadded", query = "SELECT p FROM Patientobservation p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientobservation.findByPatientvisitid", query = "SELECT p FROM Patientobservation p WHERE p.patientvisitid = :patientvisitid")})
public class Patientobservation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "patientobservationid", nullable = false)
    private Long patientobservationid;
    @Size(max = 255)
    @Column(name = "observation", length = 255)
    private String observation;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "facilityunitid")
    private Long facilityunitid;

    public Patientobservation() {
    }

    public Patientobservation(Long patientobservationid) {
        this.patientobservationid = patientobservationid;
    }

    public Long getPatientobservationid() {
        return patientobservationid;
    }

    public void setPatientobservationid(Long patientobservationid) {
        this.patientobservationid = patientobservationid;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
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
        hash += (patientobservationid != null ? patientobservationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientobservation)) {
            return false;
        }
        Patientobservation other = (Patientobservation) object;
        if ((this.patientobservationid == null && other.patientobservationid != null) || (this.patientobservationid != null && !this.patientobservationid.equals(other.patientobservationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientobservation[ patientobservationid=" + patientobservationid + " ]";
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

}
