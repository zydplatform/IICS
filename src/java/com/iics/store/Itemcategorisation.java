/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "itemcategorisation", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Itemcategorisation.findAll", query = "SELECT i FROM Itemcategorisation i")
    , @NamedQuery(name = "Itemcategorisation.findByItemcategorisationid", query = "SELECT i FROM Itemcategorisation i WHERE i.itemcategorisationid = :itemcategorisationid")
    , @NamedQuery(name = "Itemcategorisation.findByUpdatetime", query = "SELECT i FROM Itemcategorisation i WHERE i.updatetime = :updatetime")
    , @NamedQuery(name = "Itemcategorisation.findByUpdatedby", query = "SELECT i FROM Itemcategorisation i WHERE i.updatedby = :updatedby")
    , @NamedQuery(name = "Itemcategorisation.findByIsactive", query = "SELECT i FROM Itemcategorisation i WHERE i.isactive = :isactive")})
public class Itemcategorisation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "itemcategorisationid", nullable = false)
    private Long itemcategorisationid;
    @Column(name = "updatetime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatetime;
    @Basic(optional = false)
    @NotNull
    @Column(name = "updatedby", nullable = false)
    private long updatedby;
    @Column(name = "isactive")
    private Boolean isactive;
    @JoinColumn(name = "itemcategoryid", referencedColumnName = "itemcategoryid")
    @ManyToOne
    private Itemcategory itemcategoryid;
    @JoinColumn(name = "itemid", referencedColumnName = "medicalitemid", nullable = false)
    @ManyToOne(optional = false)
    private Medicalitem itemid;

    public Itemcategorisation() {
    }

    public Itemcategorisation(Long itemcategorisationid) {
        this.itemcategorisationid = itemcategorisationid;
    }

    public Itemcategorisation(Long itemcategorisationid, long updatedby) {
        this.itemcategorisationid = itemcategorisationid;
        this.updatedby = updatedby;
    }

    public Long getItemcategorisationid() {
        return itemcategorisationid;
    }

    public void setItemcategorisationid(Long itemcategorisationid) {
        this.itemcategorisationid = itemcategorisationid;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(long updatedby) {
        this.updatedby = updatedby;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    public Itemcategory getItemcategoryid() {
        return itemcategoryid;
    }

    public void setItemcategoryid(Itemcategory itemcategoryid) {
        this.itemcategoryid = itemcategoryid;
    }

    public Medicalitem getItemid() {
        return itemid;
    }

    public void setItemid(Medicalitem itemid) {
        this.itemid = itemid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (itemcategorisationid != null ? itemcategorisationid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Itemcategorisation)) {
            return false;
        }
        Itemcategorisation other = (Itemcategorisation) object;
        if ((this.itemcategorisationid == null && other.itemcategorisationid != null) || (this.itemcategorisationid != null && !this.itemcategorisationid.equals(other.itemcategorisationid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Itemcategorisation[ itemcategorisationid=" + itemcategorisationid + " ]";
    }
    
}
