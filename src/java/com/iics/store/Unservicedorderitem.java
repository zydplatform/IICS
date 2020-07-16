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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "unservicedorderitem", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unservicedorderitem.findAll", query = "SELECT u FROM Unservicedorderitem u")
    , @NamedQuery(name = "Unservicedorderitem.findByUnservicedorderitemid", query = "SELECT u FROM Unservicedorderitem u WHERE u.unservicedorderitemid = :unservicedorderitemid")
    , @NamedQuery(name = "Unservicedorderitem.findByAddedby", query = "SELECT u FROM Unservicedorderitem u WHERE u.addedby = :addedby")
    , @NamedQuery(name = "Unservicedorderitem.findByDateadded", query = "SELECT u FROM Unservicedorderitem u WHERE u.dateadded = :dateadded")
    , @NamedQuery(name = "Unservicedorderitem.findByItemid", query = "SELECT u FROM Unservicedorderitem u WHERE u.itemid = :itemid")
    , @NamedQuery(name = "Unservicedorderitem.findByUnservicedorderid", query = "SELECT u FROM Unservicedorderitem u WHERE u.unservicedorderid = :unservicedorderid")})
public class Unservicedorderitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "unservicedorderitemid")
    private Long unservicedorderitemid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "itemid")
    private long itemid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "unservicedorderid")
    private long unservicedorderid;

    public Unservicedorderitem() {
    }

    public Unservicedorderitem(Long unservicedorderitemid) {
        this.unservicedorderitemid = unservicedorderitemid;
    }

    public Unservicedorderitem(Long unservicedorderitemid, long addedby, Date dateadded, long itemid, long unservicedorderid) {
        this.unservicedorderitemid = unservicedorderitemid;
        this.addedby = addedby;
        this.dateadded = dateadded;
        this.itemid = itemid;
        this.unservicedorderid = unservicedorderid;
    }

    public Long getUnservicedorderitemid() {
        return unservicedorderitemid;
    }

    public void setUnservicedorderitemid(Long unservicedorderitemid) {
        this.unservicedorderitemid = unservicedorderitemid;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public long getItemid() {
        return itemid;
    }

    public void setItemid(long itemid) {
        this.itemid = itemid;
    }

    public long getUnservicedorderid() {
        return unservicedorderid;
    }

    public void setUnservicedorderid(long unservicedorderid) {
        this.unservicedorderid = unservicedorderid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (unservicedorderitemid != null ? unservicedorderitemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Unservicedorderitem)) {
            return false;
        }
        Unservicedorderitem other = (Unservicedorderitem) object;
        if ((this.unservicedorderitemid == null && other.unservicedorderitemid != null) || (this.unservicedorderitemid != null && !this.unservicedorderitemid.equals(other.unservicedorderitemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Unservicedorderitem[ unservicedorderitemid=" + unservicedorderitemid + " ]";
    }
    
}
