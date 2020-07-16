/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

import com.iics.assetsmanager.Blockroom;
import java.io.Serializable;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facilityblock", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityblock.findAll", query = "SELECT f FROM Facilityblock f")
    , @NamedQuery(name = "Facilityblock.findByFacilityblockid", query = "SELECT f FROM Facilityblock f WHERE f.facilityblockid = :facilityblockid")
    , @NamedQuery(name = "Facilityblock.findByBlockname", query = "SELECT f FROM Facilityblock f WHERE f.blockname = :blockname")
    , @NamedQuery(name = "Facilityblock.findByBlockdescription", query = "SELECT f FROM Facilityblock f WHERE f.blockdescription = :blockdescription")
    , @NamedQuery(name = "Facilityblock.findByStatus", query = "SELECT f FROM Facilityblock f WHERE f.status = :status")
    , @NamedQuery(name = "Facilityblock.findByFloorsize", query = "SELECT f FROM Facilityblock f WHERE f.floorsize = :floorsize")
    , @NamedQuery(name = "Facilityblock.findByDateadded", query = "SELECT f FROM Facilityblock f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityblock.findByAddedby", query = "SELECT f FROM Facilityblock f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityblock.findByUpdatedby", query = "SELECT f FROM Facilityblock f WHERE f.updatedby = :updatedby")
    , @NamedQuery(name = "Facilityblock.findByDateupdated", query = "SELECT f FROM Facilityblock f WHERE f.dateupdated = :dateupdated")})
public class Facilityblock implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityblockid", nullable = false)
    private Integer facilityblockid;
    @Size(max = 2147483647)
    @Column(name = "blockname", length = 2147483647)
    private String blockname;
    @Size(max = 2147483647)
    @Column(name = "blockdescription", length = 2147483647)
    private String blockdescription;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "floorsize")
    private Integer floorsize;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Size(max = 2147483647)
    @Column(name = "addedby", length = 2147483647)
    private Long addedby;
    @Size(max = 2147483647)
    @Column(name = "Updatedby", length = 2147483647)
    private Long updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "buildingid")
    private Integer buildingid;
    

    public Facilityblock() {
    }

    public Facilityblock(Integer facilityblockid) {
        this.facilityblockid = facilityblockid;
    }

    public Integer getFacilityblockid() {
        return facilityblockid;
    }

    public void setFacilityblockid(Integer facilityblockid) {
        this.facilityblockid = facilityblockid;
    }

    public String getBlockname() {
        return blockname;
    }

    public void setBlockname(String blockname) {
        this.blockname = blockname;
    }

    public String getBlockdescription() {
        return blockdescription;
    }

    public void setBlockdescription(String blockdescription) {
        this.blockdescription = blockdescription;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Integer getFloorsize() {
        return floorsize;
    }

    public void setFloorsize(Integer floorsize) {
        this.floorsize = floorsize;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Long getAddedby() {
        return addedby;
    }

    public void setAddedby(Long addedby) {
        this.addedby = addedby;
    }

    public Long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(Long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityblockid != null ? facilityblockid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityblock)) {
            return false;
        }
        Facilityblock other = (Facilityblock) object;
        if ((this.facilityblockid == null && other.facilityblockid != null) || (this.facilityblockid != null && !this.facilityblockid.equals(other.facilityblockid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Facilityblock[ facilityblockid=" + facilityblockid + " ]";
    }

    public Integer getBuildingid() {
        return buildingid;
    }

    public void setBuildingid(Integer buildingid) {
        this.buildingid = buildingid;
    }

    
}
