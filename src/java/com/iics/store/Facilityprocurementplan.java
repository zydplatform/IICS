/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author IICS
 */
@Entity
@Table(name = "facilityprocurementplan", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityprocurementplan.findAll", query = "SELECT f FROM Facilityprocurementplan f")
    , @NamedQuery(name = "Facilityprocurementplan.findByFacilityprocurementplanid", query = "SELECT f FROM Facilityprocurementplan f WHERE f.facilityprocurementplanid = :facilityprocurementplanid")
    , @NamedQuery(name = "Facilityprocurementplan.findByAveragemonthconsumption", query = "SELECT f FROM Facilityprocurementplan f WHERE f.averagemonthconsumption = :averagemonthconsumption")
    , @NamedQuery(name = "Facilityprocurementplan.findByAverageannualconsumption", query = "SELECT f FROM Facilityprocurementplan f WHERE f.averageannualconsumption = :averageannualconsumption")
    , @NamedQuery(name = "Facilityprocurementplan.findByAveragequarterconsumption", query = "SELECT f FROM Facilityprocurementplan f WHERE f.averagequarterconsumption = :averagequarterconsumption")
    , @NamedQuery(name = "Facilityprocurementplan.findByAddedby", query = "SELECT f FROM Facilityprocurementplan f WHERE f.addedby = :addedby")
    , @NamedQuery(name = "Facilityprocurementplan.findByDateadded", query = "SELECT f FROM Facilityprocurementplan f WHERE f.dateadded = :dateadded")
    , @NamedQuery(name = "Facilityprocurementplan.findByApproved", query = "SELECT f FROM Facilityprocurementplan f WHERE f.approved = :approved")
    , @NamedQuery(name = "Facilityprocurementplan.findByApprovedby", query = "SELECT f FROM Facilityprocurementplan f WHERE f.approvedby = :approvedby")
    , @NamedQuery(name = "Facilityprocurementplan.findByDateapproved", query = "SELECT f FROM Facilityprocurementplan f WHERE f.dateapproved = :dateapproved")
    , @NamedQuery(name = "Facilityprocurementplan.findByApprovalcomment", query = "SELECT f FROM Facilityprocurementplan f WHERE f.approvalcomment = :approvalcomment")})
public class Facilityprocurementplan implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityprocurementplanid", nullable = false)
    private Long facilityprocurementplanid;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "averagemonthconsumption", precision = 17, scale = 17)
    private Double averagemonthconsumption;
    @Column(name = "averageannualconsumption", precision = 17, scale = 17)
    private Double averageannualconsumption;
    @Column(name = "averagequarterconsumption", precision = 17, scale = 17)
    private Double averagequarterconsumption;
    @Column(name = "addedby")
    private BigInteger addedby;
    @Column(name = "dateadded")
    @Temporal(TemporalType.DATE)
    private Date dateadded;
    @Column(name = "approved")
    private Boolean approved;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @Size(max = 2147483647)
    @Column(name = "approvalcomment", length = 2147483647)
    private String approvalcomment;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;
    @JoinColumn(name = "orderperiodid", referencedColumnName = "orderperiodid")
    @ManyToOne
    private Orderperiod orderperiodid;
    @Column(name = "pack")
    private Integer pack;
    @Column(name = "itemcode")
    private String itemcode;
    @Column(name = "unitcost", precision = 17, scale = 17)
    private Double unitcost;

    public Facilityprocurementplan() {
    }

    public String getItemcode() {
        return itemcode;
    }

    public void setItemcode(String itemcode) {
        this.itemcode = itemcode;
    }

    public Facilityprocurementplan(Long facilityprocurementplanid) {
        this.facilityprocurementplanid = facilityprocurementplanid;
    }
    
    public Long getFacilityprocurementplanid() {
        return facilityprocurementplanid;
    }
    public void setFacilityprocurementplanid(Long facilityprocurementplanid) {
        this.facilityprocurementplanid = facilityprocurementplanid;
    }
    public Double getAveragemonthconsumption() {
        return averagemonthconsumption;
    }
    public void setAveragemonthconsumption(Double averagemonthconsumption) {
        this.averagemonthconsumption = averagemonthconsumption;
    }

    public Double getAverageannualconsumption() {
        return averageannualconsumption;
    }

    public void setAverageannualconsumption(Double averageannualconsumption) {
        this.averageannualconsumption = averageannualconsumption;
    }

    public Double getAveragequarterconsumption() {
        return averagequarterconsumption;
    }

    public void setAveragequarterconsumption(Double averagequarterconsumption) {
        this.averagequarterconsumption = averagequarterconsumption;
    }

    public BigInteger getAddedby() {
        return addedby;
    }

    public Integer getPack() {
        return pack;
    }

    public void setPack(Integer pack) {
        this.pack = pack;
    }

    public Double getUnitcost() {
        return unitcost;
    }

    public void setUnitcost(Double unitcost) {
        this.unitcost = unitcost;
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

    public Boolean getApproved() {
        return approved;
    }

    public void setApproved(Boolean approved) {
        this.approved = approved;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public String getApprovalcomment() {
        return approvalcomment;
    }

    public void setApprovalcomment(String approvalcomment) {
        this.approvalcomment = approvalcomment;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    public Orderperiod getOrderperiodid() {
        return orderperiodid;
    }

    public void setOrderperiodid(Orderperiod orderperiodid) {
        this.orderperiodid = orderperiodid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityprocurementplanid != null ? facilityprocurementplanid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityprocurementplan)) {
            return false;
        }
        Facilityprocurementplan other = (Facilityprocurementplan) object;
        if ((this.facilityprocurementplanid == null && other.facilityprocurementplanid != null) || (this.facilityprocurementplanid != null && !this.facilityprocurementplanid.equals(other.facilityprocurementplanid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilityprocurementplan[ facilityprocurementplanid=" + facilityprocurementplanid + " ]";
    }

}
