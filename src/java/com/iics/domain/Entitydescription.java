/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author samuelwam
 */
@Entity
@Table(name = "entitydescription", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Entitydescription.findAll", query = "SELECT e FROM Entitydescription e"),
    @NamedQuery(name = "Entitydescription.findByDescriptionid", query = "SELECT e FROM Entitydescription e WHERE e.descriptionid = :descriptionid"),
    @NamedQuery(name = "Entitydescription.findByDescription", query = "SELECT e FROM Entitydescription e WHERE e.description = :description"),
    @NamedQuery(name = "Entitydescription.findByActive", query = "SELECT e FROM Entitydescription e WHERE e.active = :active"),
    @NamedQuery(name = "Entitydescription.findByDateadded", query = "SELECT e FROM Entitydescription e WHERE e.dateadded = :dateadded"),
    @NamedQuery(name = "Entitydescription.findByLevels", query = "SELECT e FROM Entitydescription e WHERE e.levels = :levels"),
    @NamedQuery(name = "Entitydescription.findByDateupdated", query = "SELECT e FROM Entitydescription e WHERE e.dateupdated = :dateupdated")})
public class Entitydescription implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @GeneratedValue(generator = "EntityDescriptionSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "EntityDescriptionSeq", sequenceName = "EntityDescription_descriptionid_seq", allocationSize = 1)

    @Column(name = "descriptionid", nullable = false)
    private Integer descriptionid;
    @Column(name = "description", length = 255)
    private String description;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "levels")
    private Integer levels;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "options", length = 255)
    private String options;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @JoinColumn(name = "facilitylevelid", referencedColumnName = "facilitylevelid", nullable = false)
    @ManyToOne(optional = false)
    private Facilitylevel facilitylevel;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "entitydescription")
    private List<Entityleveldescription> entityleveldescriptionList;

    public Entitydescription() {
    }

    public Entitydescription(Integer descriptionid) {
        this.descriptionid = descriptionid;
    }

    public Entitydescription(Integer descriptionid, boolean active) {
        this.descriptionid = descriptionid;
        this.active = active;
    }

    public Integer getDescriptionid() {
        return descriptionid;
    }

    public void setDescriptionid(Integer descriptionid) {
        this.descriptionid = descriptionid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Integer getLevels() {
        return levels;
    }

    public void setLevels(Integer levels) {
        this.levels = levels;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
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

    public Facilitylevel getFacilitylevel() {
        return facilitylevel;
    }

    public void setFacilitylevel(Facilitylevel facilitylevel) {
        this.facilitylevel = facilitylevel;
    }

    @XmlTransient
    public List<Entityleveldescription> getEntityleveldescriptionList() {
        return entityleveldescriptionList;
    }

    public void setEntityleveldescriptionList(List<Entityleveldescription> entityleveldescriptionList) {
        this.entityleveldescriptionList = entityleveldescriptionList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (descriptionid != null ? descriptionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Entitydescription)) {
            return false;
        }
        Entitydescription other = (Entitydescription) object;
        if ((this.descriptionid == null && other.descriptionid != null) || (this.descriptionid != null && !this.descriptionid.equals(other.descriptionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domains.Entitydescription[ descriptionid=" + descriptionid + " ]";
    }
    
}
