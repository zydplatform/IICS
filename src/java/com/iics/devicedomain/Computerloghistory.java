/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.devicedomain;

import com.iics.domain.Facility;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "computerloghistory", catalog = "iics_database", schema = "accessdevice")
@NamedQueries({
    @NamedQuery(name = "Computerloghistory.findAll", query = "SELECT c FROM Computerloghistory c"),
    @NamedQuery(name = "Computerloghistory.findByComputerloghistoryid", query = "SELECT c FROM Computerloghistory c WHERE c.computerloghistoryid = :computerloghistoryid"),
    @NamedQuery(name = "Computerloghistory.findByAccessdate", query = "SELECT c FROM Computerloghistory c WHERE c.accessdate = :accessdate"),
    @NamedQuery(name = "Computerloghistory.findByComputername", query = "SELECT c FROM Computerloghistory c WHERE c.computername = :computername"),
    @NamedQuery(name = "Computerloghistory.findByDevice", query = "SELECT c FROM Computerloghistory c WHERE c.device = :device"),
    @NamedQuery(name = "Computerloghistory.findByIsregistered", query = "SELECT c FROM Computerloghistory c WHERE c.isregistered = :isregistered"),
    @NamedQuery(name = "Computerloghistory.findByMacaddress", query = "SELECT c FROM Computerloghistory c WHERE c.macaddress = :macaddress")})
public class Computerloghistory implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY, generator = "Computerloghistoryid_seq")
    @SequenceGenerator(name = "Computerloghistoryid_seq", sequenceName = "computerloghistory_computerloghistoryid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "computerloghistoryid", nullable = false)
    private Long computerloghistoryid;
    @Basic(optional = false)
    @Column(name = "accessdate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date accessdate;
    
    @Column(name = "computername", length = 255)
    private String computername;
    @Column(name = "device", length = 255)
    private String device;
    @Basic(optional = false)
    @Column(name = "ipaddress", nullable = false, length = 255)
    private String ipaddress;
    @Basic(optional = false)
    @Column(name = "isregistered", nullable = false)
    private boolean isregistered;
    @Basic(optional = false)
    @Column(name = "macaddress", nullable = false, length = 255)
    private String macaddress;
    @Column(name = "useraccount")
    private String useraccount;
    @Column(name = "sentrequest")
    private boolean sentrequest;
    @Column(name = "registereduser")
    private boolean registereduser;
    @Column(name = "active")
    private boolean active;
    @Column(name = "operatingsystem", length = 20)
    private String operatingsystem;
    @Column(name = "useragent")
    private String useragent;
    @Column(name = "userid")
    private Long userid;

    @OneToMany(mappedBy = "computerloghistory")
    private List<Userslog> userslogList;
    @OneToMany(mappedBy = "computerloghistory1")
    private List<Userslog> userslogList1;

    public Computerloghistory() {
    }

    public Computerloghistory(Long computerloghistoryid) {
        this.computerloghistoryid = computerloghistoryid;
    }

    public Computerloghistory(Long computerloghistoryid, Date accessdate, String ipaddress, boolean isregistered, String macaddress) {
        this.computerloghistoryid = computerloghistoryid;
        this.accessdate = accessdate;
        this.ipaddress = ipaddress;
        this.isregistered = isregistered;
        this.macaddress = macaddress;
    }

    public Long getComputerloghistoryid() {
        return computerloghistoryid;
    }

    public void setComputerloghistoryid(Long computerloghistoryid) {
        this.computerloghistoryid = computerloghistoryid;
    }

    public Date getAccessdate() {
        return accessdate;
    }

    public void setAccessdate(Date accessdate) {
        this.accessdate = accessdate;
    }

    public String getComputername() {
        return computername;
    }

    public void setComputername(String computername) {
        this.computername = computername;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    public String getIpaddress() {
        return ipaddress;
    }

    public void setIpaddress(String ipaddress) {
        this.ipaddress = ipaddress;
    }

    public boolean getIsregistered() {
        return isregistered;
    }

    public void setIsregistered(boolean isregistered) {
        this.isregistered = isregistered;
    }

    public String getMacaddress() {
        return macaddress;
    }

    public void setMacaddress(String macaddress) {
        this.macaddress = macaddress;
    }
    
    public String getUseraccount() {
        return useraccount;
    }

    public void setUseraccount(String useraccount) {
        this.useraccount = useraccount;
    }

    public boolean getSentrequest() {
        return sentrequest;
    }

    public void setSentrequest(boolean sentrequest) {
        this.sentrequest = sentrequest;
    }

    public boolean getRegistereduser() {
        return registereduser;
    }

    public void setRegistereduser(boolean registereduser) {
        this.registereduser = registereduser;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getOperatingsystem() {
        return operatingsystem;
    }

    public void setOperatingsystem(String operatingsystem) {
        this.operatingsystem = operatingsystem;
    }

    public String getUseragent() {
        return useragent;
    }

    public void setUseragent(String useragent) {
        this.useragent = useragent;
    }

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    public List<Userslog> getUserslogList() {
        return userslogList;
    }

    public void setUserslogList(List<Userslog> userslogList) {
        this.userslogList = userslogList;
    }

    public List<Userslog> getUserslogList1() {
        return userslogList1;
    }

    public void setUserslogList1(List<Userslog> userslogList1) {
        this.userslogList1 = userslogList1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (computerloghistoryid != null ? computerloghistoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Computerloghistory)) {
            return false;
        }
        Computerloghistory other = (Computerloghistory) object;
        if ((this.computerloghistoryid == null && other.computerloghistoryid != null) || (this.computerloghistoryid != null && !this.computerloghistoryid.equals(other.computerloghistoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.devicedomain.Computerloghistory[ computerloghistoryid=" + computerloghistoryid + " ]";
    }
    
}
