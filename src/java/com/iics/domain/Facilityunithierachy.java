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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilityunithierachy", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunithierachy.findAll", query = "SELECT f FROM Facilityunithierachy f")
    , @NamedQuery(name = "Facilityunithierachy.findByFacilityunitid", query = "SELECT f FROM Facilityunithierachy f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunithierachy.findByFacilityunitname", query = "SELECT f FROM Facilityunithierachy f WHERE f.facilityunitname = :facilityunitname")
    , @NamedQuery(name = "Facilityunithierachy.findByDescription", query = "SELECT f FROM Facilityunithierachy f WHERE f.description = :description")
    , @NamedQuery(name = "Facilityunithierachy.findByShortname", query = "SELECT f FROM Facilityunithierachy f WHERE f.shortname = :shortname")
    , @NamedQuery(name = "Facilityunithierachy.findByMainfacilityunit", query = "SELECT f FROM Facilityunithierachy f WHERE f.mainfacilityunit = :mainfacilityunit")
    , @NamedQuery(name = "Facilityunithierachy.findBySubunits", query = "SELECT f FROM Facilityunithierachy f WHERE f.subunits = :subunits")
    , @NamedQuery(name = "Facilityunithierachy.findByLocation", query = "SELECT f FROM Facilityunithierachy f WHERE f.location = :location")
    , @NamedQuery(name = "Facilityunithierachy.findByTelephone", query = "SELECT f FROM Facilityunithierachy f WHERE f.telephone = :telephone")
    , @NamedQuery(name = "Facilityunithierachy.findByActive", query = "SELECT f FROM Facilityunithierachy f WHERE f.active = :active")
    , @NamedQuery(name = "Facilityunithierachy.findByDateupdated", query = "SELECT f FROM Facilityunithierachy f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilityunithierachy.findByDateadded", query = "SELECT f FROM Facilityunithierachy f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunithierachy.findByService", query = "SELECT f FROM Facilityunithierachy f WHERE f.service = :service")})
public class Facilityunithierachy implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "FacilityUnitHierarchySeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "FacilityUnitHierarchySeq", sequenceName = "FacilityUnitHierarchy_unitid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "facilityunitid", nullable = false)
    private Long facilityunitid;
    @Basic(optional = false)
    @Column(name = "facilityunitname", nullable = false, length = 2147483647)
    private String facilityunitname;
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "shortname", length = 25)
    private String shortname;
    @Basic(optional = false)
    @Column(name = "mainfacilityunit", nullable = false)
    private long mainfacilityunit;
    @Basic(optional = false)
    @Column(name = "subunits", nullable = false)
    private int subunits;
    @Column(name = "location", length = 255)
    private String location;
    @Column(name = "telephone", length = 255)
    private String telephone;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "service")
    private Boolean service;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid")
    @ManyToOne
    private Facility facility;
    @JoinColumn(name = "structureid", referencedColumnName = "structureid")
    @ManyToOne
    private Facilitystructure facilitystructure;
    @JoinColumn(name = "parentid", referencedColumnName = "facilityunitid")
    @ManyToOne
    private Facilityunithierachy facilityunithierachy;
    @JoinColumn(name = "addedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;

    public Facilityunithierachy() {
    }

    public Facilityunithierachy(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Facilityunithierachy(Long facilityunitid, String facilityunitname, long mainfacilityunit, int subunits) {
        this.facilityunitid = facilityunitid;
        this.facilityunitname = facilityunitname;
        this.mainfacilityunit = mainfacilityunit;
        this.subunits = subunits;
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public long getMainfacilityunit() {
        return mainfacilityunit;
    }

    public void setMainfacilityunit(long mainfacilityunit) {
        this.mainfacilityunit = mainfacilityunit;
    }

    public int getSubunits() {
        return subunits;
    }

    public void setSubunits(int subunits) {
        this.subunits = subunits;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Boolean getService() {
        return service;
    }

    public void setService(Boolean service) {
        this.service = service;
    }

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public Facilitystructure getFacilitystructure() {
        return facilitystructure;
    }

    public void setFacilitystructure(Facilitystructure facilitystructure) {
        this.facilitystructure = facilitystructure;
    }

    public Facilityunithierachy getFacilityunithierachy() {
        return facilityunithierachy;
    }

    public void setFacilityunithierachy(Facilityunithierachy facilityunithierachy) {
        this.facilityunithierachy = facilityunithierachy;
    }    

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public Person getPerson1() {
        return person1;
    }

    public void setPerson1(Person person1) {
        this.person1 = person1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitid != null ? facilityunitid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunithierachy)) {
            return false;
        }
        Facilityunithierachy other = (Facilityunithierachy) object;
        if ((this.facilityunitid == null && other.facilityunitid != null) || (this.facilityunitid != null && !this.facilityunitid.equals(other.facilityunitid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilityunithierachy[ facilityunitid=" + facilityunitid + " ]";
    }
    
}
