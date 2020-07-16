/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
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
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.stafffacilityunit", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stafffacilityunit.findAll", query = "SELECT s FROM Stafffacilityunit s")
    , @NamedQuery(name = "Stafffacilityunit.findByStafffacilityunitid", query = "SELECT s FROM Stafffacilityunit s WHERE s.stafffacilityunitid = :stafffacilityunitid")
    , @NamedQuery(name = "Stafffacilityunit.findByStaffid", query = "SELECT s FROM Stafffacilityunit s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Stafffacilityunit.findByFacilityunitid", query = "SELECT s FROM Stafffacilityunit s WHERE s.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Stafffacilityunit.findByActive", query = "SELECT s FROM Stafffacilityunit s WHERE s.active = :active")
    , @NamedQuery(name = "Stafffacilityunit.findByIndex", query = "SELECT s FROM Stafffacilityunit s WHERE s.index = :index")})
public class Stafffacilityunit implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "stafffacilityunitid", nullable = false)
    private Long stafffacilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "staffid", nullable = false)
    private long staffid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitid", nullable = false)
    private long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "index")
    private Integer index;

    public Stafffacilityunit() {
    }

    public Stafffacilityunit(Long stafffacilityunitid) {
        this.stafffacilityunitid = stafffacilityunitid;
    }

    public Stafffacilityunit(Long stafffacilityunitid, long staffid, long facilityunitid, boolean active) {
        this.stafffacilityunitid = stafffacilityunitid;
        this.staffid = staffid;
        this.facilityunitid = facilityunitid;
        this.active = active;
    }

    public Long getStafffacilityunitid() {
        return stafffacilityunitid;
    }

    public void setStafffacilityunitid(Long stafffacilityunitid) {
        this.stafffacilityunitid = stafffacilityunitid;
    }

    public long getStaffid() {
        return staffid;
    }

    public void setStaffid(long staffid) {
        this.staffid = staffid;
    }

    public long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (stafffacilityunitid != null ? stafffacilityunitid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stafffacilityunit)) {
            return false;
        }
        Stafffacilityunit other = (Stafffacilityunit) object;
        if ((this.stafffacilityunitid == null && other.stafffacilityunitid != null) || (this.stafffacilityunitid != null && !this.stafffacilityunitid.equals(other.stafffacilityunitid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Stafffacilityunit[ stafffacilityunitid=" + stafffacilityunitid + " ]";
    }
    
}
