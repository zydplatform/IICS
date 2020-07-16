<%-- 
    Document   : response
    Created on : Mar 6, 2018, 4:13:20 PM
    Author     : Samuel Wamukota <samuelwam@gmail.com>
--%>
<%@include file="../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:if test="${not empty model.returnURL}">
    <fieldset>
        <legend>
            <a id="back" href="#"  onClick="${model.returnURL}"> <i class="fa fa-backward"></i></a>
        </legend>
</c:if>
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
        <c:if test="${model.mainActivity=='Device Manufacturer'}">
                <table class="table table-bordered table-hover" id="sample-table-1">
                    <thead>
                        <tr>
                            <th class="center"></th>
                            <th>District</th>
                            <th>Region</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${model.deviceList}" var="list" varStatus="status" begin="0" end="${model.size}">
                            <tr>
                                <td align="left">&nbsp;</td>
                                <td align="left">${list.manufacturer}</td>
                                <td align="left">${list.description}</td>
                                </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </c:if>
    </div>
</div>
        <c:if test="${not empty model.returnURL}">
    </fieldset>
</c:if>
