/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils;


import com.iics.controlpanel.NotificationReceipient;
import com.iics.controlpanel.Systemroleprivilagefacility;
import java.util.List;

/**
 *
 * @author iics
 */
public class CustomNotificationReceipient {
    NotificationReceipient notificationReceipient;
    Systemroleprivilagefacility systemroleprivilagefacility;
    String childrenAttached;
    String strvalue;
    boolean deleteSuccess;
    boolean saveSuccess;
    boolean confirmSuccess;
    int unicasts;
    int multicasts;
    String unicaststr;
    String multicaststr;
    
    List<NotificationReceipient> notificationReceipientList;

    public String getChildrenAttached() {
        return childrenAttached;
    }

    public void setChildrenAttached(String childrenAttached) {
        this.childrenAttached = childrenAttached;
    }

    public boolean getConfirmSuccess() {
        return confirmSuccess;
    }

    public void setConfirmSuccess(boolean confirmSuccess) {
        this.confirmSuccess = confirmSuccess;
    }

    public boolean getDeleteSuccess() {
        return deleteSuccess;
    }

    public void setDeleteSuccess(boolean deleteSuccess) {
        this.deleteSuccess = deleteSuccess;
    }

    public NotificationReceipient getNotificationReceipient() {
        return notificationReceipient;
    }

    public void setNotificationReceipient(NotificationReceipient notificationReceipient) {
        this.notificationReceipient = notificationReceipient;
    }

    public List<NotificationReceipient> getNotificationReceipientList() {
        return notificationReceipientList;
    }

    public void setNotificationReceipientList(List<NotificationReceipient> notificationReceipientList) {
        this.notificationReceipientList = notificationReceipientList;
    }

    public boolean getSaveSuccess() {
        return saveSuccess;
    }

    public void setSaveSuccess(boolean saveSuccess) {
        this.saveSuccess = saveSuccess;
    }

    public String getStrvalue() {
        return strvalue;
    }

    public void setStrvalue(String strvalue) {
        this.strvalue = strvalue;
    }

    public int getMulticasts() {
        return multicasts;
    }

    public void setMulticasts(int multicasts) {
        this.multicasts = multicasts;
    }

    public String getMulticaststr() {
        return multicaststr;
    }

    public void setMulticaststr(String multicaststr) {
        this.multicaststr = multicaststr;
    }

    public int getUnicasts() {
        return unicasts;
    }

    public void setUnicasts(int unicasts) {
        this.unicasts = unicasts;
    }

    public String getUnicaststr() {
        return unicaststr;
    }

    public void setUnicaststr(String unicaststr) {
        this.unicaststr = unicaststr;
    }

    public Systemroleprivilagefacility getSystemroleprivilagefacility() {
        return systemroleprivilagefacility;
    }

    public void setSystemroleprivilagefacility(Systemroleprivilagefacility systemroleprivilagefacility) {
        this.systemroleprivilagefacility = systemroleprivilagefacility;
    }
    
}
