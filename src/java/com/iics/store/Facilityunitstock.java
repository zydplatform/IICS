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
@Table(name = "facilityunitstock", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitstock.findAll", query = "SELECT f FROM Facilityunitstock f")
    , @NamedQuery(name = "Facilityunitstock.findByStockid", query = "SELECT f FROM Facilityunitstock f WHERE f.stockid = :stockid")
    , @NamedQuery(name = "Facilityunitstock.findByItemid", query = "SELECT f FROM Facilityunitstock f WHERE f.itemid = :itemid")
    , @NamedQuery(name = "Facilityunitstock.findByGenericname", query = "SELECT f FROM Facilityunitstock f WHERE f.genericname = :genericname")
    , @NamedQuery(name = "Facilityunitstock.findByIsactive", query = "SELECT f FROM Facilityunitstock f WHERE f.isactive = :isactive")
    , @NamedQuery(name = "Facilityunitstock.findByItemcategoryid", query = "SELECT f FROM Facilityunitstock f WHERE f.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Facilityunitstock.findByItemclassificationid", query = "SELECT f FROM Facilityunitstock f WHERE f.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Facilityunitstock.findByDaterecieved", query = "SELECT f FROM Facilityunitstock f WHERE f.daterecieved = :daterecieved")
    , @NamedQuery(name = "Facilityunitstock.findByQuantityrecieved", query = "SELECT f FROM Facilityunitstock f WHERE f.quantityrecieved = :quantityrecieved")
    , @NamedQuery(name = "Facilityunitstock.findByDaystoexpire", query = "SELECT f FROM Facilityunitstock f WHERE f.daystoexpire = :daystoexpire")
    , @NamedQuery(name = "Facilityunitstock.findByBatchnumber", query = "SELECT f FROM Facilityunitstock f WHERE f.batchnumber = :batchnumber")
    , @NamedQuery(name = "Facilityunitstock.findByFacilityunitid", query = "SELECT f FROM Facilityunitstock f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitstock.findBySuppliertype", query = "SELECT f FROM Facilityunitstock f WHERE f.suppliertype = :suppliertype")
    , @NamedQuery(name = "Facilityunitstock.findBySupplierid", query = "SELECT f FROM Facilityunitstock f WHERE f.supplierid = :supplierid")
    , @NamedQuery(name = "Facilityunitstock.findByIssuedby", query = "SELECT f FROM Facilityunitstock f WHERE f.issuedby = :issuedby")
    , @NamedQuery(name = "Facilityunitstock.findByDateadded", query = "SELECT f FROM Facilityunitstock f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitstock.findByShelvedstock", query = "SELECT f FROM Facilityunitstock f WHERE f.shelvedstock = :shelvedstock")
    , @NamedQuery(name = "Facilityunitstock.findByExpirydate", query = "SELECT f FROM Facilityunitstock f WHERE f.expirydate = :expirydate")
    , @NamedQuery(name = "Facilityunitstock.findByCategoryname", query = "SELECT f FROM Facilityunitstock f WHERE f.categoryname = :categoryname")
    , @NamedQuery(name = "Facilityunitstock.findByClassificationname", query = "SELECT f FROM Facilityunitstock f WHERE f.classificationname = :classificationname")
    , @NamedQuery(name = "Facilityunitstock.findByStockissued", query = "SELECT f FROM Facilityunitstock f WHERE f.stockissued = :stockissued")
    , @NamedQuery(name = "Facilityunitstock.findByRecievedby", query = "SELECT f FROM Facilityunitstock f WHERE f.recievedby = :recievedby")
    , @NamedQuery(name = "Facilityunitstock.findByFullname", query = "SELECT f FROM Facilityunitstock f WHERE f.fullname = :fullname")
    , @NamedQuery(name = "Facilityunitstock.findByPacksize", query = "SELECT f FROM Facilityunitstock f WHERE f.packsize = :packsize")
    , @NamedQuery(name = "Facilityunitstock.findByPackagename", query = "SELECT f FROM Facilityunitstock f WHERE f.packagename = :packagename")})
