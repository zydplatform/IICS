/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;



/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilityorderreject", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Facilityorderreject.findAll", query = "SELECT f FROM Facilityorderreject f")
    , @NamedQuery(name = "Facilityorderreject.findByRejectid", query = "SELECT f FROM Facilityorderreject f WHERE f.rejectid = :rejectid")
    , @NamedQuery(name = "Facilityorderreject.findByRejectedby", query = "SELECT f FROM Facilityorderreject f WHERE f.rejectedby = :rejectedby")
    , @NamedQuery(name = "Facilityorderreject.findByDaterejected", query = "SELECT f FROM Facilityorderreject f WHERE f.daterejected = :daterejected")
    , @NamedQuery(name = "Facilityorderreject.findByVerified", query = "SELECT f FROM Facilityorderreject f WHERE f.verified = :verified")
    , @NamedQuery(name = "Facilityorderreject.findByVerifiedby", query = "SELECT f FROM Facilityorderreject f WHERE f.verifiedby = :verifiedby")
    , @NamedQuery(name = "Facilityorderreject.findByDateverified", query = "SELECT f FROM Facilityorderreject f WHERE f.dateverified = :dateverified")
    , @NamedQuery(name = "Facilityorderreject.findByRejectnote", query = "SELECT f FROM Facilityorderreject f WHERE f.rejectnote = :rejectnote")
    , @NamedQuery(name = "Facilityorderreject.findByVerficationaction", query = "SELECT f FROM Facilityorderreject f WHERE f.verficationaction = :verficationaction")
    , @NamedQuery(name = "Facilityorderreject.findByVerificationnote", query = "SELECT f FROM Facilityorderreject f WHERE f.verificationnote = :verificationnote")
    , @NamedQuery(name = "Facilityorderreject.findByItems", query = "SELECT f FROM Facilityorderreject f WHERE f.items = :items")})
public class Facilityorderreject implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "rejectid", nullable = false)
    private Long rejectid;
    @Column(name = "rejectedby")
    private BigInteger rejectedby;
    @Column(name = "daterejected")
    @Temporal(TemporalType.TIMESTAMP)
    private Date daterejected;
    @Basic(optional = false)
    @Column(name = "verified", nullable = false)
    private boolean verified;
    @Column(name = "verifiedby")
    private BigInteger verifiedby;
    @Column(name = "dateverified")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateverified;
    @Basic(optional = false)
    @Column(name = "rejectnote", nullable = false, length = 2147483647)
    private String rejectnote;
    @Column(name = "verficationaction", length = 2147483647)
    private String verficationaction;
    @Column(name = "verificationnote", length = 2147483647)
    private String verificationnote;
    @Column(name = "items")
    private Integer items;
    @JoinColumn(name = "rejectedorderref", referencedColumnName = "referenceid", nullable = false)
    @ManyToOne(optional = false)
    private Facilityorderserviceref facilityorderserviceref;

    public Facilityorderreject() {
    }

    public Facilityorderreject(Long rejectid) {
        this.rejectid = rejectid;
    } 

    public Facilityorderreject(Long rejectid, boolean verified, String rejectnote) {
        this.rejectid = rejectid;
        this.verified = verified;
        this.rejectnote = rejectnote;
    }

    public Long getRejectid() {
        return rejectid;
    }

    public void setRejectid(Long rejectid) {
        this.rejectid = rejectid;
    }

    public BigInteger getRejectedby() {
        return rejectedby;
    }

    public void setRejectedby(BigInteger rejectedby) {
        this.rejectedby = rejectedby;
    }

    public Date getDaterejected() {
        return daterejected;
    }

    public void setDaterejected(Date daterejected) {
        this.daterejected = daterejected;
    }

    public boolean getVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public BigInteger getVerifiedby() {
        return verifiedby;
    }

    public void setVerifiedby(BigInteger verifiedby) {
        this.verifiedby = verifiedby;
    }

    public Date getDateverified() {
        return dateverified;
    }

    public void setDateverified(Date dateverified) {
        this.dateverified = dateverified;
    }

    public String getRejectnote() {
        return rejectnote;
    }

    public void setRejectnote(String rejectnote) {
        this.rejectnote = rejectnote;
    }

    public String getVerficationaction() {
        return verficationaction;
    }

    public void setVerficationaction(String verficationaction) {
        this.verficationaction = verficationaction;
    }

    public String getVerificationnote() {
        return verificationnote;
    }

    public void setVerificationnote(String verificationnote) {
        this.verificationnote = verificationnote;
    }

    public Integer getItems() {
        return items;
    }

    public void setItems(Integer items) {
        this.items = items;
    }

    public Facilityorderserviceref getFacilityorderserviceref() {
        return facilityorderserviceref;
    }

    public void setFacilityorderserviceref(Facilityorderserviceref facilityorderserviceref) {
        this.facilityorderserviceref = facilityorderserviceref;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rejectid != null ? rejectid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityorderreject)) {
            return false;
        }
        Facilityorderreject other = (Facilityorderreject) object;
        if ((this.rejectid == null && other.rejectid != null) || (this.rejectid != null && !this.rejectid.equals(other.rejectid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Facilityorderreject[ rejectid=" + rejectid + " ]";
    }
    
}
