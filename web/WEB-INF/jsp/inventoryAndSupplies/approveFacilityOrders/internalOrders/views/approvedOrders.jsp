<%-- 
    Document   : approvedOrders
    Created on : Sep 1, 2018, 2:31:16 PM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<div class="tile">
    <div class="tile-title">
        <h3>Last Approved Orders  <span class="badge badge badge-info">${internalorders}</span></h3>
    </div>
    <div class="tile-body">
        <fieldset style="min-height:100px;">
            <div class="row">
                <div class="col-md-12">
                    <button class="btn btn-primary icon-btn pull-right" onclick="filterOrdersList(${internalorders})">
                        <i class="fa fa-filter" aria-hidden="true"></i>
                        Filter Orders
                    </button>
                </div>
            </div><br>

            <table class="table table-hover table-bordered" id="approvedFacilityOrders">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Order Number</th>
                        <th>Items</th>
                        <th>Ordering Unit</th>
                        <th>Destination Unit</th>
                        <th>Created By</th>
                        <th>Date Created</th>
                        <th>Date Approved</th>
                        <th>Approved By</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1;%>
                    <c:forEach items="${facilityinternalordersList}" var="a">
                        <tr>
                            <td align="center"><%=i++%></td>
                            <td><a class="order-items-process" onclick="viewLstApprovedOrderItems(${a.facilityorderid}, '${a.facilityorderno}');"><font color="blue"><strong>${a.facilityorderno}</strong></font></a></td>
                            <td align="center"><span class="badge badge badge-info icon-custom" onclick="viewApprovedOrderItems(${a.facilityorderid}, '${a.facilityorderno}');">${a.itemscount}</span></td>
                            <td>${a.orderingstore}</td>
                            <td>${a.destinationstore}</td>
                            <td>${a.createdby}</td>
                            <td>${a.dateprepared}</td>
                            <td>${a.dateapproved}</td>
                            <td>${a.approvedby}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </fieldset>
    </div>
</div>

<script>
    $('#approvedFacilityOrders').DataTable();
    function filterOrdersList(internalorders) {
        $.ajax({
            type: 'GET',
            data: {},
            url: "approvefacilityorders/filterfacilityapprovedorders.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: 'FILTER BY',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '50%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Filter',
                            btnClass: 'btn-purple',
                            action: function () {
                                var startdate = this.$content.find('.filterstartDate').val();
                                var enddate = this.$content.find('.filterendDate').val();
                                var facilityunit = this.$content.find('.filterordersby').val();

                                $.ajax({
                                    type: 'POST',
                                    data: {startdate: startdate, enddate: enddate, facilityunit: facilityunit, startdatesize: startdate.length, enddatesize: enddate.length, facilityunitsize: facilityunit.length},
                                    url: "approvefacilityorders/filterfacilityapprovedorderitems.htm",
                                    success: function (data) {
                                        $('#facilityapprovedandunapprovedOrders').html(data);
                                    }
                                });

                            }
                        },
                        close: function () {
                        }
                    }
                });
            }
        });
    }
    function viewLstApprovedOrderItems(facilityorderid, facilityorderno) {
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityorderid},
            url: "approvefacilityorders/viewLstApprovedOrderItems.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: '<a href="#!">' + facilityorderno + '</a> ' + 'Order Items.',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '70%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        });
    }
    function viewApprovedOrderItems(facilityorderid, facilityorderno) {
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityorderid,act:'b'},
            url: "approvefacilityorders/viewItemsOnOrders.htm",
            success: function (data, textStatus, jqXHR) {
                $.confirm({
                    title: '<a href="#!">' + facilityorderno + '</a> ' + 'Order Items.',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '70%',
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                        }
                    }
                });
            }
        });
    }
</script>
