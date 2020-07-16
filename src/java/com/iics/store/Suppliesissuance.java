/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "suppliesissuance", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Suppliesissuance.findAll", query = "SELECT s FROM Suppliesissuance s")
    , @NamedQuery(name = "Suppliesissuance.findBySuppliesissuanceid", query = "SELECT s FROM Suppliesissuance s WHERE s.suppliesissuanceid = :suppliesissuanceid")
    , @NamedQuery(name = "Suppliesissuance.findByQtyissued", query = "SELECT s FROM Suppliesissuance s WHERE s.qtyissued = :qtyissued")})
public class Suppliesissuance implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "suppliesissuanceid", nullable = false)
    private Long suppliesissuanceid;
    @Column(name = "qtyissued")
    private Integer qtyissued;
    @Column(name = "stockid")
    private BigInteger stockid;
    @Column(name = "suppliesorderitemsid")
    private BigInteger suppliesorderitemsid;

    public Suppliesissuance() {
    }

    public Suppliesissuance(Long suppliesissuanceid) {
        this.suppliesissuanceid = suppliesissuanceid;
    }

    public Long getSuppliesissuanceid() {
        return suppliesissuanceid;
    }

    public void setSuppliesissuanceid(Long suppliesissuanceid) {
        this.suppliesissuanceid = suppliesissuanceid;
    }

    public Integer getQtyissued() {
        return qtyissued;
    }

    public void setQtyissued(Integer qtyissued) {
        this.qtyissued = qtyissued;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (suppliesissuanceid != null ? suppliesissuanceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Suppliesissuance)) {
            return false;
        }
        Suppliesissuance other = (Suppliesissuance) object;
        if ((this.suppliesissuanceid == null && other.suppliesissuanceid != null) || (this.suppliesissuanceid != null && !this.suppliesissuanceid.equals(other.suppliesissuanceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Suppliesissuance[ suppliesissuanceid=" + suppliesissuanceid + " ]";
    }

    public BigInteger getStockid() {
        return stockid;
    }

    public void setStockid(BigInteger stockid) {
        this.stockid = stockid;
    }

    public BigInteger getSuppliesorderitemsid() {
        return suppliesorderitemsid;
    }

    public void setSuppliesorderitemsid(BigInteger suppliesorderitemsid) {
        this.suppliesorderitemsid = suppliesorderitemsid;
    }
    
}
