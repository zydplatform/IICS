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
@Table(name = "patientcomplaint", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientcomplaint.findAll", query = "SELECT p FROM Patientcomplaint p")
    , @NamedQuery(name = "Patientcomplaint.findByPatientcomplaintid", query = "SELECT p FROM Patientcomplaint p WHERE p.patientcomplaintid = :patientcomplaintid")
    , @NamedQuery(name = "Patientcomplaint.findByPatientcomplaint", query = "SELECT p FROM Patientcomplaint p WHERE p.patientcomplaint = :patientcomplaint")
    , @NamedQuery(name = "Patientcomplaint.findByDescription", query = "SELECT p FROM Patientcomplaint p WHERE p.description = :description")
    , @NamedQuery(name = "Patientcomplaint.findByAddedby", query = "SELECT p FROM Patientcomplaint p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientcomplaint.findByDateadded", query = "SELECT p FROM Patientcomplaint p WHERE p.dateadded = :dateadded")})
public class Patientcomplaint implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "patientcomplaintid", nullable = false)
    private Long patientcomplaintid;
    @Size(max = 255)
    @Column(name = "patientcomplaint", length = 255)
    private String patientcomplaint;
    @Size(max = 255)
    @Column(name = "description", length = 255)
    private String description;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "patientvisitid")
    private Long patientvisitid;
    @Column(name = "facilityunitid")
    private Long facilityunitid;

    public Patientcomplaint() {
    }

    public Patientcomplaint(Long patientcomplaintid) {
        this.patientcomplaintid = patientcomplaintid;
    }

    public Long getPatientcomplaintid() {
        return patientcomplaintid;
    }

    public void setPatientcomplaintid(Long patientcomplaintid) {
        this.patientcomplaintid = patientcomplaintid;
    }

    public Long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public String getPatientcomplaint() {
        return patientcomplaint;
    }

    public void setPatientcomplaint(String patientcomplaint) {
        this.patientcomplaint = patientcomplaint;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (patientcomplaintid != null ? patientcomplaintid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientcomplaint)) {
            return false;
        }
        Patientcomplaint other = (Patientcomplaint) object;
        if ((this.patientcomplaintid == null && other.patientcomplaintid != null) || (this.patientcomplaintid != null && !this.patientcomplaintid.equals(other.patientcomplaintid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientcomplaint[ patientcomplaintid=" + patientcomplaintid + " ]";
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

}
