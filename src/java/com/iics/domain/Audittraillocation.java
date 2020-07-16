/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import java.math.BigInteger;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "audittraillocation", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Audittraillocation.findAll", query = "SELECT a FROM Audittraillocation a")
    , @NamedQuery(name = "Audittraillocation.findByAudit", query = "SELECT a FROM Audittraillocation a WHERE a.audit = :audit")
    , @NamedQuery(name = "Audittraillocation.findByTimein", query = "SELECT a FROM Audittraillocation a WHERE a.timein = :timein")
    , @NamedQuery(name = "Audittraillocation.findByCategory", query = "SELECT a FROM Audittraillocation a WHERE a.category = :category")
    , @NamedQuery(name = "Audittraillocation.findByActivity", query = "SELECT a FROM Audittraillocation a WHERE a.activity = :activity")
    , @NamedQuery(name = "Audittraillocation.findByDescription", query = "SELECT a FROM Audittraillocation a WHERE a.description = :description")
    , @NamedQuery(name = "Audittraillocation.findByPrevregion", query = "SELECT a FROM Audittraillocation a WHERE a.prevregion = :prevregion")
    , @NamedQuery(name = "Audittraillocation.findByPrevdistrict", query = "SELECT a FROM Audittraillocation a WHERE a.prevdistrict = :prevdistrict")
    , @NamedQuery(name = "Audittraillocation.findByPrevcounty", query = "SELECT a FROM Audittraillocation a WHERE a.prevcounty = :prevcounty")
    , @NamedQuery(name = "Audittraillocation.findByPrevsubcounty", query = "SELECT a FROM Audittraillocation a WHERE a.prevsubcounty = :prevsubcounty")
    , @NamedQuery(name = "Audittraillocation.findByPrevparish", query = "SELECT a FROM Audittraillocation a WHERE a.prevparish = :prevparish")
    , @NamedQuery(name = "Audittraillocation.findByPrevvillage", query = "SELECT a FROM Audittraillocation a WHERE a.prevvillage = :prevvillage")
    , @NamedQuery(name = "Audittraillocation.findByCurlocationid", query = "SELECT a FROM Audittraillocation a WHERE a.curlocationid = :curlocationid")
    , @NamedQuery(name = "Audittraillocation.findByDbaction", query = "SELECT a FROM Audittraillocation a WHERE a.dbaction = :dbaction")
    , @NamedQuery(name = "Audittraillocation.findByAttrvalue", query = "SELECT a FROM Audittraillocation a WHERE a.attrvalue = :attrvalue")
    , @NamedQuery(name = "Audittraillocation.findByCurcounty", query = "SELECT a FROM Audittraillocation a WHERE a.curcounty = :curcounty")
    , @NamedQuery(name = "Audittraillocation.findByCurdistrict", query = "SELECT a FROM Audittraillocation a WHERE a.curdistrict = :curdistrict")
    , @NamedQuery(name = "Audittraillocation.findByCurparish", query = "SELECT a FROM Audittraillocation a WHERE a.curparish = :curparish")
    , @NamedQuery(name = "Audittraillocation.findByCurregion", query = "SELECT a FROM Audittraillocation a WHERE a.curregion = :curregion")
    , @NamedQuery(name = "Audittraillocation.findByCursubcounty", query = "SELECT a FROM Audittraillocation a WHERE a.cursubcounty = :cursubcounty")
    , @NamedQuery(name = "Audittraillocation.findByCurvillage", query = "SELECT a FROM Audittraillocation a WHERE a.curvillage = :curvillage")
    , @NamedQuery(name = "Audittraillocation.findByPrevlocationid", query = "SELECT a FROM Audittraillocation a WHERE a.prevlocationid = :prevlocationid")
    , @NamedQuery(name = "Audittraillocation.findByTransferactivity", query = "SELECT a FROM Audittraillocation a WHERE a.transferactivity = :transferactivity")
    , @NamedQuery(name = "Audittraillocation.findByAdministered", query = "SELECT a FROM Audittraillocation a WHERE a.administered = :administered")
    , @NamedQuery(name = "Audittraillocation.findByRefid", query = "SELECT a FROM Audittraillocation a WHERE a.refid = :refid")
    , @NamedQuery(name = "Audittraillocation.findByReflevel", query = "SELECT a FROM Audittraillocation a WHERE a.reflevel = :reflevel")
    , @NamedQuery(name = "Audittraillocation.findByObjectid", query = "SELECT a FROM Audittraillocation a WHERE a.objectid = :objectid")})
