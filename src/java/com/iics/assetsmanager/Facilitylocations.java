/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.assetsmanager;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;


/**
 *
 * @author user
 */
@Entity
@Table(name = "facilitylocations", catalog = "iics_database", schema = "assetsmanager")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitylocations.findAll", query = "SELECT f FROM Facilitylocations f")
    , @NamedQuery(name = "Facilitylocations.findByBuildingid", query = "SELECT f FROM Facilitylocations f WHERE f.buildingid = :buildingid")
    , @NamedQuery(name = "Facilitylocations.findByBuildingname", query = "SELECT f FROM Facilitylocations f WHERE f.buildingname = :buildingname")
    , @NamedQuery(name = "Facilitylocations.findByFacilityid", query = "SELECT f FROM Facilitylocations f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitylocations.findByFacilityblockid", query = "SELECT f FROM Facilitylocations f WHERE f.facilityblockid = :facilityblockid")
    , @NamedQuery(name = "Facilitylocations.findByBlockname", query = "SELECT f FROM Facilitylocations f WHERE f.blockname = :blockname")
    , @NamedQuery(name = "Facilitylocations.findByBlockfloorid", query = "SELECT f FROM Facilitylocations f WHERE f.blockfloorid = :blockfloorid")
    , @NamedQuery(name = "Facilitylocations.findByFloorname", query = "SELECT f FROM Facilitylocations f WHERE f.floorname = :floorname")
    , @NamedQuery(name = "Facilitylocations.findByBlockroomid", query = "SELECT f FROM Facilitylocations f WHERE f.blockroomid = :blockroomid")
    , @NamedQuery(name = "Facilitylocations.findByRoomname", query = "SELECT f FROM Facilitylocations f WHERE f.roomname = :roomname")
    , @NamedQuery(name = "Facilitylocations.findByStatus", query = "SELECT f FROM Facilitylocations f WHERE f.status = :status")
    , @NamedQuery(name = "Facilitylocations.findByFacilityunitroomid", query = "SELECT f FROM Facilitylocations f WHERE f.facilityunitroomid = :facilityunitroomid")
    , @NamedQuery(name = "Facilitylocations.findByRoomstatus", query = "SELECT f FROM Facilitylocations f WHERE f.roomstatus = :roomstatus")})
public class Facilitylocations implements Serializable {

    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "buildingid")
    private Integer buildingid;
    @Size(max = 2147483647)
    @Column(name = "buildingname", length = 2147483647)
    private String buildingname;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "facilityblockid")
    private Integer facilityblockid;
    @Size(max = 2147483647)
    @Column(name = "blockname", length = 2147483647)
    private String blockname;
    @Column(name = "blockfloorid")
    private Integer blockfloorid;
    @Size(max = 2147483647)
    @Column(name = "floorname", length = 2147483647)
    private String floorname;
    @Column(name = "blockroomid")
    private Integer blockroomid;
    @Size(max = 2147483647)
    @Column(name = "roomname", length = 2147483647)
    private String roomname;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "facilityunitroomid")
    private Integer facilityunitroomid;
    @Size(max = 2147483647)
    @Column(name = "roomstatus", length = 2147483647)
    private String roomstatus;

    public Facilitylocations() {
    }

    public Integer getBuildingid() {
        return buildingid;
    }

    public void setBuildingid(Integer buildingid) {
        this.buildingid = buildingid;
    }

    public String getBuildingname() {
        return buildingname;
    }

    public void setBuildingname(String buildingname) {
        this.buildingname = buildingname;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
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

    public Integer getBlockfloorid() {
        return blockfloorid;
    }

    public void setBlockfloorid(Integer blockfloorid) {
        this.blockfloorid = blockfloorid;
    }

    public String getFloorname() {
        return floorname;
    }

    public void setFloorname(String floorname) {
        this.floorname = floorname;
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

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Integer getFacilityunitroomid() {
        return facilityunitroomid;
    }

    public void setFacilityunitroomid(Integer facilityunitroomid) {
        this.facilityunitroomid = facilityunitroomid;
    }

    public String getRoomstatus() {
        return roomstatus;
    }

    public void setRoomstatus(String roomstatus) {
        this.roomstatus = roomstatus;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }
    
}
