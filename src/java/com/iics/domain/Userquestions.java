/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.domain;

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
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author user
 */
@Entity
@Table(name = "userquestions", catalog = "iics_database", schema = "public", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"answer"})
    , @UniqueConstraint(columnNames = {"questionsid"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Userquestions.findAll", query = "SELECT u FROM Userquestions u")
    , @NamedQuery(name = "Userquestions.findByUserquestionsid", query = "SELECT u FROM Userquestions u WHERE u.userquestionsid = :userquestionsid")
    , @NamedQuery(name = "Userquestions.findByAnswer", query = "SELECT u FROM Userquestions u WHERE u.answer = :answer")})
public class Userquestions implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "userquestionsid", nullable = false)
    private Integer userquestionsid;
    @Size(max = 255)
    @Column(name = "answer", length = 255)
    private String answer;
    @Column(name = "systemuserid")
    private long systemuserid;
    @Column(name = "questionsid")
    private Integer questionsid;

    public long getQuestionsid() {
        return questionsid;
    }

    public void setQuestionsid(Integer questionsid) {
        this.questionsid = questionsid;
    }

    public long getSystemuserid() {
        return systemuserid;
    }

    public void setSystemuserid(long systemuserid) {
        this.systemuserid = systemuserid;
    }

    public Userquestions() {
    }

    public Userquestions(Integer userquestionsid) {
        this.userquestionsid = userquestionsid;
    }

    public Integer getUserquestionsid() {
        return userquestionsid;
    }

    public void setUserquestionsid(Integer userquestionsid) {
        this.userquestionsid = userquestionsid;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userquestionsid != null ? userquestionsid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Userquestions)) {
            return false;
        }
        Userquestions other = (Userquestions) object;
        if ((this.userquestionsid == null && other.userquestionsid != null) || (this.userquestionsid != null && !this.userquestionsid.equals(other.userquestionsid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.iics.domain.Userquestions[ userquestionsid=" + userquestionsid + " ]";
    }

}
