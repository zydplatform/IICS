/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER 1
 */
@Entity
@Table(name = "facilitylevelconfigrations", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitylevelconfigrations.findAll", query = "SELECT f FROM Facilitylevelconfigrations f")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByFacilitylevelconfigrationid", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.facilitylevelconfigrationid = :facilitylevelconfigrationid")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByRequiredstaff", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.requiredstaff = :requiredstaff")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByDatecreated", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.datecreated = :datecreated")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByDateupdated", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.dateupdated = :dateupdated")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByUpdatedby", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByDesignationid", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.designationid = :designationid")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByFacilitylevelid", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.facilitylevelid = :facilitylevelid")
    , @NamedQuery(name = "Facilitylevelconfigrations.findByAddedby", query = "SELECT f FROM Facilitylevelconfigrations f WHERE f.addedby = :addedby")})
public class Facilitylevelconfigrations implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilitylevelconfigrationid")
    private Integer facilitylevelconfigrationid;
    @Column(name = "requiredstaff")
    private Integer requiredstaff;
    @Column(name = "datecreated")
    @Temporal(TemporalType.DATE)
    private Date datecreated;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "designationid")
    private Integer designationid;
    @Column(name = "facilitylevelid")
    private Integer facilitylevelid;
    @Column(name = "addedby")
    private BigInteger addedby;

    public Facilitylevelconfigrations() {
    }

    public Facilitylevelconfigrations(Integer facilitylevelconfigrationid) {
        this.facilitylevelconfigrationid = facilitylevelconfigrationid;
    }

    public Integer getFacilitylevelconfigrationid() {
        return facilitylevelconfigrationid;
    }

    public void setFacilitylevelconfigrationid(Integer facilitylevelconfigrationid) {
        this.facilitylevelconfigrationid = facilitylevelconfigrationid;
    }

    public Integer getRequiredstaff() {
        return requiredstaff;
    }

    public void setRequiredstaff(Integer requiredstaff) {
        this.requiredstaff = requiredstaff;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
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

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public Integer getFacilitylevelid() {
        return facilitylevelid;
    }

    public void setFacilitylevelid(Integer facilitylevelid) {
        this.facilitylevelid = facilitylevelid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilitylevelconfigrationid != null ? facilitylevelconfigrationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitylevelconfigrations)) {
            return false;
        }
        Facilitylevelconfigrations other = (Facilitylevelconfigrations) object;
        if ((this.facilitylevelconfigrationid == null && other.facilitylevelconfigrationid != null) || (this.facilitylevelconfigrationid != null && !this.facilitylevelconfigrationid.equals(other.facilitylevelconfigrationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitylevelconfigrations[ facilitylevelconfigrationid=" + facilitylevelconfigrationid + " ]";
    }
    
}
