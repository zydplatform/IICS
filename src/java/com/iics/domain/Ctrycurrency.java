/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "ctrycurrency", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ctrycurrency.findAll", query = "SELECT c FROM Ctrycurrency c")
    , @NamedQuery(name = "Ctrycurrency.findByCurrencyid", query = "SELECT c FROM Ctrycurrency c WHERE c.currencyid = :currencyid")
    , @NamedQuery(name = "Ctrycurrency.findByCountry", query = "SELECT c FROM Ctrycurrency c WHERE c.country = :country")
    , @NamedQuery(name = "Ctrycurrency.findByCurrencyname", query = "SELECT c FROM Ctrycurrency c WHERE c.currencyname = :currencyname")
    , @NamedQuery(name = "Ctrycurrency.findByAbbreviation", query = "SELECT c FROM Ctrycurrency c WHERE c.abbreviation = :abbreviation")
    , @NamedQuery(name = "Ctrycurrency.findByCurrencyrate", query = "SELECT c FROM Ctrycurrency c WHERE c.currencyrate = :currencyrate")
    , @NamedQuery(name = "Ctrycurrency.findByCurrencystatus", query = "SELECT c FROM Ctrycurrency c WHERE c.currencystatus = :currencystatus")
    , @NamedQuery(name = "Ctrycurrency.findByAddedby", query = "SELECT c FROM Ctrycurrency c WHERE c.addedby = :addedby")
    , @NamedQuery(name = "Ctrycurrency.findByUpdatedby", query = "SELECT c FROM Ctrycurrency c WHERE c.updatedby = :updatedby")
    , @NamedQuery(name = "Ctrycurrency.findByDateadded", query = "SELECT c FROM Ctrycurrency c WHERE c.dateadded = :dateadded")
    , @NamedQuery(name = "Ctrycurrency.findByDateupdated", query = "SELECT c FROM Ctrycurrency c WHERE c.dateupdated = :dateupdated")})
public class Ctrycurrency implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "currencyid", nullable = false)
    private Integer currencyid;
    @Size(max = 2147483647)
    @Column(name = "country", length = 2147483647)
    private String country;
    @Size(max = 2147483647)
    @Column(name = "currencyname", length = 2147483647)
    private String currencyname;
    @Size(max = 2147483647)
    @Column(name = "abbreviation", length = 2147483647)
    private String abbreviation;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "currencyrate", precision = 17, scale = 17)
    private Double currencyrate;
    @Column(name = "currencystatus")
    private Boolean currencystatus;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "updatedby")
    private Long updatedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;

    public Ctrycurrency() {
    }

    public Ctrycurrency(Integer currencyid) {
        this.currencyid = currencyid;
    }

    public Integer getCurrencyid() {
        return currencyid;
    }

    public void setCurrencyid(Integer currencyid) {
        this.currencyid = currencyid;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCurrencyname() {
        return currencyname;
    }

    public void setCurrencyname(String currencyname) {
        this.currencyname = currencyname;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    public Double getCurrencyrate() {
        return currencyrate;
    }

    public void setCurrencyrate(Double currencyrate) {
        this.currencyrate = currencyrate;
    }

    public Boolean getCurrencystatus() {
        return currencystatus;
    }

    public void setCurrencystatus(Boolean currencystatus) {
        this.currencystatus = currencystatus;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (currencyid != null ? currencyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ctrycurrency)) {
            return false;
        }
        Ctrycurrency other = (Ctrycurrency) object;
        if ((this.currencyid == null && other.currencyid != null) || (this.currencyid != null && !this.currencyid.equals(other.currencyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Ctrycurrency[ currencyid=" + currencyid + " ]";
    }
    
}
