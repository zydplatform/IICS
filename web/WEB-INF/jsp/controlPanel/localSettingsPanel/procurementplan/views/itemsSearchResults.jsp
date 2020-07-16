<%-- 
    Document   : itemsSearchResults
    Created on : Apr 30, 2018, 2:55:47 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty items}">
    <ul class="items scrollbar" id="itemSearchScroll">
        <c:forEach items="${items}" var="item">
            <li class="classItem border-groove" onclick="searchItemsClick(${item.id}, '${item.name}')">
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
    function searchItemsClick(itemid, itemName) {
        var orderperiodtyp = $('#facilityunitfinancialprocurementorderperiodtype').val();
        $.ajax({
            type: 'GET',
            data: {itemid:itemid,itemName:itemName,orderperiodtyp:orderperiodtyp},
            url: "procurementplanmanagement/getitemconsumptionaveragefrompreviousfinancialyears.htm",
            success: function (data, textStatus, jqXHR) {
              $('#returninputfieldsdiv').html(data);
            }
        });
        $('#add_search_items').modal('show');
    }
</script>

