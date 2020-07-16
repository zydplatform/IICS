/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
@Table(name = "supplierstaff", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Supplierstaff.findAll", query = "SELECT s FROM Supplierstaff s")
    , @NamedQuery(name = "Supplierstaff.findByStaffid", query = "SELECT s FROM Supplierstaff s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Supplierstaff.findByPersonid", query = "SELECT s FROM Supplierstaff s WHERE s.personid = :personid")
    , @NamedQuery(name = "Supplierstaff.findByDesignationid", query = "SELECT s FROM Supplierstaff s WHERE s.designationid = :designationid")
    , @NamedQuery(name = "Supplierstaff.findByCreatedby", query = "SELECT s FROM Supplierstaff s WHERE s.createdby = :createdby")
    , @NamedQuery(name = "Supplierstaff.findByDatecreated", query = "SELECT s FROM Supplierstaff s WHERE s.datecreated = :datecreated")
    , @NamedQuery(name = "Supplierstaff.findByStaffno", query = "SELECT s FROM Supplierstaff s WHERE s.staffno = :staffno")
    , @NamedQuery(name = "Supplierstaff.findByComputerno", query = "SELECT s FROM Supplierstaff s WHERE s.computerno = :computerno")
    , @NamedQuery(name = "Supplierstaff.findByStaffstate", query = "SELECT s FROM Supplierstaff s WHERE s.staffstate = :staffstate")
    , @NamedQuery(name = "Supplierstaff.findByAssignedunitsize", query = "SELECT s FROM Supplierstaff s WHERE s.assignedunitsize = :assignedunitsize")
    , @NamedQuery(name = "Supplierstaff.findByCurrentfacility", query = "SELECT s FROM Supplierstaff s WHERE s.currentfacility = :currentfacility")
    , @NamedQuery(name = "Supplierstaff.findByIsexternal", query = "SELECT s FROM Supplierstaff s WHERE s.isexternal = :isexternal")
    , @NamedQuery(name = "Supplierstaff.findByStaffcategory", query = "SELECT s FROM Supplierstaff s WHERE s.staffcategory = :staffcategory")
    , @NamedQuery(name = "Supplierstaff.findByTerminatedstaff", query = "SELECT s FROM Supplierstaff s WHERE s.terminatedstaff = :terminatedstaff")
    , @NamedQuery(name = "Supplierstaff.findByApproved", query = "SELECT s FROM Supplierstaff s WHERE s.approved = :approved")
    , @NamedQuery(name = "Supplierstaff.findByDateapproved", query = "SELECT s FROM Supplierstaff s WHERE s.dateapproved = :dateapproved")
    , @NamedQuery(name = "Supplierstaff.findByDateupdated", query = "SELECT s FROM Supplierstaff s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Supplierstaff.findByUpdatedby", query = "SELECT s FROM Supplierstaff s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "Supplierstaff.findByApprovedby", query = "SELECT s FROM Supplierstaff s WHERE s.approvedby = :approvedby")})
public class Supplierstaff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "staffid", nullable = false)
    private Long staffid;
    @Basic(optional = false)
    @Column(name = "personid", nullable = false)
    private long personid;
    @Column(name = "designationid")
    private Integer designationid;
    @Column(name = "createdby")
    private BigInteger createdby;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Column(name = "staffno", length = 2147483647)
    private String staffno;
    @Column(name = "computerno", length = 2147483647)
    private String computerno;
    @Basic(optional = false)
    @Column(name = "staffstate", nullable = false)
    private boolean staffstate;
    @Basic(optional = false)
    @Column(name = "assignedunitsize", nullable = false)
    private int assignedunitsize;
    @Column(name = "currentfacility")
    private Integer currentfacility;
    @Column(name = "isexternal")
    private Boolean isexternal;
    @Basic(optional = false)
    @Column(name = "staffcategory", nullable = false, length = 2147483647)
    private String staffcategory;
    @Basic(optional = false)
    @Column(name = "terminatedstaff", nullable = false)
    private boolean terminatedstaff;
    @Basic(optional = false)
    @Column(name = "approved", nullable = false)
    private boolean approved;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateapproved;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "supplierstaff")
    private List<Assignedprivilege> assignedprivilegeList;

    public Supplierstaff() {
    }

    public Supplierstaff(Long staffid) {
        this.staffid = staffid;
    }

    public Supplierstaff(Long staffid, long personid, boolean staffstate, int assignedunitsize, String staffcategory, boolean terminatedstaff, boolean approved) {
        this.staffid = staffid;
        this.personid = personid;
        this.staffstate = staffstate;
        this.assignedunitsize = assignedunitsize;
        this.staffcategory = staffcategory;
        this.terminatedstaff = terminatedstaff;
        this.approved = approved;
    }

    public Long getStaffid() {
        return staffid;
    }

    public void setStaffid(Long staffid) {
        this.staffid = staffid;
    }

    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public BigInteger getCreatedby() {
        return createdby;
    }

    public void setCreatedby(BigInteger createdby) {
        this.createdby = createdby;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public String getStaffno() {
        return staffno;
    }

    public void setStaffno(String staffno) {
        this.staffno = staffno;
    }

    public String getComputerno() {
        return computerno;
    }

    public void setComputerno(String computerno) {
        this.computerno = computerno;
    }

    public boolean getStaffstate() {
        return staffstate;
    }

    public void setStaffstate(boolean staffstate) {
        this.staffstate = staffstate;
    }

    public int getAssignedunitsize() {
        return assignedunitsize;
    }

    public void setAssignedunitsize(int assignedunitsize) {
        this.assignedunitsize = assignedunitsize;
    }

    public Integer getCurrentfacility() {
        return currentfacility;
    }

    public void setCurrentfacility(Integer currentfacility) {
        this.currentfacility = currentfacility;
    }

    public Boolean getIsexternal() {
        return isexternal;
    }

    public void setIsexternal(Boolean isexternal) {
        this.isexternal = isexternal;
    }

    public String getStaffcategory() {
        return staffcategory;
    }

    public void setStaffcategory(String staffcategory) {
        this.staffcategory = staffcategory;
    }

    public boolean getTerminatedstaff() {
        return terminatedstaff;
    }

    public void setTerminatedstaff(boolean terminatedstaff) {
        this.terminatedstaff = terminatedstaff;
    }

    public boolean getApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
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
        hash += (staffid != null ? staffid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Supplierstaff)) {
            return false;
        }
        Supplierstaff other = (Supplierstaff) object;
        if ((this.staffid == null && other.staffid != null) || (this.staffid != null && !this.staffid.equals(other.staffid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Supplierstaff[ staffid=" + staffid + " ]";
    }
    
}
