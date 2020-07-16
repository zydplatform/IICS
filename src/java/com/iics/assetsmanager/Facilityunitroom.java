/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
=======

/**
 *
 * @author user
>>>>>>> 133f974c8047d071e6d36164d7c7e87e0c4edada
 */
@Entity
@Table(name = "facilityunitroom", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitroom.findAll", query = "SELECT f FROM Facilityunitroom f")
    , @NamedQuery(name = "Facilityunitroom.findByFacilityunitroomid", query = "SELECT f FROM Facilityunitroom f WHERE f.facilityunitroomid = :facilityunitroomid")
    , @NamedQuery(name = "Facilityunitroom.findByFacilityunitid", query = "SELECT f FROM Facilityunitroom f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitroom.findByIsactive", query = "SELECT f FROM Facilityunitroom f WHERE f.isactive = :isactive")
    , @NamedQuery(name = "Facilityunitroom.findByDateadded", query = "SELECT f FROM Facilityunitroom f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitroom.findByDateupdated", query = "SELECT f FROM Facilityunitroom f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilityunitroom.findByAddedby", query = "SELECT f FROM Facilityunitroom f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitroom.findByUpdatedby", query = "SELECT f FROM Facilityunitroom f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilityunitroom.findByRoomstatus", query = "SELECT f FROM Facilityunitroom f WHERE f.roomstatus = :roomstatus")})
public class Facilityunitroom implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityunitroomid", nullable = false)
    private Integer facilityunitroomid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Size(max = 2147483647)
    @Column(name = "roomstatus", length = 2147483647)
    private String roomstatus;
    @Column(name = "blockroomid")
    private Integer blockroomid;
    @OneToMany(mappedBy = "facilityunitroomid")
    private List<Facilityunitroomservice> facilityunitroomserviceList;

    public Facilityunitroom() {
    }

    public Facilityunitroom(Integer facilityunitroomid) {
        this.facilityunitroomid = facilityunitroomid;
    }

    public Integer getFacilityunitroomid() {
        return facilityunitroomid;
    }

    public void setFacilityunitroomid(Integer facilityunitroomid) {
        this.facilityunitroomid = facilityunitroomid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
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

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public String getRoomstatus() {
        return roomstatus;
    }

    public void setRoomstatus(String roomstatus) {
        this.roomstatus = roomstatus;
    }

    public Integer getBlockroomid() {
        return blockroomid;
    }

    public void setBlockroomid(Integer blockroomid) {
        this.blockroomid = blockroomid;
    }

    @XmlTransient
    public List<Facilityunitroomservice> getFacilityunitroomserviceList() {
        return facilityunitroomserviceList;
    }

    public void setFacilityunitroomserviceList(List<Facilityunitroomservice> facilityunitroomserviceList) {
        this.facilityunitroomserviceList = facilityunitroomserviceList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitroomid != null ? facilityunitroomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitroom)) {
            return false;
        }
        Facilityunitroom other = (Facilityunitroom) object;
        if ((this.facilityunitroomid == null && other.facilityunitroomid != null) || (this.facilityunitroomid != null && !this.facilityunitroomid.equals(other.facilityunitroomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Facilityunitroom[ facilityunitroomid=" + facilityunitroomid + " ]";
    }
    
}
