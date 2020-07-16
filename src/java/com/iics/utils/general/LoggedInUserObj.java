/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.general;

import com.iics.devicedomain.Computerloghistory;
import com.iics.domain.Facility;
import com.iics.domain.Region;
import com.iics.domain.Systemuser;
import java.util.Date;
import org.springframework.security.core.userdetails.User;

/**
 *
 * @author samuelwam
 */
public class LoggedInUserObj {
    
    private Computerloghistory computerloghistory;
    private User user;
    private Systemuser systemuser;
    private Facility facility;
    private Date accessdate;
    private String duration;
    private Region region;
    int count;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Systemuser getSystemuser() {
        return systemuser;
    }

    public void setSystemuser(Systemuser systemuser) {
        this.systemuser = systemuser;
    }

    public Facility getFacility() {
        return facility;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public Date getAccessdate() {
        return accessdate;
    }

    public void setAccessdate(Date accessdate) {
        this.accessdate = accessdate;
    }

    public Computerloghistory getComputerloghistory() {
        return computerloghistory;
    }

    public void setComputerloghistory(Computerloghistory computerloghistory) {
        this.computerloghistory = computerloghistory;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public Region getRegion() {
        return region;
    }

    public void setRegion(Region region) {
        this.region = region;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    
    
}
