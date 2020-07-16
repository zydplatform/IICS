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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facilitydonorstock", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitydonorstock.findAll", query = "SELECT f FROM Facilitydonorstock f")
    , @NamedQuery(name = "Facilitydonorstock.findByFacilitydonorstockid", query = "SELECT f FROM Facilitydonorstock f WHERE f.facilitydonorstockid = :facilitydonorstockid")
    , @NamedQuery(name = "Facilitydonorstock.findByAddedby", query = "SELECT f FROM Facilitydonorstock f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilitydonorstock.findByUpdatedby", query = "SELECT f FROM Facilitydonorstock f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilitydonorstock.findByDateadded", query = "SELECT f FROM Facilitydonorstock f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitydonorstock.findByDateupdated", query = "SELECT f FROM Facilitydonorstock f WHERE f.dateupdated = :dateupdated")})
public class Facilitydonorstock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilitydonorstockid", nullable = false)
    private Integer facilitydonorstockid;
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
    @Column(name = "donorprogramid")
    private Integer donorprogramid;
    @Column(name = "stockid")
    private Long stockid;

    public Facilitydonorstock() {
    }

    public Facilitydonorstock(Integer facilitydonorstockid) {
        this.facilitydonorstockid = facilitydonorstockid;
    }

    public Integer getFacilitydonorstockid() {
        return facilitydonorstockid;
    }

    public void setFacilitydonorstockid(Integer facilitydonorstockid) {
        this.facilitydonorstockid = facilitydonorstockid;
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

    public Integer getDonorprogramid() {
        return donorprogramid;
    }

    public void setDonorprogramid(Integer donorprogramid) {
        this.donorprogramid = donorprogramid;
    }

    public Long getStockid() {
        return stockid;
    }

    public void setStockid(Long stockid) {
        this.stockid = stockid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilitydonorstockid != null ? facilitydonorstockid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitydonorstock)) {
            return false;
        }
        Facilitydonorstock other = (Facilitydonorstock) object;
        if ((this.facilitydonorstockid == null && other.facilitydonorstockid != null) || (this.facilitydonorstockid != null && !this.facilitydonorstockid.equals(other.facilitydonorstockid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilitydonorstock[ facilitydonorstockid=" + facilitydonorstockid + " ]";
    }
    
}
