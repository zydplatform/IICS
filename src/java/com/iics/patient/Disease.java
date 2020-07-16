/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS-GRACE
 */
@Entity
@Table(name = "disease", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Disease.findAll", query = "SELECT d FROM Disease d")
    , @NamedQuery(name = "Disease.findByDiseaseid", query = "SELECT d FROM Disease d WHERE d.diseaseid = :diseaseid")
    , @NamedQuery(name = "Disease.findByDiseasename", query = "SELECT d FROM Disease d WHERE d.diseasename = :diseasename")
    , @NamedQuery(name = "Disease.findByDescription", query = "SELECT d FROM Disease d WHERE d.description = :description")
    , @NamedQuery(name = "Disease.findByCreatedby", query = "SELECT d FROM Disease d WHERE d.createdby = :createdby")
    , @NamedQuery(name = "Disease.findByUpdatedby", query = "SELECT d FROM Disease d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Disease.findByDatecreated", query = "SELECT d FROM Disease d WHERE d.datecreated = :datecreated")
    , @NamedQuery(name = "Disease.findByLastupdate", query = "SELECT d FROM Disease d WHERE d.lastupdate = :lastupdate")
    , @NamedQuery(name = "Disease.findByStatus", query = "SELECT d FROM Disease d WHERE d.status = :status")})
public class Disease implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "diseaseid", nullable = false)
    private Long diseaseid;
    @Column(name = "diseasename", length = 255)
    private String diseasename;
    @Size(max = 2147483647)
    @Column(name = "description")
    private String description;
    @Column(name = "createdby")
    private Long createdby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "datecreated")
    @Temporal(TemporalType.DATE)
    private Date datecreated;
    @Column(name = "lastupdate")
    @Temporal(TemporalType.DATE)
    private Date lastupdate;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "diseasecategoryid")
    private Long diseasecategoryid;
    @Column(name = "diseasecode")
    private String diseasecode;
    @Column(name = "hasparent")
    private Boolean hasparent;
    @Column(name = "parentid")
    private Long parentid;

    public Boolean getHasparent() {
        return hasparent;
    }

    public void setHasparent(Boolean hasparent) {
        this.hasparent = hasparent;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public Disease() {
    }

    public Disease(Long diseaseid) {
        this.diseaseid = diseaseid;
    }

    public Long getDiseaseid() {
        return diseaseid;
    }

    public void setDiseaseid(Long diseaseid) {
        this.diseaseid = diseaseid;
    }

    public String getDiseasename() {
        return diseasename;
    }

    public void setDiseasename(String diseasename) {
        this.diseasename = diseasename;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public Date getLastupdate() {
        return lastupdate;
    }

    public void setLastupdate(Date lastupdate) {
        this.lastupdate = lastupdate;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (diseaseid != null ? diseaseid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Disease)) {
            return false;
        }
        Disease other = (Disease) object;
        if ((this.diseaseid == null && other.diseaseid != null) || (this.diseaseid != null && !this.diseaseid.equals(other.diseaseid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Disease[ diseaseid=" + diseaseid + " ]";
    }

    public Long getCreatedby() {
        return createdby;
    }

    public void setCreatedby(Long createdby) {
        this.createdby = createdby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Long getDiseasecategoryid() {
        return diseasecategoryid;
    }

    public void setDiseasecategoryid(Long diseasecategoryid) {
        this.diseasecategoryid = diseasecategoryid;
    }

    public String getDiseasecode() {
        return diseasecode;
    }

    public void setDiseasecode(String diseasecode) {
        this.diseasecode = diseasecode;
    }
}
