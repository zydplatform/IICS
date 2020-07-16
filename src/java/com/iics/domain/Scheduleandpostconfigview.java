/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
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
@Table(name = "scheduleandpostconfigview", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Scheduleandpostconfigview.findAll", query = "SELECT s FROM Scheduleandpostconfigview s")
    , @NamedQuery(name = "Scheduleandpostconfigview.findByFacilitylevelid", query = "SELECT s FROM Scheduleandpostconfigview s WHERE s.facilitylevelid = :facilitylevelid")
    , @NamedQuery(name = "Scheduleandpostconfigview.findByFacilityname", query = "SELECT s FROM Scheduleandpostconfigview s WHERE s.facilityname = :facilityname")
    , @NamedQuery(name = "Scheduleandpostconfigview.findByDesignationid", query = "SELECT s FROM Scheduleandpostconfigview s WHERE s.designationid = :designationid")
    , @NamedQuery(name = "Scheduleandpostconfigview.findByRequiredstaff", query = "SELECT s FROM Scheduleandpostconfigview s WHERE s.requiredstaff = :requiredstaff")
    , @NamedQuery(name = "Scheduleandpostconfigview.findByDesignationname", query = "SELECT s FROM Scheduleandpostconfigview s WHERE s.designationname = :designationname")
    , @NamedQuery(name = "Scheduleandpostconfigview.findByFacilityid", query = "SELECT s FROM Scheduleandpostconfigview s WHERE s.facilityid = :facilityid")})
public class Scheduleandpostconfigview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "facilitylevelid")
    @Id
    private Integer facilitylevelid;
    @Size(max = 2147483647)
    @Column(name = "facilityname")
    private String facilityname;
    @Column(name = "designationid")
    private Integer designationid;
    @Column(name = "requiredstaff")
    private Integer requiredstaff;
    @Size(max = 2147483647)
    @Column(name = "designationname")
    private String designationname;
    @Column(name = "facilityid")
    private Integer facilityid;

    public Scheduleandpostconfigview() {
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

    public Integer getRequiredstaff() {
        return requiredstaff;
    }

    public void setRequiredstaff(Integer requiredstaff) {
        this.requiredstaff = requiredstaff;
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
    
}
