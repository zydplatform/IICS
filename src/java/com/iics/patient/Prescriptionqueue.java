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
 * @author IICS TECHS
 */
@Entity
@Table(name = "prescriptionqueue", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionqueue.findAll", query = "SELECT p FROM Prescriptionqueue p")
    , @NamedQuery(name = "Prescriptionqueue.findByPrescriptionqueueid", query = "SELECT p FROM Prescriptionqueue p WHERE p.prescriptionqueueid = :prescriptionqueueid")
    , @NamedQuery(name = "Prescriptionqueue.findByAddedby", query = "SELECT p FROM Prescriptionqueue p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Prescriptionqueue.findByTimein", query = "SELECT p FROM Prescriptionqueue p WHERE p.timein = :timein")
    , @NamedQuery(name = "Prescriptionqueue.findByTimeout", query = "SELECT p FROM Prescriptionqueue p WHERE p.timeout = :timeout")
    , @NamedQuery(name = "Prescriptionqueue.findByFacilityunitid", query = "SELECT p FROM Prescriptionqueue p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Prescriptionqueue.findByQueuestage", query = "SELECT p FROM Prescriptionqueue p WHERE p.queuestage = :queuestage")
    , @NamedQuery(name = "Prescriptionqueue.findByIspopped", query = "SELECT p FROM Prescriptionqueue p WHERE p.ispopped = :ispopped")
    , @NamedQuery(name = "Prescriptionqueue.findByIsserviced", query = "SELECT p FROM Prescriptionqueue p WHERE p.isserviced = :isserviced")
    , @NamedQuery(name = "Prescriptionqueue.findByPoppedby", query = "SELECT p FROM Prescriptionqueue p WHERE p.poppedby = :poppedby")
    , @NamedQuery(name = "Prescriptionqueue.findByIsunresolved", query = "SELECT p FROM Prescriptionqueue p WHERE p.isunresolved = :isunresolved")
    , @NamedQuery(name = "Prescriptionqueue.findByPatientvisitid", query = "SELECT p FROM Prescriptionqueue p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Prescriptionqueue.findByPrescriptionid", query = "SELECT p FROM Prescriptionqueue p WHERE p.prescriptionid = :prescriptionid")})
public class Prescriptionqueue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prescriptionqueueid")
    private Long prescriptionqueueid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "timein")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timein;
    @Column(name = "timeout")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeout;
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitid")
    private long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "queuestage")
    private String queuestage;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ispopped")
    private boolean ispopped;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isserviced")
    private boolean isserviced;
    @Column(name = "poppedby")
    private BigInteger poppedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isunresolved")
    private boolean isunresolved;
    @Basic(optional = false)
    @NotNull
    @Column(name = "patientvisitid")
    private long patientvisitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Prescriptionqueue() {
    }

    public Prescriptionqueue(Long prescriptionqueueid) {
        this.prescriptionqueueid = prescriptionqueueid;
    }

    public Prescriptionqueue(Long prescriptionqueueid, long addedby, Date timein, long facilityunitid, String queuestage, boolean ispopped, boolean isserviced, boolean isunresolved, long patientvisitid, long prescriptionid) {
        this.prescriptionqueueid = prescriptionqueueid;
        this.addedby = addedby;
        this.timein = timein;
        this.facilityunitid = facilityunitid;
        this.queuestage = queuestage;
        this.ispopped = ispopped;
        this.isserviced = isserviced;
        this.isunresolved = isunresolved;
        this.patientvisitid = patientvisitid;
        this.prescriptionid = prescriptionid;
    }

    public Long getPrescriptionqueueid() {
        return prescriptionqueueid;
    }

    public void setPrescriptionqueueid(Long prescriptionqueueid) {
        this.prescriptionqueueid = prescriptionqueueid;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public Date getTimein() {
        return timein;
    }

    public void setTimein(Date timein) {
        this.timein = timein;
    }

    public Date getTimeout() {
        return timeout;
    }

    public void setTimeout(Date timeout) {
        this.timeout = timeout;
    }

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getQueuestage() {
        return queuestage;
    }

    public void setQueuestage(String queuestage) {
        this.queuestage = queuestage;
    }

    public boolean getIspopped() {
        return ispopped;
    }

    public void setIspopped(boolean ispopped) {
        this.ispopped = ispopped;
    }

    public boolean getIsserviced() {
        return isserviced;
    }

    public void setIsserviced(boolean isserviced) {
        this.isserviced = isserviced;
    }

    public BigInteger getPoppedby() {
        return poppedby;
    }

    public void setPoppedby(BigInteger poppedby) {
        this.poppedby = poppedby;
    }

    public boolean getIsunresolved() {
        return isunresolved;
    }

    public void setIsunresolved(boolean isunresolved) {
        this.isunresolved = isunresolved;
    }

    public long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(long patientvisitid) {
        this.patientvisitid = patientvisitid;
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
        hash += (prescriptionqueueid != null ? prescriptionqueueid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prescriptionqueue)) {
            return false;
        }
        Prescriptionqueue other = (Prescriptionqueue) object;
        if ((this.prescriptionqueueid == null && other.prescriptionqueueid != null) || (this.prescriptionqueueid != null && !this.prescriptionqueueid.equals(other.prescriptionqueueid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Prescriptionqueue[ prescriptionqueueid=" + prescriptionqueueid + " ]";
    }
    
}
