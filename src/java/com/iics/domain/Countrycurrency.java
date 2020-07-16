/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


/**
 *
 * @author IICSRemote
 */
@Entity
@Table(name = "countrycurrency", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Countrycurrency.findAll", query = "SELECT c FROM Countrycurrency c")
    , @NamedQuery(name = "Countrycurrency.findByCountrycurrencyid", query = "SELECT c FROM Countrycurrency c WHERE c.countrycurrencyid = :countrycurrencyid")
    , @NamedQuery(name = "Countrycurrency.findByCurrencyname", query = "SELECT c FROM Countrycurrency c WHERE c.currencyname = :currencyname")
    , @NamedQuery(name = "Countrycurrency.findByCurrencyshortname", query = "SELECT c FROM Countrycurrency c WHERE c.currencyshortname = :currencyshortname")
        , @NamedQuery(name = "Countrycurrency.findByCountryname", query = "SELECT c FROM Countrycurrency c WHERE c.countryname = :countryname")
        , @NamedQuery(name = "Countrycurrency.findByCountryshortname", query = "SELECT c FROM Countrycurrency c WHERE c.countryshortname = :countryshortname")
    , @NamedQuery(name = "Countrycurrency.findByDateadded", query = "SELECT c FROM Countrycurrency c WHERE c.dateadded = :dateadded")})
public class Countrycurrency implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "countrycurrencyid", nullable = false)
    private Integer countrycurrencyid;
    @Size(max = 2147483647)
    @Column(name = "currencyname", length = 2147483647)
    private String currencyname;
    @Size(max = 2147483647)
    @Column(name = "currencyshortname", length = 2147483647)
    private String currencyshortname;
    @Size(max = 2147483647)
    @Column(name = "countryname", length = 2147483647)
    private String countryname;
    @Size(max = 2147483647)
    @Column(name = "countryshortname", length = 2147483647)
    private String countryshortname;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @OneToMany(mappedBy = "countrycurrencyoneid")
    private List<Currencyrates> currencyratesList;
    @OneToMany(mappedBy = "countrycurrencytwoid")
    private List<Currencyrates> currencyratesList1;

    public Countrycurrency() {
    }

    public Countrycurrency(Integer countrycurrencyid) {
        this.countrycurrencyid = countrycurrencyid;
    }

    public Integer getCountrycurrencyid() {
        return countrycurrencyid;
    }

    public void setCountrycurrencyid(Integer countrycurrencyid) {
        this.countrycurrencyid = countrycurrencyid;
    }

    public String getCurrencyname() {
        return currencyname;
    }

    public void setCurrencyname(String currencyname) {
        this.currencyname = currencyname;
    }

    public String getCurrencyshortname() {
        return currencyshortname;
    }

    public void setCurrencyshortname(String currencyshortname) {
        this.currencyshortname = currencyshortname;
    }
    
     public String getCountryname() {
        return countryname;
    }

    public void setCountryname(String countryname) {
        this.countryname = countryname;
    }

     public String getCountryshortname() {
        return countryshortname;
    }

    public void setCountryshortname(String countryshortname) {
        this.countryshortname = countryshortname;
    }

    
    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    @XmlTransient
    public List<Currencyrates> getCurrencyratesList() {
        return currencyratesList;
    }

    public void setCurrencyratesList(List<Currencyrates> currencyratesList) {
        this.currencyratesList = currencyratesList;
    }

    @XmlTransient
    public List<Currencyrates> getCurrencyratesList1() {
        return currencyratesList1;
    }

    public void setCurrencyratesList1(List<Currencyrates> currencyratesList1) {
        this.currencyratesList1 = currencyratesList1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (countrycurrencyid != null ? countrycurrencyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Countrycurrency)) {
            return false;
        }
        Countrycurrency other = (Countrycurrency) object;
        if ((this.countrycurrencyid == null && other.countrycurrencyid != null) || (this.countrycurrencyid != null && !this.countrycurrencyid.equals(other.countrycurrencyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Countrycurrency[ countrycurrencyid=" + countrycurrencyid + " ]";
    }
    
}
