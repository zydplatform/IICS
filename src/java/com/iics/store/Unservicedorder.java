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
@Table(name = "unservicedorder", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unservicedorder.findAll", query = "SELECT u FROM Unservicedorder u")
    , @NamedQuery(name = "Unservicedorder.findByUnservicedorderid", query = "SELECT u FROM Unservicedorder u WHERE u.unservicedorderid = :unservicedorderid")
    , @NamedQuery(name = "Unservicedorder.findByOrderid", query = "SELECT u FROM Unservicedorder u WHERE u.orderid = :orderid")
    , @NamedQuery(name = "Unservicedorder.findByDateadded", query = "SELECT u FROM Unservicedorder u WHERE u.dateadded = :dateadded")
    , @NamedQuery(name = "Unservicedorder.findByAddedby", query = "SELECT u FROM Unservicedorder u WHERE u.addedby = :addedby")
    , @NamedQuery(name = "Unservicedorder.findByServicingunitid", query = "SELECT u FROM Unservicedorder u WHERE u.servicingunitid = :servicingunitid")
    , @NamedQuery(name = "Unservicedorder.findByOrderingunitid", query = "SELECT u FROM Unservicedorder u WHERE u.orderingunitid = :orderingunitid")})
public class Unservicedorder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "unservicedorderid")
    private Long unservicedorderid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "orderid")
    private long orderid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "servicingunitid")
    private long servicingunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "orderingunitid")
    private long orderingunitid;

    public Unservicedorder() {
    }

    public Unservicedorder(Long unservicedorderid) {
        this.unservicedorderid = unservicedorderid;
    }

    public Unservicedorder(Long unservicedorderid, long orderid, Date dateadded, long addedby, long servicingunitid, long orderingunitid) {
        this.unservicedorderid = unservicedorderid;
        this.orderid = orderid;
        this.dateadded = dateadded;
        this.addedby = addedby;
        this.servicingunitid = servicingunitid;
        this.orderingunitid = orderingunitid;
    }

    public Long getUnservicedorderid() {
        return unservicedorderid;
    }

    public void setUnservicedorderid(Long unservicedorderid) {
        this.unservicedorderid = unservicedorderid;
    }

    public long getOrderid() {
        return orderid;
    }

    public void setOrderid(long orderid) {
        this.orderid = orderid;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public long getServicingunitid() {
        return servicingunitid;
    }

    public void setServicingunitid(long servicingunitid) {
        this.servicingunitid = servicingunitid;
    }

    public long getOrderingunitid() {
        return orderingunitid;
    }

    public void setOrderingunitid(long orderingunitid) {
        this.orderingunitid = orderingunitid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (unservicedorderid != null ? unservicedorderid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Unservicedorder)) {
            return false;
        }
        Unservicedorder other = (Unservicedorder) object;
        if ((this.unservicedorderid == null && other.unservicedorderid != null) || (this.unservicedorderid != null && !this.unservicedorderid.equals(other.unservicedorderid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Unservicedorder[ unservicedorderid=" + unservicedorderid + " ]";
    }
    
}
