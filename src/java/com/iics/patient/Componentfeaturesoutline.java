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
@Table(name = "componentfeaturesoutline", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Componentfeaturesoutline.findAll", query = "SELECT c FROM Componentfeaturesoutline c")
    , @NamedQuery(name = "Componentfeaturesoutline.findByComponentfeaturesoutlineid", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.componentfeaturesoutlineid = :componentfeaturesoutlineid")
    , @NamedQuery(name = "Componentfeaturesoutline.findByFeaturesoutdescription", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.featuresoutdescription = :featuresoutdescription")
    , @NamedQuery(name = "Componentfeaturesoutline.findByCreatedby", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.createdby = :createdby")
    , @NamedQuery(name = "Componentfeaturesoutline.findByUpdatedby", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.updatedby = :updatedby")
    , @NamedQuery(name = "Componentfeaturesoutline.findByDatecreated", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.datecreated = :datecreated")
    , @NamedQuery(name = "Componentfeaturesoutline.findByLastupdate", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.lastupdate = :lastupdate")
    , @NamedQuery(name = "Componentfeaturesoutline.findByStatus", query = "SELECT c FROM Componentfeaturesoutline c WHERE c.status = :status")})
public class Componentfeaturesoutline implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "componentfeaturesoutlineid", nullable = false)
    private Long componentfeaturesoutlineid;
    @Size(max = 2147483647)
    @Column(name = "featuresoutdescription", length = 2147483647)
    private String featuresoutdescription;
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
    @Column(name = "complicationcomponentfeaturesid")
    private Long complicationcomponentfeaturesid;

    public Componentfeaturesoutline() {
    }

    public Componentfeaturesoutline(Long componentfeaturesoutlineid) {
        this.componentfeaturesoutlineid = componentfeaturesoutlineid;
    }

    public Long getComponentfeaturesoutlineid() {
        return componentfeaturesoutlineid;
    }

    public void setComponentfeaturesoutlineid(Long componentfeaturesoutlineid) {
        this.componentfeaturesoutlineid = componentfeaturesoutlineid;
    }

    public String getFeaturesoutdescription() {
        return featuresoutdescription;
    }

    public void setFeaturesoutdescription(String featuresoutdescription) {
        this.featuresoutdescription = featuresoutdescription;
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
        hash += (componentfeaturesoutlineid != null ? componentfeaturesoutlineid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Componentfeaturesoutline)) {
            return false;
        }
        Componentfeaturesoutline other = (Componentfeaturesoutline) object;
        if ((this.componentfeaturesoutlineid == null && other.componentfeaturesoutlineid != null) || (this.componentfeaturesoutlineid != null && !this.componentfeaturesoutlineid.equals(other.componentfeaturesoutlineid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Componentfeaturesoutline[ componentfeaturesoutlineid=" + componentfeaturesoutlineid + " ]";
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

    public Long getComplicationcomponentfeaturesid() {
        return complicationcomponentfeaturesid;
    }

    public void setComplicationcomponentfeaturesid(Long complicationcomponentfeaturesid) {
        this.complicationcomponentfeaturesid = complicationcomponentfeaturesid;
    }
    
}
