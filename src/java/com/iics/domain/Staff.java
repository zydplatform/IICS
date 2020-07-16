/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "staff", catalog = "iics_database", schema = "public", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"personid"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staff.findAll", query = "SELECT s FROM Staff s")
    , @NamedQuery(name = "Staff.findByStaffid", query = "SELECT s FROM Staff s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Staff.findByDatecreated", query = "SELECT s FROM Staff s WHERE s.datecreated = :datecreated")
    , @NamedQuery(name = "Staff.findByStaffno", query = "SELECT s FROM Staff s WHERE s.staffno = :staffno")
    , @NamedQuery(name = "Staff.findByComputerno", query = "SELECT s FROM Staff s WHERE s.computerno = :computerno")
    , @NamedQuery(name = "Staff.findByStaffstate", query = "SELECT s FROM Staff s WHERE s.staffstate = :staffstate")
    , @NamedQuery(name = "Staff.findByAssignedunitsize", query = "SELECT s FROM Staff s WHERE s.assignedunitsize = :assignedunitsize")
    , @NamedQuery(name = "Staff.findByIsexternal", query = "SELECT s FROM Staff s WHERE s.isexternal = :isexternal")
    , @NamedQuery(name = "Staff.findByActivateddate", query = "SELECT s FROM Staff s WHERE s.activateddate = :activateddate")})
public class Staff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "staffid", nullable = false)
    private Long staffid;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Size(max = 2147483647)
    @Column(name = "staffno", length = 2147483647)
    private String staffno;
    @Size(max = 2147483647)
    @Column(name = "computerno", length = 2147483647)
    private String computerno;
    @Basic(optional = false)
    @NotNull
    @Column(name = "staffstate", nullable = false)
    private boolean staffstate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "assignedunitsize", nullable = false)
    private int assignedunitsize;
    @Column(name = "isexternal")
    private Boolean isexternal;
    @Column(name = "activateddate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date activateddate;
    @JoinColumn(name = "designationid", referencedColumnName = "designationid")
    @ManyToOne
    private Designation designationid;
    @JoinColumn(name = "currentfacility", referencedColumnName = "facilityid")
    @ManyToOne
    private Facility currentfacility;
    @JoinColumn(name = "personid", referencedColumnName = "personid", nullable = false)
    @OneToOne(optional = false)
    private Person personid;
    @OneToMany(mappedBy = "createdby")
    private List<Staff> staffList;
    @JoinColumn(name = "createdby", referencedColumnName = "staffid")
    @ManyToOne
    private Staff createdby;
    @JoinColumn(name = "staffpost", referencedColumnName = "systemrolefacilityid")
    @ManyToOne
    private Systemrolefacility staffpost;
    
    public Staff() {
    }

    public Staff(Long staffid) {
        this.staffid = staffid;
    }

    public Staff(Long staffid, boolean staffstate, int assignedunitsize) {
        this.staffid = staffid;
        this.staffstate = staffstate;
        this.assignedunitsize = assignedunitsize;
    }

    public Long getStaffid() {
        return staffid;
    }

    public void setStaffid(Long staffid) {
        this.staffid = staffid;
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

    public Boolean getIsexternal() {
        return isexternal;
    }

    public void setIsexternal(Boolean isexternal) {
        this.isexternal = isexternal;
    }

    public Date getActivateddate() {
        return activateddate;
    }

    public void setActivateddate(Date activateddate) {
        this.activateddate = activateddate;
    }

    public Designation getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Designation designationid) {
        this.designationid = designationid;
    }

    public Facility getCurrentfacility() {
        return currentfacility;
    }

    public void setCurrentfacility(Facility currentfacility) {
        this.currentfacility = currentfacility;
    }

    public Person getPersonid() {
        return personid;
    }

    public void setPersonid(Person personid) {
        this.personid = personid;
    }

    @XmlTransient
    public List<Staff> getStaffList() {
        return staffList;
    }

    public void setStaffList(List<Staff> staffList) {
        this.staffList = staffList;
    }

    public Staff getCreatedby() {
        return createdby;
    }

    public void setCreatedby(Staff createdby) {
        this.createdby = createdby;
    }

    public Systemrolefacility getStaffpost() {
        return staffpost;
    }

    public void setStaffpost(Systemrolefacility staffpost) {
        this.staffpost = staffpost;
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
        if (!(object instanceof Staff)) {
            return false;
        }
        Staff other = (Staff) object;
        if ((this.staffid == null && other.staffid != null) || (this.staffid != null && !this.staffid.equals(other.staffid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Staff[ staffid=" + staffid + " ]";
    }
    
}
