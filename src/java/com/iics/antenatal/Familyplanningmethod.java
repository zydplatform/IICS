/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "familyplanningmethod", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Familyplanningmethod.findAll", query = "SELECT f FROM Familyplanningmethod f")
    , @NamedQuery(name = "Familyplanningmethod.findByFamilyplanningmethodid", query = "SELECT f FROM Familyplanningmethod f WHERE f.familyplanningmethodid = :familyplanningmethodid")
    , @NamedQuery(name = "Familyplanningmethod.findByMethodname", query = "SELECT f FROM Familyplanningmethod f WHERE f.methodname = :methodname")
    , @NamedQuery(name = "Familyplanningmethod.findByDescription", query = "SELECT f FROM Familyplanningmethod f WHERE f.description = :description")})
public class Familyplanningmethod implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "FamilyplanningmethodSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "FamilyplanningmethodSeq", sequenceName = "Familyplanningmethod_familyplanningmethodid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "familyplanningmethodid", nullable = false)
    private Integer familyplanningmethodid;
    @Column(name = "methodname", length = 2147483647)
    private String methodname;
    @Column(name = "description", length = 2147483647)
    private String description;

    public Familyplanningmethod() {
    }

    public Familyplanningmethod(Integer familyplanningmethodid) {
        this.familyplanningmethodid = familyplanningmethodid;
    }

    public Integer getFamilyplanningmethodid() {
        return familyplanningmethodid;
    }

    public void setFamilyplanningmethodid(Integer familyplanningmethodid) {
        this.familyplanningmethodid = familyplanningmethodid;
    }

    public String getMethodname() {
        return methodname;
    }

    public void setMethodname(String methodname) {
        this.methodname = methodname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (familyplanningmethodid != null ? familyplanningmethodid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Familyplanningmethod)) {
            return false;
        }
        Familyplanningmethod other = (Familyplanningmethod) object;
        if ((this.familyplanningmethodid == null && other.familyplanningmethodid != null) || (this.familyplanningmethodid != null && !this.familyplanningmethodid.equals(other.familyplanningmethodid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Familyplanningmethod[ familyplanningmethodid=" + familyplanningmethodid + " ]";
    }
    
}
