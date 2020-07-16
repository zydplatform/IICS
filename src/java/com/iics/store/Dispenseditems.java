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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "dispenseditems", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Dispenseditems.findAll", query = "SELECT d FROM Dispenseditems d")
    , @NamedQuery(name = "Dispenseditems.findByDispenseditemsid", query = "SELECT d FROM Dispenseditems d WHERE d.dispenseditemsid = :dispenseditemsid")
    , @NamedQuery(name = "Dispenseditems.findByQuantitydispensed", query = "SELECT d FROM Dispenseditems d WHERE d.quantitydispensed = :quantitydispensed")})
public class Dispenseditems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "dispenseditemsid", nullable = false)
    private Long dispenseditemsid;
    @Column(name = "quantitydispensed")
    private Integer quantitydispensed;
    @Column(name = "prescriptionissueid")
    private Long prescriptionissueid;
    @Column(name = "stockid")
    private Long stockid;

    public Dispenseditems() {
    }

    public Dispenseditems(Long dispenseditemsid) {
        this.dispenseditemsid = dispenseditemsid;
    }

    public Long getDispenseditemsid() {
        return dispenseditemsid;
    }

    public void setDispenseditemsid(Long dispenseditemsid) {
        this.dispenseditemsid = dispenseditemsid;
    }

    public Integer getQuantitydispensed() {
        return quantitydispensed;
    }

    public void setQuantitydispensed(Integer quantitydispensed) {
        this.quantitydispensed = quantitydispensed;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (dispenseditemsid != null ? dispenseditemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Dispenseditems)) {
            return false;
        }
        Dispenseditems other = (Dispenseditems) object;
        if ((this.dispenseditemsid == null && other.dispenseditemsid != null) || (this.dispenseditemsid != null && !this.dispenseditemsid.equals(other.dispenseditemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Dispenseditems[ dispenseditemsid=" + dispenseditemsid + " ]";
    }

    public Long getPrescriptionissueid() {
        return prescriptionissueid;
    }

    public void setPrescriptionissueid(Long prescriptionissueid) {
        this.prescriptionissueid = prescriptionissueid;
    }

    public Long getStockid() {
        return stockid;
    }

    public void setStockid(Long stockid) {
        this.stockid = stockid;
    }
    
}
