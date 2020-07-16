/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;



/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilityorderserviceref", catalog = "iics_database", schema = "supplierplatform")
@NamedQueries({
    @NamedQuery(name = "Facilityorderserviceref.findAll", query = "SELECT f FROM Facilityorderserviceref f")
    , @NamedQuery(name = "Facilityorderserviceref.findByReferenceid", query = "SELECT f FROM Facilityorderserviceref f WHERE f.referenceid = :referenceid")
    , @NamedQuery(name = "Facilityorderserviceref.findByFacilityorderid", query = "SELECT f FROM Facilityorderserviceref f WHERE f.facilityorderid = :facilityorderid")
    , @NamedQuery(name = "Facilityorderserviceref.findByApproved", query = "SELECT f FROM Facilityorderserviceref f WHERE f.approved = :approved")
    , @NamedQuery(name = "Facilityorderserviceref.findBySanctionedby", query = "SELECT f FROM Facilityorderserviceref f WHERE f.sanctionedby = :sanctionedby")
    , @NamedQuery(name = "Facilityorderserviceref.findByDatesanctioned", query = "SELECT f FROM Facilityorderserviceref f WHERE f.datesanctioned = :datesanctioned")})
public class Facilityorderserviceref implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "referenceid", nullable = false)
    private Long referenceid;
    @Basic(optional = false)
    @Column(name = "facilityorderid", nullable = false)
    private long facilityorderid;
    @Basic(optional = false)
    @Column(name = "approved", nullable = false)
    private boolean approved;
    @Basic(optional = false)
    @Column(name = "sanctionedby", nullable = false)
    private long sanctionedby;
    @Column(name = "datesanctioned")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datesanctioned;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilityorderserviceref")
    private List<Facilityorderreject> facilityorderrejectList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilityorderserviceref")
    private List<Sanctionedorderitem> sanctionedorderitemList;

    public Facilityorderserviceref() {
    }

    public Facilityorderserviceref(Long referenceid) {
        this.referenceid = referenceid;
    }

    public Facilityorderserviceref(Long referenceid, long facilityorderid, boolean approved, long sanctionedby) {
        this.referenceid = referenceid;
        this.facilityorderid = facilityorderid;
        this.approved = approved;
        this.sanctionedby = sanctionedby;
    }

    public Long getReferenceid() {
        return referenceid;
    }

    public void setReferenceid(Long referenceid) {
        this.referenceid = referenceid;
    }

    public long getFacilityorderid() {
        return facilityorderid;
    }

    public void setFacilityorderid(long facilityorderid) {
        this.facilityorderid = facilityorderid;
    }

    public boolean getApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public long getSanctionedby() {
        return sanctionedby;
    }

    public void setSanctionedby(long sanctionedby) {
        this.sanctionedby = sanctionedby;
    }

    public Date getDatesanctioned() {
        return datesanctioned;
    }

    public void setDatesanctioned(Date datesanctioned) {
        this.datesanctioned = datesanctioned;
    }

    public List<Facilityorderreject> getFacilityorderrejectList() {
        return facilityorderrejectList;
    }

    public void setFacilityorderrejectList(List<Facilityorderreject> facilityorderrejectList) {
        this.facilityorderrejectList = facilityorderrejectList;
    }

    public List<Sanctionedorderitem> getSanctionedorderitemList() {
        return sanctionedorderitemList;
    }

    public void setSanctionedorderitemList(List<Sanctionedorderitem> sanctionedorderitemList) {
        this.sanctionedorderitemList = sanctionedorderitemList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (referenceid != null ? referenceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityorderserviceref)) {
            return false;
        }
        Facilityorderserviceref other = (Facilityorderserviceref) object;
        if ((this.referenceid == null && other.referenceid != null) || (this.referenceid != null && !this.referenceid.equals(other.referenceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.SuppliersPlatform.domain.Facilityorderserviceref[ referenceid=" + referenceid + " ]";
    }
    
}
