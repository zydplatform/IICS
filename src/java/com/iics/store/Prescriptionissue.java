/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
@Table(name = "prescriptionissue", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionissue.findAll", query = "SELECT p FROM Prescriptionissue p")
    , @NamedQuery(name = "Prescriptionissue.findByPrescriptionissueid", query = "SELECT p FROM Prescriptionissue p WHERE p.prescriptionissueid = :prescriptionissueid")
    , @NamedQuery(name = "Prescriptionissue.findByNotes", query = "SELECT p FROM Prescriptionissue p WHERE p.notes = :notes")
    , @NamedQuery(name = "Prescriptionissue.findByIssuedby", query = "SELECT p FROM Prescriptionissue p WHERE p.issuedby = :issuedby")
    , @NamedQuery(name = "Prescriptionissue.findByPrescriptionitemsid", query = "SELECT p FROM Prescriptionissue p WHERE p.prescriptionitemsid = :prescriptionitemsid")
    , @NamedQuery(name = "Prescriptionissue.findByDateissued", query = "SELECT p FROM Prescriptionissue p WHERE p.dateissued = :dateissued")
    , @NamedQuery(name = "Prescriptionissue.findByQuantityapproved", query = "SELECT p FROM Prescriptionissue p WHERE p.quantityapproved = :quantityapproved")
    , @NamedQuery(name = "Prescriptionissue.findByItempackageid", query = "SELECT p FROM Prescriptionissue p WHERE p.itempackageid = :itempackageid")
    , @NamedQuery(name = "Prescriptionissue.findByNewprescriptionitemsid", query = "SELECT p FROM Prescriptionissue p WHERE p.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Prescriptionissue.findByUsepackage", query = "SELECT p FROM Prescriptionissue p WHERE p.usepackage = :usepackage")})
public class Prescriptionissue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prescriptionissueid")
    private Long prescriptionissueid;
    @Size(max = 255)
    @Column(name = "notes")
    private String notes;
    @Column(name = "issuedby")
    private BigInteger issuedby;
    @Column(name = "prescriptionitemsid")
    private BigInteger prescriptionitemsid;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "quantityapproved")
    private Integer quantityapproved;
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "newprescriptionitemsid")
    private BigInteger newprescriptionitemsid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "usepackage")
    private boolean usepackage;

    public Prescriptionissue() {
    }

    public Prescriptionissue(Long prescriptionissueid) {
        this.prescriptionissueid = prescriptionissueid;
    }

    public Prescriptionissue(Long prescriptionissueid, boolean usepackage) {
        this.prescriptionissueid = prescriptionissueid;
        this.usepackage = usepackage;
    }

    public Long getPrescriptionissueid() {
        return prescriptionissueid;
    }

    public void setPrescriptionissueid(Long prescriptionissueid) {
        this.prescriptionissueid = prescriptionissueid;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public BigInteger getIssuedby() {
        return issuedby;
    }

    public void setIssuedby(BigInteger issuedby) {
        this.issuedby = issuedby;
    }

    public BigInteger getPrescriptionitemsid() {
        return prescriptionitemsid;
    }

    public void setPrescriptionitemsid(BigInteger prescriptionitemsid) {
        this.prescriptionitemsid = prescriptionitemsid;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public Integer getQuantityapproved() {
        return quantityapproved;
    }

    public void setQuantityapproved(Integer quantityapproved) {
        this.quantityapproved = quantityapproved;
    }

    public BigInteger getItempackageid() {
        return itempackageid;
    }

    public void setItempackageid(BigInteger itempackageid) {
        this.itempackageid = itempackageid;
    }

    public BigInteger getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(BigInteger newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public boolean getUsepackage() {
        return usepackage;
    }

    public void setUsepackage(boolean usepackage) {
        this.usepackage = usepackage;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (prescriptionissueid != null ? prescriptionissueid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prescriptionissue)) {
            return false;
        }
        Prescriptionissue other = (Prescriptionissue) object;
        if ((this.prescriptionissueid == null && other.prescriptionissueid != null) || (this.prescriptionissueid != null && !this.prescriptionissueid.equals(other.prescriptionissueid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Prescriptionissue[ prescriptionissueid=" + prescriptionissueid + " ]";
    }
    
}
