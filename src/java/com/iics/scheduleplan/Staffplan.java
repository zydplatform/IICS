/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.scheduleplan;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "staffplan", catalog = "iics_database", schema = "scheduleplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffplan.findAll", query = "SELECT s FROM Staffplan s")
    , @NamedQuery(name = "Staffplan.findByStaffplanid", query = "SELECT s FROM Staffplan s WHERE s.staffplanid = :staffplanid")
    , @NamedQuery(name = "Staffplan.findByStaffid", query = "SELECT s FROM Staffplan s WHERE s.staffid = :staffid")
    , @NamedQuery(name = "Staffplan.findByStaffplanweek", query = "SELECT s FROM Staffplan s WHERE s.staffplanweek = :staffplanweek")
    , @NamedQuery(name = "Staffplan.findByStaffplanyear", query = "SELECT s FROM Staffplan s WHERE s.staffplanyear = :staffplanyear")})
public class Staffplan implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "staffplanid", nullable = false)
    private Long staffplanid;
    @Column(name = "staffid")
    private BigInteger staffid;
    @Column(name = "staffplanweek")
    private Integer staffplanweek;
    @Size(max = 30)
    @Column(name = "staffplanyear", length = 30)
    private String staffplanyear;

    public Staffplan() {
    }

    public Staffplan(Long staffplanid) {
        this.staffplanid = staffplanid;
    }

    public Long getStaffplanid() {
        return staffplanid;
    }

    public void setStaffplanid(Long staffplanid) {
        this.staffplanid = staffplanid;
    }

    public BigInteger getStaffid() {
        return staffid;
    }

    public void setStaffid(BigInteger staffid) {
        this.staffid = staffid;
    }

    public Integer getStaffplanweek() {
        return staffplanweek;
    }

    public void setStaffplanweek(Integer staffplanweek) {
        this.staffplanweek = staffplanweek;
    }

    public String getStaffplanyear() {
        return staffplanyear;
    }

    public void setStaffplanyear(String staffplanyear) {
        this.staffplanyear = staffplanyear;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffplanid != null ? staffplanid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staffplan)) {
            return false;
        }
        Staffplan other = (Staffplan) object;
        if ((this.staffplanid == null && other.staffplanid != null) || (this.staffplanid != null && !this.staffplanid.equals(other.staffplanid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.scheduleplan.Staffplan[ staffplanid=" + staffplanid + " ]";
    }
    
}
