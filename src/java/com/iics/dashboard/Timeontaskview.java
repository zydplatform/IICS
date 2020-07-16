/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.dashboard;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "timeontaskview", catalog = "iics_database", schema = "dashboard")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Timeontaskview.findAll", query = "SELECT t FROM Timeontaskview t")
    , @NamedQuery(name = "Timeontaskview.findByServicedby", query = "SELECT t FROM Timeontaskview t WHERE t.servicedby = :servicedby")
    , @NamedQuery(name = "Timeontaskview.findByDate", query = "SELECT t FROM Timeontaskview t WHERE t.date = :date")
    , @NamedQuery(name = "Timeontaskview.findByStarttime", query = "SELECT t FROM Timeontaskview t WHERE t.starttime = :starttime")
    , @NamedQuery(name = "Timeontaskview.findByEndtime", query = "SELECT t FROM Timeontaskview t WHERE t.endtime = :endtime")
    , @NamedQuery(name = "Timeontaskview.findByUnitserviceid", query = "SELECT t FROM Timeontaskview t WHERE t.unitserviceid = :unitserviceid")})
public class Timeontaskview implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "servicedby")
    @Id
    private BigDecimal servicedby;
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Column(name = "starttime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttime;
    @Column(name = "endtime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endtime;
    @Column(name = "unitserviceid")
    private BigDecimal unitserviceid;

    public Timeontaskview() {
    }

    public BigDecimal getServicedby() {
        return servicedby;
    }

    public void setServicedby(BigDecimal servicedby) {
        this.servicedby = servicedby;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public BigDecimal getUnitserviceid() {
        return unitserviceid;
    }

    public void setUnitserviceid(BigDecimal unitserviceid) {
        this.unitserviceid = unitserviceid;
    }
    
}
