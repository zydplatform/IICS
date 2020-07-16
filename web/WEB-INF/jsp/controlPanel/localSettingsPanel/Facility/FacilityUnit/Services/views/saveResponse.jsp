<%-- 
    Document   : saveResponse
    Created on : Jul 4, 2018, 1:04:06 PM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="panel-body">
    <div class="table-responsive">
        <c:if test="${model.resp==true}">
            <h2>${model.successMessage}</h2>
        </c:if>
        <c:if test="${model.resp==false}">
            <h2>Sorry, Assignment Failed  <br/> 
                ${model.errorMessage}
            </h2>
        </c:if>
        <c:if test="${model.mainActivity=='AssignService'}">
            <c:if test="${not empty model.addedList}">   
                <table class="table table-hover table-bordered" id="responseTable">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>Unit Name</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.addedList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">${status.count}</td>
                                <td align="left">${list.facilityunitname}</td>
                                <td align="center">Successfully Assigned</td>
                                </tr>
                        </c:forEach>
                        <c:forEach items="${model.failedList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">${status.count}</td>
                                <td align="left">${list.facilityunitname}</td>
                                <td align="center">Failed!</td>
                            </tr>
                        </c:forEach>        
                    </tbody>
                </table>
            </c:if>
        </c:if>
        <c:if test="${model.mainActivity=='De-AssignService'}">
            <c:if test="${not empty model.addedList}">   
                <table class="table table-hover table-bordered" id="responseTable">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>Unit Name</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.addedList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">${status.count}</td>
                                <td align="left">${list.facilityunitname}</td>
                                <td align="center">Successfully De-Assigned</td>
                                </tr>
                        </c:forEach>
                        <c:forEach items="${model.failedList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">${status.count}</td>
                                <td align="left">${list.facilityunitname}</td>
                                <td align="center">Failed!</td>
                            </tr>
                        </c:forEach>        
                    </tbody>
                </table>
            </c:if>
        </c:if>    
    </div>
</div>