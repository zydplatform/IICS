/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Grace-K
 */
@Entity
@Table(name = "patient.facilityunitblock", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitblock.findAll", query = "SELECT f FROM Facilityunitblock f")
    , @NamedQuery(name = "Facilityunitblock.findByFacilityunitblockid", query = "SELECT f FROM Facilityunitblock f WHERE f.facilityunitblockid = :facilityunitblockid")
    , @NamedQuery(name = "Facilityunitblock.findByMinval", query = "SELECT f FROM Facilityunitblock f WHERE f.minval = :minval")
    , @NamedQuery(name = "Facilityunitblock.findByMaxval", query = "SELECT f FROM Facilityunitblock f WHERE f.maxval = :maxval")
    , @NamedQuery(name = "Facilityunitblock.findByCurrentval", query = "SELECT f FROM Facilityunitblock f WHERE f.currentval = :currentval")
    , @NamedQuery(name = "Facilityunitblock.findByFacilityunitid", query = "SELECT f FROM Facilityunitblock f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitblock.findByActive", query = "SELECT f FROM Facilityunitblock f WHERE f.active = :active")})
public class Facilityunitblock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitblockid", nullable = false)
    private Integer facilityunitblockid;
    @Column(name = "minval")
    private Integer minval;
    @Column(name = "maxval")
    private Integer maxval;
    @Column(name = "currentval")
    private Integer currentval;
    @Column(name = "facilityunitid")
    private long facilityunitid;
    @Column(name = "active")
    private Boolean active;

    public Facilityunitblock() {
        
    }

    public Facilityunitblock(Integer facilityunitblockid) {
        this.facilityunitblockid = facilityunitblockid;
    }

    public Integer getFacilityunitblockid() {
        return facilityunitblockid;
    }

    public void setFacilityunitblockid(Integer facilityunitblockid) {
        this.facilityunitblockid = facilityunitblockid;
    }

    public Integer getMinval() {
        return minval;
    }

    public void setMinval(Integer minval) {
        this.minval = minval;
    }

    public Integer getMaxval() {
        return maxval;
    }

    public void setMaxval(Integer maxval) {
        this.maxval = maxval;
    }

    public Integer getCurrentval() {
        return currentval;
    }

    public void setCurrentval(Integer currentval) {
        this.currentval = currentval;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitblockid != null ? facilityunitblockid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitblock)) {
            return false;
        }
        Facilityunitblock other = (Facilityunitblock) object;
        if ((this.facilityunitblockid == null && other.facilityunitblockid != null) || (this.facilityunitblockid != null && !this.facilityunitblockid.equals(other.facilityunitblockid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Facilityunitblock[ facilityunitblockid=" + facilityunitblockid + " ]";
    }

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }
    
}
