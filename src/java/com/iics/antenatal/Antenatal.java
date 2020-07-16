/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.antenatal;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Uwera
 */
@Entity
@Table(name = "antenatal", catalog = "iics_database", schema = "antenatal")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Antenatal.findAll", query = "SELECT a FROM Antenatal a")
    , @NamedQuery(name = "Antenatal.findByAntenatalid", query = "SELECT a FROM Antenatal a WHERE a.antenatalid = :antenatalid")
    , @NamedQuery(name = "Antenatal.findByLmp", query = "SELECT a FROM Antenatal a WHERE a.lmp = :lmp")
    , @NamedQuery(name = "Antenatal.findByFpmid", query = "SELECT a FROM Antenatal a WHERE a.fpmid = :fpmid")
    , @NamedQuery(name = "Antenatal.findByAmount", query = "SELECT a FROM Antenatal a WHERE a.amount = :amount")
    , @NamedQuery(name = "Antenatal.findByDc", query = "SELECT a FROM Antenatal a WHERE a.dc = :dc")
    , @NamedQuery(name = "Antenatal.findByDeliverymethod", query = "SELECT a FROM Antenatal a WHERE a.deliverymethod = :deliverymethod")
    , @NamedQuery(name = "Antenatal.findByEctopicpregnancy", query = "SELECT a FROM Antenatal a WHERE a.ectopicpregnancy = :ectopicpregnancy")
    , @NamedQuery(name = "Antenatal.findByPph", query = "SELECT a FROM Antenatal a WHERE a.pph = :pph")
    , @NamedQuery(name = "Antenatal.findByBloodtransfusion", query = "SELECT a FROM Antenatal a WHERE a.bloodtransfusion = :bloodtransfusion")
    , @NamedQuery(name = "Antenatal.findByAbortion", query = "SELECT a FROM Antenatal a WHERE a.abortion = :abortion")
    , @NamedQuery(name = "Antenatal.findByPuerperium", query = "SELECT a FROM Antenatal a WHERE a.puerperium = :puerperium")
    , @NamedQuery(name = "Antenatal.findByBabyalive", query = "SELECT a FROM Antenatal a WHERE a.babyalive = :babyalive")
    , @NamedQuery(name = "Antenatal.findByFulltermbaby", query = "SELECT a FROM Antenatal a WHERE a.fulltermbaby = :fulltermbaby")
    , @NamedQuery(name = "Antenatal.findBySacralcurve", query = "SELECT a FROM Antenatal a WHERE a.sacralcurve = :sacralcurve")
    , @NamedQuery(name = "Antenatal.findByPelvis", query = "SELECT a FROM Antenatal a WHERE a.pelvis = :pelvis")
    , @NamedQuery(name = "Antenatal.findByTetanus", query = "SELECT a FROM Antenatal a WHERE a.tetanus = :tetanus")
    , @NamedQuery(name = "Antenatal.findByParity", query = "SELECT a FROM Antenatal a WHERE a.parity = :parity")
    , @NamedQuery(name = "Antenatal.findByGravidity", query = "SELECT a FROM Antenatal a WHERE a.gravidity = :gravidity")
    , @NamedQuery(name = "Antenatal.findByPatientid", query = "SELECT a FROM Antenatal a WHERE a.patientid = :patientid")
    , @NamedQuery(name = "Antenatal.findByAddedby", query = "SELECT a FROM Antenatal a WHERE a.addedby = :addedby")
    , @NamedQuery(name = "Antenatal.findByDateadded", query = "SELECT a FROM Antenatal a WHERE a.dateadded = :dateadded")
    , @NamedQuery(name = "Antenatal.findByVisitnumber", query = "SELECT a FROM Antenatal a WHERE a.visitnumber = :visitnumber")
    , @NamedQuery(name = "Antenatal.findByVisittype", query = "SELECT a FROM Antenatal a WHERE a.visittype = :visittype")
    , @NamedQuery(name = "Antenatal.findByFacilityunitid", query = "SELECT a FROM Antenatal a WHERE a.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "Antenatal.findByVisitpriority", query = "SELECT a FROM Antenatal a WHERE a.visitpriority = :visitpriority")
    , @NamedQuery(name = "Antenatal.findByBloodgroup", query = "SELECT a FROM Antenatal a WHERE a.bloodgroup = :bloodgroup")
    , @NamedQuery(name = "Antenatal.findByPlaceofdelivery", query = "SELECT a FROM Antenatal a WHERE a.placeofdelivery = :placeofdelivery")
    , @NamedQuery(name = "Antenatal.findByPlacetogoafterdelivery", query = "SELECT a FROM Antenatal a WHERE a.placetogoafterdelivery = :placetogoafterdelivery")
    , @NamedQuery(name = "Antenatal.findByFracture", query = "SELECT a FROM Antenatal a WHERE a.fracture = :fracture")
    , @NamedQuery(name = "Antenatal.findByVacuumextraction", query = "SELECT a FROM Antenatal a WHERE a.vacuumextraction = :vacuumextraction")
    , @NamedQuery(name = "Antenatal.findByCervix", query = "SELECT a FROM Antenatal a WHERE a.cervix = :cervix")
    , @NamedQuery(name = "Antenatal.findByBabygender", query = "SELECT a FROM Antenatal a WHERE a.babygender = :babygender")
    , @NamedQuery(name = "Antenatal.findByBabybirthweight", query = "SELECT a FROM Antenatal a WHERE a.babybirthweight = :babybirthweight")
    , @NamedQuery(name = "Antenatal.findByBabyhealthcondition", query = "SELECT a FROM Antenatal a WHERE a.babyhealthcondition = :babyhealthcondition")
    , @NamedQuery(name = "Antenatal.findByPlacentadelivery", query = "SELECT a FROM Antenatal a WHERE a.placentadelivery = :placentadelivery")
    , @NamedQuery(name = "Antenatal.findByBelow12weeks", query = "SELECT a FROM Antenatal a WHERE a.below12weeks = :below12weeks")
    , @NamedQuery(name = "Antenatal.findByAbove12weeks", query = "SELECT a FROM Antenatal a WHERE a.above12weeks = :above12weeks")
    , @NamedQuery(name = "Antenatal.findByPremature", query = "SELECT a FROM Antenatal a WHERE a.premature = :premature")
    , @NamedQuery(name = "Antenatal.findByDiagonalconjugate", query = "SELECT a FROM Antenatal a WHERE a.diagonalconjugate = :diagonalconjugate")
    , @NamedQuery(name = "Antenatal.findByIschialspines", query = "SELECT a FROM Antenatal a WHERE a.ischialspines = :ischialspines")
    , @NamedQuery(name = "Antenatal.findByPelvisstate", query = "SELECT a FROM Antenatal a WHERE a.pelvisstate = :pelvisstate")})
