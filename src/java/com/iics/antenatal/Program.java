/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "program", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Program.findAll", query = "SELECT p FROM Program p")
    , @NamedQuery(name = "Program.findByProgramid", query = "SELECT p FROM Program p WHERE p.programid = :programid")
    , @NamedQuery(name = "Program.findByProgramname", query = "SELECT p FROM Program p WHERE p.programname = :programname")
    , @NamedQuery(name = "Program.findByActive", query = "SELECT p FROM Program p WHERE p.active = :active")
    , @NamedQuery(name = "Program.findByProgramkey", query = "SELECT p FROM Program p WHERE p.programkey = :programkey")})
public class Program implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "FacilityProgramSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "FacilityProgramSeq", sequenceName = "FacilityProgram_programid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "programid", nullable = false)
    private Long programid;
    @Basic(optional = false)
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "programname", length = 2147483647)
    private String programname;
    @Column(name = "programkey", length = 2147483647)
    private String programkey;

    public Program() {
    }

    public Program(Long programid) {
        this.programid = programid;
    }

    public Long getProgramid() {
        return programid;
    }

    public void setProgramid(Long programid) {
        this.programid = programid;
    }

    public String getProgramname() {
        return programname;
    }

    public void setProgramname(String programname) {
        this.programname = programname;
    }

    public String getProgramkey() {
        return programkey;
    }

    public void setProgramkey(String programkey) {
        this.programkey = programkey;
    }
     public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (programid != null ? programid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Program)) {
            return false;
        }
        Program other = (Program) object;
        if ((this.programid == null && other.programid != null) || (this.programid != null && !this.programid.equals(other.programid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Program[ programid=" + programid + " ]";
    }
    
}
