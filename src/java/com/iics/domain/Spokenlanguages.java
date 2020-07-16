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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author EARTHQUAKER
 */
@Entity
@Table(name = "spokenlanguages", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Spokenlanguages.findAll", query = "SELECT s FROM Spokenlanguages s"),
    @NamedQuery(name = "Spokenlanguages.findByLanguageid", query = "SELECT s FROM Spokenlanguages s WHERE s.languageid = :languageid"),
    @NamedQuery(name = "Spokenlanguages.findByLanguagename", query = "SELECT s FROM Spokenlanguages s WHERE s.languagename = :languagename"),
    @NamedQuery(name = "Spokenlanguages.findByDateadded", query = "SELECT s FROM Spokenlanguages s WHERE s.dateadded = :dateadded"),
    @NamedQuery(name = "Spokenlanguages.findByArchived", query = "SELECT s FROM Spokenlanguages s WHERE s.archived = :archived"),
    @NamedQuery(name = "Spokenlanguages.findByAddedby", query = "SELECT s FROM Spokenlanguages s WHERE s.addedby = :addedby")})
public class Spokenlanguages implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "languageid")
    private Integer languageid;
    @Size(max = 2147483647)
    @Column(name = "languagename")
    private String languagename;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "archived")
    private Boolean archived;
    @Column(name = "addedby")
    private Integer addedby;

    public Spokenlanguages() {
    }

    public Spokenlanguages(Integer languageid) {
        this.languageid = languageid;
    }

    public Integer getLanguageid() {
        return languageid;
    }

    public void setLanguageid(Integer languageid) {
        this.languageid = languageid;
    }

    public String getLanguagename() {
        return languagename;
    }

    public void setLanguagename(String languagename) {
        this.languagename = languagename;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Boolean getArchived() {
        return archived;
    }

    public void setArchived(Boolean archived) {
        this.archived = archived;
    }

    public Integer getAddedby() {
        return addedby;
    }

    public void setAddedby(Integer addedby) {
        this.addedby = addedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (languageid != null ? languageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Spokenlanguages)) {
            return false;
        }
        Spokenlanguages other = (Spokenlanguages) object;
        if ((this.languageid == null && other.languageid != null) || (this.languageid != null && !this.languageid.equals(other.languageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Spokenlanguages[ languageid=" + languageid + " ]";
    }
    
}
