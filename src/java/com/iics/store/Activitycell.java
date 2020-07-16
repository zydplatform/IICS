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
@Table(name = "activitycell", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Activitycell.findAll", query = "SELECT a FROM Activitycell a")
    , @NamedQuery(name = "Activitycell.findByActivitycellid", query = "SELECT a FROM Activitycell a WHERE a.activitycellid = :activitycellid")
    , @NamedQuery(name = "Activitycell.findByCellstaff", query = "SELECT a FROM Activitycell a WHERE a.cellstaff = :cellstaff")
    , @NamedQuery(name = "Activitycell.findByActivitystatus", query = "SELECT a FROM Activitycell a WHERE a.activitystatus = :activitystatus")
    , @NamedQuery(name = "Activitycell.findByAddedby", query = "SELECT a FROM Activitycell a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Activitycell.findByDateadded", query = "SELECT a FROM Activitycell a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Activitycell.findByDateupdated", query = "SELECT a FROM Activitycell a WHERE a.dateupdated = :dateupdated")
    , @NamedQuery(name = "Activitycell.findByUpdatedby", query = "SELECT a FROM Activitycell a WHERE a.updatedby = :updatedby")
    , @NamedQuery(name = "Activitycell.findByRecount", query = "SELECT a FROM Activitycell a WHERE a.recount = :recount")
    , @NamedQuery(name = "Activitycell.findByClosed", query = "SELECT a FROM Activitycell a WHERE a.closed = :closed")
    , @NamedQuery(name = "Activitycell.findByClosedby", query = "SELECT a FROM Activitycell a WHERE a.closedby = :closedby")})
public class Activitycell implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "activitycellid", nullable = false)
    private Long activitycellid;
    @Column(name = "cellstaff")
    private BigInteger cellstaff;
    @Size(max = 255)
    @Column(name = "activitystatus", length = 255)
    private String activitystatus;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "recount")
    private Boolean recount;
    @Column(name = "closed")
    private Boolean closed;
    @Column(name = "closedby")
    private BigInteger closedby;
    @OneToMany(mappedBy = "activitycellid")
    private List<Activitycellitem> activitycellitemList;
    @OneToMany(mappedBy = "activitycellid")
    private List<Recount> recountList;
    @JoinColumn(name = "cellid", referencedColumnName = "bayrowcellid")
    @ManyToOne
    private Bayrowcell cellid;
    @JoinColumn(name = "stockactivityid", referencedColumnName = "stockactivityid")
    @ManyToOne
    private Stockactivity stockactivityid;

    public Activitycell() {
    }

    public Activitycell(Long activitycellid) {
        this.activitycellid = activitycellid;
    }

    public Long getActivitycellid() {
        return activitycellid;
    }

    public void setActivitycellid(Long activitycellid) {
        this.activitycellid = activitycellid;
    }

    public BigInteger getCellstaff() {
        return cellstaff;
    }

    public void setCellstaff(BigInteger cellstaff) {
        this.cellstaff = cellstaff;
    }

    public String getActivitystatus() {
        return activitystatus;
    }

    public void setActivitystatus(String activitystatus) {
        this.activitystatus = activitystatus;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
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

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Boolean getRecount() {
        return recount;
    }

    public void setRecount(Boolean recount) {
        this.recount = recount;
    }

    public Boolean getClosed() {
        return closed;
    }

    public void setClosed(Boolean closed) {
        this.closed = closed;
    }

    public BigInteger getClosedby() {
        return closedby;
    }

    public void setClosedby(BigInteger closedby) {
        this.closedby = closedby;
    }

    @XmlTransient
    public List<Activitycellitem> getActivitycellitemList() {
        return activitycellitemList;
    }

    public void setActivitycellitemList(List<Activitycellitem> activitycellitemList) {
        this.activitycellitemList = activitycellitemList;
    }

    @XmlTransient
    public List<Recount> getRecountList() {
        return recountList;
    }

    public void setRecountList(List<Recount> recountList) {
        this.recountList = recountList;
    }

    public Bayrowcell getCellid() {
        return cellid;
    }

    public void setCellid(Bayrowcell cellid) {
        this.cellid = cellid;
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
        hash += (activitycellid != null ? activitycellid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Activitycell)) {
            return false;
        }
        Activitycell other = (Activitycell) object;
        if ((this.activitycellid == null && other.activitycellid != null) || (this.activitycellid != null && !this.activitycellid.equals(other.activitycellid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Activitycell[ activitycellid=" + activitycellid + " ]";
    }
    
}
