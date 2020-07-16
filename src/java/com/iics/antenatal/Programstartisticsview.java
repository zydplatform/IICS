/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "programstartisticsview", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Programstartisticsview.findAll", query = "SELECT p FROM Programstartisticsview p")
    , @NamedQuery(name = "Programstartisticsview.findByPatientid", query = "SELECT p FROM Programstartisticsview p WHERE p.patientid = :patientid")
    , @NamedQuery(name = "Programstartisticsview.findByPersonid", query = "SELECT p FROM Programstartisticsview p WHERE p.personid = :personid")
    , @NamedQuery(name = "Programstartisticsview.findByPatientno", query = "SELECT p FROM Programstartisticsview p WHERE p.patientno = :patientno")
    , @NamedQuery(name = "Programstartisticsview.findByDatecreated", query = "SELECT p FROM Programstartisticsview p WHERE p.datecreated = :datecreated")
    , @NamedQuery(name = "Programstartisticsview.findByRegistrationfacilityid", query = "SELECT p FROM Programstartisticsview p WHERE p.registrationfacilityid = :registrationfacilityid")
    , @NamedQuery(name = "Programstartisticsview.findByDob", query = "SELECT p FROM Programstartisticsview p WHERE p.dob = :dob")
    , @NamedQuery(name = "Programstartisticsview.findByGender", query = "SELECT p FROM Programstartisticsview p WHERE p.gender = :gender")
    , @NamedQuery(name = "Programstartisticsview.findByPatientvisitid", query = "SELECT p FROM Programstartisticsview p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Programstartisticsview.findByDateadded", query = "SELECT p FROM Programstartisticsview p WHERE p.dateadded = :dateadded")
    , @NamedQuery(name = "Programstartisticsview.findByVisitpriority", query = "SELECT p FROM Programstartisticsview p WHERE p.visitpriority = :visitpriority")
    , @NamedQuery(name = "Programstartisticsview.findByVisittype", query = "SELECT p FROM Programstartisticsview p WHERE p.visittype = :visittype")
    , @NamedQuery(name = "Programstartisticsview.findByVisitnumber", query = "SELECT p FROM Programstartisticsview p WHERE p.visitnumber = :visitnumber")
    , @NamedQuery(name = "Programstartisticsview.findByFacilityunitid", query = "SELECT p FROM Programstartisticsview p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Programstartisticsview.findByFacilityid", query = "SELECT p FROM Programstartisticsview p WHERE p.facilityid = :facilityid")
    , @NamedQuery(name = "Programstartisticsview.findByFullname", query = "SELECT p FROM Programstartisticsview p WHERE p.fullname = :fullname")
    , @NamedQuery(name = "Programstartisticsview.findByAge", query = "SELECT p FROM Programstartisticsview p WHERE p.age = :age")
    , @NamedQuery(name = "Programstartisticsview.findByVillagename", query = "SELECT p FROM Programstartisticsview p WHERE p.villagename = :villagename")
    , @NamedQuery(name = "Programstartisticsview.findByParishname", query = "SELECT p FROM Programstartisticsview p WHERE p.parishname = :parishname")
    , @NamedQuery(name = "Programstartisticsview.findByProgramname", query = "SELECT p FROM Programstartisticsview p WHERE p.programname = :programname")
    , @NamedQuery(name = "Programstartisticsview.findByProgramkey", query = "SELECT p FROM Programstartisticsview p WHERE p.programkey = :programkey")})
public class Programstartisticsview implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "patientid")
    private Long patientid;
    @Column(name = "personid")
    private Long personid;
    @Column(name = "patientno", length = 2147483647)
    private String patientno;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Column(name = "registrationfacilityid")
    private Integer registrationfacilityid;
    @Column(name = "dob")
    @Temporal(TemporalType.DATE)
    private Date dob;
    @Column(name = "gender", length = 2147483647)
    private String gender;
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "visitpriority", length = 255)
    private String visitpriority;
    @Column(name = "visittype", length = 255)
    private String visittype;
    @Column(name = "visitnumber", length = 255)
    private String visitnumber;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Column(name = "age")
    private Integer age;
    @Column(name = "villagename", length = 2147483647)
    private String villagename;
    @Column(name = "parishname", length = 2147483647)
    private String parishname;
    @Column(name = "programid")
    private Long programid;
    @Column(name = "programname", length = 2147483647)
    private String programname;
    @Column(name = "programkey", length = 2147483647)
    private String programkey;

    public Programstartisticsview() {
    }

    public Long getPatientid() {
        return patientid;
    }

    public void setPatientid(Long patientid) {
        this.patientid = patientid;
    }

    public Long getPersonid() {
        return personid;
    }

    public void setPersonid(Long personid) {
        this.personid = personid;
    }

    public Long getProgramid() {
        return programid;
    }

    public void setProgramid(Long programid) {
        this.programid = programid;
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

    public String getProgramname() {
        return programname;
    }

    public void setProgramname(String programname) {
        this.programname = programname;
    }

    public String getProgramkey() {
        return programkey;
    }

    public void setProgramkey(String programkey) {
        this.programkey = programkey;
    }
    
}
