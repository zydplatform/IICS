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
@Table(name = "complicationcomponentfeatures", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Complicationcomponentfeatures.findAll", query = "SELECT c FROM Complicationcomponentfeatures c")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByComplicationcomponentfeaturesid", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.complicationcomponentfeaturesid = :complicationcomponentfeaturesid")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByFeaturename", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.featurename = :featurename")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByDescription", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.description = :description")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByCreatedby", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.createdby = :createdby")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByUpdatedby", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.updatedby = :updatedby")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByDatecreated", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.datecreated = :datecreated")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByLastupdate", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.lastupdate = :lastupdate")
    , @NamedQuery(name = "Complicationcomponentfeatures.findByStatus", query = "SELECT c FROM Complicationcomponentfeatures c WHERE c.status = :status")})
public class Complicationcomponentfeatures implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "complicationcomponentfeaturesid", nullable = false)
    private Long complicationcomponentfeaturesid;
    @Size(max = 255)
    @Column(name = "featurename", length = 255)
    private String featurename;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
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

    public Complicationcomponentfeatures() {
    }

    public Complicationcomponentfeatures(Long complicationcomponentfeaturesid) {
        this.complicationcomponentfeaturesid = complicationcomponentfeaturesid;
    }

    public Long getComplicationcomponentfeaturesid() {
        return complicationcomponentfeaturesid;
    }

    public void setComplicationcomponentfeaturesid(Long complicationcomponentfeaturesid) {
        this.complicationcomponentfeaturesid = complicationcomponentfeaturesid;
    }

    public String getFeaturename() {
        return featurename;
    }

    public void setFeaturename(String featurename) {
        this.featurename = featurename;
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
        hash += (complicationcomponentfeaturesid != null ? complicationcomponentfeaturesid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Complicationcomponentfeatures)) {
            return false;
        }
        Complicationcomponentfeatures other = (Complicationcomponentfeatures) object;
        if ((this.complicationcomponentfeaturesid == null && other.complicationcomponentfeaturesid != null) || (this.complicationcomponentfeaturesid != null && !this.complicationcomponentfeaturesid.equals(other.complicationcomponentfeaturesid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Complicationcomponentfeatures[ complicationcomponentfeaturesid=" + complicationcomponentfeaturesid + " ]";
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
    
}
