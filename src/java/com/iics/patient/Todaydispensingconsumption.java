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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS TECHS
 */
@Entity
@Table(name = "todaydispensingconsumption", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Todaydispensingconsumption.findAll", query = "SELECT t FROM Todaydispensingconsumption t")
    , @NamedQuery(name = "Todaydispensingconsumption.findByDestinationunitid", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.destinationunitid = :destinationunitid")
    , @NamedQuery(name = "Todaydispensingconsumption.findByStatus", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.status = :status")
    , @NamedQuery(name = "Todaydispensingconsumption.findByItemname", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.itemname = :itemname")
    , @NamedQuery(name = "Todaydispensingconsumption.findByDose", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.dose = :dose")
    , @NamedQuery(name = "Todaydispensingconsumption.findByItempackageid", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.itempackageid = :itempackageid")
    , @NamedQuery(name = "Todaydispensingconsumption.findByQuantitydispensed", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.quantitydispensed = :quantitydispensed")
    , @NamedQuery(name = "Todaydispensingconsumption.findByFullname", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.fullname = :fullname")
    , @NamedQuery(name = "Todaydispensingconsumption.findByDateissued", query = "SELECT t FROM Todaydispensingconsumption t WHERE t.dateissued = :dateissued")})
public class Todaydispensingconsumption implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "destinationunitid")
    @Id
    private BigInteger destinationunitid;
    @Size(max = 200)
    @Column(name = "status")
    private String status;
    @Size(max = 2147483647)
    @Column(name = "itemname")
    private String itemname;
    @Size(max = 2147483647)
    @Column(name = "dose")
    private String dose;
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "quantitydispensed")
    private BigInteger quantitydispensed;
    @Size(max = 2147483647)
    @Column(name = "fullname")
    private String fullname;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;

    public Todaydispensingconsumption() {
    }

    public BigInteger getDestinationunitid() {
        return destinationunitid;
    }

    public void setDestinationunitid(BigInteger destinationunitid) {
        this.destinationunitid = destinationunitid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }

    public BigInteger getItempackageid() {
        return itempackageid;
    }

    public void setItempackageid(BigInteger itempackageid) {
        this.itempackageid = itempackageid;
    }

    public BigInteger getQuantitydispensed() {
        return quantitydispensed;
    }

    public void setQuantitydispensed(BigInteger quantitydispensed) {
        this.quantitydispensed = quantitydispensed;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }
    
}
