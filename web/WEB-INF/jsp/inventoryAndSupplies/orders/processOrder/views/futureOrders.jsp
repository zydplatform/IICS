<%-- 
    Document   : futureOrders
    Created on : May 16, 2018, 6:50:06 AM
    Author     : IICS-GRACE
--%>
<%@include file="../../../../include.jsp"%>
<div class="">
    <div class="">
        <div class="tile">
            <div class="tile-body">
                <table class="table table-hover table-bordered col-md-12" id="table-future-new-orders">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th>Order Number</th>
                            <th class="">Ordering Unit</th>
                            <th class="center">No. of Items</th>
                            <th class="">Prepared By</th>
                            <th class="">Approved By</th>
                            <th>Date Ordered</th>
                            <th>Date Required </th>
                            <th class="center">Override</th>
                        </tr>
                    </thead>
                    <tbody class="col-md-12" id="">
                        <% int f = 1;%>
                        <c:forEach items="${futureOrders}" var="a">
                            <tr id="${a.facilityorderid}">
                                <td class="center"><%=f++%></td>
                                <td><font color="blue"><strong>${a.facilityorderno}</strong></font></td>
                                <td class=""><font color="blue"><strong>${a.orderingUnit}</strong></font></td>
                                <td class="center"><span class="badge badge-pill badge-success"><a href="#" style="color: #fff" onclick="functionViewOrderItemsfut(${a.facilityorderid})">${a.numberofitems}</a></span></td>
                                <td class="">${a.preparedby}</td>
                                <td class="">${a.approvedby}</td>
                                <td>${a.dateprepared}</td>
                                <td>${a.dateneeded}</td>
                                <td class="center"><button data-facilityorderid="${a.facilityorderid}" id="" style="margin-top: -5px" class="btn btn-success btn-sm overridefutureorder" type="button"><i class="fa fa-level-down"></i></button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    $('#table-future-new-orders').DataTable();

    $('.overridefutureorder').click(function () {
        var facilityorderidfut = $(this).data("facilityorderid");
        $.confirm({
            icon: 'fa fa-warning',
            title: '<strong>Alert!</strong>',
            content: '' + '<strong style="font-size: 18px;"><font color="red">OVERRIDE</font> Future Order to Current Order</strong>',
            boxWidth: '30%',
            useBootstrap: false,
            type: 'red',
            typeAnimated: true,
            closeIcon: true,
            buttons: {
                somethingElse: {
                    text: 'Override',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: "GET",
                            cache: false,
                            url: "ordersmanagement/overridefutureorder.htm",
                            data: {facilityorderidfut: facilityorderidfut},
                            success: function (result) {
                                ajaxSubmitData('ordersmanagement/orderprocessmainpage', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
                    //close
                }
            }
        });
    });

    function functionViewOrderItemsfut(facilityorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "ordersmanagement/viewfacilityunitorderitemsFuture.htm",
            data: {facilityorderid: facilityorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">FUTURE ORDER ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    buttons: {
                        somethingElse: {
                            text: 'OK',
                            btnClass: 'btn-purple',
                            action: function () {
                            }
                        }
                    }
                });
            }
        });
    }
</script>