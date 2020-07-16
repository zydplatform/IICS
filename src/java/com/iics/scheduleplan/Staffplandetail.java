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
@Table(name = "staffplandetail", catalog = "iics_database", schema = "scheduleplan")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staffplandetail.findAll", query = "SELECT s FROM Staffplandetail s")
    , @NamedQuery(name = "Staffplandetail.findByStaffplandetailid", query = "SELECT s FROM Staffplandetail s WHERE s.staffplandetailid = :staffplandetailid")
    , @NamedQuery(name = "Staffplandetail.findByStaffplanid", query = "SELECT s FROM Staffplandetail s WHERE s.staffplanid = :staffplanid")
    , @NamedQuery(name = "Staffplandetail.findByPlandetailday", query = "SELECT s FROM Staffplandetail s WHERE s.plandetailday = :plandetailday")
    , @NamedQuery(name = "Staffplandetail.findByPlanstarttime", query = "SELECT s FROM Staffplandetail s WHERE s.planstarttime = :planstarttime")
    , @NamedQuery(name = "Staffplandetail.findByPlanendtime", query = "SELECT s FROM Staffplandetail s WHERE s.planendtime = :planendtime")
    , @NamedQuery(name = "Staffplandetail.findByStaffserviceid", query = "SELECT s FROM Staffplandetail s WHERE s.staffserviceid = :staffserviceid")})
public class Staffplandetail implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "staffplandetailid", nullable = false)
    private Long staffplandetailid;
    @Column(name = "staffplanid")
    private BigInteger staffplanid;
    @Column(name = "plandetailday")
    private Integer plandetailday;
    @Size(max = 30)
    @Column(name = "planstarttime", length = 30)
    private String planstarttime;
    @Size(max = 30)
    @Column(name = "planendtime", length = 30)
    private String planendtime;
    @Column(name = "staffserviceid")
    private BigInteger staffserviceid;

    public Staffplandetail() {
    }

    public Staffplandetail(Long staffplandetailid) {
        this.staffplandetailid = staffplandetailid;
    }

    public Long getStaffplandetailid() {
        return staffplandetailid;
    }

    public void setStaffplandetailid(Long staffplandetailid) {
        this.staffplandetailid = staffplandetailid;
    }

    public BigInteger getStaffplanid() {
        return staffplanid;
    }

    public void setStaffplanid(BigInteger staffplanid) {
        this.staffplanid = staffplanid;
    }

    public Integer getPlandetailday() {
        return plandetailday;
    }

    public void setPlandetailday(Integer plandetailday) {
        this.plandetailday = plandetailday;
    }

    public String getPlanstarttime() {
        return planstarttime;
    }

    public void setPlanstarttime(String planstarttime) {
        this.planstarttime = planstarttime;
    }

    public String getPlanendtime() {
        return planendtime;
    }

    public void setPlanendtime(String planendtime) {
        this.planendtime = planendtime;
    }

    public BigInteger getStaffserviceid() {
        return staffserviceid;
    }

    public void setStaffserviceid(BigInteger staffserviceid) {
        this.staffserviceid = staffserviceid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffplandetailid != null ? staffplandetailid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staffplandetail)) {
            return false;
        }
        Staffplandetail other = (Staffplandetail) object;
        if ((this.staffplandetailid == null && other.staffplandetailid != null) || (this.staffplandetailid != null && !this.staffplandetailid.equals(other.staffplandetailid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.scheduleplan.Staffplandetail[ staffplandetailid=" + staffplandetailid + " ]";
    }
    
}
