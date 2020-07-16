/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author EARTHQUAKER
 */
@Entity
@Table(name = "floorrooms", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Floorrooms.findAll", query = "SELECT f FROM Floorrooms f"),
    @NamedQuery(name = "Floorrooms.findByRoomid", query = "SELECT f FROM Floorrooms f WHERE f.roomid = :roomid"),
    @NamedQuery(name = "Floorrooms.findByRoomname", query = "SELECT f FROM Floorrooms f WHERE f.roomname = :roomname"),
    @NamedQuery(name = "Floorrooms.findByArchived", query = "SELECT f FROM Floorrooms f WHERE f.archived = :archived"),
    @NamedQuery(name = "Floorrooms.findByIsmerged", query = "SELECT f FROM Floorrooms f WHERE f.ismerged = :ismerged"),
    @NamedQuery(name = "Floorrooms.findByIspartitioned", query = "SELECT f FROM Floorrooms f WHERE f.ispartitioned = :ispartitioned"),
    @NamedQuery(name = "Floorrooms.findByFloorid", query = "SELECT f FROM Floorrooms f WHERE f.floorid = :floorid")})
public class Floorrooms implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "roomid")
    private Integer roomid;
    @Size(max = 2147483647)
    @Column(name = "roomname")
    private String roomname;
    @Column(name = "archived")
    private Boolean archived;
    @Column(name = "ismerged")
    private Boolean ismerged;
    @Column(name = "ispartitioned")
    private Boolean ispartitioned;
    @Column(name = "floorid")
    private Integer floorid;

    public Floorrooms() {
    }

    public Floorrooms(Integer roomid) {
        this.roomid = roomid;
    }

    public Integer getRoomid() {
        return roomid;
    }

    public void setRoomid(Integer roomid) {
        this.roomid = roomid;
    }

    public String getRoomname() {
        return roomname;
    }

    public void setRoomname(String roomname) {
        this.roomname = roomname;
    }

    public Boolean getArchived() {
        return archived;
    }

    public void setArchived(Boolean archived) {
        this.archived = archived;
    }

    public Boolean getIsmerged() {
        return ismerged;
    }

    public void setIsmerged(Boolean ismerged) {
        this.ismerged = ismerged;
    }

    public Boolean getIspartitioned() {
        return ispartitioned;
    }

    public void setIspartitioned(Boolean ispartitioned) {
        this.ispartitioned = ispartitioned;
    }

    public Integer getFloorid() {
        return floorid;
    }

    public void setFloorid(Integer floorid) {
        this.floorid = floorid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (roomid != null ? roomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Floorrooms)) {
            return false;
        }
        Floorrooms other = (Floorrooms) object;
        if ((this.roomid == null && other.roomid != null) || (this.roomid != null && !this.roomid.equals(other.roomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Floorrooms[ roomid=" + roomid + " ]";
    }
    
}
