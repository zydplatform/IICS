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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "staffassignedcell", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffassignedcell.findAll", query = "SELECT s FROM Staffassignedcell s")
    , @NamedQuery(name = "Staffassignedcell.findByStaffbayrowcellid", query = "SELECT s FROM Staffassignedcell s WHERE s.staffbayrowcellid = :staffbayrowcellid")
    , @NamedQuery(name = "Staffassignedcell.findByZoneid", query = "SELECT s FROM Staffassignedcell s WHERE s.zoneid = :zoneid")
    , @NamedQuery(name = "Staffassignedcell.findByStaffid", query = "SELECT s FROM Staffassignedcell s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Staffassignedcell.findByBayrowcellid", query = "SELECT s FROM Staffassignedcell s WHERE s.bayrowcellid = :bayrowcellid")
    , @NamedQuery(name = "Staffassignedcell.findByBayrowid", query = "SELECT s FROM Staffassignedcell s WHERE s.bayrowid = :bayrowid")
    , @NamedQuery(name = "Staffassignedcell.findByZonebayid", query = "SELECT s FROM Staffassignedcell s WHERE s.zonebayid = :zonebayid")})
public class Staffassignedcell implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "staffbayrowcellid")
    private Integer staffbayrowcellid;
    @Column(name = "zoneid")
    private Integer zoneid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "bayrowcellid")
    private Integer bayrowcellid;
    @Column(name = "bayrowid")
    private Integer bayrowid;
    @Column(name = "zonebayid")
    private Integer zonebayid;

    public Staffassignedcell() {
    }

    public Integer getStaffbayrowcellid() {
        return staffbayrowcellid;
    }

    public void setStaffbayrowcellid(Integer staffbayrowcellid) {
        this.staffbayrowcellid = staffbayrowcellid;
    }

    public Integer getZoneid() {
        return zoneid;
    }

    public void setZoneid(Integer zoneid) {
        this.zoneid = zoneid;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public Integer getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(Integer bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public Integer getBayrowid() {
        return bayrowid;
    }

    public void setBayrowid(Integer bayrowid) {
        this.bayrowid = bayrowid;
    }

    public Integer getZonebayid() {
        return zonebayid;
    }

    public void setZonebayid(Integer zonebayid) {
        this.zonebayid = zonebayid;
    }
    
}
