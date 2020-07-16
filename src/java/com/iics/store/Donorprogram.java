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
@Table(name = "donorprogram", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Donorprogram.findAll", query = "SELECT d FROM Donorprogram d")
    , @NamedQuery(name = "Donorprogram.findByDonorprogramid", query = "SELECT d FROM Donorprogram d WHERE d.donorprogramid = :donorprogramid")
    , @NamedQuery(name = "Donorprogram.findByDonorname", query = "SELECT d FROM Donorprogram d WHERE d.donorname = :donorname")
    , @NamedQuery(name = "Donorprogram.findByTelno", query = "SELECT d FROM Donorprogram d WHERE d.telno = :telno")
    , @NamedQuery(name = "Donorprogram.findByEmial", query = "SELECT d FROM Donorprogram d WHERE d.emial = :emial")
    , @NamedQuery(name = "Donorprogram.findByFax", query = "SELECT d FROM Donorprogram d WHERE d.fax = :fax")
    , @NamedQuery(name = "Donorprogram.findByAddedby", query = "SELECT d FROM Donorprogram d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Donorprogram.findByUpdatedby", query = "SELECT d FROM Donorprogram d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Donorprogram.findByDateadded", query = "SELECT d FROM Donorprogram d WHERE d.dateadded = :dateadded")
    , @NamedQuery(name = "Donorprogram.findByDateupdated", query = "SELECT d FROM Donorprogram d WHERE d.dateupdated = :dateupdated")
    , @NamedQuery(name = "Donorprogram.findByOrigincountry", query = "SELECT d FROM Donorprogram d WHERE d.origincountry = :origincountry")
    , @NamedQuery(name = "Donorprogram.findByDonortype", query = "SELECT d FROM Donorprogram d WHERE d.donortype = :donortype")})
public class Donorprogram implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "donorprogramid", nullable = false)
    private Integer donorprogramid;
    @Size(max = 2147483647)
    @Column(name = "donorname", length = 2147483647)
    private String donorname;
    @Size(max = 2147483647)
    @Column(name = "telno", length = 2147483647)
    private String telno;
    @Size(max = 2147483647)
    @Column(name = "emial", length = 2147483647)
    private String emial;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Size(max = 2147483647)
    @Column(name = "fax", length = 2147483647)
    private String fax;
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
    @Size(max = 2147483647)
    @Column(name = "origincountry", length = 2147483647)
    private String origincountry;
    @Size(max = 2147483647)
    @Column(name = "donortype", length = 2147483647)
    private String donortype;
    @OneToMany(mappedBy = "donorprogramid")
    private List<Facilitydonor> facilitydonorList;

    public Donorprogram() {
    }

    public Donorprogram(Integer donorprogramid) {
        this.donorprogramid = donorprogramid;
    }

    public Integer getDonorprogramid() {
        return donorprogramid;
    }

    public void setDonorprogramid(Integer donorprogramid) {
        this.donorprogramid = donorprogramid;
    }

    public String getDonorname() {
        return donorname;
    }

    public void setDonorname(String donorname) {
        this.donorname = donorname;
    }

    public String getTelno() {
        return telno;
    }

    public void setTelno(String telno) {
        this.telno = telno;
    }

    public String getEmial() {
        return emial;
    }

    public void setEmial(String emial) {
        this.emial = emial;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
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

    public String getOrigincountry() {
        return origincountry;
    }

    public void setOrigincountry(String origincountry) {
        this.origincountry = origincountry;
    }

    public String getDonortype() {
        return donortype;
    }

    public void setDonortype(String donortype) {
        this.donortype = donortype;
    }

    @XmlTransient
    public List<Facilitydonor> getFacilitydonorList() {
        return facilitydonorList;
    }

    public void setFacilitydonorList(List<Facilitydonor> facilitydonorList) {
        this.facilitydonorList = facilitydonorList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (donorprogramid != null ? donorprogramid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Donorprogram)) {
            return false;
        }
        Donorprogram other = (Donorprogram) object;
        if ((this.donorprogramid == null && other.donorprogramid != null) || (this.donorprogramid != null && !this.donorprogramid.equals(other.donorprogramid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Donorprogram[ donorprogramid=" + donorprogramid + " ]";
    }

}
