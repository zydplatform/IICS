/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "servicetype", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicetype.findAll", query = "SELECT s FROM Servicetype s")
    , @NamedQuery(name = "Servicetype.findByServicetypeid", query = "SELECT s FROM Servicetype s WHERE s.servicetypeid = :servicetypeid")
    , @NamedQuery(name = "Servicetype.findByName", query = "SELECT s FROM Servicetype s WHERE s.name = :name")
    , @NamedQuery(name = "Servicetype.findByDescription", query = "SELECT s FROM Servicetype s WHERE s.description = :description")
    , @NamedQuery(name = "Servicetype.findByDuration", query = "SELECT s FROM Servicetype s WHERE s.duration = :duration")
    , @NamedQuery(name = "Servicetype.findByIsactive", query = "SELECT s FROM Servicetype s WHERE s.isactive = :isactive")
    , @NamedQuery(name = "Servicetype.findByFacilityid", query = "SELECT s FROM Servicetype s WHERE s.facilityid = :facilityid")})
public class Servicetype implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "servicetypeid", nullable = false)
    private Long servicetypeid;
    @Size(max = 25)
    @Column(name = "name", length = 25)
    private String name;
    @Size(max = 100)
    @Column(name = "description", length = 100)
    private String description;
    @Column(name = "duration")
    private Integer duration;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "facilityid")
    private Integer facilityid;

    public Servicetype() {
    }

    public Servicetype(Long servicetypeid) {
        this.servicetypeid = servicetypeid;
    }

    public Long getServicetypeid() {
        return servicetypeid;
    }

    public void setServicetypeid(Long servicetypeid) {
        this.servicetypeid = servicetypeid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (servicetypeid != null ? servicetypeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Servicetype)) {
            return false;
        }
        Servicetype other = (Servicetype) object;
        if ((this.servicetypeid == null && other.servicetypeid != null) || (this.servicetypeid != null && !this.servicetypeid.equals(other.servicetypeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Servicetype[ servicetypeid=" + servicetypeid + " ]";
    }

}
