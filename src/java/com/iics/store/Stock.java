/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


/**
 *
 * @author IICS
 */
@Entity
@Table(name = "stock", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stock.findAll", query = "SELECT s FROM Stock s")
    , @NamedQuery(name = "Stock.findByStockid", query = "SELECT s FROM Stock s WHERE s.stockid = :stockid")
    , @NamedQuery(name = "Stock.findByDaterecieved", query = "SELECT s FROM Stock s WHERE s.daterecieved = :daterecieved")
    , @NamedQuery(name = "Stock.findByQuantityrecieved", query = "SELECT s FROM Stock s WHERE s.quantityrecieved = :quantityrecieved")
    , @NamedQuery(name = "Stock.findByExpirydate", query = "SELECT s FROM Stock s WHERE s.expirydate = :expirydate")
    , @NamedQuery(name = "Stock.findByRecievedby", query = "SELECT s FROM Stock s WHERE s.recievedby = :recievedby")
    , @NamedQuery(name = "Stock.findByIsfinished", query = "SELECT s FROM Stock s WHERE s.isfinished = :isfinished")
    , @NamedQuery(name = "Stock.findByBatchnumber", query = "SELECT s FROM Stock s WHERE s.batchnumber = :batchnumber")
    , @NamedQuery(name = "Stock.findByStocktaken", query = "SELECT s FROM Stock s WHERE s.stocktaken = :stocktaken")
    , @NamedQuery(name = "Stock.findByFacilityunitid", query = "SELECT s FROM Stock s WHERE s.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Stock.findBySuppliertype", query = "SELECT s FROM Stock s WHERE s.suppliertype = :suppliertype")
    , @NamedQuery(name = "Stock.findBySupplierid", query = "SELECT s FROM Stock s WHERE s.supplierid = :supplierid")
    , @NamedQuery(name = "Stock.findByIssuedby", query = "SELECT s FROM Stock s WHERE s.issuedby = :issuedby")
    , @NamedQuery(name = "Stock.findByDateadded", query = "SELECT s FROM Stock s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Stock.findByExpires", query = "SELECT s FROM Stock s WHERE s.expires = :expires")
    , @NamedQuery(name = "Stock.findByShelvedstock", query = "SELECT s FROM Stock s WHERE s.shelvedstock = :shelvedstock")
    , @NamedQuery(name = "Stock.findByStockissued", query = "SELECT s FROM Stock s WHERE s.stockissued = :stockissued")})
public class Stock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "stockid", nullable = false)
    private Long stockid;
    @Column(name = "daterecieved")
    @Temporal(TemporalType.TIMESTAMP)
    private Date daterecieved;
    @Basic(optional = false)
    @NotNull
    @Column(name = "quantityrecieved", nullable = false)
    private int quantityrecieved;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "recievedby", nullable = false)
    private long recievedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isfinished", nullable = false)
    private boolean isfinished;
    @Size(max = 2147483647)
    @Column(name = "batchnumber", length = 2147483647)
    private String batchnumber;
    @Column(name = "stocktaken")
    private Boolean stocktaken;
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
    @Column(name = "expires")
    private Boolean expires;
    @Column(name = "shelvedstock")
    private Integer shelvedstock;
    @Column(name = "stockissued")
    private Integer stockissued;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid", nullable = false)
    @ManyToOne(optional = false)
    private Item itemid;
    @OneToMany(mappedBy = "stockid")
    private List<Discrepancy> discrepancyList;
    @OneToMany(mappedBy = "stockid")
    private List<Prescriptionissuance> prescriptionissuanceList;
    @OneToMany(mappedBy = "stockid")
    private List<Stocklog> stocklogList;
    @OneToMany(mappedBy = "stockid")
    private List<Shelflog> shelflogList;
    @OneToMany(mappedBy = "stockid")
    private List<Orderissuance> orderissuanceList;
    @OneToMany(mappedBy = "stockid")
    private List<Shelfstock> shelfstockList;

    public Stock() {
    }

    public Stock(Long stockid) {
        this.stockid = stockid;
    }

    public Stock(Long stockid, int quantityrecieved, long recievedby, boolean isfinished) {
        this.stockid = stockid;
        this.quantityrecieved = quantityrecieved;
        this.recievedby = recievedby;
        this.isfinished = isfinished;
    }

    public Long getStockid() {
        return stockid;
    }

    public void setStockid(Long stockid) {
        this.stockid = stockid;
    }

    public Date getDaterecieved() {
        return daterecieved;
    }

    public void setDaterecieved(Date daterecieved) {
        this.daterecieved = daterecieved;
    }

    public int getQuantityrecieved() {
        return quantityrecieved;
    }

    public void setQuantityrecieved(int quantityrecieved) {
        this.quantityrecieved = quantityrecieved;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public long getRecievedby() {
        return recievedby;
    }

    public void setRecievedby(long recievedby) {
        this.recievedby = recievedby;
    }

    public boolean getIsfinished() {
        return isfinished;
    }

    public void setIsfinished(boolean isfinished) {
        this.isfinished = isfinished;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }

    public Boolean getStocktaken() {
        return stocktaken;
    }

    public void setStocktaken(Boolean stocktaken) {
        this.stocktaken = stocktaken;
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

    public Boolean getExpires() {
        return expires;
    }

    public void setExpires(Boolean expires) {
        this.expires = expires;
    }

    public Integer getShelvedstock() {
        return shelvedstock;
    }

    public void setShelvedstock(Integer shelvedstock) {
        this.shelvedstock = shelvedstock;
    }

    public Integer getStockissued() {
        return stockissued;
    }

    public void setStockissued(Integer stockissued) {
        this.stockissued = stockissued;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }


    @XmlTransient
    public List<Discrepancy> getDiscrepancyList() {
        return discrepancyList;
    }

    public void setDiscrepancyList(List<Discrepancy> discrepancyList) {
        this.discrepancyList = discrepancyList;
    }

    @XmlTransient
    public List<Prescriptionissuance> getPrescriptionissuanceList() {
        return prescriptionissuanceList;
    }

    public void setPrescriptionissuanceList(List<Prescriptionissuance> prescriptionissuanceList) {
        this.prescriptionissuanceList = prescriptionissuanceList;
    }

    @XmlTransient
    public List<Stocklog> getStocklogList() {
        return stocklogList;
    }

    public void setStocklogList(List<Stocklog> stocklogList) {
        this.stocklogList = stocklogList;
    }

    @XmlTransient
    public List<Shelflog> getShelflogList() {
        return shelflogList;
    }

    public void setShelflogList(List<Shelflog> shelflogList) {
        this.shelflogList = shelflogList;
    }

    @XmlTransient
    public List<Orderissuance> getOrderissuanceList() {
        return orderissuanceList;
    }

    public void setOrderissuanceList(List<Orderissuance> orderissuanceList) {
        this.orderissuanceList = orderissuanceList;
    }

    @XmlTransient
    public List<Shelfstock> getShelfstockList() {
        return shelfstockList;
    }

    public void setShelfstockList(List<Shelfstock> shelfstockList) {
        this.shelfstockList = shelfstockList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (stockid != null ? stockid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stock)) {
            return false;
        }
        Stock other = (Stock) object;
        if ((this.stockid == null && other.stockid != null) || (this.stockid != null && !this.stockid.equals(other.stockid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Stock[ stockid=" + stockid + " ]";
    }
    
}
