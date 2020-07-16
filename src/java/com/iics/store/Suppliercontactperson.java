/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "suppliercontactperson", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Suppliercontactperson.findAll", query = "SELECT s FROM Suppliercontactperson s")
    , @NamedQuery(name = "Suppliercontactperson.findBySuppliercontactpersonid", query = "SELECT s FROM Suppliercontactperson s WHERE s.suppliercontactpersonid = :suppliercontactpersonid")
    , @NamedQuery(name = "Suppliercontactperson.findByPersonid", query = "SELECT s FROM Suppliercontactperson s WHERE s.personid = :personid")
    , @NamedQuery(name = "Suppliercontactperson.findByPersonrole", query = "SELECT s FROM Suppliercontactperson s WHERE s.personrole = :personrole")
    , @NamedQuery(name = "Suppliercontactperson.findByMobile", query = "SELECT s FROM Suppliercontactperson s WHERE s.mobile = :mobile")
    , @NamedQuery(name = "Suppliercontactperson.findByEmailaddress", query = "SELECT s FROM Suppliercontactperson s WHERE s.emailaddress = :emailaddress")
    , @NamedQuery(name = "Suppliercontactperson.findByActive", query = "SELECT s FROM Suppliercontactperson s WHERE s.active = :active")})
public class Suppliercontactperson implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "suppliercontactpersonid", nullable = false)
    private Long suppliercontactpersonid;
    @Column(name = "personid")
    private BigInteger personid;
    @Size(max = 2147483647)
    @Column(name = "personrole", length = 2147483647)
    private String personrole;
    @Size(max = 255)
    @Column(name = "mobile", length = 255)
    private String mobile;
    @Size(max = 255)
    @Column(name = "emailaddress", length = 255)
    private String emailaddress;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active", nullable = false)
    private boolean active;
    @JoinColumn(name = "supplierid", referencedColumnName = "supplierid")
    @ManyToOne
    private Supplier supplierid;

    public Suppliercontactperson() {
    }

    public Suppliercontactperson(Long suppliercontactpersonid) {
        this.suppliercontactpersonid = suppliercontactpersonid;
    }

    public Suppliercontactperson(Long suppliercontactpersonid, boolean active) {
        this.suppliercontactpersonid = suppliercontactpersonid;
        this.active = active;
    }

    public Long getSuppliercontactpersonid() {
        return suppliercontactpersonid;
    }

    public void setSuppliercontactpersonid(Long suppliercontactpersonid) {
        this.suppliercontactpersonid = suppliercontactpersonid;
    }

    public BigInteger getPersonid() {
        return personid;
    }

    public void setPersonid(BigInteger personid) {
        this.personid = personid;
    }

    public String getPersonrole() {
        return personrole;
    }

    public void setPersonrole(String personrole) {
        this.personrole = personrole;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmailaddress() {
        return emailaddress;
    }

    public void setEmailaddress(String emailaddress) {
        this.emailaddress = emailaddress;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Supplier getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(Supplier supplierid) {
        this.supplierid = supplierid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (suppliercontactpersonid != null ? suppliercontactpersonid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Suppliercontactperson)) {
            return false;
        }
        Suppliercontactperson other = (Suppliercontactperson) object;
        if ((this.suppliercontactpersonid == null && other.suppliercontactpersonid != null) || (this.suppliercontactpersonid != null && !this.suppliercontactpersonid.equals(other.suppliercontactpersonid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Suppliercontactperson[ suppliercontactpersonid=" + suppliercontactpersonid + " ]";
    }
    
}
