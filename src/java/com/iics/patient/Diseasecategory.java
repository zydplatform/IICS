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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS-GRACE
 */
@Entity
@Table(name = "diseasecategory", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diseasecategory.findAll", query = "SELECT d FROM Diseasecategory d")
    , @NamedQuery(name = "Diseasecategory.findByDiseasecategoryid", query = "SELECT d FROM Diseasecategory d WHERE d.diseasecategoryid = :diseasecategoryid")
    , @NamedQuery(name = "Diseasecategory.findByDiseasecategoryname", query = "SELECT d FROM Diseasecategory d WHERE d.diseasecategoryname = :diseasecategoryname")
    , @NamedQuery(name = "Diseasecategory.findByCreatedby", query = "SELECT d FROM Diseasecategory d WHERE d.createdby = :createdby")
    , @NamedQuery(name = "Diseasecategory.findByUpdatedby", query = "SELECT d FROM Diseasecategory d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Diseasecategory.findByDatecreated", query = "SELECT d FROM Diseasecategory d WHERE d.datecreated = :datecreated")
    , @NamedQuery(name = "Diseasecategory.findByLastupdate", query = "SELECT d FROM Diseasecategory d WHERE d.lastupdate = :lastupdate")
    , @NamedQuery(name = "Diseasecategory.findByStatus", query = "SELECT d FROM Diseasecategory d WHERE d.status = :status")})
public class Diseasecategory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "diseasecategoryid", nullable = false)
    private Long diseasecategoryid;
    @Column(name = "diseasecategoryname", length = 255)
    private String diseasecategoryname;
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
    @Column(name = "diseaseclassificationid")
    private Long diseaseclassificationid;

    public Diseasecategory() {
    }

    public Diseasecategory(Long diseasecategoryid) {
        this.diseasecategoryid = diseasecategoryid;
    }

    public Long getDiseasecategoryid() {
        return diseasecategoryid;
    }

    public void setDiseasecategoryid(Long diseasecategoryid) {
        this.diseasecategoryid = diseasecategoryid;
    }

    public String getDiseasecategoryname() {
        return diseasecategoryname;
    }

    public void setDiseasecategoryname(String diseasecategoryname) {
        this.diseasecategoryname = diseasecategoryname;
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
        hash += (diseasecategoryid != null ? diseasecategoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Diseasecategory)) {
            return false;
        }
        Diseasecategory other = (Diseasecategory) object;
        if ((this.diseasecategoryid == null && other.diseasecategoryid != null) || (this.diseasecategoryid != null && !this.diseasecategoryid.equals(other.diseasecategoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Diseasecategory[ diseasecategoryid=" + diseasecategoryid + " ]";
    }

    public Long getDiseaseclassificationid() {
        return diseaseclassificationid;
    }

    public void setDiseaseclassificationid(Long diseaseclassificationid) {
        this.diseaseclassificationid = diseaseclassificationid;
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