public class Audittraillocation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "AuditTrail_LocationSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "AuditTrail_LocationSeq", sequenceName = "AuditTrail_Locationid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "audit", nullable = false)
    private Long audit;
    @Basic(optional = false)
    @Column(name = "timein", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date timein;
    @Basic(optional = false)
//    @Column(name = "changeby", nullable = false)
//    private long changeby;
    @JoinColumn(name = "changeby", referencedColumnName = "personid")
    @ManyToOne
    private Person person;
    @Basic(optional = false)
    @Column(name = "category", nullable = false, length = 2147483647)
    private String category;
    @Basic(optional = false)
    @Column(name = "activity", nullable = false, length = 2147483647)
    private String activity;
    @Basic(optional = false)
    @Column(name = "description", nullable = false, length = 2147483647)
    private String description;
    @Column(name = "prevregion", length = 2147483647)
    private String prevregion;
    @Column(name = "prevdistrict", length = 2147483647)
    private String prevdistrict;
    @Column(name = "prevcounty", length = 2147483647)
    private String prevcounty;
    @Column(name = "prevsubcounty", length = 2147483647)
    private String prevsubcounty;
    @Column(name = "prevparish", length = 2147483647)
    private String prevparish;
    @Column(name = "prevvillage", length = 2147483647)
    private String prevvillage;
    @Column(name = "curlocationid")
    private Integer curlocationid;
    @Basic(optional = false)
    @Column(name = "dbaction", nullable = false, length = 2147483647)
    private String dbaction;
    @Basic(optional = false)
    @Column(name = "attrvalue", nullable = false, length = 2147483647)
    private String attrvalue;
    @Column(name = "curcounty", length = 255)
    private String curcounty;
    @Column(name = "curdistrict", length = 255)
    private String curdistrict;
    @Column(name = "curparish", length = 255)
    private String curparish;
    @Column(name = "curregion", length = 255)
    private String curregion;
    @Column(name = "cursubcounty", length = 255)
    private String cursubcounty;
    @Column(name = "curvillage", length = 255)
    private String curvillage;
    @Column(name = "prevlocationid")
    private Integer prevlocationid;
    @Column(name = "transferactivity", length = 255)
    private String transferactivity;
    @Basic(optional = false)
    @Column(name = "administered", nullable = false)
    private boolean administered;
    @Column(name = "refid")
    private BigInteger refid;
    @Column(name = "reflevel")
    private Integer reflevel;
    @Column(name = "objectid")
    private BigInteger objectid;

    public Audittraillocation() {
    }

    public Audittraillocation(Long audit) {
        this.audit = audit;
    }

    public Audittraillocation(Long audit, Date timein, long changeby, String category, String activity, String description, String dbaction, String attrvalue, boolean administered) {
        this.audit = audit;
        this.timein = timein;
        this.category = category;
        this.activity = activity;
        this.description = description;
        this.dbaction = dbaction;
        this.attrvalue = attrvalue;
        this.administered = administered;
    }

    public Long getAudit() {
        return audit;
    }

    public void setAudit(Long audit) {
        this.audit = audit;
    }

    public Date getTimein() {
        return timein;
    }

    public void setTimein(Date timein) {
        this.timein = timein;
    }

//    public long getChangeby() {
//        return changeby;
//    }
//
//    public void setChangeby(long changeby) {
//        this.changeby = changeby;
//    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrevregion() {
        return prevregion;
    }

    public void setPrevregion(String prevregion) {
        this.prevregion = prevregion;
    }

    public String getPrevdistrict() {
        return prevdistrict;
    }

    public void setPrevdistrict(String prevdistrict) {
        this.prevdistrict = prevdistrict;
    }

    public String getPrevcounty() {
        return prevcounty;
    }

    public void setPrevcounty(String prevcounty) {
        this.prevcounty = prevcounty;
    }

    public String getPrevsubcounty() {
        return prevsubcounty;
    }

    public void setPrevsubcounty(String prevsubcounty) {
        this.prevsubcounty = prevsubcounty;
    }

    public String getPrevparish() {
        return prevparish;
    }

    public void setPrevparish(String prevparish) {
        this.prevparish = prevparish;
    }

    public String getPrevvillage() {
        return prevvillage;
    }

    public void setPrevvillage(String prevvillage) {
        this.prevvillage = prevvillage;
    }

    public Integer getCurlocationid() {
        return curlocationid;
    }

    public void setCurlocationid(Integer curlocationid) {
        this.curlocationid = curlocationid;
    }

    public String getDbaction() {
        return dbaction;
    }

    public void setDbaction(String dbaction) {
        this.dbaction = dbaction;
    }

    public String getAttrvalue() {
        return attrvalue;
    }

    public void setAttrvalue(String attrvalue) {
        this.attrvalue = attrvalue;
    }

    public String getCurcounty() {
        return curcounty;
    }

    public void setCurcounty(String curcounty) {
        this.curcounty = curcounty;
    }

    public String getCurdistrict() {
        return curdistrict;
    }

    public void setCurdistrict(String curdistrict) {
        this.curdistrict = curdistrict;
    }

    public String getCurparish() {
        return curparish;
    }

    public void setCurparish(String curparish) {
        this.curparish = curparish;
    }

    public String getCurregion() {
        return curregion;
    }

    public void setCurregion(String curregion) {
        this.curregion = curregion;
    }

    public String getCursubcounty() {
        return cursubcounty;
    }

    public void setCursubcounty(String cursubcounty) {
        this.cursubcounty = cursubcounty;
    }

    public String getCurvillage() {
        return curvillage;
    }

    public void setCurvillage(String curvillage) {
        this.curvillage = curvillage;
    }

    public Integer getPrevlocationid() {
        return prevlocationid;
    }

    public void setPrevlocationid(Integer prevlocationid) {
        this.prevlocationid = prevlocationid;
    }

    public String getTransferactivity() {
        return transferactivity;
    }

    public void setTransferactivity(String transferactivity) {
        this.transferactivity = transferactivity;
    }

    public boolean getAdministered() {
        return administered;
    }

    public void setAdministered(boolean administered) {
        this.administered = administered;
    }

    public BigInteger getRefid() {
        return refid;
    }

    public void setRefid(BigInteger refid) {
        this.refid = refid;
    }

    public Integer getReflevel() {
        return reflevel;
    }

    public void setReflevel(Integer reflevel) {
        this.reflevel = reflevel;
    }

    public BigInteger getObjectid() {
        return objectid;
    }

    public void setObjectid(BigInteger objectid) {
        this.objectid = objectid;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (audit != null ? audit.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Audittraillocation)) {
            return false;
        }
        Audittraillocation other = (Audittraillocation) object;
        if ((this.audit == null && other.audit != null) || (this.audit != null && !this.audit.equals(other.audit))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Audittraillocation[ audit=" + audit + " ]";
    }
    
}
