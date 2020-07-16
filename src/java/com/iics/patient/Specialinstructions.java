/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
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
 * @author IICS
 */
@Entity
@Table(name = "specialinstructions", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Specialinstructions.findAll", query = "SELECT s FROM Specialinstructions s")
    , @NamedQuery(name = "Specialinstructions.findBySpecialinstructionsid", query = "SELECT s FROM Specialinstructions s WHERE s.specialinstructionsid = :specialinstructionsid")
    , @NamedQuery(name = "Specialinstructions.findBySpecialinstruction", query = "SELECT s FROM Specialinstructions s WHERE s.specialinstruction = :specialinstruction")
    , @NamedQuery(name = "Specialinstructions.findByAddedby", query = "SELECT s FROM Specialinstructions s WHERE s.addedby = :addedby")
    , @NamedQuery(name = "Specialinstructions.findByDateadded", query = "SELECT s FROM Specialinstructions s WHERE s.dateadded = :dateadded")})
public class Specialinstructions implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "specialinstructionsid")
    private Long specialinstructionsid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "specialinstruction")
    private String specialinstruction;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addedby")
    private long addedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;

    public Specialinstructions() {
    }

    public Specialinstructions(Long specialinstructionsid) {
        this.specialinstructionsid = specialinstructionsid;
    }

    public Specialinstructions(Long specialinstructionsid, String specialinstruction, long addedby, Date dateadded) {
        this.specialinstructionsid = specialinstructionsid;
        this.specialinstruction = specialinstruction;
        this.addedby = addedby;
        this.dateadded = dateadded;
    }

    public Long getSpecialinstructionsid() {
        return specialinstructionsid;
    }

    public void setSpecialinstructionsid(Long specialinstructionsid) {
        this.specialinstructionsid = specialinstructionsid;
    }

    public String getSpecialinstruction() {
        return specialinstruction;
    }

    public void setSpecialinstruction(String specialinstruction) {
        this.specialinstruction = specialinstruction;
    }

    public long getAddedby() {
        return addedby;
    }

    public void setAddedby(long addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (specialinstructionsid != null ? specialinstructionsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Specialinstructions)) {
            return false;
        }
        Specialinstructions other = (Specialinstructions) object;
        if ((this.specialinstructionsid == null && other.specialinstructionsid != null) || (this.specialinstructionsid != null && !this.specialinstructionsid.equals(other.specialinstructionsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Specialinstructions[ specialinstructionsid=" + specialinstructionsid + " ]";
    }
    
}
