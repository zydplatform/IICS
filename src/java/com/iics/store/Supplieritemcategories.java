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
@Table(name = "supplieritemcategories", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Supplieritemcategories.findAll", query = "SELECT s FROM Supplieritemcategories s")
    , @NamedQuery(name = "Supplieritemcategories.findBySupplieritemid", query = "SELECT s FROM Supplieritemcategories s WHERE s.supplieritemid = :supplieritemid")
    , @NamedQuery(name = "Supplieritemcategories.findBySupplierid", query = "SELECT s FROM Supplieritemcategories s WHERE s.supplierid = :supplierid")
    , @NamedQuery(name = "Supplieritemcategories.findByItemid", query = "SELECT s FROM Supplieritemcategories s WHERE s.itemid = :itemid")
    , @NamedQuery(name = "Supplieritemcategories.findByItemcode", query = "SELECT s FROM Supplieritemcategories s WHERE s.itemcode = :itemcode")
    , @NamedQuery(name = "Supplieritemcategories.findByGenericname", query = "SELECT s FROM Supplieritemcategories s WHERE s.genericname = :genericname")
    , @NamedQuery(name = "Supplieritemcategories.findByPacksize", query = "SELECT s FROM Supplieritemcategories s WHERE s.packsize = :packsize")
    , @NamedQuery(name = "Supplieritemcategories.findByItemcost", query = "SELECT s FROM Supplieritemcategories s WHERE s.itemcost = :itemcost")
    , @NamedQuery(name = "Supplieritemcategories.findByIsactive", query = "SELECT s FROM Supplieritemcategories s WHERE s.isactive = :isactive")
    , @NamedQuery(name = "Supplieritemcategories.findByItemcategoryid", query = "SELECT s FROM Supplieritemcategories s WHERE s.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Supplieritemcategories.findByCategoryname", query = "SELECT s FROM Supplieritemcategories s WHERE s.categoryname = :categoryname")
    , @NamedQuery(name = "Supplieritemcategories.findByItemclassificationid", query = "SELECT s FROM Supplieritemcategories s WHERE s.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Supplieritemcategories.findByClassificationname", query = "SELECT s FROM Supplieritemcategories s WHERE s.classificationname = :classificationname")
    , @NamedQuery(name = "Supplieritemcategories.findByIsrestricted", query = "SELECT s FROM Supplieritemcategories s WHERE s.isrestricted = :isrestricted")
    , @NamedQuery(name = "Supplieritemcategories.findByTradename", query = "SELECT s FROM Supplieritemcategories s WHERE s.tradename = :tradename")
    , @NamedQuery(name = "Supplieritemcategories.findByFullname", query = "SELECT s FROM Supplieritemcategories s WHERE s.fullname = :fullname")
    , @NamedQuery(name = "Supplieritemcategories.findByPackagename", query = "SELECT s FROM Supplieritemcategories s WHERE s.packagename = :packagename")
    , @NamedQuery(name = "Supplieritemcategories.findByPackagequantity", query = "SELECT s FROM Supplieritemcategories s WHERE s.packagequantity = :packagequantity")})
public class Supplieritemcategories implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "supplieritemid")
    private BigInteger supplieritemid;
    @Column(name = "supplierid")
    private BigInteger supplierid;
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "itemcode", length = 2147483647)
    private String itemcode;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Column(name = "packsize")
    private Integer packsize;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "itemcost", precision = 17, scale = 17)
    private Double itemcost;
    @Column(name = "isactive")
    private Boolean isactive;
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
    @Column(name = "isrestricted")
    private Boolean isrestricted;
    @Size(max = 255)
    @Column(name = "tradename", length = 255)
    private String tradename;
    @Size(max = 2147483647)
    @Column(name = "fullname", length = 2147483647)
    private String fullname;
    @Size(max = 2147483647)
    @Column(name = "packagename", length = 2147483647)
    private String packagename;
    @Column(name = "packagequantity")
    private Integer packagequantity;

    public Supplieritemcategories() {
    }

    public BigInteger getSupplieritemid() {
        return supplieritemid;
    }

    public void setSupplieritemid(BigInteger supplieritemid) {
        this.supplieritemid = supplieritemid;
    }

    public BigInteger getSupplierid() {
        return supplierid;
    }

    public void setSupplierid(BigInteger supplierid) {
        this.supplierid = supplierid;
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

    public Integer getPacksize() {
        return packsize;
    }

    public void setPacksize(Integer packsize) {
        this.packsize = packsize;
    }

    public Double getItemcost() {
        return itemcost;
    }

    public void setItemcost(Double itemcost) {
        this.itemcost = itemcost;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
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

    public Boolean getIsrestricted() {
        return isrestricted;
    }

    public void setIsrestricted(Boolean isrestricted) {
        this.isrestricted = isrestricted;
    }

    public String getTradename() {
        return tradename;
    }

    public void setTradename(String tradename) {
        this.tradename = tradename;
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
