/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.dashboard;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "itemstatistics", catalog = "iics_database", schema = "dashboard")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemstatistics.findAll", query = "SELECT i FROM Itemstatistics i")
    , @NamedQuery(name = "Itemstatistics.findByItemid", query = "SELECT i FROM Itemstatistics i WHERE i.itemid = :itemid")
    , @NamedQuery(name = "Itemstatistics.findByLogtype", query = "SELECT i FROM Itemstatistics i WHERE i.logtype = :logtype")
    , @NamedQuery(name = "Itemstatistics.findByQuantity", query = "SELECT i FROM Itemstatistics i WHERE i.quantity = :quantity")
    , @NamedQuery(name = "Itemstatistics.findByFacilityunitid", query = "SELECT i FROM Itemstatistics i WHERE i.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Itemstatistics.findByStatmonth", query = "SELECT i FROM Itemstatistics i WHERE i.statmonth = :statmonth")
    , @NamedQuery(name = "Itemstatistics.findByStatyear", query = "SELECT i FROM Itemstatistics i WHERE i.statyear = :statyear")
    , @NamedQuery(name = "Itemstatistics.findByPackagename", query = "SELECT i FROM Itemstatistics i WHERE i.packagename = :packagename")})
public class Itemstatistics implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "itemid")
    @Id
    private BigInteger itemid;
    @Size(max = 255)
    @Column(name = "logtype")
    private String logtype;
    @Column(name = "quantity")
    private Integer quantity;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "statmonth")
    private Integer statmonth;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "statyear")
    private Double statyear;
    @Size(max = 2147483647)
    @Column(name = "packagename")
    private String packagename;

    public Itemstatistics() {
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public String getLogtype() {
        return logtype;
    }

    public void setLogtype(String logtype) {
        this.logtype = logtype;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Integer getStatmonth() {
        return statmonth;
    }

    public void setStatmonth(Integer statmonth) {
        this.statmonth = statmonth;
    }

    public Double getStatyear() {
        return statyear;
    }

    public void setStatyear(Double statyear) {
        this.statyear = statyear;
    }

    public String getPackagename() {
        return packagename;
    }

    public void setPackagename(String packagename) {
        this.packagename = packagename;
    }
    
}
