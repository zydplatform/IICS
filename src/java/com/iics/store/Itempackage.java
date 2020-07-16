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
@Table(name = "itempackage", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itempackage.findAll", query = "SELECT i FROM Itempackage i")
    , @NamedQuery(name = "Itempackage.findByItempackageid", query = "SELECT i FROM Itempackage i WHERE i.itempackageid = :itempackageid")
    , @NamedQuery(name = "Itempackage.findByItemid", query = "SELECT i FROM Itempackage i WHERE i.itemid = :itemid")
    , @NamedQuery(name = "Itempackage.findByGenericname", query = "SELECT i FROM Itempackage i WHERE i.genericname = :genericname")
    , @NamedQuery(name = "Itempackage.findByItemcategoryid", query = "SELECT i FROM Itempackage i WHERE i.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Itempackage.findByCategoryname", query = "SELECT i FROM Itempackage i WHERE i.categoryname = :categoryname")
    , @NamedQuery(name = "Itempackage.findByItemclassificationid", query = "SELECT i FROM Itempackage i WHERE i.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Itempackage.findByClassificationname", query = "SELECT i FROM Itempackage i WHERE i.classificationname = :classificationname")
    , @NamedQuery(name = "Itempackage.findByFullname", query = "SELECT i FROM Itempackage i WHERE i.fullname = :fullname")
    , @NamedQuery(name = "Itempackage.findByItemstrength", query = "SELECT i FROM Itempackage i WHERE i.itemstrength = :itemstrength")
    , @NamedQuery(name = "Itempackage.findByItemform", query = "SELECT i FROM Itempackage i WHERE i.itemform = :itemform")
    , @NamedQuery(name = "Itempackage.findByIssupplies", query = "SELECT i FROM Itempackage i WHERE i.issupplies = :issupplies")
    , @NamedQuery(name = "Itempackage.findBySpecification", query = "SELECT i FROM Itempackage i WHERE i.specification = :specification")
    , @NamedQuery(name = "Itempackage.findByPackagename", query = "SELECT i FROM Itempackage i WHERE i.packagename = :packagename")
    , @NamedQuery(name = "Itempackage.findByPackagequantity", query = "SELECT i FROM Itempackage i WHERE i.packagequantity = :packagequantity")
    , @NamedQuery(name = "Itempackage.findByIsactive", query = "SELECT i FROM Itempackage i WHERE i.isactive = :isactive")
    , @NamedQuery(name = "Itempackage.findByItemformid", query = "SELECT i FROM Itempackage i WHERE i.itemformid = :itemformid")
    , @NamedQuery(name = "Itempackage.findByItemcode", query = "SELECT i FROM Itempackage i WHERE i.itemcode = :itemcode")})
public class Itempackage implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "itempackageid")
    private BigInteger itempackageid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
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
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "itemformid")
    private Integer itemformid;
    @Size(max = 2147483647)
    @Column(name = "itemcode", length = 2147483647)
    private String itemcode;
    @Column(name = "packagesid")
    private BigInteger packagesid;
    @Column(name = "package")
    private String packname;
    @Column(name = "measure")
    private String measure;

    public Itempackage() {
    }

    public BigInteger getItempackageid() {
        return itempackageid;
    }

    public void setItempackageid(BigInteger itempackageid) {
        this.itempackageid = itempackageid;
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

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Integer getItemformid() {
        return itemformid;
    }

    public void setItemformid(Integer itemformid) {
        this.itemformid = itemformid;
    }

    public String getItemcode() {
        return itemcode;
    }

    public void setItemcode(String itemcode) {
        this.itemcode = itemcode;
    }

    public BigInteger getPackagesid() {
        return packagesid;
    }

    public void setPackagesid(BigInteger packagesid) {
        this.packagesid = packagesid;
    }

    public String getPackname() {
        return packname;
    }

    public void setPackname(String packname) {
        this.packname = packname;
    }

    public String getMeasure() {
        return measure;
    }

    public void setMeasure(String measure) {
        this.measure = measure;
    }
    
}
