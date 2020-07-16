/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.filemanger;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


/**
 *
 * @author IICS
 */
@Entity
@Table(name = "patient.searchpatientfile", catalog = "iics_database")
public class SearchPatientFile implements Serializable {
    private static final long serialVersionUID = 1L;
    @Column(name = "personid")
    @Id
    private long personid;
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
    @Column(name = "pin")
    private Integer pin;
    @Column(name = "patientid")
    private Integer patientid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fileno", nullable = false)
    private String fileno;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fileid", nullable = false)
    private long fileid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "staffid", nullable = false)
    private String staffid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status", nullable = false)
    private String status;
   @Basic(optional = false)
    @NotNull
    @Column(name = "datecreated", nullable = false)
    private Date datecreated;
   public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
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

    public Integer getPin() {
        return pin;
    }

    public void setPin(Integer pin) {
        this.pin = pin;
    }

    public Integer getPatientid() {
        return patientid;
    }

    public void setPatientid(Integer patientid) {
        this.patientid = patientid;
    }

    public String getFileno() {
        return fileno;
    }
    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

    public long getFileid() {
        return fileid;
    }

    public void setFileid(long fileid) {
        this.fileid = fileid;
    }

    public String getStaffid() {
        return staffid;
    }

    public void setStaffid(String staffid) {
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

}
