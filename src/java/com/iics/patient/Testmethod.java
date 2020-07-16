/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

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
 * @author HP
 */
@Entity
@Table(name = "testmethod", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Testmethod.findAll", query = "SELECT t FROM Testmethod t")
    , @NamedQuery(name = "Testmethod.findByTestmethodid", query = "SELECT t FROM Testmethod t WHERE t.testmethodid = :testmethodid")
    , @NamedQuery(name = "Testmethod.findByTestmethodname", query = "SELECT t FROM Testmethod t WHERE t.testmethodname = :testmethodname")
    , @NamedQuery(name = "Testmethod.findByIsactive", query = "SELECT t FROM Testmethod t WHERE t.isactive = :isactive")})
public class Testmethod implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "testmethodid", nullable = false)
    private Long testmethodid;
    @Size(max = 255)
    @Column(name = "testmethodname", length = 255)
    private String testmethodname;
    @Column(name = "isactive")
    private Boolean isactive;

    public Testmethod() {
    }

    public Testmethod(Long testmethodid) {
        this.testmethodid = testmethodid;
    }

    public Long getTestmethodid() {
        return testmethodid;
    }

    public void setTestmethodid(Long testmethodid) {
        this.testmethodid = testmethodid;
    }

    public String getTestmethodname() {
        return testmethodname;
    }

    public void setTestmethodname(String testmethodname) {
        this.testmethodname = testmethodname;
    }

    public Boolean getIsactive() {
        return isactive;
    }

    public void setIsactive(Boolean isactive) {
        this.isactive = isactive;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (testmethodid != null ? testmethodid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Testmethod)) {
            return false;
        }
        Testmethod other = (Testmethod) object;
        if ((this.testmethodid == null && other.testmethodid != null) || (this.testmethodid != null && !this.testmethodid.equals(other.testmethodid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Testmethod[ testmethodid=" + testmethodid + " ]";
    }
    
}
