/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
@Table(name = "orderitemsview", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Orderitemsview.findAll", query = "SELECT o FROM Orderitemsview o")
    , @NamedQuery(name = "Orderitemsview.findByFacilityorderid", query = "SELECT o FROM Orderitemsview o WHERE o.facilityorderid = :facilityorderid")
    , @NamedQuery(name = "Orderitemsview.findByFacilityorderno", query = "SELECT o FROM Orderitemsview o WHERE o.facilityorderno = :facilityorderno")
    , @NamedQuery(name = "Orderitemsview.findByStatus", query = "SELECT o FROM Orderitemsview o WHERE o.status = :status")
    , @NamedQuery(name = "Orderitemsview.findByOrdertype", query = "SELECT o FROM Orderitemsview o WHERE o.ordertype = :ordertype")
    , @NamedQuery(name = "Orderitemsview.findByPickedby", query = "SELECT o FROM Orderitemsview o WHERE o.pickedby = :pickedby")
    , @NamedQuery(name = "Orderitemsview.findByItemid", query = "SELECT o FROM Orderitemsview o WHERE o.itemid = :itemid")
    , @NamedQuery(name = "Orderitemsview.findByQtyordered", query = "SELECT o FROM Orderitemsview o WHERE o.qtyordered = :qtyordered")
    , @NamedQuery(name = "Orderitemsview.findByQtyapproved", query = "SELECT o FROM Orderitemsview o WHERE o.qtyapproved = :qtyapproved")})
public class Orderitemsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "facilityorderid")
    private BigInteger facilityorderid;
    @Size(max = 2147483647)
    @Column(name = "facilityorderno", length = 2147483647)
    private String facilityorderno;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Size(max = 2147483647)
    @Column(name = "ordertype", length = 2147483647)
    private String ordertype;
    @Column(name = "pickedby")
    private BigInteger pickedby;
    @Id
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "qtyordered")
    private BigInteger qtyordered;
    @Column(name = "qtyapproved")
    private BigInteger qtyapproved;

    public Orderitemsview() {
    }

    public BigInteger getFacilityorderid() {
        return facilityorderid;
    }

    public void setFacilityorderid(BigInteger facilityorderid) {
        this.facilityorderid = facilityorderid;
    }

    public String getFacilityorderno() {
        return facilityorderno;
    }

    public void setFacilityorderno(String facilityorderno) {
        this.facilityorderno = facilityorderno;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrdertype() {
        return ordertype;
    }

    public void setOrdertype(String ordertype) {
        this.ordertype = ordertype;
    }

    public BigInteger getPickedby() {
        return pickedby;
    }

    public void setPickedby(BigInteger pickedby) {
        this.pickedby = pickedby;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public BigInteger getQtyordered() {
        return qtyordered;
    }

    public void setQtyordered(BigInteger qtyordered) {
        this.qtyordered = qtyordered;
    }

    public BigInteger getQtyapproved() {
        return qtyapproved;
    }

    public void setQtyapproved(BigInteger qtyapproved) {
        this.qtyapproved = qtyapproved;
    }
    
}
