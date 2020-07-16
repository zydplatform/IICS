/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.facilityschedule", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityschedule.findAll", query = "SELECT f FROM Facilityschedule f")
    , @NamedQuery(name = "Facilityschedule.findBySchedulename", query = "SELECT f FROM Facilityschedule f WHERE f.schedulename = :schedulename")
    , @NamedQuery(name = "Facilityschedule.findByDescription", query = "SELECT f FROM Facilityschedule f WHERE f.description = :description")
    , @NamedQuery(name = "Facilityschedule.findByFacilityscheduleid", query = "SELECT f FROM Facilityschedule f WHERE f.facilityscheduleid = :facilityscheduleid")
    , @NamedQuery(name = "Facilityschedule.findByFacilityid", query = "SELECT f FROM Facilityschedule f WHERE f.facilityid = :facilityid")})
public class Facilityschedule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "schedulename", nullable = false, length = 2147483647)
    private String schedulename;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityscheduleid", nullable = false)
    private Long facilityscheduleid;
    @Column(name = "facilityid")
    private Long facilityid;

    public Facilityschedule() {
    }

    public Facilityschedule(Long facilityscheduleid) {
        this.facilityscheduleid = facilityscheduleid;
    }

    public Facilityschedule(Long facilityscheduleid, String schedulename) {
        this.facilityscheduleid = facilityscheduleid;
        this.schedulename = schedulename;
    }

    public String getSchedulename() {
        return schedulename;
    }

    public void setSchedulename(String schedulename) {
        this.schedulename = schedulename;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getFacilityscheduleid() {
        return facilityscheduleid;
    }

    public void setFacilityscheduleid(Long facilityscheduleid) {
        this.facilityscheduleid = facilityscheduleid;
    }

    public Long getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Long facilityid) {
        this.facilityid = facilityid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityscheduleid != null ? facilityscheduleid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityschedule)) {
            return false;
        }
        Facilityschedule other = (Facilityschedule) object;
        if ((this.facilityscheduleid == null && other.facilityscheduleid != null) || (this.facilityscheduleid != null && !this.facilityscheduleid.equals(other.facilityscheduleid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Facilityschedule[ facilityscheduleid=" + facilityscheduleid + " ]";
    }

}
