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
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "itemcategory", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemcategory.findAll", query = "SELECT i FROM Itemcategory i")
    , @NamedQuery(name = "Itemcategory.findByItemcategoryid", query = "SELECT i FROM Itemcategory i WHERE i.itemcategoryid = :itemcategoryid")
    , @NamedQuery(name = "Itemcategory.findByCategoryname", query = "SELECT i FROM Itemcategory i WHERE i.categoryname = :categoryname")
    , @NamedQuery(name = "Itemcategory.findByCategorydescription", query = "SELECT i FROM Itemcategory i WHERE i.categorydescription = :categorydescription")
    , @NamedQuery(name = "Itemcategory.findByIsactive", query = "SELECT i FROM Itemcategory i WHERE i.isactive = :isactive")
    , @NamedQuery(name = "Itemcategory.findByParentid", query = "SELECT i FROM Itemcategory i WHERE i.parentid = :parentid")})
public class Itemcategory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "itemcategoryid", nullable = false)
    private Long itemcategoryid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "categoryname", nullable = false, length = 2147483647)
    private String categoryname;
    @Size(max = 2147483647)
    @Column(name = "categorydescription", length = 2147483647)
    private String categorydescription;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "parentid")
    private Long parentid;
    @OneToMany(mappedBy = "itemcategoryid")
    private List<Itemcategorisation> itemcategorisationList;
    @JoinColumn(name = "itemclassificationid", referencedColumnName = "itemclassificationid", nullable = false)
    @ManyToOne(optional = false)
    private Itemclassification itemclassificationid;

    public Itemcategory() {
    }

    public Itemcategory(Long itemcategoryid) {
        this.itemcategoryid = itemcategoryid;
    }

    public Itemcategory(Long itemcategoryid, String categoryname) {
        this.itemcategoryid = itemcategoryid;
        this.categoryname = categoryname;
    }

    public Long getItemcategoryid() {
        return itemcategoryid;
    }

    public void setItemcategoryid(Long itemcategoryid) {
        this.itemcategoryid = itemcategoryid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorydescription() {
        return categorydescription;
    }

    public void setCategorydescription(String categorydescription) {
        this.categorydescription = categorydescription;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    @XmlTransient
    public List<Itemcategorisation> getItemcategorisationList() {
        return itemcategorisationList;
    }

    public void setItemcategorisationList(List<Itemcategorisation> itemcategorisationList) {
        this.itemcategorisationList = itemcategorisationList;
    }

    public Itemclassification getItemclassificationid() {
        return itemclassificationid;
    }

    public void setItemclassificationid(Itemclassification itemclassificationid) {
        this.itemclassificationid = itemclassificationid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (itemcategoryid != null ? itemcategoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Itemcategory)) {
            return false;
        }
        Itemcategory other = (Itemcategory) object;
        if ((this.itemcategoryid == null && other.itemcategoryid != null) || (this.itemcategoryid != null && !this.itemcategoryid.equals(other.itemcategoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Itemcategory[ itemcategoryid=" + itemcategoryid + " ]";
    }
    
}
