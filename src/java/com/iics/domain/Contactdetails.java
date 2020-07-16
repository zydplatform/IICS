/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Grace-K
 */
@Entity
@Table(name = "contactdetails", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Contactdetails.findAll", query = "SELECT c FROM Contactdetails c")
    , @NamedQuery(name = "Contactdetails.findByContactdetailsid", query = "SELECT c FROM Contactdetails c WHERE c.contactdetailsid = :contactdetailsid")
    , @NamedQuery(name = "Contactdetails.findByContacttype", query = "SELECT c FROM Contactdetails c WHERE c.contacttype = :contacttype")
    , @NamedQuery(name = "Contactdetails.findByContactvalue", query = "SELECT c FROM Contactdetails c WHERE c.contactvalue = :contactvalue")})
public class Contactdetails implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "contactdetailsid", nullable = false)
    private Integer contactdetailsid;
    @Size(max = 255)
    @Column(name = "contacttype", length = 255)
    private String contacttype;
    @Size(max = 255)
    @Column(name = "contactvalue", length = 255)
    private String contactvalue;
    @Column(name = "personid")
    private long personid;

    public Contactdetails() {
    }

    public Contactdetails(Integer contactdetailsid) {
        this.contactdetailsid = contactdetailsid;
    }

    public Integer getContactdetailsid() {
        return contactdetailsid;
    }

    public void setContactdetailsid(Integer contactdetailsid) {
        this.contactdetailsid = contactdetailsid;
    }

    public String getContacttype() {
        return contacttype;
    }

    public void setContacttype(String contacttype) {
        this.contacttype = contacttype;
    }

    public String getContactvalue() {
        return contactvalue;
    }

    public void setContactvalue(String contactvalue) {
        this.contactvalue = contactvalue;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (contactdetailsid != null ? contactdetailsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Contactdetails)) {
            return false;
        }
        Contactdetails other = (Contactdetails) object;
        if ((this.contactdetailsid == null && other.contactdetailsid != null) || (this.contactdetailsid != null && !this.contactdetailsid.equals(other.contactdetailsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Contactdetails[ contactdetailsid=" + contactdetailsid + " ]";
    }

    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

}
