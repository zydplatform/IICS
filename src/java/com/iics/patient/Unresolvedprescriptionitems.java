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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "unresolvedprescriptionitems", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unresolvedprescriptionitems.findAll", query = "SELECT u FROM Unresolvedprescriptionitems u")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByUnresolvedprescriptionitemsid", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.unresolvedprescriptionitemsid = :unresolvedprescriptionitemsid")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByAddedby", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.addedby = :addedby")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByDateadded", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.dateadded = :dateadded")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByUpdatedby", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.updatedby = :updatedby")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByDateupdated", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.dateupdated = :dateupdated")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByFacilityunitid", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByPrescriptionitemsid", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.prescriptionitemsid = :prescriptionitemsid")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByPatientvisitid", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Unresolvedprescriptionitems.findByPrescriptionid", query = "SELECT u FROM Unresolvedprescriptionitems u WHERE u.prescriptionid = :prescriptionid")})
public class Unresolvedprescriptionitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "unresolvedprescriptionitemsid")
    private Long unresolvedprescriptionitemsid;
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
    @Column(name = "facilityunitid")
    private long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionitemsid")
    private long prescriptionitemsid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "patientvisitid")
    private long patientvisitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "prescriptionid")
    private long prescriptionid;

    public Unresolvedprescriptionitems() {
    }

    public Unresolvedprescriptionitems(Long unresolvedprescriptionitemsid) {
        this.unresolvedprescriptionitemsid = unresolvedprescriptionitemsid;
    }

    public Unresolvedprescriptionitems(Long unresolvedprescriptionitemsid, long addedby, Date dateadded, long updatedby, Date dateupdated, long facilityunitid, long prescriptionitemsid, long patientvisitid, long prescriptionid) {
        this.unresolvedprescriptionitemsid = unresolvedprescriptionitemsid;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.updatedby = updatedby;
        this.dateupdated = dateupdated;
        this.facilityunitid = facilityunitid;
        this.prescriptionitemsid = prescriptionitemsid;
        this.patientvisitid = patientvisitid;
        this.prescriptionid = prescriptionid;
    }

    public Long getUnresolvedprescriptionitemsid() {
        return unresolvedprescriptionitemsid;
    }

    public void setUnresolvedprescriptionitemsid(Long unresolvedprescriptionitemsid) {
        this.unresolvedprescriptionitemsid = unresolvedprescriptionitemsid;
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

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public long getPrescriptionitemsid() {
        return prescriptionitemsid;
    }

    public void setPrescriptionitemsid(long prescriptionitemsid) {
        this.prescriptionitemsid = prescriptionitemsid;
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
        hash += (unresolvedprescriptionitemsid != null ? unresolvedprescriptionitemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Unresolvedprescriptionitems)) {
            return false;
        }
        Unresolvedprescriptionitems other = (Unresolvedprescriptionitems) object;
        if ((this.unresolvedprescriptionitemsid == null && other.unresolvedprescriptionitemsid != null) || (this.unresolvedprescriptionitemsid != null && !this.unresolvedprescriptionitemsid.equals(other.unresolvedprescriptionitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Unresolvedprescriptionitems[ unresolvedprescriptionitemsid=" + unresolvedprescriptionitemsid + " ]";
    }
    
}
