/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.persistence.MappedSuperclass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author samuelwam
 */
@Entity
@Table(name = "facilitystructure", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitystructure.findAll", query = "SELECT o FROM Facilitystructure o"),
    @NamedQuery(name = "Facilitystructure.findByStructureid", query = "SELECT o FROM Facilitystructure o WHERE o.structureid = :structureid"),
    @NamedQuery(name = "Facilitystructure.findByHierachylabel", query = "SELECT o FROM Facilitystructure o WHERE o.hierachylabel = :hierachylabel"),
    @NamedQuery(name = "Facilitystructure.findByDescription", query = "SELECT o FROM Facilitystructure o WHERE o.description = :description"),
    @NamedQuery(name = "Facilitystructure.findByPosition", query = "SELECT o FROM Facilitystructure o WHERE o.position = :position"),
    @NamedQuery(name = "Facilitystructure.findByDateadded", query = "SELECT o FROM Facilitystructure o WHERE o.dateadded = :dateadded"),
    @NamedQuery(name = "Facilitystructure.findByDateupdated", query = "SELECT o FROM Facilitystructure o WHERE o.dateupdated = :dateupdated"),
    @NamedQuery(name = "Facilitystructure.findByActive", query = "SELECT o FROM Facilitystructure o WHERE o.active = :active"),
    @NamedQuery(name = "Facilitystructure.findByUnits", query = "SELECT o FROM Facilitystructure o WHERE o.units = :units")})
public class Facilitystructure implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "FacilitystructureSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "FacilitystructureSeq", sequenceName = "facilitystructure_structureid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "structureid", nullable = false)
    private Long structureid;
    @Basic(optional = false)
    @Column(name = "hierachylabel", nullable = false, length = 2147483647)
    private String hierachylabel;
    @Column(name = "description", length = 2147483647)
    private String description;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Basic(optional = false)
    @Column(name = "position", nullable = false)
    private int position;
    @Column(name = "isparent")
    private boolean isparent;
    @Basic(optional = false)
    @Column(name = "dateadded", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "units")
    private Integer units;
    @Column(name = "items")
    private Integer items;
    @Column(name = "service", nullable = false)
    private Boolean service;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid", nullable = false)
    @ManyToOne(optional = false)
    private Facility facility;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilitystructure")
    private List<Facilitystructure> facilitystructureList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilitystructure")
    private List<Facilityunit> facilityunitList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilitystructure")
    private List<Facilityunithierachy> facilityunithierachyList;
    @JoinColumn(name = "parentid", referencedColumnName = "structureid")
    @ManyToOne
    private Facilitystructure facilitystructure;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;

    public Facilitystructure() {
    }

    public Facilitystructure(Long structureid) {
        this.structureid = structureid;
    }

    public Facilitystructure(Long structureid, String hierachylabel, boolean active, Date dateadded) {
        this.structureid = structureid;
        this.hierachylabel = hierachylabel;
        this.active = active;
        this.dateadded = dateadded;
    }

    public Long getStructureid() {
        return structureid;
    }

    public void setStructureid(Long structureid) {
        this.structureid = structureid;
    }

    public String getHierachylabel() {
        return hierachylabel;
    }

    public void setHierachylabel(String hierachylabel) {
        this.hierachylabel = hierachylabel;
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

    public Boolean getService() {
        return service;
    }

    public void setService(Boolean service) {
        this.service = service;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public boolean getIsparent() {
        return isparent;
    }

    public void setIsparent(boolean isparent) {
        this.isparent = isparent;
    }

    public Integer getUnits() {
        return units;
    }

    public void setUnits(Integer units) {
        this.units = units;
    }

    public Integer getItems() {
        return items;
    }

    public void setItems(Integer items) {
        this.items = items;
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

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public List<Facilitystructure> getFacilitystructureList() {
        return facilitystructureList;
    }

    public void setFacilitystructureList(List<Facilitystructure> facilitystructureList) {
        this.facilitystructureList = facilitystructureList;
    }

    public List<Facilityunit> getFacilityunitList() {
        return facilityunitList;
    }

    public void setFacilityunitList(List<Facilityunit> facilityunitList) {
        this.facilityunitList = facilityunitList;
    }

    public List<Facilityunithierachy> getFacilityunithierachyList() {
        return facilityunithierachyList;
    }

    public void setFacilityunithierachyList(List<Facilityunithierachy> facilityunithierachyList) {
        this.facilityunithierachyList = facilityunithierachyList;
    }

    public Facilitystructure getFacilitystructure() {
        return facilitystructure;
    }

    public void setFacilitystructure(Facilitystructure facilitystructure) {
        this.facilitystructure = facilitystructure;
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
        hash += (structureid != null ? structureid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitystructure)) {
            return false;
        }
        Facilitystructure other = (Facilitystructure) object;
        if ((this.structureid == null && other.structureid != null) || (this.structureid != null && !this.structureid.equals(other.structureid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitystructure[ structureid=" + structureid + " ]";
    }
    
}
