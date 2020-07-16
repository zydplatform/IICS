/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "buildingroom", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Buildingroom.findAll", query = "SELECT b FROM Buildingroom b")
    , @NamedQuery(name = "Buildingroom.findByBuildingroomid", query = "SELECT b FROM Buildingroom b WHERE b.buildingroomid = :buildingroomid")
    , @NamedQuery(name = "Buildingroom.findByBuildingroomname", query = "SELECT b FROM Buildingroom b WHERE b.buildingroomname = :buildingroomname")
    , @NamedQuery(name = "Buildingroom.findByDateadded", query = "SELECT b FROM Buildingroom b WHERE b.dateadded = :dateadded")
    , @NamedQuery(name = "Buildingroom.findByDateupdated", query = "SELECT b FROM Buildingroom b WHERE b.dateupdated = :dateupdated")
    , @NamedQuery(name = "Buildingroom.findByAddedby", query = "SELECT b FROM Buildingroom b WHERE b.addedby = :addedby")
    , @NamedQuery(name = "Buildingroom.findByUpdatedby", query = "SELECT b FROM Buildingroom b WHERE b.updatedby = :updatedby")
    , @NamedQuery(name = "Buildingroom.findByIsactive", query = "SELECT b FROM Buildingroom b WHERE b.isactive = :isactive")})
public class Buildingroom implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "buildingroomid", nullable = false)
    private Integer buildingroomid;
    @Size(max = 2147483647)
    @Column(name = "buildingroomname", length = 2147483647)
    private String buildingroomname;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "buildingid")
    private Integer buildingid;

    public Buildingroom() {
    }

    public Buildingroom(Integer buildingroomid) {
        this.buildingroomid = buildingroomid;
    }

    public Integer getBuildingroomid() {
        return buildingroomid;
    }

    public void setBuildingroomid(Integer buildingroomid) {
        this.buildingroomid = buildingroomid;
    }

    public String getBuildingroomname() {
        return buildingroomname;
    }

    public void setBuildingroomname(String buildingroomname) {
        this.buildingroomname = buildingroomname;
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

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
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
        hash += (buildingroomid != null ? buildingroomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Buildingroom)) {
            return false;
        }
        Buildingroom other = (Buildingroom) object;
        if ((this.buildingroomid == null && other.buildingroomid != null) || (this.buildingroomid != null && !this.buildingroomid.equals(other.buildingroomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Buildingroom[ buildingroomid=" + buildingroomid + " ]";
    }

    public Integer getBuildingid() {
        return buildingid;
    }

    public void setBuildingid(Integer buildingid) {
        this.buildingid = buildingid;
    }
    
}
