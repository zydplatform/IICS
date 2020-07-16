/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
@Table(name = "facilitystocklog", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitystocklog.findAll", query = "SELECT f FROM Facilitystocklog f")
    , @NamedQuery(name = "Facilitystocklog.findByStockflogid", query = "SELECT f FROM Facilitystocklog f WHERE f.stockflogid = :stockflogid")
    , @NamedQuery(name = "Facilitystocklog.findByItemid", query = "SELECT f FROM Facilitystocklog f WHERE f.itemid = :itemid")
    , @NamedQuery(name = "Facilitystocklog.findByStockid", query = "SELECT f FROM Facilitystocklog f WHERE f.stockid = :stockid")
    , @NamedQuery(name = "Facilitystocklog.findByLogtype", query = "SELECT f FROM Facilitystocklog f WHERE f.logtype = :logtype")
    , @NamedQuery(name = "Facilitystocklog.findByQuantity", query = "SELECT f FROM Facilitystocklog f WHERE f.quantity = :quantity")
    , @NamedQuery(name = "Facilitystocklog.findByStaffid", query = "SELECT f FROM Facilitystocklog f WHERE f.staffid = :staffid")
    , @NamedQuery(name = "Facilitystocklog.findByDatelogged", query = "SELECT f FROM Facilitystocklog f WHERE f.datelogged = :datelogged")
    , @NamedQuery(name = "Facilitystocklog.findByReferencetype", query = "SELECT f FROM Facilitystocklog f WHERE f.referencetype = :referencetype")
    , @NamedQuery(name = "Facilitystocklog.findByReference", query = "SELECT f FROM Facilitystocklog f WHERE f.reference = :reference")
    , @NamedQuery(name = "Facilitystocklog.findByReferencenumber", query = "SELECT f FROM Facilitystocklog f WHERE f.referencenumber = :referencenumber")
    , @NamedQuery(name = "Facilitystocklog.findByFacilityunitid", query = "SELECT f FROM Facilitystocklog f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilitystocklog.findByPacksize", query = "SELECT f FROM Facilitystocklog f WHERE f.packsize = :packsize")
    , @NamedQuery(name = "Facilitystocklog.findByDateadded", query = "SELECT f FROM Facilitystocklog f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitystocklog.findByDaterecieved", query = "SELECT f FROM Facilitystocklog f WHERE f.daterecieved = :daterecieved")
    , @NamedQuery(name = "Facilitystocklog.findByBatchnumber", query = "SELECT f FROM Facilitystocklog f WHERE f.batchnumber = :batchnumber")
    , @NamedQuery(name = "Facilitystocklog.findByExpirydate", query = "SELECT f FROM Facilitystocklog f WHERE f.expirydate = :expirydate")
    , @NamedQuery(name = "Facilitystocklog.findByDaystoexpire", query = "SELECT f FROM Facilitystocklog f WHERE f.daystoexpire = :daystoexpire")})
public class Facilitystocklog implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "stockflogid")
    private BigInteger stockflogid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "stockid")
    private BigInteger stockid;
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
    @Size(max = 255)
    @Column(name = "referencetype", length = 255)
    private String referencetype;
    @Column(name = "reference")
    private BigInteger reference;
    @Size(max = 255)
    @Column(name = "referencenumber", length = 255)
    private String referencenumber;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "packsize")
    private Integer packsize;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "daterecieved")
    @Temporal(TemporalType.TIMESTAMP)
    private Date daterecieved;
    @Size(max = 2147483647)
    @Column(name = "batchnumber", length = 2147483647)
    private String batchnumber;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "daystoexpire")
    private Integer daystoexpire;

    public Facilitystocklog() {
    }

    public BigInteger getStockflogid() {
        return stockflogid;
    }

    public void setStockflogid(BigInteger stockflogid) {
        this.stockflogid = stockflogid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public BigInteger getStockid() {
        return stockid;
    }

    public void setStockid(BigInteger stockid) {
        this.stockid = stockid;
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

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Integer getPacksize() {
        return packsize;
    }

    public void setPacksize(Integer packsize) {
        this.packsize = packsize;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDaterecieved() {
        return daterecieved;
    }

    public void setDaterecieved(Date daterecieved) {
        this.daterecieved = daterecieved;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public Integer getDaystoexpire() {
        return daystoexpire;
    }

    public void setDaystoexpire(Integer daystoexpire) {
        this.daystoexpire = daystoexpire;
    }
    
}
