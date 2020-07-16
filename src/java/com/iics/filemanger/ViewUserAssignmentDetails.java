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
import javax.validation.constraints.NotNull;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "viewfilefileassignment", catalog = "iics_database", schema = "patient")
public class ViewUserAssignmentDetails {
     @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private long assignmentid;
@Basic(optional = false)
@NotNull
@Column(name = "fileno", nullable = false)
private String fileno ;
@Basic(optional = false)
@NotNull
@Column(name = "fileid", nullable = false) 
private int fileid;
@Basic(optional = false)
@NotNull
@Column(name = "status", nullable = false)
private String status;
@Basic(optional = false)
@NotNull
@Column(name = "currentlocation", nullable = false)
private long currentlocation; 
@Basic(optional = false)
@NotNull
@Column(name = "recievedbystaffid", nullable = false)
private long recievedbystaffid;
@Basic(optional = false)
@NotNull
@Column(name = "issuedbystaffid", nullable = false)
private long issuedbystaffid;
@Basic(optional = false)
@NotNull
@Column(name = "dateassigned", nullable = false)
private Date dateassigned;
@Basic(optional = false)
@NotNull
@Column(name = "datereturned", nullable = false)
private Date datereturned;
@Basic(optional = false)
@NotNull
@Column(name = "firstname", nullable = false)
private String firstname; 
@Basic(optional = false)
@NotNull
@Column(name = "lastname", nullable = false)
private String lastname; 
@Basic(optional = false)
@NotNull
@Column(name = "othernames", nullable = false)
private String othernames; 

    public int getFileid() {
        return fileid;
    }

    public void setFileid(int fileid) {
        this.fileid = fileid;
    }

    public long getAssignmentid() {
        return assignmentid;
    }

    public void setAssignmentid(long assignmentid) {
        this.assignmentid = assignmentid;
    }

    

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   

    public long getCurrentlocation() {
        return currentlocation;
    }

    public void setCurrentlocation(long currentlocation) {
        this.currentlocation = currentlocation;
    }

    public long getRecievedbystaffid() {
        return recievedbystaffid;
    }

    public void setRecievedbystaffid(long recievedbystaffid) {
        this.recievedbystaffid = recievedbystaffid;
    }

    public long getIssuedbystaffid() {
        return issuedbystaffid;
    }

    public void setIssuedbystaffid(long issuedbystaffid) {
        this.issuedbystaffid = issuedbystaffid;
    }

    public Date getDateassigned() {
        return dateassigned;
    }

    public void setDateassigned(Date dateassigned) {
        this.dateassigned = dateassigned;
    }

    public Date getDatereturned() {
        return datereturned;
    }

    public void setDatereturned(Date datereturned) {
        this.datereturned = datereturned;
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

}
