/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "facilityunitschedule", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitschedule.findAll", query = "SELECT f FROM Facilityunitschedule f")
    , @NamedQuery(name = "Facilityunitschedule.findByFacilityunitscheduleid", query = "SELECT f FROM Facilityunitschedule f WHERE f.facilityunitscheduleid = :facilityunitscheduleid")
    , @NamedQuery(name = "Facilityunitschedule.findByFacilityunitid", query = "SELECT f FROM Facilityunitschedule f WHERE f.facilityunitid = :facilityunitid")})
public class Facilityunitschedule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityunitscheduleid", nullable = false)
    private Long facilityunitscheduleid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "scheduleid")
    private Integer scheduleid;

    public Facilityunitschedule() {
    }

    public Facilityunitschedule(Long facilityunitscheduleid) {
        this.facilityunitscheduleid = facilityunitscheduleid;
    }

    public Long getFacilityunitscheduleid() {
        return facilityunitscheduleid;
    }

    public void setFacilityunitscheduleid(Long facilityunitscheduleid) {
        this.facilityunitscheduleid = facilityunitscheduleid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitscheduleid != null ? facilityunitscheduleid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitschedule)) {
            return false;
        }
        Facilityunitschedule other = (Facilityunitschedule) object;
        if ((this.facilityunitscheduleid == null && other.facilityunitscheduleid != null) || (this.facilityunitscheduleid != null && !this.facilityunitscheduleid.equals(other.facilityunitscheduleid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Facilityunitschedule[ facilityunitscheduleid=" + facilityunitscheduleid + " ]";
    }

    public Integer getScheduleid() {
        return scheduleid;
    }

    public void setScheduleid(Integer scheduleid) {
        this.scheduleid = scheduleid;
    }
}
