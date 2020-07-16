/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;



/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "sanctionedorderitem", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Sanctionedorderitem.findAll", query = "SELECT s FROM Sanctionedorderitem s")
    , @NamedQuery(name = "Sanctionedorderitem.findBySanctionedorderitemid", query = "SELECT s FROM Sanctionedorderitem s WHERE s.sanctionedorderitemid = :sanctionedorderitemid")
    , @NamedQuery(name = "Sanctionedorderitem.findByItemid", query = "SELECT s FROM Sanctionedorderitem s WHERE s.itemid = :itemid")
    , @NamedQuery(name = "Sanctionedorderitem.findByQuantityrequested", query = "SELECT s FROM Sanctionedorderitem s WHERE s.quantityrequested = :quantityrequested")
    , @NamedQuery(name = "Sanctionedorderitem.findByQuantitysanctioned", query = "SELECT s FROM Sanctionedorderitem s WHERE s.quantitysanctioned = :quantitysanctioned")
    , @NamedQuery(name = "Sanctionedorderitem.findByQuantityserviced", query = "SELECT s FROM Sanctionedorderitem s WHERE s.quantityserviced = :quantityserviced")
    , @NamedQuery(name = "Sanctionedorderitem.findByServicedby", query = "SELECT s FROM Sanctionedorderitem s WHERE s.servicedby = :servicedby")
    , @NamedQuery(name = "Sanctionedorderitem.findByServicenote", query = "SELECT s FROM Sanctionedorderitem s WHERE s.servicenote = :servicenote")
    , @NamedQuery(name = "Sanctionedorderitem.findByCurrentunitcost", query = "SELECT s FROM Sanctionedorderitem s WHERE s.currentunitcost = :currentunitcost")
    , @NamedQuery(name = "Sanctionedorderitem.findByPacksize", query = "SELECT s FROM Sanctionedorderitem s WHERE s.packsize = :packsize")
    , @NamedQuery(name = "Sanctionedorderitem.findByQuantityrejected", query = "SELECT s FROM Sanctionedorderitem s WHERE s.quantityrejected = :quantityrejected")
    , @NamedQuery(name = "Sanctionedorderitem.findByRejectnote", query = "SELECT s FROM Sanctionedorderitem s WHERE s.rejectnote = :rejectnote")
    , @NamedQuery(name = "Sanctionedorderitem.findByPusheditem", query = "SELECT s FROM Sanctionedorderitem s WHERE s.pusheditem = :pusheditem")
    , @NamedQuery(name = "Sanctionedorderitem.findByPushnote", query = "SELECT s FROM Sanctionedorderitem s WHERE s.pushnote = :pushnote")
    , @NamedQuery(name = "Sanctionedorderitem.findByBatchnumber", query = "SELECT s FROM Sanctionedorderitem s WHERE s.batchnumber = :batchnumber")
    , @NamedQuery(name = "Sanctionedorderitem.findByExpirydate", query = "SELECT s FROM Sanctionedorderitem s WHERE s.expirydate = :expirydate")
    , @NamedQuery(name = "Sanctionedorderitem.findByStorageguidance", query = "SELECT s FROM Sanctionedorderitem s WHERE s.storageguidance = :storageguidance")
    , @NamedQuery(name = "Sanctionedorderitem.findByProgram", query = "SELECT s FROM Sanctionedorderitem s WHERE s.program = :program")})
