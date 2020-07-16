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
@Table(name = "county", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "County.findAll", query = "SELECT c FROM County c")
    , @NamedQuery(name = "County.findByCountyid", query = "SELECT c FROM County c WHERE c.countyid = :countyid")
    , @NamedQuery(name = "County.findByCountyname", query = "SELECT c FROM County c WHERE c.countyname = :countyname")})
public class County implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "countyid", nullable = false)
    private Integer countyid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "countyname", nullable = false, length = 2147483647)
    private String countyname;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "countyid")
    private List<Subcounty> subcountyList;
    @JoinColumn(name = "districtid", referencedColumnName = "districtid", nullable = false)
    @ManyToOne(optional = false)
    private District districtid;

    public County() {
    }

    public County(Integer countyid) {
        this.countyid = countyid;
    }

    public County(Integer countyid, String countyname) {
        this.countyid = countyid;
        this.countyname = countyname;
    }

    public Integer getCountyid() {
        return countyid;
    }

    public void setCountyid(Integer countyid) {
        this.countyid = countyid;
    }

    public String getCountyname() {
        return countyname;
    }

    public void setCountyname(String countyname) {
        this.countyname = countyname;
    }

    @XmlTransient
    public List<Subcounty> getSubcountyList() {
        return subcountyList;
    }

    public void setSubcountyList(List<Subcounty> subcountyList) {
        this.subcountyList = subcountyList;
    }

    public District getDistrictid() {
        return districtid;
    }

    public void setDistrictid(District districtid) {
        this.districtid = districtid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (countyid != null ? countyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof County)) {
            return false;
        }
        County other = (County) object;
        if ((this.countyid == null && other.countyid != null) || (this.countyid != null && !this.countyid.equals(other.countyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.County[ countyid=" + countyid + " ]";
    }
    
}
