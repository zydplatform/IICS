/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "bayrowcell", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Bayrowcell.findAll", query = "SELECT b FROM Bayrowcell b")
    , @NamedQuery(name = "Bayrowcell.findByBayrowcellid", query = "SELECT b FROM Bayrowcell b WHERE b.bayrowcellid = :bayrowcellid")
    , @NamedQuery(name = "Bayrowcell.findByCelllabel", query = "SELECT b FROM Bayrowcell b WHERE b.celllabel = :celllabel")
    , @NamedQuery(name = "Bayrowcell.findByCellstate", query = "SELECT b FROM Bayrowcell b WHERE b.cellstate = :cellstate")
    , @NamedQuery(name = "Bayrowcell.findByStoragetypeid", query = "SELECT b FROM Bayrowcell b WHERE b.storagetypeid = :storagetypeid")
    , @NamedQuery(name = "Bayrowcell.findByCelltranslimit", query = "SELECT b FROM Bayrowcell b WHERE b.celltranslimit = :celltranslimit")})
public class Bayrowcell implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "bayrowcellid", nullable = false)
    private Integer bayrowcellid;
    @Size(max = 255)
    @Column(name = "celllabel", length = 255)
    private String celllabel;
    @Basic(optional = false)
    @NotNull
    @Column(name = "cellstate", nullable = false)
    private boolean cellstate;
    @Column(name = "storagetypeid")
    private Long storagetypeid;
    @Column(name = "celltranslimit")
    private BigInteger celltranslimit;
    @OneToMany(mappedBy = "bayrowcellid")
    private List<Staffbayrowcell> staffbayrowcellList;
    @JoinColumn(name = "bayrowid", referencedColumnName = "bayrowid")
    @ManyToOne
    private Bayrow bayrowid;
    @OneToMany(mappedBy = "cellid")
    private List<Activitycell> activitycellList;
    @OneToMany(mappedBy = "cellid")
    private List<Shelflog> shelflogList;
    @OneToMany(mappedBy = "cellid")
    private List<Shelfstock> shelfstockList;
    @Column(name = "isolated")
    private boolean isolated;

    public Bayrowcell() {
    }

    public Bayrowcell(Integer bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public Bayrowcell(Integer bayrowcellid, boolean cellstate) {
        this.bayrowcellid = bayrowcellid;
        this.cellstate = cellstate;
    }

    public Integer getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(Integer bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public String getCelllabel() {
        return celllabel;
    }

    public void setCelllabel(String celllabel) {
        this.celllabel = celllabel;
    }

    public boolean getCellstate() {
        return cellstate;
    }

    public void setCellstate(boolean cellstate) {
        this.cellstate = cellstate;
    }

    public Long getStoragetypeid() {
        return storagetypeid;
    }

    public void setStoragetypeid(Long storagetypeid) {
        this.storagetypeid = storagetypeid;
    }

    public BigInteger getCelltranslimit() {
        return celltranslimit;
    }

    public void setCelltranslimit(BigInteger celltranslimit) {
        this.celltranslimit = celltranslimit;
    }

    @XmlTransient
    public List<Staffbayrowcell> getStaffbayrowcellList() {
        return staffbayrowcellList;
    }

    public void setStaffbayrowcellList(List<Staffbayrowcell> staffbayrowcellList) {
        this.staffbayrowcellList = staffbayrowcellList;
    }

    public Bayrow getBayrowid() {
        return bayrowid;
    }

    public void setBayrowid(Bayrow bayrowid) {
        this.bayrowid = bayrowid;
    }

    @XmlTransient
    public List<Activitycell> getActivitycellList() {
        return activitycellList;
    }

    public void setActivitycellList(List<Activitycell> activitycellList) {
        this.activitycellList = activitycellList;
    }

    @XmlTransient
    public List<Shelflog> getShelflogList() {
        return shelflogList;
    }

    public void setShelflogList(List<Shelflog> shelflogList) {
        this.shelflogList = shelflogList;
    }

    @XmlTransient
    public List<Shelfstock> getShelfstockList() {
        return shelfstockList;
    }

    public void setShelfstockList(List<Shelfstock> shelfstockList) {
        this.shelfstockList = shelfstockList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (bayrowcellid != null ? bayrowcellid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Bayrowcell)) {
            return false;
        }
        Bayrowcell other = (Bayrowcell) object;
        if ((this.bayrowcellid == null && other.bayrowcellid != null) || (this.bayrowcellid != null && !this.bayrowcellid.equals(other.bayrowcellid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Bayrowcell[ bayrowcellid=" + bayrowcellid + " ]";
    }

    public boolean isIsolated() {
        return isolated;
    }

    public void setIsolated(boolean isolated) {
        this.isolated = isolated;
    }
    
}
