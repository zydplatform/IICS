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
@Table(name = "shelflogstock", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Shelflogstock.findAll", query = "SELECT s FROM Shelflogstock s")
    , @NamedQuery(name = "Shelflogstock.findByShelflogid", query = "SELECT s FROM Shelflogstock s WHERE s.shelflogid = :shelflogid")
    , @NamedQuery(name = "Shelflogstock.findByCellid", query = "SELECT s FROM Shelflogstock s WHERE s.cellid = :cellid")
    , @NamedQuery(name = "Shelflogstock.findByStockid", query = "SELECT s FROM Shelflogstock s WHERE s.stockid = :stockid")
    , @NamedQuery(name = "Shelflogstock.findByLogtype", query = "SELECT s FROM Shelflogstock s WHERE s.logtype = :logtype")
    , @NamedQuery(name = "Shelflogstock.findByQuantity", query = "SELECT s FROM Shelflogstock s WHERE s.quantity = :quantity")
    , @NamedQuery(name = "Shelflogstock.findByStaffid", query = "SELECT s FROM Shelflogstock s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Shelflogstock.findByDatelogged", query = "SELECT s FROM Shelflogstock s WHERE s.datelogged = :datelogged")
    , @NamedQuery(name = "Shelflogstock.findByItemid", query = "SELECT s FROM Shelflogstock s WHERE s.itemid = :itemid")
    , @NamedQuery(name = "Shelflogstock.findByGenericname", query = "SELECT s FROM Shelflogstock s WHERE s.genericname = :genericname")
    , @NamedQuery(name = "Shelflogstock.findByBatchnumber", query = "SELECT s FROM Shelflogstock s WHERE s.batchnumber = :batchnumber")
    , @NamedQuery(name = "Shelflogstock.findByFacilityunitid", query = "SELECT s FROM Shelflogstock s WHERE s.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Shelflogstock.findByExpirydate", query = "SELECT s FROM Shelflogstock s WHERE s.expirydate = :expirydate")
    , @NamedQuery(name = "Shelflogstock.findByDaystoexpire", query = "SELECT s FROM Shelflogstock s WHERE s.daystoexpire = :daystoexpire")
    , @NamedQuery(name = "Shelflogstock.findByFullname", query = "SELECT s FROM Shelflogstock s WHERE s.fullname = :fullname")
    , @NamedQuery(name = "Shelflogstock.findByPackagename", query = "SELECT s FROM Shelflogstock s WHERE s.packagename = :packagename")})
public class Shelflogstock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "shelflogid")
    private BigInteger shelflogid;
    @Column(name = "cellid")
    private BigInteger cellid;
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
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Size(max = 2147483647)
    @Column(name = "batchnumber", length = 2147483647)
    private String batchnumber;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "daystoexpire")
    private Integer daystoexpire;
    @Size(max = 2147483647)
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;

    public Shelflogstock() {
    }

    public BigInteger getShelflogid() {
        return shelflogid;
    }

    public void setShelflogid(BigInteger shelflogid) {
        this.shelflogid = shelflogid;
    }

    public BigInteger getCellid() {
        return cellid;
    }

    public void setCellid(BigInteger cellid) {
        this.cellid = cellid;
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

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public String getGenericname() {
        return genericname;
    }

    public void setGenericname(String genericname) {
        this.genericname = genericname;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
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

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPackagename() {
        return packagename;
    }

    public void setPackagename(String packagename) {
        this.packagename = packagename;
    }
    
}
