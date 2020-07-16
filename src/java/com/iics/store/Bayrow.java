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
@Table(name = "bayrow", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Bayrow.findAll", query = "SELECT b FROM Bayrow b")
    , @NamedQuery(name = "Bayrow.findByBayrowid", query = "SELECT b FROM Bayrow b WHERE b.bayrowid = :bayrowid")
    , @NamedQuery(name = "Bayrow.findByRowlabel", query = "SELECT b FROM Bayrow b WHERE b.rowlabel = :rowlabel")})
public class Bayrow implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "bayrowid", nullable = false)
    private Integer bayrowid;
    @Size(max = 255)
    @Column(name = "rowlabel", length = 255)
    private String rowlabel;
    @OneToMany(mappedBy = "bayrowid")
    private List<Bayrowcell> bayrowcellList;
    @JoinColumn(name = "zonebayid", referencedColumnName = "zonebayid")
    @ManyToOne
    private Zonebay zonebayid;

    public Bayrow() {
    }

    public Bayrow(Integer bayrowid) {
        this.bayrowid = bayrowid;
    }

    public Integer getBayrowid() {
        return bayrowid;
    }

    public void setBayrowid(Integer bayrowid) {
        this.bayrowid = bayrowid;
    }

    public String getRowlabel() {
        return rowlabel;
    }

    public void setRowlabel(String rowlabel) {
        this.rowlabel = rowlabel;
    }

    @XmlTransient
    public List<Bayrowcell> getBayrowcellList() {
        return bayrowcellList;
    }

    public void setBayrowcellList(List<Bayrowcell> bayrowcellList) {
        this.bayrowcellList = bayrowcellList;
    }

    public Zonebay getZonebayid() {
        return zonebayid;
    }

    public void setZonebayid(Zonebay zonebayid) {
        this.zonebayid = zonebayid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (bayrowid != null ? bayrowid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Bayrow)) {
            return false;
        }
        Bayrow other = (Bayrow) object;
        if ((this.bayrowid == null && other.bayrowid != null) || (this.bayrowid != null && !this.bayrowid.equals(other.bayrowid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Bayrow[ bayrowid=" + bayrowid + " ]";
    }
    
}
