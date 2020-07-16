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
@Table(name = "registrarpatients", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Registrarpatients.findAll", query = "SELECT r FROM Registrarpatients r")
    , @NamedQuery(name = "Registrarpatients.findByPatientvisitid", query = "SELECT r FROM Registrarpatients r WHERE r.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Registrarpatients.findByPatientid", query = "SELECT r FROM Registrarpatients r WHERE r.patientid = :patientid")
    , @NamedQuery(name = "Registrarpatients.findByAddedby", query = "SELECT r FROM Registrarpatients r WHERE r.addedby = :addedby")
    , @NamedQuery(name = "Registrarpatients.findByDateadded", query = "SELECT r FROM Registrarpatients r WHERE r.dateadded = :dateadded")
    , @NamedQuery(name = "Registrarpatients.findByVisitnumber", query = "SELECT r FROM Registrarpatients r WHERE r.visitnumber = :visitnumber")
    , @NamedQuery(name = "Registrarpatients.findByVisittype", query = "SELECT r FROM Registrarpatients r WHERE r.visittype = :visittype")
    , @NamedQuery(name = "Registrarpatients.findByVisitpriority", query = "SELECT r FROM Registrarpatients r WHERE r.visitpriority = :visitpriority")
    , @NamedQuery(name = "Registrarpatients.findByFacilityunitid", query = "SELECT r FROM Registrarpatients r WHERE r.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Registrarpatients.findByFacilityid", query = "SELECT r FROM Registrarpatients r WHERE r.facilityid = :facilityid")})
public class Registrarpatients implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "patientvisitid")
    @Id
    private BigInteger patientvisitid;
    @Column(name = "patientid")
    private BigInteger patientid;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Size(max = 255)
    @Column(name = "visitnumber")
    private String visitnumber;
    @Size(max = 255)
    @Column(name = "visittype")
    private String visittype;
    @Size(max = 255)
    @Column(name = "visitpriority")
    private String visitpriority;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "facilityid")
    private Integer facilityid;

    public Registrarpatients() {
    }

    public BigInteger getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(BigInteger patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public BigInteger getPatientid() {
        return patientid;
    }

    public void setPatientid(BigInteger patientid) {
        this.patientid = patientid;
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

    public String getVisitnumber() {
        return visitnumber;
    }

    public void setVisitnumber(String visitnumber) {
        this.visitnumber = visitnumber;
    }

    public String getVisittype() {
        return visittype;
    }

    public void setVisittype(String visittype) {
        this.visittype = visittype;
    }

    public String getVisitpriority() {
        return visitpriority;
    }

    public void setVisitpriority(String visitpriority) {
        this.visitpriority = visitpriority;
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
    
}
