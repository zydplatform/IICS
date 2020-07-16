<%-- 
    Document   : incompleteOrders
    Created on : May 17, 2018, 3:38:39 PM
    Author     : IICS
--%>
<%@include file="../../../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fieldset>
    <legend>Created Orders</legend>
    <table class="table table-hover table-bordered" id="facilityunitorderstable">
        <c:if test="${act=='a'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Order Number</th>
                    <th>Destination</th>
                    <th>Items</th>
                    <th>Date Needed</th>
                    <th>Date Created</th>
                    <th>Created By</th>
                    <th>Order Stage</th>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody>
                <% int j = 1;%>
                <c:forEach items="${ordersFound}" var="a">
                    <tr>
                        <td><%=j++%></td>
                        <td>${a.facilityorderno}</td>
                        <td>${a.facilitysuppliername}(${a.shortname})</td>
                        <td align="center">
                            <button onclick="viewOrderItems(${a.facilityorderid}, '${a.facilityorderno}', '${a.facilitysuppliername}',${a.internalordersitemscount}, '${a.dateneeded}', '${a.dateprepared}', '${a.personname}', '${a.status}',${a.criteria});"  title="Items On Order" class="btn btn-secondary btn-sm add-to-shelf">
                                ${a.internalordersitemscount} Item(s)
                            </button></td>
                        <td>${a.dateneeded}</td>
                        <td>${a.dateprepared}</td>
                        <td>${a.personname}</td>
                        <td><c:if test="${a.status=='PAUSED'}">
                                <button onclick="viewpausedfacilityunitorder(${a.facilityorderid}, '${a.facilityorderno}', '${a.facilitysuppliername}',${a.internalordersitemscount}, '${a.dateneeded}', '${a.dateprepared}', '${a.personname}', 'PAUSED',${a.criteria});"  title="Add Items To This Order" class="btn btn-secondary btn-sm add-to-shelf">
                                    PAUSED
                                </button>
                            </c:if>
                            <c:if test="${a.status=='SUBMITTED'}">WAITING APPROVAL</c:if>
                            <c:if test="${a.status=='SENT'}">WAITING SERVICING</c:if>
                            <c:if test="${a.status=='SERVICED'}">SERVICED</c:if>
                            <c:if test="${a.status=='PICKED'}">READY TO PICK</c:if>
                            </td>
                            <td align="center"> 
    <!--                            <button onclick="deleteorderanditems(${a.facilityorderid});"  title="Delete or Recall Order" class="btn btn-primary btn-sm add-to-shelf">
                                    <i class="fa fa-remove"></i>
                                </button>-->
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <div class="btn-group" role="group">
                                    <button class="btn btn-sm btn-secondary dropdown-toggle" id="btnGroupDrop3" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fa fa-sliders" aria-hidden="true"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-left">
                                        <a class="dropdown-item" href="#!" onclick="deleteorderanditems(${a.facilityorderid});">Delete</a>
                                        <c:if test="${a.status=='SUBMITTED'}">
                                            <a class="dropdown-item" href="#" onclick="recallsubmittedorder(${a.facilityorderid}, '${a.facilityorderno}', '${a.facilitysuppliername}',${a.internalordersitemscount}, '${a.dateneeded}', '${a.dateprepared}', '${a.personname}', 'SUBMITTED',${a.criteria});">Edit(Recall)</a>  
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>
        <c:if test="${act=='b'}">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Order Number</th>
                    <th>Destination</th>
                    <th>Items</th>
                    <th>Date Needed</th>
                    <th>Date Created</th>
                    <th>Created By</th>
                    <th>Order Stage</th>
                </tr>
            </thead>
            <tbody>
                <% int d = 1;%>
                <c:forEach items="${ordersFound}" var="a">
                    <tr>
                        <td><%=d++%></td>
                        <td>${a.facilityorderno}</td>
                        <td>${a.facilitysuppliername}(${a.shortname})</td>
                        <td align="center">
                            <button onclick="viewOrderItems(${a.facilityorderid}, '${a.facilityorderno}', '${a.facilitysuppliername}',${a.internalordersitemscount}, '${a.dateneeded}', '${a.dateprepared}', '${a.personname}', '${a.status}',${a.criteria});"  title="Items On Order" class="btn btn-secondary btn-sm add-to-shelf">
                                ${a.internalordersitemscount} Item(s)
                            </button></td>
                        <td>${a.dateneeded}</td>
                        <td>${a.dateprepared}</td>
                        <td>${a.personname}</td>
                        <td><c:if test="${a.status=='DELIVERED'}">
                                PICKED 
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </c:if>

    </table>
