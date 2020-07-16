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
@Table(name = "shelflog", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Shelflog.findAll", query = "SELECT s FROM Shelflog s")
    , @NamedQuery(name = "Shelflog.findByShelflogid", query = "SELECT s FROM Shelflog s WHERE s.shelflogid = :shelflogid")
    , @NamedQuery(name = "Shelflog.findByLogtype", query = "SELECT s FROM Shelflog s WHERE s.logtype = :logtype")
    , @NamedQuery(name = "Shelflog.findByQuantity", query = "SELECT s FROM Shelflog s WHERE s.quantity = :quantity")
    , @NamedQuery(name = "Shelflog.findByStaffid", query = "SELECT s FROM Shelflog s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Shelflog.findByDatelogged", query = "SELECT s FROM Shelflog s WHERE s.datelogged = :datelogged")})
public class Shelflog implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "shelflogid", nullable = false)
    private Long shelflogid;
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
    @JoinColumn(name = "cellid", referencedColumnName = "bayrowcellid")
    @ManyToOne
    private Bayrowcell cellid;
    @JoinColumn(name = "stockid", referencedColumnName = "stockid")
    @ManyToOne
    private Stock stockid;

    public Shelflog() {
    }

    public Shelflog(Long shelflogid) {
        this.shelflogid = shelflogid;
    }

    public Long getShelflogid() {
        return shelflogid;
    }

    public void setShelflogid(Long shelflogid) {
        this.shelflogid = shelflogid;
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

    public Bayrowcell getCellid() {
        return cellid;
    }

    public void setCellid(Bayrowcell cellid) {
        this.cellid = cellid;
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
        hash += (shelflogid != null ? shelflogid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Shelflog)) {
            return false;
        }
        Shelflog other = (Shelflog) object;
        if ((this.shelflogid == null && other.shelflogid != null) || (this.shelflogid != null && !this.shelflogid.equals(other.shelflogid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Shelflog[ shelflogid=" + shelflogid + " ]";
    }
    
}
