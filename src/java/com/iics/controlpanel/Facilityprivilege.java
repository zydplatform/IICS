/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "controlpanel.facilityprivilege", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityprivilege.findAll", query = "SELECT f FROM Facilityprivilege f")
    , @NamedQuery(name = "Facilityprivilege.findByFacilityprivilegeid", query = "SELECT f FROM Facilityprivilege f WHERE f.facilityprivilegeid = :facilityprivilegeid")
    , @NamedQuery(name = "Facilityprivilege.findByFacilityid", query = "SELECT f FROM Facilityprivilege f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilityprivilege.findByIsactive", query = "SELECT f FROM Facilityprivilege f WHERE f.isactive = :isactive")
    , @NamedQuery(name = "Facilityprivilege.findByAddedby", query = "SELECT f FROM Facilityprivilege f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityprivilege.findByDateadded", query = "SELECT f FROM Facilityprivilege f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityprivilege.findByLastupdated", query = "SELECT f FROM Facilityprivilege f WHERE f.lastupdated = :lastupdated")
    , @NamedQuery(name = "Facilityprivilege.findByLastupdatedby", query = "SELECT f FROM Facilityprivilege f WHERE f.lastupdatedby = :lastupdatedby")})
public class Facilityprivilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "facilityprivilegeid", nullable = false)
    private Long facilityprivilegeid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "addedby")
    private Long addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "lastupdated")
    @Temporal(TemporalType.DATE)
    private Date lastupdated;
    @Column(name = "lastupdatedby")
    private Long lastupdatedby;
    @Column(name = "privilegeid")
    private Long privilegeid;
    
    public Facilityprivilege() {
    }

    public Facilityprivilege(Long facilityprivilegeid) {
        this.facilityprivilegeid = facilityprivilegeid;
    }

    public Long getFacilityprivilegeid() {
        return facilityprivilegeid;
    }

    public void setFacilityprivilegeid(Long facilityprivilegeid) {
        this.facilityprivilegeid = facilityprivilegeid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public Long getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(Long privilegeid) {
        this.privilegeid = privilegeid;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
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

    public Long getLastupdatedby() {
        return lastupdatedby;
    }

    public void setLastupdatedby(Long lastupdatedby) {
        this.lastupdatedby = lastupdatedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityprivilegeid != null ? facilityprivilegeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityprivilege)) {
            return false;
        }
        Facilityprivilege other = (Facilityprivilege) object;
        if ((this.facilityprivilegeid == null && other.facilityprivilegeid != null) || (this.facilityprivilegeid != null && !this.facilityprivilegeid.equals(other.facilityprivilegeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Facilityprivilege[ facilityprivilegeid=" + facilityprivilegeid + " ]";
    }
    
}
