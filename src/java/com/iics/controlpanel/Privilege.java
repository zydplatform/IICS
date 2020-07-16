/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.controlpanel;

import java.io.Serializable;
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
 * @author RESEARCH
 */
@Entity
@Table(name = "controlpanel.privilege", catalog = "iics_database")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Privilege.findAll", query = "SELECT p FROM Privilege p")
    , @NamedQuery(name = "Privilege.findByPrivilegeid", query = "SELECT p FROM Privilege p WHERE p.privilegeid = :privilegeid")
    , @NamedQuery(name = "Privilege.findByPrivilege", query = "SELECT p FROM Privilege p WHERE p.privilege = :privilege")
    , @NamedQuery(name = "Privilege.findByDescription", query = "SELECT p FROM Privilege p WHERE p.description = :description")
    , @NamedQuery(name = "Privilege.findByPrivilegekey", query = "SELECT p FROM Privilege p WHERE p.privilegekey = :privilegekey")
    , @NamedQuery(name = "Privilege.findByPrivilegelevel", query = "SELECT p FROM Privilege p WHERE p.privilegelevel = :privilegelevel")
    , @NamedQuery(name = "Privilege.findByActive", query = "SELECT p FROM Privilege p WHERE p.active = :active")
    , @NamedQuery(name = "Privilege.findByPrivilegetype", query = "SELECT p FROM Privilege p WHERE p.privilegetype = :privilegetype")})
public class Privilege implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "privilegeid", nullable = false)
    private Integer privilegeid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "privilege", nullable = false, length = 2147483647)
    private String privilege;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Size(max = 2147483647)
    @Column(name = "privilegekey", length = 2147483647)
    private String privilegekey;
    @Basic(optional = false)
    @NotNull
    @Column(name = "privilegelevel", nullable = false)
    private int privilegelevel;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active", nullable = false)
    private boolean active;
    @Size(max = 255)
    @Column(name = "privilegetype", length = 255)
    private String privilegetype;

    public Privilege() {
    }

    public Privilege(Integer privilegeid) {
        this.privilegeid = privilegeid;
    }

    public Privilege(Integer privilegeid, String privilege, int privilegelevel, boolean active) {
        this.privilegeid = privilegeid;
        this.privilege = privilege;
        this.privilegelevel = privilegelevel;
        this.active = active;
    }

    public Integer getPrivilegeid() {
        return privilegeid;
    }

    public void setPrivilegeid(Integer privilegeid) {
        this.privilegeid = privilegeid;
    }

    public String getPrivilege() {
        return privilege;
    }

    public void setPrivilege(String privilege) {
        this.privilege = privilege;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrivilegekey() {
        return privilegekey;
    }

    public void setPrivilegekey(String privilegekey) {
        this.privilegekey = privilegekey;
    }

    public int getPrivilegelevel() {
        return privilegelevel;
    }

    public void setPrivilegelevel(int privilegelevel) {
        this.privilegelevel = privilegelevel;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getPrivilegetype() {
        return privilegetype;
    }

    public void setPrivilegetype(String privilegetype) {
        this.privilegetype = privilegetype;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (privilegeid != null ? privilegeid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Privilege)) {
            return false;
        }
        Privilege other = (Privilege) object;
        if ((this.privilegeid == null && other.privilegeid != null) || (this.privilegeid != null && !this.privilegeid.equals(other.privilegeid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.controlpanel.Privilege[ privilegeid=" + privilegeid + " ]";
    }
    
}
