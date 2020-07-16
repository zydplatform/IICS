/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "supplieritem", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Supplieritem.findAll", query = "SELECT s FROM Supplieritem s")
    , @NamedQuery(name = "Supplieritem.findBySupplieritemid", query = "SELECT s FROM Supplieritem s WHERE s.supplieritemid = :supplieritemid")
    , @NamedQuery(name = "Supplieritem.findByPacksize", query = "SELECT s FROM Supplieritem s WHERE s.packsize = :packsize")
    , @NamedQuery(name = "Supplieritem.findByItemcost", query = "SELECT s FROM Supplieritem s WHERE s.itemcost = :itemcost")
    , @NamedQuery(name = "Supplieritem.findByItemcode", query = "SELECT s FROM Supplieritem s WHERE s.itemcode = :itemcode")
    , @NamedQuery(name = "Supplieritem.findByIsrestricted", query = "SELECT s FROM Supplieritem s WHERE s.isrestricted = :isrestricted")
    , @NamedQuery(name = "Supplieritem.findByTradename", query = "SELECT s FROM Supplieritem s WHERE s.tradename = :tradename")})
public class Supplieritem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "supplieritemid", nullable = false)
    private Long supplieritemid;
    @Column(name = "packsize")
    private Integer packsize;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "itemcost", precision = 17, scale = 17)
    private Double itemcost;
    @Size(max = 2147483647)
    @Column(name = "itemcode", length = 2147483647)
    private String itemcode;
    @Column(name = "isrestricted")
    private Boolean isrestricted;
    @Size(max = 255)
    @Column(name = "tradename", length = 255)
    private String tradename;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;
    @JoinColumn(name = "supplierid", referencedColumnName = "supplierid")
    @ManyToOne
    private Supplier supplierid;

    public Supplieritem() {
    }

    public Supplieritem(Long supplieritemid) {
        this.supplieritemid = supplieritemid;
    }

    public Long getSupplieritemid() {
        return supplieritemid;
    }

    public void setSupplieritemid(Long supplieritemid) {
        this.supplieritemid = supplieritemid;
    }

    public Integer getPacksize() {
        return packsize;
    }

    public void setPacksize(Integer packsize) {
        this.packsize = packsize;
    }

    public Double getItemcost() {
        return itemcost;
    }

    public void setItemcost(Double itemcost) {
        this.itemcost = itemcost;
    }

    public String getItemcode() {
        return itemcode;
    }

    public void setItemcode(String itemcode) {
        this.itemcode = itemcode;
    }

    public Boolean getIsrestricted() {
        return isrestricted;
    }

    public void setIsrestricted(Boolean isrestricted) {
        this.isrestricted = isrestricted;
    }

    public String getTradename() {
        return tradename;
    }

    public void setTradename(String tradename) {
        this.tradename = tradename;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    public Supplier getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(Supplier supplierid) {
        this.supplierid = supplierid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (supplieritemid != null ? supplieritemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Supplieritem)) {
            return false;
        }
        Supplieritem other = (Supplieritem) object;
        if ((this.supplieritemid == null && other.supplieritemid != null) || (this.supplieritemid != null && !this.supplieritemid.equals(other.supplieritemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Supplieritem[ supplieritemid=" + supplieritemid + " ]";
    }
    
}
