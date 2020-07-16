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
@Table(name = "systemactivityservice", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemactivityservice.findAll", query = "SELECT s FROM Systemactivityservice s")
    , @NamedQuery(name = "Systemactivityservice.findByActivityserviceid", query = "SELECT s FROM Systemactivityservice s WHERE s.activityserviceid = :activityserviceid")
    , @NamedQuery(name = "Systemactivityservice.findByStatus", query = "SELECT s FROM Systemactivityservice s WHERE s.status = :status")
    , @NamedQuery(name = "Systemactivityservice.findByDateadded", query = "SELECT s FROM Systemactivityservice s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Systemactivityservice.findByDateupdated", query = "SELECT s FROM Systemactivityservice s WHERE s.dateupdated = :dateupdated")})
public class Systemactivityservice implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "SystemactivityserviceSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "SystemactivityserviceSeq", sequenceName = "Systemactivity_activityserviceid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "activityserviceid", nullable = false)
    private Integer activityserviceid;
    @Basic(optional = false)
    @Column(name = "status", nullable = false)
    private boolean status;
    @Basic(optional = false)
    @Column(name = "dateadded", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "serviceid", referencedColumnName = "serviceid")
    @ManyToOne
    private Facilityservices facilityservices;
    @JoinColumn(name = "addedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @JoinColumn(name = "activityid", referencedColumnName = "activityid")
    @ManyToOne
    private Systemactivity systemactivity;

    public Systemactivityservice() {
    }

    public Systemactivityservice(Integer activityserviceid) {
        this.activityserviceid = activityserviceid;
    }

    public Systemactivityservice(Integer activityserviceid, boolean status, Date dateadded) {
        this.activityserviceid = activityserviceid;
        this.status = status;
        this.dateadded = dateadded;
    }

    public Integer getActivityserviceid() {
        return activityserviceid;
    }

    public void setActivityserviceid(Integer activityserviceid) {
        this.activityserviceid = activityserviceid;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
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

    public Facilityservices getFacilityservices() {
        return facilityservices;
    }

    public void setFacilityservices(Facilityservices facilityservices) {
        this.facilityservices = facilityservices;
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

    public Systemactivity getSystemactivity() {
        return systemactivity;
    }

    public void setSystemactivity(Systemactivity systemactivity) {
        this.systemactivity = systemactivity;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (activityserviceid != null ? activityserviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemactivityservice)) {
            return false;
        }
        Systemactivityservice other = (Systemactivityservice) object;
        if ((this.activityserviceid == null && other.activityserviceid != null) || (this.activityserviceid != null && !this.activityserviceid.equals(other.activityserviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Systemactivityservice[ activityserviceid=" + activityserviceid + " ]";
    }
    
}
