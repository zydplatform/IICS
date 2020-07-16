/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

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
 * @author USER 1
 */
@Entity
@Table(name = "facilitybuildings", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitybuildings.findAll", query = "SELECT f FROM Facilitybuildings f")
    , @NamedQuery(name = "Facilitybuildings.findByBuildingid", query = "SELECT f FROM Facilitybuildings f WHERE f.buildingid = :buildingid")
    , @NamedQuery(name = "Facilitybuildings.findByBuildingname", query = "SELECT f FROM Facilitybuildings f WHERE f.buildingname = :buildingname")
    , @NamedQuery(name = "Facilitybuildings.findByNumberoffloors", query = "SELECT f FROM Facilitybuildings f WHERE f.numberoffloors = :numberoffloors")
    , @NamedQuery(name = "Facilitybuildings.findByDateadded", query = "SELECT f FROM Facilitybuildings f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitybuildings.findByIsactive", query = "SELECT f FROM Facilitybuildings f WHERE f.isactive = :isactive")
    , @NamedQuery(name = "Facilitybuildings.findByFacilityid", query = "SELECT f FROM Facilitybuildings f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitybuildings.findByAddedby", query = "SELECT f FROM Facilitybuildings f WHERE f.addedby = :addedby")})
public class Facilitybuildings implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "buildingid")
    private Integer buildingid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "buildingname")
    private String buildingname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "numberoffloors")
    private long numberoffloors;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isactive")
    private boolean isactive;
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityid")
    private int facilityid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private int addedby;

    public Facilitybuildings() {
    }

    public Facilitybuildings(Integer buildingid) {
        this.buildingid = buildingid;
    }

    public Facilitybuildings(Integer buildingid, String buildingname, long numberoffloors, Date dateadded, boolean isactive, int facilityid, int addedby) {
        this.buildingid = buildingid;
        this.buildingname = buildingname;
        this.numberoffloors = numberoffloors;
        this.dateadded = dateadded;
        this.isactive = isactive;
        this.facilityid = facilityid;
        this.addedby = addedby;
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

    public long getNumberoffloors() {
        return numberoffloors;
    }

    public void setNumberoffloors(long numberoffloors) {
        this.numberoffloors = numberoffloors;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(boolean isactive) {
        this.isactive = isactive;
    }

    public int getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(int facilityid) {
        this.facilityid = facilityid;
    }

    public int getAddedby() {
        return addedby;
    }

    public void setAddedby(int addedby) {
        this.addedby = addedby;
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
        if (!(object instanceof Facilitybuildings)) {
            return false;
        }
        Facilitybuildings other = (Facilitybuildings) object;
        if ((this.buildingid == null && other.buildingid != null) || (this.buildingid != null && !this.buildingid.equals(other.buildingid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitybuildings[ buildingid=" + buildingid + " ]";
    }
    
}
