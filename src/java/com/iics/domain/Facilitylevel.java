/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "facilitylevel", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitylevel.findAll", query = "SELECT f FROM Facilitylevel f")
    , @NamedQuery(name = "Facilitylevel.findByFacilitylevelid", query = "SELECT f FROM Facilitylevel f WHERE f.facilitylevelid = :facilitylevelid")
    , @NamedQuery(name = "Facilitylevel.findByShortname", query = "SELECT f FROM Facilitylevel f WHERE f.shortname = :shortname")
    , @NamedQuery(name = "Facilitylevel.findByDescription", query = "SELECT f FROM Facilitylevel f WHERE f.description = :description")
    , @NamedQuery(name = "Facilitylevel.findByFacilitylevelname", query = "SELECT f FROM Facilitylevel f WHERE f.facilitylevelname = :facilitylevelname")})
public class Facilitylevel implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilitylevelid", nullable = false)
    private Integer facilitylevelid;
    @Size(max = 2147483647)
    @Column(name = "shortname", length = 2147483647)
    private String shortname;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "facilitylevelname", nullable = false, length = 2147483647)
    private String facilitylevelname;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilitylevelid")
    private List<Facility> facilityList;
    @Column(name = "facilitydomain")
    private Integer facilitydomain;
    @Column(name = "count")
    private Integer count;

    public Facilitylevel() {
    }

    public Facilitylevel(Integer facilitylevelid) {
        this.facilitylevelid = facilitylevelid;
    }

    public Facilitylevel(Integer facilitylevelid, String facilitylevelname) {
        this.facilitylevelid = facilitylevelid;
        this.facilitylevelname = facilitylevelname;
    }

    public Integer getFacilitylevelid() {
        return facilitylevelid;
    }

    public void setFacilitylevelid(Integer facilitylevelid) {
        this.facilitylevelid = facilitylevelid;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFacilitylevelname() {
        return facilitylevelname;
    }

    public void setFacilitylevelname(String facilitylevelname) {
        this.facilitylevelname = facilitylevelname;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
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
        hash += (facilitylevelid != null ? facilitylevelid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitylevel)) {
            return false;
        }
        Facilitylevel other = (Facilitylevel) object;
        if ((this.facilitylevelid == null && other.facilitylevelid != null) || (this.facilitylevelid != null && !this.facilitylevelid.equals(other.facilitylevelid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitylevel[ facilitylevelid=" + facilitylevelid + " ]";
    }

    public Integer getFacilitydomain() {
        return facilitydomain;
    }

    public void setFacilitydomain(Integer facilitydomain) {
        this.facilitydomain = facilitydomain;
    }
    
}
