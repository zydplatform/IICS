/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "supplier", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Supplier.findAll", query = "SELECT s FROM Supplier s")
    , @NamedQuery(name = "Supplier.findBySupplierid", query = "SELECT s FROM Supplier s WHERE s.supplierid = :supplierid")
    , @NamedQuery(name = "Supplier.findBySuppliername", query = "SELECT s FROM Supplier s WHERE s.suppliername = :suppliername")
    , @NamedQuery(name = "Supplier.findBySuppliercode", query = "SELECT s FROM Supplier s WHERE s.suppliercode = :suppliercode")
    , @NamedQuery(name = "Supplier.findByTransactions", query = "SELECT s FROM Supplier s WHERE s.transactions = :transactions")
    , @NamedQuery(name = "Supplier.findByVillageid", query = "SELECT s FROM Supplier s WHERE s.villageid = :villageid")
    , @NamedQuery(name = "Supplier.findByPhysicaladdress", query = "SELECT s FROM Supplier s WHERE s.physicaladdress = :physicaladdress")
    , @NamedQuery(name = "Supplier.findByPostaladdress", query = "SELECT s FROM Supplier s WHERE s.postaladdress = :postaladdress")
    , @NamedQuery(name = "Supplier.findByEmailaddress", query = "SELECT s FROM Supplier s WHERE s.emailaddress = :emailaddress")
    , @NamedQuery(name = "Supplier.findByOfficetel", query = "SELECT s FROM Supplier s WHERE s.officetel = :officetel")
    , @NamedQuery(name = "Supplier.findByFax", query = "SELECT s FROM Supplier s WHERE s.fax = :fax")
    , @NamedQuery(name = "Supplier.findByActive", query = "SELECT s FROM Supplier s WHERE s.active = :active")
    , @NamedQuery(name = "Supplier.findByOperations", query = "SELECT s FROM Supplier s WHERE s.operations = :operations")
    , @NamedQuery(name = "Supplier.findByTin", query = "SELECT s FROM Supplier s WHERE s.tin = :tin")})
public class Supplier implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "supplierid", nullable = false)
    private Long supplierid;
    @Size(max = 2147483647)
    @Column(name = "suppliername", length = 2147483647)
    private String suppliername;
    @Size(max = 2147483647)
    @Column(name = "suppliercode", length = 2147483647)
    private String suppliercode;
    @Size(max = 2147483647)
    @Column(name = "transactions", length = 2147483647)
    private String transactions;
    @Column(name = "villageid")
    private Integer villageid;
    @Size(max = 2147483647)
    @Column(name = "physicaladdress", length = 2147483647)
    private String physicaladdress;
    @Size(max = 2147483647)
    @Column(name = "postaladdress", length = 2147483647)
    private String postaladdress;
    @Size(max = 2147483647)
    @Column(name = "emailaddress", length = 2147483647)
    private String emailaddress;
    @Size(max = 255)
    @Column(name = "officetel", length = 255)
    private String officetel;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Size(max = 255)
    @Column(name = "fax", length = 255)
    private String fax;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active", nullable = false)
    private boolean active;
    @Size(max = 255)
    @Column(name = "operations", length = 255)
    private String operations;
    @Size(max = 255)
    @Column(name = "tin", length = 255)
    private String tin;
    @OneToMany(mappedBy = "supplierid")
    private List<Externalfacilityorders> externalfacilityordersList;
    @OneToMany(mappedBy = "supplierid")
    private List<Supplieritem> supplieritemList;
    @OneToMany(mappedBy = "supplierid")
    private List<Suppliercontactperson> suppliercontactpersonList;

    public Supplier() {
    }

    public Supplier(Long supplierid) {
        this.supplierid = supplierid;
    }

    public Supplier(Long supplierid, boolean active) {
        this.supplierid = supplierid;
        this.active = active;
    }

    public Long getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(Long supplierid) {
        this.supplierid = supplierid;
    }

    public String getSuppliername() {
        return suppliername;
    }

    public void setSuppliername(String suppliername) {
        this.suppliername = suppliername;
    }

    public String getSuppliercode() {
        return suppliercode;
    }

    public void setSuppliercode(String suppliercode) {
        this.suppliercode = suppliercode;
    }

    public String getTransactions() {
        return transactions;
    }

    public void setTransactions(String transactions) {
        this.transactions = transactions;
    }

    public Integer getVillageid() {
        return villageid;
    }

    public void setVillageid(Integer villageid) {
        this.villageid = villageid;
    }

    public String getPhysicaladdress() {
        return physicaladdress;
    }

    public void setPhysicaladdress(String physicaladdress) {
        this.physicaladdress = physicaladdress;
    }

    public String getPostaladdress() {
        return postaladdress;
    }

    public void setPostaladdress(String postaladdress) {
        this.postaladdress = postaladdress;
    }

    public String getEmailaddress() {
        return emailaddress;
    }

    public void setEmailaddress(String emailaddress) {
        this.emailaddress = emailaddress;
    }

    public String getOfficetel() {
        return officetel;
    }

    public void setOfficetel(String officetel) {
        this.officetel = officetel;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getOperations() {
        return operations;
    }

    public void setOperations(String operations) {
        this.operations = operations;
    }

    public String getTin() {
        return tin;
    }

    public void setTin(String tin) {
        this.tin = tin;
    }

    @XmlTransient
    public List<Externalfacilityorders> getExternalfacilityordersList() {
        return externalfacilityordersList;
    }

    public void setExternalfacilityordersList(List<Externalfacilityorders> externalfacilityordersList) {
        this.externalfacilityordersList = externalfacilityordersList;
    }

    @XmlTransient
    public List<Supplieritem> getSupplieritemList() {
        return supplieritemList;
    }

    public void setSupplieritemList(List<Supplieritem> supplieritemList) {
        this.supplieritemList = supplieritemList;
    }

    @XmlTransient
    public List<Suppliercontactperson> getSuppliercontactpersonList() {
        return suppliercontactpersonList;
    }

    public void setSuppliercontactpersonList(List<Suppliercontactperson> suppliercontactpersonList) {
        this.suppliercontactpersonList = suppliercontactpersonList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (supplierid != null ? supplierid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Supplier)) {
            return false;
        }
        Supplier other = (Supplier) object;
        if ((this.supplierid == null && other.supplierid != null) || (this.supplierid != null && !this.supplierid.equals(other.supplierid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Supplier[ supplierid=" + supplierid + " ]";
    }
    
}
