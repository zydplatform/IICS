/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
 * @author RESEARCH
 */
@Entity
@Table(name = "consolidatedorders", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Consolidatedorders.findAll", query = "SELECT c FROM Consolidatedorders c")
    , @NamedQuery(name = "Consolidatedorders.findByConsolidatedordersid", query = "SELECT c FROM Consolidatedorders c WHERE c.consolidatedordersid = :consolidatedordersid")
    , @NamedQuery(name = "Consolidatedorders.findByConsolidatedby", query = "SELECT c FROM Consolidatedorders c WHERE c.consolidatedby = :consolidatedby")
    , @NamedQuery(name = "Consolidatedorders.findByTransferred", query = "SELECT c FROM Consolidatedorders c WHERE c.transferred = :transferred")
    , @NamedQuery(name = "Consolidatedorders.findByDateconsolidated", query = "SELECT c FROM Consolidatedorders c WHERE c.dateconsolidated = :dateconsolidated")
    , @NamedQuery(name = "Consolidatedorders.findByFacilityid", query = "SELECT c FROM Consolidatedorders c WHERE c.facilityid = :facilityid")
    , @NamedQuery(name = "Consolidatedorders.findByConsolidationstatus", query = "SELECT c FROM Consolidatedorders c WHERE c.consolidationstatus = :consolidationstatus")
    , @NamedQuery(name = "Consolidatedorders.findByFacilityorderid", query = "SELECT c FROM Consolidatedorders c WHERE c.facilityorderid = :facilityorderid")})
public class Consolidatedorders implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "consolidatedordersid", nullable = false)
    private Integer consolidatedordersid;
    @Column(name = "consolidatedby")
    private Long consolidatedby;
    @Size(max = 2147483647)
    @Column(name = "transferred", length = 2147483647)
    private String transferred;
    @Column(name = "dateconsolidated")
    @Temporal(TemporalType.DATE)
    private Date dateconsolidated;
    @Column(name = "consolidationstatus")
    private Boolean consolidationstatus;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "facilityorderid")
    private Long facilityorderid;

    public Consolidatedorders() {
    }

    public Consolidatedorders(Integer consolidatedordersid) {
        this.consolidatedordersid = consolidatedordersid;
    }

    public Integer getConsolidatedordersid() {
        return consolidatedordersid;
    }

    public void setConsolidatedordersid(Integer consolidatedordersid) {
        this.consolidatedordersid = consolidatedordersid;
    }

    public Long getConsolidatedby() {
        return consolidatedby;
    }

    public void setConsolidatedby(Long consolidatedby) {
        this.consolidatedby = consolidatedby;
    }

    public String getTransferred() {
        return transferred;
    }

    public void setTransferred(String transferred) {
        this.transferred = transferred;
    }

    public Date getDateconsolidated() {
        return dateconsolidated;
    }

    public void setDateconsolidated(Date dateconsolidated) {
        this.dateconsolidated = dateconsolidated;
    }

    public Boolean getConsolidationstatus() {
        return consolidationstatus;
    }

    public void setConsolidationstatus(Boolean consolidationstatus) {
        this.consolidationstatus = consolidationstatus;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Long getFacilityorderid() {
        return facilityorderid;
    }

    public void setFacilityorderid(Long facilityorderid) {
        this.facilityorderid = facilityorderid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (consolidatedordersid != null ? consolidatedordersid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Consolidatedorders)) {
            return false;
        }
        Consolidatedorders other = (Consolidatedorders) object;
        if ((this.consolidatedordersid == null && other.consolidatedordersid != null) || (this.consolidatedordersid != null && !this.consolidatedordersid.equals(other.consolidatedordersid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Consolidatedorders[ consolidatedordersid=" + consolidatedordersid + " ]";
    }

}
