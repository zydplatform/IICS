<%-- 
    Document   : deleteResponse
    Created on : Jul 11, 2018, 3:21:35 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.respMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Delete Failed  <br/> 
                ${model.respMessage}
            </h2>
        </c:if>
    </div>
</div>