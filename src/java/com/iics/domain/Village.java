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
@Table(name = "village", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Village.findAll", query = "SELECT v FROM Village v")
    , @NamedQuery(name = "Village.findByVillageid", query = "SELECT v FROM Village v WHERE v.villageid = :villageid")
    , @NamedQuery(name = "Village.findByVillagename", query = "SELECT v FROM Village v WHERE v.villagename = :villagename")})
public class Village implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "villageid", nullable = false)
    private Integer villageid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "villagename", nullable = false, length = 2147483647)
    private String villagename;
    @OneToMany(mappedBy = "villageid")
    private List<Location> locationList;
    @JoinColumn(name = "parishid", referencedColumnName = "parishid", nullable = false)
    @ManyToOne(optional = false)
    private Parish parishid;

    public Village() {
    }

    public Village(Integer villageid) {
        this.villageid = villageid;
    }

    public Village(Integer villageid, String villagename) {
        this.villageid = villageid;
        this.villagename = villagename;
    }

    public Integer getVillageid() {
        return villageid;
    }

    public void setVillageid(Integer villageid) {
        this.villageid = villageid;
    }

    public String getVillagename() {
        return villagename;
    }

    public void setVillagename(String villagename) {
        this.villagename = villagename;
    }
       
    @XmlTransient
    public List<Location> getLocationList() {
        return locationList;
    }

    public void setLocationList(List<Location> locationList) {
        this.locationList = locationList;
    }

    public Parish getParishid() {
        return parishid;
    }

    public void setParishid(Parish parishid) {
        this.parishid = parishid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (villageid != null ? villageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Village)) {
            return false;
        }
        Village other = (Village) object;
        if ((this.villageid == null && other.villageid != null) || (this.villageid != null && !this.villageid.equals(other.villageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Village[ villageid=" + villageid + " ]";
    }
    
}
