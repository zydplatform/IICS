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

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilitypolicy", catalog = "iics_database", schema = "public")
@NamedQueries({
    @NamedQuery(name = "Facilitypolicy.findAll", query = "SELECT f FROM Facilitypolicy f")
    , @NamedQuery(name = "Facilitypolicy.findByPolicyid", query = "SELECT f FROM Facilitypolicy f WHERE f.policyid = :policyid")
    , @NamedQuery(name = "Facilitypolicy.findByPolicyname", query = "SELECT f FROM Facilitypolicy f WHERE f.policyname = :policyname")
    , @NamedQuery(name = "Facilitypolicy.findByDescription", query = "SELECT f FROM Facilitypolicy f WHERE f.description = :description")
    , @NamedQuery(name = "Facilitypolicy.findByDatatype", query = "SELECT f FROM Facilitypolicy f WHERE f.datatype = :datatype")
    , @NamedQuery(name = "Facilitypolicy.findByOptions", query = "SELECT f FROM Facilitypolicy f WHERE f.options = :options")
    , @NamedQuery(name = "Facilitypolicy.findByStatus", query = "SELECT f FROM Facilitypolicy f WHERE f.status = :status")
    , @NamedQuery(name = "Facilitypolicy.findByLimited", query = "SELECT f FROM Facilitypolicy f WHERE f.limited = :limited")
    , @NamedQuery(name = "Facilitypolicy.findByDateadded", query = "SELECT f FROM Facilitypolicy f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilitypolicy.findByDateupdated", query = "SELECT f FROM Facilitypolicy f WHERE f.dateupdated = :dateupdated")})
public class Facilitypolicy implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "Facilitypolicy_seq")
    @SequenceGenerator(name = "Facilitypolicy_seq", sequenceName = "facilitypolicy_policyid_seq", allocationSize = 1)
    
    @Basic(optional = false)
    @Column(name = "policyid", nullable = false)
    private Long policyid;
    @Basic(optional = false)
    @Column(name = "category", nullable = false, length = 2147483647)
    private String category;
    @Basic(optional = false)
    @Column(name = "policyname", nullable = false, length = 2147483647)
    private String policyname;
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "datatype", length = 2147483647)
    private String datatype;
    @Column(name = "options", length = 2147483647)
    private String options;
    @Column(name = "options2", length = 2147483647)
    private String options2;
    @Basic(optional = false)
    @Column(name = "status", nullable = false)
    private boolean status;
    @Column(name = "limited")
    private Boolean limited;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "addedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilitypolicy")
    private List<Facilitypolicyoptions> facilitypolicyoptionsList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilitypolicy")
    private List<Facilityassignedpolicy> facilityassignedpolicys;

    public Facilitypolicy() {
    }

    public Facilitypolicy(Long policyid) {
        this.policyid = policyid;
    }

    public Facilitypolicy(Long policyid, String policyname, boolean status) {
        this.policyid = policyid;
        this.policyname = policyname;
        this.status = status;
    }

    public Long getPolicyid() {
        return policyid;
    }

    public void setPolicyid(Long policyid) {
        this.policyid = policyid;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getPolicyname() {
        return policyname;
    }

    public void setPolicyname(String policyname) {
        this.policyname = policyname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDatatype() {
        return datatype;
    }

    public void setDatatype(String datatype) {
        this.datatype = datatype;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
    }
    
     public String getOptions2() {
        return options2;
    }

    public void setOptions2(String options2) {
        this.options2 = options2;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Boolean getLimited() {
        return limited;
    }

    public void setLimited(Boolean limited) {
        this.limited = limited;
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

    public List<Facilitypolicyoptions> getFacilitypolicyoptionsList() {
        return facilitypolicyoptionsList;
    }

    public void setFacilitypolicyoptionsList(List<Facilitypolicyoptions> facilitypolicyoptionsList) {
        this.facilitypolicyoptionsList = facilitypolicyoptionsList;
    }

    public List<Facilityassignedpolicy> getFacilityassignedpolicys() {
        return facilityassignedpolicys;
    }

    public void setFacilityassignedpolicys(List<Facilityassignedpolicy> facilityassignedpolicys) {
        this.facilityassignedpolicys = facilityassignedpolicys;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (policyid != null ? policyid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilitypolicy)) {
            return false;
        }
        Facilitypolicy other = (Facilitypolicy) object;
        if ((this.policyid == null && other.policyid != null) || (this.policyid != null && !this.policyid.equals(other.policyid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facilitypolicy[ policyid=" + policyid + " ]";
    }
    
}
