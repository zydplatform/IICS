<%-- 
    Document   : existingOrder
    Created on : May 21, 2018, 8:59:48 AM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<input id="existingcriteriaid" value="${criteria}" type="hidden">
<input id="existingfacilitysupplierid" value="${facilityunitsupplierid}" type="hidden">
<input id="existingdateneeded" value="${dateneeded}" type="hidden">
<input id="existingfacilityunitname" value="${supplierfacilityunitname}" type="hidden">
<table class="table table-hover table-bordered col-md-12" id="orderalreadyexistingtable">
    <thead class="col-md-12">
        <tr>
            <th class="center">No</th>
            <th>Order Number</th>
            <th class="">Destination Store</th>
            <th class="">Date Needed</th>
            <th class="">No. of Items</th>
            <th class="">Created By</th>
            <th class="">Order Stage</th>
            <th class="">Order Criteria</th>
            <th class="">Manage</th>
            <th class="">Discard</th>
        </tr>
    </thead>
    <tbody class="col-md-12">
        <% int y = 1;%>
        <c:forEach items="${ordersFound}" var="a">
            <tr>
                <td class="center"><%=y++%></td>
                <td class="">${a.facilityorderno}</td>
                <td class="">${a.facilityunitname}(${a.shortname})</td>
                <td class="">${a.dateneeded}</td>
                <td align="center"><span class="badge badge-pill badge-success">${a.internalordersitemscount}</span></td>
                <td class="">${a.personname}(ON ${a.dateprepared})</td>
                <td class="">
                    <c:if test="${a.status =='SUBMITTED'}">WAITING APPROVAL</c:if>
                    <c:if test="${a.status =='PAUSED'}">PAUSED</c:if>
                    <c:if test="${a.status =='SENT'}">WAITING SERVICING</c:if>
                    <c:if test="${a.status =='SERVICED'}">WAITING PICKING</c:if>
                </td>
                    <td class=""><c:if test="${a.isemergency ==true}">Emergency Order</c:if><c:if test="${a.isemergency ==false}">Normal Order</c:if></td>
                    <td align="center">
                    <c:if test="${a.status =='SUBMITTED' || a.status =='PAUSED'}">
                        <button onclick="manageexistingfacilityunitorder(${a.facilityorderid}, '${a.facilityorderno}', '${a.dateneeded}', '${a.facilityunitname}', '${a.personname}', '${a.dateprepared}', '${a.status}',${a.isemergency},${facilityunitsupplierid});"  title="Manage Order" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-dedent"></i>
                        </button>
                    </c:if> 
                    <c:if test="${a.status =='SENT' || a.status =='SERVICED'}">
                        <button disabled="true" onclick="manageexistingfacilityunitorder(${a.facilityorderid}, '${a.facilityorderno}', '${a.dateneeded}', '${a.facilityunitname}', '${a.personname}', '${a.dateprepared}', '${a.status}',${a.isemergency},${facilityunitsupplierid});"  title="Manage Order" class="btn btn-primary btn-sm add-to-shelf">
                            <i class="fa fa-dedent"></i>
                        </button>  
                    </c:if>
                </td>
                <td align="center">
                    <button onclick="discardexistingorder(${a.facilityorderid});"  title="Delete Order" class="btn btn-primary btn-sm add-to-shelf">
                        <i class="fa fa-remove"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="form-group">
    <div class="row">
        <div class="col-md-6">

        </div>

        <div class="col-md-4">
            <hr style="border:1px dashed #dddddd;">
            <button type="button" onclick="cancelexistsdialog();" class="btn btn-secondary btn-block">close</button>
        </div>   
    </div>
</div>
<script>
    document.getElementById('titleoralreadyheading').innerHTML = 'Order Already Exist !!!';
    $('#orderalreadyexistingtable').DataTable();
    function cancelexistsdialog() {
        window.location = '#close';
        ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
    }
    function discardexistingorder(facilityorderid) {
        var criteria = $('#existingcriteriaid').val();
        var facilitysupplierid = $('#existingfacilitysupplierid').val();
        var dateneeded = $('#existingdateneeded').val();
        var facilityunitname = $('#existingfacilityunitname').val();
        var facilityunitfinancialyearid = $('#existingfacilityunitfinancialyearid').val();

        $.confirm({
            title: 'Discard Order !',
            icon: 'fa fa-warning',
            content: 'Do You Want To Delete This Order ??',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderid: facilityorderid},
                            url: "ordersmanagement/deleteexistingfacilityunitorderanditems.htm",
                            success: function (data, textStatus, jqXHR) {
                                $.confirm({
                                    title: 'Discard Order!',
                                    content: 'Order Deleted Successfully, Create Order ??',
                                    type: 'orange',
                                    typeAnimated: true,
                                    buttons: {
                                        tryAgain: {
                                            text: 'Yes',
                                            btnClass: 'btn-orange',
                                            action: function () {
                                                ajaxSubmitData('ordersmanagement/addorderitems.htm', 'additemstoorderdiv', 'act=a&criteria=' + criteria + '&supplier=' + facilitysupplierid + '&dateneeded=' + dateneeded + '&type=internal&facilityunitname=' + facilityunitname + '&facilityunitfinancialyearid=' + facilityunitfinancialyearid + '&sStr=', 'GET');
                                            }
                                        },
                                        close: function () {
                                            window.location = '#close';
                                            ajaxSubmitData('ordersmanagement/placeordershome.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
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
    function manageexistingfacilityunitorder(facilityorderid, facilityorderno, dateneeded, facilityunitname, personname, dateprepared, status, isemergency, facilityunitsupplierid) {
        $.confirm({
            title: 'Modify Order!',
            icon: 'fa fa-warning',
            content: 'Are You Sure You Want To Modify This Order ?',
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-red',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderid: facilityorderid},
                            url: "ordersmanagement/approvingOrderprocess.htm",
                            success: function (data, textStatus, jqXHR) {
                                if (data === 'success') {
                                    ajaxSubmitData('ordersmanagement/manageexistingfacilityunitorderitems.htm', 'additemstoorderdiv', 'facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&dateneeded=' + dateneeded + '&facilityunitname=' + facilityunitname + '&personname=' + personname + '&dateprepared=' + dateprepared + '&status=' + status + '&isemergency=' + isemergency + '&facilityunitsupplierid=' + facilityunitsupplierid, 'GET');
                                } else {
                                    $.confirm({
                                        title: 'Modify Order!',
                                        icon: 'fa fa-warning',
                                        content: 'Can Not Be Modified Because Its Being Approved!!',
                                        type: 'red',
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