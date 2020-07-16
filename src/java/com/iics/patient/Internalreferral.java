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
@Table(name = "internalreferral", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Internalreferral.findAll", query = "SELECT i FROM Internalreferral i")
    , @NamedQuery(name = "Internalreferral.findByInternalreferralid", query = "SELECT i FROM Internalreferral i WHERE i.internalreferralid = :internalreferralid")
    , @NamedQuery(name = "Internalreferral.findByReferralunitid", query = "SELECT i FROM Internalreferral i WHERE i.referralunitid = :referralunitid")
    , @NamedQuery(name = "Internalreferral.findByPatientvisitid", query = "SELECT i FROM Internalreferral i WHERE i.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Internalreferral.findByReferringunitid", query = "SELECT i FROM Internalreferral i WHERE i.referringunitid = :referringunitid")
    , @NamedQuery(name = "Internalreferral.findByAddedby", query = "SELECT i FROM Internalreferral i WHERE i.addedby = :addedby")
    , @NamedQuery(name = "Internalreferral.findByDateadded", query = "SELECT i FROM Internalreferral i WHERE i.dateadded = :dateadded")
    , @NamedQuery(name = "Internalreferral.findByIscomplete", query = "SELECT i FROM Internalreferral i WHERE i.iscomplete = :iscomplete")
    , @NamedQuery(name = "Internalreferral.findByReferralnotes", query = "SELECT i FROM Internalreferral i WHERE i.referralnotes = :referralnotes")
    , @NamedQuery(name = "Internalreferral.findByReferredto", query = "SELECT i FROM Internalreferral i WHERE i.referredto = :referredto")
    , @NamedQuery(name = "Internalreferral.findBySpecialty", query = "SELECT i FROM Internalreferral i WHERE i.specialty = :specialty")})
public class Internalreferral implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "internalreferralid", nullable = false)
    private Long internalreferralid;
    @Column(name = "referralunitid")
    private BigInteger referralunitid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "referringunitid")
    private BigInteger referringunitid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "iscomplete")
    private Boolean iscomplete;
    @Size(max = 255)
    @Column(name = "referralnotes", length = 255)
    private String referralnotes;
    @Column(name = "referredto")
    private BigInteger referredto;
    @Size(max = 255)
    @Column(name = "specialty", length = 255)
    private String specialty;
    @Column(name = "unitserviceid")
    private Long unitserviceid;

    public Internalreferral() {
    }

    public Internalreferral(Long internalreferralid) {
        this.internalreferralid = internalreferralid;
    }

    public Long getInternalreferralid() {
        return internalreferralid;
    }

    public void setInternalreferralid(Long internalreferralid) {
        this.internalreferralid = internalreferralid;
    }

    public BigInteger getReferralunitid() {
        return referralunitid;
    }

    public void setReferralunitid(BigInteger referralunitid) {
        this.referralunitid = referralunitid;
    }

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public BigInteger getReferringunitid() {
        return referringunitid;
    }

    public void setReferringunitid(BigInteger referringunitid) {
        this.referringunitid = referringunitid;
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

    public Boolean getIscomplete() {
        return iscomplete;
    }

    public void setIscomplete(Boolean iscomplete) {
        this.iscomplete = iscomplete;
    }

    public String getReferralnotes() {
        return referralnotes;
    }

    public void setReferralnotes(String referralnotes) {
        this.referralnotes = referralnotes;
    }

    public BigInteger getReferredto() {
        return referredto;
    }

    public void setReferredto(BigInteger referredto) {
        this.referredto = referredto;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (internalreferralid != null ? internalreferralid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Internalreferral)) {
            return false;
        }
        Internalreferral other = (Internalreferral) object;
        if ((this.internalreferralid == null && other.internalreferralid != null) || (this.internalreferralid != null && !this.internalreferralid.equals(other.internalreferralid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Internalreferral[ internalreferralid=" + internalreferralid + " ]";
    }

    public Long getUnitserviceid() {
        return unitserviceid;
    }

    public void setUnitserviceid(Long unitserviceid) {
        this.unitserviceid = unitserviceid;
    }

}
