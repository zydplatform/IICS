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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "antenatalvisit", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Antenatalvisit.findAll", query = "SELECT a FROM Antenatalvisit a")
    , @NamedQuery(name = "Antenatalvisit.findByHospitalised", query = "SELECT a FROM Antenatalvisit a WHERE a.hospitalised = :hospitalised")
    , @NamedQuery(name = "Antenatalvisit.findByMoniliasis", query = "SELECT a FROM Antenatalvisit a WHERE a.moniliasis = :moniliasis")
    , @NamedQuery(name = "Antenatalvisit.findByVagina", query = "SELECT a FROM Antenatalvisit a WHERE a.vagina = :vagina")
    , @NamedQuery(name = "Antenatalvisit.findByAntenatalvisitid", query = "SELECT a FROM Antenatalvisit a WHERE a.antenatalvisitid = :antenatalvisitid")
    , @NamedQuery(name = "Antenatalvisit.findByFoetalheart", query = "SELECT a FROM Antenatalvisit a WHERE a.foetalheart = :foetalheart")
    , @NamedQuery(name = "Antenatalvisit.findByFundalheight", query = "SELECT a FROM Antenatalvisit a WHERE a.fundalheight = :fundalheight")
    , @NamedQuery(name = "Antenatalvisit.findByFaetpresentation", query = "SELECT a FROM Antenatalvisit a WHERE a.faetpresentation = :faetpresentation")
    , @NamedQuery(name = "Antenatalvisit.findByFoetposition", query = "SELECT a FROM Antenatalvisit a WHERE a.foetposition = :foetposition")
    , @NamedQuery(name = "Antenatalvisit.findByVaricoseoedema", query = "SELECT a FROM Antenatalvisit a WHERE a.varicoseoedema = :varicoseoedema")
    , @NamedQuery(name = "Antenatalvisit.findByFever", query = "SELECT a FROM Antenatalvisit a WHERE a.fever = :fever")
    , @NamedQuery(name = "Antenatalvisit.findByDiarrhoea", query = "SELECT a FROM Antenatalvisit a WHERE a.diarrhoea = :diarrhoea")
    , @NamedQuery(name = "Antenatalvisit.findByCough", query = "SELECT a FROM Antenatalvisit a WHERE a.cough = :cough")
    , @NamedQuery(name = "Antenatalvisit.findByWeightloss", query = "SELECT a FROM Antenatalvisit a WHERE a.weightloss = :weightloss")
    , @NamedQuery(name = "Antenatalvisit.findByHivstatus", query = "SELECT a FROM Antenatalvisit a WHERE a.hivstatus = :hivstatus")
    , @NamedQuery(name = "Antenatalvisit.findByWeeksofamenorhoea", query = "SELECT a FROM Antenatalvisit a WHERE a.weeksofamenorhoea = :weeksofamenorhoea")
    , @NamedQuery(name = "Antenatalvisit.findByPatientprogramid", query = "SELECT a FROM Antenatalvisit a WHERE a.patientprogramid = :patientprogramid")})
