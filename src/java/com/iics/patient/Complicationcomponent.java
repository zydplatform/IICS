/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS-GRACE
 */
@Entity
@Table(name = "complicationcomponent", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Complicationcomponent.findAll", query = "SELECT c FROM Complicationcomponent c")
    , @NamedQuery(name = "Complicationcomponent.findByComplicationcomponentid", query = "SELECT c FROM Complicationcomponent c WHERE c.complicationcomponentid = :complicationcomponentid")
    , @NamedQuery(name = "Complicationcomponent.findByComponentname", query = "SELECT c FROM Complicationcomponent c WHERE c.componentname = :componentname")
    , @NamedQuery(name = "Complicationcomponent.findByFacilityid", query = "SELECT c FROM Complicationcomponent c WHERE c.facilityid = :facilityid")
    , @NamedQuery(name = "Complicationcomponent.findByStatus", query = "SELECT c FROM Complicationcomponent c WHERE c.status = :status")})
public class Complicationcomponent implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "complicationcomponentid", nullable = false)
    private Long complicationcomponentid;
    @Column(name = "componentname", length = 255)
    private String componentname;
    @Column(name = "facilityid")
    private Long facilityid;
    @Column(name = "status")
    private Boolean status;

    public Complicationcomponent() {
    }

    public Complicationcomponent(Long complicationcomponentid) {
        this.complicationcomponentid = complicationcomponentid;
    }

    public Long getComplicationcomponentid() {
        return complicationcomponentid;
    }

    public void setComplicationcomponentid(Long complicationcomponentid) {
        this.complicationcomponentid = complicationcomponentid;
    }

    public String getComponentname() {
        return componentname;
    }

    public void setComponentname(String componentname) {
        this.componentname = componentname;
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
        hash += (complicationcomponentid != null ? complicationcomponentid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Complicationcomponent)) {
            return false;
        }
        Complicationcomponent other = (Complicationcomponent) object;
        if ((this.complicationcomponentid == null && other.complicationcomponentid != null) || (this.complicationcomponentid != null && !this.complicationcomponentid.equals(other.complicationcomponentid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Complicationcomponent[ complicationcomponentid=" + complicationcomponentid + " ]";
    }

    public Long getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Long facilityid) {
        this.facilityid = facilityid;
    }
    
}
