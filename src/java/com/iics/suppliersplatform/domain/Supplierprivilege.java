/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.domain;

import com.iics.controlpanel.Privilege;
import com.iics.store.Supplier;
import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "supplierprivilege", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Supplierprivilege.findAll", query = "SELECT s FROM Supplierprivilege s")
    , @NamedQuery(name = "Supplierprivilege.findBySupplierprivid", query = "SELECT s FROM Supplierprivilege s WHERE s.supplierprivid = :supplierprivid")
    , @NamedQuery(name = "Supplierprivilege.findByActive", query = "SELECT s FROM Supplierprivilege s WHERE s.active = :active")
    , @NamedQuery(name = "Supplierprivilege.findByAddedby", query = "SELECT s FROM Supplierprivilege s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Supplierprivilege.findByDateadded", query = "SELECT s FROM Supplierprivilege s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Supplierprivilege.findByUpdatedby", query = "SELECT s FROM Supplierprivilege s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "Supplierprivilege.findByDateupdated", query = "SELECT s FROM Supplierprivilege s WHERE s.dateupdated = :dateupdated")})
public class Supplierprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "supplierprivid", nullable = false)
    private Long supplierprivid;
    @Basic(optional = false)
    @JoinColumn(name = "privilegeid", referencedColumnName = "privilegeid", nullable = false)
    @ManyToOne(optional = false)
    private Privilege privilege;
    @JoinColumn(name = "supplierid", referencedColumnName = "supplierid", nullable = false)
    @ManyToOne(optional = false)
    private Supplier supplier;
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
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "supplierprivilege")
    private List<Assignedprivilege> assignedprivilegeList;

    public Supplierprivilege() {
    }

    public Supplierprivilege(Long supplierprivid) {
        this.supplierprivid = supplierprivid;
    }

    public Supplierprivilege(Long supplierprivid, long supplierid, int privilegeid, boolean active, long addedby) {
        this.supplierprivid = supplierprivid;
        this.active = active;
        this.addedby = addedby;
    }

    public Long getSupplierprivid() {
        return supplierprivid;
    }

    public void setSupplierprivid(Long supplierprivid) {
        this.supplierprivid = supplierprivid;
    }

    public Privilege getPrivilege() {
        return privilege;
    }

    public void setPrivilege(Privilege privilege) {
        this.privilege = privilege;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
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

    public List<Assignedprivilege> getAssignedprivilegeList() {
        return assignedprivilegeList;
    }

    public void setAssignedprivilegeList(List<Assignedprivilege> assignedprivilegeList) {
        this.assignedprivilegeList = assignedprivilegeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (supplierprivid != null ? supplierprivid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Supplierprivilege)) {
            return false;
        }
        Supplierprivilege other = (Supplierprivilege) object;
        if ((this.supplierprivid == null && other.supplierprivid != null) || (this.supplierprivid != null && !this.supplierprivid.equals(other.supplierprivid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Supplierprivilege[ supplierprivid=" + supplierprivid + " ]";
    }
    
}
