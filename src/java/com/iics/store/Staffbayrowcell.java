/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;


/**
 *
 * @author IICS
 */
@Entity
@Table(name = "staffbayrowcell", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffbayrowcell.findAll", query = "SELECT s FROM Staffbayrowcell s")
    , @NamedQuery(name = "Staffbayrowcell.findByStaffbayrowcellid", query = "SELECT s FROM Staffbayrowcell s WHERE s.staffbayrowcellid = :staffbayrowcellid")
    , @NamedQuery(name = "Staffbayrowcell.findByStaffid", query = "SELECT s FROM Staffbayrowcell s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Staffbayrowcell.findByStaffactivity", query = "SELECT s FROM Staffbayrowcell s WHERE s.staffactivity = :staffactivity")})
public class Staffbayrowcell implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "staffbayrowcellid", nullable = false)
    private Integer staffbayrowcellid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Size(max = 255)
    @Column(name = "staffactivity", length = 255)
    private String staffactivity;
    @JoinColumn(name = "bayrowcellid", referencedColumnName = "bayrowcellid")
    @ManyToOne
    private Bayrowcell bayrowcellid;
    @JoinColumn(name = "zoneid", referencedColumnName = "zoneid")
    @ManyToOne
    private Zone zoneid;

    public Staffbayrowcell() {
    }

    public Staffbayrowcell(Integer staffbayrowcellid) {
        this.staffbayrowcellid = staffbayrowcellid;
    }

    public Integer getStaffbayrowcellid() {
        return staffbayrowcellid;
    }

    public void setStaffbayrowcellid(Integer staffbayrowcellid) {
        this.staffbayrowcellid = staffbayrowcellid;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public String getStaffactivity() {
        return staffactivity;
    }

    public void setStaffactivity(String staffactivity) {
        this.staffactivity = staffactivity;
    }

    public Bayrowcell getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(Bayrowcell bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public Zone getZoneid() {
        return zoneid;
    }

    public void setZoneid(Zone zoneid) {
        this.zoneid = zoneid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffbayrowcellid != null ? staffbayrowcellid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staffbayrowcell)) {
            return false;
        }
        Staffbayrowcell other = (Staffbayrowcell) object;
        if ((this.staffbayrowcellid == null && other.staffbayrowcellid != null) || (this.staffbayrowcellid != null && !this.staffbayrowcellid.equals(other.staffbayrowcellid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Staffbayrowcell[ staffbayrowcellid=" + staffbayrowcellid + " ]";
    }
    
}
