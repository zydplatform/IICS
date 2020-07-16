<%-- 
    Document   : staffsearchlist
    Created on : Jul 11, 2018, 3:56:26 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../../include.jsp" %>
<!DOCTYPE html>
<input type="hidden" value="${searchValue}" id="patientSearchValue"/>
<c:if test="${not empty staff}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${staff}" var="u">
            <li class="classItem" onclick="userdetails(${u.staffid},$(this).attr('data-id'),$(this).attr('data-id1'),$(this).attr('data-id2'))" data-id="${u.firstname}" data-id1="${u.lastname}" data-id2="${u.othernames}">
                <div>
                    <div class="partientsearchcard">
                        <div class="firstinfo">
                            <input type="hidden" value="${u.staffid}" id="staffid" />
                            <input type="hidden" value="${u.staffno}" id="staffno"/>
                            <input type="hidden" value="${u.firstname}" id="firstname"/>
                            <input type="hidden" value="${u.lastname}" id="lastname"/>
                            <input type="hidden" value="${u.othernames}" id="othernames"/>
                            <input type="hidden" value="${u.personid}" id="personid"/>
                            <img src="static/images/profile-picture-placeholder.jpg"/>&nbsp;&nbsp;&nbsp;
                            <div class="profileinfo">
                                <h7 style="font-weight: bolder"><span style="color: graytext">NAME: </span> <span style="color: blueviolet; text-transform: uppercase;">${u.firstname} ${u.lastname} ${u.othernames}</span></h7><br>
                                <span><span style="font-weight: bolder; color: graytext">Staff number:${u.staffno} </span></span><br>

                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty staff}">
    <p class="center consentForm">
        <br>
        <span class="">Staff <span style="color: black !important; text-decoration: underline">${name}</span> is not a registered staff/request has been sent.<br>
            
    </p>
</c:if>
    <script>
    function userdetails(staffid){
        ajaxSubmitData('staffdetails.htm', 'staffinfo', 'staffid=' + staffid + '&act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    
    </script>


