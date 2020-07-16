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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER 1
 */
@Entity
@Table(name = "dutiesandresponsibilities", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Dutiesandresponsibilities.findAll", query = "SELECT d FROM Dutiesandresponsibilities d")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByDutyid", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.dutyid = :dutyid")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByDuty", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.duty = :duty")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByAddedby", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByDatecreated", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.datecreated = :datecreated")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByUpdatedby", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByDateupdated", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.dateupdated = :dateupdated")
    , @NamedQuery(name = "Dutiesandresponsibilities.findByDesignationid", query = "SELECT d FROM Dutiesandresponsibilities d WHERE d.designationid = :designationid")})
public class Dutiesandresponsibilities implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "dutyid")
    private Integer dutyid;
    @Size(max = 2147483647)
    @Column(name = "duty")
    private String duty;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "datecreated")
    @Temporal(TemporalType.DATE)
    private Date datecreated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "designationid")
    private Integer designationid;

    public Dutiesandresponsibilities() {
    }

    public Dutiesandresponsibilities(Integer dutyid) {
        this.dutyid = dutyid;
    }

    public Integer getDutyid() {
        return dutyid;
    }

    public void setDutyid(Integer dutyid) {
        this.dutyid = dutyid;
    }

    public String getDuty() {
        return duty;
    }

    public void setDuty(String duty) {
        this.duty = duty;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
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

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (dutyid != null ? dutyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Dutiesandresponsibilities)) {
            return false;
        }
        Dutiesandresponsibilities other = (Dutiesandresponsibilities) object;
        if ((this.dutyid == null && other.dutyid != null) || (this.dutyid != null && !this.dutyid.equals(other.dutyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Dutiesandresponsibilities[ dutyid=" + dutyid + " ]";
    }
    
}
