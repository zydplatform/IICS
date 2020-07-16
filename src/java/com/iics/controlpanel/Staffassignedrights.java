/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

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
@Table(name = "staffassignedrights", catalog = "iics_database", schema = "controlpanel")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffassignedrights.findAll", query = "SELECT s FROM Staffassignedrights s")
    , @NamedQuery(name = "Staffassignedrights.findByStafffacilityunitaccessrightprivilegeid", query = "SELECT s FROM Staffassignedrights s WHERE s.stafffacilityunitaccessrightprivilegeid = :stafffacilityunitaccessrightprivilegeid")
    , @NamedQuery(name = "Staffassignedrights.findByStafffacilityunitaccessrightprivstatus", query = "SELECT s FROM Staffassignedrights s WHERE s.stafffacilityunitaccessrightprivstatus = :stafffacilityunitaccessrightprivstatus")
    , @NamedQuery(name = "Staffassignedrights.findByStafffacilityunitid", query = "SELECT s FROM Staffassignedrights s WHERE s.stafffacilityunitid = :stafffacilityunitid")
    , @NamedQuery(name = "Staffassignedrights.findByAccessrightgroupprivilegeid", query = "SELECT s FROM Staffassignedrights s WHERE s.accessrightgroupprivilegeid = :accessrightgroupprivilegeid")
    , @NamedQuery(name = "Staffassignedrights.findByAccessrightgroupprivilegestatus", query = "SELECT s FROM Staffassignedrights s WHERE s.accessrightgroupprivilegestatus = :accessrightgroupprivilegestatus")
    , @NamedQuery(name = "Staffassignedrights.findByPrivilegeid", query = "SELECT s FROM Staffassignedrights s WHERE s.privilegeid = :privilegeid")
    , @NamedQuery(name = "Staffassignedrights.findByAccessrightsgroupid", query = "SELECT s FROM Staffassignedrights s WHERE s.accessrightsgroupid = :accessrightsgroupid")
    , @NamedQuery(name = "Staffassignedrights.findByAccessrightgroupstatus", query = "SELECT s FROM Staffassignedrights s WHERE s.accessrightgroupstatus = :accessrightgroupstatus")})
public class Staffassignedrights implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "stafffacilityunitaccessrightprivilegeid")
    private Integer stafffacilityunitaccessrightprivilegeid;
    @Column(name = "stafffacilityunitaccessrightprivstatus")
    private Boolean stafffacilityunitaccessrightprivstatus;
    @Column(name = "stafffacilityunitid")
    private Long stafffacilityunitid;
    @Column(name = "accessrightgroupprivilegeid")
    private Integer accessrightgroupprivilegeid;
    @Column(name = "accessrightgroupprivilegestatus")
    private Boolean accessrightgroupprivilegestatus;
    @Column(name = "privilegeid")
    private Long privilegeid;
    @Column(name = "accessrightsgroupid")
    private Integer accessrightsgroupid;
    @Column(name = "accessrightgroupstatus")
    private Boolean accessrightgroupstatus;
    @Size(max = 2147483647)
    @Column(name = "accessrightgroupname", length = 2147483647)
    private String accessrightgroupname;
    @Column(name = "facilityid")
    private Integer facilityid;

    @Column(name = "staffid")
    private Long staffid;
    @Column(name = "facilityunitid")
    private Long facilityunitid;
    @Column(name = "stafffacilityunitstatus")
    private Boolean stafffacilityunitstatus;
    
    @Column(name = "privilegekey")
    private String privilegekey;
    
    @Column(name = "isactive")
    private Boolean isactive;
    
    public Staffassignedrights() {
    }

    public Integer getStafffacilityunitaccessrightprivilegeid() {
        return stafffacilityunitaccessrightprivilegeid;
    }

    public void setStafffacilityunitaccessrightprivilegeid(Integer stafffacilityunitaccessrightprivilegeid) {
        this.stafffacilityunitaccessrightprivilegeid = stafffacilityunitaccessrightprivilegeid;
    }

    public Boolean getStafffacilityunitaccessrightprivstatus() {
        return stafffacilityunitaccessrightprivstatus;
    }

    public void setStafffacilityunitaccessrightprivstatus(Boolean stafffacilityunitaccessrightprivstatus) {
        this.stafffacilityunitaccessrightprivstatus = stafffacilityunitaccessrightprivstatus;
    }

    public Long getStafffacilityunitid() {
        return stafffacilityunitid;
    }

    public void setStafffacilityunitid(Long stafffacilityunitid) {
        this.stafffacilityunitid = stafffacilityunitid;
    }

    public Integer getAccessrightgroupprivilegeid() {
        return accessrightgroupprivilegeid;
    }

    public void setAccessrightgroupprivilegeid(Integer accessrightgroupprivilegeid) {
        this.accessrightgroupprivilegeid = accessrightgroupprivilegeid;
    }

    public Boolean getAccessrightgroupprivilegestatus() {
        return accessrightgroupprivilegestatus;
    }

    public void setAccessrightgroupprivilegestatus(Boolean accessrightgroupprivilegestatus) {
        this.accessrightgroupprivilegestatus = accessrightgroupprivilegestatus;
    }

    public Long getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(Long privilegeid) {
        this.privilegeid = privilegeid;
    }

    public String getAccessrightgroupname() {
        return accessrightgroupname;
    }

    public void setAccessrightgroupname(String accessrightgroupname) {
        this.accessrightgroupname = accessrightgroupname;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }


    public Integer getAccessrightsgroupid() {
        return accessrightsgroupid;
    }

    public void setAccessrightsgroupid(Integer accessrightsgroupid) {
        this.accessrightsgroupid = accessrightsgroupid;
    }

    public Boolean getAccessrightgroupstatus() {
        return accessrightgroupstatus;
    }

    public void setAccessrightgroupstatus(Boolean accessrightgroupstatus) {
        this.accessrightgroupstatus = accessrightgroupstatus;
    }

    public Long getStaffid() {
        return staffid;
    }

    public void setStaffid(Long staffid) {
        this.staffid = staffid;
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Boolean getStafffacilityunitstatus() {
        return stafffacilityunitstatus;
    }

    public void setStafffacilityunitstatus(Boolean stafffacilityunitstatus) {
        this.stafffacilityunitstatus = stafffacilityunitstatus;
    }

    public String getPrivilegekey() {
        return privilegekey;
    }

    public void setPrivilegekey(String privilegekey) {
        this.privilegekey = privilegekey;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    
}
