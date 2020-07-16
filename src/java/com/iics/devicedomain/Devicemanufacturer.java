/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.devicedomain;

import com.iics.domain.Person;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "devicemanufacturer", catalog = "iics_database", schema = "accessdevice")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Devicemanufacturer.findAll", query = "SELECT d FROM Devicemanufacturer d"),
    @NamedQuery(name = "Devicemanufacturer.findByDevicemanufacturerid", query = "SELECT d FROM Devicemanufacturer d WHERE d.devicemanufacturerid = :devicemanufacturerid"),
    @NamedQuery(name = "Devicemanufacturer.findByManufacturer", query = "SELECT d FROM Devicemanufacturer d WHERE d.manufacturer = :manufacturer")})
public class Devicemanufacturer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "DeviceManufacturerSeq",strategy= GenerationType.AUTO)
    @SequenceGenerator(name = "DeviceManufacturerSeq", sequenceName = "deviceManufacturer_manufacturerid_seq", allocationSize = 1, initialValue=1)
    @Basic(optional = false)
    @Column(name = "devicemanufacturerid", nullable = false)
    private Long devicemanufacturerid;
    @Basic(optional = false)
    @Column(name = "manufacturer", nullable = false, length = 255)
    private String manufacturer;
    @Column(name = "description", length = 2147483647)
    private String description;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "released")
    private boolean released;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person;
    @JoinColumn(name = "updatedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "devicemanufacturer")
    private List<Registereddevice> registereddeviceList;

    public Devicemanufacturer() {
    }

    public Devicemanufacturer(Long devicemanufacturerid) {
        this.devicemanufacturerid = devicemanufacturerid;
    }

    public Devicemanufacturer(Long devicemanufacturerid, String manufacturer) {
        this.devicemanufacturerid = devicemanufacturerid;
        this.manufacturer = manufacturer;
    }

    public Long getDevicemanufacturerid() {
        return devicemanufacturerid;
    }

    public void setDevicemanufacturerid(Long devicemanufacturerid) {
        this.devicemanufacturerid = devicemanufacturerid;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean getReleased() {
        return released;
    }

    public void setReleased(boolean released) {
        this.released = released;
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

    @XmlTransient
    public List<Registereddevice> getRegistereddeviceList() {
        return registereddeviceList;
    }

    public void setRegistereddeviceList(List<Registereddevice> registereddeviceList) {
        this.registereddeviceList = registereddeviceList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (devicemanufacturerid != null ? devicemanufacturerid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Devicemanufacturer)) {
            return false;
        }
        Devicemanufacturer other = (Devicemanufacturer) object;
        if ((this.devicemanufacturerid == null && other.devicemanufacturerid != null) || (this.devicemanufacturerid != null && !this.devicemanufacturerid.equals(other.devicemanufacturerid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.devicedomain.Devicemanufacturer[ devicemanufacturerid=" + devicemanufacturerid + " ]";
    }
    
}
