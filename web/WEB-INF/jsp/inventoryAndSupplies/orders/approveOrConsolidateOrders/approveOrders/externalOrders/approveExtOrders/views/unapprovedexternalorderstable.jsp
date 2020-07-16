<%-- 
    Document   : unapprovedexternalorderstable
    Created on : Aug 7, 2018, 2:24:58 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../../../../include.jsp" %>
<div class="row">
    <div class="col-md-12">
        <div class="tile-body">
            <fieldset>
                <div class="tile">
                    <table class="table table-hover table-striped" id="externalOrdersTable">
                        <thead>
                            <tr>
                                <th class="center">#</th>
                                <th>Order Number</th>
                                <th>Supplier</th>
                                <th class="center">No. of Items</th>
                                <th class="">Created By</th>
                                <th class=""><span>Verify Items</span></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int m = 1;%>
                            <c:forEach items="${externalOrders}" var="a">
                                <tr id="${a.facilityorderid}" <c:if test="${a.currentDate > a.dateneeded}">style="color: red;"</c:if>>
                                    <td class="center"><%=m++%></td>
                                    <td><a><font color="blue"><strong>${a.neworderno}</strong></font></a></td>
                                    <td class=""><a onclick="viewsupplierdetails(${a.supplierid}, '${a.neworderno}', '${a.suppliername}')"><font color="blue"><strong>${a.suppliername}</strong></font></a></td>
                                    <td class="center"><span class="badge badge-pill badge-success" onclick="externalorderitems(${a.facilityorderid}, '${a.facilityorderno}')">${a.externalordersitemscount}</span></td>
                                    <td class="">${a.personname}</td>   
                                    <td align="center">
                                        <button style="cursor: pointer;" onclick="verifyexternalfacilityunitorders(${a.facilityorderid});"  title="Verify Order Items" class="btn btn-primary btn-sm add-to-shelf">
                                            <i class="fa fa-dedent"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </fieldset>
        </div>
    </div> 
</div>
<script>
    $('#externalOrdersTable').DataTable();

    function externalorderitems(facilityorderid, facilityorderno) {
        console.log(facilityorderno);
        $.ajax({
            type: "GET",
            cache: false,
            url: "externalordersapproval/viewExternalOrderItems.htm",
            data: {facilityorderid: facilityorderid},
            success: function (data) {
                $.confirm({
                    title: '<font color="green">' + '<strong class="center">Ordered Items Details' + '</font>' + '</strong>',
                    content: '' + data,
                    boxWidth: '40%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
    }

    function viewsupplierdetails(supplierid, neworderno, suppliername) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "externalordersapproval/viewExternalSupplierDetails.htm",
            data: {supplierid: supplierid},
            success: function (data) {
                $.dialog({
                    title: '<strong class="center">Order No:' + '<font color="green">' + neworderno + '</font><br>' + 'Supplier Details' + '</strong>',
                    content: '' + data,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true,
                    draggable: true
                });
            }
        });
    }
    function verifyexternalfacilityunitorders(facilityorderid) {
        
        $.ajax({
            type: "GET",
            cache: false,
            url: "externalordersapproval/verifyexternalfacilityunitorders.htm",
            data: {facilityorderid: facilityorderid},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Verify Ordered Items',
                    content: '' + data,
                    boxWidth: '60%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    closeIcon: true

                });
            }
        });
//        window.location = '#approveExtOrders';
//        initDialog('supplierCatalogDialog');

        //ajaxSubmitData('externalordersapproval/verifyexternalfacilityunitorders.htm', 'approvalcontents', 'facilityorderid=' + facilityorderid + '&facilityorderno=' + facilityorderno + '&nvb=0', 'GET');
    }

</script>
