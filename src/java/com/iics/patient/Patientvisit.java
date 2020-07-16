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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patientvisit", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientvisit.findAll", query = "SELECT p FROM Patientvisit p")
    , @NamedQuery(name = "Patientvisit.findByPatientvisitid", query = "SELECT p FROM Patientvisit p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Patientvisit.findByAddedby", query = "SELECT p FROM Patientvisit p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientvisit.findByDateadded", query = "SELECT p FROM Patientvisit p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientvisit.findByVisitnumber", query = "SELECT p FROM Patientvisit p WHERE p.visitnumber = :visitnumber")
    , @NamedQuery(name = "Patientvisit.findByVisittype", query = "SELECT p FROM Patientvisit p WHERE p.visittype = :visittype")
    , @NamedQuery(name = "Patientvisit.findByFacilityunitid", query = "SELECT p FROM Patientvisit p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Patientvisit.findByVisitpriority", query = "SELECT p FROM Patientvisit p WHERE p.visitpriority = :visitpriority")
    , @NamedQuery(name = "Patientvisit.findByPatientid", query = "SELECT p FROM Patientvisit p WHERE p.patientid = :patientid")})
public class Patientvisit implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "patientvisitid")
    private Long patientvisitid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Size(max = 255)
    @Column(name = "visitnumber")
    private String visitnumber;
    @Size(max = 255)
    @Column(name = "visittype")
    private String visittype;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 255)
    @Column(name = "visitpriority")
    private String visitpriority;
    @Basic(optional = false)
    @NotNull
    @Column(name = "patientid")
    private long patientid;

    public Patientvisit() {
    }

    public Patientvisit(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public Patientvisit(Long patientvisitid, long patientid) {
        this.patientvisitid = patientvisitid;
        this.patientid = patientid;
    }

    public Long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
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

    public String getVisitnumber() {
        return visitnumber;
    }

    public void setVisitnumber(String visitnumber) {
        this.visitnumber = visitnumber;
    }

    public String getVisittype() {
        return visittype;
    }

    public void setVisittype(String visittype) {
        this.visittype = visittype;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getVisitpriority() {
        return visitpriority;
    }

    public void setVisitpriority(String visitpriority) {
        this.visitpriority = visitpriority;
    }

    public long getPatientid() {
        return patientid;
    }

    public void setPatientid(long patientid) {
        this.patientid = patientid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (patientvisitid != null ? patientvisitid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientvisit)) {
            return false;
        }
        Patientvisit other = (Patientvisit) object;
        if ((this.patientvisitid == null && other.patientvisitid != null) || (this.patientvisitid != null && !this.patientvisitid.equals(other.patientvisitid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientvisit[ patientvisitid=" + patientvisitid + " ]";
    }
    
}
