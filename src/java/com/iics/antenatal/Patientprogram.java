/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
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
@Table(name = "patientprogram", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patientprogram.findAll", query = "SELECT p FROM Patientprogram p")
    , @NamedQuery(name = "Patientprogram.findByPatientprogramid", query = "SELECT p FROM Patientprogram p WHERE p.patientprogramid = :patientprogramid")
    , @NamedQuery(name = "Patientprogram.findByProgramid", query = "SELECT p FROM Patientprogram p WHERE p.programid = :programid")
    , @NamedQuery(name = "Patientprogram.findByStartdate", query = "SELECT p FROM Patientprogram p WHERE p.startdate = :startdate")
    , @NamedQuery(name = "Patientprogram.findByDateclosed", query = "SELECT p FROM Patientprogram p WHERE p.dateclosed = :dateclosed")
    , @NamedQuery(name = "Patientprogram.findByStatus", query = "SELECT p FROM Patientprogram p WHERE p.status = :status")})
public class Patientprogram implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "PatientProgramSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "PatientProgramSeq", sequenceName = "PatientProgram_patientprogramid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "patientprogramid", nullable = false)
    private Long patientprogramid;
    @Column(name = "programid")
    private Long programid;
    @Column(name = "patientvisitid")
    private Long patientvisitid;
    @Column(name = "startdate")
    @Temporal(TemporalType.DATE)
    private Date startdate;
    @Column(name = "dateclosed")
    @Temporal(TemporalType.DATE)
    private Date dateclosed;
    @Column(name = "status", length = 2147483647)
    private String status;
    @Column(name = "timein")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timein;
    @Column(name = "timeout")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeout;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "patientprogram")
    private Antenatalvisit antenatalvisit;

    public Patientprogram() {
    }

    public Patientprogram(Long patientprogramid) {
        this.patientprogramid = patientprogramid;
    }

    public Long getPatientprogramid() {
        return patientprogramid;
    }

    public void setPatientprogramid(Long patientprogramid) {
        this.patientprogramid = patientprogramid;
    }

    public Long getProgramid() {
        return programid;
    }

    public void setProgramid(Long programid) {
        this.programid = programid;
    }

    public Long getPatientvisitid() {
        return patientvisitid;
    }

    public void setPatientvisitid(Long patientvisitid) {
        this.patientvisitid = patientvisitid;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getDateclosed() {
        return dateclosed;
    }
    
    public void setDateclosed(Date dateclosed) {
        this.dateclosed = dateclosed;
    }

    public Date getTimein() {
        return timein;
    }

    public void setTimein(Date timein) {
        this.timein = timein;
    }

    public Date getTimeout() {
        return timeout;
    }

    public void setTimeout(Date timeout) {
        this.timeout = timeout;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Antenatalvisit getAntenatalvisit() {
        return antenatalvisit;
    }

    public void setAntenatalvisit(Antenatalvisit antenatalvisit) {
        this.antenatalvisit = antenatalvisit;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (patientprogramid != null ? patientprogramid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Patientprogram)) {
            return false;
        }
        Patientprogram other = (Patientprogram) object;
        if ((this.patientprogramid == null && other.patientprogramid != null) || (this.patientprogramid != null && !this.patientprogramid.equals(other.patientprogramid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Patientprogram[ patientprogramid=" + patientprogramid + " ]";
    }
    
}
