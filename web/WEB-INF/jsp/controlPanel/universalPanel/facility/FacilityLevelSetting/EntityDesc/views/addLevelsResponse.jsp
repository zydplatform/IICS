<%-- 
    Document   : addLevelsResponse
    Created on : Dec 6, 2017, 12:38:29 PM
    Author     : samuelWam
--%>
<%@include file="../../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="box-title">
    <h3>
        <i class="fa fa-home"></i>
        School Registration Settings - ${model.descObj.description}
    </h3>
</div>
<table class="table table-striped table-bordered table-hover table-full-width" id="levelResp">
    <thead>
        <tr>
            <th>No</th>
            <th class="hidden-xs">Assigned Levels</th>
            <th>Report</th> 
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${model.customList}" var="list" varStatus="status" begin="0" end="${model.size}">
            <c:choose>
                <c:when test="${status.count % 2 != 0}">
                    <tr>
                    </c:when>
                    <c:otherwise>
                    <tr bgcolor="white">
                    </c:otherwise>
                </c:choose>
                <td>${status.count}</td>
                <td align="center">${list.facilitylevel.facilitylevelname}</td>
                <td align="center">${list.description}</td>                                            
                <td align="center"><c:if test="${list.status==true}">Success</c:if><c:if test="${list.status==false}">Failed!</c:if></td>
                </tr>
        </c:forEach>
    </tbody>
</table>
