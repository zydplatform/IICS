/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "recount", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Recount.findAll", query = "SELECT r FROM Recount r")
    , @NamedQuery(name = "Recount.findByRecountid", query = "SELECT r FROM Recount r WHERE r.recountid = :recountid")
    , @NamedQuery(name = "Recount.findByStaff", query = "SELECT r FROM Recount r WHERE r.staff = :staff")
    , @NamedQuery(name = "Recount.findByStatus", query = "SELECT r FROM Recount r WHERE r.status = :status")
    , @NamedQuery(name = "Recount.findByIssuedby", query = "SELECT r FROM Recount r WHERE r.issuedby = :issuedby")
    , @NamedQuery(name = "Recount.findByDateissued", query = "SELECT r FROM Recount r WHERE r.dateissued = :dateissued")
    , @NamedQuery(name = "Recount.findByDateupdated", query = "SELECT r FROM Recount r WHERE r.dateupdated = :dateupdated")
    , @NamedQuery(name = "Recount.findByReviewed", query = "SELECT r FROM Recount r WHERE r.reviewed = :reviewed")
    , @NamedQuery(name = "Recount.findByReviewedby", query = "SELECT r FROM Recount r WHERE r.reviewedby = :reviewedby")})
public class Recount implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "recountid", nullable = false)
    private Long recountid;
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
    @OneToMany(mappedBy = "recountid")
    private List<Recountitem> recountitemList;
    @JoinColumn(name = "activitycellid", referencedColumnName = "activitycellid")
    @ManyToOne
    private Activitycell activitycellid;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;

    public Recount() {
    }

    public Recount(Long recountid) {
        this.recountid = recountid;
    }

    public Long getRecountid() {
        return recountid;
    }

    public void setRecountid(Long recountid) {
        this.recountid = recountid;
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

    @XmlTransient
    public List<Recountitem> getRecountitemList() {
        return recountitemList;
    }

    public void setRecountitemList(List<Recountitem> recountitemList) {
        this.recountitemList = recountitemList;
    }

    public Activitycell getActivitycellid() {
        return activitycellid;
    }

    public void setActivitycellid(Activitycell activitycellid) {
        this.activitycellid = activitycellid;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (recountid != null ? recountid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Recount)) {
            return false;
        }
        Recount other = (Recount) object;
        if ((this.recountid == null && other.recountid != null) || (this.recountid != null && !this.recountid.equals(other.recountid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Recount[ recountid=" + recountid + " ]";
    }
    
}
