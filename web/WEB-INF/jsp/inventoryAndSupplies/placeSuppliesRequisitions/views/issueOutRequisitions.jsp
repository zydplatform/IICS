<%-- 
    Document   : issueOutRequisitions
    Created on : Nov 7, 2018, 4:13:45 AM
    Author     : HP
--%>
<%@include file="../../../include.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="tile">
    <div class="tile-body">
        <table class="table table-hover table-bordered col-md-12" id="table-supplies-approved-orders">
            <thead class="col-md-12">
                <tr>
                    <th class="center">No</th>
                    <th>Order Number</th>
                    <th class="center">No. of Items</th>
                    <th class="">Approved By</th>
                    <th class="">Date Approved</th>
                    <th class="">Date Requested</th>
                    <th class="center">Issue</th>
                </tr>
            </thead>
            <tbody class="col-md-12" id="">
                <% int y = 1;%>
                <c:forEach items="${readyToIssueList}" var="a">
                    <tr id="">
                        <td class="center"><%=y++%></td>
                        <td><strong>${a.orderno}</strong></td>
                        <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewReadyToIssueRequisition(${a.suppliesorderid})" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                        <td class="">${a.approvedby}</td>
                        <td class="">${a.dateapproved}</td>
                        <td class="">${a.daterequested}</td>
                        <td class="center"><button data-suppliesorderid="${a.suppliesorderid}" id="" style="margin-top: -5px" class="btn btn-success btn-sm supplies-order-issueout" type="button"><i class="fa fa-share"></i></button></td>
                    </tr>

                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!--model Manage Order Items-->
<div class="">
    <div id="modalSuppliesIssueOrderitems" class="modalOrderitemsdialog">
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
    $('#table-supplies-approved-orders').DataTable();
    
    $('.supplies-order-issueout').click(function () {
            var suppliesorderid = $(this).data("suppliesorderid");
            $('#content').html('');
            $.ajax({
                type: 'GET',
                data: {suppliesorderid: suppliesorderid},
                url: 'sandriesreq/suppliesRequesitionHandOverItems.htm',
                success: function (items) {
                    $('#content').html(items);
                }
            });
            window.location = '#modalSuppliesIssueOrderitems';
            initDialog('modalOrderitemsdialog');
        });

    function functionViewReadyToIssueRequisition(suppliesorderid) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "sandriesreq/viewRequisitionItemsApproved.htm",
            data: {suppliesorderid: suppliesorderid},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">SUPPLY APPROVED ITEMS.</strong>',
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