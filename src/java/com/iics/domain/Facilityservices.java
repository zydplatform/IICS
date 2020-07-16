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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilityservices", catalog = "iics_database", schema = "public")
@NamedQueries({
    @NamedQuery(name = "Facilityservices.findAll", query = "SELECT f FROM Facilityservices f")
    , @NamedQuery(name = "Facilityservices.findByServiceid", query = "SELECT f FROM Facilityservices f WHERE f.serviceid = :serviceid")
    , @NamedQuery(name = "Facilityservices.findByActive", query = "SELECT f FROM Facilityservices f WHERE f.active = :active")
    , @NamedQuery(name = "Facilityservices.findByDateadded", query = "SELECT f FROM Facilityservices f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityservices.findByDateupdated", query = "SELECT f FROM Facilityservices f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilityservices.findByServicename", query = "SELECT f FROM Facilityservices f WHERE f.servicename = :servicename")
    , @NamedQuery(name = "Facilityservices.findByDescription", query = "SELECT f FROM Facilityservices f WHERE f.description = :description")
    , @NamedQuery(name = "Facilityservices.findByServicekey", query = "SELECT f FROM Facilityservices f WHERE f.servicekey = :servicekey")
    , @NamedQuery(name = "Facilityservices.findByReleased", query = "SELECT f FROM Facilityservices f WHERE f.released = :released")})
public class Facilityservices implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "FacilityServiceSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "FacilityServiceSeq", sequenceName = "FacilityService_serviceid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "serviceid", nullable = false)
    private Integer serviceid;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "servicename", length = 255)
    private String servicename;
    @Column(name = "description", length = 255)
    private String description;
    @Column(name = "servicekey", length = 25)
    private String servicekey;
    @Basic(optional = false)
    @Column(name = "released", nullable = false)
    private boolean released;
    @OneToMany(mappedBy = "facilityservices")
    private List<Facilityunitservice> facilityunitserviceList;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @Column(name = "units")
    private Integer units;

    public Facilityservices() {
    }

    public Facilityservices(Integer serviceid) {
        this.serviceid = serviceid;
    }

    public Facilityservices(Integer serviceid, boolean active, boolean released) {
        this.serviceid = serviceid;
        this.active = active;
        this.released = released;
    }

    public Integer getServiceid() {
        return serviceid;
    }

    public void setServiceid(Integer serviceid) {
        this.serviceid = serviceid;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
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

    public String getServicekey() {
        return servicekey;
    }

    public void setServicekey(String servicekey) {
        this.servicekey = servicekey;
    }

    public boolean getReleased() {
        return released;
    }

    public void setReleased(boolean released) {
        this.released = released;
    }

    public List<Facilityunitservice> getFacilityunitserviceList() {
        return facilityunitserviceList;
    }

    public void setFacilityunitserviceList(List<Facilityunitservice> facilityunitserviceList) {
        this.facilityunitserviceList = facilityunitserviceList;
    }

    public Integer getUnits() {
        return units;
    }

    public void setUnits(Integer units) {
        this.units = units;
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
        hash += (serviceid != null ? serviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityservices)) {
            return false;
        }
        Facilityservices other = (Facilityservices) object;
        if ((this.serviceid == null && other.serviceid != null) || (this.serviceid != null && !this.serviceid.equals(other.serviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilityservices[ serviceid=" + serviceid + " ]";
    }
    
}
