/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER 1
 */
@Entity
@Table(name = "poststatisticsview", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Poststatisticsview.findAll", query = "SELECT p FROM Poststatisticsview p")
    , @NamedQuery(name = "Poststatisticsview.findByFacilitylevelid", query = "SELECT p FROM Poststatisticsview p WHERE p.facilitylevelid = :facilitylevelid")
    , @NamedQuery(name = "Poststatisticsview.findByFacilityname", query = "SELECT p FROM Poststatisticsview p WHERE p.facilityname = :facilityname")
    , @NamedQuery(name = "Poststatisticsview.findByDesignationid", query = "SELECT p FROM Poststatisticsview p WHERE p.designationid = :designationid")
    , @NamedQuery(name = "Poststatisticsview.findByDesignationname", query = "SELECT p FROM Poststatisticsview p WHERE p.designationname = :designationname")
    , @NamedQuery(name = "Poststatisticsview.findByFacilityid", query = "SELECT p FROM Poststatisticsview p WHERE p.facilityid = :facilityid")
    , @NamedQuery(name = "Poststatisticsview.findByStaffid", query = "SELECT p FROM Poststatisticsview p WHERE p.staffid = :staffid")
    , @NamedQuery(name = "Poststatisticsview.findByCurrentfacility", query = "SELECT p FROM Poststatisticsview p WHERE p.currentfacility = :currentfacility")})
public class Poststatisticsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "facilitylevelid")
    @Id
    private Integer facilitylevelid;
    @Size(max = 2147483647)
    @Column(name = "facilityname")
    private String facilityname;
    @Column(name = "designationid")
    private Integer designationid;
    @Size(max = 2147483647)
    @Column(name = "designationname")
    private String designationname;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "currentfacility")
    private Integer currentfacility;

    public Poststatisticsview() {
    }

    public Integer getFacilitylevelid() {
        return facilitylevelid;
    }

    public void setFacilitylevelid(Integer facilitylevelid) {
        this.facilitylevelid = facilitylevelid;
    }

    public String getFacilityname() {
        return facilityname;
    }

    public void setFacilityname(String facilityname) {
        this.facilityname = facilityname;
    }

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public String getDesignationname() {
        return designationname;
    }

    public void setDesignationname(String designationname) {
        this.designationname = designationname;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public Integer getCurrentfacility() {
        return currentfacility;
    }

    public void setCurrentfacility(Integer currentfacility) {
        this.currentfacility = currentfacility;
    }
    
}
