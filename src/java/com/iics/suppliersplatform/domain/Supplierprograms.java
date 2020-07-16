/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;



/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "supplierprograms", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Supplierprograms.findAll", query = "SELECT s FROM Supplierprograms s")
    , @NamedQuery(name = "Supplierprograms.findByProgramid", query = "SELECT s FROM Supplierprograms s WHERE s.programid = :programid")
    , @NamedQuery(name = "Supplierprograms.findBySupplierid", query = "SELECT s FROM Supplierprograms s WHERE s.supplierid = :supplierid")
    , @NamedQuery(name = "Supplierprograms.findByName", query = "SELECT s FROM Supplierprograms s WHERE s.name = :name")
    , @NamedQuery(name = "Supplierprograms.findByDescription", query = "SELECT s FROM Supplierprograms s WHERE s.description = :description")
    , @NamedQuery(name = "Supplierprograms.findByAddedby", query = "SELECT s FROM Supplierprograms s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Supplierprograms.findByDateadded", query = "SELECT s FROM Supplierprograms s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Supplierprograms.findByUpdatedby", query = "SELECT s FROM Supplierprograms s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "Supplierprograms.findByDateupdated", query = "SELECT s FROM Supplierprograms s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Supplierprograms.findByActive", query = "SELECT s FROM Supplierprograms s WHERE s.active = :active")
    , @NamedQuery(name = "Supplierprograms.findByDefault1", query = "SELECT s FROM Supplierprograms s WHERE s.default1 = :default1")})
public class Supplierprograms implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "programid", nullable = false)
    private Long programid;
    @Column(name = "supplierid")
    private BigInteger supplierid;
    @Basic(optional = false)
    @Column(name = "name", nullable = false, length = 2147483647)
    private String name;
    @Column(name = "shortname", nullable = false, length = 2147483647)
    private String shortname;
    @Basic(optional = false)
    @Column(name = "description", nullable = false, length = 2147483647)
    private String description;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Basic(optional = false)
    @Column(name = "dateadded", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Basic(optional = false)
    @Column(name = "default", nullable = false)
    private boolean default1;

    public Supplierprograms() {
    }

    public Supplierprograms(Long programid) {
        this.programid = programid;
    }

    public Supplierprograms(Long programid, String name, String description, Date dateadded, boolean active, boolean default1) {
        this.programid = programid;
        this.name = name;
        this.description = description;
        this.dateadded = dateadded;
        this.active = active;
        this.default1 = default1;
    }

    public Long getProgramid() {
        return programid;
    }

    public void setProgramid(Long programid) {
        this.programid = programid;
    }

    public BigInteger getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(BigInteger supplierid) {
        this.supplierid = supplierid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean getDefault1() {
        return default1;
    }

    public void setDefault1(boolean default1) {
        this.default1 = default1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (programid != null ? programid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Supplierprograms)) {
            return false;
        }
        Supplierprograms other = (Supplierprograms) object;
        if ((this.programid == null && other.programid != null) || (this.programid != null && !this.programid.equals(other.programid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Supplierprograms[ programid=" + programid + " ]";
    }
    
}
