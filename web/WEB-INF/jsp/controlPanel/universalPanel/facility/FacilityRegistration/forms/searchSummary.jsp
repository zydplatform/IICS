<%-- 
    Document   : searchSummary
    Created on : Apr 23, 2018, 11:14:58 AM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!-- start: FORM VALIDATION 1 PANEL -->
<div class="panel panel-default">
    <fieldset style="width:auto">
        <div class="form-group row">
            <label class="control-label col-md-4" for="facsCount">Number of Facilities Under ${model.domainRef.domainname}:</label>
            <div class="col-md-8">
                <div class="form-group row">
                    <label class="control-label col-md-4" for="total">Total (All Levels):</label>
                    <div class="col-md-8"><c:if test="${model.count==0}">${model.count}</c:if><c:if test="${model.count>0}"><a href="#" onClick="ajaxSubmitData('domainFacSetting.htm', 'searchContent-pane', 'act=b&i=${model.domainRef.facilitydomainid}&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">${model.count}</a></c:if></div>
                    </div>
                <c:forEach items="${model.facLvlList}" var="level">
                    <div class="form-group row">
                        <label class="control-label col-md-4" for="${level.facilitylevelid}">${level.facilitylevelname}:</label>
                        <div class="col-md-8"><c:if test="${level.count==0}">${level.count}</c:if><c:if test="${level.count>0}"><a href="#" onClick="ajaxSubmitData('domainFacSetting.htm', 'searchContent-pane', 'act=b&i=${level.facilitylevelid}&b=b&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">${level.count}</a></c:if></div>
                        </div>
                </c:forEach>
                <!--
                <ul>
                        <li>Total of All Levels: [<c:if test="${model.count==0}">${model.count}</c:if><c:if test="${model.count>0}"><a href="#" onClick="">${model.count}</a></c:if>]</li>
                <c:forEach items="${model.facLvlList}" var="level">
                    <li>${level.facilitylevelname}: [<c:if test="${level.count==0}">${level.count}</c:if><c:if test="${level.count>0}"><a href="#" onClick="">${level.count}</a></c:if>]</li>
                </c:forEach>
            </ul>
                -->
            </div>
        </div>
        <div id="searchContent-pane"><a href="#" onClick="ajaxSubmitData('domainFacSetting.htm', 'searchContent-pane', 'act=a3&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">...</a></div>
    </fieldset>    
</div>