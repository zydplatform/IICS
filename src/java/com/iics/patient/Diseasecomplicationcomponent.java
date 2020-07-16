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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS-GRACE
 */
@Entity
@Table(name = "diseasecomplicationcomponent", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diseasecomplicationcomponent.findAll", query = "SELECT d FROM Diseasecomplicationcomponent d")
    , @NamedQuery(name = "Diseasecomplicationcomponent.findByDiseasecomplicationcomponentid", query = "SELECT d FROM Diseasecomplicationcomponent d WHERE d.diseasecomplicationcomponentid = :diseasecomplicationcomponentid")})
public class Diseasecomplicationcomponent implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "diseasecomplicationcomponentid", nullable = false)
    private Long diseasecomplicationcomponentid;
    @Column(name = "diseaseid")
    private Long diseaseid;
    @Column(name = "complicationcomponentid")
    private Long complicationcomponentid;
    @Column(name = "componentdescription")
    private String componentdescription;

    public Diseasecomplicationcomponent() {
    }

    public Diseasecomplicationcomponent(Long diseasecomplicationcomponentid) {
        this.diseasecomplicationcomponentid = diseasecomplicationcomponentid;
    }

    public Long getDiseasecomplicationcomponentid() {
        return diseasecomplicationcomponentid;
    }

    public void setDiseasecomplicationcomponentid(Long diseasecomplicationcomponentid) {
        this.diseasecomplicationcomponentid = diseasecomplicationcomponentid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (diseasecomplicationcomponentid != null ? diseasecomplicationcomponentid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Diseasecomplicationcomponent)) {
            return false;
        }
        Diseasecomplicationcomponent other = (Diseasecomplicationcomponent) object;
        if ((this.diseasecomplicationcomponentid == null && other.diseasecomplicationcomponentid != null) || (this.diseasecomplicationcomponentid != null && !this.diseasecomplicationcomponentid.equals(other.diseasecomplicationcomponentid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Diseasecomplicationcomponent[ diseasecomplicationcomponentid=" + diseasecomplicationcomponentid + " ]";
    }

    public Long getDiseaseid() {
        return diseaseid;
    }

    public void setDiseaseid(Long diseaseid) {
        this.diseaseid = diseaseid;
    }

    public Long getComplicationcomponentid() {
        return complicationcomponentid;
    }

    public void setComplicationcomponentid(Long complicationcomponentid) {
        this.complicationcomponentid = complicationcomponentid;
    }

    public String getComponentdescription() {
        return componentdescription;
    }

    public void setComponentdescription(String componentdescription) {
        this.componentdescription = componentdescription;
    }

}
