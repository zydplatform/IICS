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
@Table(name = "laboratorytest", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Laboratorytest.findAll", query = "SELECT l FROM Laboratorytest l")
    , @NamedQuery(name = "Laboratorytest.findByLaboratorytestid", query = "SELECT l FROM Laboratorytest l WHERE l.laboratorytestid = :laboratorytestid")
    , @NamedQuery(name = "Laboratorytest.findByTestname", query = "SELECT l FROM Laboratorytest l WHERE l.testname = :testname")
    , @NamedQuery(name = "Laboratorytest.findByAddedby", query = "SELECT l FROM Laboratorytest l WHERE l.addedby = :addedby")
    , @NamedQuery(name = "Laboratorytest.findByDateadded", query = "SELECT l FROM Laboratorytest l WHERE l.dateadded = :dateadded")})
public class Laboratorytest implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "laboratorytestid", nullable = false)
    private Long laboratorytestid;
    @Size(max = 255)
    @Column(name = "testname", length = 255)
    private String testname;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @OneToMany(mappedBy = "laboratorytestid")
    private List<Laboratorytestresult> laboratorytestresultList;
    @OneToMany(mappedBy = "laboratorytestid")
    private List<Laboratoryrequesttest> laboratoryrequesttestList;

    @Column(name = "labtestclassificationid")
    private Long labtestclassificationid;
    @Column(name = "parentid")
    private Long parentid;
    @Column(name = "description")
    private String description;
    @Column(name = "unitofmeasure")
    private String unitofmeasure;
    @Column(name = "testrange")
    private String testrange;

    @Column(name = "testmethodid")
    private Long testmethodid;

    public Laboratorytest() {
    }

    public Laboratorytest(Long laboratorytestid) {
        this.laboratorytestid = laboratorytestid;
    }

    public Long getLaboratorytestid() {
        return laboratorytestid;
    }

    public void setLaboratorytestid(Long laboratorytestid) {
        this.laboratorytestid = laboratorytestid;
    }

    public String getTestname() {
        return testname;
    }

    public void setTestname(String testname) {
        this.testname = testname;
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

    @XmlTransient
    public List<Laboratorytestresult> getLaboratorytestresultList() {
        return laboratorytestresultList;
    }

    public void setLaboratorytestresultList(List<Laboratorytestresult> laboratorytestresultList) {
        this.laboratorytestresultList = laboratorytestresultList;
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
        hash += (laboratorytestid != null ? laboratorytestid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Laboratorytest)) {
            return false;
        }
        Laboratorytest other = (Laboratorytest) object;
        if ((this.laboratorytestid == null && other.laboratorytestid != null) || (this.laboratorytestid != null && !this.laboratorytestid.equals(other.laboratorytestid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Laboratorytest[ laboratorytestid=" + laboratorytestid + " ]";
    }

    public Long getLabtestclassificationid() {
        return labtestclassificationid;
    }

    public void setLabtestclassificationid(Long labtestclassificationid) {
        this.labtestclassificationid = labtestclassificationid;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUnitofmeasure() {
        return unitofmeasure;
    }

    public void setUnitofmeasure(String unitofmeasure) {
        this.unitofmeasure = unitofmeasure;
    }

    public String getTestrange() {
        return testrange;
    }

    public void setTestrange(String testrange) {
        this.testrange = testrange;
    }

    public Long getTestmethodid() {
        return testmethodid;
    }

    public void setTestmethodid(Long testmethodid) {
        this.testmethodid = testmethodid;
    }

}
