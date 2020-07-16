/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

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
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.facilityunitsupplier", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitsupplier.findAll", query = "SELECT f FROM Facilityunitsupplier f")
    , @NamedQuery(name = "Facilityunitsupplier.findByFacilityunitsupplierid", query = "SELECT f FROM Facilityunitsupplier f WHERE f.facilityunitsupplierid = :facilityunitsupplierid")
    , @NamedQuery(name = "Facilityunitsupplier.findByFacilityunitid", query = "SELECT f FROM Facilityunitsupplier f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitsupplier.findBySupplierid", query = "SELECT f FROM Facilityunitsupplier f WHERE f.supplierid = :supplierid")
    , @NamedQuery(name = "Facilityunitsupplier.findBySuppliertype", query = "SELECT f FROM Facilityunitsupplier f WHERE f.suppliertype = :suppliertype")
    , @NamedQuery(name = "Facilityunitsupplier.findByStatus", query = "SELECT f FROM Facilityunitsupplier f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityunitsupplier.findByAddedby", query = "SELECT f FROM Facilityunitsupplier f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityunitsupplier.findByDateadded", query = "SELECT f FROM Facilityunitsupplier f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityunitsupplier.findByLastupdated", query = "SELECT f FROM Facilityunitsupplier f WHERE f.lastupdated = :lastupdated")
    , @NamedQuery(name = "Facilityunitsupplier.findByLastupdatedby", query = "SELECT f FROM Facilityunitsupplier f WHERE f.lastupdatedby = :lastupdatedby")})
public class Facilityunitsupplier implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityunitsupplierid", nullable = false)
    private Integer facilityunitsupplierid;
    @Column(name = "facilityunitid")
    private Long facilityunitid;
    @Column(name = "supplierid")
    private Long supplierid;
    @Size(max = 100)
    @Column(name = "suppliertype", length = 100)
    private String suppliertype;
    @Size(max = 50)
    @Column(name = "status", length = 50)
    private String status;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    
    @Column(name = "approvalcomment")
    private String approvalcomment;
    
    @OneToMany(mappedBy = "facilityunitsupplierid")
    private List<Facilityunitsupplierschedule> facilityunitsupplierscheduleList;

    public Facilityunitsupplier() {
    }

    public Facilityunitsupplier(Integer facilityunitsupplierid) {
        this.facilityunitsupplierid = facilityunitsupplierid;
    }

    public Integer getFacilityunitsupplierid() {
        return facilityunitsupplierid;
    }

    public void setFacilityunitsupplierid(Integer facilityunitsupplierid) {
        this.facilityunitsupplierid = facilityunitsupplierid;
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Long getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(Long supplierid) {
        this.supplierid = supplierid;
    }

    public String getSuppliertype() {
        return suppliertype;
    }

    public void setSuppliertype(String suppliertype) {
        this.suppliertype = suppliertype;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
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

    public Long getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Long lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    @XmlTransient
    public List<Facilityunitsupplierschedule> getFacilityunitsupplierscheduleList() {
        return facilityunitsupplierscheduleList;
    }

    public void setFacilityunitsupplierscheduleList(List<Facilityunitsupplierschedule> facilityunitsupplierscheduleList) {
        this.facilityunitsupplierscheduleList = facilityunitsupplierscheduleList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityunitsupplierid != null ? facilityunitsupplierid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitsupplier)) {
            return false;
        }
        Facilityunitsupplier other = (Facilityunitsupplier) object;
        if ((this.facilityunitsupplierid == null && other.facilityunitsupplierid != null) || (this.facilityunitsupplierid != null && !this.facilityunitsupplierid.equals(other.facilityunitsupplierid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Facilityunitsupplier[ facilityunitsupplierid=" + facilityunitsupplierid + " ]";
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public String getApprovalcomment() {
        return approvalcomment;
    }

    public void setApprovalcomment(String approvalcomment) {
        this.approvalcomment = approvalcomment;
    }
    
}
