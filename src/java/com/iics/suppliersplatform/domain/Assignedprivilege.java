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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "assignedprivilege", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Assignedprivilege.findAll", query = "SELECT a FROM Assignedprivilege a")
    , @NamedQuery(name = "Assignedprivilege.findByAssignedprivid", query = "SELECT a FROM Assignedprivilege a WHERE a.assignedprivid = :assignedprivid")
    , @NamedQuery(name = "Assignedprivilege.findByActive", query = "SELECT a FROM Assignedprivilege a WHERE a.active = :active")
    , @NamedQuery(name = "Assignedprivilege.findByAddedby", query = "SELECT a FROM Assignedprivilege a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Assignedprivilege.findByDateadded", query = "SELECT a FROM Assignedprivilege a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Assignedprivilege.findByUpdatedby", query = "SELECT a FROM Assignedprivilege a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Assignedprivilege.findByDateupdated", query = "SELECT a FROM Assignedprivilege a WHERE a.dateupdated = :dateupdated")})
public class Assignedprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "assignedprivid", nullable = false)
    private Long assignedprivid;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Basic(optional = false)
    @Column(name = "addedby", nullable = false)
    private long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "privilegeid", referencedColumnName = "supplierprivid", nullable = false)
    @ManyToOne(optional = false)
    private Supplierprivilege supplierprivilege;
    @JoinColumn(name = "staffid", referencedColumnName = "staffid", nullable = false)
    @ManyToOne(optional = false)
    private Supplierstaff supplierstaff;

    public Assignedprivilege() {
    }

    public Assignedprivilege(Long assignedprivid) {
        this.assignedprivid = assignedprivid;
    }

    public Assignedprivilege(Long assignedprivid, boolean active, long addedby) {
        this.assignedprivid = assignedprivid;
        this.active = active;
        this.addedby = addedby;
    }

    public Long getAssignedprivid() {
        return assignedprivid;
    }

    public void setAssignedprivid(Long assignedprivid) {
        this.assignedprivid = assignedprivid;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
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

    public Supplierprivilege getSupplierprivilege() {
        return supplierprivilege;
    }

    public void setSupplierprivilege(Supplierprivilege supplierprivilege) {
        this.supplierprivilege = supplierprivilege;
    }

    public Supplierstaff getSupplierstaff() {
        return supplierstaff;
    }

    public void setSupplierstaff(Supplierstaff supplierstaff) {
        this.supplierstaff = supplierstaff;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (assignedprivid != null ? assignedprivid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Assignedprivilege)) {
            return false;
        }
        Assignedprivilege other = (Assignedprivilege) object;
        if ((this.assignedprivid == null && other.assignedprivid != null) || (this.assignedprivid != null && !this.assignedprivid.equals(other.assignedprivid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Assignedprivilege[ assignedprivid=" + assignedprivid + " ]";
    }
    
}
