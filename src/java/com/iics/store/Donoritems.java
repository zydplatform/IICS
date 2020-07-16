/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "donoritems", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Donoritems.findAll", query = "SELECT d FROM Donoritems d")
    , @NamedQuery(name = "Donoritems.findByDonoritemsid", query = "SELECT d FROM Donoritems d WHERE d.donoritemsid = :donoritemsid")
    , @NamedQuery(name = "Donoritems.findByDonoritemname", query = "SELECT d FROM Donoritems d WHERE d.donoritemname = :donoritemname")
    , @NamedQuery(name = "Donoritems.findByAddedby", query = "SELECT d FROM Donoritems d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Donoritems.findByUpdatedby", query = "SELECT d FROM Donoritems d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Donoritems.findByDateadded", query = "SELECT d FROM Donoritems d WHERE d.dateadded = :dateadded")
    , @NamedQuery(name = "Donoritems.findByDateupdated", query = "SELECT d FROM Donoritems d WHERE d.dateupdated = :dateupdated")})
public class Donoritems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "donoritemsid", nullable = false)
    private Integer donoritemsid;
    @Size(max = 2147483647)
    @Column(name = "donoritemname", length = 2147483647)
    private String donoritemname;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @OneToMany(mappedBy = "otheritemsid")
    private List<Donationsitems> donationsitemsList;

    public Donoritems() {
    }

    public Donoritems(Integer donoritemsid) {
        this.donoritemsid = donoritemsid;
    }

    public Integer getDonoritemsid() {
        return donoritemsid;
    }

    public void setDonoritemsid(Integer donoritemsid) {
        this.donoritemsid = donoritemsid;
    }

    public String getDonoritemname() {
        return donoritemname;
    }

    public void setDonoritemname(String donoritemname) {
        this.donoritemname = donoritemname;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    @XmlTransient
    public List<Donationsitems> getDonationsitemsList() {
        return donationsitemsList;
    }

    public void setDonationsitemsList(List<Donationsitems> donationsitemsList) {
        this.donationsitemsList = donationsitemsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (donoritemsid != null ? donoritemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Donoritems)) {
            return false;
        }
        Donoritems other = (Donoritems) object;
        if ((this.donoritemsid == null && other.donoritemsid != null) || (this.donoritemsid != null && !this.donoritemsid.equals(other.donoritemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Donoritems[ donoritemsid=" + donoritemsid + " ]";
    }

}
