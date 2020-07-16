<%-- 
    Document   : saveResponse
    Created on : Nov 6, 2018, 5:47:05 PM
    Author     : Uwera
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
        <c:if test="${model.mainActivity=='AddProgram'}">
            <c:if test="${not empty model.addedProgramList}">   
                <table class="table table-hover table-bordered" id="responseTable">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>Name</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.addedProgramList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.programname}</td>
                                <td align="center">Added!</td>
                                </tr>
                        </c:forEach>
                        <c:forEach items="${model.failedProgramList}" var="list" varStatus="status">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.programname}</td>
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