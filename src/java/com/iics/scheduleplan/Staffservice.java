/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.scheduleplan;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "staffservice", catalog = "iics_database", schema = "scheduleplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffservice.findAll", query = "SELECT s FROM Staffservice s")
    , @NamedQuery(name = "Staffservice.findByStaffserviceid", query = "SELECT s FROM Staffservice s WHERE s.staffserviceid = :staffserviceid")
    , @NamedQuery(name = "Staffservice.findByStaffid", query = "SELECT s FROM Staffservice s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Staffservice.findByServiceid", query = "SELECT s FROM Staffservice s WHERE s.serviceid = :serviceid")})
public class Staffservice implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "staffserviceid", nullable = false)
    private Long staffserviceid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "serviceid")
    private BigInteger serviceid;

    public Staffservice() {
    }

    public Staffservice(Long staffserviceid) {
        this.staffserviceid = staffserviceid;
    }

    public Long getStaffserviceid() {
        return staffserviceid;
    }

    public void setStaffserviceid(Long staffserviceid) {
        this.staffserviceid = staffserviceid;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public BigInteger getServiceid() {
        return serviceid;
    }

    public void setServiceid(BigInteger serviceid) {
        this.serviceid = serviceid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffserviceid != null ? staffserviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staffservice)) {
            return false;
        }
        Staffservice other = (Staffservice) object;
        if ((this.staffserviceid == null && other.staffserviceid != null) || (this.staffserviceid != null && !this.staffserviceid.equals(other.staffserviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.scheduleplan.Staffservice[ staffserviceid=" + staffserviceid + " ]";
    }
    
}
