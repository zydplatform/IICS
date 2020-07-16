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
@Table(name = "unitstoragezones", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Unitstoragezones.findAll", query = "SELECT u FROM Unitstoragezones u")
    , @NamedQuery(name = "Unitstoragezones.findByZoneid", query = "SELECT u FROM Unitstoragezones u WHERE u.zoneid = :zoneid")
    , @NamedQuery(name = "Unitstoragezones.findByZonelabel", query = "SELECT u FROM Unitstoragezones u WHERE u.zonelabel = :zonelabel")
    , @NamedQuery(name = "Unitstoragezones.findByZonebayid", query = "SELECT u FROM Unitstoragezones u WHERE u.zonebayid = :zonebayid")
    , @NamedQuery(name = "Unitstoragezones.findByBaylabel", query = "SELECT u FROM Unitstoragezones u WHERE u.baylabel = :baylabel")
    , @NamedQuery(name = "Unitstoragezones.findByBayrowid", query = "SELECT u FROM Unitstoragezones u WHERE u.bayrowid = :bayrowid")
    , @NamedQuery(name = "Unitstoragezones.findByRowlabel", query = "SELECT u FROM Unitstoragezones u WHERE u.rowlabel = :rowlabel")
    , @NamedQuery(name = "Unitstoragezones.findByBayrowcellid", query = "SELECT u FROM Unitstoragezones u WHERE u.bayrowcellid = :bayrowcellid")
    , @NamedQuery(name = "Unitstoragezones.findByCelllabel", query = "SELECT u FROM Unitstoragezones u WHERE u.celllabel = :celllabel")
    , @NamedQuery(name = "Unitstoragezones.findByFacilityunitid", query = "SELECT u FROM Unitstoragezones u WHERE u.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Unitstoragezones.findByCellstate", query = "SELECT u FROM Unitstoragezones u WHERE u.cellstate = :cellstate")
    , @NamedQuery(name = "Unitstoragezones.findByStoragetypeid", query = "SELECT u FROM Unitstoragezones u WHERE u.storagetypeid = :storagetypeid")
    , @NamedQuery(name = "Unitstoragezones.findByCelltranslimit", query = "SELECT u FROM Unitstoragezones u WHERE u.celltranslimit = :celltranslimit")})
public class Unitstoragezones implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "zoneid")
    private Integer zoneid;
    @Size(max = 255)
    @Column(name = "zonelabel", length = 255)
    private String zonelabel;
    @Column(name = "zonebayid")
    private Integer zonebayid;
    @Size(max = 255)
    @Column(name = "baylabel", length = 255)
    private String baylabel;
    @Column(name = "bayrowid")
    private Integer bayrowid;
    @Size(max = 255)
    @Column(name = "rowlabel", length = 255)
    private String rowlabel;
    @Id
    @Column(name = "bayrowcellid")
    private Integer bayrowcellid;
    @Size(max = 255)
    @Column(name = "celllabel", length = 255)
    private String celllabel;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "cellstate")
    private Boolean cellstate;
    @Column(name = "storagetypeid")
    private BigInteger storagetypeid;
    @Column(name = "celltranslimit")
    private BigInteger celltranslimit;
    @Column(name = "isolated")
    private boolean isolated;

    public Unitstoragezones() {
    }

    public Integer getZoneid() {
        return zoneid;
    }

    public void setZoneid(Integer zoneid) {
        this.zoneid = zoneid;
    }

    public String getZonelabel() {
        return zonelabel;
    }

    public void setZonelabel(String zonelabel) {
        this.zonelabel = zonelabel;
    }

    public Integer getZonebayid() {
        return zonebayid;
    }

    public void setZonebayid(Integer zonebayid) {
        this.zonebayid = zonebayid;
    }

    public String getBaylabel() {
        return baylabel;
    }

    public void setBaylabel(String baylabel) {
        this.baylabel = baylabel;
    }

    public Integer getBayrowid() {
        return bayrowid;
    }

    public void setBayrowid(Integer bayrowid) {
        this.bayrowid = bayrowid;
    }

    public String getRowlabel() {
        return rowlabel;
    }

    public void setRowlabel(String rowlabel) {
        this.rowlabel = rowlabel;
    }

    public Integer getBayrowcellid() {
        return bayrowcellid;
    }

    public void setBayrowcellid(Integer bayrowcellid) {
        this.bayrowcellid = bayrowcellid;
    }

    public String getCelllabel() {
        return celllabel;
    }

    public void setCelllabel(String celllabel) {
        this.celllabel = celllabel;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Boolean getCellstate() {
        return cellstate;
    }

    public void setCellstate(Boolean cellstate) {
        this.cellstate = cellstate;
    }

    public BigInteger getStoragetypeid() {
        return storagetypeid;
    }

    public void setStoragetypeid(BigInteger storagetypeid) {
        this.storagetypeid = storagetypeid;
    }

    public BigInteger getCelltranslimit() {
        return celltranslimit;
    }

    public void setCelltranslimit(BigInteger celltranslimit) {
        this.celltranslimit = celltranslimit;
    }

    public boolean isIsolated() {
        return isolated;
    }

    public void setIsolated(boolean isolated) {
        this.isolated = isolated;
    }
    
}
