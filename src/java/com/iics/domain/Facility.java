/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/** 
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "facility", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facility.findAll", query = "SELECT f FROM Facility f")
    , @NamedQuery(name = "Facility.findByFacilityid", query = "SELECT f FROM Facility f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facility.findByFacilityname", query = "SELECT f FROM Facility f WHERE f.facilityname = :facilityname")
    , @NamedQuery(name = "Facility.findByFacilitycode", query = "SELECT f FROM Facility f WHERE f.facilitycode = :facilitycode")
    , @NamedQuery(name = "Facility.findByStatus", query = "SELECT f FROM Facility f WHERE f.status = :status")
    , @NamedQuery(name = "Facility.findByFile", query = "SELECT f FROM Facility f WHERE f.file = :file")
    , @NamedQuery(name = "Facility.findByIsgoodssupplier", query = "SELECT f FROM Facility f WHERE f.isgoodssupplier = :isgoodssupplier")
    , @NamedQuery(name = "Facility.findByIssuppliessuplier", query = "SELECT f FROM Facility f WHERE f.issuppliessuplier = :issuppliessuplier")
    , @NamedQuery(name = "Facility.findByHasbranch", query = "SELECT f FROM Facility f WHERE f.hasbranch = :hasbranch")
    , @NamedQuery(name = "Facility.findByHasdepartments", query = "SELECT f FROM Facility f WHERE f.hasdepartments = :hasdepartments")})
public class Facility implements Serializable {

    private static final long serialVersionUID = 1L;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityid", nullable = false)
    private Integer facilityid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "facilityname", nullable = false, length = 2147483647)
    private String facilityname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "facilitycode", nullable = false, length = 2147483647)
    private String facilitycode;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "status", nullable = false, length = 2147483647)
    private String status;
    @Column(name = "shortname")
    private String shortname;
    @Column(name = "description")
    private String description;
    @Column(name = "location")
    private String location;
    @Column(name = "facilitylogourl")
    private String facilitylogourl;
    @Column(name = "active")
    private boolean active;
    @Column(name = "dateadded")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateadded;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateapproved;
    @Column(name = "ipnetwork", length = 2147483647)
    private String ipnetwork;
    @Column(name = "phonecontact")
    private String phonecontact;
    @Column(name = "phonecontact2")
    private String phonecontact2;
    @Column(name = "emailaddress")
    private String emailaddress;
    @Column(name = "website")
    private String website;
    @Column(name = "postaddress")
    private String postaddress;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "file", precision = 19, scale = 2)
    private BigDecimal file;
    @Column(name = "hasbranch")
    private boolean hasbranch;
    @Column(name = "issuppliessuplier")
    private Boolean issuppliessuplier;
     @Column(name = "isgoodssupplier")
    private Boolean isgoodssupplier;
    @Column(name = "facilityfunder", length = 50)
    private String facilityfunder;
    @Size(max = 50)
    @Column(name = "hasdepartments", nullable = false)
    private boolean hasdepartments;
    @Column(name = "gpsnorthing")
    private String gpsnorthing;
    @Column(name = "gpseasting")
    private String gpseasting;
    @OneToMany(mappedBy = "currentfacility")
    private List<Staff> staffList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "facilityid")
    private List<Location> locationList;
    @OneToMany(mappedBy = "parentbranchid")
    private List<Facility> facilityList;
    @JoinColumn(name = "parentbranchid", referencedColumnName = "facilityid")
    @ManyToOne
    private Facility parentbranchid;
    @JoinColumn(name = "facilitydomainid", referencedColumnName = "facilitydomainid")
    @ManyToOne
    private Facilitydomain facilitydomainid;
    @JoinColumn(name = "facilitylevelid", referencedColumnName = "facilitylevelid", nullable = false)
    @ManyToOne(optional = false)
    private Facilitylevel facilitylevelid;
    @JoinColumn(name = "facilityownerid", referencedColumnName = "facilityownerid")
    @ManyToOne
    private Facilityowner facilityownerid;
    @JoinColumn(name = "locationid", referencedColumnName = "locationid")
    @ManyToOne
    private Location locationid;
    @JoinColumn(name = "villageid", referencedColumnName = "villageid")
    @ManyToOne
    private Village village;
    @JoinColumn(name = "updateby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @JoinColumn(name = "approvedby", referencedColumnName = "personid")
    @ManyToOne
    private Person person1;
    @JoinColumn(name = "addedby", referencedColumnName = "personid", nullable = false)
    @ManyToOne(optional = false)
    private Person person2;

    public Facility() {
    }

    public Facility(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public Facility(Integer facilityid, String facilityname, String facilitycode, String status, boolean hasbranch, boolean hasdepartments) {
        this.facilityid = facilityid;
        this.facilityname = facilityname;
        this.facilitycode = facilitycode;
        this.status = status;
        this.hasbranch = hasbranch;
        this.hasdepartments = hasdepartments;
    }

    public Integer getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Integer facilityid) {
        this.facilityid = facilityid;
    }

    public String getFacilityname() {
        return facilityname;
    }

    public void setFacilityname(String facilityname) {
        this.facilityname = facilityname;
    }

    public String getFacilitycode() {
        return facilitycode;
    }

    public void setFacilitycode(String facilitycode) {
        this.facilitycode = facilitycode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getFile() {
        return file;
    }

    public void setFile(BigDecimal file) {
        this.file = file;
    }

    public Boolean getIsgoodssupplier() {
        return isgoodssupplier;
    }

    public void setIsgoodssupplier(Boolean isgoodssupplier) {
        this.isgoodssupplier = isgoodssupplier;
    }

    public Boolean getIssuppliessuplier() {
        return issuppliessuplier;
    }

    public void setIssuppliessuplier(Boolean issuppliessuplier) {
        this.issuppliessuplier = issuppliessuplier;
    }

    public String getFacilityfunder() {
        return facilityfunder;
    }

    public void setFacilityfunder(String facilityfunder) {
        this.facilityfunder = facilityfunder;
    }


    public boolean getHasbranch() {
        return hasbranch;
    }

    public void setHasbranch(boolean hasbranch) {
        this.hasbranch = hasbranch;
    }

    public boolean getHasdepartments() {
        return hasdepartments;
    }

    public void setHasdepartments(boolean hasdepartments) {
        this.hasdepartments = hasdepartments;
    }

    @XmlTransient
    public List<Staff> getStaffList() {
        return staffList;
    }

    public void setStaffList(List<Staff> staffList) {
        this.staffList = staffList;
    }

    
    @XmlTransient
    public List<Location> getLocationList() {
        return locationList;
    }

    public void setLocationList(List<Location> locationList) {
        this.locationList = locationList;
    }

    @XmlTransient
    public List<Facility> getFacilityList() {
        return facilityList;
    }

    public void setFacilityList(List<Facility> facilityList) {
        this.facilityList = facilityList;
    }

    public Facility getParentbranchid() {
        return parentbranchid;
    }

    public void setParentbranchid(Facility parentbranchid) {
        this.parentbranchid = parentbranchid;
    }

    public Facilitydomain getFacilitydomainid() {
        return facilitydomainid;
    }

    public void setFacilitydomainid(Facilitydomain facilitydomainid) {
        this.facilitydomainid = facilitydomainid;
    }

    public Facilitylevel getFacilitylevelid() {
        return facilitylevelid;
    }

    public void setFacilitylevelid(Facilitylevel facilitylevelid) {
        this.facilitylevelid = facilitylevelid;
    }

    public Facilityowner getFacilityownerid() {
        return facilityownerid;
    }

    public void setFacilityownerid(Facilityowner facilityownerid) {
        this.facilityownerid = facilityownerid;
    }

    public Location getLocationid() {
        return locationid;
    }

    public void setLocationid(Location locationid) {
        this.locationid = locationid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityid != null ? facilityid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facility)) {
            return false;
        }
        Facility other = (Facility) object;
        if ((this.facilityid == null && other.facilityid != null) || (this.facilityid != null && !this.facilityid.equals(other.facilityid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Facility[ facilityid=" + facilityid + " ]";
    }

    public Village getVillage() {
        return village;
    }

    public void setVillage(Village village) {
        this.village = village;
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

    public Person getPerson2() {
        return person2;
    }

    public void setPerson2(Person person2) {
        this.person2 = person2;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getFacilitylogourl() {
        return facilitylogourl;
    }

    public void setFacilitylogourl(String facilitylogourl) {
        this.facilitylogourl = facilitylogourl;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
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

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public String getIpnetwork() {
        return ipnetwork;
    }

    public void setIpnetwork(String ipnetwork) {
        this.ipnetwork = ipnetwork;
    }

    public String getPhonecontact() {
        return phonecontact;
    }

    public void setPhonecontact(String phonecontact) {
        this.phonecontact = phonecontact;
    }

    public String getPhonecontact2() {
        return phonecontact2;
    }

    public void setPhonecontact2(String phonecontact2) {
        this.phonecontact2 = phonecontact2;
    }

    public String getEmailaddress() {
        return emailaddress;
    }

    public void setEmailaddress(String emailaddress) {
        this.emailaddress = emailaddress;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getPostaddress() {
        return postaddress;
    }

    public void setPostaddress(String postaddress) {
        this.postaddress = postaddress;
    }
    
    public String getGpsnorthing() {
        return gpsnorthing;
    }

    public void setGpsnorthing(String gpsnorthing) {
        this.gpsnorthing = gpsnorthing;
    }

    public String getGpseasting() {
        return gpseasting;
    }

    public void setGpseasting(String gpseasting) {
        this.gpseasting = gpseasting;
    }

    public boolean isHasbranch() {
        return hasbranch;
    }

    public boolean isHasdepartments() {
        return hasdepartments;
    }

    public boolean isActive() {
        return active;
    }

}
