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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "antenantalvisitcondition ", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Antenantalvisitcondition.findAll", query = "SELECT a FROM Antenantalvisitcondition a")
    , @NamedQuery(name = "Antenantalvisitcondition.findByAntenantalvisitconditionid", query = "SELECT a FROM Antenantalvisitcondition a WHERE a.antenantalvisitconditionid = :antenantalvisitconditionid")
    , @NamedQuery(name = "Antenantalvisitcondition.findByObservation", query = "SELECT a FROM Antenantalvisitcondition a WHERE a.observation = :observation")})
public class Antenantalvisitcondition implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "antenantalvisitconditionid", nullable = false)
    private Integer antenantalvisitconditionid;
    @Column(name = "observation", length = 2147483647)
    private String observation;
    @JoinColumn(name = "antenatalvisitid", referencedColumnName = "antenatalvisitid")
    @ManyToOne
    private Antenatalvisit antenatalvisitid;
    @JoinColumn(name = "conditionid", referencedColumnName = "conditionid")
    @ManyToOne
    private Condition conditionid;

    public Antenantalvisitcondition() {
    }

    public Antenantalvisitcondition(Integer antenantalvisitconditionid) {
        this.antenantalvisitconditionid = antenantalvisitconditionid;
    }

    public Integer getAntenantalvisitconditionid() {
        return antenantalvisitconditionid;
    }

    public void setAntenantalvisitconditionid(Integer antenantalvisitconditionid) {
        this.antenantalvisitconditionid = antenantalvisitconditionid;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Antenatalvisit getAntenatalvisitid() {
        return antenatalvisitid;
    }

    public void setAntenatalvisitid(Antenatalvisit antenatalvisitid) {
        this.antenatalvisitid = antenatalvisitid;
    }

    public Condition getConditionid() {
        return conditionid;
    }

    public void setConditionid(Condition conditionid) {
        this.conditionid = conditionid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (antenantalvisitconditionid != null ? antenantalvisitconditionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Antenantalvisitcondition)) {
            return false;
        }
        Antenantalvisitcondition other = (Antenantalvisitcondition) object;
        if ((this.antenantalvisitconditionid == null && other.antenantalvisitconditionid != null) || (this.antenantalvisitconditionid != null && !this.antenantalvisitconditionid.equals(other.antenantalvisitconditionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Antenantalvisitcondition[ antenantalvisitconditionid=" + antenantalvisitconditionid + " ]";
    }
    
}
