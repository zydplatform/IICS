<%-- 
    Document   : orderVerification
    Created on : Sep 4, 2018, 12:02:46 AM
    Author     : samuelwam <samuelwam@gmail.com>
--%>
<%@include file="../../../include.jsp"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<style>
    .order-items-process:hover{
        text-decoration: underline !important;
        cursor: pointer; 
    }
</style>

<div class="app-title" id="">
    <div class="col-md-5">
        <h1><i class="fa fa-hospital-o"></i>Customer Order Processing</h1>
        <p>New Order Verification and Scheduling</p>
    </div>

    <div>
        <div class="mmmains">
            <div class="wrapper">
                <ul class="breadcrumbs">
                    <li class="first"><a href="#" class="fa fa-home" onclick="ajaxSubmitData('Supplier/Menu/mainMenu.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');"></a></li>
                    <li><a href="#" onclick="ajaxSubmitData('Supplier/Store/orderManagement.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');">Order Processing</a></li>
                    <li class="last active"><a href="#">New Orders</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<c:if test="${emptyList==false}">
    <div class="">
        <div class="tile">
            <c:set var="i" value="0"></c:set>
            <div class="tile-body">
                <table class="table table-hover table-bordered col-md-12" id="tableTodayProcessOrders">
                    <thead class="col-md-12">
                        <tr>
                            <th class="center">No</th>
                            <th>Order Number</th>
                            <th class="">Client</th>
                            <th class="">Date Sent</th>
                            <th class="center">Date Needed</th>
                            <th class="center">No. of Items</th>
                            <th class="">Approved By</th>
                            <th class="">Elapsed Time</th>
                            <th class="">Verify</th>
                        </tr>
                    </thead>
                    <tbody class="col-md-12" id="">
                        <% int y = 1;%>
                        
                        <c:forEach items="${receivedOrders}" var="a">
                            <c:choose>
                                <c:when test="${a.emergencyCount == 1}">
                                    <tr id="" style="background-color: #fda4a4">
                                        <td class="center"><%=y++%><c:set var="i" value="${i+1}"></c:set></td>
                                        <td>
                                            <strong>${a.neworderno}</strong>
                                            <input type='hidden' id='facilityNo${i}' value='${a.neworderno}'/>
                                        </td>
                                        <td>
                                            <input type='hidden' id='facilityName${i}' value='${a.facilityname}'/>
                                            <a href="#" class="class-facility-unit-details" data-facilityid${i}="${a.facilityid}" onClick="functionViewFacilityDetails(${a.facilityid});"><font color="blue"><strong>${a.facilityname}</strong></font></a>
                                        </td>
                                        <td class=""><fmt:formatDate type="date" value="${a.datesent}"/></td>
                                        <td class="center"></td>
                                        <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewOrderItems(${a.externalfacilityordersid},'a')" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                                        <td class="">${a.personname}</td>
                                        <td class="center">${a.waitingTime}</td>
                                        <td class=""><input data-facilityorderid="${a.externalfacilityordersid}" value="${a.externalfacilityordersid}" id="verifyOrder[${i}]" type="checkbox" onChange="if(this.checked){$('#selectedOrder').val(this.value); $('#selectedItem').val(${i}); var orderSize=$('#itemSize').val(); funDisableOtherCheckBoxes(orderSize,'verifyOrder','${i}','ordersForm','check'); functionViewOrderItems(${a.externalfacilityordersid},'b'); $('#clientOrderNo').val($('#facilityNo${i}').val()); $('#orderClientName').val($('#facilityName${i}').val());}else{$('#selectedOrder').val(0); $('#selectedItem').val(0); funDisableOtherCheckBoxes(orderSize,'verifyOrder','${i}','ordersForm','uncheck');}"/></td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr id="">
                                        <td class="center"><%=y++%><c:set var="i" value="${i+1}"></c:set></td>
                                        <td>
                                            <strong>${a.neworderno}</strong>
                                            <input type='hidden' id='facilityNo${i}' value='${a.neworderno}'/>
                                        </td>
                                        <td>
                                            <input type='hidden' id='facilityName${i}' value='${a.facilityname}'/>
                                            <a href="#" class="class-facility-unit-details" data-facilityid${i}="${a.facilityid}" onClick="functionViewFacilityDetails(${a.facilityid});"><font color="blue"><strong>${a.facilityname}</strong></font></a>
                                        </td>
                                        <td class=""><fmt:formatDate type="date" value="${a.datesent}"/>:${a.datesent}</td>
                                        <td class="center"></td>
                                        <td class="center"><span class="badge badge-pill badge-success"><a onclick="functionViewOrderItems(${a.externalfacilityordersid},'a')" style="color: #fff" href="#">${a.numberofitems}</a></span></td>
                                        <td>${a.personname}</td>
                                        <td class="center">${a.waitingTime}</td>
                                        <td class="center">
                                            <input data-facilityorderid="${a.externalfacilityordersid}" value="${a.externalfacilityordersid}" id="verifyOrder[${i}]" type="checkbox" onChange="if(this.checked){$('#selectedOrder').val(this.value); $('#selectedItem').val(${i}); var orderSize=$('#itemSize').val(); funDisableOtherCheckBoxes(orderSize,'verifyOrder','${i}','ordersForm','check'); functionViewOrderItems(${a.externalfacilityordersid},'b'); $('#clientOrderNo').val($('#facilityNo${i}').val()); $('#orderClientName').val($('#facilityName${i}').val());}else{$('#selectedOrder').val(0); $('#selectedItem').val(0); funDisableOtherCheckBoxes(orderSize,'verifyOrder','${i}','ordersForm','uncheck');}"/>
                                            <!--
                                            <input class="order-items-process" data-facilityorderid="${a.externalfacilityordersid}" value="${a.externalfacilityordersid}" id="verifyOrder<%=y++%>" type="checkbox" onChange="if(this.checked){$('#selectedOrder').val(this.value); funDisableOtherCheckBoxes('${model.sizeCSA}','updateAssigt','${status.count}','inventory','uncheck');}else{$('#selectedOrder').val(0);}"/>
                                            <div class="toggle-flip">
                                                <label>
                                                    <input class="order-items-process" value="${a.externalfacilityordersid}" id="verifyOrder<%=y++%>p" type="checkbox" onChange="if (this.checked) {
                                        verifySelectedOrder(this.value, 'checked', ${a.externalfacilityordersid});
                                    } else {
                                        verifySelectedOrder(this.value, 'unchecked', ${a.externalfacilityordersid});
                                    }"><span class="flip-indecator"  style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                                </label>
                                            </div>
                                            -->
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div>
                <input type="hidden" id="selectedOrderId" value="0"/>
                <input type="hidden" id="selectedItem" value="0"/>
                <input type="hidden" id="itemSize" value="${i}"/>
                <input type="hidden" id="orderClientName" value=""/>
                <input type="hidden" id="clientOrderNo" value=""/>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${emptyList==true}">
    <fieldset>
        <div>
            <h2><font color="blue">No New Orders For Verification/Scheduling</font></h2>
        </div>
    </fieldset>

