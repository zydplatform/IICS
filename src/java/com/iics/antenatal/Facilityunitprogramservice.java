/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "facilityunitprogramservice", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityunitprogramservice.findAll", query = "SELECT f FROM Facilityunitprogramservice f")
    , @NamedQuery(name = "Facilityunitprogramservice.findByUnitprogramserviceid", query = "SELECT f FROM Facilityunitprogramservice f WHERE f.unitprogramserviceid = :unitprogramserviceid")
    , @NamedQuery(name = "Facilityunitprogramservice.findByFacilityunitid", query = "SELECT f FROM Facilityunitprogramservice f WHERE f.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Facilityunitprogramservice.findByFacilityid", query = "SELECT f FROM Facilityunitprogramservice f WHERE f.facilityid = :facilityid")
    , @NamedQuery(name = "Facilityunitprogramservice.findByServiceid", query = "SELECT f FROM Facilityunitprogramservice f WHERE f.serviceid = :serviceid")})
public class Facilityunitprogramservice implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "unitprogramserviceid", nullable = false)
    private Long unitprogramserviceid;
    @Column(name = "facilityunitid")
    private Long facilityunitid;
    @Column(name = "facilityid")
    private Long facilityid;
    @Column(name = "serviceid")
    private Long serviceid;
    @JoinColumn(name = "programid", referencedColumnName = "programid")
    @ManyToOne
    private Program program;

    public Facilityunitprogramservice() {
    }

    public Facilityunitprogramservice(Long unitprogramserviceid) {
        this.unitprogramserviceid = unitprogramserviceid;
    }

    public Long getUnitprogramserviceid() {
        return unitprogramserviceid;
    }

    public void setUnitprogramserviceid(Long unitprogramserviceid) {
        this.unitprogramserviceid = unitprogramserviceid;
    }

    public Long getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(Long facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public Long getFacilityid() {
        return facilityid;
    }

    public void setFacilityid(Long facilityid) {
        this.facilityid = facilityid;
    }

    public Long getServiceid() {
        return serviceid;
    }

    public void setServiceid(Long serviceid) {
        this.serviceid = serviceid;
    }

    public Program getProgram() {
        return program;
    }

    public void setProgram(Program program) {
        this.program = program;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (unitprogramserviceid != null ? unitprogramserviceid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityunitprogramservice)) {
            return false;
        }
        Facilityunitprogramservice other = (Facilityunitprogramservice) object;
        if ((this.unitprogramserviceid == null && other.unitprogramserviceid != null) || (this.unitprogramserviceid != null && !this.unitprogramserviceid.equals(other.unitprogramserviceid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Facilityunitprogramservice[ unitprogramserviceid=" + unitprogramserviceid + " ]";
    }
    
}
