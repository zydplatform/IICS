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
@Table(name = "stockcount", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stockcount.findAll", query = "SELECT s FROM Stockcount s")
    , @NamedQuery(name = "Stockcount.findByActivitycellitemid", query = "SELECT s FROM Stockcount s WHERE s.activitycellitemid = :activitycellitemid")
    , @NamedQuery(name = "Stockcount.findByItemid", query = "SELECT s FROM Stockcount s WHERE s.itemid = :itemid")
    , @NamedQuery(name = "Stockcount.findByCountedstock", query = "SELECT s FROM Stockcount s WHERE s.countedstock = :countedstock")
    , @NamedQuery(name = "Stockcount.findByBatchnumber", query = "SELECT s FROM Stockcount s WHERE s.batchnumber = :batchnumber")
    , @NamedQuery(name = "Stockcount.findByDateadded", query = "SELECT s FROM Stockcount s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Stockcount.findByStockactivityid", query = "SELECT s FROM Stockcount s WHERE s.stockactivityid = :stockactivityid")
    , @NamedQuery(name = "Stockcount.findByGenericname", query = "SELECT s FROM Stockcount s WHERE s.genericname = :genericname")
    , @NamedQuery(name = "Stockcount.findByExpirydate", query = "SELECT s FROM Stockcount s WHERE s.expirydate = :expirydate")
    , @NamedQuery(name = "Stockcount.findByActivitycellid", query = "SELECT s FROM Stockcount s WHERE s.activitycellid = :activitycellid")
    , @NamedQuery(name = "Stockcount.findByCellstaff", query = "SELECT s FROM Stockcount s WHERE s.cellstaff = :cellstaff")
    , @NamedQuery(name = "Stockcount.findByCellid", query = "SELECT s FROM Stockcount s WHERE s.cellid = :cellid")
    , @NamedQuery(name = "Stockcount.findByFullname", query = "SELECT s FROM Stockcount s WHERE s.fullname = :fullname")
    , @NamedQuery(name = "Stockcount.findByPackagename", query = "SELECT s FROM Stockcount s WHERE s.packagename = :packagename")
    , @NamedQuery(name = "Stockcount.findByPackagequantity", query = "SELECT s FROM Stockcount s WHERE s.packagequantity = :packagequantity")})
public class Stockcount implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "activitycellitemid")
    private BigInteger activitycellitemid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "countedstock")
    private Integer countedstock;
    @Size(max = 255)
    @Column(name = "batchnumber", length = 255)
    private String batchnumber;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "stockactivityid")
    private BigInteger stockactivityid;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "activitycellid")
    private BigInteger activitycellid;
    @Column(name = "cellstaff")
    private BigInteger cellstaff;
    @Column(name = "cellid")
    private Integer cellid;
    @Size(max = 2147483647)
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;
    @Column(name = "packagequantity")
    private Integer packagequantity;

    public Stockcount() {
    }

    public BigInteger getActivitycellitemid() {
        return activitycellitemid;
    }

    public void setActivitycellitemid(BigInteger activitycellitemid) {
        this.activitycellitemid = activitycellitemid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public Integer getCountedstock() {
        return countedstock;
    }

    public void setCountedstock(Integer countedstock) {
        this.countedstock = countedstock;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getStockactivityid() {
        return stockactivityid;
    }

    public void setStockactivityid(BigInteger stockactivityid) {
        this.stockactivityid = stockactivityid;
    }

    public String getGenericname() {
        return genericname;
    }

    public void setGenericname(String genericname) {
        this.genericname = genericname;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public BigInteger getActivitycellid() {
        return activitycellid;
    }

    public void setActivitycellid(BigInteger activitycellid) {
        this.activitycellid = activitycellid;
    }

    public BigInteger getCellstaff() {
        return cellstaff;
    }

    public void setCellstaff(BigInteger cellstaff) {
        this.cellstaff = cellstaff;
    }

    public Integer getCellid() {
        return cellid;
    }

    public void setCellid(Integer cellid) {
        this.cellid = cellid;
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

    public Integer getPackagequantity() {
        return packagequantity;
    }

    public void setPackagequantity(Integer packagequantity) {
        this.packagequantity = packagequantity;
    }
    
}
