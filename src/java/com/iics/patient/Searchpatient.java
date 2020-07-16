/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

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
 * @author IICS
 */
@Entity
@Table(name = "searchpatient", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Searchpatient.findAll", query = "SELECT s FROM Searchpatient s")
    , @NamedQuery(name = "Searchpatient.findByPersonid", query = "SELECT s FROM Searchpatient s WHERE s.personid = :personid")
    , @NamedQuery(name = "Searchpatient.findByFirstname", query = "SELECT s FROM Searchpatient s WHERE s.firstname = :firstname")
    , @NamedQuery(name = "Searchpatient.findByLastname", query = "SELECT s FROM Searchpatient s WHERE s.lastname = :lastname")
    , @NamedQuery(name = "Searchpatient.findByOthernames", query = "SELECT s FROM Searchpatient s WHERE s.othernames = :othernames")
    , @NamedQuery(name = "Searchpatient.findByFacilityid", query = "SELECT s FROM Searchpatient s WHERE s.facilityid = :facilityid")
    , @NamedQuery(name = "Searchpatient.findByCurrentaddress", query = "SELECT s FROM Searchpatient s WHERE s.currentaddress = :currentaddress")
    , @NamedQuery(name = "Searchpatient.findByPatientno", query = "SELECT s FROM Searchpatient s WHERE s.patientno = :patientno")
    , @NamedQuery(name = "Searchpatient.findByPatientid", query = "SELECT s FROM Searchpatient s WHERE s.patientid = :patientid")
    , @NamedQuery(name = "Searchpatient.findByTelephone", query = "SELECT s FROM Searchpatient s WHERE s.telephone = :telephone")
    , @NamedQuery(name = "Searchpatient.findByNextofkin", query = "SELECT s FROM Searchpatient s WHERE s.nextofkin = :nextofkin")
    , @NamedQuery(name = "Searchpatient.findByNextofkincontact", query = "SELECT s FROM Searchpatient s WHERE s.nextofkincontact = :nextofkincontact")
    , @NamedQuery(name = "Searchpatient.findByPermutation1", query = "SELECT s FROM Searchpatient s WHERE s.permutation1 = :permutation1")
    , @NamedQuery(name = "Searchpatient.findByPermutation2", query = "SELECT s FROM Searchpatient s WHERE s.permutation2 = :permutation2")
    , @NamedQuery(name = "Searchpatient.findByPermutation3", query = "SELECT s FROM Searchpatient s WHERE s.permutation3 = :permutation3")})
public class Searchpatient implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "personid")
    private BigInteger personid;
    @Size(max = 2147483647)
    @Column(name = "firstname", length = 2147483647)
    private String firstname;
    @Size(max = 2147483647)
    @Column(name = "lastname", length = 2147483647)
    private String lastname;
    @Size(max = 2147483647)
    @Column(name = "othernames", length = 2147483647)
    private String othernames;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "currentaddress")
    private Integer currentaddress;
    @Size(max = 2147483647)
    @Column(name = "patientno", length = 2147483647)
    private String patientno;
    @Column(name = "patientid")
    private BigInteger patientid;
    @Size(max = 255)
    @Column(name = "telephone", length = 255)
    private String telephone;
    @Size(max = 2147483647)
    @Column(name = "nextofkin", length = 2147483647)
    private String nextofkin;
    @Size(max = 255)
    @Column(name = "nextofkincontact", length = 255)
    private String nextofkincontact;
    @Size(max = 2147483647)
    @Column(name = "permutation1", length = 2147483647)
    private String permutation1;
    @Size(max = 2147483647)
    @Column(name = "permutation2", length = 2147483647)
    private String permutation2;
    @Size(max = 2147483647)
    @Column(name = "permutation3", length = 2147483647)
    private String permutation3;

    public Searchpatient() {
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

    public Integer getCurrentaddress() {
        return currentaddress;
    }

    public void setCurrentaddress(Integer currentaddress) {
        this.currentaddress = currentaddress;
    }

    public String getPatientno() {
        return patientno;
    }

    public void setPatientno(String patientno) {
        this.patientno = patientno;
    }

    public BigInteger getPatientid() {
        return patientid;
    }

    public void setPatientid(BigInteger patientid) {
        this.patientid = patientid;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getNextofkin() {
        return nextofkin;
    }

    public void setNextofkin(String nextofkin) {
        this.nextofkin = nextofkin;
    }

    public String getNextofkincontact() {
        return nextofkincontact;
    }

    public void setNextofkincontact(String nextofkincontact) {
        this.nextofkincontact = nextofkincontact;
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
    
}
