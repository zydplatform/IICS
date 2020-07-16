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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.schedule", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Schedule.findAll", query = "SELECT s FROM Schedule s")
    , @NamedQuery(name = "Schedule.findByScheduleid", query = "SELECT s FROM Schedule s WHERE s.scheduleid = :scheduleid")
    , @NamedQuery(name = "Schedule.findByScheduledayname", query = "SELECT s FROM Schedule s WHERE s.scheduledayname = :scheduledayname")
    , @NamedQuery(name = "Schedule.findByAbbreviation", query = "SELECT s FROM Schedule s WHERE s.abbreviation = :abbreviation")
    , @NamedQuery(name = "Schedule.findByDateadded", query = "SELECT s FROM Schedule s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Schedule.findByAddedby", query = "SELECT s FROM Schedule s WHERE s.addedby = :addedby")})
public class Schedule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "scheduleid", nullable = false)
    private Integer scheduleid;
    @Size(max = 100)
    @Column(name = "scheduledayname", length = 100)
    private String scheduledayname;
    @Size(max = 20)
    @Column(name = "abbreviation", length = 20)
    private String abbreviation;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private Long addedby;

    public Schedule() {
    }

    public Schedule(Integer scheduleid) {
        this.scheduleid = scheduleid;
    }

    public Integer getScheduleid() {
        return scheduleid;
    }

    public void setScheduleid(Integer scheduleid) {
        this.scheduleid = scheduleid;
    }

    public String getScheduledayname() {
        return scheduledayname;
    }

    public void setScheduledayname(String scheduledayname) {
        this.scheduledayname = scheduledayname;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (scheduleid != null ? scheduleid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Schedule)) {
            return false;
        }
        Schedule other = (Schedule) object;
        if ((this.scheduleid == null && other.scheduleid != null) || (this.scheduleid != null && !this.scheduleid.equals(other.scheduleid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Schedule[ scheduleid=" + scheduleid + " ]";
    }
    
}
