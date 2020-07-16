/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICSRemote
 */
@Entity
@Table(name = "currencyrates", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Currencyrates.findAll", query = "SELECT c FROM Currencyrates c")
    , @NamedQuery(name = "Currencyrates.findByCurrencyratesid", query = "SELECT c FROM Currencyrates c WHERE c.currencyratesid = :currencyratesid")
    , @NamedQuery(name = "Currencyrates.findByBuyone", query = "SELECT c FROM Currencyrates c WHERE c.buyone = :buyone")
    , @NamedQuery(name = "Currencyrates.findBySellone", query = "SELECT c FROM Currencyrates c WHERE c.sellone = :sellone")
    , @NamedQuery(name = "Currencyrates.findByBuytwo", query = "SELECT c FROM Currencyrates c WHERE c.buytwo = :buytwo")
    , @NamedQuery(name = "Currencyrates.findBySelltwo", query = "SELECT c FROM Currencyrates c WHERE c.selltwo = :selltwo")
    , @NamedQuery(name = "Currencyrates.findByDateadded", query = "SELECT c FROM Currencyrates c WHERE c.dateadded = :dateadded")})
public class Currencyrates implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "currencyratesid", nullable = false)
    private Integer currencyratesid;
    @Column(name = "buyone")
    private Integer buyone;
    @Column(name = "sellone")
    private Integer sellone;
    @Column(name = "buytwo")
    private Integer buytwo;
    @Column(name = "selltwo")
    private Integer selltwo;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "countrycurrencyoneid")
    private Integer countrycurrencyoneid;
    @JoinColumn(name = "countrycurrencytwoid", referencedColumnName = "countrycurrencyid")
    @ManyToOne
    private Countrycurrency countrycurrencytwoid;

    public Currencyrates() {
    }

    public Currencyrates(Integer currencyratesid) {
        this.currencyratesid = currencyratesid;
    }

    public Integer getCurrencyratesid() {
        return currencyratesid;
    }

    public void setCurrencyratesid(Integer currencyratesid) {
        this.currencyratesid = currencyratesid;
    }

    public Integer getBuyone() {
        return buyone;
    }

    public void setBuyone(Integer buyone) {
        this.buyone = buyone;
    }

    public Integer getSellone() {
        return sellone;
    }

    public void setSellone(Integer sellone) {
        this.sellone = sellone;
    }

    public Integer getBuytwo() {
        return buytwo;
    }

    public void setBuytwo(Integer buytwo) {
        this.buytwo = buytwo;
    }

    public Integer getSelltwo() {
        return selltwo;
    }

    public void setSelltwo(Integer selltwo) {
        this.selltwo = selltwo;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Integer getCountrycurrencyoneid() {
        return countrycurrencyoneid;
    }

    public void setCountrycurrencyoneid(Integer countrycurrencyoneid) {
        this.countrycurrencyoneid = countrycurrencyoneid;
    }

    public Countrycurrency getCountrycurrencytwoid() {
        return countrycurrencytwoid;
    }

    public void setCountrycurrencytwoid(Countrycurrency countrycurrencytwoid) {
        this.countrycurrencytwoid = countrycurrencytwoid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (currencyratesid != null ? currencyratesid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Currencyrates)) {
            return false;
        }
        Currencyrates other = (Currencyrates) object;
        if ((this.currencyratesid == null && other.currencyratesid != null) || (this.currencyratesid != null && !this.currencyratesid.equals(other.currencyratesid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Currencyrates[ currencyratesid=" + currencyratesid + " ]";
    }
    
}
