/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
 * @author RESEARCH
 */
@Entity
@Table(name = "systemrolefacility", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemrolefacility.findAll", query = "SELECT s FROM Systemrolefacility s")
    , @NamedQuery(name = "Systemrolefacility.findBySystemrolefacilityid", query = "SELECT s FROM Systemrolefacility s WHERE s.systemrolefacilityid = :systemrolefacilityid")
    , @NamedQuery(name = "Systemrolefacility.findBySetdate", query = "SELECT s FROM Systemrolefacility s WHERE s.setdate = :setdate")
    , @NamedQuery(name = "Systemrolefacility.findByRemovedate", query = "SELECT s FROM Systemrolefacility s WHERE s.removedate = :removedate")
    , @NamedQuery(name = "Systemrolefacility.findByStatus", query = "SELECT s FROM Systemrolefacility s WHERE s.status = :status")
    , @NamedQuery(name = "Systemrolefacility.findByIsimported", query = "SELECT s FROM Systemrolefacility s WHERE s.isimported = :isimported")})
public class Systemrolefacility implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "systemrolefacilityid", nullable = false)
    private Long systemrolefacilityid;
    @Column(name = "setdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date setdate;
    @Column(name = "removedate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date removedate;
    @Size(max = 20)
    @Column(name = "status", length = 20)
    private String status;
    @Column(name = "isimported")
    private Boolean isimported;
    @JoinColumn(name = "setby", referencedColumnName = "staffid")
    @ManyToOne
    private Staff setby;
    @JoinColumn(name = "systemroleid", referencedColumnName = "systemroleid")
    @ManyToOne
    private Systemrole systemroleid;
    @OneToMany(mappedBy = "staffpost")
    private List<Staff> staffList;

    public Systemrolefacility() {
    }

    public Systemrolefacility(Long systemrolefacilityid) {
        this.systemrolefacilityid = systemrolefacilityid;
    }

    public Long getSystemrolefacilityid() {
        return systemrolefacilityid;
    }

    public void setSystemrolefacilityid(Long systemrolefacilityid) {
        this.systemrolefacilityid = systemrolefacilityid;
    }

    public Date getSetdate() {
        return setdate;
    }

    public void setSetdate(Date setdate) {
        this.setdate = setdate;
    }

    public Date getRemovedate() {
        return removedate;
    }

    public void setRemovedate(Date removedate) {
        this.removedate = removedate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getIsimported() {
        return isimported;
    }

    public void setIsimported(Boolean isimported) {
        this.isimported = isimported;
    }

    public Staff getSetby() {
        return setby;
    }

    public void setSetby(Staff setby) {
        this.setby = setby;
    }

    public Systemrole getSystemroleid() {
        return systemroleid;
    }

    public void setSystemroleid(Systemrole systemroleid) {
        this.systemroleid = systemroleid;
    }

    @XmlTransient
    public List<Staff> getStaffList() {
        return staffList;
    }

    public void setStaffList(List<Staff> staffList) {
        this.staffList = staffList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (systemrolefacilityid != null ? systemrolefacilityid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemrolefacility)) {
            return false;
        }
        Systemrolefacility other = (Systemrolefacility) object;
        if ((this.systemrolefacilityid == null && other.systemrolefacilityid != null) || (this.systemrolefacilityid != null && !this.systemrolefacilityid.equals(other.systemrolefacilityid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Systemrolefacility[ systemrolefacilityid=" + systemrolefacilityid + " ]";
    }
    
}
