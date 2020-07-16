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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facilitydonorprogram", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitydonorprogram.findAll", query = "SELECT f FROM Facilitydonorprogram f")
    , @NamedQuery(name = "Facilitydonorprogram.findByFacilitydonorprogramid", query = "SELECT f FROM Facilitydonorprogram f WHERE f.facilitydonorprogramid = :facilitydonorprogramid")
    , @NamedQuery(name = "Facilitydonorprogram.findByFacilityid", query = "SELECT f FROM Facilitydonorprogram f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitydonorprogram.findByAddedby", query = "SELECT f FROM Facilitydonorprogram f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilitydonorprogram.findByUpdatedby", query = "SELECT f FROM Facilitydonorprogram f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilitydonorprogram.findByDateadded", query = "SELECT f FROM Facilitydonorprogram f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitydonorprogram.findByDateupdated", query = "SELECT f FROM Facilitydonorprogram f WHERE f.dateupdated = :dateupdated")})
public class Facilitydonorprogram implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilitydonorprogramid", nullable = false)
    private Integer facilitydonorprogramid;
    @Column(name = "facilityid")
    private Integer facilityid;
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

    public Facilitydonorprogram() {
    }

    public Facilitydonorprogram(Integer facilitydonorprogramid) {
        this.facilitydonorprogramid = facilitydonorprogramid;
    }

    public Integer getFacilitydonorprogramid() {
        return facilitydonorprogramid;
    }

    public void setFacilitydonorprogramid(Integer facilitydonorprogramid) {
        this.facilitydonorprogramid = facilitydonorprogramid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilitydonorprogramid != null ? facilitydonorprogramid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitydonorprogram)) {
            return false;
        }
        Facilitydonorprogram other = (Facilitydonorprogram) object;
        if ((this.facilitydonorprogramid == null && other.facilitydonorprogramid != null) || (this.facilitydonorprogramid != null && !this.facilitydonorprogramid.equals(other.facilitydonorprogramid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilitydonorprogram[ facilitydonorprogramid=" + facilitydonorprogramid + " ]";
    }
    
}
