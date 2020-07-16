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
import javax.persistence.CascadeType;
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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "item", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Item.findAll", query = "SELECT i FROM Item i")
    , @NamedQuery(name = "Item.findByItemid", query = "SELECT i FROM Item i WHERE i.itemid = :itemid")
    , @NamedQuery(name = "Item.findByQty", query = "SELECT i FROM Item i WHERE i.qty = :qty")
    , @NamedQuery(name = "Item.findByAddedby", query = "SELECT i FROM Item i WHERE i.addedby = :addedby")
    , @NamedQuery(name = "Item.findByDateadded", query = "SELECT i FROM Item i WHERE i.dateadded = :dateadded")
    , @NamedQuery(name = "Item.findByLastupdate", query = "SELECT i FROM Item i WHERE i.lastupdate = :lastupdate")
    , @NamedQuery(name = "Item.findByLastupdatedby", query = "SELECT i FROM Item i WHERE i.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Item.findByIsactive", query = "SELECT i FROM Item i WHERE i.isactive = :isactive")})
public class Item implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "itemid", nullable = false)
    private Long itemid;
    @Column(name = "qty")
    private Integer qty;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdate")
    @Temporal(TemporalType.DATE)
    private Date lastupdate;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @Column(name = "isactive")
    private Boolean isactive;
    @OneToMany(mappedBy = "itemid")
    private List<Activitycellitem> activitycellitemList;
    @OneToMany(mappedBy = "itemid")
    private List<Facilityunitprocurementplan> facilityunitprocurementplanList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "itemid")
    private List<Stock> stockList;
    @JoinColumn(name = "medicalitemid", referencedColumnName = "medicalitemid")
    @ManyToOne
    private Medicalitem medicalitemid;
    @JoinColumn(name = "packagesid", referencedColumnName = "packagesid")
    @ManyToOne
    private Packages packagesid;
    @OneToMany(mappedBy = "itemid")
    private List<Unitcatalogueitem> unitcatalogueitemList;
    @OneToMany(mappedBy = "itemid")
    private List<Activityfollowup> activityfollowupList;
    @OneToMany(mappedBy = "itemid")
    private List<Recount> recountList;
    @OneToMany(mappedBy = "itemid")
    private List<Facilityprocurementplan> facilityprocurementplanList;
    @OneToMany(mappedBy = "itemid")
    private List<Facilityorderitems> facilityorderitemsList;
    @OneToMany(mappedBy = "itemid")
    private List<Supplieritem> supplieritemList;
    @Column(name = "measure")
    private String measure;

    public Item() {
    }

    public Item(Long itemid) {
        this.itemid = itemid;
    }

    public Long getItemid() {
        return itemid;
    }

    public void setItemid(Long itemid) {
        this.itemid = itemid;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getLastupdate() {
        return lastupdate;
    }

    public void setLastupdate(Date lastupdate) {
        this.lastupdate = lastupdate;
    }

    public BigInteger getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(BigInteger lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    @XmlTransient
    public List<Activitycellitem> getActivitycellitemList() {
        return activitycellitemList;
    }

    public void setActivitycellitemList(List<Activitycellitem> activitycellitemList) {
        this.activitycellitemList = activitycellitemList;
    }

    @XmlTransient
    public List<Facilityunitprocurementplan> getFacilityunitprocurementplanList() {
        return facilityunitprocurementplanList;
    }

    public void setFacilityunitprocurementplanList(List<Facilityunitprocurementplan> facilityunitprocurementplanList) {
        this.facilityunitprocurementplanList = facilityunitprocurementplanList;
    }

    @XmlTransient
    public List<Stock> getStockList() {
        return stockList;
    }

    public void setStockList(List<Stock> stockList) {
        this.stockList = stockList;
    }

    public Medicalitem getMedicalitemid() {
        return medicalitemid;
    }

    public void setMedicalitemid(Medicalitem medicalitemid) {
        this.medicalitemid = medicalitemid;
    }

    public Packages getPackagesid() {
        return packagesid;
    }

    public void setPackagesid(Packages packagesid) {
        this.packagesid = packagesid;
    }

    @XmlTransient
    public List<Unitcatalogueitem> getUnitcatalogueitemList() {
        return unitcatalogueitemList;
    }

    public void setUnitcatalogueitemList(List<Unitcatalogueitem> unitcatalogueitemList) {
        this.unitcatalogueitemList = unitcatalogueitemList;
    }

    @XmlTransient
    public List<Activityfollowup> getActivityfollowupList() {
        return activityfollowupList;
    }

    public void setActivityfollowupList(List<Activityfollowup> activityfollowupList) {
        this.activityfollowupList = activityfollowupList;
    }

    @XmlTransient
    public List<Recount> getRecountList() {
        return recountList;
    }

    public void setRecountList(List<Recount> recountList) {
        this.recountList = recountList;
    }

    @XmlTransient
    public List<Facilityprocurementplan> getFacilityprocurementplanList() {
        return facilityprocurementplanList;
    }

    public void setFacilityprocurementplanList(List<Facilityprocurementplan> facilityprocurementplanList) {
        this.facilityprocurementplanList = facilityprocurementplanList;
    }

    @XmlTransient
    public List<Facilityorderitems> getFacilityorderitemsList() {
        return facilityorderitemsList;
    }

    public void setFacilityorderitemsList(List<Facilityorderitems> facilityorderitemsList) {
        this.facilityorderitemsList = facilityorderitemsList;
    }

    @XmlTransient
    public List<Supplieritem> getSupplieritemList() {
        return supplieritemList;
    }

    public void setSupplieritemList(List<Supplieritem> supplieritemList) {
        this.supplieritemList = supplieritemList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (itemid != null ? itemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Item)) {
            return false;
        }
        Item other = (Item) object;
        if ((this.itemid == null && other.itemid != null) || (this.itemid != null && !this.itemid.equals(other.itemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Item[ itemid=" + itemid + " ]";
    }

    public String getMeasure() {
        return measure;
    }

    public void setMeasure(String measure) {
        this.measure = measure;
    }
    
}
