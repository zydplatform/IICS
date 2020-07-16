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
@Table(name = "fileassignmentactivity", catalog = "iics_database", schema = "patient")
public class FileAssignmentActivity {
   @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int activityid;
@Basic(optional = false)
@NotNull
@Column(name = "staffid", nullable = false)
private long staffid;
   @Basic(optional = false)
@NotNull
@Column(name = "assignmentid", nullable = false)
private long assignmentid;
   @Basic(optional = false)
@NotNull
@Column(name = "assignmentaction", nullable = false)
private String assignmentaction ;
   @Basic(optional = false)
@NotNull
@Column(name = "actionDate", nullable = false)
private Date actionDate;

    public int getActivityid() {
        return activityid;
    }

    public void setActivityid(int activityid) {
        this.activityid = activityid;
    }

    public long getAssignmentid() {
        return assignmentid;
    }

    public void setAssignmentid(long assignmentid) {
        this.assignmentid = assignmentid;
    }


    public long getStaffid() {
        return staffid;
    }

    public void setStaffid(long staffid) {
        this.staffid = staffid;
    }

    public String getAssignmentaction() {
        return assignmentaction;
    }

    public void setAssignmentaction(String assignmentaction) {
        this.assignmentaction = assignmentaction;
    }

    public Date getActionDate() {
        return actionDate;
    }

    public void setActionDate(Date actionDate) {
        this.actionDate = actionDate;
    }
}
