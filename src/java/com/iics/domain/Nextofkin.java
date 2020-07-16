/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Grace-K
 */
@Entity
@Table(name = "nextofkin", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Nextofkin.findAll", query = "SELECT n FROM Nextofkin n")
    , @NamedQuery(name = "Nextofkin.findByNextofkinid", query = "SELECT n FROM Nextofkin n WHERE n.nextofkinid = :nextofkinid")
    , @NamedQuery(name = "Nextofkin.findByFullname", query = "SELECT n FROM Nextofkin n WHERE n.fullname = :fullname")
    , @NamedQuery(name = "Nextofkin.findByPhonecontact", query = "SELECT n FROM Nextofkin n WHERE n.phonecontact = :phonecontact")
    , @NamedQuery(name = "Nextofkin.findByRelationship", query = "SELECT n FROM Nextofkin n WHERE n.relationship = :relationship")
    , @NamedQuery(name = "Nextofkin.findByIndex", query = "SELECT n FROM Nextofkin n WHERE n.index = :index")
    , @NamedQuery(name = "Nextofkin.findByLocalcouncil", query = "SELECT n FROM Nextofkin n WHERE n.localcouncil = :localcouncil")})
public class Nextofkin implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "nextofkinid", nullable = false)
    private Long nextofkinid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "fullname", nullable = false, length = 2147483647)
    private String fullname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "phonecontact", nullable = false, length = 2147483647)
    private String phonecontact;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "relationship", nullable = false, length = 2147483647)
    private String relationship;
    @Column(name = "index")
    private Integer index;
    @Size(max = 255)
    @Column(name = "localcouncil", length = 255)
    private String localcouncil;
    @Column(name = "personid")
    private long personid;

    public Nextofkin() {
    }

    public Nextofkin(Long nextofkinid) {
        this.nextofkinid = nextofkinid;
    }

    public Nextofkin(Long nextofkinid, String fullname, String phonecontact, String relationship) {
        this.nextofkinid = nextofkinid;
        this.fullname = fullname;
        this.phonecontact = phonecontact;
        this.relationship = relationship;
    }

    public Long getNextofkinid() {
        return nextofkinid;
    }

    public void setNextofkinid(Long nextofkinid) {
        this.nextofkinid = nextofkinid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhonecontact() {
        return phonecontact;
    }

    public void setPhonecontact(String phonecontact) {
        this.phonecontact = phonecontact;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    public String getLocalcouncil() {
        return localcouncil;
    }

    public void setLocalcouncil(String localcouncil) {
        this.localcouncil = localcouncil;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nextofkinid != null ? nextofkinid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Nextofkin)) {
            return false;
        }
        Nextofkin other = (Nextofkin) object;
        if ((this.nextofkinid == null && other.nextofkinid != null) || (this.nextofkinid != null && !this.nextofkinid.equals(other.nextofkinid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Nextofkin[ nextofkinid=" + nextofkinid + " ]";
    }

    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    
}
