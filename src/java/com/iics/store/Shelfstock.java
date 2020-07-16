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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "shelfstock", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Shelfstock.findAll", query = "SELECT s FROM Shelfstock s")
    , @NamedQuery(name = "Shelfstock.findByShelfstockid", query = "SELECT s FROM Shelfstock s WHERE s.shelfstockid = :shelfstockid")
    , @NamedQuery(name = "Shelfstock.findByQuantityshelved", query = "SELECT s FROM Shelfstock s WHERE s.quantityshelved = :quantityshelved")
    , @NamedQuery(name = "Shelfstock.findByIsstocktaken", query = "SELECT s FROM Shelfstock s WHERE s.isstocktaken = :isstocktaken")
    , @NamedQuery(name = "Shelfstock.findByUpdatedby", query = "SELECT s FROM Shelfstock s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "Shelfstock.findByDateupdated", query = "SELECT s FROM Shelfstock s WHERE s.dateupdated = :dateupdated")})
public class Shelfstock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "shelfstockid", nullable = false)
    private Long shelfstockid;
    @Column(name = "quantityshelved")
    private Integer quantityshelved;
    @Column(name = "isstocktaken")
    private Boolean isstocktaken;
    @Column(name = "updatedby")
    private Integer updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @JoinColumn(name = "cellid", referencedColumnName = "bayrowcellid")
    @ManyToOne
    private Bayrowcell cellid;
    @JoinColumn(name = "stockid", referencedColumnName = "stockid")
    @ManyToOne
    private Stock stockid;

    public Shelfstock() {
    }

    public Shelfstock(Long shelfstockid) {
        this.shelfstockid = shelfstockid;
    }

    public Long getShelfstockid() {
        return shelfstockid;
    }

    public void setShelfstockid(Long shelfstockid) {
        this.shelfstockid = shelfstockid;
    }

    public Integer getQuantityshelved() {
        return quantityshelved;
    }

    public void setQuantityshelved(Integer quantityshelved) {
        this.quantityshelved = quantityshelved;
    }

    public Boolean getIsstocktaken() {
        return isstocktaken;
    }

    public void setIsstocktaken(Boolean isstocktaken) {
        this.isstocktaken = isstocktaken;
    }

    public Integer getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Integer updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Bayrowcell getCellid() {
        return cellid;
    }

    public void setCellid(Bayrowcell cellid) {
        this.cellid = cellid;
    }

    public Stock getStockid() {
        return stockid;
    }

    public void setStockid(Stock stockid) {
        this.stockid = stockid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (shelfstockid != null ? shelfstockid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Shelfstock)) {
            return false;
        }
        Shelfstock other = (Shelfstock) object;
        if ((this.shelfstockid == null && other.shelfstockid != null) || (this.shelfstockid != null && !this.shelfstockid.equals(other.shelfstockid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Shelfstock[ shelfstockid=" + shelfstockid + " ]";
    }
    
}
