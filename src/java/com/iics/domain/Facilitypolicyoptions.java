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
@Table(name = "facilitypolicyoptions", catalog = "iics_database", schema = "public")
@NamedQueries({
    @NamedQuery(name = "Facilitypolicyoptions.findAll", query = "SELECT f FROM Facilitypolicyoptions f")
    , @NamedQuery(name = "Facilitypolicyoptions.findByOptionsid", query = "SELECT f FROM Facilitypolicyoptions f WHERE f.optionsid = :optionsid")
    , @NamedQuery(name = "Facilitypolicyoptions.findByName", query = "SELECT f FROM Facilitypolicyoptions f WHERE f.name = :name")
    , @NamedQuery(name = "Facilitypolicyoptions.findByActive", query = "SELECT f FROM Facilitypolicyoptions f WHERE f.active = :active")
    , @NamedQuery(name = "Facilitypolicyoptions.findByDateadded", query = "SELECT f FROM Facilitypolicyoptions f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitypolicyoptions.findByDateupdated", query = "SELECT f FROM Facilitypolicyoptions f WHERE f.dateupdated = :dateupdated")})
public class Facilitypolicyoptions implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "Facilitypolicyoptions_seq")
    @SequenceGenerator(name = "Facilitypolicyoptions_seq", sequenceName = "facilitypolicyoptions_assignedpolicyoptionsid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "optionsid", nullable = false)
    private Long optionsid;
    @Basic(optional = false)
    @Column(name = "name", nullable = false, length = 2147483647)
    private String name;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "policyid", referencedColumnName = "policyid", nullable = false)
    @ManyToOne(optional = false)
    private Facilitypolicy facilitypolicy;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person1;

    public Facilitypolicyoptions() {
    }

    public Facilitypolicyoptions(Long optionsid) {
        this.optionsid = optionsid;
    }

    public Facilitypolicyoptions(Long optionsid, String name, boolean active) {
        this.optionsid = optionsid;
        this.name = name;
        this.active = active;
    }

    public Long getOptionsid() {
        return optionsid;
    }

    public void setOptionsid(Long optionsid) {
        this.optionsid = optionsid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Facilitypolicy getFacilitypolicy() {
        return facilitypolicy;
    }

    public void setFacilitypolicy(Facilitypolicy facilitypolicy) {
        this.facilitypolicy = facilitypolicy;
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
        hash += (optionsid != null ? optionsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitypolicyoptions)) {
            return false;
        }
        Facilitypolicyoptions other = (Facilitypolicyoptions) object;
        if ((this.optionsid == null && other.optionsid != null) || (this.optionsid != null && !this.optionsid.equals(other.optionsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitypolicyoptions[ optionsid=" + optionsid + " ]";
    }
    
}
