/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "servicequeue", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicequeue.findAll", query = "SELECT s FROM Servicequeue s")
    , @NamedQuery(name = "Servicequeue.findByServicequeueid", query = "SELECT s FROM Servicequeue s WHERE s.servicequeueid = :servicequeueid")
    , @NamedQuery(name = "Servicequeue.findByUnitserviceid", query = "SELECT s FROM Servicequeue s WHERE s.unitserviceid = :unitserviceid")
    , @NamedQuery(name = "Servicequeue.findByTimein", query = "SELECT s FROM Servicequeue s WHERE s.timein = :timein")
    , @NamedQuery(name = "Servicequeue.findByTimeout", query = "SELECT s FROM Servicequeue s WHERE s.timeout = :timeout")
    , @NamedQuery(name = "Servicequeue.findByAddedby", query = "SELECT s FROM Servicequeue s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Servicequeue.findByServicedby", query = "SELECT s FROM Servicequeue s WHERE s.servicedby = :servicedby")})
public class Servicequeue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "servicequeueid", nullable = false)
    private Long servicequeueid;
    @Column(name = "unitserviceid")
    private BigInteger unitserviceid;
    @Column(name = "timein")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timein;
    @Column(name = "timeout")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeout;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "serviced")
    private Boolean serviced;
    @Column(name = "servicedby")
    private BigInteger servicedby;
    @JoinColumn(name = "patientvisitid", referencedColumnName = "patientvisitid")
    @ManyToOne
    private Patientvisit patientvisitid;
    @Column(name = "canceled")
    private Boolean canceled;
    @Column(name = "canceledby")
    private BigInteger canceledby;
    @Column(name = "timecanceled")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timecanceled;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ispopped")
    private boolean ispopped;
    
    public Servicequeue() {
    }

    public Servicequeue(Long servicequeueid) {
        this.servicequeueid = servicequeueid;
    }

    public Long getServicequeueid() {
        return servicequeueid;
    }

    public void setServicequeueid(Long servicequeueid) {
        this.servicequeueid = servicequeueid;
    }

    public BigInteger getUnitserviceid() {
        return unitserviceid;
    }

    public void setUnitserviceid(BigInteger unitserviceid) {
        this.unitserviceid = unitserviceid;
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

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public BigInteger getServicedby() {
        return servicedby;
    }

    public void setServicedby(BigInteger servicedby) {
        this.servicedby = servicedby;
    }

    public Patientvisit getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Patientvisit patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (servicequeueid != null ? servicequeueid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Servicequeue)) {
            return false;
        }
        Servicequeue other = (Servicequeue) object;
        if ((this.servicequeueid == null && other.servicequeueid != null) || (this.servicequeueid != null && !this.servicequeueid.equals(other.servicequeueid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Servicequeue[ servicequeueid=" + servicequeueid + " ]";
    }

    public Boolean getServiced() {
        return serviced;
    }

    public void setServiced(Boolean serviced) {
        this.serviced = serviced;
    }

    public Boolean getCanceled() {
        return canceled;
    }

    public void setCanceled(Boolean canceled) {
        this.canceled = canceled;
    }

    public BigInteger getCanceledby() {
        return canceledby;
    }

    public void setCanceledby(BigInteger canceledby) {
        this.canceledby = canceledby;
    }

    public Date getTimecanceled() {
        return timecanceled;
    }

    public void setTimecanceled(Date timecanceled) {
        this.timecanceled = timecanceled;
    }
    public boolean getIspopped() {
        return ispopped;
    }

    public void setIspopped(boolean ispopped) {
        this.ispopped = ispopped;
    }
}
