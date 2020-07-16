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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "prescriptionpicklist", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionpicklist.findAll", query = "SELECT p FROM Prescriptionpicklist p")
    , @NamedQuery(name = "Prescriptionpicklist.findByPrescriptionpicklistid", query = "SELECT p FROM Prescriptionpicklist p WHERE p.prescriptionpicklistid = :prescriptionpicklistid")
    , @NamedQuery(name = "Prescriptionpicklist.findByPicklistid", query = "SELECT p FROM Prescriptionpicklist p WHERE p.picklistid = :picklistid")
    , @NamedQuery(name = "Prescriptionpicklist.findByNewprescriptionitemsid", query = "SELECT p FROM Prescriptionpicklist p WHERE p.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Prescriptionpicklist.findByPrescriptionid", query = "SELECT p FROM Prescriptionpicklist p WHERE p.prescriptionid = :prescriptionid")})
public class Prescriptionpicklist implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prescriptionpicklistid")
    private Long prescriptionpicklistid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "picklistid")
    private long picklistid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "newprescriptionitemsid")
    private long newprescriptionitemsid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Prescriptionpicklist() {
    }

    public Prescriptionpicklist(Long prescriptionpicklistid) {
        this.prescriptionpicklistid = prescriptionpicklistid;
    }

    public Prescriptionpicklist(Long prescriptionpicklistid, long picklistid, long newprescriptionitemsid, long prescriptionid) {
        this.prescriptionpicklistid = prescriptionpicklistid;
        this.picklistid = picklistid;
        this.newprescriptionitemsid = newprescriptionitemsid;
        this.prescriptionid = prescriptionid;
    }

    public Long getPrescriptionpicklistid() {
        return prescriptionpicklistid;
    }

    public void setPrescriptionpicklistid(Long prescriptionpicklistid) {
        this.prescriptionpicklistid = prescriptionpicklistid;
    }

    public long getPicklistid() {
        return picklistid;
    }

    public void setPicklistid(long picklistid) {
        this.picklistid = picklistid;
    }

    public long getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(long newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
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
        hash += (prescriptionpicklistid != null ? prescriptionpicklistid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prescriptionpicklist)) {
            return false;
        }
        Prescriptionpicklist other = (Prescriptionpicklist) object;
        if ((this.prescriptionpicklistid == null && other.prescriptionpicklistid != null) || (this.prescriptionpicklistid != null && !this.prescriptionpicklistid.equals(other.prescriptionpicklistid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Prescriptionpicklist[ prescriptionpicklistid=" + prescriptionpicklistid + " ]";
    }
    
}
