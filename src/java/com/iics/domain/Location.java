/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "location", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Location.findAll", query = "SELECT l FROM Location l")
    , @NamedQuery(name = "Location.findByLocationid", query = "SELECT l FROM Location l WHERE l.locationid = :locationid")
    , @NamedQuery(name = "Location.findByNorthingminimum", query = "SELECT l FROM Location l WHERE l.northingminimum = :northingminimum")
    , @NamedQuery(name = "Location.findByNorthingmaximum", query = "SELECT l FROM Location l WHERE l.northingmaximum = :northingmaximum")
    , @NamedQuery(name = "Location.findByEastingmaximum", query = "SELECT l FROM Location l WHERE l.eastingmaximum = :eastingmaximum")
    , @NamedQuery(name = "Location.findByEastingminimum", query = "SELECT l FROM Location l WHERE l.eastingminimum = :eastingminimum")
    , @NamedQuery(name = "Location.findByElevationminimum", query = "SELECT l FROM Location l WHERE l.elevationminimum = :elevationminimum")
    , @NamedQuery(name = "Location.findByElevationmaximum", query = "SELECT l FROM Location l WHERE l.elevationmaximum = :elevationmaximum")
    , @NamedQuery(name = "Location.findByGpsid", query = "SELECT l FROM Location l WHERE l.gpsid = :gpsid")})
public class Location implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "locationid", nullable = false)
    private Integer locationid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "northingminimum", nullable = false)
    private int northingminimum;
    @Basic(optional = false)
    @NotNull
    @Column(name = "northingmaximum", nullable = false)
    private int northingmaximum;
    @Basic(optional = false)
    @NotNull
    @Column(name = "eastingmaximum", nullable = false)
    private int eastingmaximum;
    @Basic(optional = false)
    @NotNull
    @Column(name = "eastingminimum", nullable = false)
    private int eastingminimum;
    @Basic(optional = false)
    @NotNull
    @Column(name = "elevationminimum", nullable = false)
    private int elevationminimum;
    @Basic(optional = false)
    @NotNull
    @Column(name = "elevationmaximum", nullable = false)
    private int elevationmaximum;
    @Column(name = "gpsid")
    private Integer gpsid;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid", nullable = false)
    @ManyToOne(optional = false)
    private Facility facilityid;
    @JoinColumn(name = "villageid", referencedColumnName = "villageid")
    @ManyToOne
    private Village villageid;
    @OneToMany(mappedBy = "locationid")
    private List<Facility> facilityList;

    public Location() {
    }

    public Location(Integer locationid) {
        this.locationid = locationid;
    }

    public Location(Integer locationid, int northingminimum, int northingmaximum, int eastingmaximum, int eastingminimum, int elevationminimum, int elevationmaximum) {
        this.locationid = locationid;
        this.northingminimum = northingminimum;
        this.northingmaximum = northingmaximum;
        this.eastingmaximum = eastingmaximum;
        this.eastingminimum = eastingminimum;
        this.elevationminimum = elevationminimum;
        this.elevationmaximum = elevationmaximum;
    }

    public Integer getLocationid() {
        return locationid;
    }

    public void setLocationid(Integer locationid) {
        this.locationid = locationid;
    }

    public int getNorthingminimum() {
        return northingminimum;
    }

    public void setNorthingminimum(int northingminimum) {
        this.northingminimum = northingminimum;
    }

    public int getNorthingmaximum() {
        return northingmaximum;
    }

    public void setNorthingmaximum(int northingmaximum) {
        this.northingmaximum = northingmaximum;
    }

    public int getEastingmaximum() {
        return eastingmaximum;
    }

    public void setEastingmaximum(int eastingmaximum) {
        this.eastingmaximum = eastingmaximum;
    }

    public int getEastingminimum() {
        return eastingminimum;
    }

    public void setEastingminimum(int eastingminimum) {
        this.eastingminimum = eastingminimum;
    }

    public int getElevationminimum() {
        return elevationminimum;
    }

    public void setElevationminimum(int elevationminimum) {
        this.elevationminimum = elevationminimum;
    }

    public int getElevationmaximum() {
        return elevationmaximum;
    }

    public void setElevationmaximum(int elevationmaximum) {
        this.elevationmaximum = elevationmaximum;
    }

    public Integer getGpsid() {
        return gpsid;
    }

    public void setGpsid(Integer gpsid) {
        this.gpsid = gpsid;
    }

    public Facility getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Facility facilityid) {
        this.facilityid = facilityid;
    }

    public Village getVillageid() {
        return villageid;
    }

    public void setVillageid(Village villageid) {
        this.villageid = villageid;
    }

    @XmlTransient
    public List<Facility> getFacilityList() {
        return facilityList;
    }

    public void setFacilityList(List<Facility> facilityList) {
        this.facilityList = facilityList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (locationid != null ? locationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Location)) {
            return false;
        }
        Location other = (Location) object;
        if ((this.locationid == null && other.locationid != null) || (this.locationid != null && !this.locationid.equals(other.locationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Location[ locationid=" + locationid + " ]";
    }
    
}
