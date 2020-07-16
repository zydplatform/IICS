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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.stafffacilityunitroleprivilege", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stafffacilityunitroleprivilege.findAll", query = "SELECT s FROM Stafffacilityunitroleprivilege s")
    , @NamedQuery(name = "Stafffacilityunitroleprivilege.findByStafffacilityunitroleprivilegeid", query = "SELECT s FROM Stafffacilityunitroleprivilege s WHERE s.stafffacilityunitroleprivilegeid = :stafffacilityunitroleprivilegeid")
    , @NamedQuery(name = "Stafffacilityunitroleprivilege.findByActive", query = "SELECT s FROM Stafffacilityunitroleprivilege s WHERE s.active = :active")
    , @NamedQuery(name = "Stafffacilityunitroleprivilege.findByIndex", query = "SELECT s FROM Stafffacilityunitroleprivilege s WHERE s.index = :index")})
public class Stafffacilityunitroleprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "stafffacilityunitroleprivilegeid", nullable = false)
    private Long stafffacilityunitroleprivilegeid;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "index")
    private Integer index;

    @Column(name = "stafffacilityunitid")
    private Long stafffacilityunitid;

    public Long getStafffacilityunitid() {
        return stafffacilityunitid;
    }

    public void setStafffacilityunitid(Long stafffacilityunitid) {
        this.stafffacilityunitid = stafffacilityunitid;
    }

    public Long getSystemroleprivilegeid() {
        return systemroleprivilegeid;
    }

    public void setSystemroleprivilegeid(Long systemroleprivilegeid) {
        this.systemroleprivilegeid = systemroleprivilegeid;
    }

    @Column(name = "systemroleprivilegeid")
    private Long systemroleprivilegeid;

    public Stafffacilityunitroleprivilege() {
    }

    public Stafffacilityunitroleprivilege(Long stafffacilityunitroleprivilegeid) {
        this.stafffacilityunitroleprivilegeid = stafffacilityunitroleprivilegeid;
    }

    public Long getStafffacilityunitroleprivilegeid() {
        return stafffacilityunitroleprivilegeid;
    }

    public void setStafffacilityunitroleprivilegeid(Long stafffacilityunitroleprivilegeid) {
        this.stafffacilityunitroleprivilegeid = stafffacilityunitroleprivilegeid;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (stafffacilityunitroleprivilegeid != null ? stafffacilityunitroleprivilegeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stafffacilityunitroleprivilege)) {
            return false;
        }
        Stafffacilityunitroleprivilege other = (Stafffacilityunitroleprivilege) object;
        if ((this.stafffacilityunitroleprivilegeid == null && other.stafffacilityunitroleprivilegeid != null) || (this.stafffacilityunitroleprivilegeid != null && !this.stafffacilityunitroleprivilegeid.equals(other.stafffacilityunitroleprivilegeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Stafffacilityunitroleprivilege[ stafffacilityunitroleprivilegeid=" + stafffacilityunitroleprivilegeid + " ]";
    }

}
