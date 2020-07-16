<%-- 
    Document   : internalOrders
    Created on : Sep 1, 2018, 1:20:11 PM
    Author     : HP
--%>
<%@include file="../../../include.jsp" %>
<div class="container-fluid" id="LabTestsmmmainLocalSettings">
    <div class="app-title">
        <div class="col-md-5">
            <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
            <p>Together We Save Lives...!</p>
        </div>

        <div>
            <div class="mmmains">
                <div class="wrapper">
                    <ul class="breadcrumbs">
                        <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('homepageicon.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                        <li><a href="#" onclick="ajaxSubmitData('store/inventoryAndSupplies.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Inventory & Supplies</a></li>
                        <li class="last active"><a href="#">Approve Facility Orders</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <main id="main">
        <input id="tab1" class="tabCheck" type="radio" name="tabs" checked>
        <label class="tabLabels" for="tab1">Internal Orders</label>

        <section class="tabContent" id="content1">
            <div class="row">
                <div class="col-md-11 col-sm-11 right">
                    <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-sliders" aria-hidden="true"></i>
                            </button>
                            <div class="dropdown-menu dropdown-menu-left">
                                <a class="dropdown-item" href="#" onclick="facilityapprovedandunapprovedorders('unapprove');" >Un Approved Orders</a><hr>
                                <a class="dropdown-item" href="#" onclick="facilityapprovedandunapprovedorders('approved');">Approved Orders</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div><br>
            <div id="facilityapprovedandunapprovedOrders">
                <div class="tile">
                    <div class="tile-title">
                        <h3>Un Approved Orders  <span class="badge badge badge-info">${internalorders}</span></h3>
                    </div>
                    <div class="tile-body">
                        <fieldset style="min-height:100px;">
                            <table class="table table-hover table-bordered" id="approveFacilityOrdersItems">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Order Number</th>
                                        <th>Items</th>
                                        <th>Ordering Unit</th>
                                        <th>Destination Unit</th>
                                        <th>Created By</th>
                                        <th>Date Created</th>
                                        <th>Date Needed</th>
                                        <th>Is Emergency</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int i = 1;%>
                                    <c:forEach items="${facilityinternalordersList}" var="a">
                                        <tr>
                                            <td align="center"><%=i++%></td>
                                            <td><a class="order-items-process" onclick="viewFacilityApproveOrderItems(${a.facilityorderid}, '${a.facilityorderno}');"><font color="blue"><strong>${a.facilityorderno}</strong></font></a></td>
                                            <td align="center"><span class="badge badge badge-info icon-custom" onclick="viewItemsOnOrders(${a.facilityorderid}, '${a.facilityorderno}');">${a.itemscount}</span></td>
                                            <td>${a.orderingstore}</td>
                                            <td>${a.destinationstore}</td>
                                            <td>${a.createdby}</td>
                                            <td>${a.dateprepared}</td>
                                            <td>${a.dateneeded}</td>
                                            <td align="center">
                                                <c:if test="${a.isemergency==true}"><span class="badge badge badge-success" style="width: 50%; height: 50%;">Yes</span></c:if>
                                                <c:if test="${a.isemergency==false}"><span class="badge badge badge-secondary" style="width: 50%; height: 50%;">No</span></c:if>
                                                </td>
                                            </tr>
                                    </c:forEach>
                                </tbody>
                            </table>  
                        </fieldset>
                    </div>
                </div>
            </div>
        </section>

    </main>
</div>
<script>
    $('#approveFacilityOrdersItems').DataTable();
    function facilityapprovedandunapprovedorders(type) {
        if (type === 'approved') {
            ajaxSubmitData('approvefacilityorders/approvedfacilityinternalorders.htm', 'facilityapprovedandunapprovedOrders', '', 'GET');
        } else {
            ajaxSubmitData('approvefacilityorders/approvefacilityinternalorders.htm', 'workpane', '', 'GET');
        }
    }
    function viewFacilityApproveOrderItems(facilityorderid, facilityorderno) {
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityorderid},
            url: "approvefacilityorders/viewfacilityapproveorderitems.htm",
            success: function (data) {
                $.confirm({
                    title: 'Approving <a href="#!">' + facilityorderno + '</a> ' + 'Order Items.',
                    content: '' + data,
                    type: 'purple',
                    boxWidth: '95%',
                    closeIcon: true,
                    useBootstrap: false,
                    typeAnimated: true,
                    buttons: {
                        tryAgain: {
                            text: 'Submit For Sunctioning',
                            btnClass: 'btn-purple',
                            action: function () {
                                var apprItems = $('#internalorderitemsapprovedId').val();
                                var unapprItems = $('#internalorderitemsunapprovedId').val();
                                if (parseInt(apprItems) === 0) {
                                    $.alert('No Items Approved On The Order');
                                    return false;
                                }
                                if (parseInt(unapprItems) !== 0) {
                                    $.confirm({
                                        title: 'Un Approved Order Item(s)',
                                        content: unapprItems + ' ' + 'Have not been Approved, Are You Sure You Want To Submit?',
                                        type: 'purple',
                                        typeAnimated: true,
                                        buttons: {
                                            tryAgain: {
                                                text: 'Yes, Submit',
                                                btnClass: 'btn-purple',
                                                action: function () {
                                                    saveapprovedOrder(facilityorderid);
                                                }},
                                            close: function () {
                                                viewFacilityApproveOrderItems(facilityorderid, facilityorderno);
                                            }
                                        }
                                    });
                                }
                                if (parseInt(unapprItems) === 0 && parseInt(apprItems) !== 0) {
                                    saveapprovedOrder(facilityorderid);
                                }
                            }
                        },
                        Close: function () {

                        }
                    }
                });
            }
        });
    }
    function saveapprovedOrder(facilityorderid) {
        $.ajax({
            type: 'POST',
            data: {facilityorderid: facilityorderid, type: 'submitted'},
            url: "approvefacilityorders/approvedfalityorderitem.htm",
            success: function (data) {
                $.confirm({
                    title: 'Submitting Approved Order',
                    content: 'Submitted Success Fully',
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        close: function () {
                            ajaxSubmitData('approvefacilityorders/approvefacilityinternalorders.htm', 'workpane', '', 'GET');
                        }
                    }
                });
            }
        });
    }
    function viewItemsOnOrders(facilityorderid, ordernumber) {
        $.ajax({
            type: 'GET',
            data: {facilityorderid: facilityorderid,act:'a'},
            url: "approvefacilityorders/viewItemsOnOrders.htm",
            success: function (data) {
                $.confirm({
                    title: '<a href="#!">' + ordernumber + '</a>. ' + 'FACILITY ORDER ITEMS',
                    content: '' + data,
                    type: 'purple',
                    useBootstrap: false,
                    boxWidth: '70%',
                    closeIcon:true,
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