<%-- 
    Document   : newOrder
    Created on : May 21, 2018, 5:49:00 PM
    Author     : IICS
--%>
<%@include file="../../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .error
    {
        border:1px solid red;
    }
    .label2 {
        height: 25px;
        margin:0 0 .5em;
    }
    .label2 {
        margin-right: .5em;
    }
</style>
<input id="externalfacilityunitfinancialyearid" value="0" type="hidden">
<table style="margin: 0px; width: 90%;">
    <tbody>
        <tr>
            <td align="center">
                <fieldset style="margin: 10px; width:80%;">
                    <legend>Create An External Order</legend>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile" id="createdExternalord">
                                <div class="tile-body">
                                    <form class="form-horizontal">
                                        <c:if test="${act=='a'}">
                                            <label class="control-label" style="color: red;" >No Active Facility Order</label>  
                                        </c:if>
                                            
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Order Type</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" value="External Order" disabled="true"> 
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Order Number</label>
                                            <div class="col-md-8">
                                                <select class="form-control col-md-8" id="facilityOrderNumbers">
                                                    <c:forEach items="${ordersFound}" var="order">
                                                        <option id="FacilityOrd${order.externalfacilityordersid}" data-ordernumber="${order.neworderno}" data-name="${order.suppliername}" data-supplier="${order.supplierid}" value="${order.externalfacilityordersid}">${order.neworderno}</option>  
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Supplier</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" id="facilityordersuppliername" type="text" placeholder="No Supplier" value="" disabled="true">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="control-label col-md-3">Order Origin</label>
                                            <div class="col-md-8">
                                                <input class="form-control col-md-8" type="text" placeholder="Logged In Unit" value="${loggedinfacilityunitname}" disabled="true">
                                            </div>
                                        </div>
                                    </form>

                                </div>
                                <c:if test="${act=='b'}">
                                    <div class="tile-footer">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-3">
                                                <button class="btn btn-primary" onclick="createExternalOrder(${size});" type="button"><i class="fa fa-fw fa-lg fa-plus"></i>Add Items To Order</button>&nbsp;&nbsp;&nbsp;<a class="btn btn-secondary" onclick="ajaxSubmitData('ordersmanagement/placeexternalordershome.htm', 'content2', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');" href="#"><i class="fa fa-fw fa-lg fa-times-circle"></i>Refresh</a>
                                            </div>
                                        </div>
                                    </div> 
                                </c:if>

                            </div>
                        </div>
                    </div>
                </fieldset>
            </td>
        </tr>
    </tbody>
</table>
<div class="row">
    <div class="col-md-12">
        <div id="addexternalitemsordersItemsdialog" class="supplierCatalogDialog addexternalitemsorderdialog">
            <div style="width:90% !important;">
                <div id="head">
                    <a href="#close" title="Close" class="close2" style="display: block;">X</a>
                    <h2 class="modalDialog-title" id="titleorexistingexreadyheading"> Add External Order Items</h2>
                    <hr>
                </div>
                <div class="row scrollbar" id="content">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <div class="tile" id="addexistingexternalitemstoorderdiv">

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
    var serverDate = '${serverdate}';
    $('#externaldateneeded').datetimepicker({
        pickTime: false,
        format: "DD/MM/YYYY",
        minDate: new Date(serverDate)
    });
    var facilityOrderNumbers = $('#facilityOrderNumbers').val();
    if (!facilityOrderNumbers) {

    } else {
        var suppliername = $('#FacilityOrd' + facilityOrderNumbers).data('name');
        document.getElementById('facilityordersuppliername').value = suppliername;
    }

    $('#facilityOrderNumbers').change(function () {
        var facilityOrderNumbers2 = $('#facilityOrderNumbers').val();
        var suppliername2 = $('#FacilityOrd' + facilityOrderNumbers2).data('name');
        document.getElementById('facilityordersuppliername').value = suppliername2;
    });

    function createExternalOrder(size) {
        if (size > 0) {
            var externalfacilityordersid = $('#facilityOrderNumbers').val();
            var facilityOrderNumber = $('#FacilityOrd' + externalfacilityordersid).data('ordernumber');
            var facilityordersuppliername = $('#facilityordersuppliername').val();
            var supplierid = $('#FacilityOrd' + externalfacilityordersid).data('supplier');
            $.ajax({
                type: 'GET',
                data: {facilityOrderNumber: facilityOrderNumber, externalfacilityordersid: externalfacilityordersid, facilityordersuppliername: facilityordersuppliername, supplierid: supplierid},
                url: "extordersmanagement/additemtoorder.htm",
                success: function (data, textStatus, jqXHR) {
                    window.location = '#addexternalitemsordersItemsdialog';
                    $('#addexistingexternalitemstoorderdiv').html(data);
                    initDialog('addexternalitemsorderdialog');
                }
            });
        }
    }

</script>



