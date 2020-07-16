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
 * @author IICS PROJECT
 */
@Entity
@Table(name = "personview")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Personview.findAll", query = "SELECT p FROM Personview p")
    , @NamedQuery(name = "Personview.findByPersonid", query = "SELECT p FROM Personview p WHERE p.personid = :personid")
    , @NamedQuery(name = "Personview.findByFirstname", query = "SELECT p FROM Personview p WHERE p.firstname = :firstname")
    , @NamedQuery(name = "Personview.findByLastname", query = "SELECT p FROM Personview p WHERE p.lastname = :lastname")
    , @NamedQuery(name = "Personview.findByOthernames", query = "SELECT p FROM Personview p WHERE p.othernames = :othernames")
    , @NamedQuery(name = "Personview.findByFacilityid", query = "SELECT p FROM Personview p WHERE p.facilityid = :facilityid")
    , @NamedQuery(name = "Personview.findByStaffid", query = "SELECT p FROM Personview p WHERE p.staffid = :staffid")
    , @NamedQuery(name = "Personview.findByStaffno", query = "SELECT p FROM Personview p WHERE p.staffno = :staffno")
    , @NamedQuery(name = "Personview.findByDesignationid", query = "SELECT p FROM Personview p WHERE p.designationid = :designationid")
    , @NamedQuery(name = "Personview.findByFacilityunitid", query = "SELECT p FROM Personview p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Personview.findByFacilityunitname", query = "SELECT p FROM Personview p WHERE p.facilityunitname = :facilityunitname")
    , @NamedQuery(name = "Personview.findByDesignationname", query = "SELECT p FROM Personview p WHERE p.designationname = :designationname")
    , @NamedQuery(name = "Personview.findByUsername", query = "SELECT p FROM Personview p WHERE p.username = :username")
    , @NamedQuery(name = "Personview.findByActive", query = "SELECT p FROM Personview p WHERE p.active = :active")})
public class Personview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "personid")
    private BigInteger personid;
    @Size(max = 2147483647)
    @Column(name = "firstname")
    private String firstname;
    @Size(max = 2147483647)
    @Column(name = "lastname")
    private String lastname;
    @Size(max = 2147483647)
    @Column(name = "othernames")
    private String othernames;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Size(max = 2147483647)
    @Column(name = "staffno")
    private String staffno;
    @Column(name = "designationid")
    private Integer designationid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 2147483647)
    @Column(name = "facilityunitname")
    private String facilityunitname;
    @Size(max = 2147483647)
    @Column(name = "designationname")
    private String designationname;
    @Size(max = 2147483647)
    @Column(name = "username")
    private String username;
    @Column(name = "active")
    private Boolean active;

    public Personview() {
    }

    public BigInteger getPersonid() {
        return personid;
    }

    public void setPersonid(BigInteger personid) {
        this.personid = personid;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getOthernames() {
        return othernames;
    }

    public void setOthernames(String othernames) {
        this.othernames = othernames;
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

    public String getStaffno() {
        return staffno;
    }

    public void setStaffno(String staffno) {
        this.staffno = staffno;
    }

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getFacilityunitname() {
        return facilityunitname;
    }

    public void setFacilityunitname(String facilityunitname) {
        this.facilityunitname = facilityunitname;
    }

    public String getDesignationname() {
        return designationname;
    }

    public void setDesignationname(String designationname) {
        this.designationname = designationname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
    
}
