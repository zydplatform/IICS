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
@Table(name = "medicalissue", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Medicalissue.findAll", query = "SELECT m FROM Medicalissue m")
    , @NamedQuery(name = "Medicalissue.findByMedicalissueid", query = "SELECT m FROM Medicalissue m WHERE m.medicalissueid = :medicalissueid")
    , @NamedQuery(name = "Medicalissue.findByMedicalissuename", query = "SELECT m FROM Medicalissue m WHERE m.medicalissuename = :medicalissuename")
    , @NamedQuery(name = "Medicalissue.findByIssuedescription", query = "SELECT m FROM Medicalissue m WHERE m.issuedescription = :issuedescription")
    , @NamedQuery(name = "Medicalissue.findByDateadded", query = "SELECT m FROM Medicalissue m WHERE m.dateadded = :dateadded")
    , @NamedQuery(name = "Medicalissue.findByAddedby", query = "SELECT m FROM Medicalissue m WHERE m.addedby = :addedby")})
public class Medicalissue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "medicalissueid", nullable = false)
    private Long medicalissueid;
    @Size(max = 255)
    @Column(name = "medicalissuename", length = 255)
    private String medicalissuename;
    @Size(max = 2147483647)
    @Column(name = "issuedescription", length = 2147483647)
    private String issuedescription;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @OneToMany(mappedBy = "medicalissue")
    private List<Patientmedicalissue> patientmedicalissueList;

    public Medicalissue() {
    }

    public Medicalissue(Long medicalissueid) {
        this.medicalissueid = medicalissueid;
    }

    public Long getMedicalissueid() {
        return medicalissueid;
    }

    public void setMedicalissueid(Long medicalissueid) {
        this.medicalissueid = medicalissueid;
    }

    public String getMedicalissuename() {
        return medicalissuename;
    }

    public void setMedicalissuename(String medicalissuename) {
        this.medicalissuename = medicalissuename;
    }

    public String getIssuedescription() {
        return issuedescription;
    }

    public void setIssuedescription(String issuedescription) {
        this.issuedescription = issuedescription;
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

    @XmlTransient
    public List<Patientmedicalissue> getPatientmedicalissueList() {
        return patientmedicalissueList;
    }

    public void setPatientmedicalissueList(List<Patientmedicalissue> patientmedicalissueList) {
        this.patientmedicalissueList = patientmedicalissueList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (medicalissueid != null ? medicalissueid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Medicalissue)) {
            return false;
        }
        Medicalissue other = (Medicalissue) object;
        if ((this.medicalissueid == null && other.medicalissueid != null) || (this.medicalissueid != null && !this.medicalissueid.equals(other.medicalissueid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Medicalissue[ medicalissueid=" + medicalissueid + " ]";
    }
    
}
