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
@Table(name = "itemcategories", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemcategories.findAll", query = "SELECT i FROM Itemcategories i")
    , @NamedQuery(name = "Itemcategories.findByItemid", query = "SELECT i FROM Itemcategories i WHERE i.itemid = :itemid")
    , @NamedQuery(name = "Itemcategories.findByItemcode", query = "SELECT i FROM Itemcategories i WHERE i.itemcode = :itemcode")
    , @NamedQuery(name = "Itemcategories.findByGenericname", query = "SELECT i FROM Itemcategories i WHERE i.genericname = :genericname")
    , @NamedQuery(name = "Itemcategories.findByPacksize", query = "SELECT i FROM Itemcategories i WHERE i.packsize = :packsize")
    , @NamedQuery(name = "Itemcategories.findByItemformid", query = "SELECT i FROM Itemcategories i WHERE i.itemformid = :itemformid")
    , @NamedQuery(name = "Itemcategories.findByItemadministeringtypeid", query = "SELECT i FROM Itemcategories i WHERE i.itemadministeringtypeid = :itemadministeringtypeid")
    , @NamedQuery(name = "Itemcategories.findByIsactive", query = "SELECT i FROM Itemcategories i WHERE i.isactive = :isactive")
    , @NamedQuery(name = "Itemcategories.findByItemcategoryid", query = "SELECT i FROM Itemcategories i WHERE i.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Itemcategories.findByCategoryname", query = "SELECT i FROM Itemcategories i WHERE i.categoryname = :categoryname")
    , @NamedQuery(name = "Itemcategories.findByItemclassificationid", query = "SELECT i FROM Itemcategories i WHERE i.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Itemcategories.findByClassificationname", query = "SELECT i FROM Itemcategories i WHERE i.classificationname = :classificationname")
    , @NamedQuery(name = "Itemcategories.findByFormname", query = "SELECT i FROM Itemcategories i WHERE i.formname = :formname")
    , @NamedQuery(name = "Itemcategories.findByTypename", query = "SELECT i FROM Itemcategories i WHERE i.typename = :typename")
    , @NamedQuery(name = "Itemcategories.findByFullname", query = "SELECT i FROM Itemcategories i WHERE i.fullname = :fullname")
    , @NamedQuery(name = "Itemcategories.findByItemstrength", query = "SELECT i FROM Itemcategories i WHERE i.itemstrength = :itemstrength")
    , @NamedQuery(name = "Itemcategories.findByItemform", query = "SELECT i FROM Itemcategories i WHERE i.itemform = :itemform")
    , @NamedQuery(name = "Itemcategories.findByIssupplies", query = "SELECT i FROM Itemcategories i WHERE i.issupplies = :issupplies")
    , @NamedQuery(name = "Itemcategories.findBySpecification", query = "SELECT i FROM Itemcategories i WHERE i.specification = :specification")
    , @NamedQuery(name = "Itemcategories.findByClassificationisdeleted", query = "SELECT i FROM Itemcategories i WHERE i.classificationisdeleted = :classificationisdeleted")
    , @NamedQuery(name = "Itemcategories.findByItemisdeleted", query = "SELECT i FROM Itemcategories i WHERE i.itemisdeleted = :itemisdeleted")})
public class Itemcategories implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
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
    @Column(name = "itemformid")
    private Integer itemformid;
    @Column(name = "itemadministeringtypeid")
    private Integer itemadministeringtypeid;
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
    @Size(max = 2147483647)
    @Column(name = "formname", length = 2147483647)
    private String formname;
    @Size(max = 2147483647)
    @Column(name = "typename", length = 2147483647)
    private String typename;
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
    @Column(name = "classificationisdeleted")
    private Boolean classificationisdeleted;
    @Column(name = "itemisdeleted")
    private Boolean itemisdeleted;

    public Itemcategories() {
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

    public Integer getItemformid() {
        return itemformid;
    }

    public void setItemformid(Integer itemformid) {
        this.itemformid = itemformid;
    }

    public Integer getItemadministeringtypeid() {
        return itemadministeringtypeid;
    }

    public void setItemadministeringtypeid(Integer itemadministeringtypeid) {
        this.itemadministeringtypeid = itemadministeringtypeid;
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

    public String getFormname() {
        return formname;
    }

    public void setFormname(String formname) {
        this.formname = formname;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
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

    public Boolean getClassificationisdeleted() {
        return classificationisdeleted;
    }

    public void setClassificationisdeleted(Boolean classificationisdeleted) {
        this.classificationisdeleted = classificationisdeleted;
    }

    public Boolean getItemisdeleted() {
        return itemisdeleted;
    }

    public void setItemisdeleted(Boolean itemisdeleted) {
        this.itemisdeleted = itemisdeleted;
    }
    
}
