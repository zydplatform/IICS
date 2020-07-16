/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
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
@Table(name = "symptom", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Symptom.findAll", query = "SELECT s FROM Symptom s")
    , @NamedQuery(name = "Symptom.findBySymptomid", query = "SELECT s FROM Symptom s WHERE s.symptomid = :symptomid")
    , @NamedQuery(name = "Symptom.findBySymptom", query = "SELECT s FROM Symptom s WHERE s.symptom = :symptom")
    , @NamedQuery(name = "Symptom.findByAddedby", query = "SELECT s FROM Symptom s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Symptom.findByDateadded", query = "SELECT s FROM Symptom s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Symptom.findByLastupdated", query = "SELECT s FROM Symptom s WHERE s.lastupdated = :lastupdated")
    , @NamedQuery(name = "Symptom.findByLastupdatedby", query = "SELECT s FROM Symptom s WHERE s.lastupdatedby = :lastupdatedby")})
public class Symptom implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "symptomid", nullable = false)
    private Long symptomid;
    @Size(max = 255)
    @Column(name = "symptom", length = 255)
    private String symptom;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @OneToMany(mappedBy = "symptomid")
    private List<Diseasesymptom> diseasesymptomList;

    public Symptom() {
    }

    public Symptom(Long symptomid) {
        this.symptomid = symptomid;
    }

    public Long getSymptomid() {
        return symptomid;
    }

    public void setSymptomid(Long symptomid) {
        this.symptomid = symptomid;
    }

    public String getSymptom() {
        return symptom;
    }

    public void setSymptom(String symptom) {
        this.symptom = symptom;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
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

    public BigInteger getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(BigInteger lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    @XmlTransient
    public List<Diseasesymptom> getDiseasesymptomList() {
        return diseasesymptomList;
    }

    public void setDiseasesymptomList(List<Diseasesymptom> diseasesymptomList) {
        this.diseasesymptomList = diseasesymptomList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (symptomid != null ? symptomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Symptom)) {
            return false;
        }
        Symptom other = (Symptom) object;
        if ((this.symptomid == null && other.symptomid != null) || (this.symptomid != null && !this.symptomid.equals(other.symptomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Symptom[ symptomid=" + symptomid + " ]";
    }
    
}
