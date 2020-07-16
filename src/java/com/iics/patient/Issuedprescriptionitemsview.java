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
 * @author USER
 */
@Entity
@Table(name = "issuedprescriptionitemsview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Issuedprescriptionitemsview.findAll", query = "SELECT i FROM Issuedprescriptionitemsview i")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByPatientvisitid", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByPatientid", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.patientid = :patientid")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByVisitnumber", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.visitnumber = :visitnumber")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByVisitedunit", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.visitedunit = :visitedunit")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByPrescriptionid", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByDateprescribed", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.dateprescribed = :dateprescribed")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByReferencenumber", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.referencenumber = :referencenumber")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByNewprescriptionitemsid", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByDosage", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.dosage = :dosage")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByDose", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.dose = :dose")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByDays", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.days = :days")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByDaysname", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.daysname = :daysname")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByItemname", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.itemname = :itemname")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByIsissued", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.isissued = :isissued")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByIsmodified", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.ismodified = :ismodified")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByIssuedby", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.issuedby = :issuedby")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByDateissued", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.dateissued = :dateissued")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByItempackageid", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.itempackageid = :itempackageid")
    , @NamedQuery(name = "Issuedprescriptionitemsview.findByQuantitydispensed", query = "SELECT i FROM Issuedprescriptionitemsview i WHERE i.quantitydispensed = :quantitydispensed")})
public class Issuedprescriptionitemsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "patientvisitid")
    @Id
    private BigInteger patientvisitid;
    @Column(name = "patientid")
    private BigInteger patientid;
    @Size(max = 255)
    @Column(name = "visitnumber")
    private String visitnumber;
    @Column(name = "visitedunit")
    private BigInteger visitedunit;
    @Column(name = "prescriptionid")
    private BigInteger prescriptionid;
    @Column(name = "dateprescribed")
    @Temporal(TemporalType.DATE)
    private Date dateprescribed;
    @Size(max = 2147483647)
    @Column(name = "referencenumber")
    private String referencenumber;
    @Column(name = "newprescriptionitemsid")
    private BigInteger newprescriptionitemsid;
    @Size(max = 255)
    @Column(name = "dosage")
    private String dosage;
    @Size(max = 2147483647)
    @Column(name = "dose")
    private String dose;
    @Column(name = "days")
    private Integer days;
    @Size(max = 255)
    @Column(name = "daysname")
    private String daysname;
    @Size(max = 2147483647)
    @Column(name = "itemname")
    private String itemname;
    @Column(name = "isissued")
    private Boolean isissued;
    @Column(name = "ismodified")
    private Boolean ismodified;
    @Column(name = "issuedby")
    private BigInteger issuedby;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "quantitydispensed")
    private Integer quantitydispensed;

    public Issuedprescriptionitemsview() {
    }

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public BigInteger getPatientid() {
        return patientid;
    }

    public void setPatientid(BigInteger patientid) {
        this.patientid = patientid;
    }

    public String getVisitnumber() {
        return visitnumber;
    }

    public void setVisitnumber(String visitnumber) {
        this.visitnumber = visitnumber;
    }

    public BigInteger getVisitedunit() {
        return visitedunit;
    }

    public void setVisitedunit(BigInteger visitedunit) {
        this.visitedunit = visitedunit;
    }

    public BigInteger getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(BigInteger prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public Date getDateprescribed() {
        return dateprescribed;
    }

    public void setDateprescribed(Date dateprescribed) {
        this.dateprescribed = dateprescribed;
    }

    public String getReferencenumber() {
        return referencenumber;
    }

    public void setReferencenumber(String referencenumber) {
        this.referencenumber = referencenumber;
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

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public Boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(Boolean isissued) {
        this.isissued = isissued;
    }

    public Boolean getIsmodified() {
        return ismodified;
    }

    public void setIsmodified(Boolean ismodified) {
        this.ismodified = ismodified;
    }

    public BigInteger getIssuedby() {
        return issuedby;
    }

    public void setIssuedby(BigInteger issuedby) {
        this.issuedby = issuedby;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public BigInteger getItempackageid() {
        return itempackageid;
    }

    public void setItempackageid(BigInteger itempackageid) {
        this.itempackageid = itempackageid;
    }

    public Integer getQuantitydispensed() {
        return quantitydispensed;
    }

    public void setQuantitydispensed(Integer quantitydispensed) {
        this.quantitydispensed = quantitydispensed;
    }
    
}
