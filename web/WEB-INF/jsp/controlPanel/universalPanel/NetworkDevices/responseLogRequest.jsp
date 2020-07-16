<%-- 
    Document   : responseLogRequest
    Created on : Mar 6, 2018, 4:13:20 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.respMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2><font color='red'><b>Sorry, Save Failed</b></font><br/><br/> 
                ${model.respMessage}
            </h2>
        </c:if>
    </div>
</div>
