/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
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
@Table(name = "alternatedosages", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Alternatedosages.findAll", query = "SELECT a FROM Alternatedosages a")
    , @NamedQuery(name = "Alternatedosages.findByAltdosageid", query = "SELECT a FROM Alternatedosages a WHERE a.altdosageid = :altdosageid")
    , @NamedQuery(name = "Alternatedosages.findByDosage", query = "SELECT a FROM Alternatedosages a WHERE a.dosage = :dosage")
    , @NamedQuery(name = "Alternatedosages.findByAddedby", query = "SELECT a FROM Alternatedosages a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Alternatedosages.findByDateadded", query = "SELECT a FROM Alternatedosages a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Alternatedosages.findByUpdatedby", query = "SELECT a FROM Alternatedosages a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Alternatedosages.findByDateupdated", query = "SELECT a FROM Alternatedosages a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Alternatedosages.findByItemid", query = "SELECT a FROM Alternatedosages a WHERE a.itemid = :itemid")
    , @NamedQuery(name = "Alternatedosages.findByNewprescriptionitemsid", query = "SELECT a FROM Alternatedosages a WHERE a.newprescriptionitemsid = :newprescriptionitemsid")})
public class Alternatedosages implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "altdosageid")
    private Long altdosageid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "dosage")
    private String dosage;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "updatedby")
    private long updatedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Basic(optional = false)
    @NotNull
    @Column(name = "itemid")
    private long itemid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "newprescriptionitemsid")
    private long newprescriptionitemsid;

    public Alternatedosages() {
    }

    public Alternatedosages(Long altdosageid) {
        this.altdosageid = altdosageid;
    }

    public Alternatedosages(Long altdosageid, String dosage, long addedby, Date dateadded, long updatedby, Date dateupdated, long itemid, long newprescriptionitemsid) {
        this.altdosageid = altdosageid;
        this.dosage = dosage;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.updatedby = updatedby;
        this.dateupdated = dateupdated;
        this.itemid = itemid;
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public Long getAltdosageid() {
        return altdosageid;
    }

    public void setAltdosageid(Long altdosageid) {
        this.altdosageid = altdosageid;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public long getItemid() {
        return itemid;
    }

    public void setItemid(long itemid) {
        this.itemid = itemid;
    }

    public long getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(long newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (altdosageid != null ? altdosageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Alternatedosages)) {
            return false;
        }
        Alternatedosages other = (Alternatedosages) object;
        if ((this.altdosageid == null && other.altdosageid != null) || (this.altdosageid != null && !this.altdosageid.equals(other.altdosageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Alternatedosages[ altdosageid=" + altdosageid + " ]";
    }
    
}
