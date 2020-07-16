/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "systemroleprivilagefacility", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemroleprivilagefacility.findAll", query = "SELECT s FROM Systemroleprivilagefacility s")
    , @NamedQuery(name = "Systemroleprivilagefacility.findBySystemroleprivilagefacilityid", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.systemroleprivilagefacilityid = :systemroleprivilagefacilityid")
    , @NamedQuery(name = "Systemroleprivilagefacility.findByIsimported", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.isimported = :isimported")
    , @NamedQuery(name = "Systemroleprivilagefacility.findByRemovedate", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.removedate = :removedate")
    , @NamedQuery(name = "Systemroleprivilagefacility.findByRemovedby", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.removedby = :removedby")
    , @NamedQuery(name = "Systemroleprivilagefacility.findBySetby", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.setby = :setby")
    , @NamedQuery(name = "Systemroleprivilagefacility.findBySetdate", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.setdate = :setdate")
    , @NamedQuery(name = "Systemroleprivilagefacility.findByStatus", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.status = :status")
    , @NamedQuery(name = "Systemroleprivilagefacility.findBySystemrolefacilityid", query = "SELECT s FROM Systemroleprivilagefacility s WHERE s.systemrolefacilityid = :systemrolefacilityid")})
public class Systemroleprivilagefacility implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "systemroleprivilagefacilityid", nullable = false)
    private Long systemroleprivilagefacilityid;
    @Column(name = "isimported")
    private Boolean isimported;
    @Column(name = "removedate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date removedate;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "removedby", precision = 19, scale = 2)
    private BigDecimal removedby;
    @Column(name = "setby", precision = 19, scale = 2)
    private BigDecimal setby;
    @Column(name = "setdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date setdate;
    @Size(max = 20)
    @Column(name = "status", length = 20)
    private String status;
    @Column(name = "systemrolefacilityid", precision = 19, scale = 2)
    private BigDecimal systemrolefacilityid;

    public Systemroleprivilagefacility() {
    }

    public Systemroleprivilagefacility(Long systemroleprivilagefacilityid) {
        this.systemroleprivilagefacilityid = systemroleprivilagefacilityid;
    }

    public Long getSystemroleprivilagefacilityid() {
        return systemroleprivilagefacilityid;
    }

    public void setSystemroleprivilagefacilityid(Long systemroleprivilagefacilityid) {
        this.systemroleprivilagefacilityid = systemroleprivilagefacilityid;
    }

    public Boolean getIsimported() {
        return isimported;
    }

    public void setIsimported(Boolean isimported) {
        this.isimported = isimported;
    }

    public Date getRemovedate() {
        return removedate;
    }

    public void setRemovedate(Date removedate) {
        this.removedate = removedate;
    }

    public BigDecimal getRemovedby() {
        return removedby;
    }

    public void setRemovedby(BigDecimal removedby) {
        this.removedby = removedby;
    }

    public BigDecimal getSetby() {
        return setby;
    }

    public void setSetby(BigDecimal setby) {
        this.setby = setby;
    }

    public Date getSetdate() {
        return setdate;
    }

    public void setSetdate(Date setdate) {
        this.setdate = setdate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getSystemrolefacilityid() {
        return systemrolefacilityid;
    }

    public void setSystemrolefacilityid(BigDecimal systemrolefacilityid) {
        this.systemrolefacilityid = systemrolefacilityid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (systemroleprivilagefacilityid != null ? systemroleprivilagefacilityid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemroleprivilagefacility)) {
            return false;
        }
        Systemroleprivilagefacility other = (Systemroleprivilagefacility) object;
        if ((this.systemroleprivilagefacilityid == null && other.systemroleprivilagefacilityid != null) || (this.systemroleprivilagefacilityid != null && !this.systemroleprivilagefacilityid.equals(other.systemroleprivilagefacilityid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Systemroleprivilagefacility[ systemroleprivilagefacilityid=" + systemroleprivilagefacilityid + " ]";
    }
    
}
