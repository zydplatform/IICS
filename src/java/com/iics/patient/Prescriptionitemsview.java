/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
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
 * @author IICS
 */
@Entity
@Table(name = "prescriptionitemsview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionitemsview.findAll", query = "SELECT p FROM Prescriptionitemsview p")
    , @NamedQuery(name = "Prescriptionitemsview.findByPrescriptionid", query = "SELECT p FROM Prescriptionitemsview p WHERE p.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Prescriptionitemsview.findByPatientvisitid", query = "SELECT p FROM Prescriptionitemsview p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Prescriptionitemsview.findByDateprescribed", query = "SELECT p FROM Prescriptionitemsview p WHERE p.dateprescribed = :dateprescribed")
    , @NamedQuery(name = "Prescriptionitemsview.findByStatus", query = "SELECT p FROM Prescriptionitemsview p WHERE p.status = :status")
    , @NamedQuery(name = "Prescriptionitemsview.findByAddedby", query = "SELECT p FROM Prescriptionitemsview p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Prescriptionitemsview.findByLastupdated", query = "SELECT p FROM Prescriptionitemsview p WHERE p.lastupdated = :lastupdated")
    , @NamedQuery(name = "Prescriptionitemsview.findByLastupdatedby", query = "SELECT p FROM Prescriptionitemsview p WHERE p.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Prescriptionitemsview.findByDispensingunit", query = "SELECT p FROM Prescriptionitemsview p WHERE p.dispensingunit = :dispensingunit")
    , @NamedQuery(name = "Prescriptionitemsview.findByDestinationunitid", query = "SELECT p FROM Prescriptionitemsview p WHERE p.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Prescriptionitemsview.findByOriginunitid", query = "SELECT p FROM Prescriptionitemsview p WHERE p.originunitid = :originunitid")
    , @NamedQuery(name = "Prescriptionitemsview.findByApprovedby", query = "SELECT p FROM Prescriptionitemsview p WHERE p.approvedby = :approvedby")
    , @NamedQuery(name = "Prescriptionitemsview.findByDateapproved", query = "SELECT p FROM Prescriptionitemsview p WHERE p.dateapproved = :dateapproved")
    , @NamedQuery(name = "Prescriptionitemsview.findByDateissued", query = "SELECT p FROM Prescriptionitemsview p WHERE p.dateissued = :dateissued")
    , @NamedQuery(name = "Prescriptionitemsview.findByNewprescriptionitemsid", query = "SELECT p FROM Prescriptionitemsview p WHERE p.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Prescriptionitemsview.findByDosage", query = "SELECT p FROM Prescriptionitemsview p WHERE p.dosage = :dosage")
    , @NamedQuery(name = "Prescriptionitemsview.findByDose", query = "SELECT p FROM Prescriptionitemsview p WHERE p.dose = :dose")
    , @NamedQuery(name = "Prescriptionitemsview.findByNotes", query = "SELECT p FROM Prescriptionitemsview p WHERE p.notes = :notes")
    , @NamedQuery(name = "Prescriptionitemsview.findByDays", query = "SELECT p FROM Prescriptionitemsview p WHERE p.days = :days")
    , @NamedQuery(name = "Prescriptionitemsview.findByDaysname", query = "SELECT p FROM Prescriptionitemsview p WHERE p.daysname = :daysname")
    , @NamedQuery(name = "Prescriptionitemsview.findByIsapproved", query = "SELECT p FROM Prescriptionitemsview p WHERE p.isapproved = :isapproved")
    , @NamedQuery(name = "Prescriptionitemsview.findByIsissued", query = "SELECT p FROM Prescriptionitemsview p WHERE p.isissued = :isissued")
    , @NamedQuery(name = "Prescriptionitemsview.findByItemname", query = "SELECT p FROM Prescriptionitemsview p WHERE p.itemname = :itemname")
    , @NamedQuery(name = "Prescriptionitemsview.findByApprovable", query = "SELECT p FROM Prescriptionitemsview p WHERE p.approvable = :approvable")})
public class Prescriptionitemsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    @Id
    private BigInteger prescriptionid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "dateprescribed")
    @Temporal(TemporalType.DATE)
    private Date dateprescribed;
    @Size(max = 200)
    @Column(name = "status")
    private String status;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @Column(name = "dispensingunit")
    private BigInteger dispensingunit;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Column(name = "originunitid")
    private BigInteger originunitid;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "newprescriptionitemsid")
    private BigInteger newprescriptionitemsid;
    @Size(max = 255)
    @Column(name = "dosage")
    private String dosage;
    @Size(max = 2147483647)
    @Column(name = "dose")
    private String dose;
    @Size(max = 2147483647)
    @Column(name = "notes")
    private String notes;
    @Column(name = "days")
    private Integer days;
    @Size(max = 255)
    @Column(name = "daysname")
    private String daysname;
    @Column(name = "isapproved")
    private Boolean isapproved;
    @Column(name = "isissued")
    private Boolean isissued;
    @Size(max = 2147483647)
    @Column(name = "itemname")
    private String itemname;
    @Column(name = "approvable")
    private Boolean approvable;

    public Prescriptionitemsview() {
    }

    public BigInteger getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(BigInteger prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public Date getDateprescribed() {
        return dateprescribed;
    }

    public void setDateprescribed(Date dateprescribed) {
        this.dateprescribed = dateprescribed;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public BigInteger getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(BigInteger lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public BigInteger getDispensingunit() {
        return dispensingunit;
    }

    public void setDispensingunit(BigInteger dispensingunit) {
        this.dispensingunit = dispensingunit;
    }

    public BigInteger getDestinationunitid() {
        return destinationunitid;
    }

    public void setDestinationunitid(BigInteger destinationunitid) {
        this.destinationunitid = destinationunitid;
    }

    public BigInteger getOriginunitid() {
        return originunitid;
    }

    public void setOriginunitid(BigInteger originunitid) {
        this.originunitid = originunitid;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public BigInteger getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(BigInteger newprescriptionitemsid) {
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

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public String getDaysname() {
        return daysname;
    }

    public void setDaysname(String daysname) {
        this.daysname = daysname;
    }

    public Boolean getIsapproved() {
        return isapproved;
    }

    public void setIsapproved(Boolean isapproved) {
        this.isapproved = isapproved;
    }

    public Boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(Boolean isissued) {
        this.isissued = isissued;
    }

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public Boolean getApprovable() {
        return approvable;
    }

    public void setApprovable(Boolean approvable) {
        this.approvable = approvable;
    }
    
}
