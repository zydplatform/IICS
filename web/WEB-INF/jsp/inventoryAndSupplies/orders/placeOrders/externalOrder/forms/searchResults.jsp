<%-- 
    Document   : searchResults
    Created on : Aug 27, 2018, 5:02:44 AM
    Author     : HP
--%>
<%@include file="../../../../../include.jsp" %>
<c:if test="${not empty itemsFound}">
    <ul class="items" id="foundExternItems">
        <c:forEach items="${itemsFound}" var="item">
            <li id="liext${item.itemid}" class="classItem border-groove" onclick="addexternalitemquantity('${item.genericname}',${item.itemid});">
                <h5 class="itemTitle">
                    ${item.genericname}
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
        Item <strong>${name}</strong> Not Found.
    </p>
</c:if>