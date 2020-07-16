/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.store;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;




/**
 *
 * @author IICS
 */
@Entity
@Table(name = "facilityorderitems", catalog = "iics_database", schema = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Facilityorderitems.findAll", query = "SELECT f FROM Facilityorderitems f")
    , @NamedQuery(name = "Facilityorderitems.findByFacilityorderitemsid", query = "SELECT f FROM Facilityorderitems f WHERE f.facilityorderitemsid = :facilityorderitemsid")
    , @NamedQuery(name = "Facilityorderitems.findByQtyordered", query = "SELECT f FROM Facilityorderitems f WHERE f.qtyordered = :qtyordered")
    , @NamedQuery(name = "Facilityorderitems.findByQtyreceived", query = "SELECT f FROM Facilityorderitems f WHERE f.qtyreceived = :qtyreceived")
    , @NamedQuery(name = "Facilityorderitems.findByQtyapproved", query = "SELECT f FROM Facilityorderitems f WHERE f.qtyapproved = :qtyapproved")
    , @NamedQuery(name = "Facilityorderitems.findByApprovalcomment", query = "SELECT f FROM Facilityorderitems f WHERE f.approvalcomment = :approvalcomment")
    , @NamedQuery(name = "Facilityorderitems.findByApproved", query = "SELECT f FROM Facilityorderitems f WHERE f.approved = :approved")
    , @NamedQuery(name = "Facilityorderitems.findByDateapproved", query = "SELECT f FROM Facilityorderitems f WHERE f.dateapproved = :dateapproved")
    , @NamedQuery(name = "Facilityorderitems.findByApprovedby", query = "SELECT f FROM Facilityorderitems f WHERE f.approvedby = :approvedby")
    , @NamedQuery(name = "Facilityorderitems.findByIspicked", query = "SELECT f FROM Facilityorderitems f WHERE f.ispicked = :ispicked")
    , @NamedQuery(name = "Facilityorderitems.findByServiced", query = "SELECT f FROM Facilityorderitems f WHERE f.serviced = :serviced")
    , @NamedQuery(name = "Facilityorderitems.findByServicedby", query = "SELECT f FROM Facilityorderitems f WHERE f.servicedby = :servicedby")
    , @NamedQuery(name = "Facilityorderitems.findByDateserviced", query = "SELECT f FROM Facilityorderitems f WHERE f.dateserviced = :dateserviced")
    , @NamedQuery(name = "Facilityorderitems.findByServicedcomment", query = "SELECT f FROM Facilityorderitems f WHERE f.servicedcomment = :servicedcomment")
    , @NamedQuery(name = "Facilityorderitems.findByPickedby", query = "SELECT f FROM Facilityorderitems f WHERE f.pickedby = :pickedby")
    , @NamedQuery(name = "Facilityorderitems.findByDeliveredby", query = "SELECT f FROM Facilityorderitems f WHERE f.deliveredby = :deliveredby")
    , @NamedQuery(name = "Facilityorderitems.findByDeliveredto", query = "SELECT f FROM Facilityorderitems f WHERE f.deliveredto = :deliveredto")
    , @NamedQuery(name = "Facilityorderitems.findByIsdelivered", query = "SELECT f FROM Facilityorderitems f WHERE f.isdelivered = :isdelivered")
    , @NamedQuery(name = "Facilityorderitems.findByDatedelivered", query = "SELECT f FROM Facilityorderitems f WHERE f.datedelivered = :datedelivered")
    , @NamedQuery(name = "Facilityorderitems.findByDatepicked", query = "SELECT f FROM Facilityorderitems f WHERE f.datepicked = :datepicked")
    , @NamedQuery(name = "Facilityorderitems.findByIsconsolidated", query = "SELECT f FROM Facilityorderitems f WHERE f.isconsolidated = :isconsolidated")})
