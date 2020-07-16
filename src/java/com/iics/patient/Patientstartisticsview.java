/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

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
 * @author IICS
 */
@Entity
@Table(name = "patientstartisticsview", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientstartisticsview.findAll", query = "SELECT p FROM Patientstartisticsview p")
    , @NamedQuery(name = "Patientstartisticsview.findByPatientid", query = "SELECT p FROM Patientstartisticsview p WHERE p.patientid = :patientid")
    , @NamedQuery(name = "Patientstartisticsview.findByPersonid", query = "SELECT p FROM Patientstartisticsview p WHERE p.personid = :personid")
    , @NamedQuery(name = "Patientstartisticsview.findByPatientno", query = "SELECT p FROM Patientstartisticsview p WHERE p.patientno = :patientno")
    , @NamedQuery(name = "Patientstartisticsview.findByDatecreated", query = "SELECT p FROM Patientstartisticsview p WHERE p.datecreated = :datecreated")
    , @NamedQuery(name = "Patientstartisticsview.findByRegistrationfacilityid", query = "SELECT p FROM Patientstartisticsview p WHERE p.registrationfacilityid = :registrationfacilityid")
    , @NamedQuery(name = "Patientstartisticsview.findByDob", query = "SELECT p FROM Patientstartisticsview p WHERE p.dob = :dob")
    , @NamedQuery(name = "Patientstartisticsview.findByGender", query = "SELECT p FROM Patientstartisticsview p WHERE p.gender = :gender")
    , @NamedQuery(name = "Patientstartisticsview.findByPatientvisitid", query = "SELECT p FROM Patientstartisticsview p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Patientstartisticsview.findByAddedby", query = "SELECT p FROM Patientstartisticsview p WHERE p.addedby = :addedby")
    , @NamedQuery(name = "Patientstartisticsview.findByDateadded", query = "SELECT p FROM Patientstartisticsview p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Patientstartisticsview.findByVisitpriority", query = "SELECT p FROM Patientstartisticsview p WHERE p.visitpriority = :visitpriority")
    , @NamedQuery(name = "Patientstartisticsview.findByVisittype", query = "SELECT p FROM Patientstartisticsview p WHERE p.visittype = :visittype")
    , @NamedQuery(name = "Patientstartisticsview.findByVisitnumber", query = "SELECT p FROM Patientstartisticsview p WHERE p.visitnumber = :visitnumber")
    , @NamedQuery(name = "Patientstartisticsview.findByFacilityunitid", query = "SELECT p FROM Patientstartisticsview p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Patientstartisticsview.findByFacilityid", query = "SELECT p FROM Patientstartisticsview p WHERE p.facilityid = :facilityid")
    , @NamedQuery(name = "Patientstartisticsview.findByFullname", query = "SELECT p FROM Patientstartisticsview p WHERE p.fullname = :fullname")
    , @NamedQuery(name = "Patientstartisticsview.findByAge", query = "SELECT p FROM Patientstartisticsview p WHERE p.age = :age")
    , @NamedQuery(name = "Patientstartisticsview.findByVillagename", query = "SELECT p FROM Patientstartisticsview p WHERE p.villagename = :villagename")
    , @NamedQuery(name = "Patientstartisticsview.findByParishname", query = "SELECT p FROM Patientstartisticsview p WHERE p.parishname = :parishname")})
public class Patientstartisticsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "patientid")
    private BigInteger patientid;
    @Column(name = "personid")
    private BigInteger personid;
    @Size(max = 2147483647)
    @Column(name = "patientno")
    private String patientno;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Column(name = "registrationfacilityid")
    private Integer registrationfacilityid;
    @Column(name = "dob")
    @Temporal(TemporalType.DATE)
    private Date dob;
    @Size(max = 2147483647)
    @Column(name = "gender")
    private String gender;
    @Id
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Size(max = 255)
    @Column(name = "visitpriority")
    private String visitpriority;
    @Size(max = 255)
    @Column(name = "visittype")
    private String visittype;
    @Size(max = 255)
    @Column(name = "visitnumber")
    private String visitnumber;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Size(max = 2147483647)
    @Column(name = "fullname")
    private String fullname;
    @Column(name = "age")
    private Integer age;
    @Size(max = 2147483647)
    @Column(name = "villagename")
    private String villagename;
    @Size(max = 2147483647)
    @Column(name = "parishname")
    private String parishname;

    public Patientstartisticsview() {
    }

    public BigInteger getPatientid() {
        return patientid;
    }

    public void setPatientid(BigInteger patientid) {
        this.patientid = patientid;
    }

    public BigInteger getPersonid() {
        return personid;
    }

    public void setPersonid(BigInteger personid) {
        this.personid = personid;
    }

    public String getPatientno() {
        return patientno;
    }

    public void setPatientno(String patientno) {
        this.patientno = patientno;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public Integer getRegistrationfacilityid() {
        return registrationfacilityid;
    }

    public void setRegistrationfacilityid(Integer registrationfacilityid) {
        this.registrationfacilityid = registrationfacilityid;
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

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public String getVisitpriority() {
        return visitpriority;
    }

    public void setVisitpriority(String visitpriority) {
        this.visitpriority = visitpriority;
    }

    public String getVisittype() {
        return visittype;
    }

    public void setVisittype(String visittype) {
        this.visittype = visittype;
    }

    public String getVisitnumber() {
        return visitnumber;
    }

    public void setVisitnumber(String visitnumber) {
        this.visitnumber = visitnumber;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getVillagename() {
        return villagename;
    }

    public void setVillagename(String villagename) {
        this.villagename = villagename;
    }

    public String getParishname() {
        return parishname;
    }

    public void setParishname(String parishname) {
        this.parishname = parishname;
    }
    
}
