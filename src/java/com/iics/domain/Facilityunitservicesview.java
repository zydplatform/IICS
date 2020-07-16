/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "facilityunitservicesview", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitservicesview.findAll", query = "SELECT f FROM Facilityunitservicesview f")
    , @NamedQuery(name = "Facilityunitservicesview.findByServiceid", query = "SELECT f FROM Facilityunitservicesview f WHERE f.serviceid = :serviceid")
    , @NamedQuery(name = "Facilityunitservicesview.findByServicename", query = "SELECT f FROM Facilityunitservicesview f WHERE f.servicename = :servicename")
    , @NamedQuery(name = "Facilityunitservicesview.findByDescription", query = "SELECT f FROM Facilityunitservicesview f WHERE f.description = :description")
    , @NamedQuery(name = "Facilityunitservicesview.findByActive", query = "SELECT f FROM Facilityunitservicesview f WHERE f.active = :active")
    , @NamedQuery(name = "Facilityunitservicesview.findByDateadded", query = "SELECT f FROM Facilityunitservicesview f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitservicesview.findByDateupdated", query = "SELECT f FROM Facilityunitservicesview f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilityunitservicesview.findByUpdatedby", query = "SELECT f FROM Facilityunitservicesview f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilityunitservicesview.findByServicekey", query = "SELECT f FROM Facilityunitservicesview f WHERE f.servicekey = :servicekey")
    , @NamedQuery(name = "Facilityunitservicesview.findByReleased", query = "SELECT f FROM Facilityunitservicesview f WHERE f.released = :released")
    , @NamedQuery(name = "Facilityunitservicesview.findByFacilityunitserviceid", query = "SELECT f FROM Facilityunitservicesview f WHERE f.facilityunitserviceid = :facilityunitserviceid")
    , @NamedQuery(name = "Facilityunitservicesview.findByFacilityunitid", query = "SELECT f FROM Facilityunitservicesview f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitservicesview.findByAddedby", query = "SELECT f FROM Facilityunitservicesview f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitservicesview.findByStatus", query = "SELECT f FROM Facilityunitservicesview f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityunitservicesview.findByFacilityunitname", query = "SELECT f FROM Facilityunitservicesview f WHERE f.facilityunitname = :facilityunitname")
    , @NamedQuery(name = "Facilityunitservicesview.findByFacilityid", query = "SELECT f FROM Facilityunitservicesview f WHERE f.facilityid = :facilityid")})
public class Facilityunitservicesview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "serviceid")
    @Id
    private Integer serviceid;
    @Size(max = 255)
    @Column(name = "servicename")
    private String servicename;
    @Size(max = 255)
    @Column(name = "description")
    private String description;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Size(max = 25)
    @Column(name = "servicekey")
    private String servicekey;
    @Column(name = "released")
    private Boolean released;
    @Column(name = "facilityunitserviceid")
    private BigInteger facilityunitserviceid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "status")
    private Boolean status;
    @Size(max = 2147483647)
    @Column(name = "facilityunitname")
    private String facilityunitname;
    @Column(name = "facilityid")
    private Integer facilityid;

    public Facilityunitservicesview() {
    }

    public Integer getServiceid() {
        return serviceid;
    }

    public void setServiceid(Integer serviceid) {
        this.serviceid = serviceid;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
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

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public String getServicekey() {
        return servicekey;
    }

    public void setServicekey(String servicekey) {
        this.servicekey = servicekey;
    }

    public Boolean getReleased() {
        return released;
    }

    public void setReleased(Boolean released) {
        this.released = released;
    }

    public BigInteger getFacilityunitserviceid() {
        return facilityunitserviceid;
    }

    public void setFacilityunitserviceid(BigInteger facilityunitserviceid) {
        this.facilityunitserviceid = facilityunitserviceid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }
    
}
