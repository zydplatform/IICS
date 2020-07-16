/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "systemuser", catalog = "iics_database", schema = "public", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"personid"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemuser.findAll", query = "SELECT s FROM Systemuser s")
    , @NamedQuery(name = "Systemuser.findBySystemuserid", query = "SELECT s FROM Systemuser s WHERE s.systemuserid = :systemuserid")
    , @NamedQuery(name = "Systemuser.findByPassword", query = "SELECT s FROM Systemuser s WHERE s.password = :password")
    , @NamedQuery(name = "Systemuser.findByUsername", query = "SELECT s FROM Systemuser s WHERE s.username = :username")
    , @NamedQuery(name = "Systemuser.findByActive", query = "SELECT s FROM Systemuser s WHERE s.active = :active")
    , @NamedQuery(name = "Systemuser.findByDatecreated", query = "SELECT s FROM Systemuser s WHERE s.datecreated = :datecreated")
    , @NamedQuery(name = "Systemuser.findByDatechanged", query = "SELECT s FROM Systemuser s WHERE s.datechanged = :datechanged")
    , @NamedQuery(name = "Systemuser.findByUserid", query = "SELECT s FROM Systemuser s WHERE s.userid = :userid")
    , @NamedQuery(name = "Systemuser.findByIndex", query = "SELECT s FROM Systemuser s WHERE s.index = :index")})
public class Systemuser implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "systemuserid", nullable = false)
    private Long systemuserid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "password", nullable = false, length = 2147483647)
    private String password;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "username", nullable = false, length = 2147483647)
    private String username;
    @Column(name = "active")
    private Boolean active;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Column(name = "datechanged")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datechanged;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "userid", precision = 19, scale = 2)
    private BigDecimal userid;
    @Column(name = "index")
    private Integer index;
    @JoinColumn(name = "changedby", referencedColumnName = "personid")
    @ManyToOne
    private Person changedby;
    @JoinColumn(name = "createdby", referencedColumnName = "personid")
    @ManyToOne
    private Person createdby;
    @JoinColumn(name = "personid", referencedColumnName = "personid", nullable = false)
    @OneToOne(optional = false)
    private Person personid;

    public Systemuser() {
    }

    public Systemuser(Long systemuserid) {
        this.systemuserid = systemuserid;
    }

    public Systemuser(Long systemuserid, String password, String username) {
        this.systemuserid = systemuserid;
        this.password = password;
        this.username = username;
    }

    public Long getSystemuserid() {
        return systemuserid;
    }

    public void setSystemuserid(Long systemuserid) {
        this.systemuserid = systemuserid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public Date getDatechanged() {
        return datechanged;
    }

    public void setDatechanged(Date datechanged) {
        this.datechanged = datechanged;
    }

    public BigDecimal getUserid() {
        return userid;
    }

    public void setUserid(BigDecimal userid) {
        this.userid = userid;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    public Person getChangedby() {
        return changedby;
    }

    public void setChangedby(Person changedby) {
        this.changedby = changedby;
    }

    public Person getCreatedby() {
        return createdby;
    }

    public void setCreatedby(Person createdby) {
        this.createdby = createdby;
    }

    public Person getPersonid() {
        return personid;
    }

    public void setPersonid(Person personid) {
        this.personid = personid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (systemuserid != null ? systemuserid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemuser)) {
            return false;
        }
        Systemuser other = (Systemuser) object;
        if ((this.systemuserid == null && other.systemuserid != null) || (this.systemuserid != null && !this.systemuserid.equals(other.systemuserid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Systemuser[ systemuserid=" + systemuserid + " ]";
    }
    
}
