/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

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
 * @author user
 */
@Entity
@Table(name = "facilityunitroomservice", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitroomservice.findAll", query = "SELECT f FROM Facilityunitroomservice f")
    , @NamedQuery(name = "Facilityunitroomservice.findByFacilityunitroomserviceid", query = "SELECT f FROM Facilityunitroomservice f WHERE f.facilityunitroomserviceid = :facilityunitroomserviceid")
    , @NamedQuery(name = "Facilityunitroomservice.findByFacilityunitservice", query = "SELECT f FROM Facilityunitroomservice f WHERE f.facilityunitservice = :facilityunitservice")
    , @NamedQuery(name = "Facilityunitroomservice.findByDateadded", query = "SELECT f FROM Facilityunitroomservice f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitroomservice.findByDateupdated", query = "SELECT f FROM Facilityunitroomservice f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilityunitroomservice.findByAddedby", query = "SELECT f FROM Facilityunitroomservice f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitroomservice.findByUpdatedby", query = "SELECT f FROM Facilityunitroomservice f WHERE f.updatedby = :updatedby")})
public class Facilityunitroomservice implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityunitroomserviceid", nullable = false)
    private Integer facilityunitroomserviceid;
    @Column(name = "facilityunitservice")
    private Long facilityunitservice;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "facilityunitroomid")
    private Integer facilityunitroomid;

    public Integer getFacilityunitroomid() {
        return facilityunitroomid;
    }

    public void setFacilityunitroomid(Integer facilityunitroomid) {
        this.facilityunitroomid = facilityunitroomid;
    }

    public Facilityunitroomservice() {
    }

    public Facilityunitroomservice(Integer facilityunitroomserviceid) {
        this.facilityunitroomserviceid = facilityunitroomserviceid;
    }

    public Integer getFacilityunitroomserviceid() {
        return facilityunitroomserviceid;
    }

    public void setFacilityunitroomserviceid(Integer facilityunitroomserviceid) {
        this.facilityunitroomserviceid = facilityunitroomserviceid;
    }

    public Long getFacilityunitservice() {
        return facilityunitservice;
    }

    public void setFacilityunitservice(Long facilityunitservice) {
        this.facilityunitservice = facilityunitservice;
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

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitroomserviceid != null ? facilityunitroomserviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitroomservice)) {
            return false;
        }
        Facilityunitroomservice other = (Facilityunitroomservice) object;
        if ((this.facilityunitroomserviceid == null && other.facilityunitroomserviceid != null) || (this.facilityunitroomserviceid != null && !this.facilityunitroomserviceid.equals(other.facilityunitroomserviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Facilityunitroomservice[ facilityunitroomserviceid=" + facilityunitroomserviceid + " ]";
    }
    
}