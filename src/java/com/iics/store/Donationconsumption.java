/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "donationconsumption", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Donationconsumption.findAll", query = "SELECT d FROM Donationconsumption d")
    , @NamedQuery(name = "Donationconsumption.findByDonationconsumptionid", query = "SELECT d FROM Donationconsumption d WHERE d.donationconsumptionid = :donationconsumptionid")
    , @NamedQuery(name = "Donationconsumption.findByHandedoverto", query = "SELECT d FROM Donationconsumption d WHERE d.handedoverto = :handedoverto")
    , @NamedQuery(name = "Donationconsumption.findByQtyhandedover", query = "SELECT d FROM Donationconsumption d WHERE d.qtyhandedover = :qtyhandedover")
    , @NamedQuery(name = "Donationconsumption.findByHandoverdate", query = "SELECT d FROM Donationconsumption d WHERE d.handoverdate = :handoverdate")
    , @NamedQuery(name = "Donationconsumption.findByConsumerunit", query = "SELECT d FROM Donationconsumption d WHERE d.consumerunit = :consumerunit")
    , @NamedQuery(name = "Donationconsumption.findByHandoverunit", query = "SELECT d FROM Donationconsumption d WHERE d.handoverunit = :handoverunit")
    , @NamedQuery(name = "Donationconsumption.findByQtydelivered", query = "SELECT d FROM Donationconsumption d WHERE d.qtydelivered = :qtydelivered")
    , @NamedQuery(name = "Donationconsumption.findByIsdelivered", query = "SELECT d FROM Donationconsumption d WHERE d.isdelivered = :isdelivered")
    , @NamedQuery(name = "Donationconsumption.findByDatedelivered", query = "SELECT d FROM Donationconsumption d WHERE d.datedelivered = :datedelivered")
    , @NamedQuery(name = "Donationconsumption.findByDeliveredto", query = "SELECT d FROM Donationconsumption d WHERE d.deliveredto = :deliveredto")
    , @NamedQuery(name = "Donationconsumption.findByDeliveredfrom", query = "SELECT d FROM Donationconsumption d WHERE d.deliveredfrom = :deliveredfrom")})
public class Donationconsumption implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "donationconsumptionid", nullable = false)
    private Integer donationconsumptionid;
    @Column(name = "handedoverto")
    private BigInteger handedoverto;
    @Column(name = "qtyhandedover")
    private Integer qtyhandedover;
    @Column(name = "handoverdate")
    @Temporal(TemporalType.DATE)
    private Date handoverdate;
    @Column(name = "consumerunit")
    private BigInteger consumerunit;
    @Column(name = "handoverunit")
    private BigInteger handoverunit;
    @Column(name = "qtydelivered")
    private Integer qtydelivered;
    @Column(name = "isdelivered")
    private Boolean isdelivered;
    @Column(name = "datedelivered")
    @Temporal(TemporalType.DATE)
    private Date datedelivered;
    @Column(name = "deliveredto")
    private Long deliveredto;
    @Column(name = "deliveredfrom")
    private Long deliveredfrom;
    @Column(name = "donationsitemsid")
    private Integer donationsitemsid;

    public Donationconsumption() {
    }

    public Donationconsumption(Integer donationconsumptionid) {
        this.donationconsumptionid = donationconsumptionid;
    }

    public Integer getDonationconsumptionid() {
        return donationconsumptionid;
    }

    public void setDonationconsumptionid(Integer donationconsumptionid) {
        this.donationconsumptionid = donationconsumptionid;
    }

    public BigInteger getHandedoverto() {
        return handedoverto;
    }

    public void setHandedoverto(BigInteger handedoverto) {
        this.handedoverto = handedoverto;
    }

    public Integer getQtyhandedover() {
        return qtyhandedover;
    }

    public void setQtyhandedover(Integer qtyhandedover) {
        this.qtyhandedover = qtyhandedover;
    }

    public Date getHandoverdate() {
        return handoverdate;
    }

    public void setHandoverdate(Date handoverdate) {
        this.handoverdate = handoverdate;
    }

    public BigInteger getConsumerunit() {
        return consumerunit;
    }

    public void setConsumerunit(BigInteger consumerunit) {
        this.consumerunit = consumerunit;
    }

    public BigInteger getHandoverunit() {
        return handoverunit;
    }

    public void setHandoverunit(BigInteger handoverunit) {
        this.handoverunit = handoverunit;
    }

    public Integer getQtydelivered() {
        return qtydelivered;
    }

    public void setQtydelivered(Integer qtydelivered) {
        this.qtydelivered = qtydelivered;
    }

    public Boolean getIsdelivered() {
        return isdelivered;
    }

    public void setIsdelivered(Boolean isdelivered) {
        this.isdelivered = isdelivered;
    }

    public Date getDatedelivered() {
        return datedelivered;
    }

    public void setDatedelivered(Date datedelivered) {
        this.datedelivered = datedelivered;
    }

    public Long getDeliveredto() {
        return deliveredto;
    }

    public void setDeliveredto(Long deliveredto) {
        this.deliveredto = deliveredto;
    }

    public Long getDeliveredfrom() {
        return deliveredfrom;
    }

    public void setDeliveredfrom(Long deliveredfrom) {
        this.deliveredfrom = deliveredfrom;
    }

    public Integer getDonationsitemsid() {
        return donationsitemsid;
    }

    public void setDonationsitemsid(Integer donationsitemsid) {
        this.donationsitemsid = donationsitemsid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (donationconsumptionid != null ? donationconsumptionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Donationconsumption)) {
            return false;
        }
        Donationconsumption other = (Donationconsumption) object;
        if ((this.donationconsumptionid == null && other.donationconsumptionid != null) || (this.donationconsumptionid != null && !this.donationconsumptionid.equals(other.donationconsumptionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Donationconsumption[ donationconsumptionid=" + donationconsumptionid + " ]";
    }

}
