<%-- 
    Document   : saveResponse
    Created on : Aug 24, 2018, 10:43:38 AM
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
            <c:if test="${model.mainActivity!='Delete'}">
            <h2>Sorry, Save Failed  <br/> 
                </c:if>
                <c:if test="${model.mainActivity=='Delete'}">
            <h2>Sorry, Delete Failed  <br/> 
                </c:if>
                ${model.errorMessage}
            </h2>
        </c:if>
        <c:if test="${model.mainActivity=='AddSystemActivity'}">
            <c:if test="${not empty model.addedActivityList}">   
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
                        <c:forEach items="${model.addedActivityList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.activityname}</td>
                                <td align="left">${list.description}</td>
                                <td align="center"><c:if test="${list.active==true}">Saved</c:if><c:if test="${list.active==false}">Failed!</c:if></td>
                                </tr>
                        </c:forEach>
                        <c:forEach items="${model.failedActivityList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.activityname}</td>
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
<script>
    $(document).ready(function () {
        
    });
</script>