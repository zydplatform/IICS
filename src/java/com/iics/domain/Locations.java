/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "locations", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Locations.findAll", query = "SELECT l FROM Locations l")
    , @NamedQuery(name = "Locations.findByVillageid", query = "SELECT l FROM Locations l WHERE l.villageid = :villageid")
    , @NamedQuery(name = "Locations.findByVillagename", query = "SELECT l FROM Locations l WHERE l.villagename = :villagename")
    , @NamedQuery(name = "Locations.findByParishid", query = "SELECT l FROM Locations l WHERE l.parishid = :parishid")
    , @NamedQuery(name = "Locations.findByParishname", query = "SELECT l FROM Locations l WHERE l.parishname = :parishname")
    , @NamedQuery(name = "Locations.findBySubcountyid", query = "SELECT l FROM Locations l WHERE l.subcountyid = :subcountyid")
    , @NamedQuery(name = "Locations.findBySubcountyname", query = "SELECT l FROM Locations l WHERE l.subcountyname = :subcountyname")
    , @NamedQuery(name = "Locations.findByCountyid", query = "SELECT l FROM Locations l WHERE l.countyid = :countyid")
    , @NamedQuery(name = "Locations.findByCountyname", query = "SELECT l FROM Locations l WHERE l.countyname = :countyname")
    , @NamedQuery(name = "Locations.findByDistrictid", query = "SELECT l FROM Locations l WHERE l.districtid = :districtid")
    , @NamedQuery(name = "Locations.findByDistrictname", query = "SELECT l FROM Locations l WHERE l.districtname = :districtname")
    , @NamedQuery(name = "Locations.findByRegionid", query = "SELECT l FROM Locations l WHERE l.regionid = :regionid")
    , @NamedQuery(name = "Locations.findByRegionname", query = "SELECT l FROM Locations l WHERE l.regionname = :regionname")})
public class Locations implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "villageid")
    private Integer villageid;
    @Size(max = 2147483647)
    @Column(name = "villagename", length = 2147483647)
    private String villagename;
    @Column(name = "parishid")
    private Integer parishid;
    @Size(max = 2147483647)
    @Column(name = "parishname", length = 2147483647)
    private String parishname;
    @Column(name = "subcountyid")
    private Integer subcountyid;
    @Size(max = 2147483647)
    @Column(name = "subcountyname", length = 2147483647)
    private String subcountyname;
    @Column(name = "countyid")
    private Integer countyid;
    @Size(max = 2147483647)
    @Column(name = "countyname", length = 2147483647)
    private String countyname;
    @Column(name = "districtid")
    private Integer districtid;
    @Size(max = 2147483647)
    @Column(name = "districtname", length = 2147483647)
    private String districtname;
    @Column(name = "regionid")
    private Integer regionid;
    @Size(max = 2147483647)
    @Column(name = "regionname", length = 2147483647)
    private String regionname;

    public Locations() {
    }

    public Integer getVillageid() {
        return villageid;
    }

    public void setVillageid(Integer villageid) {
        this.villageid = villageid;
    }

    public String getVillagename() {
        return villagename;
    }

    public void setVillagename(String villagename) {
        this.villagename = villagename;
    }

    public Integer getParishid() {
        return parishid;
    }

    public void setParishid(Integer parishid) {
        this.parishid = parishid;
    }

    public String getParishname() {
        return parishname;
    }

    public void setParishname(String parishname) {
        this.parishname = parishname;
    }

    public Integer getSubcountyid() {
        return subcountyid;
    }

    public void setSubcountyid(Integer subcountyid) {
        this.subcountyid = subcountyid;
    }

    public String getSubcountyname() {
        return subcountyname;
    }

    public void setSubcountyname(String subcountyname) {
        this.subcountyname = subcountyname;
    }

    public Integer getCountyid() {
        return countyid;
    }

    public void setCountyid(Integer countyid) {
        this.countyid = countyid;
    }

    public String getCountyname() {
        return countyname;
    }

    public void setCountyname(String countyname) {
        this.countyname = countyname;
    }

    public Integer getDistrictid() {
        return districtid;
    }

    public void setDistrictid(Integer districtid) {
        this.districtid = districtid;
    }

    public String getDistrictname() {
        return districtname;
    }

    public void setDistrictname(String districtname) {
        this.districtname = districtname;
    }

    public Integer getRegionid() {
        return regionid;
    }

    public void setRegionid(Integer regionid) {
        this.regionid = regionid;
    }

    public String getRegionname() {
        return regionname;
    }

    public void setRegionname(String regionname) {
        this.regionname = regionname;
    }
    
}
