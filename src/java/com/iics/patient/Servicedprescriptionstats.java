/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "servicedprescriptionstats", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicedprescriptionstats.findAll", query = "SELECT s FROM Servicedprescriptionstats s")
    , @NamedQuery(name = "Servicedprescriptionstats.findByPrescriptionid", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Servicedprescriptionstats.findByPatientvisitid", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Servicedprescriptionstats.findByDateprescribed", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.dateprescribed = :dateprescribed")
    , @NamedQuery(name = "Servicedprescriptionstats.findByDestinationunitid", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Servicedprescriptionstats.findByServicedprescriptionid", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.servicedprescriptionid = :servicedprescriptionid")
    , @NamedQuery(name = "Servicedprescriptionstats.findByIssueditems", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.issueditems = :issueditems")
    , @NamedQuery(name = "Servicedprescriptionstats.findByNotissueditems", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.notissueditems = :notissueditems")
    , @NamedQuery(name = "Servicedprescriptionstats.findByAddedby", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Servicedprescriptionstats.findByDateadded", query = "SELECT s FROM Servicedprescriptionstats s WHERE s.dateadded = :dateadded")})
public class Servicedprescriptionstats implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    @Id
    private BigInteger prescriptionid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "dateprescribed")
    @Temporal(TemporalType.DATE)
    private Date dateprescribed;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Column(name = "servicedprescriptionid")
    private BigInteger servicedprescriptionid;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "issueditems")
    private BigDecimal issueditems;
    @Column(name = "notissueditems")
    private BigDecimal notissueditems;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;

    public Servicedprescriptionstats() {
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

    public BigInteger getDestinationunitid() {
        return destinationunitid;
    }

    public void setDestinationunitid(BigInteger destinationunitid) {
        this.destinationunitid = destinationunitid;
    }

    public BigInteger getServicedprescriptionid() {
        return servicedprescriptionid;
    }

    public void setServicedprescriptionid(BigInteger servicedprescriptionid) {
        this.servicedprescriptionid = servicedprescriptionid;
    }

    public BigDecimal getIssueditems() {
        return issueditems;
    }

    public void setIssueditems(BigDecimal issueditems) {
        this.issueditems = issueditems;
    }

    public BigDecimal getNotissueditems() {
        return notissueditems;
    }

    public void setNotissueditems(BigDecimal notissueditems) {
        this.notissueditems = notissueditems;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }
    
}
