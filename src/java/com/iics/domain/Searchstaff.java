/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
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
 * @author user
 */
@Entity
@Table(name = "searchstaff", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Searchstaff.findAll", query = "SELECT s FROM Searchstaff s")
    , @NamedQuery(name = "Searchstaff.findByStaffid", query = "SELECT s FROM Searchstaff s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Searchstaff.findByPersonid", query = "SELECT s FROM Searchstaff s WHERE s.personid = :personid")
    , @NamedQuery(name = "Searchstaff.findByDesignationid", query = "SELECT s FROM Searchstaff s WHERE s.designationid = :designationid")
    , @NamedQuery(name = "Searchstaff.findByStaffno", query = "SELECT s FROM Searchstaff s WHERE s.staffno = :staffno")
    , @NamedQuery(name = "Searchstaff.findByComputerno", query = "SELECT s FROM Searchstaff s WHERE s.computerno = :computerno")
    , @NamedQuery(name = "Searchstaff.findByCurrentfacility", query = "SELECT s FROM Searchstaff s WHERE s.currentfacility = :currentfacility")
    , @NamedQuery(name = "Searchstaff.findByIsexternal", query = "SELECT s FROM Searchstaff s WHERE s.isexternal = :isexternal")
    , @NamedQuery(name = "Searchstaff.findByFirstname", query = "SELECT s FROM Searchstaff s WHERE s.firstname = :firstname")
    , @NamedQuery(name = "Searchstaff.findByOthernames", query = "SELECT s FROM Searchstaff s WHERE s.othernames = :othernames")
    , @NamedQuery(name = "Searchstaff.findByLastname", query = "SELECT s FROM Searchstaff s WHERE s.lastname = :lastname")
    , @NamedQuery(name = "Searchstaff.findByDob", query = "SELECT s FROM Searchstaff s WHERE s.dob = :dob")
    , @NamedQuery(name = "Searchstaff.findByGender", query = "SELECT s FROM Searchstaff s WHERE s.gender = :gender")
    , @NamedQuery(name = "Searchstaff.findByPermutation1", query = "SELECT s FROM Searchstaff s WHERE s.permutation1 = :permutation1")
    , @NamedQuery(name = "Searchstaff.findByPermutation2", query = "SELECT s FROM Searchstaff s WHERE s.permutation2 = :permutation2")
    , @NamedQuery(name = "Searchstaff.findByPermutation3", query = "SELECT s FROM Searchstaff s WHERE s.permutation3 = :permutation3")})
public class Searchstaff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "personid")
    private BigInteger personid;
    @Column(name = "designationid")
    private Integer designationid;
    @Size(max = 2147483647)
    @Column(name = "staffno", length = 2147483647)
    private String staffno;
    @Size(max = 2147483647)
    @Column(name = "computerno", length = 2147483647)
    private String computerno;
    @Column(name = "designationname")
    private String designationname;
    @Column(name = "currentfacility")
    private Integer currentfacility;
    @Column(name = "isexternal")
    private Boolean isexternal;
    @Size(max = 2147483647)
    @Column(name = "firstname", length = 2147483647)
    private String firstname;
    @Size(max = 2147483647)
    @Column(name = "othernames", length = 2147483647)
    private String othernames;
    @Size(max = 2147483647)
    @Column(name = "lastname", length = 2147483647)
    private String lastname;
    @Column(name = "dob")
    @Temporal(TemporalType.DATE)
    private Date dob;
    @Size(max = 2147483647)
    @Column(name = "gender", length = 2147483647)
    private String gender;
    @Size(max = 2147483647)
    @Column(name = "permutation1", length = 2147483647)
    private String permutation1;
    @Size(max = 2147483647)
    @Column(name = "permutation2", length = 2147483647)
    private String permutation2;
    @Size(max = 2147483647)
    @Column(name = "permutation3", length = 2147483647)
    private String permutation3;

    public Searchstaff() {
    }

    @Column(name = "facilityid")
    private Integer facilityid;

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public BigInteger getPersonid() {
        return personid;
    }

    public void setPersonid(BigInteger personid) {
        this.personid = personid;
    }

    public Integer getDesignationid() {
        return designationid;
    }

    public void setDesignationid(Integer designationid) {
        this.designationid = designationid;
    }

    public String getStaffno() {
        return staffno;
    }

    public void setStaffno(String staffno) {
        this.staffno = staffno;
    }

    public String getComputerno() {
        return computerno;
    }

    public void setComputerno(String computerno) {
        this.computerno = computerno;
    }

    public Integer getCurrentfacility() {
        return currentfacility;
    }

    public void setCurrentfacility(Integer currentfacility) {
        this.currentfacility = currentfacility;
    }

    public Boolean getIsexternal() {
        return isexternal;
    }

    public void setIsexternal(Boolean isexternal) {
        this.isexternal = isexternal;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getOthernames() {
        return othernames;
    }

    public void setOthernames(String othernames) {
        this.othernames = othernames;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPermutation1() {
        return permutation1;
    }

    public void setPermutation1(String permutation1) {
        this.permutation1 = permutation1;
    }

    public String getPermutation2() {
        return permutation2;
    }

    public void setPermutation2(String permutation2) {
        this.permutation2 = permutation2;
    }

    public String getPermutation3() {
        return permutation3;
    }

    public void setPermutation3(String permutation3) {
        this.permutation3 = permutation3;
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