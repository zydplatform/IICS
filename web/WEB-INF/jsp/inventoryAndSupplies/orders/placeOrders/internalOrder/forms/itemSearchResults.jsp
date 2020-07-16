<%-- 
    Document   : itemSearchResults
    Created on : Sep 16, 2018, 4:13:08 PM
    Author     : HP
--%>
<%@include file="../../../../../include.jsp" %>
<c:if test="${not empty itemsFound}">
    <ul class="items" id="foundItems">
        <c:forEach items="${itemsFound}" var="item">
            <li id="li${item.itemid}" class="classItem border-groove" onclick="additemquantity('${item.packagename}',${item.itemid});">
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