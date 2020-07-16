/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
@Table(name = "itemclassification", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemclassification.findAll", query = "SELECT i FROM Itemclassification i")
    , @NamedQuery(name = "Itemclassification.findByItemclassificationid", query = "SELECT i FROM Itemclassification i WHERE i.itemclassificationid = :itemclassificationid")
    , @NamedQuery(name = "Itemclassification.findByClassificationdescription", query = "SELECT i FROM Itemclassification i WHERE i.classificationdescription = :classificationdescription")
    , @NamedQuery(name = "Itemclassification.findByClassificationname", query = "SELECT i FROM Itemclassification i WHERE i.classificationname = :classificationname")
    , @NamedQuery(name = "Itemclassification.findByIsactive", query = "SELECT i FROM Itemclassification i WHERE i.isactive = :isactive")
    , @NamedQuery(name = "Itemclassification.findByIsmedicine", query = "SELECT i FROM Itemclassification i WHERE i.ismedicine = :ismedicine")
    , @NamedQuery(name = "Itemclassification.findByParentid", query = "SELECT i FROM Itemclassification i WHERE i.parentid = :parentid")
    , @NamedQuery(name = "Itemclassification.findByHasparent", query = "SELECT i FROM Itemclassification i WHERE i.hasparent = :hasparent")
    , @NamedQuery(name = "Itemclassification.findByIsdeleted", query = "SELECT i FROM Itemclassification i WHERE i.isdeleted = :isdeleted")})
public class Itemclassification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "itemclassificationid", nullable = false)
    private Long itemclassificationid;
    @Size(max = 2147483647)
    @Column(name = "classificationdescription", length = 2147483647)
    private String classificationdescription;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "classificationname", nullable = false, length = 2147483647)
    private String classificationname;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "ismedicine")
    private Boolean ismedicine;
    @Column(name = "parentid")
    private Long parentid;
    @Column(name = "hasparent")
    private Boolean hasparent;
    @Column(name = "isdeleted")
    private Boolean isdeleted;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "itemclassificationid")
    private List<Itemcategory> itemcategoryList;

    public Itemclassification() {
    }

    public Itemclassification(Long itemclassificationid) {
        this.itemclassificationid = itemclassificationid;
    }

    public Itemclassification(Long itemclassificationid, String classificationname) {
        this.itemclassificationid = itemclassificationid;
        this.classificationname = classificationname;
    }

    public Long getItemclassificationid() {
        return itemclassificationid;
    }

    public void setItemclassificationid(Long itemclassificationid) {
        this.itemclassificationid = itemclassificationid;
    }

    public String getClassificationdescription() {
        return classificationdescription;
    }

    public void setClassificationdescription(String classificationdescription) {
        this.classificationdescription = classificationdescription;
    }

    public String getClassificationname() {
        return classificationname;
    }

    public void setClassificationname(String classificationname) {
        this.classificationname = classificationname;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Boolean getIsmedicine() {
        return ismedicine;
    }

    public void setIsmedicine(Boolean ismedicine) {
        this.ismedicine = ismedicine;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public Boolean getHasparent() {
        return hasparent;
    }

    public void setHasparent(Boolean hasparent) {
        this.hasparent = hasparent;
    }

    public Boolean getIsdeleted() {
        return isdeleted;
    }

    public void setIsdeleted(Boolean isdeleted) {
        this.isdeleted = isdeleted;
    }

    @XmlTransient
    public List<Itemcategory> getItemcategoryList() {
        return itemcategoryList;
    }

    public void setItemcategoryList(List<Itemcategory> itemcategoryList) {
        this.itemcategoryList = itemcategoryList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (itemclassificationid != null ? itemclassificationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Itemclassification)) {
            return false;
        }
        Itemclassification other = (Itemclassification) object;
        if ((this.itemclassificationid == null && other.itemclassificationid != null) || (this.itemclassificationid != null && !this.itemclassificationid.equals(other.itemclassificationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Itemclassification[ itemclassificationid=" + itemclassificationid + " ]";
    }
    
}
