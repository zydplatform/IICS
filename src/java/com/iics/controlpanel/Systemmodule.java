/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.systemmodule", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemmodule.findAll", query = "SELECT s FROM Systemmodule s")
    , @NamedQuery(name = "Systemmodule.findBySystemmoduleid", query = "SELECT s FROM Systemmodule s WHERE s.systemmoduleid = :systemmoduleid")
    , @NamedQuery(name = "Systemmodule.findByComponentname", query = "SELECT s FROM Systemmodule s WHERE s.componentname = :componentname")
    , @NamedQuery(name = "Systemmodule.findByDescription", query = "SELECT s FROM Systemmodule s WHERE s.description = :description")
    , @NamedQuery(name = "Systemmodule.findByStatus", query = "SELECT s FROM Systemmodule s WHERE s.status = :status")
    , @NamedQuery(name = "Systemmodule.findByDateadded", query = "SELECT s FROM Systemmodule s WHERE s.dateadded = :dateadded")
    , @NamedQuery(name = "Systemmodule.findByAddedby", query = "SELECT s FROM Systemmodule s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Systemmodule.findByUpdatedby", query = "SELECT s FROM Systemmodule s WHERE s.updatedby = :updatedby")
    , @NamedQuery(name = "Systemmodule.findByDateupdated", query = "SELECT s FROM Systemmodule s WHERE s.dateupdated = :dateupdated")
    , @NamedQuery(name = "Systemmodule.findByPrivilegeid", query = "SELECT s FROM Systemmodule s WHERE s.privilegeid = :privilegeid")
    , @NamedQuery(name = "Systemmodule.findByHasprivilege", query = "SELECT s FROM Systemmodule s WHERE s.hasprivilege = :hasprivilege")
    , @NamedQuery(name = "Systemmodule.findByActivity", query = "SELECT s FROM Systemmodule s WHERE s.activity = :activity")})
public class Systemmodule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "systemmoduleid", nullable = false)
    private Long systemmoduleid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "componentname", nullable = false, length = 2147483647)
    private String componentname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "description", nullable = false, length = 2147483647)
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status", nullable = false)
    private boolean status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby", nullable = false)
    private long addedby;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "privilegeid")
    private BigInteger privilegeid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "hasprivilege", nullable = false)
    private boolean hasprivilege;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "activity", nullable = false, length = 2147483647)
    private String activity;
    @OneToMany(mappedBy = "parentid")
    private List<Systemmodule> systemmoduleList;
    @JoinColumn(name = "parentid", referencedColumnName = "systemmoduleid")
    @ManyToOne
    private Systemmodule parentid;

    public Systemmodule() {
    }

    public Systemmodule(Long systemmoduleid) {
        this.systemmoduleid = systemmoduleid;
    }

    public Systemmodule(Long systemmoduleid, String componentname, String description, boolean status, Date dateadded, long addedby, boolean hasprivilege, String activity) {
        this.systemmoduleid = systemmoduleid;
        this.componentname = componentname;
        this.description = description;
        this.status = status;
        this.dateadded = dateadded;
        this.addedby = addedby;
        this.hasprivilege = hasprivilege;
        this.activity = activity;
    }

    public Long getSystemmoduleid() {
        return systemmoduleid;
    }

    public void setSystemmoduleid(Long systemmoduleid) {
        this.systemmoduleid = systemmoduleid;
    }

    public String getComponentname() {
        return componentname;
    }

    public void setComponentname(String componentname) {
        this.componentname = componentname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public BigInteger getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(BigInteger privilegeid) {
        this.privilegeid = privilegeid;
    }

    public boolean getHasprivilege() {
        return hasprivilege;
    }

    public void setHasprivilege(boolean hasprivilege) {
        this.hasprivilege = hasprivilege;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    @XmlTransient
    public List<Systemmodule> getSystemmoduleList() {
        return systemmoduleList;
    }

    public void setSystemmoduleList(List<Systemmodule> systemmoduleList) {
        this.systemmoduleList = systemmoduleList;
    }

    public Systemmodule getParentid() {
        return parentid;
    }

    public void setParentid(Systemmodule parentid) {
        this.parentid = parentid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (systemmoduleid != null ? systemmoduleid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemmodule)) {
            return false;
        }
        Systemmodule other = (Systemmodule) object;
        if ((this.systemmoduleid == null && other.systemmoduleid != null) || (this.systemmoduleid != null && !this.systemmoduleid.equals(other.systemmoduleid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Systemmodule[ systemmoduleid=" + systemmoduleid + " ]";
    }
    
}
