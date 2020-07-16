/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

import java.io.Serializable;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author RESEARCH
 */
@Entity
@Table(name = "systemrole", catalog = "iics_database", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Systemrole.findAll", query = "SELECT s FROM Systemrole s")
    , @NamedQuery(name = "Systemrole.findBySystemroleid", query = "SELECT s FROM Systemrole s WHERE s.systemroleid = :systemroleid")
    , @NamedQuery(name = "Systemrole.findByDescription", query = "SELECT s FROM Systemrole s WHERE s.description = :description")
    , @NamedQuery(name = "Systemrole.findByRolename", query = "SELECT s FROM Systemrole s WHERE s.rolename = :rolename")
    , @NamedQuery(name = "Systemrole.findByRolekey", query = "SELECT s FROM Systemrole s WHERE s.rolekey = :rolekey")
    , @NamedQuery(name = "Systemrole.findByRolelevel", query = "SELECT s FROM Systemrole s WHERE s.rolelevel = :rolelevel")
    , @NamedQuery(name = "Systemrole.findByActive", query = "SELECT s FROM Systemrole s WHERE s.active = :active")
    , @NamedQuery(name = "Systemrole.findByIscustom", query = "SELECT s FROM Systemrole s WHERE s.iscustom = :iscustom")
    , @NamedQuery(name = "Systemrole.findByIsimported", query = "SELECT s FROM Systemrole s WHERE s.isimported = :isimported")})
public class Systemrole implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "systemroleid", nullable = false)
    private Integer systemroleid;
    @Size(max = 2147483647)
    @Column(name = "description", length = 2147483647)
    private String description;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "rolename", nullable = false, length = 2147483647)
    private String rolename;
    @Size(max = 2147483647)
    @Column(name = "rolekey", length = 2147483647)
    private String rolekey;
    @Basic(optional = false)
    @NotNull
    @Column(name = "rolelevel", nullable = false)
    private int rolelevel;
    @Basic(optional = false)
    @NotNull
    @Column(name = "active", nullable = false)
    private boolean active;
    @Column(name = "iscustom")
    private Boolean iscustom;
    @Column(name = "isimported")
    private Boolean isimported;
    @OneToMany(mappedBy = "systemroleid")
    private List<Systemrolefacility> systemrolefacilityList;
    @JoinColumn(name = "designationcategoryid", referencedColumnName = "designationcategoryid")
    @ManyToOne
    private Designationcategory designationcategoryid;

    public Systemrole() {
    }

    public Systemrole(Integer systemroleid) {
        this.systemroleid = systemroleid;
    }

    public Systemrole(Integer systemroleid, String rolename, int rolelevel, boolean active) {
        this.systemroleid = systemroleid;
        this.rolename = rolename;
        this.rolelevel = rolelevel;
        this.active = active;
    }

    public Integer getSystemroleid() {
        return systemroleid;
    }

    public void setSystemroleid(Integer systemroleid) {
        this.systemroleid = systemroleid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getRolekey() {
        return rolekey;
    }

    public void setRolekey(String rolekey) {
        this.rolekey = rolekey;
    }

    public int getRolelevel() {
        return rolelevel;
    }

    public void setRolelevel(int rolelevel) {
        this.rolelevel = rolelevel;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Boolean getIscustom() {
        return iscustom;
    }

    public void setIscustom(Boolean iscustom) {
        this.iscustom = iscustom;
    }

    public Boolean getIsimported() {
        return isimported;
    }

    public void setIsimported(Boolean isimported) {
        this.isimported = isimported;
    }

    @XmlTransient
    public List<Systemrolefacility> getSystemrolefacilityList() {
        return systemrolefacilityList;
    }

    public void setSystemrolefacilityList(List<Systemrolefacility> systemrolefacilityList) {
        this.systemrolefacilityList = systemrolefacilityList;
    }

    public Designationcategory getDesignationcategoryid() {
        return designationcategoryid;
    }

    public void setDesignationcategoryid(Designationcategory designationcategoryid) {
        this.designationcategoryid = designationcategoryid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (systemroleid != null ? systemroleid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Systemrole)) {
            return false;
        }
        Systemrole other = (Systemrole) object;
        if ((this.systemroleid == null && other.systemroleid != null) || (this.systemroleid != null && !this.systemroleid.equals(other.systemroleid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Systemrole[ systemroleid=" + systemroleid + " ]";
    }
    
}
