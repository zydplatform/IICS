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
@Table(name = "facilityfinancialyear", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityfinancialyear.findAll", query = "SELECT f FROM Facilityfinancialyear f")
    , @NamedQuery(name = "Facilityfinancialyear.findByFacilityfinancialyearid", query = "SELECT f FROM Facilityfinancialyear f WHERE f.facilityfinancialyearid = :facilityfinancialyearid")
    , @NamedQuery(name = "Facilityfinancialyear.findByStatus", query = "SELECT f FROM Facilityfinancialyear f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityfinancialyear.findByStartyear", query = "SELECT f FROM Facilityfinancialyear f WHERE f.startyear = :startyear")
    , @NamedQuery(name = "Facilityfinancialyear.findByEndyear", query = "SELECT f FROM Facilityfinancialyear f WHERE f.endyear = :endyear")
    , @NamedQuery(name = "Facilityfinancialyear.findByIsthecurrent", query = "SELECT f FROM Facilityfinancialyear f WHERE f.isthecurrent = :isthecurrent")
    , @NamedQuery(name = "Facilityfinancialyear.findByDateadded", query = "SELECT f FROM Facilityfinancialyear f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityfinancialyear.findByLastupdated", query = "SELECT f FROM Facilityfinancialyear f WHERE f.lastupdated = :lastupdated")
    , @NamedQuery(name = "Facilityfinancialyear.findByAddedby", query = "SELECT f FROM Facilityfinancialyear f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityfinancialyear.findByLastupdatedby", query = "SELECT f FROM Facilityfinancialyear f WHERE f.lastupdatedby = :lastupdatedby")
    , @NamedQuery(name = "Facilityfinancialyear.findByFacilityid", query = "SELECT f FROM Facilityfinancialyear f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilityfinancialyear.findByOrderperiodtype", query = "SELECT f FROM Facilityfinancialyear f WHERE f.orderperiodtype = :orderperiodtype")
    , @NamedQuery(name = "Facilityfinancialyear.findByProccessstage", query = "SELECT f FROM Facilityfinancialyear f WHERE f.proccessstage = :proccessstage")
    , @NamedQuery(name = "Facilityfinancialyear.findByFinancialyearstartdate", query = "SELECT f FROM Facilityfinancialyear f WHERE f.financialyearstartdate = :financialyearstartdate")
    , @NamedQuery(name = "Facilityfinancialyear.findByFinancialyearenddate", query = "SELECT f FROM Facilityfinancialyear f WHERE f.financialyearenddate = :financialyearenddate")
    , @NamedQuery(name = "Facilityfinancialyear.findByProcuringopendate", query = "SELECT f FROM Facilityfinancialyear f WHERE f.procuringopendate = :procuringopendate")
    , @NamedQuery(name = "Facilityfinancialyear.findByProcuringclosedate", query = "SELECT f FROM Facilityfinancialyear f WHERE f.procuringclosedate = :procuringclosedate")
    , @NamedQuery(name = "Facilityfinancialyear.findByApprovalopendate", query = "SELECT f FROM Facilityfinancialyear f WHERE f.approvalopendate = :approvalopendate")
    , @NamedQuery(name = "Facilityfinancialyear.findByApprovalclosedate", query = "SELECT f FROM Facilityfinancialyear f WHERE f.approvalclosedate = :approvalclosedate")
    , @NamedQuery(name = "Facilityfinancialyear.findByIstopdownapproach", query = "SELECT f FROM Facilityfinancialyear f WHERE f.istopdownapproach = :istopdownapproach")})
