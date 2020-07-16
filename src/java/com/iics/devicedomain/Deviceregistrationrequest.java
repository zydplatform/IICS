/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.devicedomain;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "deviceregistrationrequest", catalog = "iics_database", schema = "accessdevice")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Deviceregistrationrequest.findAll", query = "SELECT d FROM Deviceregistrationrequest d")
    , @NamedQuery(name = "Deviceregistrationrequest.findByRequestid", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.requestid = :requestid")
    , @NamedQuery(name = "Deviceregistrationrequest.findByIsregistered", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.isregistered = :isregistered")
    , @NamedQuery(name = "Deviceregistrationrequest.findByDaterequested", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.daterequested = :daterequested")
    , @NamedQuery(name = "Deviceregistrationrequest.findBySerialnumber", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.serialnumber = :serialnumber")
    , @NamedQuery(name = "Deviceregistrationrequest.findByAddedby", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.addedby = :addedby")
    , @NamedQuery(name = "Deviceregistrationrequest.findByRequestnote", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.requestnote = :requestnote")
    , @NamedQuery(name = "Deviceregistrationrequest.findByOperatingsystem", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.operatingsystem = :operatingsystem")
    , @NamedQuery(name = "Deviceregistrationrequest.findByUpdatedby", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.updatedby = :updatedby")
    , @NamedQuery(name = "Deviceregistrationrequest.findByPhysicalcondition", query = "SELECT d FROM Deviceregistrationrequest d WHERE d.physicalcondition = :physicalcondition")})

public class Deviceregistrationrequest implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
     @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "requestid", nullable = false)
    private Long requestid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "isregistered", nullable = false)
    private boolean isregistered;
    @Basic(optional = false)
    @NotNull
    @Column(name = "daterequested", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date daterequested;
    @Size(max = 255)
    @Column(name = "serialnumber", length = 255)
    private String serialnumber;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Size(max = 2147483647)
    @Column(name = "requestnote", length = 2147483647)
    private String requestnote;
    @Size(max = 20)
    @Column(name = "operatingsystem", length = 20)
    private String operatingsystem;
    @Column(name = "updatedby")
    private BigInteger updatedby;
    @Size(max = 2147483647)
    @Column(name = "physicalcondition", length = 2147483647)
    private String physicalcondition;
    
    @Column(name = "computerlogid")
    private Long computerlogid;

    public Long getComputerlogid() {
        return computerlogid;
    }

    public void setComputerlogid(Long computerlogid) {
        this.computerlogid = computerlogid;
    }

    public Deviceregistrationrequest() {
    }

    public Deviceregistrationrequest(Long requestid) {
        this.requestid = requestid;
    }

    public Deviceregistrationrequest(Long requestid, boolean isregistered, Date daterequested) {
        this.requestid = requestid;
        this.isregistered = isregistered;
        this.daterequested = daterequested;
    }

    public Long getRequestid() {
        return requestid;
    }

    public void setRequestid(Long requestid) {
        this.requestid = requestid;
    }

    public boolean getIsregistered() {
        return isregistered;
    }

    public void setIsregistered(boolean isregistered) {
        this.isregistered = isregistered;
    }

    public Date getDaterequested() {
        return daterequested;
    }

    public void setDaterequested(Date daterequested) {
        this.daterequested = daterequested;
    }

    public String getSerialnumber() {
        return serialnumber;
    }

    public void setSerialnumber(String serialnumber) {
        this.serialnumber = serialnumber;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public String getRequestnote() {
        return requestnote;
    }

    public void setRequestnote(String requestnote) {
        this.requestnote = requestnote;
    }
    public String getOperatingsystem() {
        return operatingsystem;
    }

    public void setOperatingsystem(String operatingsystem) {
        this.operatingsystem = operatingsystem;
    }

    public BigInteger getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(BigInteger updatedby) {
        this.updatedby = updatedby;
    }

    public String getPhysicalcondition() {
        return physicalcondition;
    }

    public void setPhysicalcondition(String physicalcondition) {
        this.physicalcondition = physicalcondition;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (requestid != null ? requestid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Deviceregistrationrequest)) {
            return false;
        }
        Deviceregistrationrequest other = (Deviceregistrationrequest) object;
        if ((this.requestid == null && other.requestid != null) || (this.requestid != null && !this.requestid.equals(other.requestid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.devicedomain.Deviceregistrationrequest[ requestid=" + requestid + " ]";
    }
    
}
