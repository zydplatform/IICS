/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "worldcountries", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Worldcountries.findAll", query = "SELECT w FROM Worldcountries w")
    , @NamedQuery(name = "Worldcountries.findByWorldcountriesid", query = "SELECT w FROM Worldcountries w WHERE w.worldcountriesid = :worldcountriesid")
    , @NamedQuery(name = "Worldcountries.findByCountryname", query = "SELECT w FROM Worldcountries w WHERE w.countryname = :countryname")
    , @NamedQuery(name = "Worldcountries.findByCountrycurrency", query = "SELECT w FROM Worldcountries w WHERE w.countrycurrency = :countrycurrency")
    , @NamedQuery(name = "Worldcountries.findByCurrencyabbrv", query = "SELECT w FROM Worldcountries w WHERE w.currencyabbrv = :currencyabbrv")})
public class Worldcountries implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "worldcountriesid", nullable = false)
    private Integer worldcountriesid;
    @Size(max = 2147483647)
    @Column(name = "countryname", length = 2147483647)
    private String countryname;
    @Size(max = 2147483647)
    @Column(name = "countrycurrency", length = 2147483647)
    private String countrycurrency;
    @Size(max = 2147483647)
    @Column(name = "currencyabbrv", length = 2147483647)
    private String currencyabbrv;

    public Worldcountries() {
    }

    public Worldcountries(Integer worldcountriesid) {
        this.worldcountriesid = worldcountriesid;
    }

    public Integer getWorldcountriesid() {
        return worldcountriesid;
    }

    public void setWorldcountriesid(Integer worldcountriesid) {
        this.worldcountriesid = worldcountriesid;
    }

    public String getCountryname() {
        return countryname;
    }

    public void setCountryname(String countryname) {
        this.countryname = countryname;
    }

    public String getCountrycurrency() {
        return countrycurrency;
    }

    public void setCountrycurrency(String countrycurrency) {
        this.countrycurrency = countrycurrency;
    }

    public String getCurrencyabbrv() {
        return currencyabbrv;
    }

    public void setCurrencyabbrv(String currencyabbrv) {
        this.currencyabbrv = currencyabbrv;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (worldcountriesid != null ? worldcountriesid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Worldcountries)) {
            return false;
        }
        Worldcountries other = (Worldcountries) object;
        if ((this.worldcountriesid == null && other.worldcountriesid != null) || (this.worldcountriesid != null && !this.worldcountriesid.equals(other.worldcountriesid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Worldcountries[ worldcountriesid=" + worldcountriesid + " ]";
    }
    
}
