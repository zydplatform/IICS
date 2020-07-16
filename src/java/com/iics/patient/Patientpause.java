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
@Table(name = "patientpause", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientpause.findAll", query = "SELECT p FROM Patientpause p")
    , @NamedQuery(name = "Patientpause.findByPatientpauseid", query = "SELECT p FROM Patientpause p WHERE p.patientpauseid = :patientpauseid")
    , @NamedQuery(name = "Patientpause.findByAddedby", query = "SELECT p FROM Patientpause p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientpause.findByPaused", query = "SELECT p FROM Patientpause p WHERE p.paused = :paused")
    , @NamedQuery(name = "Patientpause.findByDateadded", query = "SELECT p FROM Patientpause p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientpause.findByPatientvisitid", query = "SELECT p FROM Patientpause p WHERE p.patientvisitid = :patientvisitid")})
public class Patientpause implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "patientpauseid", nullable = false)
    private Integer patientpauseid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "paused")
    private Boolean paused;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;

    @Column(name = "facilityunit")
    private Integer facilityunit;
    
    public Patientpause() {
    }

    public Patientpause(Integer patientpauseid) {
        this.patientpauseid = patientpauseid;
    }

    public Integer getPatientpauseid() {
        return patientpauseid;
    }

    public void setPatientpauseid(Integer patientpauseid) {
        this.patientpauseid = patientpauseid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Boolean getPaused() {
        return paused;
    }

    public void setPaused(Boolean paused) {
        this.paused = paused;
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
        hash += (patientpauseid != null ? patientpauseid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientpause)) {
            return false;
        }
        Patientpause other = (Patientpause) object;
        if ((this.patientpauseid == null && other.patientpauseid != null) || (this.patientpauseid != null && !this.patientpauseid.equals(other.patientpauseid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientpause[ patientpauseid=" + patientpauseid + " ]";
    }

    public Integer getFacilityunit() {
        return facilityunit;
    }

    public void setFacilityunit(Integer facilityunit) {
        this.facilityunit = facilityunit;
    }
    
}
