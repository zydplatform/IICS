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


/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilityassignedpolicy", catalog = "iics_database", schema = "public")
@NamedQueries({
    @NamedQuery(name = "Facilityassignedpolicy.findAll", query = "SELECT f FROM Facilityassignedpolicy f")
    , @NamedQuery(name = "Facilityassignedpolicy.findByAssignedpolicyid", query = "SELECT f FROM Facilityassignedpolicy f WHERE f.assignedpolicyid = :assignedpolicyid")
    , @NamedQuery(name = "Facilityassignedpolicy.findByDateadded", query = "SELECT f FROM Facilityassignedpolicy f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityassignedpolicy.findByDateupdated", query = "SELECT f FROM Facilityassignedpolicy f WHERE f.dateupdated = :dateupdated")})
public class Facilityassignedpolicy implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "Facilityassignedpolicy_seq")
    @SequenceGenerator(name = "Facilityassignedpolicy_seq", sequenceName = "facilityassignedpolicy_assignedpolicyid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "assignedpolicyid", nullable = false)
    private Long assignedpolicyid;
    @Column(name = "inputvalue")
    private String inputvalue;
    @Column(name = "active")
    private boolean active;
    @Basic(optional = false)
    @Column(name = "dateadded", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid", nullable = false)
    @ManyToOne(optional = false)
    private Facility facility;
    @JoinColumn(name = "policyid", referencedColumnName = "policyid", nullable = false)
    @ManyToOne(optional = false)
    private Facilitypolicy facilitypolicy;
    @JoinColumn(name = "optionsid", referencedColumnName = "optionsid", nullable = false)
    @ManyToOne(optional = false)
    private Facilitypolicyoptions facilitypolicyoptions;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;

    public Facilityassignedpolicy() {
    }

    public Facilityassignedpolicy(Long assignedpolicyid) {
        this.assignedpolicyid = assignedpolicyid;
    }

    public Facilityassignedpolicy(Long assignedpolicyid, Date dateadded) {
        this.assignedpolicyid = assignedpolicyid;
        this.dateadded = dateadded;
    }

    public Long getAssignedpolicyid() {
        return assignedpolicyid;
    }

    public void setAssignedpolicyid(Long assignedpolicyid) {
        this.assignedpolicyid = assignedpolicyid;
    }

    public String getInputvalue() {
        return inputvalue;
    }

    public void setInputvalue(String inputvalue) {
        this.inputvalue = inputvalue;
    }

    public boolean isActive() {
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

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public Facilitypolicy getFacilitypolicy() {
        return facilitypolicy;
    }

    public void setFacilitypolicy(Facilitypolicy facilitypolicy) {
        this.facilitypolicy = facilitypolicy;
    }

    public Facilitypolicyoptions getFacilitypolicyoptions() {
        return facilitypolicyoptions;
    }

    public void setFacilitypolicyoptions(Facilitypolicyoptions facilitypolicyoptions) {
        this.facilitypolicyoptions = facilitypolicyoptions;
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
        hash += (assignedpolicyid != null ? assignedpolicyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityassignedpolicy)) {
            return false;
        }
        Facilityassignedpolicy other = (Facilityassignedpolicy) object;
        if ((this.assignedpolicyid == null && other.assignedpolicyid != null) || (this.assignedpolicyid != null && !this.assignedpolicyid.equals(other.assignedpolicyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilityassignedpolicy[ assignedpolicyid=" + assignedpolicyid + " ]";
    }
    
}
