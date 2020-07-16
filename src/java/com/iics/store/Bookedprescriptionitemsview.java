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
 * @author IICS TECHS
 */
@Entity
@Table(name = "bookedprescriptionitemsview", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Bookedprescriptionitemsview.findAll", query = "SELECT b FROM Bookedprescriptionitemsview b")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByPrescriptionid", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.prescriptionid = :prescriptionid")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByDestinationunitid", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByNewprescriptionitemsid", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.newprescriptionitemsid = :newprescriptionitemsid")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByItemid", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.itemid = :itemid")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByDays", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.days = :days")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByIsapproved", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.isapproved = :isapproved")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByQuantityapproved", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.quantityapproved = :quantityapproved")
    , @NamedQuery(name = "Bookedprescriptionitemsview.findByItemstrength", query = "SELECT b FROM Bookedprescriptionitemsview b WHERE b.itemstrength = :itemstrength")})
public class Bookedprescriptionitemsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "prescriptionid")
    @Id
    private BigInteger prescriptionid;
    @Column(name = "destinationunitid")
    private BigInteger destinationunitid;
    @Column(name = "newprescriptionitemsid")
    private BigInteger newprescriptionitemsid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "days")
    private Integer days;
    @Column(name = "isapproved")
    private Boolean isapproved;
    @Column(name = "quantityapproved")
    private Integer quantityapproved;
    @Size(max = 2147483647)
    @Column(name = "itemstrength")
    private String itemstrength;

    public Bookedprescriptionitemsview() {
    }

    public BigInteger getPrescriptionid() {
        return prescriptionid;
    }

    public void setPrescriptionid(BigInteger prescriptionid) {
        this.prescriptionid = prescriptionid;
    }

    public BigInteger getDestinationunitid() {
        return destinationunitid;
    }

    public void setDestinationunitid(BigInteger destinationunitid) {
        this.destinationunitid = destinationunitid;
    }

    public BigInteger getNewprescriptionitemsid() {
        return newprescriptionitemsid;
    }

    public void setNewprescriptionitemsid(BigInteger newprescriptionitemsid) {
        this.newprescriptionitemsid = newprescriptionitemsid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public Integer getDays() {
        return days;
    }

    public void setDays(Integer days) {
        this.days = days;
    }

    public Boolean getIsapproved() {
        return isapproved;
    }

    public void setIsapproved(Boolean isapproved) {
        this.isapproved = isapproved;
    }

    public Integer getQuantityapproved() {
        return quantityapproved;
    }

    public void setQuantityapproved(Integer quantityapproved) {
        this.quantityapproved = quantityapproved;
    }

    public String getItemstrength() {
        return itemstrength;
    }

    public void setItemstrength(String itemstrength) {
        this.itemstrength = itemstrength;
    }
    
}
