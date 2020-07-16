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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "zonebay", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Zonebay.findAll", query = "SELECT z FROM Zonebay z")
    , @NamedQuery(name = "Zonebay.findByZonebayid", query = "SELECT z FROM Zonebay z WHERE z.zonebayid = :zonebayid")
    , @NamedQuery(name = "Zonebay.findByBaylabel", query = "SELECT z FROM Zonebay z WHERE z.baylabel = :baylabel")
    , @NamedQuery(name = "Zonebay.findByCelltransactionlimit", query = "SELECT z FROM Zonebay z WHERE z.celltransactionlimit = :celltransactionlimit")})
public class Zonebay implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "zonebayid", nullable = false)
    private Integer zonebayid;
    @Size(max = 255)
    @Column(name = "baylabel", length = 255)
    private String baylabel;
    @Column(name = "celltransactionlimit")
    private Integer celltransactionlimit;
    @JoinColumn(name = "storagemechanismid", referencedColumnName = "storagemechanismid")
    @ManyToOne
    private Storagemechanism storagemechanismid;
    @JoinColumn(name = "zoneid", referencedColumnName = "zoneid")
    @ManyToOne
    private Zone zoneid;
    @OneToMany(mappedBy = "zonebayid")
    private List<Bayrow> bayrowList;

    public Zonebay() {
    }

    public Zonebay(Integer zonebayid) {
        this.zonebayid = zonebayid;
    }

    public Integer getZonebayid() {
        return zonebayid;
    }

    public void setZonebayid(Integer zonebayid) {
        this.zonebayid = zonebayid;
    }

    public String getBaylabel() {
        return baylabel;
    }

    public void setBaylabel(String baylabel) {
        this.baylabel = baylabel;
    }

    public Integer getCelltransactionlimit() {
        return celltransactionlimit;
    }

    public void setCelltransactionlimit(Integer celltransactionlimit) {
        this.celltransactionlimit = celltransactionlimit;
    }

    public Storagemechanism getStoragemechanismid() {
        return storagemechanismid;
    }

    public void setStoragemechanismid(Storagemechanism storagemechanismid) {
        this.storagemechanismid = storagemechanismid;
    }

    public Zone getZoneid() {
        return zoneid;
    }

    public void setZoneid(Zone zoneid) {
        this.zoneid = zoneid;
    }

    @XmlTransient
    public List<Bayrow> getBayrowList() {
        return bayrowList;
    }

    public void setBayrowList(List<Bayrow> bayrowList) {
        this.bayrowList = bayrowList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (zonebayid != null ? zonebayid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Zonebay)) {
            return false;
        }
        Zonebay other = (Zonebay) object;
        if ((this.zonebayid == null && other.zonebayid != null) || (this.zonebayid != null && !this.zonebayid.equals(other.zonebayid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Zonebay[ zonebayid=" + zonebayid + " ]";
    }
    
}
