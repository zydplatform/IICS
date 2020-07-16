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
@Table(name = "suppliesorderitems", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Suppliesorderitems.findAll", query = "SELECT s FROM Suppliesorderitems s")
    , @NamedQuery(name = "Suppliesorderitems.findBySuppliesorderitemsid", query = "SELECT s FROM Suppliesorderitems s WHERE s.suppliesorderitemsid = :suppliesorderitemsid")
    , @NamedQuery(name = "Suppliesorderitems.findByItemid", query = "SELECT s FROM Suppliesorderitems s WHERE s.itemid = :itemid")
    , @NamedQuery(name = "Suppliesorderitems.findByQtyordered", query = "SELECT s FROM Suppliesorderitems s WHERE s.qtyordered = :qtyordered")
    , @NamedQuery(name = "Suppliesorderitems.findByQtyreceived", query = "SELECT s FROM Suppliesorderitems s WHERE s.qtyreceived = :qtyreceived")
    , @NamedQuery(name = "Suppliesorderitems.findByQtyapproved", query = "SELECT s FROM Suppliesorderitems s WHERE s.qtyapproved = :qtyapproved")})
public class Suppliesorderitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "suppliesorderitemsid", nullable = false)
    private Long suppliesorderitemsid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "qtyordered")
    private Integer qtyordered;
    @Column(name = "qtyreceived")
    private Integer qtyreceived;
    @Column(name = "qtyapproved")
    private Integer qtyapproved;
    @Column(name = "suppliesorderid")
    private BigInteger suppliesorderid;
    @Column(name = "isissued")
    private Boolean isissued;
    @Column(name = "isapproved")
    private Boolean isapproved;

    public Suppliesorderitems() {
    }

    public Suppliesorderitems(Long suppliesorderitemsid) {
        this.suppliesorderitemsid = suppliesorderitemsid;
    }

    public Long getSuppliesorderitemsid() {
        return suppliesorderitemsid;
    }

    public void setSuppliesorderitemsid(Long suppliesorderitemsid) {
        this.suppliesorderitemsid = suppliesorderitemsid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public Integer getQtyordered() {
        return qtyordered;
    }

    public void setQtyordered(Integer qtyordered) {
        this.qtyordered = qtyordered;
    }

    public Integer getQtyreceived() {
        return qtyreceived;
    }

    public void setQtyreceived(Integer qtyreceived) {
        this.qtyreceived = qtyreceived;
    }

    public Integer getQtyapproved() {
        return qtyapproved;
    }

    public void setQtyapproved(Integer qtyapproved) {
        this.qtyapproved = qtyapproved;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (suppliesorderitemsid != null ? suppliesorderitemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Suppliesorderitems)) {
            return false;
        }
        Suppliesorderitems other = (Suppliesorderitems) object;
        if ((this.suppliesorderitemsid == null && other.suppliesorderitemsid != null) || (this.suppliesorderitemsid != null && !this.suppliesorderitemsid.equals(other.suppliesorderitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Suppliesorderitems[ suppliesorderitemsid=" + suppliesorderitemsid + " ]";
    }

    public BigInteger getSuppliesorderid() {
        return suppliesorderid;
    }

    public void setSuppliesorderid(BigInteger suppliesorderid) {
        this.suppliesorderid = suppliesorderid;
    }

    public Boolean getIsissued() {
        return isissued;
    }

    public void setIsissued(Boolean isissued) {
        this.isissued = isissued;
    }

    public Boolean getIsapproved() {
        return isapproved;
    }

    public void setIsapproved(Boolean isapproved) {
        this.isapproved = isapproved;
    }
    
}
