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
@Table(name = "itemform", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemform.findAll", query = "SELECT i FROM Itemform i")
    , @NamedQuery(name = "Itemform.findByItemformid", query = "SELECT i FROM Itemform i WHERE i.itemformid = :itemformid")
    , @NamedQuery(name = "Itemform.findByFormname", query = "SELECT i FROM Itemform i WHERE i.formname = :formname")
    , @NamedQuery(name = "Itemform.findByFormdescription", query = "SELECT i FROM Itemform i WHERE i.formdescription = :formdescription")})
public class Itemform implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "itemformid", nullable = false)
    private Integer itemformid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "formname", nullable = false, length = 2147483647)
    private String formname;
    @Size(max = 2147483647)
    @Column(name = "formdescription", length = 2147483647)
    private String formdescription;
    @OneToMany(mappedBy = "itemformid")
    private List<Medicalitem> medicalitemList;

    public Itemform() {
    }

    public Itemform(Integer itemformid) {
        this.itemformid = itemformid;
    }

    public Itemform(Integer itemformid, String formname) {
        this.itemformid = itemformid;
        this.formname = formname;
    }

    public Integer getItemformid() {
        return itemformid;
    }

    public void setItemformid(Integer itemformid) {
        this.itemformid = itemformid;
    }

    public String getFormname() {
        return formname;
    }

    public void setFormname(String formname) {
        this.formname = formname;
    }

    public String getFormdescription() {
        return formdescription;
    }

    public void setFormdescription(String formdescription) {
        this.formdescription = formdescription;
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
        hash += (itemformid != null ? itemformid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Itemform)) {
            return false;
        }
        Itemform other = (Itemform) object;
        if ((this.itemformid == null && other.itemformid != null) || (this.itemformid != null && !this.itemformid.equals(other.itemformid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Itemform[ itemformid=" + itemformid + " ]";
    }
    
}
