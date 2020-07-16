/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils;


import com.iics.controlpanel.Systemmodule;
import java.util.List;

/**
 *
 * @author samuelwam
 */
public class CustomSystemmodule {
    
    Systemmodule systemmodule;
    int submodules;
    String childrenAttached;
    boolean deleteSuccess;
    boolean saveSuccess;
    boolean confirmSuccess;
    String treelevel;
    boolean assigned;
    boolean selected;
    boolean hasAttachment;
    int taggedprivs;
    boolean assignedpost;
    long id;
    CustomNotificationReceipient customNotificationReceipient;
    
    List<Systemmodule> systemmoduleList;
    List<CustomSystemmodule> customSystemmoduleList;
    List<Systemmodule> activityList;

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

    public boolean getSaveSuccess() {
        return saveSuccess;
    }

    public void setSaveSuccess(boolean saveSuccess) {
        this.saveSuccess = saveSuccess;
    }

    public int getSubmodules() {
        return submodules;
    }

    public void setSubmodules(int submodules) {
        this.submodules = submodules;
    }

    public Systemmodule getSystemmodule() {
        return systemmodule;
    }

    public void setSystemmodule(Systemmodule systemmodule) {
        this.systemmodule = systemmodule;
    }

    public List<Systemmodule> getSystemmoduleList() {
        return systemmoduleList;
    }

    public void setSystemmoduleList(List<Systemmodule> systemmoduleList) {
        this.systemmoduleList = systemmoduleList;
    }

    public String getTreelevel() {
        return treelevel;
    }

    public void setTreelevel(String treelevel) {
        this.treelevel = treelevel;
    }

    public List<CustomSystemmodule> getCustomSystemmoduleList() {
        return customSystemmoduleList;
    }

    public void setCustomSystemmoduleList(List<CustomSystemmodule> customSystemmoduleList) {
        this.customSystemmoduleList = customSystemmoduleList;
    }

    public boolean getAssigned() {
        return assigned;
    }

    public void setAssigned(boolean assigned) {
        this.assigned = assigned;
    }

    public boolean getAssignedpost() {
        return assignedpost;
    }

    public void setAssignedpost(boolean assignedpost) {
        this.assignedpost = assignedpost;
    }

    public boolean getSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public boolean getHasAttachment() {
        return hasAttachment;
    }

    public void setHasAttachment(boolean hasAttachment) {
        this.hasAttachment = hasAttachment;
    }

    public int getTaggedprivs() {
        return taggedprivs;
    }

    public void setTaggedprivs(int taggedprivs) {
        this.taggedprivs = taggedprivs;
    }

    public List<Systemmodule> getActivityList() {
        return activityList;
    }

    public void setActivityList(List<Systemmodule> activityList) {
        this.activityList = activityList;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public CustomNotificationReceipient getCustomNotificationReceipient() {
        return customNotificationReceipient;
    }

    public void setCustomNotificationReceipient(CustomNotificationReceipient customNotificationReceipient) {
        this.customNotificationReceipient = customNotificationReceipient;
    }
        
}
