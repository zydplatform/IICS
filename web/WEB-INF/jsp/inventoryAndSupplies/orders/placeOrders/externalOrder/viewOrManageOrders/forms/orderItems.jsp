<%-- 
    Document   : orderItems
    Created on : Aug 27, 2018, 10:52:37 PM
    Author     : HP
--%>
<%@include file="../../../../../../include.jsp" %>
<div id="externalFacilityOrderDiv">
    <div style="margin: 10px;">
        <fieldset style="min-height:100px;">
            <table class="table table-hover table-bordered" id="facilityorderitemssTable">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Item</th>
                        <th>Quantity Ordered</th>
                            <c:if test="${status=='PAUSED'}">
                            <th>Edit | Remove</th>
                            </c:if>
                    </tr>
                </thead>
                <tbody>
                    <% int j = 1;%>
                    <c:forEach items="${orderItemsFound}" var="a">
                        <tr>
                            <td><%=j++%></td>
                            <td>${a.fullname}</td>
                            <td>${a.qtyordered}</td>
                            <c:if test="${status=='PAUSED'}">
                                <td align="center"> 
                                    <button onclick="editFacilityExternalorderitem(${a.facilityorderitemsid},${a.quantityordered}, '${a.fullname}',${facilityorderid},'${status}');"  title="Edit Order Item" class="btn btn-primary btn-sm add-to-shelf">
                                        <i class="fa fa-edit"></i>
                                    </button>
                                    |
                                    <button onclick="removeitemfromFacilityExternalorder(${a.facilityorderitemsid});"  title="Delete Item From Order" class="btn btn-primary btn-sm add-to-shelf">
                                        <i class="fa fa-remove"></i>
                                    </button>
                                </td>  
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table><br>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-12 right">
                        <c:if test="${status=='PAUSED'}">
                            <hr style="border:1px dashed #dddddd;">
                            <button type="button"  onclick="submitExternalFacilityOrder();" class="btn btn-primary">Submit</button> 
                        </c:if>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-12 right">
                        <c:if test="${status=='PAUSED'}">
                            <button type="button" class="btn btn-secondary" onclick="printingPatientPrescription();">
                                <i class="fa fa-plus"></i>  Add More Items
                            </button>    
                        </c:if>
                    </div>
                </div> 
            </div>
        </fieldset>
    </div>  
</div>
<script>
    $('#facilityorderitemssTable').DataTable();
    function editFacilityExternalorderitem(facilityorderitemsid, quantityordered, fullname,facilityorderid,status) {
        $.confirm({
            title: 'Edit' + ' ' + fullname,
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<label>Quantity Ordered</label>' +
                    '<input type="text" value="' + quantityordered + '" class="facilityquantityordered form-control" required />' +
                    '</div>' +
                    '</form>',
            type: 'purple',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Update',
                    btnClass: 'btn-purple',
                    action: function () {
                        var qtyordered = this.$content.find('.facilityquantityordered').val();
                        if (parseInt(qtyordered) === parseInt(quantityordered)) {

                        } else {
                            $.ajax({
                                type: 'POST',
                                data: {facilityorderitemsid: facilityorderitemsid, quantityordered: qtyordered},
                                url: "extordersmanagement/editFacilityExternalorderitem.htm",
                                success: function (data, textStatus, jqXHR) {
                                    ajaxSubmitData('extordersmanagement/facilityunitexternalorderitems.htm', 'externalFacilityOrderDiv', 'facilityorderid='+facilityorderid+'&status='+status+'&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                }
                            });
                        }
                    }
                },
                close: function () {
                }
            }
        });
    }
</script>