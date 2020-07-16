/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
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
@Table(name = "activitycellitem", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Activitycellitem.findAll", query = "SELECT a FROM Activitycellitem a")
    , @NamedQuery(name = "Activitycellitem.findByActivitycellitemid", query = "SELECT a FROM Activitycellitem a WHERE a.activitycellitemid = :activitycellitemid")
    , @NamedQuery(name = "Activitycellitem.findByCountedstock", query = "SELECT a FROM Activitycellitem a WHERE a.countedstock = :countedstock")
    , @NamedQuery(name = "Activitycellitem.findByStatus", query = "SELECT a FROM Activitycellitem a WHERE a.status = :status")
    , @NamedQuery(name = "Activitycellitem.findByBatchnumber", query = "SELECT a FROM Activitycellitem a WHERE a.batchnumber = :batchnumber")
    , @NamedQuery(name = "Activitycellitem.findByExpirydate", query = "SELECT a FROM Activitycellitem a WHERE a.expirydate = :expirydate")
    , @NamedQuery(name = "Activitycellitem.findByDateadded", query = "SELECT a FROM Activitycellitem a WHERE a.dateadded = :dateadded")})
public class Activitycellitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "activitycellitemid", nullable = false)
    private Long activitycellitemid;
    @Column(name = "countedstock")
    private Integer countedstock;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Size(max = 255)
    @Column(name = "batchnumber", length = 255)
    private String batchnumber;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @JoinColumn(name = "activitycellid", referencedColumnName = "activitycellid")
    @ManyToOne
    private Activitycell activitycellid;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;

    public Activitycellitem() {
    }

    public Activitycellitem(Long activitycellitemid) {
        this.activitycellitemid = activitycellitemid;
    }

    public Long getActivitycellitemid() {
        return activitycellitemid;
    }

    public void setActivitycellitemid(Long activitycellitemid) {
        this.activitycellitemid = activitycellitemid;
    }

    public Integer getCountedstock() {
        return countedstock;
    }

    public void setCountedstock(Integer countedstock) {
        this.countedstock = countedstock;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Activitycell getActivitycellid() {
        return activitycellid;
    }

    public void setActivitycellid(Activitycell activitycellid) {
        this.activitycellid = activitycellid;
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
        hash += (activitycellitemid != null ? activitycellitemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Activitycellitem)) {
            return false;
        }
        Activitycellitem other = (Activitycellitem) object;
        if ((this.activitycellitemid == null && other.activitycellitemid != null) || (this.activitycellitemid != null && !this.activitycellitemid.equals(other.activitycellitemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Activitycellitem[ activitycellitemid=" + activitycellitemid + " ]";
    }
    
}
