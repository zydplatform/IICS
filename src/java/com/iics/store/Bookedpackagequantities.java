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
@Table(name = "bookedpackagequantities", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Bookedpackagequantities.findAll", query = "SELECT b FROM Bookedpackagequantities b")
    , @NamedQuery(name = "Bookedpackagequantities.findByItemid", query = "SELECT b FROM Bookedpackagequantities b WHERE b.itemid = :itemid")
    , @NamedQuery(name = "Bookedpackagequantities.findByFullname", query = "SELECT b FROM Bookedpackagequantities b WHERE b.fullname = :fullname")
    , @NamedQuery(name = "Bookedpackagequantities.findByTotalqtypicked", query = "SELECT b FROM Bookedpackagequantities b WHERE b.totalqtypicked = :totalqtypicked")
    , @NamedQuery(name = "Bookedpackagequantities.findByFacilityunitid", query = "SELECT b FROM Bookedpackagequantities b WHERE b.facilityunitid = :facilityunitid")})
public class Bookedpackagequantities implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "fullname")
    private String fullname;
    @Column(name = "totalqtypicked")
    private BigInteger totalqtypicked;
    @Column(name = "facilityunitid")
    @Id
    private BigInteger facilityunitid;

    public Bookedpackagequantities() {
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public BigInteger getTotalqtypicked() {
        return totalqtypicked;
    }

    public void setTotalqtypicked(BigInteger totalqtypicked) {
        this.totalqtypicked = totalqtypicked;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }
    
}
