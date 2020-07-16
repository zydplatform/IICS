/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
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
@Table(name = "recountitem", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Recountitem.findAll", query = "SELECT r FROM Recountitem r")
    , @NamedQuery(name = "Recountitem.findByRecountitemid", query = "SELECT r FROM Recountitem r WHERE r.recountitemid = :recountitemid")
    , @NamedQuery(name = "Recountitem.findByCountedstock", query = "SELECT r FROM Recountitem r WHERE r.countedstock = :countedstock")
    , @NamedQuery(name = "Recountitem.findByStatus", query = "SELECT r FROM Recountitem r WHERE r.status = :status")
    , @NamedQuery(name = "Recountitem.findByBatchnumber", query = "SELECT r FROM Recountitem r WHERE r.batchnumber = :batchnumber")
    , @NamedQuery(name = "Recountitem.findByExpirydate", query = "SELECT r FROM Recountitem r WHERE r.expirydate = :expirydate")
    , @NamedQuery(name = "Recountitem.findByDateadded", query = "SELECT r FROM Recountitem r WHERE r.dateadded = :dateadded")})
public class Recountitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "recountitemid", nullable = false)
    private Long recountitemid;
    @Column(name = "countedstock")
    private Integer countedstock;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Size(max = 255)
    @Column(name = "batchnumber", length = 255)
    private String batchnumber;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @JoinColumn(name = "recountid", referencedColumnName = "recountid")
    @ManyToOne
    private Recount recountid;

    public Recountitem() {
    }

    public Recountitem(Long recountitemid) {
        this.recountitemid = recountitemid;
    }

    public Long getRecountitemid() {
        return recountitemid;
    }

    public void setRecountitemid(Long recountitemid) {
        this.recountitemid = recountitemid;
    }

    public Integer getCountedstock() {
        return countedstock;
    }

    public void setCountedstock(Integer countedstock) {
        this.countedstock = countedstock;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }

    public Date getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(Date expirydate) {
        this.expirydate = expirydate;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Recount getRecountid() {
        return recountid;
    }

    public void setRecountid(Recount recountid) {
        this.recountid = recountid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (recountitemid != null ? recountitemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Recountitem)) {
            return false;
        }
        Recountitem other = (Recountitem) object;
        if ((this.recountitemid == null && other.recountitemid != null) || (this.recountitemid != null && !this.recountitemid.equals(other.recountitemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Recountitem[ recountitemid=" + recountitemid + " ]";
    }
    
}
