/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import com.iics.store.Supplier;
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
@Table(name = "person", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Person.findAll", query = "SELECT p FROM Person p")
    , @NamedQuery(name = "Person.findByPersonid", query = "SELECT p FROM Person p WHERE p.personid = :personid")
    , @NamedQuery(name = "Person.findByFirstname", query = "SELECT p FROM Person p WHERE p.firstname = :firstname")
    , @NamedQuery(name = "Person.findByOthernames", query = "SELECT p FROM Person p WHERE p.othernames = :othernames")
    , @NamedQuery(name = "Person.findByLastname", query = "SELECT p FROM Person p WHERE p.lastname = :lastname")
    , @NamedQuery(name = "Person.findByDob", query = "SELECT p FROM Person p WHERE p.dob = :dob")
    , @NamedQuery(name = "Person.findByEstimatedage", query = "SELECT p FROM Person p WHERE p.estimatedage = :estimatedage")
    , @NamedQuery(name = "Person.findByDatecreated", query = "SELECT p FROM Person p WHERE p.datecreated = :datecreated")
    , @NamedQuery(name = "Person.findByDod", query = "SELECT p FROM Person p WHERE p.dod = :dod")
    , @NamedQuery(name = "Person.findByGender", query = "SELECT p FROM Person p WHERE p.gender = :gender")
    , @NamedQuery(name = "Person.findByEstimated", query = "SELECT p FROM Person p WHERE p.estimated = :estimated")
    , @NamedQuery(name = "Person.findBySpokenlanguageid", query = "SELECT p FROM Person p WHERE p.spokenlanguageid = :spokenlanguageid")
    , @NamedQuery(name = "Person.findByWrittenlanguage", query = "SELECT p FROM Person p WHERE p.writtenlanguage = :writtenlanguage")
    , @NamedQuery(name = "Person.findByTribe", query = "SELECT p FROM Person p WHERE p.tribe = :tribe")
    , @NamedQuery(name = "Person.findByNationality", query = "SELECT p FROM Person p WHERE p.nationality = :nationality")
    , @NamedQuery(name = "Person.findByMaritalstatus", query = "SELECT p FROM Person p WHERE p.maritalstatus = :maritalstatus")
    , @NamedQuery(name = "Person.findByConsent", query = "SELECT p FROM Person p WHERE p.consent = :consent")
    , @NamedQuery(name = "Person.findByDateupdated", query = "SELECT p FROM Person p WHERE p.dateupdated = :dateupdated")
    , @NamedQuery(name = "Person.findByFathersname", query = "SELECT p FROM Person p WHERE p.fathersname = :fathersname")
    , @NamedQuery(name = "Person.findByMothersname", query = "SELECT p FROM Person p WHERE p.mothersname = :mothersname")
    , @NamedQuery(name = "Person.findBySearchindexBiometricstate", query = "SELECT p FROM Person p WHERE p.searchindexBiometricstate = :searchindexBiometricstate")
    , @NamedQuery(name = "Person.findBySearchindexContactstate", query = "SELECT p FROM Person p WHERE p.searchindexContactstate = :searchindexContactstate")
    , @NamedQuery(name = "Person.findBySearchindexNokstate", query = "SELECT p FROM Person p WHERE p.searchindexNokstate = :searchindexNokstate")
    , @NamedQuery(name = "Person.findBySearchindexBiometricsstate", query = "SELECT p FROM Person p WHERE p.searchindexBiometricsstate = :searchindexBiometricsstate")
    , @NamedQuery(name = "Person.findByImagepath", query = "SELECT p FROM Person p WHERE p.imagepath = :imagepath")
    , @NamedQuery(name = "Person.findByFFirstname", query = "SELECT p FROM Person p WHERE p.fFirstname = :fFirstname")
    , @NamedQuery(name = "Person.findByFLastname", query = "SELECT p FROM Person p WHERE p.fLastname = :fLastname")
    , @NamedQuery(name = "Person.findByFOthernames", query = "SELECT p FROM Person p WHERE p.fOthernames = :fOthernames")
    , @NamedQuery(name = "Person.findByMFirstname", query = "SELECT p FROM Person p WHERE p.mFirstname = :mFirstname")
    , @NamedQuery(name = "Person.findByMLastname", query = "SELECT p FROM Person p WHERE p.mLastname = :mLastname")
    , @NamedQuery(name = "Person.findByMOthernames", query = "SELECT p FROM Person p WHERE p.mOthernames = :mOthernames")
    , @NamedQuery(name = "Person.findByIsPatient", query = "SELECT p FROM Person p WHERE p.isPatient = :isPatient")
    , @NamedQuery(name = "Person.findByIsStaff", query = "SELECT p FROM Person p WHERE p.isStaff = :isStaff")
    , @NamedQuery(name = "Person.findByPersonstate", query = "SELECT p FROM Person p WHERE p.personstate = :personstate")
    , @NamedQuery(name = "Person.findBySearchindexPatientstate", query = "SELECT p FROM Person p WHERE p.searchindexPatientstate = :searchindexPatientstate")
    , @NamedQuery(name = "Person.findByGFirstname", query = "SELECT p FROM Person p WHERE p.gFirstname = :gFirstname")
    , @NamedQuery(name = "Person.findByGLastname", query = "SELECT p FROM Person p WHERE p.gLastname = :gLastname")
    , @NamedQuery(name = "Person.findByGOthernames", query = "SELECT p FROM Person p WHERE p.gOthernames = :gOthernames")
    , @NamedQuery(name = "Person.findByCurrentaddressperiod", query = "SELECT p FROM Person p WHERE p.currentaddressperiod = :currentaddressperiod")
    , @NamedQuery(name = "Person.findByPreviousaddressperiod", query = "SELECT p FROM Person p WHERE p.previousaddressperiod = :previousaddressperiod")
    , @NamedQuery(name = "Person.findByLastaddressperiod", query = "SELECT p FROM Person p WHERE p.lastaddressperiod = :lastaddressperiod")
    , @NamedQuery(name = "Person.findByContactstate", query = "SELECT p FROM Person p WHERE p.contactstate = :contactstate")
    , @NamedQuery(name = "Person.findByIspatientstate", query = "SELECT p FROM Person p WHERE p.ispatientstate = :ispatientstate")
    , @NamedQuery(name = "Person.findByIsstaffstate", query = "SELECT p FROM Person p WHERE p.isstaffstate = :isstaffstate")
    , @NamedQuery(name = "Person.findByFatheralive", query = "SELECT p FROM Person p WHERE p.fatheralive = :fatheralive")
    , @NamedQuery(name = "Person.findByMotheralive", query = "SELECT p FROM Person p WHERE p.motheralive = :motheralive")
    , @NamedQuery(name = "Person.findByNoofchildren", query = "SELECT p FROM Person p WHERE p.noofchildren = :noofchildren")
    , @NamedQuery(name = "Person.findBySignaturepath", query = "SELECT p FROM Person p WHERE p.signaturepath = :signaturepath")
    , @NamedQuery(name = "Person.findByNin", query = "SELECT p FROM Person p WHERE p.nin = :nin")})
