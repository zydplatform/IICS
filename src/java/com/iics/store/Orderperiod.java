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
@Table(name = "orderperiod", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Orderperiod.findAll", query = "SELECT o FROM Orderperiod o")
    , @NamedQuery(name = "Orderperiod.findByOrderperiodid", query = "SELECT o FROM Orderperiod o WHERE o.orderperiodid = :orderperiodid")
    , @NamedQuery(name = "Orderperiod.findByOrderperiodname", query = "SELECT o FROM Orderperiod o WHERE o.orderperiodname = :orderperiodname")
    , @NamedQuery(name = "Orderperiod.findByStartdate", query = "SELECT o FROM Orderperiod o WHERE o.startdate = :startdate")
    , @NamedQuery(name = "Orderperiod.findByEnddate", query = "SELECT o FROM Orderperiod o WHERE o.enddate = :enddate")
    , @NamedQuery(name = "Orderperiod.findByAddedby", query = "SELECT o FROM Orderperiod o WHERE o.addedby = :addedby")
    , @NamedQuery(name = "Orderperiod.findByDateadded", query = "SELECT o FROM Orderperiod o WHERE o.dateadded = :dateadded")
    , @NamedQuery(name = "Orderperiod.findByOrderperiodtype", query = "SELECT o FROM Orderperiod o WHERE o.orderperiodtype = :orderperiodtype")
    , @NamedQuery(name = "Orderperiod.findBySetascurrent", query = "SELECT o FROM Orderperiod o WHERE o.setascurrent = :setascurrent")
    , @NamedQuery(name = "Orderperiod.findByApproved", query = "SELECT o FROM Orderperiod o WHERE o.approved = :approved")
    , @NamedQuery(name = "Orderperiod.findByProcured", query = "SELECT o FROM Orderperiod o WHERE o.procured = :procured")
    , @NamedQuery(name = "Orderperiod.findBySubmitted", query = "SELECT o FROM Orderperiod o WHERE o.submitted = :submitted")
    , @NamedQuery(name = "Orderperiod.findBySubmitcomment", query = "SELECT o FROM Orderperiod o WHERE o.submitcomment = :submitcomment")
    , @NamedQuery(name = "Orderperiod.findByIsactive", query = "SELECT o FROM Orderperiod o WHERE o.isactive = :isactive")})
public class Orderperiod implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "orderperiodid", nullable = false)
    private Integer orderperiodid;
    @Size(max = 255)
    @Column(name = "orderperiodname", length = 255)
    private String orderperiodname;
    @Column(name = "startdate")
    @Temporal(TemporalType.DATE)
    private Date startdate;
    @Column(name = "enddate")
    @Temporal(TemporalType.DATE)
    private Date enddate;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Size(max = 2147483647)
    @Column(name = "orderperiodtype", length = 2147483647)
    private String orderperiodtype;
    @Column(name = "setascurrent")
    private Boolean setascurrent;
    @Column(name = "approved")
    private Boolean approved;
    @Column(name = "procured")
    private Boolean procured;
    @Column(name = "submitted")
    private Boolean submitted;
    @Size(max = 2147483647)
    @Column(name = "submitcomment", length = 2147483647)
    private String submitcomment;
    @Column(name = "isactive")
    private Boolean isactive;
    @OneToMany(mappedBy = "orderperiodid")
    private List<Facilityprocurementplan> facilityprocurementplanList;
    @JoinColumn(name = "facilityfinancialyearid", referencedColumnName = "facilityfinancialyearid")
    @ManyToOne
    private Facilityfinancialyear facilityfinancialyearid;
    @OneToMany(mappedBy = "orderperiodid")
    private List<Facilityunitfinancialyear> facilityunitfinancialyearList;

    public Orderperiod() {
    }

    public Orderperiod(Integer orderperiodid) {
        this.orderperiodid = orderperiodid;
    }

    public Integer getOrderperiodid() {
        return orderperiodid;
    }

    public void setOrderperiodid(Integer orderperiodid) {
        this.orderperiodid = orderperiodid;
    }

    public String getOrderperiodname() {
        return orderperiodname;
    }

    public void setOrderperiodname(String orderperiodname) {
        this.orderperiodname = orderperiodname;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getEnddate() {
        return enddate;
    }

    public void setEnddate(Date enddate) {
        this.enddate = enddate;
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

    public String getOrderperiodtype() {
        return orderperiodtype;
    }

    public void setOrderperiodtype(String orderperiodtype) {
        this.orderperiodtype = orderperiodtype;
    }

    public Boolean getSetascurrent() {
        return setascurrent;
    }

    public void setSetascurrent(Boolean setascurrent) {
        this.setascurrent = setascurrent;
    }

    public Boolean getApproved() {
        return approved;
    }

    public void setApproved(Boolean approved) {
        this.approved = approved;
    }

    public Boolean getProcured() {
        return procured;
    }

    public void setProcured(Boolean procured) {
        this.procured = procured;
    }

    public Boolean getSubmitted() {
        return submitted;
    }

    public void setSubmitted(Boolean submitted) {
        this.submitted = submitted;
    }

    public String getSubmitcomment() {
        return submitcomment;
    }

    public void setSubmitcomment(String submitcomment) {
        this.submitcomment = submitcomment;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    @XmlTransient
    public List<Facilityprocurementplan> getFacilityprocurementplanList() {
        return facilityprocurementplanList;
    }

    public void setFacilityprocurementplanList(List<Facilityprocurementplan> facilityprocurementplanList) {
        this.facilityprocurementplanList = facilityprocurementplanList;
    }

    public Facilityfinancialyear getFacilityfinancialyearid() {
        return facilityfinancialyearid;
    }

    public void setFacilityfinancialyearid(Facilityfinancialyear facilityfinancialyearid) {
        this.facilityfinancialyearid = facilityfinancialyearid;
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
        hash += (orderperiodid != null ? orderperiodid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Orderperiod)) {
            return false;
        }
        Orderperiod other = (Orderperiod) object;
        if ((this.orderperiodid == null && other.orderperiodid != null) || (this.orderperiodid != null && !this.orderperiodid.equals(other.orderperiodid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Orderperiod[ orderperiodid=" + orderperiodid + " ]";
    }
    
}
