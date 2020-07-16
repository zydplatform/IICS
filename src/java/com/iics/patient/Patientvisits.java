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
@Table(name = "patientvisits", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientvisits.findAll", query = "SELECT p FROM Patientvisits p")
    , @NamedQuery(name = "Patientvisits.findByPatientvisitid", query = "SELECT p FROM Patientvisits p WHERE p.patientvisitid = :patientvisitid")
    , @NamedQuery(name = "Patientvisits.findByPatientid", query = "SELECT p FROM Patientvisits p WHERE p.patientid = :patientid")
    , @NamedQuery(name = "Patientvisits.findByVisitnumber", query = "SELECT p FROM Patientvisits p WHERE p.visitnumber = :visitnumber")
    , @NamedQuery(name = "Patientvisits.findByVisittype", query = "SELECT p FROM Patientvisits p WHERE p.visittype = :visittype")
    , @NamedQuery(name = "Patientvisits.findByFacilityunitid", query = "SELECT p FROM Patientvisits p WHERE p.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Patientvisits.findByFullnames", query = "SELECT p FROM Patientvisits p WHERE p.fullnames = :fullnames")})
public class Patientvisits implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "patientvisitid")
    private BigInteger patientvisitid;
    @Column(name = "patientid")
    private BigInteger patientid;
    @Size(max = 255)
    @Column(name = "visitnumber")
    private String visitnumber;
    @Size(max = 255)
    @Column(name = "visittype")
    private String visittype;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 2147483647)
    @Column(name = "fullnames")
    private String fullnames;

    public Patientvisits() {
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

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getConcat() {
        return fullnames;
    }

    public void setConcat(String concat) {
        this.fullnames = concat;
    }
}
