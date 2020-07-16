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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author samuelwam
 */
@Entity
@Table(name = "entityleveldescription", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Entityleveldescription.findAll", query = "SELECT e FROM Entityleveldescription e"),
    @NamedQuery(name = "Entityleveldescription.findByEntitylevelid", query = "SELECT e FROM Entityleveldescription e WHERE e.entitylevelid = :entitylevelid"),
    @NamedQuery(name = "Entityleveldescription.findByStatus", query = "SELECT e FROM Entityleveldescription e WHERE e.status = :status"),
    @NamedQuery(name = "Entityleveldescription.findByDateadded", query = "SELECT e FROM Entityleveldescription e WHERE e.dateadded = :dateadded"),
    @NamedQuery(name = "Entityleveldescription.findByDateupdated", query = "SELECT e FROM Entityleveldescription e WHERE e.dateupdated = :dateupdated")})
public class Entityleveldescription implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "entitylevelid", nullable = false)
    private Long entitylevelid;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "description", length = 255)
    private String description;
    @JoinColumn(name = "descriptionid", referencedColumnName = "descriptionid", nullable = false)
    @ManyToOne(optional = false)
    private Entitydescription entitydescription;
    @JoinColumn(name = "facilitylevelid", referencedColumnName = "facilitylevelid", nullable = false)
    @ManyToOne(optional = false)
    private Facilitylevel facilitylevel;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;

    public Entityleveldescription() {
    }

    public Entityleveldescription(Long entitylevelid) {
        this.entitylevelid = entitylevelid;
    }

    public Long getEntitylevelid() {
        return entitylevelid;
    }

    public void setEntitylevelid(Long entitylevelid) {
        this.entitylevelid = entitylevelid;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Entitydescription getEntitydescription() {
        return entitydescription;
    }

    public void setEntitydescription(Entitydescription entitydescription) {
        this.entitydescription = entitydescription;
    }

    public Facilitylevel getFacilitylevel() {
        return facilitylevel;
    }

    public void setFacilitylevel(Facilitylevel facilitylevel) {
        this.facilitylevel = facilitylevel;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public Person getPerson1() {
        return person1;
    }

    public void setPerson1(Person person1) {
        this.person1 = person1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (entitylevelid != null ? entitylevelid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Entityleveldescription)) {
            return false;
        }
        Entityleveldescription other = (Entityleveldescription) object;
        if ((this.entitylevelid == null && other.entitylevelid != null) || (this.entitylevelid != null && !this.entitylevelid.equals(other.entitylevelid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domains.Entityleveldescription[ entitylevelid=" + entitylevelid + " ]";
    }
    
}
