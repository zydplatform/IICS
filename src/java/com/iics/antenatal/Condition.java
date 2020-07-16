/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "condition", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Condition.findAll", query = "SELECT c FROM Condition c")
    , @NamedQuery(name = "Condition.findByConditionid", query = "SELECT c FROM Condition c WHERE c.conditionid = :conditionid")
    , @NamedQuery(name = "Condition.findByConditionname", query = "SELECT c FROM Condition c WHERE c.conditionname = :conditionname")
    , @NamedQuery(name = "Condition.findByConditontype", query = "SELECT c FROM Condition c WHERE c.conditontype = :conditontype")})
public class Condition implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(generator = "ConditionSeq", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "ConditionSeq", sequenceName = "ConditionSeq_conditionid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "conditionid", nullable = false)
    private Integer conditionid;
    @Column(name = "conditionname", length = 2147483647)
    private String conditionname;
    @Column(name = "conditontype", length = 2147483647)
    private String conditontype;
    @OneToMany(mappedBy = "conditionid")
    private List<Antenantalvisitcondition> antenantalvisitconditionList;

    public Condition() {
    }

    public Condition(Integer conditionid) {
        this.conditionid = conditionid;
    }

    public Integer getConditionid() {
        return conditionid;
    }

    public void setConditionid(Integer conditionid) {
        this.conditionid = conditionid;
    }

    public String getConditionname() {
        return conditionname;
    }

    public void setConditionname(String conditionname) {
        this.conditionname = conditionname;
    }

    public String getConditontype() {
        return conditontype;
    }

    public void setConditontype(String conditontype) {
        this.conditontype = conditontype;
    }

    @XmlTransient
    public List<Antenantalvisitcondition> getAntenantalvisitconditionList() {
        return antenantalvisitconditionList;
    }

    public void setAntenantalvisitconditionList(List<Antenantalvisitcondition> antenantalvisitconditionList) {
        this.antenantalvisitconditionList = antenantalvisitconditionList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (conditionid != null ? conditionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Condition)) {
            return false;
        }
        Condition other = (Condition) object;
        if ((this.conditionid == null && other.conditionid != null) || (this.conditionid != null && !this.conditionid.equals(other.conditionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Condition[ conditionid=" + conditionid + " ]";
    }
    
}
