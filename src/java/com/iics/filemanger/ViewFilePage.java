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
@Table(name = "viewfiledocument", catalog = "iics_database", schema = "patient")
public class ViewFilePage {
   @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int documentid;
@Basic(optional = false)
@NotNull
@Column(name = "description", nullable = false)
private String description; 

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
@Column(name = "firstname", nullable = false)
private String firstname; 
@Basic(optional = false)
@NotNull
@Column(name = "lastname", nullable = false)
private String lastname; 

@Basic(optional = false)
@NotNull
@Column(name = "datecreated", nullable = false)
private Date datecreated;

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

   

    public int getDocumentid() {
        return documentid;
    }

    public void setDocumentid(int documentid) {
        this.documentid = documentid;
    }
     public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
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
  
}
