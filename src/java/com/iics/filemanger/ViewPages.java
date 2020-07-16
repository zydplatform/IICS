/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.filemanger;

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
@Table(name = "viewfilepage", catalog = "iics_database", schema = "patient")

public class ViewPages {
      @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private long pageid;
@Basic(optional = false)
@NotNull
@Column(name = "doctumentid", nullable = false)
private long doctumentid; 
@Basic(optional = false)
@NotNull
@Column(name = "fileno", nullable = false)
private String fileno;

    public long getPageid() {
        return pageid;
    }

    public void setPageid(long pageid) {
        this.pageid = pageid;
    }

    public long getDoctumentid() {
        return doctumentid;
    }

    public void setDoctumentid(long doctumentid) {
        this.doctumentid = doctumentid;
    }

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }
}
