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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author 2018
 */
@Entity
@Table(name = "facilityvisitno", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityvisitno.findAll", query = "SELECT f FROM Facilityvisitno f")
    , @NamedQuery(name = "Facilityvisitno.findByFacilityvisitnoid", query = "SELECT f FROM Facilityvisitno f WHERE f.facilityvisitnoid = :facilityvisitnoid")
    , @NamedQuery(name = "Facilityvisitno.findByFacilityunitid", query = "SELECT f FROM Facilityvisitno f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityvisitno.findByCurrentvalue", query = "SELECT f FROM Facilityvisitno f WHERE f.currentvalue = :currentvalue")})
public class Facilityvisitno implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityvisitnoid", nullable = false)
    private Long facilityvisitnoid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "currentvalue")
    private Integer currentvalue;

    public Facilityvisitno() {
    }

    public Facilityvisitno(Long facilityvisitnoid) {
        this.facilityvisitnoid = facilityvisitnoid;
    }

    public Long getFacilityvisitnoid() {
        return facilityvisitnoid;
    }

    public void setFacilityvisitnoid(Long facilityvisitnoid) {
        this.facilityvisitnoid = facilityvisitnoid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Integer getCurrentvalue() {
        return currentvalue;
    }

    public void setCurrentvalue(Integer currentvalue) {
        this.currentvalue = currentvalue;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityvisitnoid != null ? facilityvisitnoid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityvisitno)) {
            return false;
        }
        Facilityvisitno other = (Facilityvisitno) object;
        if ((this.facilityvisitnoid == null && other.facilityvisitnoid != null) || (this.facilityvisitnoid != null && !this.facilityvisitnoid.equals(other.facilityvisitnoid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Facilityvisitno[ facilityvisitnoid=" + facilityvisitnoid + " ]";
    }
    
}
