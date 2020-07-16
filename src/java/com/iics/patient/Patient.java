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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patient", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patient.findAll", query = "SELECT p FROM Patient p")
    , @NamedQuery(name = "Patient.findByPatientid", query = "SELECT p FROM Patient p WHERE p.patientid = :patientid")
    , @NamedQuery(name = "Patient.findByPatientno", query = "SELECT p FROM Patient p WHERE p.patientno = :patientno")
    , @NamedQuery(name = "Patient.findByPersonid", query = "SELECT p FROM Patient p WHERE p.personid = :personid")
    , @NamedQuery(name = "Patient.findByFileno", query = "SELECT p FROM Patient p WHERE p.fileno = :fileno")
    , @NamedQuery(name = "Patient.findByComputerno", query = "SELECT p FROM Patient p WHERE p.computerno = :computerno")
    , @NamedQuery(name = "Patient.findByDatecreated", query = "SELECT p FROM Patient p WHERE p.datecreated = :datecreated")
    , @NamedQuery(name = "Patient.findByCreatedby", query = "SELECT p FROM Patient p WHERE p.createdby = :createdby")
    , @NamedQuery(name = "Patient.findByFacilityid", query = "SELECT p FROM Patient p WHERE p.facilityid = :facilityid")
    , @NamedQuery(name = "Patient.findByPregnancy", query = "SELECT p FROM Patient p WHERE p.pregnancy = :pregnancy")
    , @NamedQuery(name = "Patient.findByPregnant", query = "SELECT p FROM Patient p WHERE p.pregnant = :pregnant")
    , @NamedQuery(name = "Patient.findByTelephone", query = "SELECT p FROM Patient p WHERE p.telephone = :telephone")
    , @NamedQuery(name = "Patient.findByNextofkinname", query = "SELECT p FROM Patient p WHERE p.nextofkinname = :nextofkinname")
    , @NamedQuery(name = "Patient.findByRelationship", query = "SELECT p FROM Patient p WHERE p.relationship = :relationship")
    , @NamedQuery(name = "Patient.findByNextofkincontact", query = "SELECT p FROM Patient p WHERE p.nextofkincontact = :nextofkincontact")})
public class Patient implements Serializable {

    @OneToMany(mappedBy = "patientid")
    private List<Patientvisit> patientvisitList;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "patientid", nullable = false)
    private Long patientid;
    @Size(max = 2147483647)
    @Column(name = "patientno", length = 2147483647)
    private String patientno;
    @Basic(optional = false)
    @NotNull
    @Column(name = "personid", nullable = false)
    private long personid;
    @Size(max = 2147483647)
    @Column(name = "fileno", length = 2147483647)
    private String fileno;
    @Size(max = 2147483647)
    @Column(name = "computerno", length = 2147483647)
    private String computerno;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Column(name = "createdby")
    private BigInteger createdby;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "pregnancy")
    private Boolean pregnancy;
    @Column(name = "pregnant")
    private Boolean pregnant;
    @Size(max = 255)
    @Column(name = "telephone", length = 255)
    private String telephone;
    @Size(max = 255)
    @Column(name = "nextofkinname", length = 255)
    private String nextofkinname;
    @Size(max = 255)
    @Column(name = "relationship", length = 255)
    private String relationship;
    @Size(max = 255)
    @Column(name = "nextofkincontact", length = 255)
    private String nextofkincontact;

    public Patient() {
    }

    public Patient(Long patientid) {
        this.patientid = patientid;
    }

    public Patient(Long patientid, long personid) {
        this.patientid = patientid;
        this.personid = personid;
    }

    public Long getPatientid() {
        return patientid;
    }

    public void setPatientid(Long patientid) {
        this.patientid = patientid;
    }

    public String getPatientno() {
        return patientno;
    }

    public void setPatientno(String patientno) {
        this.patientno = patientno;
    }

    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

    public String getComputerno() {
        return computerno;
    }

    public void setComputerno(String computerno) {
        this.computerno = computerno;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public BigInteger getCreatedby() {
        return createdby;
    }

    public void setCreatedby(BigInteger createdby) {
        this.createdby = createdby;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Boolean getPregnancy() {
        return pregnancy;
    }

    public void setPregnancy(Boolean pregnancy) {
        this.pregnancy = pregnancy;
    }

    public Boolean getPregnant() {
        return pregnant;
    }

    public void setPregnant(Boolean pregnant) {
        this.pregnant = pregnant;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getNextofkinname() {
        return nextofkinname;
    }

    public void setNextofkinname(String nextofkinname) {
        this.nextofkinname = nextofkinname;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getNextofkincontact() {
        return nextofkincontact;
    }

    public void setNextofkincontact(String nextofkincontact) {
        this.nextofkincontact = nextofkincontact;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (patientid != null ? patientid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patient)) {
            return false;
        }
        Patient other = (Patient) object;
        if ((this.patientid == null && other.patientid != null) || (this.patientid != null && !this.patientid.equals(other.patientid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Patient[ patientid=" + patientid + " ]";
    }

    @XmlTransient
    public List<Patientvisit> getPatientvisitList() {
        return patientvisitList;
    }

    public void setPatientvisitList(List<Patientvisit> patientvisitList) {
        this.patientvisitList = patientvisitList;
    }
    
}
