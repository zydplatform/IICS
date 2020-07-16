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
@Table(name = "filerequisition", catalog = "iics_database", schema = "patient")
public class FileRequisition {
    @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private long requestid;
@Basic(optional = false)
@NotNull
@Column(name = "requestedby", nullable = false)
private long requestedby;
@Basic(optional = false)

@Column(name = "approvedby", nullable = false)
private long approvedbystaffid;
@Basic(optional = false)
@NotNull
@Column(name = "requesteddate", nullable = false)
private Date requesteddate;
@Basic(optional = false)
@NotNull
@Column(name = "requestdate", nullable = false)
private Date requestdate;
@Basic(optional = false)

@Column(name = "approveddate", nullable = false)
private Date approveddate;
@Basic(optional = false)
@NotNull
@Column(name = "assignmentid", nullable = false) 
private long assignmentid;
@Basic(optional = false)
@NotNull
@Column(name = "status", nullable = false)
private String requeststatus;
    public long getRequestid() {
        return requestid;
    }

    public void setRequestid(long requestid) {
        this.requestid = requestid;
    }

    public Date getRequestdate() {
        return requestdate;
    }

    public void setRequestdate(Date requestdate) {
        this.requestdate = requestdate;
    }

    public String getRequeststatus() {
        return requeststatus;
    }

    public void setRequeststatus(String requeststatus) {
        this.requeststatus = requeststatus;
    }


    public long getRequestedby() {
        return requestedby;
    }

    public void setRequestedby(long requestedby) {
        this.requestedby = requestedby;
    }

    public long getApprovedbystaffid() {
        return approvedbystaffid;
    }

    public void setApprovedbystaffid(long approvedbystaffid) {
        this.approvedbystaffid = approvedbystaffid;
    }

    public Date getRequesteddate() {
        return requesteddate;
    }

    public void setRequesteddate(Date requesteddate) {
        this.requesteddate = requesteddate;
    }

    public Date getApproveddate() {
        return approveddate;
    }

    public void setApproveddate(Date approveddate) {
        this.approveddate = approveddate;
    }

    public long getAssignmentid() {
        return assignmentid;
    }

    public void setAssignmentid(long assignmentid) {
        this.assignmentid = assignmentid;
    }

    

    




}
