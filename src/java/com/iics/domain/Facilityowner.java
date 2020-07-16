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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facilityowner", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityowner.findAll", query = "SELECT f FROM Facilityowner f")
    , @NamedQuery(name = "Facilityowner.findByFacilityownerid", query = "SELECT f FROM Facilityowner f WHERE f.facilityownerid = :facilityownerid")
    , @NamedQuery(name = "Facilityowner.findByOwnername", query = "SELECT f FROM Facilityowner f WHERE f.ownername = :ownername")
    , @NamedQuery(name = "Facilityowner.findByDescription", query = "SELECT f FROM Facilityowner f WHERE f.description = :description")})
public class Facilityowner implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityownerid", nullable = false)
    private Integer facilityownerid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "ownername", nullable = false, length = 2147483647)
    private String ownername;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "subunits")
    private Integer subunits;
    @Column(name = "active")
    private boolean active;
    @OneToMany(mappedBy = "facilityownerid")
    private List<Facility> facilityList;

    public Facilityowner() {
    }

    public Facilityowner(Integer facilityownerid) {
        this.facilityownerid = facilityownerid;
    }

    public Facilityowner(Integer facilityownerid, String ownername) {
        this.facilityownerid = facilityownerid;
        this.ownername = ownername;
    }

    public Integer getFacilityownerid() {
        return facilityownerid;
    }

    public void setFacilityownerid(Integer facilityownerid) {
        this.facilityownerid = facilityownerid;
    }

    public String getOwnername() {
        return ownername;
    }

    public void setOwnername(String ownername) {
        this.ownername = ownername;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getSubunits() {
        return subunits;
    }

    public void setSubunits(Integer subunits) {
        this.subunits = subunits;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
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
        hash += (facilityownerid != null ? facilityownerid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityowner)) {
            return false;
        }
        Facilityowner other = (Facilityowner) object;
        if ((this.facilityownerid == null && other.facilityownerid != null) || (this.facilityownerid != null && !this.facilityownerid.equals(other.facilityownerid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilityowner[ facilityownerid=" + facilityownerid + " ]";
    }
    
}
