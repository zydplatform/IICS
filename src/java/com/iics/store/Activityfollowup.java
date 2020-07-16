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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "activityfollowup", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Activityfollowup.findAll", query = "SELECT a FROM Activityfollowup a")
    , @NamedQuery(name = "Activityfollowup.findByActivityfollowupid", query = "SELECT a FROM Activityfollowup a WHERE a.activityfollowupid = :activityfollowupid")
    , @NamedQuery(name = "Activityfollowup.findByBatchno", query = "SELECT a FROM Activityfollowup a WHERE a.batchno = :batchno")
    , @NamedQuery(name = "Activityfollowup.findByFollowupaction", query = "SELECT a FROM Activityfollowup a WHERE a.followupaction = :followupaction")
    , @NamedQuery(name = "Activityfollowup.findByFollowupcomment", query = "SELECT a FROM Activityfollowup a WHERE a.followupcomment = :followupcomment")
    , @NamedQuery(name = "Activityfollowup.findByDateadded", query = "SELECT a FROM Activityfollowup a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Activityfollowup.findByAddedby", query = "SELECT a FROM Activityfollowup a WHERE a.addedby = :addedby")})
public class Activityfollowup implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "activityfollowupid", nullable = false)
    private Long activityfollowupid;
    @Size(max = 255)
    @Column(name = "batchno", length = 255)
    private String batchno;
    @Size(max = 255)
    @Column(name = "followupaction", length = 255)
    private String followupaction;
    @Size(max = 2147483647)
    @Column(name = "followupcomment", length = 2147483647)
    private String followupcomment;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;
    @JoinColumn(name = "stockactivityid", referencedColumnName = "stockactivityid")
    @ManyToOne
    private Stockactivity stockactivityid;

    public Activityfollowup() {
    }

    public Activityfollowup(Long activityfollowupid) {
        this.activityfollowupid = activityfollowupid;
    }

    public Long getActivityfollowupid() {
        return activityfollowupid;
    }

    public void setActivityfollowupid(Long activityfollowupid) {
        this.activityfollowupid = activityfollowupid;
    }

    public String getBatchno() {
        return batchno;
    }

    public void setBatchno(String batchno) {
        this.batchno = batchno;
    }

    public String getFollowupaction() {
        return followupaction;
    }

    public void setFollowupaction(String followupaction) {
        this.followupaction = followupaction;
    }

    public String getFollowupcomment() {
        return followupcomment;
    }

    public void setFollowupcomment(String followupcomment) {
        this.followupcomment = followupcomment;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    public Stockactivity getStockactivityid() {
        return stockactivityid;
    }

    public void setStockactivityid(Stockactivity stockactivityid) {
        this.stockactivityid = stockactivityid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (activityfollowupid != null ? activityfollowupid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Activityfollowup)) {
            return false;
        }
        Activityfollowup other = (Activityfollowup) object;
        if ((this.activityfollowupid == null && other.activityfollowupid != null) || (this.activityfollowupid != null && !this.activityfollowupid.equals(other.activityfollowupid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Activityfollowup[ activityfollowupid=" + activityfollowupid + " ]";
    }
    
}
