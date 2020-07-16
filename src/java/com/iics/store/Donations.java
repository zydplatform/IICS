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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "donations", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Donations.findAll", query = "SELECT d FROM Donations d")
    , @NamedQuery(name = "Donations.findByDonationsid", query = "SELECT d FROM Donations d WHERE d.donationsid = :donationsid")
    , @NamedQuery(name = "Donations.findByDonorrefno", query = "SELECT d FROM Donations d WHERE d.donorrefno = :donorrefno")
    , @NamedQuery(name = "Donations.findByReceivedby", query = "SELECT d FROM Donations d WHERE d.receivedby = :receivedby")
    , @NamedQuery(name = "Donations.findByUpdatedby", query = "SELECT d FROM Donations d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Donations.findByDatereceived", query = "SELECT d FROM Donations d WHERE d.datereceived = :datereceived")
    , @NamedQuery(name = "Donations.findByDateupdated", query = "SELECT d FROM Donations d WHERE d.dateupdated = :dateupdated")})
public class Donations implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "donationsid", nullable = false)
    private Integer donationsid;
    @Size(max = 2147483647)
    @Column(name = "donorrefno", length = 2147483647)
    private String donorrefno;
    @Column(name = "receivedby")
    private Long receivedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "datereceived")
    @Temporal(TemporalType.DATE)
    private Date datereceived;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "facilitydonorid")
    private Integer facilitydonorid;
    @OneToMany(mappedBy = "donationsid")
    private List<Donationsitems> donationsitemsList;

    public Donations() {
    }

    public Donations(Integer donationsid) {
        this.donationsid = donationsid;
    }

    public Integer getDonationsid() {
        return donationsid;
    }

    public void setDonationsid(Integer donationsid) {
        this.donationsid = donationsid;
    }

    public String getDonorrefno() {
        return donorrefno;
    }

    public void setDonorrefno(String donorrefno) {
        this.donorrefno = donorrefno;
    }

    public Long getReceivedby() {
        return receivedby;
    }

    public void setReceivedby(Long receivedby) {
        this.receivedby = receivedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDatereceived() {
        return datereceived;
    }

    public void setDatereceived(Date datereceived) {
        this.datereceived = datereceived;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Integer getFacilitydonorid() {
        return facilitydonorid;
    }

    public void setFacilitydonorid(Integer facilitydonorid) {
        this.facilitydonorid = facilitydonorid;
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
        hash += (donationsid != null ? donationsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Donations)) {
            return false;
        }
        Donations other = (Donations) object;
        if ((this.donationsid == null && other.donationsid != null) || (this.donationsid != null && !this.donationsid.equals(other.donationsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Donations[ donationsid=" + donationsid + " ]";
    }
    
}
