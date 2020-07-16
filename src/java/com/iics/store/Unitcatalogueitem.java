/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
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
@Table(name = "unitcatalogueitem", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unitcatalogueitem.findAll", query = "SELECT u FROM Unitcatalogueitem u")
    , @NamedQuery(name = "Unitcatalogueitem.findByUnitcatalogueitemid", query = "SELECT u FROM Unitcatalogueitem u WHERE u.unitcatalogueitemid = :unitcatalogueitemid")
    , @NamedQuery(name = "Unitcatalogueitem.findByFacilityunitid", query = "SELECT u FROM Unitcatalogueitem u WHERE u.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Unitcatalogueitem.findByCatitemstatus", query = "SELECT u FROM Unitcatalogueitem u WHERE u.catitemstatus = :catitemstatus")
    , @NamedQuery(name = "Unitcatalogueitem.findByIsactive", query = "SELECT u FROM Unitcatalogueitem u WHERE u.isactive = :isactive")
    , @NamedQuery(name = "Unitcatalogueitem.findByDateadded", query = "SELECT u FROM Unitcatalogueitem u WHERE u.dateadded = :dateadded")
    , @NamedQuery(name = "Unitcatalogueitem.findByDateupdated", query = "SELECT u FROM Unitcatalogueitem u WHERE u.dateupdated = :dateupdated")
    , @NamedQuery(name = "Unitcatalogueitem.findByUpdatedby", query = "SELECT u FROM Unitcatalogueitem u WHERE u.updatedby = :updatedby")})
public class Unitcatalogueitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "unitcatalogueitemid", nullable = false)
    private Long unitcatalogueitemid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 255)
    @Column(name = "catitemstatus", length = 255)
    private String catitemstatus;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;

    public Unitcatalogueitem() {
    }

    public Unitcatalogueitem(Long unitcatalogueitemid) {
        this.unitcatalogueitemid = unitcatalogueitemid;
    }

    public Long getUnitcatalogueitemid() {
        return unitcatalogueitemid;
    }

    public void setUnitcatalogueitemid(Long unitcatalogueitemid) {
        this.unitcatalogueitemid = unitcatalogueitemid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getCatitemstatus() {
        return catitemstatus;
    }

    public void setCatitemstatus(String catitemstatus) {
        this.catitemstatus = catitemstatus;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
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

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (unitcatalogueitemid != null ? unitcatalogueitemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Unitcatalogueitem)) {
            return false;
        }
        Unitcatalogueitem other = (Unitcatalogueitem) object;
        if ((this.unitcatalogueitemid == null && other.unitcatalogueitemid != null) || (this.unitcatalogueitemid != null && !this.unitcatalogueitemid.equals(other.unitcatalogueitemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Unitcatalogueitem[ unitcatalogueitemid=" + unitcatalogueitemid + " ]";
    }
    
}
