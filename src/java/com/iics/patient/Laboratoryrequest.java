/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "laboratoryrequest", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Laboratoryrequest.findAll", query = "SELECT l FROM Laboratoryrequest l")
    , @NamedQuery(name = "Laboratoryrequest.findByLaboratoryrequestid", query = "SELECT l FROM Laboratoryrequest l WHERE l.laboratoryrequestid = :laboratoryrequestid")
    , @NamedQuery(name = "Laboratoryrequest.findByLaboratoryrequestnumber", query = "SELECT l FROM Laboratoryrequest l WHERE l.laboratoryrequestnumber = :laboratoryrequestnumber")
    , @NamedQuery(name = "Laboratoryrequest.findByOriginunit", query = "SELECT l FROM Laboratoryrequest l WHERE l.originunit = :originunit")
    , @NamedQuery(name = "Laboratoryrequest.findByDestinationunit", query = "SELECT l FROM Laboratoryrequest l WHERE l.destinationunit = :destinationunit")
    , @NamedQuery(name = "Laboratoryrequest.findByDateadded", query = "SELECT l FROM Laboratoryrequest l WHERE l.dateadded = :dateadded")
    , @NamedQuery(name = "Laboratoryrequest.findByAddedby", query = "SELECT l FROM Laboratoryrequest l WHERE l.addedby = :addedby")
    , @NamedQuery(name = "Laboratoryrequest.findByLastupdated", query = "SELECT l FROM Laboratoryrequest l WHERE l.lastupdated = :lastupdated")
    , @NamedQuery(name = "Laboratoryrequest.findByLastupdatedby", query = "SELECT l FROM Laboratoryrequest l WHERE l.lastupdatedby = :lastupdatedby")})
public class Laboratoryrequest implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "laboratoryrequestid", nullable = false)
    private Long laboratoryrequestid;
    @Size(max = 255)
    @Column(name = "laboratoryrequestnumber", length = 255)
    private String laboratoryrequestnumber;
    @Column(name = "originunit")
    private Long originunit;
    @Column(name = "destinationunit")
    private Long destinationunit;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    @OneToMany(mappedBy = "laboratoryrequestid")
    private List<Laboratoryrequesttest> laboratoryrequesttestList;
    @Column(name = "patientvisitid")
    private Long patientvisitid;
    
    @Column(name = "status")
    private String status;
    public Laboratoryrequest() {
    }

    public Laboratoryrequest(Long laboratoryrequestid) {
        this.laboratoryrequestid = laboratoryrequestid;
    }

    public Long getLaboratoryrequestid() {
        return laboratoryrequestid;
    }

    public void setLaboratoryrequestid(Long laboratoryrequestid) {
        this.laboratoryrequestid = laboratoryrequestid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLaboratoryrequestnumber() {
        return laboratoryrequestnumber;
    }

    public void setLaboratoryrequestnumber(String laboratoryrequestnumber) {
        this.laboratoryrequestnumber = laboratoryrequestnumber;
    }

    public Long getOriginunit() {
        return originunit;
    }

    public void setOriginunit(Long originunit) {
        this.originunit = originunit;
    }

    public Long getDestinationunit() {
        return destinationunit;
    }

    public void setDestinationunit(Long destinationunit) {
        this.destinationunit = destinationunit;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public Long getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Long lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    @XmlTransient
    public List<Laboratoryrequesttest> getLaboratoryrequesttestList() {
        return laboratoryrequesttestList;
    }

    public void setLaboratoryrequesttestList(List<Laboratoryrequesttest> laboratoryrequesttestList) {
        this.laboratoryrequesttestList = laboratoryrequesttestList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (laboratoryrequestid != null ? laboratoryrequestid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Laboratoryrequest)) {
            return false;
        }
        Laboratoryrequest other = (Laboratoryrequest) object;
        if ((this.laboratoryrequestid == null && other.laboratoryrequestid != null) || (this.laboratoryrequestid != null && !this.laboratoryrequestid.equals(other.laboratoryrequestid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Laboratoryrequest[ laboratoryrequestid=" + laboratoryrequestid + " ]";
    }

    public Long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }
    
}
