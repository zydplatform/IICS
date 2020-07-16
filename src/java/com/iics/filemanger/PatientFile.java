/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.filemanger;

import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;


/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patientfile", catalog = "iics_database", schema = "patient")
public class PatientFile {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int fileid;
@Basic(optional = false)
@NotNull
@Column(name = "patientid", nullable = false)
 private Long patientid; 
@Basic(optional = false)
@NotNull
@Column(name = "pin", nullable = false)
private String pin;
@Basic(optional = false)
@NotNull
@Column(name = "fileno", nullable = false)
private String fileno; 
@Basic(optional = false)
@NotNull
@Column(name = "staffid", nullable = false)
 private Long staffid; 
@Basic(optional = false)
@NotNull
@Column(name = "status", nullable = false)
private String status; 
@Basic(optional = false)
@NotNull
@Column(name = "datecreated", nullable = false)
@Temporal(TemporalType.DATE)
private Date datecreated;
    public int getFileid() {
        return fileid;
    }

    public void setFileid(int fileid) {
        this.fileid = fileid;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

 


    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

    public Long getStaffid() {
        return staffid;
    }

    public void setStaffid(Long staffid) {
        this.staffid = staffid;
    }

 
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }
  public Long getPatientid() {
        return patientid;
    }

    public void setPatientid(Long patientid) {
        this.patientid = patientid;
    }

   
    
}
