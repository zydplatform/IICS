/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author EARTHQUAKER
 */
@Entity
@Table(name = "personlanguage", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Personlanguage.findAll", query = "SELECT p FROM Personlanguage p"),
    @NamedQuery(name = "Personlanguage.findByPersonlanguageid", query = "SELECT p FROM Personlanguage p WHERE p.personlanguageid = :personlanguageid"),
    @NamedQuery(name = "Personlanguage.findByPersonid", query = "SELECT p FROM Personlanguage p WHERE p.personid = :personid"),
    @NamedQuery(name = "Personlanguage.findByLanguageid", query = "SELECT p FROM Personlanguage p WHERE p.languageid = :languageid")})
public class Personlanguage implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "personlanguageid")
    private Integer personlanguageid;
    @Column(name = "personid")
    private BigInteger personid;
    @Column(name = "languageid")
    private Integer languageid;

    public Personlanguage() {
    }

    public Personlanguage(Integer personlanguageid) {
        this.personlanguageid = personlanguageid;
    }

    public Integer getPersonlanguageid() {
        return personlanguageid;
    }

    public void setPersonlanguageid(Integer personlanguageid) {
        this.personlanguageid = personlanguageid;
    }

    public BigInteger getPersonid() {
        return personid;
    }

    public void setPersonid(BigInteger personid) {
        this.personid = personid;
    }

    public Integer getLanguageid() {
        return languageid;
    }

    public void setLanguageid(Integer languageid) {
        this.languageid = languageid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (personlanguageid != null ? personlanguageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Personlanguage)) {
            return false;
        }
        Personlanguage other = (Personlanguage) object;
        if ((this.personlanguageid == null && other.personlanguageid != null) || (this.personlanguageid != null && !this.personlanguageid.equals(other.personlanguageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Personlanguage[ personlanguageid=" + personlanguageid + " ]";
    }
    
}
