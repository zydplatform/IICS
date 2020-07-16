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
 * @author IICSRemote
 */
@Entity
@Table(name = "queuetype", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Queuetype.findAll", query = "SELECT q FROM Queuetype q")
    , @NamedQuery(name = "Queuetype.findByQueuetypeid", query = "SELECT q FROM Queuetype q WHERE q.queuetypeid = :queuetypeid")
    , @NamedQuery(name = "Queuetype.findByName", query = "SELECT q FROM Queuetype q WHERE q.name = :name")
    , @NamedQuery(name = "Queuetype.findByQueuestatus", query = "SELECT q FROM Queuetype q WHERE q.queuestatus = :queuestatus")
    , @NamedQuery(name = "Queuetype.findByDescription", query = "SELECT q FROM Queuetype q WHERE q.description = :description")
    , @NamedQuery(name = "Queuetype.findByWeight", query = "SELECT q FROM Queuetype q WHERE q.weight = :weight")})
public class Queuetype implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id

    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "queuetypeid", nullable = false)
    private Long queuetypeid;
    @Size(max = 30)
    @Column(name = "name", length = 30)
    private String name;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Column(name = "weight")
    private Integer weight;
    @Column(name = "queuestatus")
    private Boolean queuestatus;

    public Queuetype() {
    }

    public Queuetype(Long queuetypeid) {
        this.queuetypeid = queuetypeid;
    }

    public Long getQueuetypeid() {
        return queuetypeid;
    }

    public void setQueuetypeid(Long queuetypeid) {
        this.queuetypeid = queuetypeid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public Boolean getQueuestatus() {
        return queuestatus;
    }

    public void setQueuestatus(Boolean queuestatus) {
        this.queuestatus = queuestatus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (queuetypeid != null ? queuetypeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Queuetype)) {
            return false;
        }
        Queuetype other = (Queuetype) object;
        if ((this.queuetypeid == null && other.queuetypeid != null) || (this.queuetypeid != null && !this.queuetypeid.equals(other.queuetypeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Queuetype[ queuetypeid=" + queuetypeid + " ]";
    }
}
