<%-- 
    Document   : response2
    Created on : Mar 22, 2018, 12:57:00 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.respMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Save Failed  <br/> 
                ${model.respMessage}
            </h2>
        </c:if>
    </div>
</div>