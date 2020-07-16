/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "medicalitem", catalog = "iics_database", schema = "store", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"itemcode"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Medicalitem.findAll", query = "SELECT m FROM Medicalitem m")
    , @NamedQuery(name = "Medicalitem.findByMedicalitemid", query = "SELECT m FROM Medicalitem m WHERE m.medicalitemid = :medicalitemid")
    , @NamedQuery(name = "Medicalitem.findByItemcode", query = "SELECT m FROM Medicalitem m WHERE m.itemcode = :itemcode")
    , @NamedQuery(name = "Medicalitem.findByGenericname", query = "SELECT m FROM Medicalitem m WHERE m.genericname = :genericname")
    , @NamedQuery(name = "Medicalitem.findByPacksize", query = "SELECT m FROM Medicalitem m WHERE m.packsize = :packsize")
    , @NamedQuery(name = "Medicalitem.findByUnitcost", query = "SELECT m FROM Medicalitem m WHERE m.unitcost = :unitcost")
    , @NamedQuery(name = "Medicalitem.findByItemstrength", query = "SELECT m FROM Medicalitem m WHERE m.itemstrength = :itemstrength")
    , @NamedQuery(name = "Medicalitem.findByItemordertype", query = "SELECT m FROM Medicalitem m WHERE m.itemordertype = :itemordertype")
    , @NamedQuery(name = "Medicalitem.findByItemusage", query = "SELECT m FROM Medicalitem m WHERE m.itemusage = :itemusage")
    , @NamedQuery(name = "Medicalitem.findByIsspecial", query = "SELECT m FROM Medicalitem m WHERE m.isspecial = :isspecial")
    , @NamedQuery(name = "Medicalitem.findByRestricted", query = "SELECT m FROM Medicalitem m WHERE m.restricted = :restricted")
    , @NamedQuery(name = "Medicalitem.findByIsactive", query = "SELECT m FROM Medicalitem m WHERE m.isactive = :isactive")
    , @NamedQuery(name = "Medicalitem.findByLevelofuse", query = "SELECT m FROM Medicalitem m WHERE m.levelofuse = :levelofuse")
    , @NamedQuery(name = "Medicalitem.findByItemform", query = "SELECT m FROM Medicalitem m WHERE m.itemform = :itemform")
    , @NamedQuery(name = "Medicalitem.findByIssupplies", query = "SELECT m FROM Medicalitem m WHERE m.issupplies = :issupplies")
    , @NamedQuery(name = "Medicalitem.findBySpecification", query = "SELECT m FROM Medicalitem m WHERE m.specification = :specification")
    , @NamedQuery(name = "Medicalitem.findByIsdeleted", query = "SELECT m FROM Medicalitem m WHERE m.isdeleted = :isdeleted")})
