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
@Table(name = "laboratorytestresult", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Laboratorytestresult.findAll", query = "SELECT l FROM Laboratorytestresult l")
    , @NamedQuery(name = "Laboratorytestresult.findByLaboratorytestresultid", query = "SELECT l FROM Laboratorytestresult l WHERE l.laboratorytestresultid = :laboratorytestresultid")
    , @NamedQuery(name = "Laboratorytestresult.findByTestresultname", query = "SELECT l FROM Laboratorytestresult l WHERE l.testresultname = :testresultname")
    , @NamedQuery(name = "Laboratorytestresult.findByAddedby", query = "SELECT l FROM Laboratorytestresult l WHERE l.addedby = :addedby")
    , @NamedQuery(name = "Laboratorytestresult.findByDateadded", query = "SELECT l FROM Laboratorytestresult l WHERE l.dateadded = :dateadded")
    , @NamedQuery(name = "Laboratorytestresult.findByLastupdated", query = "SELECT l FROM Laboratorytestresult l WHERE l.lastupdated = :lastupdated")
    , @NamedQuery(name = "Laboratorytestresult.findByLastupdatedby", query = "SELECT l FROM Laboratorytestresult l WHERE l.lastupdatedby = :lastupdatedby")})
public class Laboratorytestresult implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "laboratorytestresultid", nullable = false)
    private Long laboratorytestresultid;
    @Size(max = 255)
    @Column(name = "testresultname", length = 255)
    private String testresultname;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    @Column(name = "laboratorytestid")
    private Long laboratorytestid;
    @OneToMany(mappedBy = "laboratorytestresultid")
    private List<Laboratoryrequesttest> laboratoryrequesttestList;

    public Laboratorytestresult() {
    }

    public Laboratorytestresult(Long laboratorytestresultid) {
        this.laboratorytestresultid = laboratorytestresultid;
    }

    public Long getLaboratorytestresultid() {
        return laboratorytestresultid;
    }

    public void setLaboratorytestresultid(Long laboratorytestresultid) {
        this.laboratorytestresultid = laboratorytestresultid;
    }

    public String getTestresultname() {
        return testresultname;
    }

    public void setTestresultname(String testresultname) {
        this.testresultname = testresultname;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
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

    public Long getLaboratorytestid() {
        return laboratorytestid;
    }

    public void setLaboratorytestid(Long laboratorytestid) {
        this.laboratorytestid = laboratorytestid;
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
        hash += (laboratorytestresultid != null ? laboratorytestresultid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Laboratorytestresult)) {
            return false;
        }
        Laboratorytestresult other = (Laboratorytestresult) object;
        if ((this.laboratorytestresultid == null && other.laboratorytestresultid != null) || (this.laboratorytestresultid != null && !this.laboratorytestresultid.equals(other.laboratorytestresultid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Laboratorytestresult[ laboratorytestresultid=" + laboratorytestresultid + " ]";
    }
    
}
