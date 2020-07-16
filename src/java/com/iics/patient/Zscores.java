/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.patient;

import java.io.Serializable;
import java.math.BigInteger;
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
 * @author user
 */
@Entity
@Table(name = "zscores", catalog = "iics_database", schema = "patient")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Zscores.findAll", query = "SELECT z FROM Zscores z")
    , @NamedQuery(name = "Zscores.findByZscoresid", query = "SELECT z FROM Zscores z WHERE z.zscoresid = :zscoresid")
    , @NamedQuery(name = "Zscores.findByWeightforage", query = "SELECT z FROM Zscores z WHERE z.weightforage = :weightforage")
    , @NamedQuery(name = "Zscores.findByHeightforage", query = "SELECT z FROM Zscores z WHERE z.heightforage = :heightforage")
    , @NamedQuery(name = "Zscores.findByWeightforheight", query = "SELECT z FROM Zscores z WHERE z.weightforheight = :weightforheight")
    , @NamedQuery(name = "Zscores.findByBmi", query = "SELECT z FROM Zscores z WHERE z.bmi = :bmi")
    , @NamedQuery(name = "Zscores.findByTriageid", query = "SELECT z FROM Zscores z WHERE z.triageid = :triageid")})
public class Zscores implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @NotNull
    @Column(name = "zscoresid", nullable = false)
    private Long zscoresid;
    @Size(max = 255)
    @Column(name = "weightforage", length = 255)
    private String weightforage;
    @Size(max = 255)
    @Column(name = "heightforage", length = 255)
    private String heightforage;
    @Size(max = 255)
    @Column(name = "weightforheight", length = 255)
    private String weightforheight;
    @Size(max = 255)
    @Column(name = "bmi", length = 255)
    private String bmi;
    @Column(name = "triageid")
    private Long triageid;

    public Zscores() {
    }

    public Zscores(Long zscoresid) {
        this.zscoresid = zscoresid;
    }

    public Long getZscoresid() {
        return zscoresid;
    }

    public void setZscoresid(Long zscoresid) {
        this.zscoresid = zscoresid;
    }

    public String getWeightforage() {
        return weightforage;
    }

    public void setWeightforage(String weightforage) {
        this.weightforage = weightforage;
    }

    public String getHeightforage() {
        return heightforage;
    }

    public void setHeightforage(String heightforage) {
        this.heightforage = heightforage;
    }

    public String getWeightforheight() {
        return weightforheight;
    }

    public void setWeightforheight(String weightforheight) {
        this.weightforheight = weightforheight;
    }

    public String getBmi() {
        return bmi;
    }

    public void setBmi(String bmi) {
        this.bmi = bmi;
    }

    public Long getTriageid() {
        return triageid;
    }

    public void setTriageid(Long triageid) {
        this.triageid = triageid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (zscoresid != null ? zscoresid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Zscores)) {
            return false;
        }
        Zscores other = (Zscores) object;
        if ((this.zscoresid == null && other.zscoresid != null) || (this.zscoresid != null && !this.zscoresid.equals(other.zscoresid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.patient.Zscores[ zscoresid=" + zscoresid + " ]";
    }
    
}
