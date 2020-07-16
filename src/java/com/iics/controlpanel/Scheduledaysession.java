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
@Table(name = "scheduledaysession", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Scheduledaysession.findAll", query = "SELECT s FROM Scheduledaysession s")
    , @NamedQuery(name = "Scheduledaysession.findByScheduledaysessionid", query = "SELECT s FROM Scheduledaysession s WHERE s.scheduledaysessionid = :scheduledaysessionid")
    , @NamedQuery(name = "Scheduledaysession.findByStarttime", query = "SELECT s FROM Scheduledaysession s WHERE s.starttime = :starttime")
    , @NamedQuery(name = "Scheduledaysession.findByEndtime", query = "SELECT s FROM Scheduledaysession s WHERE s.endtime = :endtime")})
public class Scheduledaysession implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "scheduledaysessionid", nullable = false)
    private Long scheduledaysessionid;
    @Size(max = 30)
    @Column(name = "starttime", length = 30)
    private String starttime;
    @Size(max = 30)
    @Column(name = "endtime", length = 30)
    private String endtime;
    @JoinColumn(name = "scheduledayid", referencedColumnName = "scheduledayid")
    @ManyToOne
    private Scheduleday scheduledayid;

    public Scheduledaysession() {
    }

    public Scheduledaysession(Long scheduledaysessionid) {
        this.scheduledaysessionid = scheduledaysessionid;
    }

    public Long getScheduledaysessionid() {
        return scheduledaysessionid;
    }

    public void setScheduledaysessionid(Long scheduledaysessionid) {
        this.scheduledaysessionid = scheduledaysessionid;
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

    public Scheduleday getScheduledayid() {
        return scheduledayid;
    }

    public void setScheduledayid(Scheduleday scheduledayid) {
        this.scheduledayid = scheduledayid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (scheduledaysessionid != null ? scheduledaysessionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Scheduledaysession)) {
            return false;
        }
        Scheduledaysession other = (Scheduledaysession) object;
        if ((this.scheduledaysessionid == null && other.scheduledaysessionid != null) || (this.scheduledaysessionid != null && !this.scheduledaysessionid.equals(other.scheduledaysessionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Scheduledaysession[ scheduledaysessionid=" + scheduledaysessionid + " ]";
    }
    
}
