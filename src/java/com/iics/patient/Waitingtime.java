/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
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
 * @author IICS
 */
@Entity
@Table(name = "waitingtime", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Waitingtime.findAll", query = "SELECT w FROM Waitingtime w")
    , @NamedQuery(name = "Waitingtime.findByUnitserviceid", query = "SELECT w FROM Waitingtime w WHERE w.unitserviceid = :unitserviceid")
    , @NamedQuery(name = "Waitingtime.findByDateadded", query = "SELECT w FROM Waitingtime w WHERE w.dateadded = :dateadded")
    , @NamedQuery(name = "Waitingtime.findBySum", query = "SELECT w FROM Waitingtime w WHERE w.sum = :sum")})
public class Waitingtime implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "unitserviceid")
    private BigInteger unitserviceid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "sum", precision = 17, scale = 17)
    private Double sum;

    public Waitingtime() {
    }

    public BigInteger getUnitserviceid() {
        return unitserviceid;
    }

    public void setUnitserviceid(BigInteger unitserviceid) {
        this.unitserviceid = unitserviceid;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }
    
}
