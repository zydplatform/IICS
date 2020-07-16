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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "prescriptionitems", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionitems.findAll", query = "SELECT p FROM Prescriptionitems p")
    , @NamedQuery(name = "Prescriptionitems.findByPrescriptionitemsid", query = "SELECT p FROM Prescriptionitems p WHERE p.prescriptionitemsid = :prescriptionitemsid")
    , @NamedQuery(name = "Prescriptionitems.findByPrescriptionid", query = "SELECT p FROM Prescriptionitems p WHERE p.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Prescriptionitems.findByItemid", query = "SELECT p FROM Prescriptionitems p WHERE p.itemid = :itemid")
    , @NamedQuery(name = "Prescriptionitems.findByDosage", query = "SELECT p FROM Prescriptionitems p WHERE p.dosage = :dosage")
    , @NamedQuery(name = "Prescriptionitems.findByDays", query = "SELECT p FROM Prescriptionitems p WHERE p.days = :days")
    , @NamedQuery(name = "Prescriptionitems.findByDosagestatus", query = "SELECT p FROM Prescriptionitems p WHERE p.dosagestatus = :dosagestatus")
    , @NamedQuery(name = "Prescriptionitems.findByDateadded", query = "SELECT p FROM Prescriptionitems p WHERE p.dateadded = :dateadded")})
public class Prescriptionitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prescriptionitemsid", nullable = false)
    private Long prescriptionitemsid;
    @Column(name = "prescriptionid")
    private Long prescriptionid;
    @Column(name = "itemid")
    private Long itemid;
    @Size(max = 255)
    @Column(name = "dosage", length = 255)
    private String dosage;
    @Column(name = "days")
    private Integer days;
    @Size(max = 255)
    @Column(name = "dosagestatus", length = 255)
    private String dosagestatus;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "isapproved")
    private Boolean isapproved;
    @Column(name = "notes")
    private String notes;
    @Column(name = "isissued")
    private Boolean isissued;
    @Column(name = "daysname")
    private String daysname;
    
     @Column(name = "dose")
    private String dose;

    public Prescriptionitems() {

    }

    public Prescriptionitems(Long prescriptionitemsid) {
        this.prescriptionitemsid = prescriptionitemsid;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Long getPrescriptionitemsid() {
        return prescriptionitemsid;
    }

    public void setPrescriptionitemsid(Long prescriptionitemsid) {
        this.prescriptionitemsid = prescriptionitemsid;
    }

    public Long getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(Long prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public Long getItemid() {
        return itemid;
    }

    public Boolean getIsapproved() {
        return isapproved;
    }

    public void setIsapproved(Boolean isapproved) {
        this.isapproved = isapproved;
    }

    public String getDaysname() {
        return daysname;
    }

    public void setDaysname(String daysname) {
        this.daysname = daysname;
    }

    public void setItemid(Long itemid) {
        this.itemid = itemid;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public String getDosagestatus() {
        return dosagestatus;
    }

    public void setDosagestatus(String dosagestatus) {
        this.dosagestatus = dosagestatus;
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
        hash += (prescriptionitemsid != null ? prescriptionitemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prescriptionitems)) {
            return false;
        }
        Prescriptionitems other = (Prescriptionitems) object;
        if ((this.prescriptionitemsid == null && other.prescriptionitemsid != null) || (this.prescriptionitemsid != null && !this.prescriptionitemsid.equals(other.prescriptionitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Prescriptionitems[ prescriptionitemsid=" + prescriptionitemsid + " ]";
    }

    public Boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(Boolean isissued) {
        this.isissued = isissued;
    }

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }
}
