/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "trailcategory", catalog = "iics_database", schema = "audits")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Trailcategory.findAll", query = "SELECT t FROM Trailcategory t")
    , @NamedQuery(name = "Trailcategory.findByTrailcategoryid", query = "SELECT t FROM Trailcategory t WHERE t.trailcategoryid = :trailcategoryid")
    , @NamedQuery(name = "Trailcategory.findByTrailcategoryname", query = "SELECT t FROM Trailcategory t WHERE t.trailcategoryname = :trailcategoryname")})
public class Trailcategory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "trailcategoryid")
    private Integer trailcategoryid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "trailcategoryname")
    private String trailcategoryname;
    @Column(name = "description")
    private String description;


    public Trailcategory() {
    }

    public Trailcategory(Integer trailcategoryid) {
        this.trailcategoryid = trailcategoryid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Trailcategory(Integer trailcategoryid, String trailcategoryname) {
        this.trailcategoryid = trailcategoryid;
        this.trailcategoryname = trailcategoryname;
    }

    public Integer getTrailcategoryid() {
        return trailcategoryid;
    }

    public void setTrailcategoryid(Integer trailcategoryid) {
        this.trailcategoryid = trailcategoryid;
    }

    public String getTrailcategoryname() {
        return trailcategoryname;
    }

    public void setTrailcategoryname(String trailcategoryname) {
        this.trailcategoryname = trailcategoryname;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (trailcategoryid != null ? trailcategoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Trailcategory)) {
            return false;
        }
        Trailcategory other = (Trailcategory) object;
        if ((this.trailcategoryid == null && other.trailcategoryid != null) || (this.trailcategoryid != null && !this.trailcategoryid.equals(other.trailcategoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Trailcategory[ trailcategoryid=" + trailcategoryid + " ]";
    }
    
}
