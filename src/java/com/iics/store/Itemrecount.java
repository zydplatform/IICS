/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

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
 * @author IICS
 */
@Entity
@Table(name = "itemrecount", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemrecount.findAll", query = "SELECT i FROM Itemrecount i")
    , @NamedQuery(name = "Itemrecount.findByRecountid", query = "SELECT i FROM Itemrecount i WHERE i.recountid = :recountid")
    , @NamedQuery(name = "Itemrecount.findByItemid", query = "SELECT i FROM Itemrecount i WHERE i.itemid = :itemid")
    , @NamedQuery(name = "Itemrecount.findByStaff", query = "SELECT i FROM Itemrecount i WHERE i.staff = :staff")
    , @NamedQuery(name = "Itemrecount.findByStatus", query = "SELECT i FROM Itemrecount i WHERE i.status = :status")
    , @NamedQuery(name = "Itemrecount.findByIssuedby", query = "SELECT i FROM Itemrecount i WHERE i.issuedby = :issuedby")
    , @NamedQuery(name = "Itemrecount.findByDateissued", query = "SELECT i FROM Itemrecount i WHERE i.dateissued = :dateissued")
    , @NamedQuery(name = "Itemrecount.findByDateupdated", query = "SELECT i FROM Itemrecount i WHERE i.dateupdated = :dateupdated")
    , @NamedQuery(name = "Itemrecount.findByReviewed", query = "SELECT i FROM Itemrecount i WHERE i.reviewed = :reviewed")
    , @NamedQuery(name = "Itemrecount.findByReviewedby", query = "SELECT i FROM Itemrecount i WHERE i.reviewedby = :reviewedby")
    , @NamedQuery(name = "Itemrecount.findByActivitycellid", query = "SELECT i FROM Itemrecount i WHERE i.activitycellid = :activitycellid")
    , @NamedQuery(name = "Itemrecount.findByCellid", query = "SELECT i FROM Itemrecount i WHERE i.cellid = :cellid")
    , @NamedQuery(name = "Itemrecount.findByStockactivityid", query = "SELECT i FROM Itemrecount i WHERE i.stockactivityid = :stockactivityid")})
public class Itemrecount implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "recountid")
    private BigInteger recountid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Column(name = "staff")
    private BigInteger staff;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Column(name = "issuedby")
    private BigInteger issuedby;
    @Column(name = "dateissued")
    @Temporal(TemporalType.DATE)
    private Date dateissued;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "reviewed")
    private Boolean reviewed;
    @Column(name = "reviewedby")
    private BigInteger reviewedby;
    @Column(name = "activitycellid")
    private BigInteger activitycellid;
    @Column(name = "cellid")
    private Integer cellid;
    @Column(name = "stockactivityid")
    private BigInteger stockactivityid;

    public Itemrecount() {
    }

    public BigInteger getRecountid() {
        return recountid;
    }

    public void setRecountid(BigInteger recountid) {
        this.recountid = recountid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public BigInteger getStaff() {
        return staff;
    }

    public void setStaff(BigInteger staff) {
        this.staff = staff;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigInteger getIssuedby() {
        return issuedby;
    }

    public void setIssuedby(BigInteger issuedby) {
        this.issuedby = issuedby;
    }

    public Date getDateissued() {
        return dateissued;
    }

    public void setDateissued(Date dateissued) {
        this.dateissued = dateissued;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Boolean getReviewed() {
        return reviewed;
    }

    public void setReviewed(Boolean reviewed) {
        this.reviewed = reviewed;
    }

    public BigInteger getReviewedby() {
        return reviewedby;
    }

    public void setReviewedby(BigInteger reviewedby) {
        this.reviewedby = reviewedby;
    }

    public BigInteger getActivitycellid() {
        return activitycellid;
    }

    public void setActivitycellid(BigInteger activitycellid) {
        this.activitycellid = activitycellid;
    }

    public Integer getCellid() {
        return cellid;
    }

    public void setCellid(Integer cellid) {
        this.cellid = cellid;
    }

    public BigInteger getStockactivityid() {
        return stockactivityid;
    }

    public void setStockactivityid(BigInteger stockactivityid) {
        this.stockactivityid = stockactivityid;
    }
    
}
