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
@Table(name = "facilitycatalogue", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitycatalogue.findAll", query = "SELECT f FROM Facilitycatalogue f")
    , @NamedQuery(name = "Facilitycatalogue.findByFacilityid", query = "SELECT f FROM Facilitycatalogue f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitycatalogue.findByItemid", query = "SELECT f FROM Facilitycatalogue f WHERE f.itemid = :itemid")
    , @NamedQuery(name = "Facilitycatalogue.findByGenericname", query = "SELECT f FROM Facilitycatalogue f WHERE f.genericname = :genericname")
    , @NamedQuery(name = "Facilitycatalogue.findByItemformid", query = "SELECT f FROM Facilitycatalogue f WHERE f.itemformid = :itemformid")
    , @NamedQuery(name = "Facilitycatalogue.findByItemcategoryid", query = "SELECT f FROM Facilitycatalogue f WHERE f.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Facilitycatalogue.findByCategoryname", query = "SELECT f FROM Facilitycatalogue f WHERE f.categoryname = :categoryname")
    , @NamedQuery(name = "Facilitycatalogue.findByItemclassificationid", query = "SELECT f FROM Facilitycatalogue f WHERE f.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Facilitycatalogue.findByClassificationname", query = "SELECT f FROM Facilitycatalogue f WHERE f.classificationname = :classificationname")
    , @NamedQuery(name = "Facilitycatalogue.findByFormname", query = "SELECT f FROM Facilitycatalogue f WHERE f.formname = :formname")
    , @NamedQuery(name = "Facilitycatalogue.findByItemstrength", query = "SELECT f FROM Facilitycatalogue f WHERE f.itemstrength = :itemstrength")
    , @NamedQuery(name = "Facilitycatalogue.findByItemform", query = "SELECT f FROM Facilitycatalogue f WHERE f.itemform = :itemform")
    , @NamedQuery(name = "Facilitycatalogue.findByIssupplies", query = "SELECT f FROM Facilitycatalogue f WHERE f.issupplies = :issupplies")
    , @NamedQuery(name = "Facilitycatalogue.findBySpecification", query = "SELECT f FROM Facilitycatalogue f WHERE f.specification = :specification")
    , @NamedQuery(name = "Facilitycatalogue.findByFullname", query = "SELECT f FROM Facilitycatalogue f WHERE f.fullname = :fullname")
    , @NamedQuery(name = "Facilitycatalogue.findByPackagename", query = "SELECT f FROM Facilitycatalogue f WHERE f.packagename = :packagename")
    , @NamedQuery(name = "Facilitycatalogue.findByPackagequantity", query = "SELECT f FROM Facilitycatalogue f WHERE f.packagequantity = :packagequantity")})
public class Facilitycatalogue implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Id
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
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
    @Size(max = 2147483647)
    @Column(name = "formname", length = 2147483647)
    private String formname;
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
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;
    @Column(name = "packagequantity")
    private Integer packagequantity;

    public Facilitycatalogue() {
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public BigInteger getItemid() {
        return itemid;
    }

    public void setItemid(BigInteger itemid) {
        this.itemid = itemid;
    }

    public String getGenericname() {
        return genericname;
    }

    public void setGenericname(String genericname) {
        this.genericname = genericname;
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

    public String getFormname() {
        return formname;
    }

    public void setFormname(String formname) {
        this.formname = formname;
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

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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
