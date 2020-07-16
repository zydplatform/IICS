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
@Table(name = "cellitems", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cellitems.findAll", query = "SELECT c FROM Cellitems c")
    , @NamedQuery(name = "Cellitems.findByZonelabel", query = "SELECT c FROM Cellitems c WHERE c.zonelabel = :zonelabel")
    , @NamedQuery(name = "Cellitems.findByZoneid", query = "SELECT c FROM Cellitems c WHERE c.zoneid = :zoneid")
    , @NamedQuery(name = "Cellitems.findByBaylabel", query = "SELECT c FROM Cellitems c WHERE c.baylabel = :baylabel")
    , @NamedQuery(name = "Cellitems.findByZonebayid", query = "SELECT c FROM Cellitems c WHERE c.zonebayid = :zonebayid")
    , @NamedQuery(name = "Cellitems.findByBayrowid", query = "SELECT c FROM Cellitems c WHERE c.bayrowid = :bayrowid")
    , @NamedQuery(name = "Cellitems.findByRowlabel", query = "SELECT c FROM Cellitems c WHERE c.rowlabel = :rowlabel")
    , @NamedQuery(name = "Cellitems.findByBayrowcellid", query = "SELECT c FROM Cellitems c WHERE c.bayrowcellid = :bayrowcellid")
    , @NamedQuery(name = "Cellitems.findByCelllabel", query = "SELECT c FROM Cellitems c WHERE c.celllabel = :celllabel")
    , @NamedQuery(name = "Cellitems.findByShelfstockid", query = "SELECT c FROM Cellitems c WHERE c.shelfstockid = :shelfstockid")
    , @NamedQuery(name = "Cellitems.findByQuantityshelved", query = "SELECT c FROM Cellitems c WHERE c.quantityshelved = :quantityshelved")
    , @NamedQuery(name = "Cellitems.findByStockid", query = "SELECT c FROM Cellitems c WHERE c.stockid = :stockid")
    , @NamedQuery(name = "Cellitems.findByItemid", query = "SELECT c FROM Cellitems c WHERE c.itemid = :itemid")
    , @NamedQuery(name = "Cellitems.findByGenericname", query = "SELECT c FROM Cellitems c WHERE c.genericname = :genericname")
    , @NamedQuery(name = "Cellitems.findByDaystoexpire", query = "SELECT c FROM Cellitems c WHERE c.daystoexpire = :daystoexpire")
    , @NamedQuery(name = "Cellitems.findByBatchnumber", query = "SELECT c FROM Cellitems c WHERE c.batchnumber = :batchnumber")
    , @NamedQuery(name = "Cellitems.findByExpirydate", query = "SELECT c FROM Cellitems c WHERE c.expirydate = :expirydate")
    , @NamedQuery(name = "Cellitems.findByFacilityunitid", query = "SELECT c FROM Cellitems c WHERE c.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Cellitems.findByCategoryname", query = "SELECT c FROM Cellitems c WHERE c.categoryname = :categoryname")
    , @NamedQuery(name = "Cellitems.findByClassificationname", query = "SELECT c FROM Cellitems c WHERE c.classificationname = :classificationname")
    , @NamedQuery(name = "Cellitems.findByCellstate", query = "SELECT c FROM Cellitems c WHERE c.cellstate = :cellstate")
    , @NamedQuery(name = "Cellitems.findByFullname", query = "SELECT c FROM Cellitems c WHERE c.fullname = :fullname")
    , @NamedQuery(name = "Cellitems.findByPackagename", query = "SELECT c FROM Cellitems c WHERE c.packagename = :packagename")})
public class Cellitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Size(max = 255)
    @Column(name = "zonelabel", length = 255)
    private String zonelabel;
    @Column(name = "zoneid")
    private Integer zoneid;
    @Size(max = 255)
    @Column(name = "baylabel", length = 255)
    private String baylabel;
    @Column(name = "zonebayid")
    private Integer zonebayid;
    @Column(name = "bayrowid")
    private Integer bayrowid;
    @Size(max = 255)
    @Column(name = "rowlabel", length = 255)
    private String rowlabel;
    @Column(name = "bayrowcellid")
    private Integer bayrowcellid;
    @Size(max = 255)
    @Column(name = "celllabel", length = 255)
    private String celllabel;
    @Id
    @Column(name = "shelfstockid")
    private BigInteger shelfstockid;
    @Column(name = "quantityshelved")
    private Integer quantityshelved;
    @Column(name = "stockid")
    private BigInteger stockid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Column(name = "daystoexpire")
    private Integer daystoexpire;
    @Size(max = 2147483647)
    @Column(name = "batchnumber", length = 2147483647)
    private String batchnumber;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 2147483647)
    @Column(name = "categoryname", length = 2147483647)
    private String categoryname;
    @Size(max = 2147483647)
    @Column(name = "classificationname", length = 2147483647)
    private String classificationname;
    @Column(name = "cellstate")
    private Boolean cellstate;
    @Size(max = 2147483647)
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;
    @Column(name = "packsize")
    private Integer packsize;
    @Column(name = "cellid")
    private Integer cellid;
    @Column(name = "isolated")
    private Boolean isolated;

    public Cellitems() {
    }

    public String getZonelabel() {
        return zonelabel;
    }

    public void setZonelabel(String zonelabel) {
        this.zonelabel = zonelabel;
    }

    public Integer getZoneid() {
        return zoneid;
    }

    public void setZoneid(Integer zoneid) {
        this.zoneid = zoneid;
    }

    public String getBaylabel() {
        return baylabel;
    }

    public void setBaylabel(String baylabel) {
        this.baylabel = baylabel;
    }

    public Integer getZonebayid() {
        return zonebayid;
    }

    public void setZonebayid(Integer zonebayid) {
        this.zonebayid = zonebayid;
    }

    public Integer getBayrowid() {
        return bayrowid;
    }

    public void setBayrowid(Integer bayrowid) {
        this.bayrowid = bayrowid;
    }

    public String getRowlabel() {
        return rowlabel;
    }

    public void setRowlabel(String rowlabel) {
        this.rowlabel = rowlabel;
    }

    public Integer getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(Integer bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public String getCelllabel() {
        return celllabel;
    }

    public void setCelllabel(String celllabel) {
        this.celllabel = celllabel;
    }

    public BigInteger getShelfstockid() {
        return shelfstockid;
    }

    public void setShelfstockid(BigInteger shelfstockid) {
        this.shelfstockid = shelfstockid;
    }

    public Integer getQuantityshelved() {
        return quantityshelved;
    }

    public void setQuantityshelved(Integer quantityshelved) {
        this.quantityshelved = quantityshelved;
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

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
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

    public Boolean getCellstate() {
        return cellstate;
    }

    public void setCellstate(Boolean cellstate) {
        this.cellstate = cellstate;
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

    public Integer getPacksize() {
        return packsize;
    }

    public void setPacksize(Integer packsize) {
        this.packsize = packsize;
    }

    public Integer getCellid() {
        return cellid;
    }

    public void setCellid(Integer cellid) {
        this.cellid = cellid;
    }

    public Boolean getIsolated() {
        return isolated;
    }

    public void setIsolated(Boolean isolated) {
        this.isolated = isolated;
    }
    
}
