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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "designation", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Designation.findAll", query = "SELECT d FROM Designation d")
    , @NamedQuery(name = "Designation.findByDesignationid", query = "SELECT d FROM Designation d WHERE d.designationid = :designationid")
    , @NamedQuery(name = "Designation.findByDesignationname", query = "SELECT d FROM Designation d WHERE d.designationname = :designationname")
    , @NamedQuery(name = "Designation.findByShortname", query = "SELECT d FROM Designation d WHERE d.shortname = :shortname")
    , @NamedQuery(name = "Designation.findByStatus", query = "SELECT d FROM Designation d WHERE d.status = :status")
    , @NamedQuery(name = "Designation.findByTransferstatus", query = "SELECT d FROM Designation d WHERE d.transferstatus = :transferstatus")
    , @NamedQuery(name = "Designation.findByUniversaltransferstatus", query = "SELECT d FROM Designation d WHERE d.universaltransferstatus = :universaltransferstatus")
    , @NamedQuery(name = "Designation.findByDescription", query = "SELECT d FROM Designation d WHERE d.description = :description")
    , @NamedQuery(name = "Designation.findByPreviousdesigcategory", query = "SELECT d FROM Designation d WHERE d.previousdesigcategory = :previousdesigcategory")
    , @NamedQuery(name = "Designation.findByDateadded", query = "SELECT d FROM Designation d WHERE d.dateadded = :dateadded")
    , @NamedQuery(name = "Designation.findByDateupdated", query = "SELECT d FROM Designation d WHERE d.dateupdated = :dateupdated")
    , @NamedQuery(name = "Designation.findByAddedby", query = "SELECT d FROM Designation d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Designation.findByUpdatedby", query = "SELECT d FROM Designation d WHERE d.updatedby = :updatedby")})
public class Designation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "designationid", nullable = false)
    private Integer designationid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "designationname", nullable = false, length = 2147483647)
    private String designationname;
    @Size(max = 2147483647)
    @Column(name = "status")
    private Boolean status;
    @Column(name = "shortname", length = 2147483647)
    private String shortname;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "previousdesigcategory", length = 2147483647)
    private Integer previousdesigcategory;
    @OneToMany(mappedBy = "designationid")
    private List<Staff> staffList;
    @Column(name = "designationcategoryid")
    private Integer designationcategoryid;
    @Column(name = "global")
    private Boolean global;
    @Column(name = "transferstatus")
    private String transferstatus;
    @Column(name = "universaltransferstatus")
    private String universaltransferstatus;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "activity")
    private String activity;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid")
    @ManyToOne
    private Facility facilityid;
    @JoinColumn(name = "parentid", referencedColumnName = "designationid")
    @ManyToOne
    private Designation designation;

    public Designation() {
    }

    public Designation(Integer designationid) {
        this.designationid = designationid;
    }

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public String getDesignationname() {
        return designationname;
    }

    public void setDesignationname(String designationname) {
        this.designationname = designationname;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
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

    public Integer getPreviousdesigcategory() {
        return previousdesigcategory;
    }

    public void setPreviousdesigcategory(Integer previousdesigcategory) {
        this.previousdesigcategory = previousdesigcategory;
    }

    public Boolean getGlobal() {
        return global;
    }

    public void setGlobal(Boolean global) {
        this.global = global;
    }

    public String getTransferstatus() {
        return transferstatus;
    }

    public void setTransferstatus(String transferstatus) {
        this.transferstatus = transferstatus;
    }

    public String getUniversaltransferstatus() {
        return universaltransferstatus;
    }

    public void setUniversaltransferstatus(String universaltransferstatus) {
        this.universaltransferstatus = universaltransferstatus;
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

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public Facility getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Facility facilityid) {
        this.facilityid = facilityid;
    }

    public Integer getDesignationcategoryid() {
        return designationcategoryid;
    }

    public void setDesignationcategoryid(Integer designationcategoryid) {
        this.designationcategoryid = designationcategoryid;
    }

    public Designation getDesignation() {
        return designation;
    }

    public void setDesignation(Designation designation) {
        this.designation = designation;
    }

    @XmlTransient
    public List<Staff> getStaffList() {
        return staffList;
    }

    public void setStaffList(List<Staff> staffList) {
        this.staffList = staffList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (designationid != null ? designationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Designation)) {
            return false;
        }
        Designation other = (Designation) object;
        if ((this.designationid == null && other.designationid != null) || (this.designationid != null && !this.designationid.equals(other.designationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Designation[ designationid=" + designationid + " ]";
    }

}
