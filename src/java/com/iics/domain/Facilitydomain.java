/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facilitydomain", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitydomain.findAll", query = "SELECT f FROM Facilitydomain f")
    , @NamedQuery(name = "Facilitydomain.findByFacilitydomainid", query = "SELECT f FROM Facilitydomain f WHERE f.facilitydomainid = :facilitydomainid")
    , @NamedQuery(name = "Facilitydomain.findByDescription", query = "SELECT f FROM Facilitydomain f WHERE f.description = :description")
    , @NamedQuery(name = "Facilitydomain.findByDomainname", query = "SELECT f FROM Facilitydomain f WHERE f.domainname = :domainname")
    , @NamedQuery(name = "Facilitydomain.findByStatus", query = "SELECT f FROM Facilitydomain f WHERE f.status = :status")})
public class Facilitydomain implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilitydomainid", nullable = false)
    private Integer facilitydomainid;
    @Size(max = 255)
    @Column(name = "description", length = 255)
    private String description;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "domainname", nullable = false, length = 255)
    private String domainname;
    @Column(name = "status")
    private Boolean status;
    @OneToMany(mappedBy = "facilitydomainid")
    private List<Facility> facilityList;

    public Facilitydomain() {
    }

    public Facilitydomain(Integer facilitydomainid) {
        this.facilitydomainid = facilitydomainid;
    }

    public Facilitydomain(Integer facilitydomainid, String domainname) {
        this.facilitydomainid = facilitydomainid;
        this.domainname = domainname;
    }

    public Integer getFacilitydomainid() {
        return facilitydomainid;
    }

    public void setFacilitydomainid(Integer facilitydomainid) {
        this.facilitydomainid = facilitydomainid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDomainname() {
        return domainname;
    }

    public void setDomainname(String domainname) {
        this.domainname = domainname;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
    
    @XmlTransient
    public List<Facility> getFacilityList() {
        return facilityList;
    }

    public void setFacilityList(List<Facility> facilityList) {
        this.facilityList = facilityList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilitydomainid != null ? facilitydomainid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitydomain)) {
            return false;
        }
        Facilitydomain other = (Facilitydomain) object;
        if ((this.facilitydomainid == null && other.facilitydomainid != null) || (this.facilitydomainid != null && !this.facilitydomainid.equals(other.facilitydomainid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitydomain[ facilitydomainid=" + facilitydomainid + " ]";
    }
    
}
