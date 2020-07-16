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
@Table(name = "modifiedprescriptionitems", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Modifiedprescriptionitems.findAll", query = "SELECT m FROM Modifiedprescriptionitems m")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByNewprescriptionitemsid", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByDosage", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.dosage = :dosage")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByDose", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.dose = :dose")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByDays", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.days = :days")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByDaysname", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.daysname = :daysname")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByIsapproved", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.isapproved = :isapproved")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByIsissued", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.isissued = :isissued")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByItemname", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.itemname = :itemname")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByReason", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.reason = :reason")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByDatemodified", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.datemodified = :datemodified")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByModifiedby", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.modifiedby = :modifiedby")
    , @NamedQuery(name = "Modifiedprescriptionitems.findByPrescriptionid", query = "SELECT m FROM Modifiedprescriptionitems m WHERE m.prescriptionid = :prescriptionid")})
public class Modifiedprescriptionitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "newprescriptionitemsid")
    private Long newprescriptionitemsid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "dosage")
    private String dosage;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "dose")
    private String dose;
    @Basic(optional = false)
    @NotNull
    @Column(name = "days")
    private int days;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "daysname")
    private String daysname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isapproved")
    private boolean isapproved;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isissued")
    private boolean isissued;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "itemname")
    private String itemname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "reason")
    private String reason;
    @Basic(optional = false)
    @NotNull
    @Column(name = "datemodified")
    @Temporal(TemporalType.DATE)
    private Date datemodified;
    @Basic(optional = false)
    @NotNull
    @Column(name = "modifiedby")
    private long modifiedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Modifiedprescriptionitems() {
    }

    public Modifiedprescriptionitems(Long newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public Modifiedprescriptionitems(Long newprescriptionitemsid, String dosage, String dose, int days, String daysname, boolean isapproved, boolean isissued, String itemname, String reason, Date datemodified, long modifiedby, long prescriptionid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
        this.dosage = dosage;
        this.dose = dose;
        this.days = days;
        this.daysname = daysname;
        this.isapproved = isapproved;
        this.isissued = isissued;
        this.itemname = itemname;
        this.reason = reason;
        this.datemodified = datemodified;
        this.modifiedby = modifiedby;
        this.prescriptionid = prescriptionid;
    }

    public Long getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(Long newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }

    public int getDays() {
        return days;
    }

    public void setDays(int days) {
        this.days = days;
    }

    public String getDaysname() {
        return daysname;
    }

    public void setDaysname(String daysname) {
        this.daysname = daysname;
    }

    public boolean getIsapproved() {
        return isapproved;
    }

    public void setIsapproved(boolean isapproved) {
        this.isapproved = isapproved;
    }

    public boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(boolean isissued) {
        this.isissued = isissued;
    }

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getDatemodified() {
        return datemodified;
    }

    public void setDatemodified(Date datemodified) {
        this.datemodified = datemodified;
    }

    public long getModifiedby() {
        return modifiedby;
    }

    public void setModifiedby(long modifiedby) {
        this.modifiedby = modifiedby;
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
        hash += (newprescriptionitemsid != null ? newprescriptionitemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Modifiedprescriptionitems)) {
            return false;
        }
        Modifiedprescriptionitems other = (Modifiedprescriptionitems) object;
        if ((this.newprescriptionitemsid == null && other.newprescriptionitemsid != null) || (this.newprescriptionitemsid != null && !this.newprescriptionitemsid.equals(other.newprescriptionitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Modifiedprescriptionitems[ newprescriptionitemsid=" + newprescriptionitemsid + " ]";
    }
    
}
