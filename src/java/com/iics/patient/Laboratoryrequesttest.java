/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "laboratoryrequesttest", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Laboratoryrequesttest.findAll", query = "SELECT l FROM Laboratoryrequesttest l")
    , @NamedQuery(name = "Laboratoryrequesttest.findByLaboratoryrequesttestid", query = "SELECT l FROM Laboratoryrequesttest l WHERE l.laboratoryrequesttestid = :laboratoryrequesttestid")
    , @NamedQuery(name = "Laboratoryrequesttest.findByDateadded", query = "SELECT l FROM Laboratoryrequesttest l WHERE l.dateadded = :dateadded")
    , @NamedQuery(name = "Laboratoryrequesttest.findByAddedby", query = "SELECT l FROM Laboratoryrequesttest l WHERE l.addedby = :addedby")
    , @NamedQuery(name = "Laboratoryrequesttest.findByLastupdated", query = "SELECT l FROM Laboratoryrequesttest l WHERE l.lastupdated = :lastupdated")
    , @NamedQuery(name = "Laboratoryrequesttest.findByLastupdatedby", query = "SELECT l FROM Laboratoryrequesttest l WHERE l.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Laboratoryrequesttest.findByComment", query = "SELECT l FROM Laboratoryrequesttest l WHERE l.comment = :comment")})
public class Laboratoryrequesttest implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "laboratoryrequesttestid", nullable = false)
    private Long laboratoryrequesttestid;
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
    @Size(max = 255)
    @Column(name = "comment", length = 255)
    private String comment;
    @Column(name = "laboratoryrequestid")
    private Long laboratoryrequestid;
    @Column(name = "laboratorytestid")
    private Long laboratorytestid;
    @Column(name = "laboratorytestresultid")
    private Long laboratorytestresultid;

    @Column(name = "iscompleted")
    private Boolean iscompleted;
    
     @Column(name = "testresult")
    private String testresult;
     
    public Laboratoryrequesttest() {
    }

    public Laboratoryrequesttest(Long laboratoryrequesttestid) {
        this.laboratoryrequesttestid = laboratoryrequesttestid;
    }

    public Long getLaboratoryrequesttestid() {
        return laboratoryrequesttestid;
    }

    public String getTestresult() {
        return testresult;
    }

    public void setTestresult(String testresult) {
        this.testresult = testresult;
    }

    public void setLaboratoryrequesttestid(Long laboratoryrequesttestid) {
        this.laboratoryrequesttestid = laboratoryrequesttestid;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Boolean getIscompleted() {
        return iscompleted;
    }

    public void setIscompleted(Boolean iscompleted) {
        this.iscompleted = iscompleted;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Long getLaboratoryrequestid() {
        return laboratoryrequestid;
    }

    public void setLaboratoryrequestid(Long laboratoryrequestid) {
        this.laboratoryrequestid = laboratoryrequestid;
    }

    public Long getLaboratorytestid() {
        return laboratorytestid;
    }

    public void setLaboratorytestid(Long laboratorytestid) {
        this.laboratorytestid = laboratorytestid;
    }

    public Long getLaboratorytestresultid() {
        return laboratorytestresultid;
    }

    public void setLaboratorytestresultid(Long laboratorytestresultid) {
        this.laboratorytestresultid = laboratorytestresultid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (laboratoryrequesttestid != null ? laboratoryrequesttestid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Laboratoryrequesttest)) {
            return false;
        }
        Laboratoryrequesttest other = (Laboratoryrequesttest) object;
        if ((this.laboratoryrequesttestid == null && other.laboratoryrequesttestid != null) || (this.laboratoryrequesttestid != null && !this.laboratoryrequesttestid.equals(other.laboratoryrequesttestid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Laboratoryrequesttest[ laboratoryrequesttestid=" + laboratoryrequesttestid + " ]";
    }
    
}
