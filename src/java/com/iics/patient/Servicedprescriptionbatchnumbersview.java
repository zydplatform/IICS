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
@Table(name = "servicedprescriptionbatchnumbersview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findAll", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByPrescriptionid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByPatientvisitid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByItemname", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.itemname = :itemname")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByDose", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.dose = :dose")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByStatus", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.status = :status")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByQuantitydispensed", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.quantitydispensed = :quantitydispensed")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByItempackageid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.itempackageid = :itempackageid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByOriginunitid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.originunitid = :originunitid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByDestinationunitid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByNewprescriptionitemsid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByIsissued", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.isissued = :isissued")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByDateissued", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.dateissued = :dateissued")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByPrescriptionissueid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.prescriptionissueid = :prescriptionissueid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByStockid", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.stockid = :stockid")
    , @NamedQuery(name = "Servicedprescriptionbatchnumbersview.findByBatchnumber", query = "SELECT s FROM Servicedprescriptionbatchnumbersview s WHERE s.batchnumber = :batchnumber")})
public class Servicedprescriptionbatchnumbersview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    @Id
    private BigInteger prescriptionid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Size(max = 2147483647)
    @Column(name = "itemname")
    private String itemname;
    @Size(max = 2147483647)
    @Column(name = "dose")
    private String dose;
    @Size(max = 200)
    @Column(name = "status")
    private String status;
    @Column(name = "quantitydispensed")
    private Integer quantitydispensed;
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "originunitid")
    private BigInteger originunitid;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Column(name = "newprescriptionitemsid")
    private BigInteger newprescriptionitemsid;
    @Column(name = "isissued")
    private Boolean isissued;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "prescriptionissueid")
    private BigInteger prescriptionissueid;
    @Column(name = "stockid")
    private BigInteger stockid;
    @Size(max = 2147483647)
    @Column(name = "batchnumber")
    private String batchnumber;

    public Servicedprescriptionbatchnumbersview() {
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

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getQuantitydispensed() {
        return quantitydispensed;
    }

    public void setQuantitydispensed(Integer quantitydispensed) {
        this.quantitydispensed = quantitydispensed;
    }

    public BigInteger getItempackageid() {
        return itempackageid;
    }

    public void setItempackageid(BigInteger itempackageid) {
        this.itempackageid = itempackageid;
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

    public BigInteger getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(BigInteger newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public Boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(Boolean isissued) {
        this.isissued = isissued;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public BigInteger getPrescriptionissueid() {
        return prescriptionissueid;
    }

    public void setPrescriptionissueid(BigInteger prescriptionissueid) {
        this.prescriptionissueid = prescriptionissueid;
    }

    public BigInteger getStockid() {
        return stockid;
    }

    public void setStockid(BigInteger stockid) {
        this.stockid = stockid;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }
    
}
