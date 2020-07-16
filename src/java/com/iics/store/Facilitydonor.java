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
@Table(name = "facilitydonor", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitydonor.findAll", query = "SELECT f FROM Facilitydonor f")
    , @NamedQuery(name = "Facilitydonor.findByFacilitydonorid", query = "SELECT f FROM Facilitydonor f WHERE f.facilitydonorid = :facilitydonorid")
    , @NamedQuery(name = "Facilitydonor.findByFacilityid", query = "SELECT f FROM Facilitydonor f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitydonor.findByPrimarycontact", query = "SELECT f FROM Facilitydonor f WHERE f.primarycontact = :primarycontact")
    , @NamedQuery(name = "Facilitydonor.findBySecondarycontact", query = "SELECT f FROM Facilitydonor f WHERE f.secondarycontact = :secondarycontact")
    , @NamedQuery(name = "Facilitydonor.findByEmail", query = "SELECT f FROM Facilitydonor f WHERE f.email = :email")
    , @NamedQuery(name = "Facilitydonor.findByAddedby", query = "SELECT f FROM Facilitydonor f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilitydonor.findByUpdatedby", query = "SELECT f FROM Facilitydonor f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilitydonor.findByDateadded", query = "SELECT f FROM Facilitydonor f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitydonor.findByDateupdated", query = "SELECT f FROM Facilitydonor f WHERE f.dateupdated = :dateupdated")})
public class Facilitydonor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilitydonorid", nullable = false)
    private Integer facilitydonorid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "primarycontact", length = 2147483647)
    private String primarycontact;
    @Size(max = 2147483647)
    @Column(name = "email", length = 2147483647)
    private String email;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Size(max = 2147483647)
    @Column(name = "secondarycontact", length = 2147483647)
    private String secondarycontact;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "donorprogramid")
    private Integer donorprogramid;
    @Column(name = "contactperson")
    private Long contactperson;
    @OneToMany(mappedBy = "facilitydonorid")
    private List<Donations> donationsList;

    public Facilitydonor() {
    }

    public Facilitydonor(Integer facilitydonorid) {
        this.facilitydonorid = facilitydonorid;
    }

    public Integer getFacilitydonorid() {
        return facilitydonorid;
    }

    public void setFacilitydonorid(Integer facilitydonorid) {
        this.facilitydonorid = facilitydonorid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public String getPrimarycontact() {
        return primarycontact;
    }

    public void setPrimarycontact(String primarycontact) {
        this.primarycontact = primarycontact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSecondarycontact() {
        return secondarycontact;
    }

    public void setSecondarycontact(String secondarycontact) {
        this.secondarycontact = secondarycontact;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
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

    public Integer getDonorprogramid() {
        return donorprogramid;
    }

    public void setDonorprogramid(Integer donorprogramid) {
        this.donorprogramid = donorprogramid;
    }

    public Long getContactperson() {
        return contactperson;
    }

    public void setContactperson(Long contactperson) {
        this.contactperson = contactperson;
    }

    @XmlTransient
    public List<Donations> getDonationsList() {
        return donationsList;
    }

    public void setDonationsList(List<Donations> donationsList) {
        this.donationsList = donationsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilitydonorid != null ? facilitydonorid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitydonor)) {
            return false;
        }
        Facilitydonor other = (Facilitydonor) object;
        if ((this.facilitydonorid == null && other.facilitydonorid != null) || (this.facilitydonorid != null && !this.facilitydonorid.equals(other.facilitydonorid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilitydonor[ facilitydonorid=" + facilitydonorid + " ]";
    }

}
