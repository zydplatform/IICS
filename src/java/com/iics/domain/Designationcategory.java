/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "designationcategory", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Designationcategory.findAll", query = "SELECT d FROM Designationcategory d")
    , @NamedQuery(name = "Designationcategory.findByDesignationcategoryid", query = "SELECT d FROM Designationcategory d WHERE d.designationcategoryid = :designationcategoryid")
    , @NamedQuery(name = "Designationcategory.findByCategoryname", query = "SELECT d FROM Designationcategory d WHERE d.categoryname = :categoryname")
    , @NamedQuery(name = "Designationcategory.findByDescription", query = "SELECT d FROM Designationcategory d WHERE d.description = :description")
    , @NamedQuery(name = "Designationcategory.findByRolessize", query = "SELECT d FROM Designationcategory d WHERE d.rolessize = :rolessize")
    , @NamedQuery(name = "Designationcategory.findByDisabled", query = "SELECT d FROM Designationcategory d WHERE d.disabled = :disabled")
    , @NamedQuery(name = "Designationcategory.findByDeletestatus", query = "SELECT d FROM Designationcategory d WHERE d.deletestatus = :deletestatus")
    , @NamedQuery(name = "Designationcategory.findByUniversaldeletestatus", query = "SELECT d FROM Designationcategory d WHERE d.universaldeletestatus = :universaldeletestatus")
    , @NamedQuery(name = "Designationcategory.findByIscustom", query = "SELECT d FROM Designationcategory d WHERE d.iscustom = :iscustom")})
public class Designationcategory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "designationcategoryid", nullable = false)
    private Integer designationcategoryid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "categoryname", nullable = false, length = 2147483647)
    private String categoryname;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "rolessize")
    private Integer rolessize;
    @Column(name = "disabled")
    private Boolean disabled;
    @Column(name = "iscustom")
    private Boolean iscustom;
    @Column(name = "deletestatus")
    private String deletestatus;
    @Column(name = "universaldeletestatus")
    private String universaldeletestatus;
    @OneToMany(mappedBy = "designationcategoryid")
    private List<Systemrole> systemroleList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "designationcategoryid")
    private List<Designation> designationList;
    @Column(name = "facilitydomainid")
    private Integer facilitydomainid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @Column(name = "dateadded")
    private Date dateadded;
    @Column(name = "datelastupdated")
    private Date datelastupdated;

    public Designationcategory() {
    }

    public Designationcategory(Integer designationcategoryid) {
        this.designationcategoryid = designationcategoryid;
    }

    public Designationcategory(Integer designationcategoryid, String categoryname) {
        this.designationcategoryid = designationcategoryid;
        this.categoryname = categoryname;
    }

    public Integer getDesignationcategoryid() {
        return designationcategoryid;
    }

    public void setDesignationcategoryid(Integer designationcategoryid) {
        this.designationcategoryid = designationcategoryid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getRolessize() {
        return rolessize;
    }

    public void setRolessize(Integer rolessize) {
        this.rolessize = rolessize;
    }

    public Boolean getDisabled() {
        return disabled;
    }

    public void setDisabled(Boolean disabled) {
        this.disabled = disabled;
    }

    public Boolean getIscustom() {
        return iscustom;
    }

    public void setIscustom(Boolean iscustom) {
        this.iscustom = iscustom;
    }

    public String getDeletestatus() {
        return deletestatus;
    }

    public void setDeletestatus(String deletestatus) {
        this.deletestatus = deletestatus;
    }

    public String getUniversaldeletestatus() {
        return universaldeletestatus;
    }

    public void setUniversaldeletestatus(String universaldeletestatus) {
        this.universaldeletestatus = universaldeletestatus;
    }

    public List<Systemrole> getSystemroleList() {
        return systemroleList;
    }

    public void setSystemroleList(List<Systemrole> systemroleList) {
        this.systemroleList = systemroleList;
    }

    @XmlTransient
    public List<Designation> getDesignationList() {
        return designationList;
    }

    public void setDesignationList(List<Designation> designationList) {
        this.designationList = designationList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (designationcategoryid != null ? designationcategoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Designationcategory)) {
            return false;
        }
        Designationcategory other = (Designationcategory) object;
        if ((this.designationcategoryid == null && other.designationcategoryid != null) || (this.designationcategoryid != null && !this.designationcategoryid.equals(other.designationcategoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Designationcategory[ designationcategoryid=" + designationcategoryid + " ]";
    }

    public Integer getFacilitydomainid() {
        return facilitydomainid;
    }

    public void setFacilitydomainid(Integer facilitydomainid) {
        this.facilitydomainid = facilitydomainid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public BigInteger getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(BigInteger lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDatelastupdated() {
        return datelastupdated;
    }

    public void setDatelastupdated(Date datelastupdated) {
        this.datelastupdated = datelastupdated;
    }
}
