/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "unitcatalogue", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unitcatalogue.findAll", query = "SELECT u FROM Unitcatalogue u")
    , @NamedQuery(name = "Unitcatalogue.findByUnitcatalogueitemid", query = "SELECT u FROM Unitcatalogue u WHERE u.unitcatalogueitemid = :unitcatalogueitemid")
    , @NamedQuery(name = "Unitcatalogue.findByItemid", query = "SELECT u FROM Unitcatalogue u WHERE u.itemid = :itemid")
    , @NamedQuery(name = "Unitcatalogue.findByItemcode", query = "SELECT u FROM Unitcatalogue u WHERE u.itemcode = :itemcode")
    , @NamedQuery(name = "Unitcatalogue.findByGenericname", query = "SELECT u FROM Unitcatalogue u WHERE u.genericname = :genericname")
    , @NamedQuery(name = "Unitcatalogue.findByFormname", query = "SELECT u FROM Unitcatalogue u WHERE u.formname = :formname")
    , @NamedQuery(name = "Unitcatalogue.findByItemformid", query = "SELECT u FROM Unitcatalogue u WHERE u.itemformid = :itemformid")
    , @NamedQuery(name = "Unitcatalogue.findByItemcategoryid", query = "SELECT u FROM Unitcatalogue u WHERE u.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Unitcatalogue.findByCategoryname", query = "SELECT u FROM Unitcatalogue u WHERE u.categoryname = :categoryname")
    , @NamedQuery(name = "Unitcatalogue.findByItemclassificationid", query = "SELECT u FROM Unitcatalogue u WHERE u.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Unitcatalogue.findByClassificationname", query = "SELECT u FROM Unitcatalogue u WHERE u.classificationname = :classificationname")
    , @NamedQuery(name = "Unitcatalogue.findByFacilityunitid", query = "SELECT u FROM Unitcatalogue u WHERE u.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Unitcatalogue.findByCatitemstatus", query = "SELECT u FROM Unitcatalogue u WHERE u.catitemstatus = :catitemstatus")
    , @NamedQuery(name = "Unitcatalogue.findByIsactive", query = "SELECT u FROM Unitcatalogue u WHERE u.isactive = :isactive")
    , @NamedQuery(name = "Unitcatalogue.findByFacilityid", query = "SELECT u FROM Unitcatalogue u WHERE u.facilityid = :facilityid")
    , @NamedQuery(name = "Unitcatalogue.findByFullname", query = "SELECT u FROM Unitcatalogue u WHERE u.fullname = :fullname")
    , @NamedQuery(name = "Unitcatalogue.findByItemstrength", query = "SELECT u FROM Unitcatalogue u WHERE u.itemstrength = :itemstrength")
    , @NamedQuery(name = "Unitcatalogue.findByItemform", query = "SELECT u FROM Unitcatalogue u WHERE u.itemform = :itemform")
    , @NamedQuery(name = "Unitcatalogue.findByIssupplies", query = "SELECT u FROM Unitcatalogue u WHERE u.issupplies = :issupplies")
    , @NamedQuery(name = "Unitcatalogue.findBySpecification", query = "SELECT u FROM Unitcatalogue u WHERE u.specification = :specification")
    , @NamedQuery(name = "Unitcatalogue.findByPackagename", query = "SELECT u FROM Unitcatalogue u WHERE u.packagename = :packagename")
    , @NamedQuery(name = "Unitcatalogue.findByPackagequantity", query = "SELECT u FROM Unitcatalogue u WHERE u.packagequantity = :packagequantity")})
public class Unitcatalogue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "unitcatalogueitemid")
    private BigInteger unitcatalogueitemid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "itemcode", length = 2147483647)
    private String itemcode;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Size(max = 2147483647)
    @Column(name = "formname", length = 2147483647)
    private String formname;
    @Column(name = "itemformid")
    private Integer itemformid;
    @Column(name = "itemcategoryid")
    private BigInteger itemcategoryid;
    @Size(max = 2147483647)
    @Column(name = "categoryname", length = 2147483647)
    private String categoryname;
    @Column(name = "itemclassificationid")
    private BigInteger itemclassificationid;
    @Size(max = 2147483647)
    @Column(name = "classificationname", length = 2147483647)
    private String classificationname;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Size(max = 255)
    @Column(name = "catitemstatus", length = 255)
    private String catitemstatus;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Size(max = 2147483647)
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Size(max = 2147483647)
    @Column(name = "itemstrength", length = 2147483647)
    private String itemstrength;
    @Size(max = 2147483647)
    @Column(name = "itemform", length = 2147483647)
    private String itemform;
    @Column(name = "issupplies")
    private Boolean issupplies;
    @Size(max = 2147483647)
    @Column(name = "specification", length = 2147483647)
    private String specification;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;
    @Column(name = "packagequantity")
    private Integer packagequantity;

    public Unitcatalogue() {
    }

    public BigInteger getUnitcatalogueitemid() {
        return unitcatalogueitemid;
    }

    public void setUnitcatalogueitemid(BigInteger unitcatalogueitemid) {
        this.unitcatalogueitemid = unitcatalogueitemid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public String getItemcode() {
        return itemcode;
    }

    public void setItemcode(String itemcode) {
        this.itemcode = itemcode;
    }

    public String getGenericname() {
        return genericname;
    }

    public void setGenericname(String genericname) {
        this.genericname = genericname;
    }

    public String getFormname() {
        return formname;
    }

    public void setFormname(String formname) {
        this.formname = formname;
    }

    public Integer getItemformid() {
        return itemformid;
    }

    public void setItemformid(Integer itemformid) {
        this.itemformid = itemformid;
    }

    public BigInteger getItemcategoryid() {
        return itemcategoryid;
    }

    public void setItemcategoryid(BigInteger itemcategoryid) {
        this.itemcategoryid = itemcategoryid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public BigInteger getItemclassificationid() {
        return itemclassificationid;
    }

    public void setItemclassificationid(BigInteger itemclassificationid) {
        this.itemclassificationid = itemclassificationid;
    }

    public String getClassificationname() {
        return classificationname;
    }

    public void setClassificationname(String classificationname) {
        this.classificationname = classificationname;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getCatitemstatus() {
        return catitemstatus;
    }

    public void setCatitemstatus(String catitemstatus) {
        this.catitemstatus = catitemstatus;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getItemstrength() {
        return itemstrength;
    }

    public void setItemstrength(String itemstrength) {
        this.itemstrength = itemstrength;
    }

    public String getItemform() {
        return itemform;
    }

    public void setItemform(String itemform) {
        this.itemform = itemform;
    }

    public Boolean getIssupplies() {
        return issupplies;
    }

    public void setIssupplies(Boolean issupplies) {
        this.issupplies = issupplies;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    public String getPackagename() {
        return packagename;
    }

    public void setPackagename(String packagename) {
        this.packagename = packagename;
    }

    public Integer getPackagequantity() {
        return packagequantity;
    }

    public void setPackagequantity(Integer packagequantity) {
        this.packagequantity = packagequantity;
    }
    
}
