/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "diseasesymptom", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diseasesymptom.findAll", query = "SELECT d FROM Diseasesymptom d")
    , @NamedQuery(name = "Diseasesymptom.findByDiseasesymptomid", query = "SELECT d FROM Diseasesymptom d WHERE d.diseasesymptomid = :diseasesymptomid")
    , @NamedQuery(name = "Diseasesymptom.findByAddedby", query = "SELECT d FROM Diseasesymptom d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Diseasesymptom.findByDateadded", query = "SELECT d FROM Diseasesymptom d WHERE d.dateadded = :dateadded")
    , @NamedQuery(name = "Diseasesymptom.findByIscritical", query = "SELECT d FROM Diseasesymptom d WHERE d.iscritical = :iscritical")})
public class Diseasesymptom implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "diseasesymptomid", nullable = false)
    private Long diseasesymptomid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "iscritical")
    private Boolean iscritical;
    @JoinColumn(name = "diseaseid", referencedColumnName = "diseaseid")
    @ManyToOne
    private Disease diseaseid;
    @JoinColumn(name = "symptomid", referencedColumnName = "symptomid")
    @ManyToOne
    private Symptom symptomid;

    public Diseasesymptom() {
    }

    public Diseasesymptom(Long diseasesymptomid) {
        this.diseasesymptomid = diseasesymptomid;
    }

    public Long getDiseasesymptomid() {
        return diseasesymptomid;
    }

    public void setDiseasesymptomid(Long diseasesymptomid) {
        this.diseasesymptomid = diseasesymptomid;
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

    public Boolean getIscritical() {
        return iscritical;
    }

    public void setIscritical(Boolean iscritical) {
        this.iscritical = iscritical;
    }

    public Disease getDiseaseid() {
        return diseaseid;
    }

    public void setDiseaseid(Disease diseaseid) {
        this.diseaseid = diseaseid;
    }

    public Symptom getSymptomid() {
        return symptomid;
    }

    public void setSymptomid(Symptom symptomid) {
        this.symptomid = symptomid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (diseasesymptomid != null ? diseasesymptomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Diseasesymptom)) {
            return false;
        }
        Diseasesymptom other = (Diseasesymptom) object;
        if ((this.diseasesymptomid == null && other.diseasesymptomid != null) || (this.diseasesymptomid != null && !this.diseasesymptomid.equals(other.diseasesymptomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Diseasesymptom[ diseasesymptomid=" + diseasesymptomid + " ]";
    }
    
}
