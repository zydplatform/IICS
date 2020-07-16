/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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


/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facilityunit", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunit.findAll", query = "SELECT f FROM Facilityunit f")
    , @NamedQuery(name = "Facilityunit.findByFacilityunitid", query = "SELECT f FROM Facilityunit f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunit.findByFacilityunitname", query = "SELECT f FROM Facilityunit f WHERE f.facilityunitname = :facilityunitname")
    , @NamedQuery(name = "Facilityunit.findByDescription", query = "SELECT f FROM Facilityunit f WHERE f.description = :description")
    , @NamedQuery(name = "Facilityunit.findByShortname", query = "SELECT f FROM Facilityunit f WHERE f.shortname = :shortname")
    , @NamedQuery(name = "Facilityunit.findByMainfacilityunit", query = "SELECT f FROM Facilityunit f WHERE f.mainfacilityunit = :mainfacilityunit")
    , @NamedQuery(name = "Facilityunit.findBySubunits", query = "SELECT f FROM Facilityunit f WHERE f.subunits = :subunits")
    , @NamedQuery(name = "Facilityunit.findByLocation", query = "SELECT f FROM Facilityunit f WHERE f.location = :location")
    , @NamedQuery(name = "Facilityunit.findByTelephone", query = "SELECT f FROM Facilityunit f WHERE f.telephone = :telephone")
    , @NamedQuery(name = "Facilityunit.findByUnittypename", query = "SELECT f FROM Facilityunit f WHERE f.unittypename = :unittypename")
    , @NamedQuery(name = "Facilityunit.findByActive", query = "SELECT f FROM Facilityunit f WHERE f.active = :active")})
public class Facilityunit implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityunitid", nullable = false)
    private Long facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "facilityunitname", nullable = false, length = 2147483647)
    private String facilityunitname;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Size(max = 25)
    @Column(name = "shortname")
    private String shortname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "mainfacilityunit", nullable = false)
    private long mainfacilityunit;
    @Basic(optional = false)
    @NotNull
    @Column(name = "subunits", nullable = false)
    private int subunits;
    @Size(max = 255)
    @Column(name = "location", length = 255)
    private String location;
    @Size(max = 255)
    @Column(name = "telephone", length = 255)
    private String telephone;
    @Size(max = 255)
    @Column(name = "unittypename", length = 255)
    private String unittypename;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "service")
    private Boolean service;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "supplierid")
    private long supplierid;
    @Basic(optional = false)
    @Column(name = "dateadded", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @JoinColumn(name = "structureid", referencedColumnName = "structureid")
    @ManyToOne
    private Facilitystructure facilitystructure;
    @JoinColumn(name = "parentid", referencedColumnName = "facilityunitid")
    @ManyToOne
    private Facilityunithierachy facilityunithierachy;
    

    @Column(name = "ismainstore")
    private Boolean ismainstore;
    
    public Facilityunit() {
    }

    public Facilityunit(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Facilityunit(Long facilityunitid, String facilityunitname, long mainfacilityunit, int subunits) {
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

    public Boolean getService() {
        return service;
    }

    public void setService(Boolean service) {
        this.service = service;
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

    public Facilitystructure getFacilitystructure() {
        return facilitystructure;
    }

    public Facilityunithierachy getFacilityunithierachy() {
        return facilityunithierachy;
    }

    public void setFacilityunithierachy(Facilityunithierachy facilityunithierachy) {
        this.facilityunithierachy = facilityunithierachy;
    }    

    public void setFacilitystructure(Facilitystructure facilitystructure) {
        this.facilitystructure = facilitystructure;
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

    public String getUnittypename() {
        return unittypename;
    }

    public void setUnittypename(String unittypename) {
        this.unittypename = unittypename;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
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
        if (!(object instanceof Facilityunit)) {
            return false;
        }
        Facilityunit other = (Facilityunit) object;
        if ((this.facilityunitid == null && other.facilityunitid != null) || (this.facilityunitid != null && !this.facilityunitid.equals(other.facilityunitid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilityunit[ facilityunitid=" + facilityunitid + " ]";
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public long getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(long supplierid) {
        this.supplierid = supplierid;
    }

    public Boolean getIsmainstore() {
        return ismainstore;
    }

    public void setIsmainstore(Boolean ismainstore) {
        this.ismainstore = ismainstore;
    }
    
}