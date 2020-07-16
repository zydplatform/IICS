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
 */
@Entity
@Table(name = "blockfloor", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Blockfloor.findAll", query = "SELECT b FROM Blockfloor b")
    , @NamedQuery(name = "Blockfloor.findByBlockfloorid", query = "SELECT b FROM Blockfloor b WHERE b.blockfloorid = :blockfloorid")
    , @NamedQuery(name = "Blockfloor.findByFloorname", query = "SELECT b FROM Blockfloor b WHERE b.floorname = :floorname")
    , @NamedQuery(name = "Blockfloor.findByNumberofrooms", query = "SELECT b FROM Blockfloor b WHERE b.numberofrooms = :numberofrooms")
    , @NamedQuery(name = "Blockfloor.findByRoomsize", query = "SELECT b FROM Blockfloor b WHERE b.roomsize = :roomsize")
    , @NamedQuery(name = "Blockfloor.findByIsactive", query = "SELECT b FROM Blockfloor b WHERE b.isactive = :isactive")
    , @NamedQuery(name = "Blockfloor.findByDateadded", query = "SELECT b FROM Blockfloor b WHERE b.dateadded = :dateadded")
    , @NamedQuery(name = "Blockfloor.findByDateupdated", query = "SELECT b FROM Blockfloor b WHERE b.dateupdated = :dateupdated")
    , @NamedQuery(name = "Blockfloor.findByAddedby", query = "SELECT b FROM Blockfloor b WHERE b.addedby = :addedby")
    , @NamedQuery(name = "Blockfloor.findByUpdatedby", query = "SELECT b FROM Blockfloor b WHERE b.updatedby = :updatedby")})
public class Blockfloor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "blockfloorid", nullable = false)
    private Integer blockfloorid;
    @Size(max = 2147483647)
    @Column(name = "floorname", length = 2147483647)
    private String floorname;
    @Column(name = "numberofrooms")
    private Integer numberofrooms;
    @Column(name = "roomsize")
    private Integer roomsize;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "facilityblockid")
    private Integer facilityblockid;
    @OneToMany(mappedBy = "blockfloorid")
    private List<Blockroom> blockroomList;

    public Blockfloor() {
    }

    public Blockfloor(Integer blockfloorid) {
        this.blockfloorid = blockfloorid;
    }

    public Integer getBlockfloorid() {
        return blockfloorid;
    }

    public void setBlockfloorid(Integer blockfloorid) {
        this.blockfloorid = blockfloorid;
    }

    public String getFloorname() {
        return floorname;
    }

    public void setFloorname(String floorname) {
        this.floorname = floorname;
    }

    public Integer getNumberofrooms() {
        return numberofrooms;
    }

    public void setNumberofrooms(Integer numberofrooms) {
        this.numberofrooms = numberofrooms;
    }

    public Integer getRoomsize() {
        return roomsize;
    }

    public void setRoomsize(Integer roomsize) {
        this.roomsize = roomsize;
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

    public Integer getFacilityblockid() {
        return facilityblockid;
    }

    public void setFacilityblockid(Integer facilityblockid) {
        this.facilityblockid = facilityblockid;
    }

    @XmlTransient
    public List<Blockroom> getBlockroomList() {
        return blockroomList;
    }

    public void setBlockroomList(List<Blockroom> blockroomList) {
        this.blockroomList = blockroomList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (blockfloorid != null ? blockfloorid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Blockfloor)) {
            return false;
        }
        Blockfloor other = (Blockfloor) object;
        if ((this.blockfloorid == null && other.blockfloorid != null) || (this.blockfloorid != null && !this.blockfloorid.equals(other.blockfloorid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Blockfloor[ blockfloorid=" + blockfloorid + " ]";
    }

}