public class Antenatalvisit implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "hospitalised ")
    private Boolean hospitalised;
    @Column(name = "moniliasis ")
    private Boolean moniliasis;
    @Column(name = "vagina", length = 2147483647)
    private String vagina;
    @Id
    @Basic(optional = false)
    @Column(name = "antenatalvisitid", nullable = false)
    private Integer antenatalvisitid;
    @Column(name = "foetalheart ")
    private Integer foetalheart;
    @Column(name = "fundalheight ")
    private Integer fundalheight;
    @Column(name = "faetpresentation", length = 2147483647)
    private String faetpresentation;
    @Column(name = "foetposition", length = 2147483647)
    private String foetposition;
    @Column(name = "varicoseoedema")
    private Boolean varicoseoedema;
    @Column(name = "fever")
    private Boolean fever;
    @Column(name = "diarrhoea")
    private Boolean diarrhoea;
    @Column(name = "cough")
    private Boolean cough;
    @Column(name = "weightloss")
    private Boolean weightloss;
    @Column(name = "hivstatus")
    private Boolean hivstatus;
    @Column(name = "weeksofamenorhoea", length = 2147483647)
    private String weeksofamenorhoea;
    @Column(name = "patientprogramid")
    private Integer patientprogramid;
    @JoinColumn(name = "antenatalvisitid", referencedColumnName = "patientprogramid", nullable = false, insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Patientprogram patientprogram;
    @OneToMany(mappedBy = "antenatalvisitid")
    private List<Antenantalvisitcondition> antenantalvisitconditionList;

    public Antenatalvisit() {
    }

    public Antenatalvisit(Integer antenatalvisitid) {
        this.antenatalvisitid = antenatalvisitid;
    }

    public Boolean getHospitalised() {
        return hospitalised;
    }

    public void setHospitalised(Boolean hospitalised) {
        this.hospitalised = hospitalised;
    }

    public Boolean getMoniliasis() {
        return moniliasis;
    }

    public void setMoniliasis(Boolean moniliasis) {
        this.moniliasis = moniliasis;
    }

    public String getVagina() {
        return vagina;
    }

    public void setVagina(String vagina) {
        this.vagina = vagina;
    }

    public Integer getAntenatalvisitid() {
        return antenatalvisitid;
    }

    public void setAntenatalvisitid(Integer antenatalvisitid) {
        this.antenatalvisitid = antenatalvisitid;
    }

    public Integer getFoetalheart() {
        return foetalheart;
    }

    public void setFoetalheart(Integer foetalheart) {
        this.foetalheart = foetalheart;
    }

    public Integer getFundalheight() {
        return fundalheight;
    }

    public void setFundalheight(Integer fundalheight) {
        this.fundalheight = fundalheight;
    }

    public String getFaetpresentation() {
        return faetpresentation;
    }

    public void setFaetpresentation(String faetpresentation) {
        this.faetpresentation = faetpresentation;
    }

    public String getFoetposition() {
        return foetposition;
    }

    public void setFoetposition(String foetposition) {
        this.foetposition = foetposition;
    }

    public Boolean getVaricoseoedema() {
        return varicoseoedema;
    }

    public void setVaricoseoedema(Boolean varicoseoedema) {
        this.varicoseoedema = varicoseoedema;
    }

    public Boolean getFever() {
        return fever;
    }

    public void setFever(Boolean fever) {
        this.fever = fever;
    }

    public Boolean getDiarrhoea() {
        return diarrhoea;
    }

    public void setDiarrhoea(Boolean diarrhoea) {
        this.diarrhoea = diarrhoea;
    }

    public Boolean getCough() {
        return cough;
    }

    public void setCough(Boolean cough) {
        this.cough = cough;
    }

    public Boolean getWeightloss() {
        return weightloss;
    }

    public void setWeightloss(Boolean weightloss) {
        this.weightloss = weightloss;
    }

    public Boolean getHivstatus() {
        return hivstatus;
    }

    public void setHivstatus(Boolean hivstatus) {
        this.hivstatus = hivstatus;
    }

    public String getWeeksofamenorhoea() {
        return weeksofamenorhoea;
    }

    public void setWeeksofamenorhoea(String weeksofamenorhoea) {
        this.weeksofamenorhoea = weeksofamenorhoea;
    }

    public Integer getPatientprogramid() {
        return patientprogramid;
    }

    public void setPatientprogramid(Integer patientprogramid) {
        this.patientprogramid = patientprogramid;
    }

    public Patientprogram getPatientprogram() {
        return patientprogram;
    }

    public void setPatientprogram(Patientprogram patientprogram) {
        this.patientprogram = patientprogram;
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
        hash += (antenatalvisitid != null ? antenatalvisitid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Antenatalvisit)) {
            return false;
        }
        Antenatalvisit other = (Antenatalvisit) object;
        if ((this.antenatalvisitid == null && other.antenatalvisitid != null) || (this.antenatalvisitid != null && !this.antenatalvisitid.equals(other.antenatalvisitid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Antenatalvisit[ antenatalvisitid=" + antenatalvisitid + " ]";
    }
    
}