public class Sanctionedorderitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "sanctionedorderitemid", nullable = false)
    private Long sanctionedorderitemid;
    @Basic(optional = false)
    @Column(name = "itemid", nullable = false)
    private long itemid;
    @Basic(optional = false)
    @Column(name = "quantityrequested", nullable = false)
    private double quantityrequested;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "quantitysanctioned", precision = 17, scale = 17)
    private Double quantitysanctioned;
    @Column(name = "quantityserviced", precision = 17, scale = 17)
    private Double quantityserviced;
    @Column(name = "servicedby")
    private BigInteger servicedby;
    @Column(name = "servicenote", length = 2147483647)
    private String servicenote;
    @Column(name = "currentunitcost", precision = 17, scale = 17)
    private Double currentunitcost;
    @Column(name = "packsize")
    private Integer packsize;
    @Column(name = "quantityrejected", precision = 17, scale = 17)
    private Double quantityrejected;
    @Column(name = "rejectnote", length = 2147483647)
    private String rejectnote;
    @Basic(optional = false)
    @Column(name = "pusheditem", nullable = false)
    private boolean pusheditem;
    @Column(name = "pushnote", length = 2147483647)
    private String pushnote;
    @Column(name = "batchnumber", length = 25)
    private String batchnumber;
    @Column(name = "expirydate")
    @Temporal(TemporalType.DATE)
    private Date expirydate;
    @Column(name = "storageguidance", length = 2147483647)
    private String storageguidance;
    @Column(name = "program", length = 2147483647)
    private String program;
    @JoinColumn(name = "referenceid", referencedColumnName = "referenceid", nullable = false)
    @ManyToOne(optional = false)
    private Facilityorderserviceref facilityorderserviceref;

    public Sanctionedorderitem() {
    }

    public Sanctionedorderitem(Long sanctionedorderitemid) {
        this.sanctionedorderitemid = sanctionedorderitemid;
    }

    public Sanctionedorderitem(Long sanctionedorderitemid, long itemid, double quantityrequested, boolean pusheditem) {
        this.sanctionedorderitemid = sanctionedorderitemid;
        this.itemid = itemid;
        this.quantityrequested = quantityrequested;
        this.pusheditem = pusheditem;
    }

    public Long getSanctionedorderitemid() {
        return sanctionedorderitemid;
    }

    public void setSanctionedorderitemid(Long sanctionedorderitemid) {
        this.sanctionedorderitemid = sanctionedorderitemid;
    }

    public long getItemid() {
        return itemid;
    }

    public void setItemid(long itemid) {
        this.itemid = itemid;
    }

    public double getQuantityrequested() {
        return quantityrequested;
    }

    public void setQuantityrequested(double quantityrequested) {
        this.quantityrequested = quantityrequested;
    }

    public Double getQuantitysanctioned() {
        return quantitysanctioned;
    }

    public void setQuantitysanctioned(Double quantitysanctioned) {
        this.quantitysanctioned = quantitysanctioned;
    }

    public Double getQuantityserviced() {
        return quantityserviced;
    }

    public void setQuantityserviced(Double quantityserviced) {
        this.quantityserviced = quantityserviced;
    }

    public BigInteger getServicedby() {
        return servicedby;
    }

    public void setServicedby(BigInteger servicedby) {
        this.servicedby = servicedby;
    }

    public String getServicenote() {
        return servicenote;
    }

    public void setServicenote(String servicenote) {
        this.servicenote = servicenote;
    }

    public Double getCurrentunitcost() {
        return currentunitcost;
    }

    public void setCurrentunitcost(Double currentunitcost) {
        this.currentunitcost = currentunitcost;
    }

    public Integer getPacksize() {
        return packsize;
    }

    public void setPacksize(Integer packsize) {
        this.packsize = packsize;
    }

    public Double getQuantityrejected() {
        return quantityrejected;
    }

    public void setQuantityrejected(Double quantityrejected) {
        this.quantityrejected = quantityrejected;
    }

    public String getRejectnote() {
        return rejectnote;
    }

    public void setRejectnote(String rejectnote) {
        this.rejectnote = rejectnote;
    }

    public boolean getPusheditem() {
        return pusheditem;
    }

    public void setPusheditem(boolean pusheditem) {
        this.pusheditem = pusheditem;
    }

    public String getPushnote() {
        return pushnote;
    }

    public void setPushnote(String pushnote) {
        this.pushnote = pushnote;
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

    public String getStorageguidance() {
        return storageguidance;
    }

    public void setStorageguidance(String storageguidance) {
        this.storageguidance = storageguidance;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public Facilityorderserviceref getFacilityorderserviceref() {
        return facilityorderserviceref;
    }

    public void setFacilityorderserviceref(Facilityorderserviceref facilityorderserviceref) {
        this.facilityorderserviceref = facilityorderserviceref;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (sanctionedorderitemid != null ? sanctionedorderitemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sanctionedorderitem)) {
            return false;
        }
        Sanctionedorderitem other = (Sanctionedorderitem) object;
        if ((this.sanctionedorderitemid == null && other.sanctionedorderitemid != null) || (this.sanctionedorderitemid != null && !this.sanctionedorderitemid.equals(other.sanctionedorderitemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Sanctionedorderitem[ sanctionedorderitemid=" + sanctionedorderitemid + " ]";
    }
    
}
