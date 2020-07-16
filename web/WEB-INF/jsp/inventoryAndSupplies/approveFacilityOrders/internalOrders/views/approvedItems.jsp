<%-- 
    Document   : approvedItems
    Created on : Oct 1, 2018, 10:02:49 AM
    Author     : HP
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="approvedFacilityOrderdiv">
    <table class="table table-hover table-bordered" id="approvedFacilityOrderItems">
        <thead>
            <tr>
                <th>No</th>
                <th>Item Name</th>
                <th>Quantity Ordered</th>
                <th>Current Sock</th>
                <th>Approved</th>
            </tr>
        </thead>
        <tbody>
            <% int i = 1;%>
            <c:forEach items="${facilityorderitemsList}" var="a">
                <tr>
                    <td align="center"><%=i++%></td>
                    <td>${a.packagename}</td>
                    <td>${a.qtyordered}</td>
                    <td>${a.stockbalance}</td>
                    <td align="center">
                        <div class="toggle-flip">
                            <label>
                                <input id="unFacilityOrderItmid${a.facilityorderitemsid}" type="checkbox" checked="true" onchange="if (this.checked) {
                                        } else {
                                            unapproveFacilityOrderItm(${a.facilityorderitemsid}, 'unchecked',${facilityorderid}, this.id);
                                        }"><span class="flip-indecator" style="height: 10px !important; margin-top: -13px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                            </label>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $('#approvedFacilityOrderItems').DataTable();
    function unapproveFacilityOrderItm(facilityorderitemsid, type, facilityorderid, id) {
        $.confirm({
            title: 'Un Approve Order Item',
            content: 'Are You Sure You Want To Unprove This Item?',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-purple',
                    action: function () {
                        $.ajax({
                            type: 'POST',
                            data: {facilityorderitemsid: facilityorderitemsid},
                            url: "approvefacilityorders/unapproveFacilityOrderItem.htm",
                            success: function (data) {
                                ajaxSubmitData('approvefacilityorders/viewapprovedorderitemspno.htm', 'approvedFacilityOrderdiv', 'facilityorderid=' + facilityorderid, 'GET');
                            }
                        });
                    }
                },
                close: function () {
                    $('#' + id).prop('checked', true);
                }
            }
        });
    }
</script>