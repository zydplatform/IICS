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
 * @author HP
 */
@Entity
@Table(name = "triage", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Triage.findAll", query = "SELECT t FROM Triage t")
    , @NamedQuery(name = "Triage.findByTriageid", query = "SELECT t FROM Triage t WHERE t.triageid = :triageid")
    , @NamedQuery(name = "Triage.findByWeight", query = "SELECT t FROM Triage t WHERE t.weight = :weight")
    , @NamedQuery(name = "Triage.findByTemperature", query = "SELECT t FROM Triage t WHERE t.temperature = :temperature")
    , @NamedQuery(name = "Triage.findByHeight", query = "SELECT t FROM Triage t WHERE t.height = :height")
    , @NamedQuery(name = "Triage.findByPulse", query = "SELECT t FROM Triage t WHERE t.pulse = :pulse")
    , @NamedQuery(name = "Triage.findByHeadcircum", query = "SELECT t FROM Triage t WHERE t.headcircum = :headcircum")
    , @NamedQuery(name = "Triage.findByBodysurfacearea", query = "SELECT t FROM Triage t WHERE t.bodysurfacearea = :bodysurfacearea")
    , @NamedQuery(name = "Triage.findByRespirationrate", query = "SELECT t FROM Triage t WHERE t.respirationrate = :respirationrate")
    , @NamedQuery(name = "Triage.findByNotes", query = "SELECT t FROM Triage t WHERE t.notes = :notes")
    , @NamedQuery(name = "Triage.findByAddedby", query = "SELECT t FROM Triage t WHERE t.addedby = :addedby")
    , @NamedQuery(name = "Triage.findByPatientpressuresystolic", query = "SELECT t FROM Triage t WHERE t.patientpressuresystolic = :patientpressuresystolic")
    , @NamedQuery(name = "Triage.findByPatientpressurediastolic", query = "SELECT t FROM Triage t WHERE t.patientpressurediastolic = :patientpressurediastolic")
    , @NamedQuery(name = "Triage.findByDateadded", query = "SELECT t FROM Triage t WHERE t.dateadded = :dateadded")})
public class Triage implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "triageid", nullable = false)
    private Long triageid;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "weight", precision = 17, scale = 17)
    private Double weight;
    @Column(name = "temperature", precision = 17, scale = 17)
    private Double temperature;
    @Column(name = "height", precision = 17, scale = 17)
    private Double height;
    @Column(name = "pulse")
    private Integer pulse;
    @Column(name = "headcircum", precision = 17, scale = 17)
    private Double headcircum;
    @Column(name = "bodysurfacearea", precision = 17, scale = 17)
    private Double bodysurfacearea;
    @Column(name = "respirationrate")
    private Integer respirationrate;
    @Size(max = 2147483647)
    @Column(name = "notes", length = 2147483647)
    private String notes;
    @Column(name = "muac", precision = 17, scale = 17)
    private Double muac;        
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "patientpressuresystolic")
    private Long patientpressuresystolic;
    @Column(name = "patientpressurediastolic")
    private Long patientpressurediastolic;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "patientvisitid")
    private Long patientvisitid;

    public Triage() {
    }

    public Triage(Long triageid) {
        this.triageid = triageid;
    }

    public Long getTriageid() {
        return triageid;
    }

    public void setTriageid(Long triageid) {
        this.triageid = triageid;
    }
    
    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Double getTemperature() {
        return temperature;
    }

    public void setTemperature(Double temperature) {
        this.temperature = temperature;
    }

    public Double getHeight() {
        return height;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public Integer getPulse() {
        return pulse;
    }

    public void setPulse(Integer pulse) {
        this.pulse = pulse;
    }

    public Double getHeadcircum() {
        return headcircum;
    }

    public void setHeadcircum(Double headcircum) {
        this.headcircum = headcircum;
    }

    public Double getBodysurfacearea() {
        return bodysurfacearea;
    }

    public void setBodysurfacearea(Double bodysurfacearea) {
        this.bodysurfacearea = bodysurfacearea;
    }

    public Integer getRespirationrate() {
        return respirationrate;
    }

    public void setRespirationrate(Integer respirationrate) {
        this.respirationrate = respirationrate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }    

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (triageid != null ? triageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Triage)) {
            return false;
        }
        Triage other = (Triage) object;
        if ((this.triageid == null && other.triageid != null) || (this.triageid != null && !this.triageid.equals(other.triageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Triage[ triageid=" + triageid + " ]";
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getPatientpressuresystolic() {
        return patientpressuresystolic;
    }

    public void setPatientpressuresystolic(Long patientpressuresystolic) {
        this.patientpressuresystolic = patientpressuresystolic;
    }

    public Long getPatientpressurediastolic() {
        return patientpressurediastolic;
    }

    public void setPatientpressurediastolic(Long patientpressurediastolic) {
        this.patientpressurediastolic = patientpressurediastolic;
    }

    public Long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }
    
    public Double getMuac() {
        return muac;
    }

    public void setMuac(Double muac) {
        this.muac = muac;
    }
    
}
