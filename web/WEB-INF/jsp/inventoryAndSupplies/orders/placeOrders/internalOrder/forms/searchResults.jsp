<%-- 
    Document   : searchResults
    Created on : Sep 17, 2018, 9:48:23 AM
    Author     : HP
--%>

<%@include file="../../../../../include.jsp" %>
<c:if test="${not empty itemsFound}">
    <ul class="items" id="foundItems">
        <c:forEach items="${itemsFound}" var="item">
            <li id="lisearch${item.itemid}" class="classItem border-groove" onclick="addexititemquantity('${item.packagename}',${item.itemid});">
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