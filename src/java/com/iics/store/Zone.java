/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


/**
 *
 * @author IICS
 */
@Entity
@Table(name = "zone", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Zone.findAll", query = "SELECT z FROM Zone z")
    , @NamedQuery(name = "Zone.findByZoneid", query = "SELECT z FROM Zone z WHERE z.zoneid = :zoneid")
    , @NamedQuery(name = "Zone.findByZonelabel", query = "SELECT z FROM Zone z WHERE z.zonelabel = :zonelabel")
    , @NamedQuery(name = "Zone.findBySearchstate", query = "SELECT z FROM Zone z WHERE z.searchstate = :searchstate")
    , @NamedQuery(name = "Zone.findByFacilityunitid", query = "SELECT z FROM Zone z WHERE z.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Zone.findByLastupdated", query = "SELECT z FROM Zone z WHERE z.lastupdated = :lastupdated")
    , @NamedQuery(name = "Zone.findByLastupdatedby", query = "SELECT z FROM Zone z WHERE z.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Zone.findByDateadded", query = "SELECT z FROM Zone z WHERE z.dateadded = :dateadded")
    , @NamedQuery(name = "Zone.findByAddedby", query = "SELECT z FROM Zone z WHERE z.addedby = :addedby")
    , @NamedQuery(name = "Zone.findByZonestate", query = "SELECT z FROM Zone z WHERE z.zonestate = :zonestate")})
public class Zone implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "zoneid", nullable = false)
    private Integer zoneid;
    @Size(max = 255)
    @Column(name = "zonelabel", length = 255)
    private String zonelabel;
    @Column(name = "searchstate")
    private Boolean searchstate;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private Integer lastupdatedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private Integer addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "zonestate", nullable = false)
    private boolean zonestate;
    @OneToMany(mappedBy = "zoneid")
    private List<Staffbayrowcell> staffbayrowcellList;
    @JoinColumn(name = "storagetypeid", referencedColumnName = "storagetype")
    @ManyToOne
    private Storagetype storagetypeid;
    @OneToMany(mappedBy = "zoneid")
    private List<Zonebay> zonebayList;

    public Zone() {
    }

    public Zone(Integer zoneid) {
        this.zoneid = zoneid;
    }

    public Zone(Integer zoneid, boolean zonestate) {
        this.zoneid = zoneid;
        this.zonestate = zonestate;
    }

    public Integer getZoneid() {
        return zoneid;
    }

    public void setZoneid(Integer zoneid) {
        this.zoneid = zoneid;
    }

    public String getZonelabel() {
        return zonelabel;
    }

    public void setZonelabel(String zonelabel) {
        this.zonelabel = zonelabel;
    }

    public Boolean getSearchstate() {
        return searchstate;
    }

    public void setSearchstate(Boolean searchstate) {
        this.searchstate = searchstate;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public Integer getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Integer lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Integer getAddedby() {
        return addedby;
    }

    public void setAddedby(Integer addedby) {
        this.addedby = addedby;
    }

    public boolean getZonestate() {
        return zonestate;
    }

    public void setZonestate(boolean zonestate) {
        this.zonestate = zonestate;
    }

    @XmlTransient
    public List<Staffbayrowcell> getStaffbayrowcellList() {
        return staffbayrowcellList;
    }

    public void setStaffbayrowcellList(List<Staffbayrowcell> staffbayrowcellList) {
        this.staffbayrowcellList = staffbayrowcellList;
    }

    public Storagetype getStoragetypeid() {
        return storagetypeid;
    }

    public void setStoragetypeid(Storagetype storagetypeid) {
        this.storagetypeid = storagetypeid;
    }

    @XmlTransient
    public List<Zonebay> getZonebayList() {
        return zonebayList;
    }

    public void setZonebayList(List<Zonebay> zonebayList) {
        this.zonebayList = zonebayList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (zoneid != null ? zoneid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Zone)) {
            return false;
        }
        Zone other = (Zone) object;
        if ((this.zoneid == null && other.zoneid != null) || (this.zoneid != null && !this.zoneid.equals(other.zoneid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Zone[ zoneid=" + zoneid + " ]";
    }
    
}
