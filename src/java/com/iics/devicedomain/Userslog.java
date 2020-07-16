/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.devicedomain;

import com.iics.devicedomain.Computerloghistory;
import com.iics.domain.Systemuser;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Entity
@Table(name = "userslog", catalog = "iics_database", schema = "accessdevice")
@NamedQueries({
    @NamedQuery(name = "Userslog.findAll", query = "SELECT u FROM Userslog u"),
    @NamedQuery(name = "Userslog.findByUserslogid", query = "SELECT u FROM Userslog u WHERE u.userslogid = :userslogid"),
    @NamedQuery(name = "Userslog.findByLoggedout", query = "SELECT u FROM Userslog u WHERE u.loggedout = :loggedout"),
    @NamedQuery(name = "Userslog.findByLogouttime", query = "SELECT u FROM Userslog u WHERE u.logouttime = :logouttime")})
public class Userslog implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "Userslogid_seq")
    @SequenceGenerator(name = "Userslogid_seq", sequenceName = "userslog_userslogid_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "userslogid", nullable = false)
    private Long userslogid;
    @Column(name = "loggedout")
    private Boolean loggedout;
    @Column(name = "logouttime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date logouttime;
    @JoinColumn(name = "systemuserid", referencedColumnName = "systemuserid")
    @ManyToOne
    private Systemuser systemuser;
    @JoinColumn(name = "computerloghistoryndc", referencedColumnName = "computerloghistoryid")
    @ManyToOne
    private Computerloghistory computerloghistory;
    @JoinColumn(name = "computerloghistory", referencedColumnName = "computerloghistoryid")
    @ManyToOne
    private Computerloghistory computerloghistory1;

    public Userslog() {
    }

    public Userslog(Long userslogid) {
        this.userslogid = userslogid;
    }

    public Long getUserslogid() {
        return userslogid;
    }

    public void setUserslogid(Long userslogid) {
        this.userslogid = userslogid;
    }

    public Boolean getLoggedout() {
        return loggedout;
    }

    public void setLoggedout(Boolean loggedout) {
        this.loggedout = loggedout;
    }

    public Date getLogouttime() {
        return logouttime;
    }

    public void setLogouttime(Date logouttime) {
        this.logouttime = logouttime;
    }

    public Systemuser getSystemuser() {
        return systemuser;
    }

    public void setSystemuser(Systemuser systemuser) {
        this.systemuser = systemuser;
    }

    public Computerloghistory getComputerloghistory() {
        return computerloghistory;
    }

    public void setComputerloghistory(Computerloghistory computerloghistory) {
        this.computerloghistory = computerloghistory;
    }

    public Computerloghistory getComputerloghistory1() {
        return computerloghistory1;
    }

    public void setComputerloghistory1(Computerloghistory computerloghistory1) {
        this.computerloghistory1 = computerloghistory1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userslogid != null ? userslogid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Userslog)) {
            return false;
        }
        Userslog other = (Userslog) object;
        if ((this.userslogid == null && other.userslogid != null) || (this.userslogid != null && !this.userslogid.equals(other.userslogid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.devicedomain.Userslog[ userslogid=" + userslogid + " ]";
    }
    
}
