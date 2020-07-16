<%-- 
    Document   : itemSearchResults
    Created on : Apr 10, 2018, 5:41:41 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<c:if test="${not empty items}">
    <ul class="items scrollbar" id="itemSearchScroll">
        <c:forEach items="${items}" var="item">
            <li class="classItem border-groove" onclick="searchItemClick(${item.id}, '${item.name}', '${item.packname}', ${item.packqty}, '${item.measure}')">
                <h5 class="itemTitle">
                    ${item.name}
                </h5>
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
    function searchItemClick(itemid, itemName, packname, packsize, measure) {
        itemQty = 0;
        packsQty = 1;
        looseQty = 0;
        totalItemQuantity = 0;
        $('#itemQty').val('');
        $('#packsQty').val('');
        $('#totalQty').val('');
        $('#looseQty').val('');
        document.getElementById('itemQty').focus();
        document.getElementById('itemid').value = itemid;
        document.getElementById('itemname').value = itemName;
        if (packname !== 'N/A') {
            $('#packageLabel').html(packname + ' Size');
            if (packsize === 1) {
                $('#packageQty').val(packsize + ' ' + measure);
            } else {
                $('#packageQty').val(packsize + ' ' + measure + '(s)');
            }
            size = parseInt(packsize);
            $('#packsLabel').html(packname + 's');
            $('#package').show();
        } else {
            $('#package').hide();
            $('#packsLabel').html('Quantity');
            size = 1;
        }
        $('#addItem').prop('disabled', true);
        $('#addadmintype').modal('show');
    }
</script>
