<%-- 
    Document   : itemSearchResult
    Created on : May 4, 2018, 6:14:43 AM
    Author     : IICS
--%>

<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty items}">
    <ul class="items scrollbar" id="itemSearchScroll">
        <c:forEach items="${items}" var="item">
            <li class="classItem border-groove" onclick="searchItemsClick2(${item.id}, '${item.name}')">
                <h5 class="itemTitle">
                    ${item.name}
                </h5>
                <p class="itemContent">
                    ${item.cat}
                </p>
            </li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty items}">
    <p class="center">
        <br>
        Item <strong>${name}</strong> Not Found.
    </p>
</c:if>
<script>
    function searchItemsClick2(itemid, itemName) {
        var orderperiodtyp=$('#pausedunitfinancialprocurementorderperiodtype').val();
        ajaxSubmitData('procurementplanmanagement/getitemconsumptionaveragefrompreviousfinancialyears.htm', 'pausedreturninputfieldsdiv', 'act=b&itemid=' + itemid + '&itemName='+ itemName +'&orderperiodtyp='+ orderperiodtyp +'&maxR=100&sStr=', 'GET');        
        $('#pausedadd_search_items').modal('show');
    }
</script>