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
 * @author HP
 */
@Entity
@Table(name = "prescriptionissueview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionissueview.findAll", query = "SELECT p FROM Prescriptionissueview p")
    , @NamedQuery(name = "Prescriptionissueview.findByPrescriptionid", query = "SELECT p FROM Prescriptionissueview p WHERE p.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Prescriptionissueview.findByPatientvisitid", query = "SELECT p FROM Prescriptionissueview p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Prescriptionissueview.findByOriginunitid", query = "SELECT p FROM Prescriptionissueview p WHERE p.originunitid = :originunitid")
    , @NamedQuery(name = "Prescriptionissueview.findByDestinationunitid", query = "SELECT p FROM Prescriptionissueview p WHERE p.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Prescriptionissueview.findByStatus", query = "SELECT p FROM Prescriptionissueview p WHERE p.status = :status")
    , @NamedQuery(name = "Prescriptionissueview.findByPrescriptionitemsid", query = "SELECT p FROM Prescriptionissueview p WHERE p.prescriptionitemsid = :prescriptionitemsid")
    , @NamedQuery(name = "Prescriptionissueview.findByItemid", query = "SELECT p FROM Prescriptionissueview p WHERE p.itemid = :itemid")
    , @NamedQuery(name = "Prescriptionissueview.findByIsissued", query = "SELECT p FROM Prescriptionissueview p WHERE p.isissued = :isissued")
    , @NamedQuery(name = "Prescriptionissueview.findByItempackageid", query = "SELECT p FROM Prescriptionissueview p WHERE p.itempackageid = :itempackageid")
    , @NamedQuery(name = "Prescriptionissueview.findByDateissued", query = "SELECT p FROM Prescriptionissueview p WHERE p.dateissued = :dateissued")
    , @NamedQuery(name = "Prescriptionissueview.findByStockid", query = "SELECT p FROM Prescriptionissueview p WHERE p.stockid = :stockid")
    , @NamedQuery(name = "Prescriptionissueview.findByPrescriptionissueid", query = "SELECT p FROM Prescriptionissueview p WHERE p.prescriptionissueid = :prescriptionissueid")})
public class Prescriptionissueview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    private BigInteger prescriptionid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "originunitid")
    private BigInteger originunitid;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Column(name = "prescriptionitemsid")
    private BigInteger prescriptionitemsid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "isissued")
    private Boolean isissued;
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "stockid")
    private BigInteger stockid;
    @Id
    @Column(name = "prescriptionissueid")
    private BigInteger prescriptionissueid;
    @Column(name = "quantitydispensed")
    private Integer quantitydispensed;

    public Prescriptionissueview() {
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

    public BigInteger getOriginunitid() {
        return originunitid;
    }

    public void setOriginunitid(BigInteger originunitid) {
        this.originunitid = originunitid;
    }

    public BigInteger getDestinationunitid() {
        return destinationunitid;
    }

    public void setDestinationunitid(BigInteger destinationunitid) {
        this.destinationunitid = destinationunitid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigInteger getPrescriptionitemsid() {
        return prescriptionitemsid;
    }

    public void setPrescriptionitemsid(BigInteger prescriptionitemsid) {
        this.prescriptionitemsid = prescriptionitemsid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public Boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(Boolean isissued) {
        this.isissued = isissued;
    }

    public BigInteger getItempackageid() {
        return itempackageid;
    }

    public void setItempackageid(BigInteger itempackageid) {
        this.itempackageid = itempackageid;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public BigInteger getStockid() {
        return stockid;
    }

    public void setStockid(BigInteger stockid) {
        this.stockid = stockid;
    }

    public BigInteger getPrescriptionissueid() {
        return prescriptionissueid;
    }

    public void setPrescriptionissueid(BigInteger prescriptionissueid) {
        this.prescriptionissueid = prescriptionissueid;
    }

    public Integer getQuantitydispensed() {
        return quantitydispensed;
    }

    public void setQuantitydispensed(Integer quantitydispensed) {
        this.quantitydispensed = quantitydispensed;
    }
    
}
