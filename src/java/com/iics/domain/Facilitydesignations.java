/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author SAMINUNU
 */
@Entity
@Table(name = "facilitydesignations", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitydesignations.findAll", query = "SELECT f FROM Facilitydesignations f")
    , @NamedQuery(name = "Facilitydesignations.findByFacilitydesignationsid", query = "SELECT f FROM Facilitydesignations f WHERE f.facilitydesignationsid = :facilitydesignationsid")
    , @NamedQuery(name = "Facilitydesignations.findByDesignationcategoryid", query = "SELECT f FROM Facilitydesignations f WHERE f.designationcategoryid = :designationcategoryid")
    , @NamedQuery(name = "Facilitydesignations.findByDesignationid", query = "SELECT f FROM Facilitydesignations f WHERE f.designationid = :designationid")
    , @NamedQuery(name = "Facilitydesignations.findByFacilityid", query = "SELECT f FROM Facilitydesignations f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitydesignations.findByDateadded", query = "SELECT f FROM Facilitydesignations f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitydesignations.findByAddedby", query = "SELECT f FROM Facilitydesignations f WHERE f.addedby = :addedby")})
public class Facilitydesignations implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilitydesignationsid", nullable = false)
    private Integer facilitydesignationsid;
    @Column(name = "designationcategoryid")
    private Integer designationcategoryid;
    @Column(name = "designationid")
    private Integer designationid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Size(max = 2147483647)
    @Column(name = "addedby", length = 2147483647)
    private Long addedby;

    public Facilitydesignations() {
    }

    public Facilitydesignations(Integer facilitydesignationsid) {
        this.facilitydesignationsid = facilitydesignationsid;
    }

    public Integer getFacilitydesignationsid() {
        return facilitydesignationsid;
    }

    public void setFacilitydesignationsid(Integer facilitydesignationsid) {
        this.facilitydesignationsid = facilitydesignationsid;
    }

    public Integer getDesignationcategoryid() {
        return designationcategoryid;
    }

    public void setDesignationcategoryid(Integer designationcategoryid) {
        this.designationcategoryid = designationcategoryid;
    }

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
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
        hash += (facilitydesignationsid != null ? facilitydesignationsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitydesignations)) {
            return false;
        }
        Facilitydesignations other = (Facilitydesignations) object;
        if ((this.facilitydesignationsid == null && other.facilitydesignationsid != null) || (this.facilitydesignationsid != null && !this.facilitydesignationsid.equals(other.facilitydesignationsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitydesignations[ facilitydesignationsid=" + facilitydesignationsid + " ]";
    }

}