public class Facilityfinancialyear implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityfinancialyearid", nullable = false)
    private Long facilityfinancialyearid;
    @Column(name = "status")
    private Boolean status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "startyear", nullable = false)
    private int startyear;
    @Basic(optional = false)
    @NotNull
    @Column(name = "endyear", nullable = false)
    private int endyear;
    @Column(name = "isthecurrent")
    private Boolean isthecurrent;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "lastupdatedby")
    private BigInteger lastupdatedby;
    @Column(name = "facilityid")
    private BigInteger facilityid;
    @Size(max = 2147483647)
    @Column(name = "orderperiodtype", length = 2147483647)
    private String orderperiodtype;
    @Size(max = 2147483647)
    @Column(name = "proccessstage", length = 2147483647)
    private String proccessstage;
    @Column(name = "financialyearstartdate")
    @Temporal(TemporalType.DATE)
    private Date financialyearstartdate;
    @Column(name = "financialyearenddate")
    @Temporal(TemporalType.DATE)
    private Date financialyearenddate;
    @Column(name = "procuringopendate")
    @Temporal(TemporalType.DATE)
    private Date procuringopendate;
    @Column(name = "procuringclosedate")
    @Temporal(TemporalType.DATE)
    private Date procuringclosedate;
    @Column(name = "approvalopendate")
    @Temporal(TemporalType.DATE)
    private Date approvalopendate;
    @Column(name = "approvalclosedate")
    @Temporal(TemporalType.DATE)
    private Date approvalclosedate;
    @Column(name = "istopdownapproach")
    private Boolean istopdownapproach;
    @OneToMany(mappedBy = "facilityfinancialyearid")
    private List<Orderperiod> orderperiodList;
    @OneToMany(mappedBy = "facilityfinancialyearid")
    private List<Facilityunitfinancialyear> facilityunitfinancialyearList;

    public Facilityfinancialyear() {
    }

    public Facilityfinancialyear(Long facilityfinancialyearid) {
        this.facilityfinancialyearid = facilityfinancialyearid;
    }

    public Facilityfinancialyear(Long facilityfinancialyearid, int startyear, int endyear) {
        this.facilityfinancialyearid = facilityfinancialyearid;
        this.startyear = startyear;
        this.endyear = endyear;
    }

    public Long getFacilityfinancialyearid() {
        return facilityfinancialyearid;
    }

    public void setFacilityfinancialyearid(Long facilityfinancialyearid) {
        this.facilityfinancialyearid = facilityfinancialyearid;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public int getStartyear() {
        return startyear;
    }

    public void setStartyear(int startyear) {
        this.startyear = startyear;
    }

    public int getEndyear() {
        return endyear;
    }

    public void setEndyear(int endyear) {
        this.endyear = endyear;
    }

    public Boolean getIsthecurrent() {
        return isthecurrent;
    }

    public void setIsthecurrent(Boolean isthecurrent) {
        this.isthecurrent = isthecurrent;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getLastupdated() {
        return lastupdated;
    }

    public void setLastupdated(Date lastupdated) {
        this.lastupdated = lastupdated;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public BigInteger getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(BigInteger lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    public BigInteger getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(BigInteger facilityid) {
        this.facilityid = facilityid;
    }

    public String getOrderperiodtype() {
        return orderperiodtype;
    }

    public void setOrderperiodtype(String orderperiodtype) {
        this.orderperiodtype = orderperiodtype;
    }

    public String getProccessstage() {
        return proccessstage;
    }

    public void setProccessstage(String proccessstage) {
        this.proccessstage = proccessstage;
    }

    public Date getFinancialyearstartdate() {
        return financialyearstartdate;
    }

    public void setFinancialyearstartdate(Date financialyearstartdate) {
        this.financialyearstartdate = financialyearstartdate;
    }

    public Date getFinancialyearenddate() {
        return financialyearenddate;
    }

    public void setFinancialyearenddate(Date financialyearenddate) {
        this.financialyearenddate = financialyearenddate;
    }

    public Date getProcuringopendate() {
        return procuringopendate;
    }

    public void setProcuringopendate(Date procuringopendate) {
        this.procuringopendate = procuringopendate;
    }

    public Date getProcuringclosedate() {
        return procuringclosedate;
    }

    public void setProcuringclosedate(Date procuringclosedate) {
        this.procuringclosedate = procuringclosedate;
    }

    public Date getApprovalopendate() {
        return approvalopendate;
    }

    public void setApprovalopendate(Date approvalopendate) {
        this.approvalopendate = approvalopendate;
    }

    public Date getApprovalclosedate() {
        return approvalclosedate;
    }

    public void setApprovalclosedate(Date approvalclosedate) {
        this.approvalclosedate = approvalclosedate;
    }

    public Boolean getIstopdownapproach() {
        return istopdownapproach;
    }

    public void setIstopdownapproach(Boolean istopdownapproach) {
        this.istopdownapproach = istopdownapproach;
    }

    @XmlTransient
    public List<Orderperiod> getOrderperiodList() {
        return orderperiodList;
    }

    public void setOrderperiodList(List<Orderperiod> orderperiodList) {
        this.orderperiodList = orderperiodList;
    }

    @XmlTransient
    public List<Facilityunitfinancialyear> getFacilityunitfinancialyearList() {
        return facilityunitfinancialyearList;
    }

    public void setFacilityunitfinancialyearList(List<Facilityunitfinancialyear> facilityunitfinancialyearList) {
        this.facilityunitfinancialyearList = facilityunitfinancialyearList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityfinancialyearid != null ? facilityfinancialyearid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityfinancialyear)) {
            return false;
        }
        Facilityfinancialyear other = (Facilityfinancialyear) object;
        if ((this.facilityfinancialyearid == null && other.facilityfinancialyearid != null) || (this.facilityfinancialyearid != null && !this.facilityfinancialyearid.equals(other.facilityfinancialyearid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilityfinancialyear[ facilityfinancialyearid=" + facilityfinancialyearid + " ]";
    }
    
}
