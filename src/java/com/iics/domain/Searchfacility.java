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
@Table(name = "searchfacility", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Searchfacility.findAll", query = "SELECT s FROM Searchfacility s")
    , @NamedQuery(name = "Searchfacility.findByFacilityid", query = "SELECT s FROM Searchfacility s WHERE s.facilityid = :facilityid")
    , @NamedQuery(name = "Searchfacility.findByFacilityname", query = "SELECT s FROM Searchfacility s WHERE s.facilityname = :facilityname")
    , @NamedQuery(name = "Searchfacility.findByFacilitycode", query = "SELECT s FROM Searchfacility s WHERE s.facilitycode = :facilitycode")
    , @NamedQuery(name = "Searchfacility.findByShortname", query = "SELECT s FROM Searchfacility s WHERE s.shortname = :shortname")
    , @NamedQuery(name = "Searchfacility.findByEmailaddress", query = "SELECT s FROM Searchfacility s WHERE s.emailaddress = :emailaddress")
    , @NamedQuery(name = "Searchfacility.findByPhonecontact", query = "SELECT s FROM Searchfacility s WHERE s.phonecontact = :phonecontact")
    , @NamedQuery(name = "Searchfacility.findByWebsite", query = "SELECT s FROM Searchfacility s WHERE s.website = :website")
    , @NamedQuery(name = "Searchfacility.findByPostaddress", query = "SELECT s FROM Searchfacility s WHERE s.postaddress = :postaddress")
    , @NamedQuery(name = "Searchfacility.findByPhonecontact2", query = "SELECT s FROM Searchfacility s WHERE s.phonecontact2 = :phonecontact2")
    , @NamedQuery(name = "Searchfacility.findByVillagename", query = "SELECT s FROM Searchfacility s WHERE s.villagename = :villagename")
    , @NamedQuery(name = "Searchfacility.findByParishname", query = "SELECT s FROM Searchfacility s WHERE s.parishname = :parishname")
    , @NamedQuery(name = "Searchfacility.findBySubcountyname", query = "SELECT s FROM Searchfacility s WHERE s.subcountyname = :subcountyname")
    , @NamedQuery(name = "Searchfacility.findByCountyname", query = "SELECT s FROM Searchfacility s WHERE s.countyname = :countyname")
    , @NamedQuery(name = "Searchfacility.findByDistrictname", query = "SELECT s FROM Searchfacility s WHERE s.districtname = :districtname")
    , @NamedQuery(name = "Searchfacility.findByRegionname", query = "SELECT s FROM Searchfacility s WHERE s.regionname = :regionname")
    , @NamedQuery(name = "Searchfacility.findByLevelcode", query = "SELECT s FROM Searchfacility s WHERE s.levelcode = :levelcode")
    , @NamedQuery(name = "Searchfacility.findByFacilitylevelname", query = "SELECT s FROM Searchfacility s WHERE s.facilitylevelname = :facilitylevelname")})
public class Searchfacility implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "facilityid")
    private Integer facilityid;
    @Size(max = 2147483647)
    @Column(name = "facilityname", length = 2147483647)
    private String facilityname;
    @Size(max = 2147483647)
    @Column(name = "facilitycode", length = 2147483647)
    private String facilitycode;
    @Size(max = 255)
    @Column(name = "shortname", length = 255)
    private String shortname;
    @Size(max = 255)
    @Column(name = "emailaddress", length = 255)
    private String emailaddress;
    @Size(max = 255)
    @Column(name = "phonecontact", length = 255)
    private String phonecontact;
    @Size(max = 255)
    @Column(name = "website", length = 255)
    private String website;
    @Size(max = 255)
    @Column(name = "postaddress", length = 255)
    private String postaddress;
    @Size(max = 25)
    @Column(name = "phonecontact2", length = 25)
    private String phonecontact2;
    @Size(max = 2147483647)
    @Column(name = "villagename", length = 2147483647)
    private String villagename;
    @Size(max = 2147483647)
    @Column(name = "parishname", length = 2147483647)
    private String parishname;
    @Size(max = 2147483647)
    @Column(name = "subcountyname", length = 2147483647)
    private String subcountyname;
    @Size(max = 2147483647)
    @Column(name = "countyname", length = 2147483647)
    private String countyname;
    @Size(max = 2147483647)
    @Column(name = "districtname", length = 2147483647)
    private String districtname;
    @Size(max = 2147483647)
    @Column(name = "regionname", length = 2147483647)
    private String regionname;
    @Size(max = 2147483647)
    @Column(name = "levelcode", length = 2147483647)
    private String levelcode;
    @Size(max = 2147483647)
    @Column(name = "facilitylevelname", length = 2147483647)
    private String facilitylevelname;

    public Searchfacility() {
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public String getFacilityname() {
        return facilityname;
    }

    public void setFacilityname(String facilityname) {
        this.facilityname = facilityname;
    }

    public String getFacilitycode() {
        return facilitycode;
    }

    public void setFacilitycode(String facilitycode) {
        this.facilitycode = facilitycode;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public String getEmailaddress() {
        return emailaddress;
    }

    public void setEmailaddress(String emailaddress) {
        this.emailaddress = emailaddress;
    }

    public String getPhonecontact() {
        return phonecontact;
    }

    public void setPhonecontact(String phonecontact) {
        this.phonecontact = phonecontact;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getPostaddress() {
        return postaddress;
    }

    public void setPostaddress(String postaddress) {
        this.postaddress = postaddress;
    }

    public String getPhonecontact2() {
        return phonecontact2;
    }

    public void setPhonecontact2(String phonecontact2) {
        this.phonecontact2 = phonecontact2;
    }

    public String getVillagename() {
        return villagename;
    }

    public void setVillagename(String villagename) {
        this.villagename = villagename;
    }

    public String getParishname() {
        return parishname;
    }

    public void setParishname(String parishname) {
        this.parishname = parishname;
    }

    public String getSubcountyname() {
        return subcountyname;
    }

    public void setSubcountyname(String subcountyname) {
        this.subcountyname = subcountyname;
    }

    public String getCountyname() {
        return countyname;
    }

    public void setCountyname(String countyname) {
        this.countyname = countyname;
    }

    public String getDistrictname() {
        return districtname;
    }

    public void setDistrictname(String districtname) {
        this.districtname = districtname;
    }

    public String getRegionname() {
        return regionname;
    }

    public void setRegionname(String regionname) {
        this.regionname = regionname;
    }

    public String getLevelcode() {
        return levelcode;
    }

    public void setLevelcode(String levelcode) {
        this.levelcode = levelcode;
    }

    public String getFacilitylevelname() {
        return facilitylevelname;
    }

    public void setFacilitylevelname(String facilitylevelname) {
        this.facilitylevelname = facilitylevelname;
    }
    
}
