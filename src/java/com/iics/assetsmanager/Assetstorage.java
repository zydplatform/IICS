/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "assetstorage", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assetstorage.findAll", query = "SELECT a FROM Assetstorage a")
    , @NamedQuery(name = "Assetstorage.findByAssetstorageid", query = "SELECT a FROM Assetstorage a WHERE a.assetstorageid = :assetstorageid")
    , @NamedQuery(name = "Assetstorage.findByInstorage", query = "SELECT a FROM Assetstorage a WHERE a.instorage = :instorage")
    , @NamedQuery(name = "Assetstorage.findByDateadded", query = "SELECT a FROM Assetstorage a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Assetstorage.findByDateupdated", query = "SELECT a FROM Assetstorage a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Assetstorage.findByAddedby", query = "SELECT a FROM Assetstorage a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Assetstorage.findByUpdatedby", query = "SELECT a FROM Assetstorage a WHERE a.updatedby = :updatedby")})
public class Assetstorage implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "assetstorageid", nullable = false)
    private Integer assetstorageid;
    @Column(name = "instorage")
    private Boolean instorage;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "updatedby")
    private BigInteger updatedby;

    public Assetstorage() {
    }

    public Assetstorage(Integer assetstorageid) {
        this.assetstorageid = assetstorageid;
    }

    public Integer getAssetstorageid() {
        return assetstorageid;
    }

    public void setAssetstorageid(Integer assetstorageid) {
        this.assetstorageid = assetstorageid;
    }

    public Boolean getInstorage() {
        return instorage;
    }

    public void setInstorage(Boolean instorage) {
        this.instorage = instorage;
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

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (assetstorageid != null ? assetstorageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Assetstorage)) {
            return false;
        }
        Assetstorage other = (Assetstorage) object;
        if ((this.assetstorageid == null && other.assetstorageid != null) || (this.assetstorageid != null && !this.assetstorageid.equals(other.assetstorageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.assetsmanager.Assetstorage[ assetstorageid=" + assetstorageid + " ]";
    }
    
}
