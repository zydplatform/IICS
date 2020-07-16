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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "unservicedprescriptionsview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unservicedprescriptionsview.findAll", query = "SELECT u FROM Unservicedprescriptionsview u")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByPrescriptionid", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByPatientvisitid", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByDateprescribed", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.dateprescribed = :dateprescribed")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByStatus", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.status = :status")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByAddedby", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.addedby = :addedby")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByDestinationunitid", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByOriginunitid", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.originunitid = :originunitid")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByReferencenumber", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.referencenumber = :referencenumber")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByServicequeueid", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.servicequeueid = :servicequeueid")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByServiced", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.serviced = :serviced")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByServicedby", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.servicedby = :servicedby")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByTimein", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.timein = :timein")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByTimeout", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.timeout = :timeout")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByUnitserviceid", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.unitserviceid = :unitserviceid")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByCanceled", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.canceled = :canceled")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByCanceledby", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.canceledby = :canceledby")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByTimecanceled", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.timecanceled = :timecanceled")
    , @NamedQuery(name = "Unservicedprescriptionsview.findByIspopped", query = "SELECT u FROM Unservicedprescriptionsview u WHERE u.ispopped = :ispopped")})
public class Unservicedprescriptionsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    @Id
    private BigInteger prescriptionid;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "dateprescribed")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateprescribed;
    @Size(max = 200)
    @Column(name = "status")
    private String status;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Column(name = "originunitid")
    private BigInteger originunitid;
    @Size(max = 2147483647)
    @Column(name = "referencenumber")
    private String referencenumber;
    @Column(name = "servicequeueid")
    private BigInteger servicequeueid;
    @Column(name = "serviced")
    private Boolean serviced;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "servicedby")
    private BigDecimal servicedby;
    @Column(name = "timein")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timein;
    @Column(name = "timeout")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeout;
    @Column(name = "unitserviceid")
    private BigDecimal unitserviceid;
    @Column(name = "canceled")
    private Boolean canceled;
    @Column(name = "canceledby")
    private BigDecimal canceledby;
    @Column(name = "timecanceled")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timecanceled;
    @Column(name = "ispopped")
    private Boolean ispopped;

    public Unservicedprescriptionsview() {
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

    public String getReferencenumber() {
        return referencenumber;
    }

    public void setReferencenumber(String referencenumber) {
        this.referencenumber = referencenumber;
    }

    public BigInteger getServicequeueid() {
        return servicequeueid;
    }

    public void setServicequeueid(BigInteger servicequeueid) {
        this.servicequeueid = servicequeueid;
    }

    public Boolean getServiced() {
        return serviced;
    }

    public void setServiced(Boolean serviced) {
        this.serviced = serviced;
    }

    public BigDecimal getServicedby() {
        return servicedby;
    }

    public void setServicedby(BigDecimal servicedby) {
        this.servicedby = servicedby;
    }

    public Date getTimein() {
        return timein;
    }

    public void setTimein(Date timein) {
        this.timein = timein;
    }

    public Date getTimeout() {
        return timeout;
    }

    public void setTimeout(Date timeout) {
        this.timeout = timeout;
    }

    public BigDecimal getUnitserviceid() {
        return unitserviceid;
    }

    public void setUnitserviceid(BigDecimal unitserviceid) {
        this.unitserviceid = unitserviceid;
    }

    public Boolean getCanceled() {
        return canceled;
    }

    public void setCanceled(Boolean canceled) {
        this.canceled = canceled;
    }

    public BigDecimal getCanceledby() {
        return canceledby;
    }

    public void setCanceledby(BigDecimal canceledby) {
        this.canceledby = canceledby;
    }

    public Date getTimecanceled() {
        return timecanceled;
    }

    public void setTimecanceled(Date timecanceled) {
        this.timecanceled = timecanceled;
    }

    public Boolean getIspopped() {
        return ispopped;
    }

    public void setIspopped(Boolean ispopped) {
        this.ispopped = ispopped;
    }
    
}
