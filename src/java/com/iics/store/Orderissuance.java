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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "orderissuance", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Orderissuance.findAll", query = "SELECT o FROM Orderissuance o")
    , @NamedQuery(name = "Orderissuance.findByOrderissuanceid", query = "SELECT o FROM Orderissuance o WHERE o.orderissuanceid = :orderissuanceid")
    , @NamedQuery(name = "Orderissuance.findByQuantitydelivered", query = "SELECT o FROM Orderissuance o WHERE o.quantitydelivered = :quantitydelivered")
    , @NamedQuery(name = "Orderissuance.findByQtypicked", query = "SELECT o FROM Orderissuance o WHERE o.qtypicked = :qtypicked")})
public class Orderissuance implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "orderissuanceid", nullable = false)
    private Long orderissuanceid;
    @Column(name = "quantitydelivered")
    private Integer quantitydelivered;
    @Column(name = "qtypicked")
    private Integer qtypicked;
    @JoinColumn(name = "facilityorderitemsid", referencedColumnName = "facilityorderitemsid")
    @ManyToOne
    private Facilityorderitems facilityorderitemsid;
    @JoinColumn(name = "stockid", referencedColumnName = "stockid")
    @ManyToOne
    private Stock stockid;
    @Column(name = "unitquantityreceived")
    private Integer unitquantityreceived;

    public Orderissuance() {
    }

    public Orderissuance(Long orderissuanceid) {
        this.orderissuanceid = orderissuanceid;
    }

    public Long getOrderissuanceid() {
        return orderissuanceid;
    }

    public void setOrderissuanceid(Long orderissuanceid) {
        this.orderissuanceid = orderissuanceid;
    }

    public Integer getQuantitydelivered() {
        return quantitydelivered;
    }

    public void setQuantitydelivered(Integer quantitydelivered) {
        this.quantitydelivered = quantitydelivered;
    }

    public Integer getQtypicked() {
        return qtypicked;
    }

    public void setQtypicked(Integer qtypicked) {
        this.qtypicked = qtypicked;
    }

    public Facilityorderitems getFacilityorderitemsid() {
        return facilityorderitemsid;
    }

    public void setFacilityorderitemsid(Facilityorderitems facilityorderitemsid) {
        this.facilityorderitemsid = facilityorderitemsid;
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
        hash += (orderissuanceid != null ? orderissuanceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Orderissuance)) {
            return false;
        }
        Orderissuance other = (Orderissuance) object;
        if ((this.orderissuanceid == null && other.orderissuanceid != null) || (this.orderissuanceid != null && !this.orderissuanceid.equals(other.orderissuanceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Orderissuance[ orderissuanceid=" + orderissuanceid + " ]";
    }

    public Integer getUnitquantityreceived() {
        return unitquantityreceived;
    }

    public void setUnitquantityreceived(Integer unitquantityreceived) {
        this.unitquantityreceived = unitquantityreceived;
    }
    
}
