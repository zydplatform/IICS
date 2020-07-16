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
 * @author user
 */
@Entity
@Table(name = "userfileassignment", catalog = "iics_database", schema = "patient")
public class UserFileAssignment {
    @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int assignmentid;
@Basic(optional = false)
@NotNull
@Column(name = "fileno", nullable = false)
private String fileno ;
@Basic(optional = false)
@NotNull
@Column(name = "status", nullable = false)
private String filestatus;
@Basic(optional = false)
@NotNull
@Column(name = "currentlocation", nullable = false)
private long currentlocation; 
@Basic(optional = false)
@NotNull
@Column(name = "recievedbystaffid", nullable = false)
private long recieverid;
@Basic(optional = false)
@NotNull
@Column(name = "issuedbystaffid", nullable = false)
private long issuerid;
@Basic(optional = false)
@NotNull
@Column(name = "dateassigned", nullable = false)
private Date issueDate;
@Basic(optional = false)
@NotNull
@Column(name = "datereturned", nullable = false)
private Date returnDate;

    public int getAssignmentid() {
        return assignmentid;
    }

    public void setAssignmentid(int assignmentid) {
        this.assignmentid = assignmentid;
    }

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

   

    public String getFilestatus() {
        return filestatus;
    }

    public void setFilestatus(String filestatus) {
        this.filestatus = filestatus;
    }

    public long getCurrentlocation() {
        return currentlocation;
    }

    public void setCurrentlocation(long currentlocation) {
        this.currentlocation = currentlocation;
    }


    public long getRecieverid() {
        return recieverid;
    }

    public void setRecieverid(long recieverid) {
        this.recieverid = recieverid;
    }

    public long getIssuerid() {
        return issuerid;
    }

    public void setIssuerid(long issuerid) {
        this.issuerid = issuerid;
    }


    public void setRecieverid(int recieverid) {
        this.recieverid = recieverid;
    }


    public void setIssuerid(int issuerid) {
        this.issuerid = issuerid;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }


}
