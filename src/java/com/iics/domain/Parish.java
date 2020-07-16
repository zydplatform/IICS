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
@Table(name = "parish", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Parish.findAll", query = "SELECT p FROM Parish p")
    , @NamedQuery(name = "Parish.findByParishid", query = "SELECT p FROM Parish p WHERE p.parishid = :parishid")
    , @NamedQuery(name = "Parish.findByParishname", query = "SELECT p FROM Parish p WHERE p.parishname = :parishname")})
public class Parish implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "parishid", nullable = false)
    private Integer parishid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "parishname", nullable = false, length = 2147483647)
    private String parishname;
    @JoinColumn(name = "subcountyid", referencedColumnName = "subcountyid", nullable = false)
    @ManyToOne(optional = false)
    private Subcounty subcountyid;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "parishid")
    private List<Village> villageList;

    public Parish() {
    }

    public Parish(Integer parishid) {
        this.parishid = parishid;
    }

    public Parish(Integer parishid, String parishname) {
        this.parishid = parishid;
        this.parishname = parishname;
    }

    public Integer getParishid() {
        return parishid;
    }

    public void setParishid(Integer parishid) {
        this.parishid = parishid;
    }

    public String getParishname() {
        return parishname;
    }

    public void setParishname(String parishname) {
        this.parishname = parishname;
    }

    public Subcounty getSubcountyid() {
        return subcountyid;
    }

    public void setSubcountyid(Subcounty subcountyid) {
        this.subcountyid = subcountyid;
    }

    @XmlTransient
    public List<Village> getVillageList() {
        return villageList;
    }

    public void setVillageList(List<Village> villageList) {
        this.villageList = villageList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (parishid != null ? parishid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Parish)) {
            return false;
        }
        Parish other = (Parish) object;
        if ((this.parishid == null && other.parishid != null) || (this.parishid != null && !this.parishid.equals(other.parishid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Parish[ parishid=" + parishid + " ]";
    }
    
}
