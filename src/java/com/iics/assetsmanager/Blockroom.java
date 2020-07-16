/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

import java.io.Serializable;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "blockroom", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Blockroom.findAll", query = "SELECT b FROM Blockroom b")
    , @NamedQuery(name = "Blockroom.findByBlockroomid", query = "SELECT b FROM Blockroom b WHERE b.blockroomid = :blockroomid")
    , @NamedQuery(name = "Blockroom.findByRoomname", query = "SELECT b FROM Blockroom b WHERE b.roomname = :roomname")
    , @NamedQuery(name = "Blockroom.findByDescription", query = "SELECT b FROM Blockroom b WHERE b.description = :description")
    , @NamedQuery(name = "Blockroom.findByStatus", query = "SELECT b FROM Blockroom b WHERE b.status = :status")
    , @NamedQuery(name = "Blockroom.findByRoomstatus", query = "SELECT b FROM Blockroom b WHERE b.roomstatus = :roomstatus")
    , @NamedQuery(name = "Blockroom.findByDateadded", query = "SELECT b FROM Blockroom b WHERE b.dateadded = :dateadded")
    , @NamedQuery(name = "Blockroom.findByAddedby", query = "SELECT b FROM Blockroom b WHERE b.addedby = :addedby")
    , @NamedQuery(name = "Blockroom.findByUpdatedby", query = "SELECT b FROM Blockroom b WHERE b.updatedby = :updatedby")
    , @NamedQuery(name = "Blockroom.findByDateupdated", query = "SELECT b FROM Blockroom b WHERE b.dateupdated = :dateupdated")})
public class Blockroom implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "blockroomid", nullable = false)
    private Integer blockroomid;
    @Size(max = 2147483647)
    @Column(name = "roomname", length = 2147483647)
    private String roomname;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "roomstatus")
    private Boolean roomstatus;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Size(max = 2147483647)
    @Column(name = "addedby", length = 2147483647)
    private Long addedby;
    @Size(max = 2147483647)
    @Column(name = "updatedby", length = 2147483647)
    private Long updatedby;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.DATE)
    private Date dateupdated;
    @Column(name = "blockfloorid")
    private Integer blockfloorid;

    public Blockroom() {
    }

    public Blockroom(Integer blockroomid) {
        this.blockroomid = blockroomid;
    }

    public Integer getBlockroomid() {
        return blockroomid;
    }

    public void setBlockroomid(Integer blockroomid) {
        this.blockroomid = blockroomid;
    }

    public String getRoomname() {
        return roomname;
    }

    public void setRoomname(String roomname) {
        this.roomname = roomname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Boolean getRoomstatus() {
        return roomstatus;
    }

    public void setRoomstatus(Boolean roomstatus) {
        this.roomstatus = roomstatus;
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

    public Integer getBlockfloorid() {
        return blockfloorid;
    }

    public void setBlockfloorid(Integer blockfloorid) {
        this.blockfloorid = blockfloorid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (blockroomid != null ? blockroomid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Blockroom)) {
            return false;
        }
        Blockroom other = (Blockroom) object;
        if ((this.blockroomid == null && other.blockroomid != null) || (this.blockroomid != null && !this.blockroomid.equals(other.blockroomid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Blockroom[ blockroomid=" + blockroomid + " ]";
    }
    
}
