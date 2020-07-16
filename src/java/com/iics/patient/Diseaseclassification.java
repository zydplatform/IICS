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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS-GRACE
 */
@Entity
@Table(name = "diseaseclassification", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diseaseclassification.findAll", query = "SELECT d FROM Diseaseclassification d")
    , @NamedQuery(name = "Diseaseclassification.findByDiseaseclassificationid", query = "SELECT d FROM Diseaseclassification d WHERE d.diseaseclassificationid = :diseaseclassificationid")
    , @NamedQuery(name = "Diseaseclassification.findByClassifficationname", query = "SELECT d FROM Diseaseclassification d WHERE d.classifficationname = :classifficationname")
    , @NamedQuery(name = "Diseaseclassification.findByCreatedby", query = "SELECT d FROM Diseaseclassification d WHERE d.createdby = :createdby")
    , @NamedQuery(name = "Diseaseclassification.findByUpdatedby", query = "SELECT d FROM Diseaseclassification d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Diseaseclassification.findByDatecreated", query = "SELECT d FROM Diseaseclassification d WHERE d.datecreated = :datecreated")
    , @NamedQuery(name = "Diseaseclassification.findByLastupdate", query = "SELECT d FROM Diseaseclassification d WHERE d.lastupdate = :lastupdate")
    , @NamedQuery(name = "Diseaseclassification.findByStatus", query = "SELECT d FROM Diseaseclassification d WHERE d.status = :status")})
public class Diseaseclassification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "diseaseclassificationid", nullable = false)
    private Long diseaseclassificationid;
    @Column(name = "classifficationname", length = 255)
    private String classifficationname;
    @Column(name = "createdby")
    private Long createdby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "datecreated")
    @Temporal(TemporalType.DATE)
    private Date datecreated;
    @Column(name = "lastupdate")
    @Temporal(TemporalType.DATE)
    private Date lastupdate;
    @Column(name = "status")
    private Boolean status;

    public Diseaseclassification() {
    }

    public Diseaseclassification(Long diseaseclassificationid) {
        this.diseaseclassificationid = diseaseclassificationid;
    }

    public Long getDiseaseclassificationid() {
        return diseaseclassificationid;
    }

    public void setDiseaseclassificationid(Long diseaseclassificationid) {
        this.diseaseclassificationid = diseaseclassificationid;
    }

    public String getClassifficationname() {
        return classifficationname;
    }

    public void setClassifficationname(String classifficationname) {
        this.classifficationname = classifficationname;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public Date getLastupdate() {
        return lastupdate;
    }

    public void setLastupdate(Date lastupdate) {
        this.lastupdate = lastupdate;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (diseaseclassificationid != null ? diseaseclassificationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Diseaseclassification)) {
            return false;
        }
        Diseaseclassification other = (Diseaseclassification) object;
        if ((this.diseaseclassificationid == null && other.diseaseclassificationid != null) || (this.diseaseclassificationid != null && !this.diseaseclassificationid.equals(other.diseaseclassificationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Diseaseclassification[ diseaseclassificationid=" + diseaseclassificationid + " ]";
    }

    public Long getCreatedby() {
        return createdby;
    }

    public void setCreatedby(Long createdby) {
        this.createdby = createdby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }
    
}
