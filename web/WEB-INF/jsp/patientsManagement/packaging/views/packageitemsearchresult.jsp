<%-- 
    Document   : packageitemsearchresult
    Created on : Sep 14, 2018, 11:14:37 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../include.jsp" %>
<input type="hidden" value="${searchValue}" id="itemsearchvalue"/>
<c:if test="${not empty items}">
    <ul class="items scrollbar" id="patientSearchScroll">
        <c:forEach items="${items}" var="item">
            <li class="classItem border-groove" onclick="viewitemdetails(${item.itemid}, '${item.fullname}',${item.stockid})">
                <h5 class="itemTitle">
                    ${item.fullname}
                </h5>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty items}">
    <p class="center">
        <br>
        <span class="">Item <span style="color: black !important; text-decoration: underline">${searchValue}</span> is not on your shelves<br>
    </p>
</c:if>
<script>
    function viewitemdetails(itemid,fullname,stockid){
        
        ajaxSubmitData('packaging/viewitemdetails.htm', 'ItemsearchResults', '&itemid=' + itemid + '&fullname=' + fullname +'&stockid=' + stockid + '', 'GET');
        
        
    }
</script>

