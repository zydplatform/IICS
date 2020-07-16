/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "picklist", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Picklist.findAll", query = "SELECT p FROM Picklist p")
    , @NamedQuery(name = "Picklist.findByPicklistid", query = "SELECT p FROM Picklist p WHERE p.picklistid = :picklistid")
    , @NamedQuery(name = "Picklist.findByQuantitypicked", query = "SELECT p FROM Picklist p WHERE p.quantitypicked = :quantitypicked")
    , @NamedQuery(name = "Picklist.findByAddedby", query = "SELECT p FROM Picklist p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Picklist.findByDateadded", query = "SELECT p FROM Picklist p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Picklist.findByBayrowcellid", query = "SELECT p FROM Picklist p WHERE p.bayrowcellid = :bayrowcellid")
    , @NamedQuery(name = "Picklist.findByItemid", query = "SELECT p FROM Picklist p WHERE p.itemid = :itemid")
    , @NamedQuery(name = "Picklist.findByStockid", query = "SELECT p FROM Picklist p WHERE p.stockid = :stockid")})
public class Picklist implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "picklistid")
    private Long picklistid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "quantitypicked")
    private long quantitypicked;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "bayrowcellid")
    private int bayrowcellid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "itemid")
    private long itemid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "stockid")
    private long stockid;

    public Picklist() {
    }

    public Picklist(Long picklistid) {
        this.picklistid = picklistid;
    }

    public Picklist(Long picklistid, long quantitypicked, long addedby, Date dateadded, int bayrowcellid, long itemid, long stockid) {
        this.picklistid = picklistid;
        this.quantitypicked = quantitypicked;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.bayrowcellid = bayrowcellid;
        this.itemid = itemid;
        this.stockid = stockid;
    }

    public Long getPicklistid() {
        return picklistid;
    }

    public void setPicklistid(Long picklistid) {
        this.picklistid = picklistid;
    }

    public long getQuantitypicked() {
        return quantitypicked;
    }

    public void setQuantitypicked(long quantitypicked) {
        this.quantitypicked = quantitypicked;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public int getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(int bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public long getItemid() {
        return itemid;
    }

    public void setItemid(long itemid) {
        this.itemid = itemid;
    }

    public long getStockid() {
        return stockid;
    }

    public void setStockid(long stockid) {
        this.stockid = stockid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (picklistid != null ? picklistid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Picklist)) {
            return false;
        }
        Picklist other = (Picklist) object;
        if ((this.picklistid == null && other.picklistid != null) || (this.picklistid != null && !this.picklistid.equals(other.picklistid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Picklist[ picklistid=" + picklistid + " ]";
    }
    
}
