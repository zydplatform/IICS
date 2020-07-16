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
@Table(name = "stocklog", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stocklog.findAll", query = "SELECT s FROM Stocklog s")
    , @NamedQuery(name = "Stocklog.findByStockflogid", query = "SELECT s FROM Stocklog s WHERE s.stockflogid = :stockflogid")
    , @NamedQuery(name = "Stocklog.findByLogtype", query = "SELECT s FROM Stocklog s WHERE s.logtype = :logtype")
    , @NamedQuery(name = "Stocklog.findByQuantity", query = "SELECT s FROM Stocklog s WHERE s.quantity = :quantity")
    , @NamedQuery(name = "Stocklog.findByStaffid", query = "SELECT s FROM Stocklog s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Stocklog.findByDatelogged", query = "SELECT s FROM Stocklog s WHERE s.datelogged = :datelogged")})
public class Stocklog implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "stockflogid", nullable = false)
    private Long stockflogid;
    @Size(max = 255)
    @Column(name = "logtype", length = 255)
    private String logtype;
    @Column(name = "quantity")
    private Integer quantity;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "datelogged")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datelogged;
    @JoinColumn(name = "stockid", referencedColumnName = "stockid")
    @ManyToOne
    private Stock stockid;
    @Column(name = "referencetype")
    private String referencetype;
    @Column(name = "reference")
    private BigInteger reference;
    @Column(name = "referencenumber")
    private String referencenumber;

    public Stocklog() {
    }

    public Stocklog(Long stockflogid) {
        this.stockflogid = stockflogid;
    }

    public Long getStockflogid() {
        return stockflogid;
    }

    public void setStockflogid(Long stockflogid) {
        this.stockflogid = stockflogid;
    }

    public String getLogtype() {
        return logtype;
    }

    public void setLogtype(String logtype) {
        this.logtype = logtype;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public Date getDatelogged() {
        return datelogged;
    }

    public void setDatelogged(Date datelogged) {
        this.datelogged = datelogged;
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
        hash += (stockflogid != null ? stockflogid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stocklog)) {
            return false;
        }
        Stocklog other = (Stocklog) object;
        if ((this.stockflogid == null && other.stockflogid != null) || (this.stockflogid != null && !this.stockflogid.equals(other.stockflogid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Stocklog[ stockflogid=" + stockflogid + " ]";
    }

    public String getReferencetype() {
        return referencetype;
    }

    public void setReferencetype(String referencetype) {
        this.referencetype = referencetype;
    }

    public BigInteger getReference() {
        return reference;
    }

    public void setReference(BigInteger reference) {
        this.reference = reference;
    }

    public String getReferencenumber() {
        return referencenumber;
    }

    public void setReferencenumber(String referencenumber) {
        this.referencenumber = referencenumber;
    }
    
}
