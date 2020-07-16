<%-- 
    Document   : searchResults
    Created on : Sep 30, 2018, 10:49:35 AM
    Author     : HP
--%>
<%@include file="../../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty itemsFound}">
    <ul class="items" id="foundItems1">
        <c:forEach items="${itemsFound}" var="item">
            <li id="li2${item.itemid}" class="classItem border-groove" onclick="addpausedorderitemquantity('${item.packagename}',${item.itemid});">
                <h5 class="itemTitle">
                    ${item.packagename}
                </h5>
                <p class="itemContent">
                    ${item.categoryname}
                </p>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty itemsFound}">
    <p class="center">
        <br>
        Item <strong>${searchValue}</strong> Not Found.
    </p>
</c:if>