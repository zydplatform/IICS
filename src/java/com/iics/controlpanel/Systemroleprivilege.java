/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.systemroleprivilege", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemroleprivilege.findAll", query = "SELECT s FROM Systemroleprivilege s")
    , @NamedQuery(name = "Systemroleprivilege.findBySystemroleprivilegeid", query = "SELECT s FROM Systemroleprivilege s WHERE s.systemroleprivilegeid = :systemroleprivilegeid")
    , @NamedQuery(name = "Systemroleprivilege.findBySystemroleid", query = "SELECT s FROM Systemroleprivilege s WHERE s.systemroleid = :systemroleid")
    , @NamedQuery(name = "Systemroleprivilege.findByPrivilegeid", query = "SELECT s FROM Systemroleprivilege s WHERE s.privilegeid = :privilegeid")
    , @NamedQuery(name = "Systemroleprivilege.findByActive", query = "SELECT s FROM Systemroleprivilege s WHERE s.active = :active")
    , @NamedQuery(name = "Systemroleprivilege.findByDesignationrolesid", query = "SELECT s FROM Systemroleprivilege s WHERE s.designationrolesid = :designationrolesid")})
public class Systemroleprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "systemroleprivilegeid", nullable = false)
    private Long systemroleprivilegeid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "systemroleid", nullable = false)
    private long systemroleid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "privilegeid", nullable = false)
    private long privilegeid;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "designationrolesid")
    private BigInteger designationrolesid;

    public Systemroleprivilege() {
    }

    public Systemroleprivilege(Long systemroleprivilegeid) {
        this.systemroleprivilegeid = systemroleprivilegeid;
    }

    public Systemroleprivilege(Long systemroleprivilegeid, long systemroleid, long privilegeid) {
        this.systemroleprivilegeid = systemroleprivilegeid;
        this.systemroleid = systemroleid;
        this.privilegeid = privilegeid;
    }

    public Long getSystemroleprivilegeid() {
        return systemroleprivilegeid;
    }

    public void setSystemroleprivilegeid(Long systemroleprivilegeid) {
        this.systemroleprivilegeid = systemroleprivilegeid;
    }

    public long getSystemroleid() {
        return systemroleid;
    }

    public void setSystemroleid(long systemroleid) {
        this.systemroleid = systemroleid;
    }

    public long getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(long privilegeid) {
        this.privilegeid = privilegeid;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public BigInteger getDesignationrolesid() {
        return designationrolesid;
    }

    public void setDesignationrolesid(BigInteger designationrolesid) {
        this.designationrolesid = designationrolesid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (systemroleprivilegeid != null ? systemroleprivilegeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemroleprivilege)) {
            return false;
        }
        Systemroleprivilege other = (Systemroleprivilege) object;
        if ((this.systemroleprivilegeid == null && other.systemroleprivilegeid != null) || (this.systemroleprivilegeid != null && !this.systemroleprivilegeid.equals(other.systemroleprivilegeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Systemroleprivilege[ systemroleprivilegeid=" + systemroleprivilegeid + " ]";
    }
    
}
