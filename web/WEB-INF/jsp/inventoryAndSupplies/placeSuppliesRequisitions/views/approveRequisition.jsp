<%-- 
    Document   : approveRequisition
    Created on : Nov 6, 2018, 8:30:33 PM
    Author     : HP
--%>

<%@include file="../../../include.jsp"%>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="sentSuppliesRequisitionDataTable">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Order Number</th>
                    <th class="center">No. of Items</th>
                    <th class="">Prepared By</th>
                    <th class="">Date Requested</th>
                    <th class="center">Approve</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="">
                <% int y = 1;%>
                <c:forEach items="${sentOrdersList}" var="a">
                    <c:choose>
                        <c:when test="${a.isemergency == 'true'}">
                            <tr id="" style="background-color: #fda4a4">
                                <td class="center"><%=y++%></td>
                                <td><strong>${a.orderno}</strong></td>
                                <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewRequisition(${a.suppliesorderid})" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                                <td class="">${a.requester}</td>
                                <td class="">${a.daterequested}</td>
                                <td class="center"><button data-facilityorderid="${a.suppliesorderid}" id="" style="margin-top: -5px" class="btn btn-success btn-sm supplies-order-approval" type="button"><i class="fa fa-share"></i></button></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr id="">
                                <td class="center"><%=y++%></td>
                                <td><strong>${a.orderno}</strong></td>
                                <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewRequisition(${a.suppliesorderid})" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                                <td class="">${a.requester}</td>
                                <td class="">${a.daterequested}</td>
                                <td class="center"><button data-suppliesorderid="${a.suppliesorderid}" id="" style="margin-top: -5px" class="btn btn-success btn-sm supplies-order-approval" type="button"><i class="fa fa-check"></i></button></td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
                
                <!--model Manage Order Items-->
<div class="">
    <div id="modalSuppliesOrderitems" class="modalOrderitemsdialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple">Order Processing...</font></h3>
                <a href="#close" title="Close" class="close2">X</a>
                <hr>
            </div>
            <div class="scrollbar row" id="content">

            </div>
        </div>
    </div>
</div>
                
<script>
    $('#sentSuppliesRequisitionDataTable').DataTable();
    
    $(document).ready(function () {
        $('#tableTodayProcessOrders').DataTable();
        breadCrumb();

        $('.supplies-order-approval').click(function () {
            var suppliesorderid = $(this).data("suppliesorderid");
            $('#content').html('');
            $.ajax({
                type: 'GET',
                data: {suppliesorderid: suppliesorderid},
                url: 'sandriesreq/suppliesRequestItemApproval.htm',
                success: function (items) {
                    $('#content').html(items);
                }
            });
            window.location = '#modalSuppliesOrderitems';
            initDialog('modalOrderitemsdialog');
        });
    });
    
    function functionViewRequisition(suppliesorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "sandriesreq/viewRequisitionItems.htm",
            data: {suppliesorderid: suppliesorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">SUPPLY REQUISITION ITEMS.</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '50%',
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