public class Facilityorderitems implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "facilityorderitemsid", nullable = false)
    private Long facilityorderitemsid;
    @Column(name = "qtyordered")
    private BigInteger qtyordered;
    @Column(name = "qtyreceived")
    private BigInteger qtyreceived;
    @Column(name = "qtyapproved")
    private BigInteger qtyapproved;
    @Size(max = 255)
    @Column(name = "approvalcomment", length = 255)
    private String approvalcomment;
    @Column(name = "approved")
    private Boolean approved;
    @Column(name = "dateapproved")
    @Temporal(TemporalType.DATE)
    private Date dateapproved;
    @Column(name = "approvedby")
    private BigInteger approvedby;
    @Column(name = "ispicked")
    private Boolean ispicked;
    @Column(name = "serviced")
    private Boolean serviced;
    @Column(name = "servicedby")
    private BigInteger servicedby;
    @Column(name = "dateserviced")
    @Temporal(TemporalType.DATE)
    private Date dateserviced;
    @Size(max = 255)
    @Column(name = "servicedcomment", length = 255)
    private String servicedcomment;
    @Column(name = "pickedby")
    private BigInteger pickedby;
    @Column(name = "deliveredby")
    private BigInteger deliveredby;
    @Column(name = "deliveredto")
    private BigInteger deliveredto;
    @Column(name = "isdelivered")
    private Boolean isdelivered;
    @Column(name = "datedelivered")
    @Temporal(TemporalType.DATE)
    private Date datedelivered;
    @Column(name = "datepicked")
    @Temporal(TemporalType.DATE)
    private Date datepicked;
    @Column(name = "isconsolidated")
    private Boolean isconsolidated;
    @OneToMany(mappedBy = "facilityorderitemsid")
    private List<Orderissuance> orderissuanceList;
    @JoinColumn(name = "facilityorderid", referencedColumnName = "facilityorderid")
    @ManyToOne
    private Facilityorder facilityorderid;
    @JoinColumn(name = "itemid", referencedColumnName = "itemid")
    @ManyToOne
    private Item itemid;
    @Column(name = "qtysanctioned")
    private Integer qtysanctioned;

    public Facilityorderitems() {
    }

    public Facilityorderitems(Long facilityorderitemsid) {
        this.facilityorderitemsid = facilityorderitemsid;
    }

    public Long getFacilityorderitemsid() {
        return facilityorderitemsid;
    }

    public void setFacilityorderitemsid(Long facilityorderitemsid) {
        this.facilityorderitemsid = facilityorderitemsid;
    }

    public BigInteger getQtyordered() {
        return qtyordered;
    }

    public void setQtyordered(BigInteger qtyordered) {
        this.qtyordered = qtyordered;
    }

    public BigInteger getQtyreceived() {
        return qtyreceived;
    }

    public void setQtyreceived(BigInteger qtyreceived) {
        this.qtyreceived = qtyreceived;
    }

    public BigInteger getQtyapproved() {
        return qtyapproved;
    }

    public void setQtyapproved(BigInteger qtyapproved) {
        this.qtyapproved = qtyapproved;
    }

    public String getApprovalcomment() {
        return approvalcomment;
    }

    public void setApprovalcomment(String approvalcomment) {
        this.approvalcomment = approvalcomment;
    }

    public Boolean getApproved() {
        return approved;
    }

    public void setApproved(Boolean approved) {
        this.approved = approved;
    }

    public Date getDateapproved() {
        return dateapproved;
    }

    public void setDateapproved(Date dateapproved) {
        this.dateapproved = dateapproved;
    }

    public BigInteger getApprovedby() {
        return approvedby;
    }

    public void setApprovedby(BigInteger approvedby) {
        this.approvedby = approvedby;
    }

    public Boolean getIspicked() {
        return ispicked;
    }

    public void setIspicked(Boolean ispicked) {
        this.ispicked = ispicked;
    }

    public Boolean getServiced() {
        return serviced;
    }

    public void setServiced(Boolean serviced) {
        this.serviced = serviced;
    }

    public BigInteger getServicedby() {
        return servicedby;
    }

    public void setServicedby(BigInteger servicedby) {
        this.servicedby = servicedby;
    }

    public Date getDateserviced() {
        return dateserviced;
    }

    public void setDateserviced(Date dateserviced) {
        this.dateserviced = dateserviced;
    }

    public String getServicedcomment() {
        return servicedcomment;
    }

    public void setServicedcomment(String servicedcomment) {
        this.servicedcomment = servicedcomment;
    }

    public BigInteger getPickedby() {
        return pickedby;
    }

    public void setPickedby(BigInteger pickedby) {
        this.pickedby = pickedby;
    }

    public BigInteger getDeliveredby() {
        return deliveredby;
    }

    public void setDeliveredby(BigInteger deliveredby) {
        this.deliveredby = deliveredby;
    }

    public BigInteger getDeliveredto() {
        return deliveredto;
    }

    public void setDeliveredto(BigInteger deliveredto) {
        this.deliveredto = deliveredto;
    }

    public Boolean getIsdelivered() {
        return isdelivered;
    }

    public void setIsdelivered(Boolean isdelivered) {
        this.isdelivered = isdelivered;
    }

    public Date getDatedelivered() {
        return datedelivered;
    }

    public void setDatedelivered(Date datedelivered) {
        this.datedelivered = datedelivered;
    }

    public Date getDatepicked() {
        return datepicked;
    }

    public void setDatepicked(Date datepicked) {
        this.datepicked = datepicked;
    }

    public Boolean getIsconsolidated() {
        return isconsolidated;
    }

    public void setIsconsolidated(Boolean isconsolidated) {
        this.isconsolidated = isconsolidated;
    }

    @XmlTransient
    public List<Orderissuance> getOrderissuanceList() {
        return orderissuanceList;
    }

    public void setOrderissuanceList(List<Orderissuance> orderissuanceList) {
        this.orderissuanceList = orderissuanceList;
    }

    public Facilityorder getFacilityorderid() {
        return facilityorderid;
    }

    public void setFacilityorderid(Facilityorder facilityorderid) {
        this.facilityorderid = facilityorderid;
    }

    public Item getItemid() {
        return itemid;
    }

    public void setItemid(Item itemid) {
        this.itemid = itemid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (facilityorderitemsid != null ? facilityorderitemsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Facilityorderitems)) {
            return false;
        }
        Facilityorderitems other = (Facilityorderitems) object;
        if ((this.facilityorderitemsid == null && other.facilityorderitemsid != null) || (this.facilityorderitemsid != null && !this.facilityorderitemsid.equals(other.facilityorderitemsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.store.Facilityorderitems[ facilityorderitemsid=" + facilityorderitemsid + " ]";
    }

    public Integer getQtysanctioned() {
        return qtysanctioned;
    }

    public void setQtysanctioned(Integer qtysanctioned) {
        this.qtysanctioned = qtysanctioned;
    }
}
