/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.scheduleplan;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "servicedayplan", catalog = "iics_database", schema = "scheduleplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Servicedayplan.findAll", query = "SELECT s FROM Servicedayplan s")
    , @NamedQuery(name = "Servicedayplan.findByServicedayplanid", query = "SELECT s FROM Servicedayplan s WHERE s.servicedayplanid = :servicedayplanid")
    , @NamedQuery(name = "Servicedayplan.findByServicedayid", query = "SELECT s FROM Servicedayplan s WHERE s.servicedayid = :servicedayid")
    , @NamedQuery(name = "Servicedayplan.findByDesiredstaff", query = "SELECT s FROM Servicedayplan s WHERE s.desiredstaff = :desiredstaff")
    , @NamedQuery(name = "Servicedayplan.findByStarttime", query = "SELECT s FROM Servicedayplan s WHERE s.starttime = :starttime")
    , @NamedQuery(name = "Servicedayplan.findByEndtime", query = "SELECT s FROM Servicedayplan s WHERE s.endtime = :endtime")})
public class Servicedayplan implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "servicedayplanid", nullable = false)
    private Long servicedayplanid;
    @Column(name = "servicedayid")
    private Integer servicedayid;
    @Column(name = "desiredstaff")
    private Integer desiredstaff;
    @Size(max = 30)
    @Column(name = "starttime", length = 30)
    private String starttime;
    @Size(max = 30)
    @Column(name = "endtime", length = 30)
    private String endtime;
    @JoinColumn(name = "serviceid", referencedColumnName = "serviceid")
    @ManyToOne
    private Service serviceid;

    public Servicedayplan() {
    }

    public Servicedayplan(Long servicedayplanid) {
        this.servicedayplanid = servicedayplanid;
    }

    public Long getServicedayplanid() {
        return servicedayplanid;
    }

    public void setServicedayplanid(Long servicedayplanid) {
        this.servicedayplanid = servicedayplanid;
    }

    public Integer getServicedayid() {
        return servicedayid;
    }

    public void setServicedayid(Integer servicedayid) {
        this.servicedayid = servicedayid;
    }

    public Integer getDesiredstaff() {
        return desiredstaff;
    }

    public void setDesiredstaff(Integer desiredstaff) {
        this.desiredstaff = desiredstaff;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setStarttime(String starttime) {
        this.starttime = starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public Service getServiceid() {
        return serviceid;
    }

    public void setServiceid(Service serviceid) {
        this.serviceid = serviceid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (servicedayplanid != null ? servicedayplanid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Servicedayplan)) {
            return false;
        }
        Servicedayplan other = (Servicedayplan) object;
        if ((this.servicedayplanid == null && other.servicedayplanid != null) || (this.servicedayplanid != null && !this.servicedayplanid.equals(other.servicedayplanid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.scheduleplan.Servicedayplan[ servicedayplanid=" + servicedayplanid + " ]";
    }
    
}
