/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.utils.general;

import com.iics.domain.Person;

/**
 *
 * @author samuelwam
 */
public class CustomPerson {
    
    Person personndc;
    Person searchedPersonndc;
    Person matchedPersonndc;
        
    boolean deleteSuccess;
    boolean saveSuccess;
    boolean confirmSuccess;
    int attachedCategories;
    int attachedTitles;
    boolean personState;
    boolean guestApprovalState;
    boolean guestState;
    boolean inSession;
    
    //Used Under Quality Control
    long count1;
    long count2;
    long count3;
    long count4;
    long count5;
    long count6;
    long count7;
    long count8;

    public int getAttachedCategories() {
        return attachedCategories;
    }

    public void setAttachedCategories(int attachedCategories) {
        this.attachedCategories = attachedCategories;
    }

    public int getAttachedTitles() {
        return attachedTitles;
    }

    public void setAttachedTitles(int attachedTitles) {
        this.attachedTitles = attachedTitles;
    }

    public boolean isConfirmSuccess() {
        return confirmSuccess;
    }

    public void setConfirmSuccess(boolean confirmSuccess) {
        this.confirmSuccess = confirmSuccess;
    }

    public boolean isDeleteSuccess() {
        return deleteSuccess;
    }

    public void setDeleteSuccess(boolean deleteSuccess) {
        this.deleteSuccess = deleteSuccess;
    }

    public Person getMatchedPersonndc() {
        return matchedPersonndc;
    }

    public void setMatchedPersonndc(Person matchedPersonndc) {
        this.matchedPersonndc = matchedPersonndc;
    }

    public Person getPersonndc() {
        return personndc;
    }

    public void setPersonndc(Person personndc) {
        this.personndc = personndc;
    }

    public boolean isSaveSuccess() {
        return saveSuccess;
    }

    public void setSaveSuccess(boolean saveSuccess) {
        this.saveSuccess = saveSuccess;
    }

    public Person getSearchedPersonndc() {
        return searchedPersonndc;
    }

    public void setSearchedPersonndc(Person searchedPersonndc) {
        this.searchedPersonndc = searchedPersonndc;
    }

    public boolean isPersonState() {
        return personState;
    }

    public void setPersonState(boolean personState) {
        this.personState = personState;
    }

    public boolean isGuestApprovalState() {
        return guestApprovalState;
    }

    public void setGuestApprovalState(boolean guestApprovalState) {
        this.guestApprovalState = guestApprovalState;
    }

    public boolean isGuestState() {
        return guestState;
    }

    public void setGuestState(boolean guestState) {
        this.guestState = guestState;
    }

    public boolean isInSession() {
        return inSession;
    }

    public void setInSession(boolean inSession) {
        this.inSession = inSession;
    }

    public long getCount1() {
        return count1;
    }

    public void setCount1(long count1) {
        this.count1 = count1;
    }

    public long getCount2() {
        return count2;
    }

    public void setCount2(long count2) {
        this.count2 = count2;
    }

    public long getCount3() {
        return count3;
    }

    public void setCount3(long count3) {
        this.count3 = count3;
    }

    public long getCount4() {
        return count4;
    }

    public void setCount4(long count4) {
        this.count4 = count4;
    }

    public long getCount5() {
        return count5;
    }

    public void setCount5(long count5) {
        this.count5 = count5;
    }

    public long getCount6() {
        return count6;
    }

    public void setCount6(long count6) {
        this.count6 = count6;
    }

    public long getCount7() {
        return count7;
    }

    public void setCount7(long count7) {
        this.count7 = count7;
    }

    public long getCount8() {
        return count8;
    }

    public void setCount8(long count8) {
        this.count8 = count8;
    }


}