public class Person implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "personid", nullable = false)
    private Long personid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "firstname", nullable = false, length = 2147483647)
    private String firstname;
    @Size(max = 2147483647)
    @Column(name = "othernames", length = 2147483647)
    private String othernames;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "lastname", nullable = false, length = 2147483647)
    private String lastname;
    @Column(name = "dob")
    @Temporal(TemporalType.DATE)
    private Date dob;
    @Column(name = "estimatedage")
    private Integer estimatedage;
    @Column(name = "datecreated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datecreated;
    @Column(name = "dod")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dod;
    @Size(max = 2147483647)
    @Column(name = "gender", length = 2147483647)
    private String gender;
    @Column(name = "estimated")
    private Boolean estimated;
    @Size(max = 2147483647)
    @Column(name = "spokenlanguageid")
    private Integer spokenlanguageid;
    @Size(max = 2147483647)
    @Column(name = "writtenlanguage", length = 2147483647)
    private String writtenlanguage;
    @Size(max = 2147483647)
    @Column(name = "tribe", length = 2147483647)
    private String tribe;
    @Size(max = 2147483647)
    @Column(name = "nationality", length = 2147483647)
    private String nationality;
    @Size(max = 2147483647)
    @Column(name = "maritalstatus", length = 2147483647)
    private String maritalstatus;
    @Column(name = "consent")
    private Boolean consent;
    @Column(name = "dateupdated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateupdated;
    @Size(max = 50)
    @Column(name = "fathersname", length = 50)
    private String fathersname;
    @Size(max = 2147483647)
    @Column(name = "mothersname", length = 2147483647)
    private String mothersname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "searchindex_biometricstate", nullable = false)
    private boolean searchindexBiometricstate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "searchindex_contactstate", nullable = false)
    private boolean searchindexContactstate;
    @Column(name = "searchindex_nokstate")
    private Boolean searchindexNokstate;
    @Column(name = "searchindex_biometricsstate")
    private Boolean searchindexBiometricsstate;
    @Size(max = 255)
    @Column(name = "imagepath", length = 255)
    private String imagepath;
    @Size(max = 25)
    @Column(name = "f_firstname", length = 25)
    private String fFirstname;
    @Size(max = 25)
    @Column(name = "f_lastname", length = 25)
    private String fLastname;
    @Size(max = 25)
    @Column(name = "f_othernames", length = 25)
    private String fOthernames;
    @Size(max = 25)
    @Column(name = "m_firstname", length = 25)
    private String mFirstname;
    @Size(max = 25)
    @Column(name = "m_lastname", length = 25)
    private String mLastname;
    @Size(max = 25)
    @Column(name = "m_othernames", length = 25)
    private String mOthernames;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_patient", nullable = false)
    private boolean isPatient;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_staff", nullable = false)
    private boolean isStaff;
    @Basic(optional = false)
    @NotNull
    @Column(name = "personstate", nullable = false)
    private boolean personstate;
    @Column(name = "searchindex_patientstate")
    private Boolean searchindexPatientstate;
    @Size(max = 25)
    @Column(name = "g_firstname", length = 25)
    private String gFirstname;
    @Size(max = 25)
    @Column(name = "g_lastname", length = 25)
    private String gLastname;
    @Size(max = 25)
    @Column(name = "g_othernames", length = 25)
    private String gOthernames;
    @Size(max = 25)
    @Column(name = "currentaddressperiod", length = 25)
    private String currentaddressperiod;
    @Size(max = 25)
    @Column(name = "previousaddressperiod", length = 25)
    private String previousaddressperiod;
    @Size(max = 25)
    @Column(name = "lastaddressperiod", length = 25)
    private String lastaddressperiod;
    @Column(name = "contactstate")
    private Boolean contactstate;
    @Column(name = "ispatientstate")
    private Boolean ispatientstate;
    @Column(name = "isstaffstate")
    private Boolean isstaffstate;
    @Column(name = "fatheralive")
    private Boolean fatheralive;
    @Column(name = "motheralive")
    private Boolean motheralive;
    @Column(name = "noofchildren")
    private Integer noofchildren;
    @Size(max = 255)
    @Column(name = "signaturepath", length = 255)
    private String signaturepath;
    @Size(max = 255)
    @Column(name = "nin", length = 255)
    private String nin;
    @JoinColumn(name = "currentaddress", referencedColumnName = "villageid")
    @ManyToOne
    private Village currentaddress;
    @JoinColumn(name = "facilityid", referencedColumnName = "facilityid")
    @ManyToOne
    private Facility facilityid;
    @JoinColumn(name = "supplierid", referencedColumnName = "supplierid")
    @ManyToOne
    private Supplier supplier;
    @Column(name = "registrationpoint")
    private long registrationpoint;
    @Size(max = 255)
    @Column(name = "title")
    private String title;


    public Facility getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Facility facilityid) {
        this.facilityid = facilityid;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Village getCurrentaddress() {
        return currentaddress;
    }

    public void setCurrentaddress(Village currentaddress) {
        this.currentaddress = currentaddress;
    }

    public Person() {
    }

    public Person(Long personid) {
        this.personid = personid;
    }

    public Person(Long personid, String firstname, String lastname, boolean searchindexBiometricstate, boolean searchindexContactstate, boolean isPatient, boolean isStaff, boolean personstate) {
        this.personid = personid;
        this.firstname = firstname;
        this.lastname = lastname;
        this.searchindexBiometricstate = searchindexBiometricstate;
        this.searchindexContactstate = searchindexContactstate;
        this.isPatient = isPatient;
        this.isStaff = isStaff;
        this.personstate = personstate;
    }

    public Long getPersonid() {
        return personid;
    }

    public void setPersonid(Long personid) {
        this.personid = personid;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getOthernames() {
        return othernames;
    }

    public void setOthernames(String othernames) {
        this.othernames = othernames;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Integer getEstimatedage() {
        return estimatedage;
    }

    public void setEstimatedage(Integer estimatedage) {
        this.estimatedage = estimatedage;
    }

    public Date getDatecreated() {
        return datecreated;
    }

    public void setDatecreated(Date datecreated) {
        this.datecreated = datecreated;
    }

    public Date getDod() {
        return dod;
    }

    public void setDod(Date dod) {
        this.dod = dod;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Boolean getEstimated() {
        return estimated;
    }

    public void setEstimated(Boolean estimated) {
        this.estimated = estimated;
    }

    public String getWrittenlanguage() {
        return writtenlanguage;
    }

    public void setWrittenlanguage(String writtenlanguage) {
        this.writtenlanguage = writtenlanguage;
    }

    public String getTribe() {
        return tribe;
    }

    public void setTribe(String tribe) {
        this.tribe = tribe;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getMaritalstatus() {
        return maritalstatus;
    }

    public void setMaritalstatus(String maritalstatus) {
        this.maritalstatus = maritalstatus;
    }

    public Boolean getConsent() {
        return consent;
    }

    public void setConsent(Boolean consent) {
        this.consent = consent;
    }

    public Date getDateupdated() {
        return dateupdated;
    }

    public void setDateupdated(Date dateupdated) {
        this.dateupdated = dateupdated;
    }

    public String getFathersname() {
        return fathersname;
    }

    public void setFathersname(String fathersname) {
        this.fathersname = fathersname;
    }

    public String getMothersname() {
        return mothersname;
    }

    public void setMothersname(String mothersname) {
        this.mothersname = mothersname;
    }

    public boolean getSearchindexBiometricstate() {
        return searchindexBiometricstate;
    }

    public void setSearchindexBiometricstate(boolean searchindexBiometricstate) {
        this.searchindexBiometricstate = searchindexBiometricstate;
    }

    public boolean getSearchindexContactstate() {
        return searchindexContactstate;
    }

    public void setSearchindexContactstate(boolean searchindexContactstate) {
        this.searchindexContactstate = searchindexContactstate;
    }

    public Boolean getSearchindexNokstate() {
        return searchindexNokstate;
    }

    public void setSearchindexNokstate(Boolean searchindexNokstate) {
        this.searchindexNokstate = searchindexNokstate;
    }

    public Boolean getSearchindexBiometricsstate() {
        return searchindexBiometricsstate;
    }

    public void setSearchindexBiometricsstate(Boolean searchindexBiometricsstate) {
        this.searchindexBiometricsstate = searchindexBiometricsstate;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }

    public String getFFirstname() {
        return fFirstname;
    }

    public void setFFirstname(String fFirstname) {
        this.fFirstname = fFirstname;
    }

    public String getFLastname() {
        return fLastname;
    }

    public void setFLastname(String fLastname) {
        this.fLastname = fLastname;
    }

    public String getFOthernames() {
        return fOthernames;
    }

    public void setFOthernames(String fOthernames) {
        this.fOthernames = fOthernames;
    }

    public String getMFirstname() {
        return mFirstname;
    }

    public void setMFirstname(String mFirstname) {
        this.mFirstname = mFirstname;
    }

    public String getMLastname() {
        return mLastname;
    }

    public void setMLastname(String mLastname) {
        this.mLastname = mLastname;
    }

    public String getMOthernames() {
        return mOthernames;
    }

    public void setMOthernames(String mOthernames) {
        this.mOthernames = mOthernames;
    }

    public boolean getIsPatient() {
        return isPatient;
    }

    public void setIsPatient(boolean isPatient) {
        this.isPatient = isPatient;
    }

    public boolean getIsStaff() {
        return isStaff;
    }

    public void setIsStaff(boolean isStaff) {
        this.isStaff = isStaff;
    }

    public boolean getPersonstate() {
        return personstate;
    }

    public void setPersonstate(boolean personstate) {
        this.personstate = personstate;
    }

    public Boolean getSearchindexPatientstate() {
        return searchindexPatientstate;
    }

    public void setSearchindexPatientstate(Boolean searchindexPatientstate) {
        this.searchindexPatientstate = searchindexPatientstate;
    }

    public String getGFirstname() {
        return gFirstname;
    }

    public void setGFirstname(String gFirstname) {
        this.gFirstname = gFirstname;
    }

    public String getGLastname() {
        return gLastname;
    }

    public void setGLastname(String gLastname) {
        this.gLastname = gLastname;
    }

    public String getGOthernames() {
        return gOthernames;
    }

    public void setGOthernames(String gOthernames) {
        this.gOthernames = gOthernames;
    }

    public String getCurrentaddressperiod() {
        return currentaddressperiod;
    }

    public void setCurrentaddressperiod(String currentaddressperiod) {
        this.currentaddressperiod = currentaddressperiod;
    }

    public String getPreviousaddressperiod() {
        return previousaddressperiod;
    }

    public void setPreviousaddressperiod(String previousaddressperiod) {
        this.previousaddressperiod = previousaddressperiod;
    }

    public String getLastaddressperiod() {
        return lastaddressperiod;
    }

    public void setLastaddressperiod(String lastaddressperiod) {
        this.lastaddressperiod = lastaddressperiod;
    }

    public Boolean getContactstate() {
        return contactstate;
    }

    public void setContactstate(Boolean contactstate) {
        this.contactstate = contactstate;
    }

    public Boolean getIspatientstate() {
        return ispatientstate;
    }

    public void setIspatientstate(Boolean ispatientstate) {
        this.ispatientstate = ispatientstate;
    }

    public Boolean getIsstaffstate() {
        return isstaffstate;
    }

    public void setIsstaffstate(Boolean isstaffstate) {
        this.isstaffstate = isstaffstate;
    }

    public Boolean getFatheralive() {
        return fatheralive;
    }

    public void setFatheralive(Boolean fatheralive) {
        this.fatheralive = fatheralive;
    }

    public Boolean getMotheralive() {
        return motheralive;
    }

    public void setMotheralive(Boolean motheralive) {
        this.motheralive = motheralive;
    }

    public Integer getNoofchildren() {
        return noofchildren;
    }

    public void setNoofchildren(Integer noofchildren) {
        this.noofchildren = noofchildren;
    }

    public String getSignaturepath() {
        return signaturepath;
    }

    public void setSignaturepath(String signaturepath) {
        this.signaturepath = signaturepath;
    }

    public String getNin() {
        return nin;
    }

    public void setNin(String nin) {
        this.nin = nin;
    }
    public void setSpokenlanguageid(Integer spokenlanguageid) {
        this.spokenlanguageid = spokenlanguageid;
    }

    public Integer getSpokenlanguageid() {
        return spokenlanguageid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (personid != null ? personid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Person)) {
            return false;
        }
        Person other = (Person) object;
        if ((this.personid == null && other.personid != null) || (this.personid != null && !this.personid.equals(other.personid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Person[ personid=" + personid + " ]";
    }
    
    public long getRegistrationpoint() {
        return registrationpoint;
}

    public void setRegistrationpoint(long registrationpoint) {
        this.registrationpoint = registrationpoint;
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
