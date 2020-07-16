<%-- 
    Document   : selects
    Created on : Jul 31, 2018, 3:01:09 PM
    Author     :Uwera
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>



<c:if test="${model.formActivity=='Activity List'}">
    <select class="form-control col-md-5" id="audCat" name="audCat" onChange="clearDiv('activityPanel'); if(this.value==0){return false;} ajaxSubmitData('locations/locationsAuditor.htm', 'activityPanel', 'act=c&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr='+this.value+'', 'GET');">
        <option value="0">--Select Data Category--</option>
        <c:forEach items="${model.audActivityList}" var="list">                                
            <option value="${list}">${list}</option>
        </c:forEach>
    </select>
</c:if>
