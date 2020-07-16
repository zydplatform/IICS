<%-- 
    Document   : rejectedOrderItems
    Created on : Jun 26, 2019, 3:36:57 PM
    Author     : IICS TECHS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../../include.jsp"%>
<div class="row">
    <div class="col-md-12">
        <div class="tile">
            <div class="tile-title">
                <h5 style="color: #ff0000;"><c:if test='${orderstatus != "SENT"}'>This order has already been processed at the servicing unit. Please include these items in the next order.</c:if></h5>
            </div>
            <div class="tile-body">
                <table class="table table-hover table-bordered" id="rejected-items-table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th>Quantity Ordered</th>
                    <th>Approve</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1;%>
                <c:forEach items="${internalordersItems}" var="a">
                    <tr>
                        <td align="center"><%=i++%></td>
                        <td>${a.packagename}</td>
                        <td>${a.qtyordered}</td>
                        <td>
                            <div class="toggle-flip">
                                <label>
                                    <input type="checkbox" value="" class="item-toggle approve-rejected-item"
                                           data-facility-order-items-id="${a.facilityorderitemsid}"
                                           data-facility-order-id="${facilityorderid}"
                                           data-facility-order-no="${facilityorderno}"
                                           <c:if test='${orderstatus != "SENT"}'>disabled</c:if>/>
                                    <span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                                </label>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
            </div>
        </div>        
    </div>
</div>
<script>
    var table = $('#rejected-items-table').DataTable();
    table.on('click', '.approve-rejected-item', function(){
        var control = $(this);
        var checked = control.prop('checked');
        var facilityorderitemsid = control.data('facility-order-items-id');
        var facilityorderid = control.data('facility-order-id');
        var facilityorderno = control.data('facility-order-no');
        approveorunapproveorderitems(facilityorderitemsid, checked, facilityorderid, facilityorderno);
    }); 
    function approveorunapproveorderitems(facilityorderitemsid, checked, facilityorderid, facilityorderno) {
        if (checked) {
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid: facilityorderitemsid, type: 'approve'},
                url: "ordersmanagement/approveorunapprovefacilityunitorderitems.htm",
                success: function (data) {
                    if (data === 'success') {
                        $.toast({
                            heading: 'Success',
                            text: 'Operation Successful!',
                            icon: 'success',
                            hideAfter: 4000,
                            position: 'mid-center'
                        });                         
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'Operation Failed. Please Try Again.',
                            icon: 'error',
                            hideAfter: 4000,
                            position: 'mid-center'
                        }); 
                    }
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                data: {facilityorderitemsid: facilityorderitemsid, type: 'unapprove'},
                url: "ordersmanagement/approveorunapprovefacilityunitorderitems.htm",
                success: function (data) {
                    if (data === 'success') {
                       $.toast({
                            heading: 'Success',
                            text: 'Operation Successful!',
                            icon: 'success',
                            hideAfter: 4000,
                            position: 'mid-center'
                        }); 
                    } else {
                        $.toast({
                            heading: 'Error',
                            text: 'Operation Failed. Please Try Again.',
                            icon: 'error',
                            hideAfter: 4000,
                            position: 'mid-center'
                        }); 
                    }
                }
            });
        }
//        viewRejectedOrderItems(facilityorderid, facilityorderno);
    }
</script>        