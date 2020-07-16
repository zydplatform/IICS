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
@Table(name = "labtestclassification", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Labtestclassification.findAll", query = "SELECT l FROM Labtestclassification l")
    , @NamedQuery(name = "Labtestclassification.findByLabtestclassificationid", query = "SELECT l FROM Labtestclassification l WHERE l.labtestclassificationid = :labtestclassificationid")
    , @NamedQuery(name = "Labtestclassification.findByLabtestclassificationname", query = "SELECT l FROM Labtestclassification l WHERE l.labtestclassificationname = :labtestclassificationname")
    , @NamedQuery(name = "Labtestclassification.findByDescription", query = "SELECT l FROM Labtestclassification l WHERE l.description = :description")
    , @NamedQuery(name = "Labtestclassification.findByDateadded", query = "SELECT l FROM Labtestclassification l WHERE l.dateadded = :dateadded")
    , @NamedQuery(name = "Labtestclassification.findByAddedby", query = "SELECT l FROM Labtestclassification l WHERE l.addedby = :addedby")})
public class Labtestclassification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "labtestclassificationid", nullable = false)
    private Long labtestclassificationid;
    @Size(max = 255)
    @Column(name = "labtestclassificationname", length = 255)
    private String labtestclassificationname;
    @Size(max = 255)
    @Column(name = "description", length = 255)
    private String description;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "parentid")
    private Long parentid;
    @Column(name = "isactive")
    private Boolean isactive;
    
    public Labtestclassification() {
    }

    public Labtestclassification(Long labtestclassificationid) {
        this.labtestclassificationid = labtestclassificationid;
    }

    public Long getLabtestclassificationid() {
        return labtestclassificationid;
    }

    public void setLabtestclassificationid(Long labtestclassificationid) {
        this.labtestclassificationid = labtestclassificationid;
    }

    public String getLabtestclassificationname() {
        return labtestclassificationname;
    }

    public void setLabtestclassificationname(String labtestclassificationname) {
        this.labtestclassificationname = labtestclassificationname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (labtestclassificationid != null ? labtestclassificationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Labtestclassification)) {
            return false;
        }
        Labtestclassification other = (Labtestclassification) object;
        if ((this.labtestclassificationid == null && other.labtestclassificationid != null) || (this.labtestclassificationid != null && !this.labtestclassificationid.equals(other.labtestclassificationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Labtestclassification[ labtestclassificationid=" + labtestclassificationid + " ]";
    }
    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }
    
}
