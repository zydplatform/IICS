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
@Table(name = "facilitycatalogueitem", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilitycatalogueitem.findAll", query = "SELECT f FROM Facilitycatalogueitem f")
    , @NamedQuery(name = "Facilitycatalogueitem.findByFacilityid", query = "SELECT f FROM Facilitycatalogueitem f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilitycatalogueitem.findByItemid", query = "SELECT f FROM Facilitycatalogueitem f WHERE f.itemid = :itemid")
    , @NamedQuery(name = "Facilitycatalogueitem.findByFormname", query = "SELECT f FROM Facilitycatalogueitem f WHERE f.formname = :formname")})
public class Facilitycatalogueitem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "facilityid")
    private Integer facilityid;
    @Id
    @Column(name = "itemid")
    private BigInteger itemid;
    @Size(max = 2147483647)
    @Column(name = "formname", length = 2147483647)
    private String formname;

    public Facilitycatalogueitem() {
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

    public String getFormname() {
        return formname;
    }

    public void setFormname(String formname) {
        this.formname = formname;
    }
    
}
