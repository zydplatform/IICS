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
 * @author RESEARCH
 */
@Entity
@Table(name = "facilitydesignationview", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitydesignationview.findAll", query = "SELECT f FROM Facilitydesignationview f")
    , @NamedQuery(name = "Facilitydesignationview.findByDesignationcategoryid", query = "SELECT f FROM Facilitydesignationview f WHERE f.designationcategoryid = :designationcategoryid")
    , @NamedQuery(name = "Facilitydesignationview.findByCategoryname", query = "SELECT f FROM Facilitydesignationview f WHERE f.categoryname = :categoryname")
    , @NamedQuery(name = "Facilitydesignationview.findByUniversaldeletestatus", query = "SELECT f FROM Facilitydesignationview f WHERE f.universaldeletestatus = :universaldeletestatus")
    , @NamedQuery(name = "Facilitydesignationview.findByDeletestatus", query = "SELECT f FROM Facilitydesignationview f WHERE f.deletestatus = :deletestatus")
    , @NamedQuery(name = "Facilitydesignationview.findByDesignationid", query = "SELECT f FROM Facilitydesignationview f WHERE f.designationid = :designationid")
    , @NamedQuery(name = "Facilitydesignationview.findByDesignationname", query = "SELECT f FROM Facilitydesignationview f WHERE f.designationname = :designationname")
    , @NamedQuery(name = "Facilitydesignationview.findByTransferstatus", query = "SELECT f FROM Facilitydesignationview f WHERE f.transferstatus = :transferstatus")
    , @NamedQuery(name = "Facilitydesignationview.findByUniversaltransferstatus", query = "SELECT f FROM Facilitydesignationview f WHERE f.universaltransferstatus = :universaltransferstatus")
    , @NamedQuery(name = "Facilitydesignationview.findByFacilitydesignationsid", query = "SELECT f FROM Facilitydesignationview f WHERE f.facilitydesignationsid = :facilitydesignationsid")
    , @NamedQuery(name = "Facilitydesignationview.findByFacilityid", query = "SELECT f FROM Facilitydesignationview f WHERE f.facilityid = :facilityid")})
public class Facilitydesignationview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "designationcategoryid")
    private Integer designationcategoryid;
    @Size(max = 2147483647)
    @Column(name = "categoryname", length = 2147483647)
    private String categoryname;
    @Size(max = 2147483647)
    @Column(name = "universaldeletestatus", length = 2147483647)
    private String universaldeletestatus;
    @Size(max = 2147483647)
    @Column(name = "deletestatus", length = 2147483647)
    private String deletestatus;
    @Column(name = "designationid")
    private Integer designationid;
    @Size(max = 2147483647)
    @Column(name = "designationname", length = 2147483647)
    private String designationname;
    @Size(max = 2147483647)
    @Column(name = "transferstatus", length = 2147483647)
    private String transferstatus;
    @Size(max = 2147483647)
    @Column(name = "universaltransferstatus", length = 2147483647)
    private String universaltransferstatus;
    @Column(name = "facilitydesignationsid")
    private Integer facilitydesignationsid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Id
    private Long facilitydesignationviewid;

    public Facilitydesignationview() {
    }

    public Integer getDesignationcategoryid() {
        return designationcategoryid;
    }

    public void setDesignationcategoryid(Integer designationcategoryid) {
        this.designationcategoryid = designationcategoryid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getUniversaldeletestatus() {
        return universaldeletestatus;
    }

    public void setUniversaldeletestatus(String universaldeletestatus) {
        this.universaldeletestatus = universaldeletestatus;
    }

    public String getDeletestatus() {
        return deletestatus;
    }

    public void setDeletestatus(String deletestatus) {
        this.deletestatus = deletestatus;
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

    public String getTransferstatus() {
        return transferstatus;
    }

    public void setTransferstatus(String transferstatus) {
        this.transferstatus = transferstatus;
    }

    public String getUniversaltransferstatus() {
        return universaltransferstatus;
    }

    public void setUniversaltransferstatus(String universaltransferstatus) {
        this.universaltransferstatus = universaltransferstatus;
    }

    public Integer getFacilitydesignationsid() {
        return facilitydesignationsid;
    }

    public void setFacilitydesignationsid(Integer facilitydesignationsid) {
        this.facilitydesignationsid = facilitydesignationsid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Long getFacilitydesignationviewid() {
        return facilitydesignationviewid;
    }

    public void setFacilitydesignationviewid(Long facilitydesignationviewid) {
        this.facilitydesignationviewid = facilitydesignationviewid;
    }
    
}
