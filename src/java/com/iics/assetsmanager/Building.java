/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "building", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Building.findAll", query = "SELECT b FROM Building b")
    , @NamedQuery(name = "Building.findByBuildingid", query = "SELECT b FROM Building b WHERE b.buildingid = :buildingid")
    , @NamedQuery(name = "Building.findByBuildingname", query = "SELECT b FROM Building b WHERE b.buildingname = :buildingname")
    , @NamedQuery(name = "Building.findByFacilityid", query = "SELECT b FROM Building b WHERE b.facilityid = :facilityid")
    , @NamedQuery(name = "Building.findByIsactive", query = "SELECT b FROM Building b WHERE b.isactive = :isactive")
    , @NamedQuery(name = "Building.findByDateadded", query = "SELECT b FROM Building b WHERE b.dateadded = :dateadded")
    , @NamedQuery(name = "Building.findByAddedby", query = "SELECT b FROM Building b WHERE b.addedby = :addedby")
    , @NamedQuery(name = "Building.findByDateupdated", query = "SELECT b FROM Building b WHERE b.dateupdated = :dateupdated")
    , @NamedQuery(name = "Building.findByUpdatedby", query = "SELECT b FROM Building b WHERE b.updatedby = :updatedby")
    , @NamedQuery(name = "Building.findByBlocksize", query = "SELECT b FROM Building b WHERE b.blocksize = :blocksize")
    , @NamedQuery(name = "Building.findByRoomsize", query = "SELECT b FROM Building b WHERE b.roomsize = :roomsize")})
public class Building implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "buildingid", nullable = false)
    private Integer buildingid;
    @Size(max = 2147483647)
    @Column(name = "buildingname", length = 2147483647)
    private String buildingname;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Size(max = 2147483647)
    @Column(name = "addedby", length = 2147483647)
    private Long addedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Size(max = 2147483647)
    @Column(name = "updatedby", length = 2147483647)
    private Long updatedby;
    @Column(name = "blocksize")
    private Integer blocksize;
    @Column(name = "roomsize")
    private Integer roomsize;

    public Building() {
    }

    public Building(Integer buildingid) {
        this.buildingid = buildingid;
    }

    public Integer getBuildingid() {
        return buildingid;
    }

    public void setBuildingid(Integer buildingid) {
        this.buildingid = buildingid;
    }

    public String getBuildingname() {
        return buildingname;
    }

    public void setBuildingname(String buildingname) {
        this.buildingname = buildingname;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
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

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Integer getBlocksize() {
        return blocksize;
    }

    public void setBlocksize(Integer blocksize) {
        this.blocksize = blocksize;
    }

    public Integer getRoomsize() {
        return roomsize;
    }

    public void setRoomsize(Integer roomsize) {
        this.roomsize = roomsize;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (buildingid != null ? buildingid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Building)) {
            return false;
        }
        Building other = (Building) object;
        if ((this.buildingid == null && other.buildingid != null) || (this.buildingid != null && !this.buildingid.equals(other.buildingid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Building[ buildingid=" + buildingid + " ]";
    }
    
}
