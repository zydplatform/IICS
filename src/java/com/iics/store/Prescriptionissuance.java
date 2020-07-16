/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "prescriptionissuance", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prescriptionissuance.findAll", query = "SELECT p FROM Prescriptionissuance p")
    , @NamedQuery(name = "Prescriptionissuance.findByPrescriptionissuanceid", query = "SELECT p FROM Prescriptionissuance p WHERE p.prescriptionissuanceid = :prescriptionissuanceid")
    , @NamedQuery(name = "Prescriptionissuance.findByQuantityissued", query = "SELECT p FROM Prescriptionissuance p WHERE p.quantityissued = :quantityissued")
    , @NamedQuery(name = "Prescriptionissuance.findByPrescriptionid", query = "SELECT p FROM Prescriptionissuance p WHERE p.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Prescriptionissuance.findByDateissued", query = "SELECT p FROM Prescriptionissuance p WHERE p.dateissued = :dateissued")
    , @NamedQuery(name = "Prescriptionissuance.findByIssuedby", query = "SELECT p FROM Prescriptionissuance p WHERE p.issuedby = :issuedby")})
public class Prescriptionissuance implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prescriptionissuanceid", nullable = false)
    private Long prescriptionissuanceid;
    @Column(name = "quantityissued")
    private Integer quantityissued;
    @Column(name = "prescriptionid")
    private BigInteger prescriptionid;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "issuedby")
    private BigInteger issuedby;
    @JoinColumn(name = "stockid", referencedColumnName = "stockid")
    @ManyToOne
    private Stock stockid;

    public Prescriptionissuance() {
    }

    public Prescriptionissuance(Long prescriptionissuanceid) {
        this.prescriptionissuanceid = prescriptionissuanceid;
    }

    public Long getPrescriptionissuanceid() {
        return prescriptionissuanceid;
    }

    public void setPrescriptionissuanceid(Long prescriptionissuanceid) {
        this.prescriptionissuanceid = prescriptionissuanceid;
    }

    public Integer getQuantityissued() {
        return quantityissued;
    }

    public void setQuantityissued(Integer quantityissued) {
        this.quantityissued = quantityissued;
    }

    public BigInteger getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(BigInteger prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public BigInteger getIssuedby() {
        return issuedby;
    }

    public void setIssuedby(BigInteger issuedby) {
        this.issuedby = issuedby;
    }

    public Stock getStockid() {
        return stockid;
    }

    public void setStockid(Stock stockid) {
        this.stockid = stockid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (prescriptionissuanceid != null ? prescriptionissuanceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prescriptionissuance)) {
            return false;
        }
        Prescriptionissuance other = (Prescriptionissuance) object;
        if ((this.prescriptionissuanceid == null && other.prescriptionissuanceid != null) || (this.prescriptionissuanceid != null && !this.prescriptionissuanceid.equals(other.prescriptionissuanceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Prescriptionissuance[ prescriptionissuanceid=" + prescriptionissuanceid + " ]";
    }
    
}
