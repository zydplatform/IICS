<%-- 
    Document   : viewfacilityextorders
    Created on : Aug 16, 2018, 12:38:25 PM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp" %>
<table class="table table-hover table-bordered" id="tableFacilityexternalorders">
    <thead>
        <tr>
            <th>No</th>
            <th>Order No.</th>
            <th>Ordering Start Date</th>
            <th>Ordering End Date</th>
            <th>Approving Start Date</th>
            <th>Approving End Date</th>
            <th>Order Status</th>
            <th>Manage</th>
        </tr>
    </thead>
    <tbody>
        <% int k = 1;%>
        <c:forEach items="${externalFacOrders}" var="s">
            <tr id="${s.externalfacilityordersid}"  <c:if test="${s.isactive==true}">style="color: green;"</c:if>>
                <td><%=k++%></td>
                <td>${s.neworderno}</td>
                <td>${s.orderingstart}</td>
                <td>${s.orderingenddate}</td>
                <td>${s.approvalstartdate}</td>
                <td>${s.approvalenddate}</td>
                <td align="center">
                    <c:if test="${s.status=='after'}">
                        <button title=" The Items To Be Order For." class="btn btn-secondary btn-sm add-to-shelf" style="background-color: red; important">
                            DE-ACTIVE
                        </button>
                    </c:if>
                    <c:if test="${s.status=='before'}">
                        <button title=" The Items To Be Order For." class="btn btn-secondary btn-sm add-to-shelf" style="background-color: red; important">
                            DE-ACTIVE
                        </button>
                    </c:if>
                    <c:if test="${s.status=='now'}">
                        <button title=" The Items To Be Order For." class="btn btn-secondary btn-sm add-to-shelf" style="background-color: green; important">
                            ACTIVE
                        </button>
                    </c:if>
                </td>
                <td align="center">
                    <button  data-toggle="popover" onclick="editorderdates(${s.externalfacilityordersid}, '${s.orderingstart}', '${s.orderingenddate}', '${s.approvalstartdate}', '${s.approvalenddate}');" title="Facility Order Number.${s.neworderno}" class="btn btn-primary btn-sm add-to-shelf subscribe">
                        <i class="fa fa-fw fa-lg fa-dedent"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<script>
    $('#tableFacilityexternalorders').DataTable();
    function editorderdates(externalfacilityordersid, orderingstart, orderingenddate, approvalstartdate, approvalenddate) {
        $.ajax({
            type: "GET",
            cache: false,
            url: "extordersmanagement/updateOrderDates.htm",
            data: {externalfacilityordersid: externalfacilityordersid, orderingstart: orderingstart, orderingenddate: orderingenddate, approvalstartdate: approvalstartdate, approvalenddate: approvalenddate},
            success: function (data) {
                $.confirm({
                    title: '<strong class="center">Edit Order Dates' + '</strong>',
                    content: '' + data,
                    boxWidth: '35%',
                    useBootstrap: false,
                    type: 'purple',
                    typeAnimated: true,
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-green',
                            action: function () {
                                                               $.ajax({
                                    type: "POST",
                                    cache: false,
                                    url: "extordersmanagement/updatefacilityorderdates.htm",
                                    data: {externalfacilityordersid: externalfacilityordersid, orderingstartdate: orderingstart, orderingenddate: orderingenddate, approvalstartdate: approvalstartdate, approvalenddate: approvalenddate},
                                    success: function (response) {
                                        ajaxSubmitData('extordersmanagement/manageFacilityExternalOrders', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');
                                    }

                                });
                            }
                        },
                        cancel: {
                            text: 'Cancel',
                            btnClass: 'btn-red',
                            action: function () {
                            }
                        }
                    },
                });
            }
        });
    }

</script>