</fieldset>
<div class="row">
    <div class="col-md-12">
        <div id="viewpausedfacilityunitorderdialog" class="supplierCatalogDialog viewpaused">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleitmsheading">Order Items</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="orderitemsdiv">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="prescribeunprescribedpatientords" class="prescriptionDiaolog prescribeunprescribedpatientord">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleoraldivreadyheading">Order Details</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div id="additemstoorderrecalldiv">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="viewpausedfacilityunitorderitmzdialog" class="modalDialog pausedItems">
            <div>
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleitmpaussheading">Order Items</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div id="orderitemspausdiv">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#facilityunitorderstable').DataTable();
    function viewpausedfacilityunitorder(facilityorderid, facilityorderno, facilitysuppliername, internalordersitemscount, dateneeded, dateprepared, personname, orderstage, criteria) {
        document.getElementById('titleitmsheading').innerHTML = facilityorderno + ' ' + 'Order Items';
        ajaxSubmitData('ordersmanagement/pausedfacilityorderitems.htm', 'orderitemsdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
        window.location = '#viewpausedfacilityunitorderdialog';
        initDialog('viewpaused');
    }
    function viewOrderItems(facilityorderid, facilityorderno, facilitysuppliername, internalordersitemscount, dateneeded, dateprepared, personname, orderstage, criteria) {
        document.getElementById('titleitmpaussheading').innerHTML = facilityorderno + ' ' + 'Order Items';
        ajaxSubmitData('ordersmanagement/viewpausedfacilityunitorderItms.htm', 'orderitemspausdiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
        window.location = '#viewpausedfacilityunitorderitmzdialog';
        initDialog('pausedItems');
    }
    function deleteorderanditems(facilityorderid) {
        $.confirm({
            title: 'Delete Order!',
            icon: 'fa fa-warning',
            content: 'Will Delete Order And Its Items !!',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes, Delete',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderid: facilityorderid},
                            url: "ordersmanagement/deleteexistingfacilityunitorderanditems.htm",
                            success: function (data, textStatus, jqXHR) {
                                $.confirm({
                                    title: 'Deleted Order!',
                                    content: 'Order Deleted Successfully !!',
                                    type: 'orange',
                                    typeAnimated: true,
                                    buttons: {
                                        tryAgain: {
                                            text: 'Ok',
                                            btnClass: 'btn-orange',
                                            action: function () {
                                                ajaxSubmitData('ordersmanagement/internalordersview.htm', 'createdordersdiv', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                close: function () {

                }
            }
        });
    }
    function recallsubmittedorder(facilityorderid, facilityorderno, facilitysuppliername, internalordersitemscount, dateneeded, dateprepared, personname, orderstage, criteria) {
        $.confirm({
            title: 'Edit Order!',
            content: 'Are You Sure You Want To Modify This Order??',
            type: 'red',
            icon: 'fa fa-warning',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes,Modify',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            url: "ordersmanagement/checkforapprovedorderitem.htm",
                            data: {facilityorderid: facilityorderid},
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    window.location = '#prescribeunprescribedpatientords';
                                    document.getElementById('titleoraldivreadyheading').innerHTML = facilityorderno + ' ' + 'Item(s)';
                                    ajaxSubmitData('ordersmanagement/recalledorderitems.htm', 'additemstoorderrecalldiv', 'act=a&facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&facilitysuppliername=' + facilitysuppliername + '&internalordersitemscount=' + internalordersitemscount + '&dateneeded=' + dateneeded + '&dateprepared=' + dateprepared + '&personname=' + personname + '&orderstage=' + orderstage + '&criteria=' + criteria + '&pgh=3', 'GET');
                                    initDialog('prescribeunprescribedpatientord');
                                } else {
                                    $.confirm({
                                        title: 'Edit Order!',
                                        content: 'Can Not Recall This Order Because Its Already Being Approved.',
                                        type: 'red',
                                        icon: 'fa fa-warning',
                                        typeAnimated: true,
                                        buttons: {
                                            close: function () {

                                            }
                                        }
                                    });
                                }
                            }

                        });

                    }
                },
                close: function () {
                }
            }
        });
    }
</script>