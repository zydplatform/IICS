/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.scheduleplan;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "service", catalog = "iics_database", schema = "scheduleplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Service.findAll", query = "SELECT s FROM Service s")
    , @NamedQuery(name = "Service.findByServiceid", query = "SELECT s FROM Service s WHERE s.serviceid = :serviceid")
    , @NamedQuery(name = "Service.findByServicename", query = "SELECT s FROM Service s WHERE s.servicename = :servicename")
    , @NamedQuery(name = "Service.findByFacilityunitid", query = "SELECT s FROM Service s WHERE s.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Service.findByDateadded", query = "SELECT s FROM Service s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Service.findByAddedby", query = "SELECT s FROM Service s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Service.findByDateupdated", query = "SELECT s FROM Service s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Service.findByUpdatedby", query = "SELECT s FROM Service s WHERE s.updatedby = :updatedby")})
public class Service implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "serviceid", nullable = false)
    private Long serviceid;
    @Size(max = 255)
    @Column(name = "servicename", length = 255)
    private String servicename;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "service1")
    private Service service;
    @JoinColumn(name = "serviceid", referencedColumnName = "serviceid", nullable = false, insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Service service1;
    @OneToMany(mappedBy = "serviceid")
    private List<Servicedayplan> servicedayplanList;

    public Service() {
    }

    public Service(Long serviceid) {
        this.serviceid = serviceid;
    }

    public Long getServiceid() {
        return serviceid;
    }

    public void setServiceid(Long serviceid) {
        this.serviceid = serviceid;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public Service getService1() {
        return service1;
    }

    public void setService1(Service service1) {
        this.service1 = service1;
    }
    public List<Servicedayplan> getServicedayplanList() {
        return servicedayplanList;
    }

    public void setServicedayplanList(List<Servicedayplan> servicedayplanList) {
        this.servicedayplanList = servicedayplanList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (serviceid != null ? serviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Service)) {
            return false;
        }
        Service other = (Service) object;
        if ((this.serviceid == null && other.serviceid != null) || (this.serviceid != null && !this.serviceid.equals(other.serviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.scheduleplan.Service[ serviceid=" + serviceid + " ]";
    }
    
}