public class Facilityunitstock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "stockid")
    private BigInteger stockid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "itemcategoryid")
    private BigInteger itemcategoryid;
    @Column(name = "itemclassificationid")
    private BigInteger itemclassificationid;
    @Column(name = "daterecieved")
    @Temporal(TemporalType.TIMESTAMP)
    private Date daterecieved;
    @Column(name = "quantityrecieved")
    private Integer quantityrecieved;
    @Column(name = "daystoexpire")
    private Integer daystoexpire;
    @Size(max = 2147483647)
    @Column(name = "batchnumber", length = 2147483647)
    private String batchnumber;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 255)
    @Column(name = "suppliertype", length = 255)
    private String suppliertype;
    @Column(name = "supplierid")
    private BigInteger supplierid;
    @Column(name = "issuedby")
    private BigInteger issuedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "shelvedstock")
    private Integer shelvedstock;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Size(max = 2147483647)
    @Column(name = "categoryname", length = 2147483647)
    private String categoryname;
    @Size(max = 2147483647)
    @Column(name = "classificationname", length = 2147483647)
    private String classificationname;
    @Column(name = "stockissued")
    private Integer stockissued;
    @Column(name = "recievedby")
    private BigInteger recievedby;
    @Size(max = 2147483647)
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Column(name = "packsize")
    private Integer packsize;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;

    public Facilityunitstock() {
    }

    public BigInteger getStockid() {
        return stockid;
    }

    public void setStockid(BigInteger stockid) {
        this.stockid = stockid;
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

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public BigInteger getItemcategoryid() {
        return itemcategoryid;
    }

    public void setItemcategoryid(BigInteger itemcategoryid) {
        this.itemcategoryid = itemcategoryid;
    }

    public BigInteger getItemclassificationid() {
        return itemclassificationid;
    }

    public void setItemclassificationid(BigInteger itemclassificationid) {
        this.itemclassificationid = itemclassificationid;
    }

    public Date getDaterecieved() {
        return daterecieved;
    }

    public void setDaterecieved(Date daterecieved) {
        this.daterecieved = daterecieved;
    }

    public Integer getQuantityrecieved() {
        return quantityrecieved;
    }

    public void setQuantityrecieved(Integer quantityrecieved) {
        this.quantityrecieved = quantityrecieved;
    }

    public Integer getDaystoexpire() {
        return daystoexpire;
    }

    public void setDaystoexpire(Integer daystoexpire) {
        this.daystoexpire = daystoexpire;
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

    public String getSuppliertype() {
        return suppliertype;
    }

    public void setSuppliertype(String suppliertype) {
        this.suppliertype = suppliertype;
    }

    public BigInteger getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(BigInteger supplierid) {
        this.supplierid = supplierid;
    }

    public BigInteger getIssuedby() {
        return issuedby;
    }

    public void setIssuedby(BigInteger issuedby) {
        this.issuedby = issuedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Integer getShelvedstock() {
        return shelvedstock;
    }

    public void setShelvedstock(Integer shelvedstock) {
        this.shelvedstock = shelvedstock;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getClassificationname() {
        return classificationname;
    }

    public void setClassificationname(String classificationname) {
        this.classificationname = classificationname;
    }

    public Integer getStockissued() {
        return stockissued;
    }

    public void setStockissued(Integer stockissued) {
        this.stockissued = stockissued;
    }

    public BigInteger getRecievedby() {
        return recievedby;
    }

    public void setRecievedby(BigInteger recievedby) {
        this.recievedby = recievedby;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Integer getPacksize() {
        return packsize;
    }

    public void setPacksize(Integer packsize) {
        this.packsize = packsize;
    }

    public String getPackagename() {
        return packagename;
    }

    public void setPackagename(String packagename) {
        this.packagename = packagename;
    }
    
}
