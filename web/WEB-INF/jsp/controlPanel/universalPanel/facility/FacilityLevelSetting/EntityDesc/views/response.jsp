<%-- 
    Document   : response
    Created on : Dec 5, 2017, 2:45:35 PM
    Author     : samuelwam
--%>
<%@include file="../../../../../../include.jsp" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div id="levelResponsePane">

    <c:if test="${model.resp==true}">
        <h4>${model.successMessage}</h4>
        <h5><u><b>${model.catObj.categoryname}</b></u></h5>
                </c:if>
                <c:if test="${model.resp==false}">
        <h4>Sorry, Save Failed  <br/> 
            ${model.errorMessage}
        </h4>
    </c:if>

    <c:if test="${not empty model.descList}">   
        <table class="table table-bordered table-hover" id="sample-table-1">
            <thead>
                <tr>
                    <th class="center"></th>
                    <th>Description</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${model.descList}" var="list" varStatus="status" begin="0" end="${model.size}">
                    <tr>
                        <td align="left">&nbsp;</td>
                        <td align="left">${list.description}</td>                                            
                        <td align="center"><c:if test="${list.active==true}">Active</c:if><c:if test="${list.active==false}">Disabled</c:if></td>
                        </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>