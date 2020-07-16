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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "discrepancy", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Discrepancy.findAll", query = "SELECT d FROM Discrepancy d")
    , @NamedQuery(name = "Discrepancy.findByDiscrepancyid", query = "SELECT d FROM Discrepancy d WHERE d.discrepancyid = :discrepancyid")
    , @NamedQuery(name = "Discrepancy.findByDiscrepancytype", query = "SELECT d FROM Discrepancy d WHERE d.discrepancytype = :discrepancytype")
    , @NamedQuery(name = "Discrepancy.findByQuantity", query = "SELECT d FROM Discrepancy d WHERE d.quantity = :quantity")
    , @NamedQuery(name = "Discrepancy.findByLoggedby", query = "SELECT d FROM Discrepancy d WHERE d.loggedby = :loggedby")
    , @NamedQuery(name = "Discrepancy.findByDatelogged", query = "SELECT d FROM Discrepancy d WHERE d.datelogged = :datelogged")
    , @NamedQuery(name = "Discrepancy.findByDateadded", query = "SELECT d FROM Discrepancy d WHERE d.dateadded = :dateadded")
    , @NamedQuery(name = "Discrepancy.findByAddedby", query = "SELECT d FROM Discrepancy d WHERE d.addedby = :addedby")})
public class Discrepancy implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "discrepancyid", nullable = false)
    private Long discrepancyid;
    @Size(max = 200)
    @Column(name = "discrepancytype", length = 200)
    private String discrepancytype;
    @Column(name = "quantity")
    private Integer quantity;
    @Column(name = "loggedby")
    private BigInteger loggedby;
    @Column(name = "datelogged")
    @Temporal(TemporalType.DATE)
    private Date datelogged;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @JoinColumn(name = "stockid", referencedColumnName = "stockid")
    @ManyToOne
    private Stock stockid;

    public Discrepancy() {
    }

    public Discrepancy(Long discrepancyid) {
        this.discrepancyid = discrepancyid;
    }

    public Long getDiscrepancyid() {
        return discrepancyid;
    }

    public void setDiscrepancyid(Long discrepancyid) {
        this.discrepancyid = discrepancyid;
    }

    public String getDiscrepancytype() {
        return discrepancytype;
    }

    public void setDiscrepancytype(String discrepancytype) {
        this.discrepancytype = discrepancytype;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigInteger getLoggedby() {
        return loggedby;
    }

    public void setLoggedby(BigInteger loggedby) {
        this.loggedby = loggedby;
    }

    public Date getDatelogged() {
        return datelogged;
    }

    public void setDatelogged(Date datelogged) {
        this.datelogged = datelogged;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
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
        hash += (discrepancyid != null ? discrepancyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Discrepancy)) {
            return false;
        }
        Discrepancy other = (Discrepancy) object;
        if ((this.discrepancyid == null && other.discrepancyid != null) || (this.discrepancyid != null && !this.discrepancyid.equals(other.discrepancyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Discrepancy[ discrepancyid=" + discrepancyid + " ]";
    }
    
}
