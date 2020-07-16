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
 * @author IICS TECHS
 */
@Entity
@Table(name = "newprescriptionissueview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Newprescriptionissueview.findAll", query = "SELECT n FROM Newprescriptionissueview n")
    , @NamedQuery(name = "Newprescriptionissueview.findByPrescriptionid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Newprescriptionissueview.findByPatientvisitid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Newprescriptionissueview.findByOriginunitid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.originunitid = :originunitid")
    , @NamedQuery(name = "Newprescriptionissueview.findByDestinationunitid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Newprescriptionissueview.findByStatus", query = "SELECT n FROM Newprescriptionissueview n WHERE n.status = :status")
    , @NamedQuery(name = "Newprescriptionissueview.findByNewprescriptionitemsid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Newprescriptionissueview.findByItemname", query = "SELECT n FROM Newprescriptionissueview n WHERE n.itemname = :itemname")
    , @NamedQuery(name = "Newprescriptionissueview.findByDose", query = "SELECT n FROM Newprescriptionissueview n WHERE n.dose = :dose")
    , @NamedQuery(name = "Newprescriptionissueview.findByIsissued", query = "SELECT n FROM Newprescriptionissueview n WHERE n.isissued = :isissued")
    , @NamedQuery(name = "Newprescriptionissueview.findByItempackageid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.itempackageid = :itempackageid")
    , @NamedQuery(name = "Newprescriptionissueview.findByDateissued", query = "SELECT n FROM Newprescriptionissueview n WHERE n.dateissued = :dateissued")
    , @NamedQuery(name = "Newprescriptionissueview.findByStockid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.stockid = :stockid")
    , @NamedQuery(name = "Newprescriptionissueview.findByQuantitydispensed", query = "SELECT n FROM Newprescriptionissueview n WHERE n.quantitydispensed = :quantitydispensed")
    , @NamedQuery(name = "Newprescriptionissueview.findByPrescriptionissueid", query = "SELECT n FROM Newprescriptionissueview n WHERE n.prescriptionissueid = :prescriptionissueid")
    , @NamedQuery(name = "Newprescriptionissueview.findByFullname", query = "SELECT n FROM Newprescriptionissueview n WHERE n.fullname = :fullname")})
public class Newprescriptionissueview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    @Id
    private BigInteger prescriptionid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "originunitid")
    private BigInteger originunitid;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Size(max = 200)
    @Column(name = "status")
    private String status;
    @Column(name = "newprescriptionitemsid")
    private BigInteger newprescriptionitemsid;
    @Size(max = 2147483647)
    @Column(name = "itemname")
    private String itemname;
    @Size(max = 2147483647)
    @Column(name = "dose")
    private String dose;
    @Column(name = "isissued")
    private Boolean isissued;
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "stockid")
    private BigInteger stockid;
    @Column(name = "quantitydispensed")
    private Integer quantitydispensed;
    @Column(name = "prescriptionissueid")
    private BigInteger prescriptionissueid;
    @Size(max = 2147483647)
    @Column(name = "fullname")
    private String fullname;

    public Newprescriptionissueview() {
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

    public BigInteger getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(BigInteger newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
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

    public Integer getQuantitydispensed() {
        return quantitydispensed;
    }

    public void setQuantitydispensed(Integer quantitydispensed) {
        this.quantitydispensed = quantitydispensed;
    }

    public BigInteger getPrescriptionissueid() {
        return prescriptionissueid;
    }

    public void setPrescriptionissueid(BigInteger prescriptionissueid) {
        this.prescriptionissueid = prescriptionissueid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    
}
