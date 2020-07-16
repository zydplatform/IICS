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
@Table(name = "filelocation", catalog = "iics_database", schema = "patient")

public class FileLocation {
  @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int locationid;
@Basic(optional = false)
@NotNull
@Column(name = "zoneid", nullable = false)
private int zoneid ;
@Basic(optional = false)
@NotNull
@Column(name = "cellid", nullable = false)
private int cellid ;

@Basic(optional = false)
@NotNull
@Column(name = "fileno", nullable = false)
private String fileno; 
@Basic(optional = false)
@NotNull
@Column(name = "datecreated", nullable = false)
private Date datecreated;  

    public int getLocationid() {
        return locationid;
    }

    public void setLocationid(int locationid) {
        this.locationid = locationid;
    }

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

    public int getZoneid() {
        return zoneid;
    }

    public void setZoneid(int zoneid) {
        this.zoneid = zoneid;
    }

    public int getCellid() {
        return cellid;
    }

    public void setCellid(int cellid) {
        this.cellid = cellid;
    }
public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }
}
