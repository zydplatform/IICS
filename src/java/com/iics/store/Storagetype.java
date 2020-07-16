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
 * @author IICS
 */
@Entity
@Table(name = "storagetype", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Storagetype.findAll", query = "SELECT s FROM Storagetype s")
    , @NamedQuery(name = "Storagetype.findByStoragetype", query = "SELECT s FROM Storagetype s WHERE s.storagetype = :storagetype")
    , @NamedQuery(name = "Storagetype.findByStoragetypename", query = "SELECT s FROM Storagetype s WHERE s.storagetypename = :storagetypename")
    , @NamedQuery(name = "Storagetype.findByAddedby", query = "SELECT s FROM Storagetype s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Storagetype.findByDateadded", query = "SELECT s FROM Storagetype s WHERE s.dateadded = :dateadded")})
public class Storagetype implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "storagetype", nullable = false)
    private Long storagetype;
    @Size(max = 50)
    @Column(name = "storagetypename", length = 50)
    private String storagetypename;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @OneToMany(mappedBy = "storagetypeid")
    private List<Zone> zoneList;

    public Storagetype() {
    }

    public Storagetype(Long storagetype) {
        this.storagetype = storagetype;
    }

    public Long getStoragetype() {
        return storagetype;
    }

    public void setStoragetype(Long storagetype) {
        this.storagetype = storagetype;
    }

    public String getStoragetypename() {
        return storagetypename;
    }

    public void setStoragetypename(String storagetypename) {
        this.storagetypename = storagetypename;
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

    @XmlTransient
    public List<Zone> getZoneList() {
        return zoneList;
    }

    public void setZoneList(List<Zone> zoneList) {
        this.zoneList = zoneList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (storagetype != null ? storagetype.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Storagetype)) {
            return false;
        }
        Storagetype other = (Storagetype) object;
        if ((this.storagetype == null && other.storagetype != null) || (this.storagetype != null && !this.storagetype.equals(other.storagetype))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Storagetype[ storagetype=" + storagetype + " ]";
    }

}
