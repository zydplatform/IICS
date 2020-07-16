/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.notification_receipient", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "NotificationReceipient.findAll", query = "SELECT n FROM NotificationReceipient n")
    , @NamedQuery(name = "NotificationReceipient.findByNotificationReceipientId", query = "SELECT n FROM NotificationReceipient n WHERE n.notificationReceipientId = :notificationReceipientId")
    , @NamedQuery(name = "NotificationReceipient.findByActive", query = "SELECT n FROM NotificationReceipient n WHERE n.active = :active")
    , @NamedQuery(name = "NotificationReceipient.findByMainreceiver", query = "SELECT n FROM NotificationReceipient n WHERE n.mainreceiver = :mainreceiver")
    , @NamedQuery(name = "NotificationReceipient.findByRecipientid", query = "SELECT n FROM NotificationReceipient n WHERE n.recipientid = :recipientid")
    , @NamedQuery(name = "NotificationReceipient.findByFacilityprivilegeid", query = "SELECT n FROM NotificationReceipient n WHERE n.facilityprivilegeid = :facilityprivilegeid")
    , @NamedQuery(name = "NotificationReceipient.findByFacilityunitid", query = "SELECT n FROM NotificationReceipient n WHERE n.facilityunitid = :facilityunitid")
    , @NamedQuery(name = "NotificationReceipient.findByUpdatedby", query = "SELECT n FROM NotificationReceipient n WHERE n.updatedby = :updatedby")
    , @NamedQuery(name = "NotificationReceipient.findByUpdatetime", query = "SELECT n FROM NotificationReceipient n WHERE n.updatetime = :updatetime")
    , @NamedQuery(name = "NotificationReceipient.findByViewscope", query = "SELECT n FROM NotificationReceipient n WHERE n.viewscope = :viewscope")
    , @NamedQuery(name = "NotificationReceipient.findByNotificationtemplateid", query = "SELECT n FROM NotificationReceipient n WHERE n.notificationtemplateid = :notificationtemplateid")
    , @NamedQuery(name = "NotificationReceipient.findByLocationid", query = "SELECT n FROM NotificationReceipient n WHERE n.locationid = :locationid")
    , @NamedQuery(name = "NotificationReceipient.findByGroupmsg", query = "SELECT n FROM NotificationReceipient n WHERE n.groupmsg = :groupmsg")
    , @NamedQuery(name = "NotificationReceipient.findByMessagelife", query = "SELECT n FROM NotificationReceipient n WHERE n.messagelife = :messagelife")
    , @NamedQuery(name = "NotificationReceipient.findByRole", query = "SELECT n FROM NotificationReceipient n WHERE n.role = :role")
    , @NamedQuery(name = "NotificationReceipient.findByIsNotified", query = "SELECT n FROM NotificationReceipient n WHERE n.isNotified = :isNotified")
    , @NamedQuery(name = "NotificationReceipient.findByIsRead", query = "SELECT n FROM NotificationReceipient n WHERE n.isRead = :isRead")
    , @NamedQuery(name = "NotificationReceipient.findByNotificationId", query = "SELECT n FROM NotificationReceipient n WHERE n.notificationId = :notificationId")
    , @NamedQuery(name = "NotificationReceipient.findByReceipientId", query = "SELECT n FROM NotificationReceipient n WHERE n.receipientId = :receipientId")})