public class Medicalitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "medicalitemid", nullable = false)
    private Long medicalitemid;
    @Size(max = 2147483647)
    @Column(name = "itemcode", length = 2147483647)
    private String itemcode;
    @Size(max = 2147483647)
    @Column(name = "genericname", length = 2147483647)
    private String genericname;
    @Column(name = "packsize")
    private Integer packsize;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "unitcost", precision = 17, scale = 17)
    private Double unitcost;
    @Size(max = 2147483647)
    @Column(name = "itemstrength", length = 2147483647)
    private String itemstrength;
    @Size(max = 255)
    @Column(name = "itemordertype", length = 255)
    private String itemordertype;
    @Size(max = 255)
    @Column(name = "itemusage", length = 255)
    private String itemusage;
    @Column(name = "isspecial")
    private Boolean isspecial;
    @Basic(optional = false)
    @NotNull
    @Column(name = "restricted", nullable = false)
    private boolean restricted;
    @Column(name = "isactive")
    private Boolean isactive;
    @Column(name = "levelofuse")
    private Integer levelofuse;
    @Size(max = 2147483647)
    @Column(name = "itemform", length = 2147483647)
    private String itemform;
    @Column(name = "issupplies")
    private Boolean issupplies;
    @Size(max = 2147483647)
    @Column(name = "specification", length = 2147483647)
    private String specification;
    @Column(name = "isdeleted")
    private Boolean isdeleted;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "itemid")
    private List<Itemcategorisation> itemcategorisationList;
    @JoinColumn(name = "itemadministeringtypeid", referencedColumnName = "administeringtypeid")
    @ManyToOne
    private Itemadministeringtype itemadministeringtypeid;
    @JoinColumn(name = "itemformid", referencedColumnName = "itemformid")
    @ManyToOne
    private Itemform itemformid;
    @OneToMany(mappedBy = "medicalitemid")
    private List<Item> itemList;
    @Column(name = "itemsource")
    private String itemsource;

    public Medicalitem() {
    }

    public Medicalitem(Long medicalitemid) {
        this.medicalitemid = medicalitemid;
    }

    public Medicalitem(Long medicalitemid, boolean restricted) {
        this.medicalitemid = medicalitemid;
        this.restricted = restricted;
    }

    public Long getMedicalitemid() {
        return medicalitemid;
    }

    public void setMedicalitemid(Long medicalitemid) {
        this.medicalitemid = medicalitemid;
    }

    public String getItemsource() {
        return itemsource;
    }

    public void setItemsource(String itemsource) {
        this.itemsource = itemsource;
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

    public Double getUnitcost() {
        return unitcost;
    }

    public void setUnitcost(Double unitcost) {
        this.unitcost = unitcost;
    }

    public String getItemstrength() {
        return itemstrength;
    }

    public void setItemstrength(String itemstrength) {
        this.itemstrength = itemstrength;
    }

    public String getItemordertype() {
        return itemordertype;
    }

    public void setItemordertype(String itemordertype) {
        this.itemordertype = itemordertype;
    }

    public String getItemusage() {
        return itemusage;
    }

    public void setItemusage(String itemusage) {
        this.itemusage = itemusage;
    }

    public Boolean getIsspecial() {
        return isspecial;
    }

    public void setIsspecial(Boolean isspecial) {
        this.isspecial = isspecial;
    }

    public boolean getRestricted() {
        return restricted;
    }

    public void setRestricted(boolean restricted) {
        this.restricted = restricted;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Integer getLevelofuse() {
        return levelofuse;
    }

    public void setLevelofuse(Integer levelofuse) {
        this.levelofuse = levelofuse;
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

    public Boolean getIsdeleted() {
        return isdeleted;
    }

    public void setIsdeleted(Boolean isdeleted) {
        this.isdeleted = isdeleted;
    }

    @XmlTransient
    public List<Itemcategorisation> getItemcategorisationList() {
        return itemcategorisationList;
    }

    public void setItemcategorisationList(List<Itemcategorisation> itemcategorisationList) {
        this.itemcategorisationList = itemcategorisationList;
    }

    public Itemadministeringtype getItemadministeringtypeid() {
        return itemadministeringtypeid;
    }

    public void setItemadministeringtypeid(Itemadministeringtype itemadministeringtypeid) {
        this.itemadministeringtypeid = itemadministeringtypeid;
    }

    public Itemform getItemformid() {
        return itemformid;
    }

    public void setItemformid(Itemform itemformid) {
        this.itemformid = itemformid;
    }

    @XmlTransient
    public List<Item> getItemList() {
        return itemList;
    }

    public void setItemList(List<Item> itemList) {
        this.itemList = itemList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (medicalitemid != null ? medicalitemid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Medicalitem)) {
            return false;
        }
        Medicalitem other = (Medicalitem) object;
        if ((this.medicalitemid == null && other.medicalitemid != null) || (this.medicalitemid != null && !this.medicalitemid.equals(other.medicalitemid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Medicalitem[ medicalitemid=" + medicalitemid + " ]";
    }

}
