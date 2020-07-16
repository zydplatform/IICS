/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS PROJECT
 */
@Entity
@Table(name = "requisition", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Requisition.findAll", query = "SELECT r FROM Requisition r")
    , @NamedQuery(name = "Requisition.findByRequisitionid", query = "SELECT r FROM Requisition r WHERE r.requisitionid = :requisitionid")
    , @NamedQuery(name = "Requisition.findByStatus", query = "SELECT r FROM Requisition r WHERE r.status = :status")
    , @NamedQuery(name = "Requisition.findByDatecreated", query = "SELECT r FROM Requisition r WHERE r.datecreated = :datecreated")})
public class Requisition implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "requisitionid", nullable = false)
    private Integer requisitionid;
    @Size(max = 255)
    @Column(name = "status", length = 255)
    private String status;
    @Column(name = "datecreated")
    @Temporal(TemporalType.DATE)
    private Date datecreated;
    @Column(name = "datedenied")
    @Temporal(TemporalType.DATE)
    private Date datedenied;

    public Date getDatedenied() {
        return datedenied;
    }

    public void setDatedenied(Date datedenied) {
        this.datedenied = datedenied;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @Column(name = "staffid")
    private long staffid;
    @Column(name = "recommender")
    private long recommender;
    @Column(name = "links", length = 255)
    private String links;
    @Column(name = "reasonfordenial", length = 255)
    private String reasonfordenial;

    public String getReasonfordenial() {
        return reasonfordenial;
    }

    public void setReasonfordenial(String reasonfordenial) {
        this.reasonfordenial = reasonfordenial;
    }
    

    public String getLinks() {
        return links;
    }

    public void setLinks(String links) {
        this.links = links;
    }

    public long getRecommender() {
        return recommender;
    }

    public void setRecommender(long recommender) {
        this.recommender = recommender;
    }
    public long getStaffid() {
        return staffid;
    }

    public void setStaffid(long staffid) {
        this.staffid = staffid;
    }

    public Requisition() {
    }

    public Requisition(Integer requisitionid) {
        this.requisitionid = requisitionid;
    }

    public Integer getRequisitionid() {
        return requisitionid;
    }

    public void setRequisitionid(Integer requisitionid) {
        this.requisitionid = requisitionid;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (requisitionid != null ? requisitionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Requisition)) {
            return false;
        }
        Requisition other = (Requisition) object;
        if ((this.requisitionid == null && other.requisitionid != null) || (this.requisitionid != null && !this.requisitionid.equals(other.requisitionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Requisition[ requisitionid=" + requisitionid + " ]";
    }
    
}
