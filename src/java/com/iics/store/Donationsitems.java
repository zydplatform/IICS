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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "donationsitems", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Donationsitems.findAll", query = "SELECT d FROM Donationsitems d")
    , @NamedQuery(name = "Donationsitems.findByDonationsitemsid", query = "SELECT d FROM Donationsitems d WHERE d.donationsitemsid = :donationsitemsid")
    , @NamedQuery(name = "Donationsitems.findByItemtype", query = "SELECT d FROM Donationsitems d WHERE d.itemtype = :itemtype")
    , @NamedQuery(name = "Donationsitems.findByQtydonated", query = "SELECT d FROM Donationsitems d WHERE d.qtydonated = :qtydonated")
    , @NamedQuery(name = "Donationsitems.findByItemspecification", query = "SELECT d FROM Donationsitems d WHERE d.itemspecification = :itemspecification")
    , @NamedQuery(name = "Donationsitems.findByExpirydate", query = "SELECT d FROM Donationsitems d WHERE d.expirydate = :expirydate")
    , @NamedQuery(name = "Donationsitems.findByBatchno", query = "SELECT d FROM Donationsitems d WHERE d.batchno = :batchno")
    , @NamedQuery(name = "Donationsitems.findByAddedby", query = "SELECT d FROM Donationsitems d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Donationsitems.findByUpdatedby", query = "SELECT d FROM Donationsitems d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Donationsitems.findByDateadded", query = "SELECT d FROM Donationsitems d WHERE d.dateadded = :dateadded")
    , @NamedQuery(name = "Donationsitems.findByDateupdated", query = "SELECT d FROM Donationsitems d WHERE d.dateupdated = :dateupdated")})
public class Donationsitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "donationsitemsid", nullable = false)
    private Integer donationsitemsid;
    @Size(max = 2147483647)
    @Column(name = "itemtype", length = 2147483647)
    private String itemtype;
    @Column(name = "qtydonated")
    private Integer qtydonated;
    @Size(max = 2147483647)
    @Column(name = "itemspecification", length = 2147483647)
    private String itemspecification;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Size(max = 2147483647)
    @Column(name = "batchno", length = 2147483647)
    private String batchno;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @OneToMany(mappedBy = "donationsitemsid")
    private List<Donationconsumption> donationconsumptionList;
    @Column(name = "donationsid")
    private Integer donationsid;
    @Column(name = "otheritemsid")
    private Integer otheritemsid;
    @Column(name = "medicalitemsid")
    private Long medicalitemsid;

    public Donationsitems() {
    }

    public Donationsitems(Integer donationsitemsid) {
        this.donationsitemsid = donationsitemsid;
    }

    public Integer getDonationsitemsid() {
        return donationsitemsid;
    }

    public void setDonationsitemsid(Integer donationsitemsid) {
        this.donationsitemsid = donationsitemsid;
    }

    public String getItemtype() {
        return itemtype;
    }

    public void setItemtype(String itemtype) {
        this.itemtype = itemtype;
    }

    public Integer getQtydonated() {
        return qtydonated;
    }

    public void setQtydonated(Integer qtydonated) {
        this.qtydonated = qtydonated;
    }

    public String getItemspecification() {
        return itemspecification;
    }

    public void setItemspecification(String itemspecification) {
        this.itemspecification = itemspecification;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public String getBatchno() {
        return batchno;
    }

    public void setBatchno(String batchno) {
        this.batchno = batchno;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Long getMedicalitemsid() {
        return medicalitemsid;
    }

    public void setMedicalitemsid(Long medicalitemsid) {
        this.medicalitemsid = medicalitemsid;
    }

    @XmlTransient
    public List<Donationconsumption> getDonationconsumptionList() {
        return donationconsumptionList;
    }

    public void setDonationconsumptionList(List<Donationconsumption> donationconsumptionList) {
        this.donationconsumptionList = donationconsumptionList;
    }

    public Integer getDonationsid() {
        return donationsid;
    }

    public void setDonationsid(Integer donationsid) {
        this.donationsid = donationsid;
    }

    public Integer getOtheritemsid() {
        return otheritemsid;
    }

    public void setOtheritemsid(Integer otheritemsid) {
        this.otheritemsid = otheritemsid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (donationsitemsid != null ? donationsitemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Donationsitems)) {
            return false;
        }
        Donationsitems other = (Donationsitems) object;
        if ((this.donationsitemsid == null && other.donationsitemsid != null) || (this.donationsitemsid != null && !this.donationsitemsid.equals(other.donationsitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Donationsitems[ donationsitemsid=" + donationsitemsid + " ]";
    }

}