public class NotificationReceipient implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "notification_receipient_id", nullable = false)
    private Long notificationReceipientId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active", nullable = false)
    private boolean active;
    @Basic(optional = false)
    @NotNull
    @Column(name = "mainreceiver", nullable = false)
    private boolean mainreceiver;
    @Column(name = "recipientid")
    private BigInteger recipientid;
    @Column(name = "facilityprivilegeid")
    private BigInteger facilityprivilegeid;
    @Column(name = "facilityunitid")
    private BigInteger facilityunitid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "updatedby", nullable = false)
    private long updatedby;
    @Basic(optional = false)
    @NotNull
    @Column(name = "updatetime", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatetime;
    @Size(max = 25)
    @Column(name = "viewscope", length = 25)
    private String viewscope;
    @Column(name = "notificationtemplateid")
    private BigInteger notificationtemplateid;
    @Column(name = "locationid")
    private BigInteger locationid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "groupmsg", nullable = false)
    private boolean groupmsg;
    @Basic(optional = false)
    @NotNull
    @Column(name = "messagelife", nullable = false)
    private int messagelife;
    @Size(max = 255)
    @Column(name = "role", length = 255)
    private String role;
    @Column(name = "is_notified")
    private Boolean isNotified;
    @Column(name = "is_read")
    private Boolean isRead;
    @Basic(optional = false)
    @NotNull
    @Column(name = "notification_id", nullable = false)
    private long notificationId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "receipient_id", nullable = false)
    private long receipientId;

    public NotificationReceipient() {
    }

    public NotificationReceipient(Long notificationReceipientId) {
        this.notificationReceipientId = notificationReceipientId;
    }

    public NotificationReceipient(Long notificationReceipientId, boolean active, boolean mainreceiver, long updatedby, Date updatetime, boolean groupmsg, int messagelife, long notificationId, long receipientId) {
        this.notificationReceipientId = notificationReceipientId;
        this.active = active;
        this.mainreceiver = mainreceiver;
        this.updatedby = updatedby;
        this.updatetime = updatetime;
        this.groupmsg = groupmsg;
        this.messagelife = messagelife;
        this.notificationId = notificationId;
        this.receipientId = receipientId;
    }

    public Long getNotificationReceipientId() {
        return notificationReceipientId;
    }

    public void setNotificationReceipientId(Long notificationReceipientId) {
        this.notificationReceipientId = notificationReceipientId;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean getMainreceiver() {
        return mainreceiver;
    }

    public void setMainreceiver(boolean mainreceiver) {
        this.mainreceiver = mainreceiver;
    }

    public BigInteger getRecipientid() {
        return recipientid;
    }

    public void setRecipientid(BigInteger recipientid) {
        this.recipientid = recipientid;
    }

    public BigInteger getFacilityprivilegeid() {
        return facilityprivilegeid;
    }

    public void setFacilityprivilegeid(BigInteger facilityprivilegeid) {
        this.facilityprivilegeid = facilityprivilegeid;
    }

    public BigInteger getFacilityunitid() {
        return facilityunitid;
    }

    public void setFacilityunitid(BigInteger facilityunitid) {
        this.facilityunitid = facilityunitid;
    }

    public long getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(long updatedby) {
        this.updatedby = updatedby;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public String getViewscope() {
        return viewscope;
    }

    public void setViewscope(String viewscope) {
        this.viewscope = viewscope;
    }

    public BigInteger getNotificationtemplateid() {
        return notificationtemplateid;
    }

    public void setNotificationtemplateid(BigInteger notificationtemplateid) {
        this.notificationtemplateid = notificationtemplateid;
    }

    public BigInteger getLocationid() {
        return locationid;
    }

    public void setLocationid(BigInteger locationid) {
        this.locationid = locationid;
    }

    public boolean getGroupmsg() {
        return groupmsg;
    }

    public void setGroupmsg(boolean groupmsg) {
        this.groupmsg = groupmsg;
    }

    public int getMessagelife() {
        return messagelife;
    }

    public void setMessagelife(int messagelife) {
        this.messagelife = messagelife;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Boolean getIsNotified() {
        return isNotified;
    }

    public void setIsNotified(Boolean isNotified) {
        this.isNotified = isNotified;
    }

    public Boolean getIsRead() {
        return isRead;
    }

    public void setIsRead(Boolean isRead) {
        this.isRead = isRead;
    }

    public long getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(long notificationId) {
        this.notificationId = notificationId;
    }

    public long getReceipientId() {
        return receipientId;
    }

    public void setReceipientId(long receipientId) {
        this.receipientId = receipientId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (notificationReceipientId != null ? notificationReceipientId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof NotificationReceipient)) {
            return false;
        }
        NotificationReceipient other = (NotificationReceipient) object;
        if ((this.notificationReceipientId == null && other.notificationReceipientId != null) || (this.notificationReceipientId != null && !this.notificationReceipientId.equals(other.notificationReceipientId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.NotificationReceipient[ notificationReceipientId=" + notificationReceipientId + " ]";
    }
    
}
