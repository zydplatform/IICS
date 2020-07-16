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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER 1
 */
@Entity
@Table(name = "buildingfloors", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Buildingfloors.findAll", query = "SELECT b FROM Buildingfloors b")
    , @NamedQuery(name = "Buildingfloors.findByFloorid", query = "SELECT b FROM Buildingfloors b WHERE b.floorid = :floorid")
    , @NamedQuery(name = "Buildingfloors.findByFloorname", query = "SELECT b FROM Buildingfloors b WHERE b.floorname = :floorname")
    , @NamedQuery(name = "Buildingfloors.findByNumberofrooms", query = "SELECT b FROM Buildingfloors b WHERE b.numberofrooms = :numberofrooms")
    , @NamedQuery(name = "Buildingfloors.findByBuildingid", query = "SELECT b FROM Buildingfloors b WHERE b.buildingid = :buildingid")})
public class Buildingfloors implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "floorid")
    private Integer floorid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "floorname")
    private String floorname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "numberofrooms")
    private long numberofrooms;
    @Basic(optional = false)
    @NotNull
    @Column(name = "buildingid")
    private int buildingid;

    public Buildingfloors() {
    }

    public Buildingfloors(Integer floorid) {
        this.floorid = floorid;
    }

    public Buildingfloors(Integer floorid, String floorname, long numberofrooms, int buildingid) {
        this.floorid = floorid;
        this.floorname = floorname;
        this.numberofrooms = numberofrooms;
        this.buildingid = buildingid;
    }

    public Integer getFloorid() {
        return floorid;
    }

    public void setFloorid(Integer floorid) {
        this.floorid = floorid;
    }

    public String getFloorname() {
        return floorname;
    }

    public void setFloorname(String floorname) {
        this.floorname = floorname;
    }

    public long getNumberofrooms() {
        return numberofrooms;
    }

    public void setNumberofrooms(long numberofrooms) {
        this.numberofrooms = numberofrooms;
    }

    public int getBuildingid() {
        return buildingid;
    }

    public void setBuildingid(int buildingid) {
        this.buildingid = buildingid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (floorid != null ? floorid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Buildingfloors)) {
            return false;
        }
        Buildingfloors other = (Buildingfloors) object;
        if ((this.floorid == null && other.floorid != null) || (this.floorid != null && !this.floorid.equals(other.floorid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Buildingfloors[ floorid=" + floorid + " ]";
    }
    
}
