<%-- 
    Document   : itemstatistics
    Created on : Oct 1, 2019, 5:18:12 PM
    Author     : IICS TECHS
--%>
<%@include file="../../../include.jsp"%>
<table id="item-statistics-table" class="table table-bordered">
    <thead>
        <tr>
            <th>No.</th>
            <th>Item</th>
            <th>Quantity Received</th>
            <th>Quantity Issued</th>
            <th>View Details</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${items}" var="item">
            <tr>
                <td></td>
                <td>${item.itemname}</td>
                <td>${item.quantityreceived}</td>
                <td>${item.quantityissued}</td>
                <td>
                    <button class="view-item-details btn btn-sm btn-primary" onclick="displayItemDetails(${item.itemid}, '${item.itemname}');" <c:if test="${item.quantityreceived <= 0 && item.quantityissued <= 0}">disabled="disabled"</c:if>>
                        <i class="fa fa-dedent"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
    <tfoot></tfoot>
</table>

<script>
    $(function () {
        if (!$.fn.DataTable.isDataTable('#item-statistics-table')) {
            var table = $('#item-statistics-table').DataTable({
                "lengthMenu": [5, 10, 25, 50, 100],
                "pageLength": 5
            });
            table.on('order.dt search.dt', function () {
                table.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
    function displayItemDetails(itemId, itemName) {
        $.ajax({
            type: 'GET',
            url: 'dashboard/itemstatisticsdetails.htm',
            data: {itemid: itemId},
            success: function (data, textStatus, jqXHR) {
                debugger
                $.confirm({
                    title: itemName.toString().toUpperCase(),
                    type: 'purple',
                    typeAnimated: true,
                    boxWidth: '85%',
                    closeIcon: true,
                    useBootstrap: false,
                    content: data,
                    buttons: {
                        CLOSE: {
                            text: 'Close',
                            btnClass: 'btn btn-purple',
                            action: function () {
                            }
                        }
                    }
                });
            }
        });
    };
</script>