public class Antenatal implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "antenatalid", nullable = false)
    private Integer antenatalid;
    @Column(name = "lmp")
    @Temporal(TemporalType.DATE)
    private Date lmp;
    @Column(name = "fpmid")
    private Integer fpmid;
    @Column(name = "amount", length = 2147483647)
    private String amount;
    @Column(name = "dc")
    private Boolean dc;
    @Column(name = "deliverymethod", length = 2147483647)
    private String deliverymethod;
    @Column(name = "ectopicpregnancy ")
    private Boolean ectopicpregnancy;
    @Column(name = "pph ")
    private Boolean pph;
    @Column(name = "bloodtransfusion")
    private Boolean bloodtransfusion;
    @Column(name = "abortion ")
    private Boolean abortion;
    @Column(name = "puerperium ")
    private Boolean puerperium;
    @Column(name = "babyalive")
    private Boolean babyalive;
    @Column(name = "fulltermbaby ")
    private Boolean fulltermbaby;
    @Column(name = "sacralcurve", length = 2147483647)
    private String sacralcurve;
    @Column(name = "pelvis", length = 2147483647)
    private String pelvis;
    @Column(name = "tetanus ")
    private Boolean tetanus;
    @Column(name = "parity")
    private Integer parity;
    @Column(name = "gravidity")
    private Integer gravidity;
    @Column(name = "patientid")
    private BigInteger patientid;
    @Column(name = " addedby")
    private BigInteger addedby;
    @Column(name = "dateadded ")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "visitnumber", length = 2147483647)
    private String visitnumber;
    @Column(name = "visittype", length = 2147483647)
    private String visittype;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Column(name = "visitpriority ", length = 2147483647)
    private String visitpriority;
    @Column(name = "bloodgroup", length = 2147483647)
    private String bloodgroup;
    @Column(name = "placeofdelivery", length = 2147483647)
    private String placeofdelivery;
    @Column(name = "placetogoafterdelivery", length = 2147483647)
    private String placetogoafterdelivery;
    @Column(name = "fracture", length = 2147483647)
    private String fracture;
    @Column(name = "vacuumextraction", length = 2147483647)
    private String vacuumextraction;
    @Column(name = "cervix", length = 2147483647)
    private String cervix;
    @Column(name = "babygender", length = 2147483647)
    private String babygender;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "babybirthweight", precision = 17, scale = 17)
    private Double babybirthweight;
    @Column(name = "babyhealthcondition ", length = 2147483647)
    private String babyhealthcondition;
    @Column(name = "placentadelivery")
    private Boolean placentadelivery;
    @Column(name = "below12weeks")
    private Boolean below12weeks;
    @Column(name = "above12weeks")
    private Boolean above12weeks;
    @Column(name = "premature")
    private Boolean premature;
    @Column(name = "diagonalconjugate", precision = 17, scale = 17)
    private Double diagonalconjugate;
    @Column(name = "ischialspines", length = 2147483647)
    private String ischialspines;
    @Column(name = "pelvisstate", length = 2147483647)
    private String pelvisstate;
