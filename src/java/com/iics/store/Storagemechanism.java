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
@Table(name = "storagemechanism", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Storagemechanism.findAll", query = "SELECT s FROM Storagemechanism s")
    , @NamedQuery(name = "Storagemechanism.findByStoragemechanismid", query = "SELECT s FROM Storagemechanism s WHERE s.storagemechanismid = :storagemechanismid")
    , @NamedQuery(name = "Storagemechanism.findByStoragemechanismname", query = "SELECT s FROM Storagemechanism s WHERE s.storagemechanismname = :storagemechanismname")})
public class Storagemechanism implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "storagemechanismid", nullable = false)
    private Long storagemechanismid;
    @Size(max = 30)
    @Column(name = "storagemechanismname", length = 30)
    private String storagemechanismname;
    @OneToMany(mappedBy = "storagemechanismid")
    private List<Zonebay> zonebayList;

    public Storagemechanism() {
    }

    public Storagemechanism(Long storagemechanismid) {
        this.storagemechanismid = storagemechanismid;
    }

    public Long getStoragemechanismid() {
        return storagemechanismid;
    }

    public void setStoragemechanismid(Long storagemechanismid) {
        this.storagemechanismid = storagemechanismid;
    }

    public String getStoragemechanismname() {
        return storagemechanismname;
    }

    public void setStoragemechanismname(String storagemechanismname) {
        this.storagemechanismname = storagemechanismname;
    }

    @XmlTransient
    public List<Zonebay> getZonebayList() {
        return zonebayList;
    }

    public void setZonebayList(List<Zonebay> zonebayList) {
        this.zonebayList = zonebayList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (storagemechanismid != null ? storagemechanismid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Storagemechanism)) {
            return false;
        }
        Storagemechanism other = (Storagemechanism) object;
        if ((this.storagemechanismid == null && other.storagemechanismid != null) || (this.storagemechanismid != null && !this.storagemechanismid.equals(other.storagemechanismid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Storagemechanism[ storagemechanismid=" + storagemechanismid + " ]";
    }
    
}
