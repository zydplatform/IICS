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
@Table(name = "facilityunitservice", catalog = "iics_database", schema = "public")
@NamedQueries({
    @NamedQuery(name = "Facilityunitservice.findAll", query = "SELECT f FROM Facilityunitservice f")
    , @NamedQuery(name = "Facilityunitservice.findByFacilityunitserviceid", query = "SELECT f FROM Facilityunitservice f WHERE f.facilityunitserviceid = :facilityunitserviceid")
    , @NamedQuery(name = "Facilityunitservice.findByStatus", query = "SELECT f FROM Facilityunitservice f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityunitservice.findByDateadded", query = "SELECT f FROM Facilityunitservice f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitservice.findByDateupdated", query = "SELECT f FROM Facilityunitservice f WHERE f.dateupdated = :dateupdated")})
public class Facilityunitservice implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "FacilityUnitServiceSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "FacilityUnitServiceSeq", sequenceName = "FacilityUnitService_unitserviceid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "facilityunitserviceid", nullable = false)
    private Long facilityunitserviceid;
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
    @JoinColumn(name = "facilityunitid", referencedColumnName = "facilityunitid")
    @ManyToOne
    private Facilityunit facilityunit;
    @JoinColumn(name = "addedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;

    public Facilityunitservice() {
    }

    public Facilityunitservice(Long facilityunitserviceid) {
        this.facilityunitserviceid = facilityunitserviceid;
    }

    public Facilityunitservice(Long facilityunitserviceid, String description, String servicename, boolean status, Date dateadded) {
        this.facilityunitserviceid = facilityunitserviceid;
        this.status = status;
        this.dateadded = dateadded;
    }

    public Long getFacilityunitserviceid() {
        return facilityunitserviceid;
    }

    public void setFacilityunitserviceid(Long facilityunitserviceid) {
        this.facilityunitserviceid = facilityunitserviceid;
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

    public Facilityunit getFacilityunit() {
        return facilityunit;
    }

    public void setFacilityunit(Facilityunit facilityunit) {
        this.facilityunit = facilityunit;
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
        hash += (facilityunitserviceid != null ? facilityunitserviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitservice)) {
            return false;
        }
        Facilityunitservice other = (Facilityunitservice) object;
        if ((this.facilityunitserviceid == null && other.facilityunitserviceid != null) || (this.facilityunitserviceid != null && !this.facilityunitserviceid.equals(other.facilityunitserviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilityunitservice[ facilityunitserviceid=" + facilityunitserviceid + " ]";
    }
    
}
