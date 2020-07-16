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
@Table(name = "subcounty", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Subcounty.findAll", query = "SELECT s FROM Subcounty s")
    , @NamedQuery(name = "Subcounty.findBySubcountyid", query = "SELECT s FROM Subcounty s WHERE s.subcountyid = :subcountyid")
    , @NamedQuery(name = "Subcounty.findBySubcountyname", query = "SELECT s FROM Subcounty s WHERE s.subcountyname = :subcountyname")})
public class Subcounty implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "subcountyid", nullable = false)
    private Integer subcountyid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "subcountyname", nullable = false, length = 2147483647)
    private String subcountyname;
    @JoinColumn(name = "countyid", referencedColumnName = "countyid", nullable = false)
    @ManyToOne(optional = false)
    private County countyid;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "subcountyid")
    private List<Parish> parishList;

    public Subcounty() {
    }

    public Subcounty(Integer subcountyid) {
        this.subcountyid = subcountyid;
    }

    public Subcounty(Integer subcountyid, String subcountyname) {
        this.subcountyid = subcountyid;
        this.subcountyname = subcountyname;
    }

    public Integer getSubcountyid() {
        return subcountyid;
    }

    public void setSubcountyid(Integer subcountyid) {
        this.subcountyid = subcountyid;
    }

    public String getSubcountyname() {
        return subcountyname;
    }

    public void setSubcountyname(String subcountyname) {
        this.subcountyname = subcountyname;
    }

    public County getCountyid() {
        return countyid;
    }

    public void setCountyid(County countyid) {
        this.countyid = countyid;
    }

    @XmlTransient
    public List<Parish> getParishList() {
        return parishList;
    }

    public void setParishList(List<Parish> parishList) {
        this.parishList = parishList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (subcountyid != null ? subcountyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Subcounty)) {
            return false;
        }
        Subcounty other = (Subcounty) object;
        if ((this.subcountyid == null && other.subcountyid != null) || (this.subcountyid != null && !this.subcountyid.equals(other.subcountyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Subcounty[ subcountyid=" + subcountyid + " ]";
    }
    
}