</c:if>


<!--model Manage Order Items-->
<div class="">
    <div id="modalOrderitems" class="modalOrderitemsdialog">
        <div class="">
            <div id="head">
                <h3 class="modal-title" id="title"><font color="purple">Client Order Verification</font></h3>
                <a href="#close" title="Close" class="close2" onClick="">X</a>
                <hr>
            </div>
            <div class="scrollbar row" id="content">
                
            </div>
        </div>
    </div>
</div>

<!-- FACILITY UNIT DESCRIPTION -->
<div class="modal fade col-md-12" id="modalExternalOrderDetails" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 153%;">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Client/Facility Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body" id="orderingUnitDetails">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="showgenericname"></div>
<script>
    $(document).ready(function () {
        $('#tableTodayProcessOrders').DataTable();
        breadCrumb();
        $('.order-items-process').click(function () {
            //var facilityorderid = $('#selectedOrderId').val();
            var facilityorderid = $(this).data("facilityorderid");
            $.ajax({
                type: 'GET',
                url: "Supplier/Store/newOrdersManager.htm",
                data: {act:'c',i:facilityorderid,b:'a',c:'b',d:0,ofst:1,maxR:100,sStr:''},
                success: function (items) {
                    $('#content').html(items);
                }
            });
            window.location = '#modalOrderitems';
            initDialog('modalOrderitemsdialog');
        });

        $('.class-facility-unit-details').click(function () {
            $('#modalExternalOrderDetails').modal('show');
        });
    });
    function functionViewFacilityDetails(id) {
        //ajaxSubmitData('Supplier/Store/newOrdersManager.htm', 'orderingUnitDetails', 'act=b&i='+id+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
        $.ajax({
                type: 'GET',
                url: "Supplier/Store/newOrdersManager.htm",
                data: {act:'b',i:id,b:'a',c:'b',d:0,ofst:1,maxR:100,sStr:''},
                success: function (items) {
                    $('#orderingUnitDetails').html(items);
                }
            });
    }

    function functionViewOrderItems(facilityorderid,act) {
        var title="FACILITY ORDERED ITEMS.";
        if(act==='b'){title="FACILITY ORDERED VERIFICATION.";}
        $.ajax({
            type: "GET",
            cache: false,
            url: "Supplier/Store/newOrdersManager.htm",
            data: {act:'c',i:facilityorderid,b:'a',c:act,d:0,ofst:1,maxR:100,sStr:''},
            success: function (jsonorderitemslist) {
                $.confirm({
                    title: '<strong class="center">'+title+'</strong>',
                    content: '' + jsonorderitemslist,
                    boxWidth: '90%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: false,
                    buttons: {
                        somethingElse: {
                            text: 'CLOSE',
                            btnClass: 'btn-purple',
                            action: function () {
                                var orderSize=$('#itemSize').val(); 
                                var item=$('#selectedItem').val(); 
                                funDisableOtherCheckBoxes(orderSize,'verifyOrder',item,'ordersForm','uncheck');
                            }
                        }
                    }
                });
            }
        });
    }
    function funDisableOtherCheckBoxes(size,elementIdName,elementNo,formName,activity){
        for (var x=1; x<=size; x++){
            if(x!==elementNo){
                if(activity==='check'){
                    document.getElementById(elementIdName+"["+x+"]").disabled=true;
                }
                else{
                    document.getElementById(elementIdName+"["+x+"]").disabled=false;
                    document.getElementById(elementIdName+"["+x+"]").checked=false;
                    //$("#"+elementIdName+"["+x+"]").prop('checked', false);
                }
            }
        }
    }
</script>