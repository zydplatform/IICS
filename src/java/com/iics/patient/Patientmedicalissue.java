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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patientmedicalissue", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientmedicalissue.findAll", query = "SELECT p FROM Patientmedicalissue p")
    , @NamedQuery(name = "Patientmedicalissue.findByPatientmedicalissueid", query = "SELECT p FROM Patientmedicalissue p WHERE p.patientmedicalissueid = :patientmedicalissueid")
    , @NamedQuery(name = "Patientmedicalissue.findByMedicalissuestate", query = "SELECT p FROM Patientmedicalissue p WHERE p.medicalissuestate = :medicalissuestate")
    , @NamedQuery(name = "Patientmedicalissue.findByDateadded", query = "SELECT p FROM Patientmedicalissue p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientmedicalissue.findByAddedby", query = "SELECT p FROM Patientmedicalissue p WHERE p.addedby = :addedby")})
public class Patientmedicalissue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "patientmedicalissueid", nullable = false)
    private Long patientmedicalissueid;
    @Size(max = 255)
    @Column(name = "medicalissuestate", length = 255)
    private String medicalissuestate;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @JoinColumn(name = "medicalissue", referencedColumnName = "medicalissueid")
    @ManyToOne
    private Medicalissue medicalissue;
    @JoinColumn(name = "patientid", referencedColumnName = "patientid")
    @ManyToOne
    private Patient patientid;

    public Patientmedicalissue() {
    }

    public Patientmedicalissue(Long patientmedicalissueid) {
        this.patientmedicalissueid = patientmedicalissueid;
    }

    public Long getPatientmedicalissueid() {
        return patientmedicalissueid;
    }

    public void setPatientmedicalissueid(Long patientmedicalissueid) {
        this.patientmedicalissueid = patientmedicalissueid;
    }

    public String getMedicalissuestate() {
        return medicalissuestate;
    }

    public void setMedicalissuestate(String medicalissuestate) {
        this.medicalissuestate = medicalissuestate;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Medicalissue getMedicalissue() {
        return medicalissue;
    }

    public void setMedicalissue(Medicalissue medicalissue) {
        this.medicalissue = medicalissue;
    }

    public Patient getPatientid() {
        return patientid;
    }

    public void setPatientid(Patient patientid) {
        this.patientid = patientid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (patientmedicalissueid != null ? patientmedicalissueid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientmedicalissue)) {
            return false;
        }
        Patientmedicalissue other = (Patientmedicalissue) object;
        if ((this.patientmedicalissueid == null && other.patientmedicalissueid != null) || (this.patientmedicalissueid != null && !this.patientmedicalissueid.equals(other.patientmedicalissueid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patientmedicalissue[ patientmedicalissueid=" + patientmedicalissueid + " ]";
    }
    
}