//    @OneToMany(mappedBy = "antenatalid")
//    private List<Antenatalsymptom> antenatalsymptomList;

    public Antenatal() {
    }

    public Antenatal(Integer antenatalid) {
        this.antenatalid = antenatalid;
    }

    public Integer getAntenatalid() {
        return antenatalid;
    }

    public void setAntenatalid(Integer antenatalid) {
        this.antenatalid = antenatalid;
    }

    public Date getLmp() {
        return lmp;
    }

    public void setLmp(Date lmp) {
        this.lmp = lmp;
    }

    public Integer getFpmid() {
        return fpmid;
    }

    public void setFpmid(Integer fpmid) {
        this.fpmid = fpmid;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public Boolean getDc() {
        return dc;
    }

    public void setDc(Boolean dc) {
        this.dc = dc;
    }

    public String getDeliverymethod() {
        return deliverymethod;
    }

    public void setDeliverymethod(String deliverymethod) {
        this.deliverymethod = deliverymethod;
    }

    public Boolean getEctopicpregnancy() {
        return ectopicpregnancy;
    }

    public void setEctopicpregnancy(Boolean ectopicpregnancy) {
        this.ectopicpregnancy = ectopicpregnancy;
    }

    public Boolean getPph() {
        return pph;
    }

    public void setPph(Boolean pph) {
        this.pph = pph;
    }

    public Boolean getBloodtransfusion() {
        return bloodtransfusion;
    }

    public void setBloodtransfusion(Boolean bloodtransfusion) {
        this.bloodtransfusion = bloodtransfusion;
    }

    public Boolean getAbortion() {
        return abortion;
    }

    public void setAbortion(Boolean abortion) {
        this.abortion = abortion;
    }

    public Boolean getPuerperium() {
        return puerperium;
    }

    public void setPuerperium(Boolean puerperium) {
        this.puerperium = puerperium;
    }

    public Boolean getBabyalive() {
        return babyalive;
    }

    public void setBabyalive(Boolean babyalive) {
        this.babyalive = babyalive;
    }

    public Boolean getFulltermbaby() {
        return fulltermbaby;
    }

    public void setFulltermbaby(Boolean fulltermbaby) {
        this.fulltermbaby = fulltermbaby;
    }

    public String getSacralcurve() {
        return sacralcurve;
    }

    public void setSacralcurve(String sacralcurve) {
        this.sacralcurve = sacralcurve;
    }

    public String getPelvis() {
        return pelvis;
    }

    public void setPelvis(String pelvis) {
        this.pelvis = pelvis;
    }

    public Boolean getTetanus() {
        return tetanus;
    }

    public void setTetanus(Boolean tetanus) {
        this.tetanus = tetanus;
    }

    public Integer getParity() {
        return parity;
    }

    public void setParity(Integer parity) {
        this.parity = parity;
    }

    public Integer getGravidity() {
        return gravidity;
    }

    public void setGravidity(Integer gravidity) {
        this.gravidity = gravidity;
    }

    public BigInteger getPatientid() {
        return patientid;
    }

    public void setPatientid(BigInteger patientid) {
        this.patientid = patientid;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public void setAddedby(BigInteger addedby) {
        this.addedby = addedby;
    }

    public Date getDateadded() {
        return dateadded;
    }

    public void setDateadded(Date dateadded) {
        this.dateadded = dateadded;
    }

    public String getVisitnumber() {
        return visitnumber;
    }

    public void setVisitnumber(String visitnumber) {
        this.visitnumber = visitnumber;
    }

    public String getVisittype() {
        return visittype;
    }

    public void setVisittype(String visittype) {
        this.visittype = visittype;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public String getVisitpriority() {
        return visitpriority;
    }

    public void setVisitpriority(String visitpriority) {
        this.visitpriority = visitpriority;
    }

    public String getBloodgroup() {
        return bloodgroup;
    }

    public void setBloodgroup(String bloodgroup) {
        this.bloodgroup = bloodgroup;
    }

    public String getPlaceofdelivery() {
        return placeofdelivery;
    }

    public void setPlaceofdelivery(String placeofdelivery) {
        this.placeofdelivery = placeofdelivery;
    }

    public String getPlacetogoafterdelivery() {
        return placetogoafterdelivery;
    }

    public void setPlacetogoafterdelivery(String placetogoafterdelivery) {
        this.placetogoafterdelivery = placetogoafterdelivery;
    }

    public String getFracture() {
        return fracture;
    }

    public void setFracture(String fracture) {
        this.fracture = fracture;
    }

    public String getVacuumextraction() {
        return vacuumextraction;
    }

    public void setVacuumextraction(String vacuumextraction) {
        this.vacuumextraction = vacuumextraction;
    }

    public String getCervix() {
        return cervix;
    }

    public void setCervix(String cervix) {
        this.cervix = cervix;
    }

    public String getBabygender() {
        return babygender;
    }

    public void setBabygender(String babygender) {
        this.babygender = babygender;
    }

    public Double getBabybirthweight() {
        return babybirthweight;
    }

    public void setBabybirthweight(Double babybirthweight) {
        this.babybirthweight = babybirthweight;
    }

    public String getBabyhealthcondition() {
        return babyhealthcondition;
    }

    public void setBabyhealthcondition(String babyhealthcondition) {
        this.babyhealthcondition = babyhealthcondition;
    }

    public Boolean getPlacentadelivery() {
        return placentadelivery;
    }

    public void setPlacentadelivery(Boolean placentadelivery) {
        this.placentadelivery = placentadelivery;
    }

    public Boolean getBelow12weeks() {
        return below12weeks;
    }

    public void setBelow12weeks(Boolean below12weeks) {
        this.below12weeks = below12weeks;
    }

    public Boolean getAbove12weeks() {
        return above12weeks;
    }

    public void setAbove12weeks(Boolean above12weeks) {
        this.above12weeks = above12weeks;
    }

    public Boolean getPremature() {
        return premature;
    }

    public void setPremature(Boolean premature) {
        this.premature = premature;
    }

    public Double getDiagonalconjugate() {
        return diagonalconjugate;
    }

    public void setDiagonalconjugate(Double diagonalconjugate) {
        this.diagonalconjugate = diagonalconjugate;
    }

    public String getIschialspines() {
        return ischialspines;
    }

    public void setIschialspines(String ischialspines) {
        this.ischialspines = ischialspines;
    }

    public String getPelvisstate() {
        return pelvisstate;
    }

    public void setPelvisstate(String pelvisstate) {
        this.pelvisstate = pelvisstate;
    }

//    @XmlTransient
//    public List<Antenatalsymptom> getAntenatalsymptomList() {
//        return antenatalsymptomList;
//    }

//    public void setAntenatalsymptomList(List<Antenatalsymptom> antenatalsymptomList) {
//        this.antenatalsymptomList = antenatalsymptomList;
//    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (antenatalid != null ? antenatalid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Antenatal)) {
            return false;
        }
        Antenatal other = (Antenatal) object;
        if ((this.antenatalid == null && other.antenatalid != null) || (this.antenatalid != null && !this.antenatalid.equals(other.antenatalid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.antenatal.Antenatal[ antenatalid=" + antenatalid + " ]";
    }
    
}
