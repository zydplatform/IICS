/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
 * @author IICS
 */
@Entity
@Table(name = "itemadministeringtype", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemadministeringtype.findAll", query = "SELECT i FROM Itemadministeringtype i")
    , @NamedQuery(name = "Itemadministeringtype.findByAdministeringtypeid", query = "SELECT i FROM Itemadministeringtype i WHERE i.administeringtypeid = :administeringtypeid")
    , @NamedQuery(name = "Itemadministeringtype.findByTypename", query = "SELECT i FROM Itemadministeringtype i WHERE i.typename = :typename")})
public class Itemadministeringtype implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "administeringtypeid", nullable = false)
    private Integer administeringtypeid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "typename", nullable = false, length = 2147483647)
    private String typename;
    @OneToMany(mappedBy = "itemadministeringtypeid")
    private List<Medicalitem> medicalitemList;

    public Itemadministeringtype() {
    }

    public Itemadministeringtype(Integer administeringtypeid) {
        this.administeringtypeid = administeringtypeid;
    }

    public Itemadministeringtype(Integer administeringtypeid, String typename) {
        this.administeringtypeid = administeringtypeid;
        this.typename = typename;
    }

    public Integer getAdministeringtypeid() {
        return administeringtypeid;
    }

    public void setAdministeringtypeid(Integer administeringtypeid) {
        this.administeringtypeid = administeringtypeid;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    @XmlTransient
    public List<Medicalitem> getMedicalitemList() {
        return medicalitemList;
    }

    public void setMedicalitemList(List<Medicalitem> medicalitemList) {
        this.medicalitemList = medicalitemList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (administeringtypeid != null ? administeringtypeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Itemadministeringtype)) {
            return false;
        }
        Itemadministeringtype other = (Itemadministeringtype) object;
        if ((this.administeringtypeid == null && other.administeringtypeid != null) || (this.administeringtypeid != null && !this.administeringtypeid.equals(other.administeringtypeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Itemadministeringtype[ administeringtypeid=" + administeringtypeid + " ]";
    }
    
}
