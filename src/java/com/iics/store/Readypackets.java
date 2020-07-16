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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "readypackets", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Readypackets.findAll", query = "SELECT r FROM Readypackets r")
    , @NamedQuery(name = "Readypackets.findByReadypacketsid", query = "SELECT r FROM Readypackets r WHERE r.readypacketsid = :readypacketsid")
    , @NamedQuery(name = "Readypackets.findByReferencenumber", query = "SELECT r FROM Readypackets r WHERE r.referencenumber = :referencenumber")
    , @NamedQuery(name = "Readypackets.findByStatus", query = "SELECT r FROM Readypackets r WHERE r.status = :status")
    , @NamedQuery(name = "Readypackets.findByPackagedby", query = "SELECT r FROM Readypackets r WHERE r.packagedby = :packagedby")
    , @NamedQuery(name = "Readypackets.findByUpdatedby", query = "SELECT r FROM Readypackets r WHERE r.updatedby = :updatedby")
    , @NamedQuery(name = "Readypackets.findByDatepackaged", query = "SELECT r FROM Readypackets r WHERE r.datepackaged = :datepackaged")
    , @NamedQuery(name = "Readypackets.findByDispensingstatus", query = "SELECT r FROM Readypackets r WHERE r.dispensingstatus = :dispensingstatus")
    , @NamedQuery(name = "Readypackets.findByFacilityunitid", query = "SELECT r FROM Readypackets r WHERE r.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Readypackets.findByQuantity", query = "SELECT r FROM Readypackets r WHERE r.quantity = :quantity")
    , @NamedQuery(name = "Readypackets.findByPackageid", query = "SELECT r FROM Readypackets r WHERE r.packageid = :packageid")
    , @NamedQuery(name = "Readypackets.findByStockid", query = "SELECT r FROM Readypackets r WHERE r.stockid = :stockid")})
public class Readypackets implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "readypacketsid")
    private Long readypacketsid;
    @Size(max = 255)
    @Column(name = "referencenumber")
    private String referencenumber;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "status")
    private String status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "packagedby")
    private long packagedby;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "datepackaged")
    @Temporal(TemporalType.DATE)
    private Date datepackaged;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dispensingstatus")
    private boolean dispensingstatus;
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitid")
    private long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "quantity")
    private int quantity;
    @Basic(optional = false)
    @NotNull
    @Column(name = "packageid")
    private long packageid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "stockid")
    private long stockid;

    public Readypackets() {
    }

    public Readypackets(Long readypacketsid) {
        this.readypacketsid = readypacketsid;
    }

    public Readypackets(Long readypacketsid, String status, long packagedby, boolean dispensingstatus, long facilityunitid, int quantity, long packageid, long stockid) {
        this.readypacketsid = readypacketsid;
        this.status = status;
        this.packagedby = packagedby;
        this.dispensingstatus = dispensingstatus;
        this.facilityunitid = facilityunitid;
        this.quantity = quantity;
        this.packageid = packageid;
        this.stockid = stockid;
    }

    public Long getReadypacketsid() {
        return readypacketsid;
    }

    public void setReadypacketsid(Long readypacketsid) {
        this.readypacketsid = readypacketsid;
    }

    public String getReferencenumber() {
        return referencenumber;
    }

    public void setReferencenumber(String referencenumber) {
        this.referencenumber = referencenumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public long getPackagedby() {
        return packagedby;
    }

    public void setPackagedby(long packagedby) {
        this.packagedby = packagedby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDatepackaged() {
        return datepackaged;
    }

    public void setDatepackaged(Date datepackaged) {
        this.datepackaged = datepackaged;
    }

    public boolean getDispensingstatus() {
        return dispensingstatus;
    }

    public void setDispensingstatus(boolean dispensingstatus) {
        this.dispensingstatus = dispensingstatus;
    }

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public long getPackageid() {
        return packageid;
    }

    public void setPackageid(long packageid) {
        this.packageid = packageid;
    }

    public long getStockid() {
        return stockid;
    }

    public void setStockid(long stockid) {
        this.stockid = stockid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (readypacketsid != null ? readypacketsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Readypackets)) {
            return false;
        }
        Readypackets other = (Readypackets) object;
        if ((this.readypacketsid == null && other.readypacketsid != null) || (this.readypacketsid != null && !this.readypacketsid.equals(other.readypacketsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Readypackets[ readypacketsid=" + readypacketsid + " ]";
    }
    
}
