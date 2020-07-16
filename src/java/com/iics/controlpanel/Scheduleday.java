/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author user
 */
@Entity
@Table(name = "scheduleday", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Scheduleday.findAll", query = "SELECT s FROM Scheduleday s")
    , @NamedQuery(name = "Scheduleday.findByScheduledayid", query = "SELECT s FROM Scheduleday s WHERE s.scheduledayid = :scheduledayid")
    , @NamedQuery(name = "Scheduleday.findByWeekday", query = "SELECT s FROM Scheduleday s WHERE s.weekday = :weekday")})
public class Scheduleday implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "scheduledayid", nullable = false)
    private Long scheduledayid;
    @Size(max = 30)
    @Column(name = "weekday", length = 30)
    private String weekday;
    @JoinColumn(name = "schedulesid", referencedColumnName = "schedulesid")
    @ManyToOne
    private Schedules schedulesid;
    @OneToMany(mappedBy = "scheduledayid")
    private List<Scheduledaysession> scheduledaysessionList;

    public Scheduleday() {
    }

    public Scheduleday(Long scheduledayid) {
        this.scheduledayid = scheduledayid;
    }

    public Long getScheduledayid() {
        return scheduledayid;
    }

    public void setScheduledayid(Long scheduledayid) {
        this.scheduledayid = scheduledayid;
    }

    public String getWeekday() {
        return weekday;
    }

    public void setWeekday(String weekday) {
        this.weekday = weekday;
    }

    public Schedules getSchedulesid() {
        return schedulesid;
    }

    public void setSchedulesid(Schedules schedulesid) {
        this.schedulesid = schedulesid;
    }

    @XmlTransient
    public List<Scheduledaysession> getScheduledaysessionList() {
        return scheduledaysessionList;
    }

    public void setScheduledaysessionList(List<Scheduledaysession> scheduledaysessionList) {
        this.scheduledaysessionList = scheduledaysessionList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (scheduledayid != null ? scheduledayid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Scheduleday)) {
            return false;
        }
        Scheduleday other = (Scheduleday) object;
        if ((this.scheduledayid == null && other.scheduledayid != null) || (this.scheduledayid != null && !this.scheduledayid.equals(other.scheduledayid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Scheduleday[ scheduledayid=" + scheduledayid + " ]";
    }
}
