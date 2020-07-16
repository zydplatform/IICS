/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "newprescriptionitems", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Newprescriptionitems.findAll", query = "SELECT n FROM Newprescriptionitems n")
    , @NamedQuery(name = "Newprescriptionitems.findByNewprescriptionitemsid", query = "SELECT n FROM Newprescriptionitems n WHERE n.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Newprescriptionitems.findByDosage", query = "SELECT n FROM Newprescriptionitems n WHERE n.dosage = :dosage")
    , @NamedQuery(name = "Newprescriptionitems.findByDose", query = "SELECT n FROM Newprescriptionitems n WHERE n.dose = :dose")
    , @NamedQuery(name = "Newprescriptionitems.findByNotes", query = "SELECT n FROM Newprescriptionitems n WHERE n.notes = :notes")
    , @NamedQuery(name = "Newprescriptionitems.findByDays", query = "SELECT n FROM Newprescriptionitems n WHERE n.days = :days")
    , @NamedQuery(name = "Newprescriptionitems.findByDaysname", query = "SELECT n FROM Newprescriptionitems n WHERE n.daysname = :daysname")
    , @NamedQuery(name = "Newprescriptionitems.findByIsapproved", query = "SELECT n FROM Newprescriptionitems n WHERE n.isapproved = :isapproved")
    , @NamedQuery(name = "Newprescriptionitems.findByIsissued", query = "SELECT n FROM Newprescriptionitems n WHERE n.isissued = :isissued")
    , @NamedQuery(name = "Newprescriptionitems.findByItemname", query = "SELECT n FROM Newprescriptionitems n WHERE n.itemname = :itemname")
    , @NamedQuery(name = "Newprescriptionitems.findByApprovable", query = "SELECT n FROM Newprescriptionitems n WHERE n.approvable = :approvable")
    , @NamedQuery(name = "Newprescriptionitems.findByIsmodified", query = "SELECT n FROM Newprescriptionitems n WHERE n.ismodified = :ismodified")
    , @NamedQuery(name = "Newprescriptionitems.findByPrescriptionid", query = "SELECT n FROM Newprescriptionitems n WHERE n.prescriptionid = :prescriptionid")})
public class Newprescriptionitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "newprescriptionitemsid")
    private Long newprescriptionitemsid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "dosage")
    private String dosage;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "dose")
    private String dose;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "notes")
    private String notes;
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
    @Column(name = "approvable")
    private boolean approvable;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ismodified")
    private boolean ismodified;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Newprescriptionitems() {
    }

    public Newprescriptionitems(Long newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public Newprescriptionitems(Long newprescriptionitemsid, String dosage, String dose, String notes, int days, String daysname, boolean isapproved, boolean isissued, String itemname, boolean approvable, boolean ismodified, long prescriptionid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
        this.dosage = dosage;
        this.dose = dose;
        this.notes = notes;
        this.days = days;
        this.daysname = daysname;
        this.isapproved = isapproved;
        this.isissued = isissued;
        this.itemname = itemname;
        this.approvable = approvable;
        this.ismodified = ismodified;
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

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
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

    public boolean getApprovable() {
        return approvable;
    }

    public void setApprovable(boolean approvable) {
        this.approvable = approvable;
    }

    public boolean getIsmodified() {
        return ismodified;
    }

    public void setIsmodified(boolean ismodified) {
        this.ismodified = ismodified;
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
        if (!(object instanceof Newprescriptionitems)) {
            return false;
        }
        Newprescriptionitems other = (Newprescriptionitems) object;
        if ((this.newprescriptionitemsid == null && other.newprescriptionitemsid != null) || (this.newprescriptionitemsid != null && !this.newprescriptionitemsid.equals(other.newprescriptionitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Newprescriptionitems[ newprescriptionitemsid=" + newprescriptionitemsid + " ]";
    }
    
}
