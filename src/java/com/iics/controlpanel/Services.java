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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
 * @author IICS
 */
@Entity
@Table(name = "controlpanel.services", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Services.findAll", query = "SELECT s FROM Services s")
    , @NamedQuery(name = "Services.findByServiceid", query = "SELECT s FROM Services s WHERE s.serviceid = :serviceid")
    , @NamedQuery(name = "Services.findByCompleted", query = "SELECT s FROM Services s WHERE s.completed = :completed")
    , @NamedQuery(name = "Services.findByCrondescription", query = "SELECT s FROM Services s WHERE s.crondescription = :crondescription")
    , @NamedQuery(name = "Services.findByDatechanged", query = "SELECT s FROM Services s WHERE s.datechanged = :datechanged")
    , @NamedQuery(name = "Services.findByDatecreated", query = "SELECT s FROM Services s WHERE s.datecreated = :datecreated")
    , @NamedQuery(name = "Services.findByDescription", query = "SELECT s FROM Services s WHERE s.description = :description")
    , @NamedQuery(name = "Services.findByEndingtime", query = "SELECT s FROM Services s WHERE s.endingtime = :endingtime")
    , @NamedQuery(name = "Services.findByFrequency", query = "SELECT s FROM Services s WHERE s.frequency = :frequency")
    , @NamedQuery(name = "Services.findByFreqvalue", query = "SELECT s FROM Services s WHERE s.freqvalue = :freqvalue")
    , @NamedQuery(name = "Services.findByLastruntime", query = "SELECT s FROM Services s WHERE s.lastruntime = :lastruntime")
    , @NamedQuery(name = "Services.findByNextruntime", query = "SELECT s FROM Services s WHERE s.nextruntime = :nextruntime")
    , @NamedQuery(name = "Services.findByServicename", query = "SELECT s FROM Services s WHERE s.servicename = :servicename")
    , @NamedQuery(name = "Services.findByStartingtime", query = "SELECT s FROM Services s WHERE s.startingtime = :startingtime")
    , @NamedQuery(name = "Services.findByStartingtimepattern", query = "SELECT s FROM Services s WHERE s.startingtimepattern = :startingtimepattern")
    , @NamedQuery(name = "Services.findByStartondemand", query = "SELECT s FROM Services s WHERE s.startondemand = :startondemand")
    , @NamedQuery(name = "Services.findByStartonstartup", query = "SELECT s FROM Services s WHERE s.startonstartup = :startonstartup")
    , @NamedQuery(name = "Services.findByStatus", query = "SELECT s FROM Services s WHERE s.status = :status")
    , @NamedQuery(name = "Services.findByChangedby", query = "SELECT s FROM Services s WHERE s.changedby = :changedby")
    , @NamedQuery(name = "Services.findByCreatedby", query = "SELECT s FROM Services s WHERE s.createdby = :createdby")
    , @NamedQuery(name = "Services.findByInterrupted", query = "SELECT s FROM Services s WHERE s.interrupted = :interrupted")})
public class Services implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "serviceid", nullable = false)
    private Integer serviceid;
    @Column(name = "completed")
    private Boolean completed;
    @Size(max = 255)
    @Column(name = "crondescription", length = 255)
    private String crondescription;
    @Column(name = "datechanged")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datechanged;
    @Basic(optional = false)
    @NotNull
    @Column(name = "datecreated", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Size(max = 255)
    @Column(name = "description", length = 255)
    private String description;
    @Column(name = "endingtime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endingtime;
    @Size(max = 255)
    @Column(name = "frequency", length = 255)
    private String frequency;
    @Size(max = 255)
    @Column(name = "freqvalue", length = 255)
    private String freqvalue;
    @Column(name = "lastruntime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastruntime;
    @Column(name = "nextruntime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date nextruntime;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "servicename", nullable = false, length = 255)
    private String servicename;
    @Column(name = "startingtime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startingtime;
    @Size(max = 255)
    @Column(name = "startingtimepattern", length = 255)
    private String startingtimepattern;
    @Column(name = "startondemand")
    private Boolean startondemand;
    @Column(name = "startonstartup")
    private Boolean startonstartup;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "changedby")
    private Long changedby;
    @Column(name = "createdby")
    private Long createdby;
    @Column(name = "interrupted")
    private Boolean interrupted;
    @Column(name = "autoactivityrunsetting")
    private Integer autoactivityrunsetting;
     @Column(name = "terminationreason")
    private String terminationreason;
     
    public Services() {
    }

    public Services(Integer serviceid) {
        this.serviceid = serviceid;
    }

    public Services(Integer serviceid, Date datecreated, String servicename) {
        this.serviceid = serviceid;
        this.datecreated = datecreated;
        this.servicename = servicename;
    }

    public Integer getServiceid() {
        return serviceid;
    }

    public void setServiceid(Integer serviceid) {
        this.serviceid = serviceid;
    }

    public Boolean getCompleted() {
        return completed;
    }

    public void setCompleted(Boolean completed) {
        this.completed = completed;
    }

    public String getCrondescription() {
        return crondescription;
    }

    public void setCrondescription(String crondescription) {
        this.crondescription = crondescription;
    }

    public Date getDatechanged() {
        return datechanged;
    }

    public void setDatechanged(Date datechanged) {
        this.datechanged = datechanged;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getEndingtime() {
        return endingtime;
    }

    public void setEndingtime(Date endingtime) {
        this.endingtime = endingtime;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public String getFreqvalue() {
        return freqvalue;
    }

    public void setFreqvalue(String freqvalue) {
        this.freqvalue = freqvalue;
    }

    public Date getLastruntime() {
        return lastruntime;
    }

    public void setLastruntime(Date lastruntime) {
        this.lastruntime = lastruntime;
    }

    public Date getNextruntime() {
        return nextruntime;
    }

    public void setNextruntime(Date nextruntime) {
        this.nextruntime = nextruntime;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public Date getStartingtime() {
        return startingtime;
    }

    public void setStartingtime(Date startingtime) {
        this.startingtime = startingtime;
    }

    public String getStartingtimepattern() {
        return startingtimepattern;
    }

    public void setStartingtimepattern(String startingtimepattern) {
        this.startingtimepattern = startingtimepattern;
    }

    public Boolean getStartondemand() {
        return startondemand;
    }

    public void setStartondemand(Boolean startondemand) {
        this.startondemand = startondemand;
    }

    public Boolean getStartonstartup() {
        return startonstartup;
    }

    public void setStartonstartup(Boolean startonstartup) {
        this.startonstartup = startonstartup;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Long getChangedby() {
        return changedby;
    }

    public void setChangedby(Long changedby) {
        this.changedby = changedby;
    }

    public Long getCreatedby() {
        return createdby;
    }

    public void setCreatedby(Long createdby) {
        this.createdby = createdby;
    }

    public Boolean getInterrupted() {
        return interrupted;
    }

    public void setInterrupted(Boolean interrupted) {
        this.interrupted = interrupted;
    }

    public Integer getAutoactivityrunsetting() {
        return autoactivityrunsetting;
    }

    public void setAutoactivityrunsetting(Integer autoactivityrunsetting) {
        this.autoactivityrunsetting = autoactivityrunsetting;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (serviceid != null ? serviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Services)) {
            return false;
        }
        Services other = (Services) object;
        if ((this.serviceid == null && other.serviceid != null) || (this.serviceid != null && !this.serviceid.equals(other.serviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Services[ serviceid=" + serviceid + " ]";
    }

    public String getTerminationreason() {
        return terminationreason;
    }

    public void setTerminationreason(String terminationreason) {
        this.terminationreason = terminationreason;
    }
    
}
