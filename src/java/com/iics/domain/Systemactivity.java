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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "systemactivity", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemactivity.findAll", query = "SELECT s FROM Systemactivity s")
    , @NamedQuery(name = "Systemactivity.findByActivityid", query = "SELECT s FROM Systemactivity s WHERE s.activityid = :activityid")
    , @NamedQuery(name = "Systemactivity.findByActive", query = "SELECT s FROM Systemactivity s WHERE s.active = :active")
    , @NamedQuery(name = "Systemactivity.findByDateadded", query = "SELECT s FROM Systemactivity s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Systemactivity.findByDateupdated", query = "SELECT s FROM Systemactivity s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Systemactivity.findByActivityname", query = "SELECT s FROM Systemactivity s WHERE s.activityname = :activityname")
    , @NamedQuery(name = "Systemactivity.findByDescription", query = "SELECT s FROM Systemactivity s WHERE s.description = :description")
    , @NamedQuery(name = "Systemactivity.findByActivitykey", query = "SELECT s FROM Systemactivity s WHERE s.activitykey = :activitykey")
    , @NamedQuery(name = "Systemactivity.findByReleased", query = "SELECT s FROM Systemactivity s WHERE s.released = :released")
    , @NamedQuery(name = "Systemactivity.findByUnits", query = "SELECT s FROM Systemactivity s WHERE s.units = :units")})
public class Systemactivity implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "SystemactivitySeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "SystemactivitySeq", sequenceName = "Systemactivity_activityid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "activityid", nullable = false)
    private Integer activityid;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "activityname", length = 255)
    private String activityname;
    @Column(name = "description", length = 255)
    private String description;
    @Column(name = "activitykey", length = 25)
    private String activitykey;
    @Basic(optional = false)
    @Column(name = "released", nullable = false)
    private boolean released;
    @Column(name = "units")
    private Integer units;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @OneToMany(mappedBy = "systemactivity")
    private List<Systemactivityservice> systemactivityserviceList;

    public Systemactivity() {
    }

    public Systemactivity(Integer activityid) {
        this.activityid = activityid;
    }

    public Systemactivity(Integer activityid, boolean active, boolean released) {
        this.activityid = activityid;
        this.active = active;
        this.released = released;
    }

    public Integer getActivityid() {
        return activityid;
    }

    public void setActivityid(Integer activityid) {
        this.activityid = activityid;
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

    public String getActivityname() {
        return activityname;
    }

    public void setActivityname(String activityname) {
        this.activityname = activityname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getActivitykey() {
        return activitykey;
    }

    public void setActivitykey(String activitykey) {
        this.activitykey = activitykey;
    }

    public boolean getReleased() {
        return released;
    }

    public void setReleased(boolean released) {
        this.released = released;
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

    @XmlTransient
    public List<Systemactivityservice> getSystemactivityserviceList() {
        return systemactivityserviceList;
    }

    public void setSystemactivityserviceList(List<Systemactivityservice> systemactivityserviceList) {
        this.systemactivityserviceList = systemactivityserviceList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (activityid != null ? activityid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemactivity)) {
            return false;
        }
        Systemactivity other = (Systemactivity) object;
        if ((this.activityid == null && other.activityid != null) || (this.activityid != null && !this.activityid.equals(other.activityid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Systemactivity[ activityid=" + activityid + " ]";
    }
    
}
