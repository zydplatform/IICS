/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.devicedomain;

import com.iics.domain.Facility;
import com.iics.domain.Person;
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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "registereddevice", catalog = "iics_database", schema = "accessdevice", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"macaddress"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Registereddevice.findAll", query = "SELECT r FROM Registereddevice r"),
    @NamedQuery(name = "Registereddevice.findByRegistereddeviceid", query = "SELECT r FROM Registereddevice r WHERE r.registereddeviceid = :registereddeviceid"),
    @NamedQuery(name = "Registereddevice.findByMacaddress", query = "SELECT r FROM Registereddevice r WHERE r.macaddress = :macaddress"),
    @NamedQuery(name = "Registereddevice.findByPhysicalcondition", query = "SELECT r FROM Registereddevice r WHERE r.physicalcondition = :physicalcondition"),
    @NamedQuery(name = "Registereddevice.findByActive", query = "SELECT r FROM Registereddevice r WHERE r.active = :active"),
    @NamedQuery(name = "Registereddevice.findByOperatingsystem", query = "SELECT r FROM Registereddevice r WHERE r.operatingsystem = :operatingsystem"),
    @NamedQuery(name = "Registereddevice.findByDevicename", query = "SELECT r FROM Registereddevice r WHERE r.devicename = :devicename"),
    @NamedQuery(name = "Registereddevice.findBySerialnumber", query = "SELECT r FROM Registereddevice r WHERE r.serialnumber = :serialnumber")})
public class Registereddevice implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "RegisteredDeviceSeq",strategy= GenerationType.AUTO)
    @SequenceGenerator(name = "RegisteredDeviceSeq", sequenceName = "registeredDevice_registereddeviceid_seq", allocationSize = 1, initialValue=1)
    @Basic(optional = false)
    @Column(name = "registereddeviceid", nullable = false)
    private Long registereddeviceid;
    @Basic(optional = false)
    @Column(name = "macaddress", nullable = false, length = 2147483647)
    private String macaddress;
    @Basic(optional = false)
    @Column(name = "physicalcondition", length = 2147483647)
    private String physicalcondition;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "devicetype", length = 25)
    private String devicetype;
    @Column(name = "operatingsystem", length = 20)
    private String operatingsystem;
    @Basic(optional = false)
    @Column(name = "devicename", length = 2147483647)
    private String devicename;
    @Column(name = "serialnumber", length = 255)
    private String serialnumber;
    @Column(name = "devicerequestid")
    private long devicerequestid;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateapproved;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @JoinColumn(name = "approvedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person2;
    @JoinColumn(name = "devicemanufacturerid", referencedColumnName = "devicemanufacturerid", nullable = false)
    @ManyToOne(optional = false)
    private Devicemanufacturer devicemanufacturer;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid", nullable = false)
    @ManyToOne(optional = false)
    private Facility facility;

    public Registereddevice() {
    }

    public Registereddevice(Long registereddeviceid) {
        this.registereddeviceid = registereddeviceid;
    }

    public Registereddevice(Long registereddeviceid, String macaddress, long registeredby, Date dateregistered, boolean active, long facilityassigned) {
        this.registereddeviceid = registereddeviceid;
        this.macaddress = macaddress;
        this.active = active;
    }

    public Long getRegistereddeviceid() {
        return registereddeviceid;
    }

    public void setRegistereddeviceid(Long registereddeviceid) {
        this.registereddeviceid = registereddeviceid;
    }

    public String getMacaddress() {
        return macaddress;
    }

    public void setMacaddress(String macaddress) {
        this.macaddress = macaddress;
    }

    public String getPhysicalcondition() {
        return physicalcondition;
    }

    public void setPhysicalcondition(String physicalcondition) {
        this.physicalcondition = physicalcondition;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getDevicetype() {
        return devicetype;
    }

    public void setDevicetype(String devicetype) {
        this.devicetype = devicetype;
    }

    public String getOperatingsystem() {
        return operatingsystem;
    }

    public void setOperatingsystem(String operatingsystem) {
        this.operatingsystem = operatingsystem;
    }

    public long getDevicerequestid() {
        return devicerequestid;
    }

    public void setDevicerequestid(long devicerequestid) {
        this.devicerequestid = devicerequestid;
    }

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public String getDevicename() {
        return devicename;
    }

    public void setDevicename(String devicename) {
        this.devicename = devicename;
    }

    public String getSerialnumber() {
        return serialnumber;
    }

    public void setSerialnumber(String serialnumber) {
        this.serialnumber = serialnumber;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public Person getPerson1() {
        return person1;
    }

    public void setPerson1(Person person1) {
        this.person1 = person1;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public Person getPerson2() {
        return person2;
    }

    public void setPerson2(Person person2) {
        this.person2 = person2;
    }

    
    public Devicemanufacturer getDevicemanufacturer() {
        return devicemanufacturer;
    }

    public void setDevicemanufacturer(Devicemanufacturer devicemanufacturer) {
        this.devicemanufacturer = devicemanufacturer;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (registereddeviceid != null ? registereddeviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Registereddevice)) {
            return false;
        }
        Registereddevice other = (Registereddevice) object;
        if ((this.registereddeviceid == null && other.registereddeviceid != null) || (this.registereddeviceid != null && !this.registereddeviceid.equals(other.registereddeviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.devicedomain.Registereddevice[ registereddeviceid=" + registereddeviceid + " ]";
    }
    
}
