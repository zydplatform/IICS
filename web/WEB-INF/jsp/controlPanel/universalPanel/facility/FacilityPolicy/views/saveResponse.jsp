<%-- 
    Document   : saveResponse
    Created on : Jul 4, 2018, 1:04:06 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.successMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Save Failed  <br/> 
                ${model.errorMessage}
            </h2>
        </c:if>
        <c:if test="${model.mainActivity=='AddFacilityPolicy'}">
            <c:if test="${not empty model.addedPolicyList}">   
                <table class="table table-hover table-bordered" id="responseTable">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.addedPolicyList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.policyname}</td>
                                <td align="left">${list.description}</td>
                                <td align="center"><c:if test="${list.status==true}">Saved</c:if><c:if test="${list.status==false}">Failed!</c:if></td>
                                </tr>
                        </c:forEach>
                        <c:forEach items="${model.failedPolicyList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.policyname}</td>
                                <td align="left">${list.description}</td>
                                <td align="center">Failed!</td>
                                </tr>
                        </c:forEach>        
                    </tbody>
                </table>
            </c:if>
        </c:if>
    </div>
</div>