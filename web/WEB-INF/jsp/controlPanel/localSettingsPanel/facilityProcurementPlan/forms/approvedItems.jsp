<%-- 
    Document   : approvedItems
    Created on : Jun 6, 2018, 5:33:09 PM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">

    <div class="col-md-6">
        <div class="form-group row">
            <label class="control-label col-md-4">Approved Items Cost:</label>
            <div class="col-md-6">
                <button type="button" class="btn btn-primary" >
                        <span class="badge badge-light">${approvedItems}</span>
                    </i>
                </button>
            </div>
        </div>
    </div>
</div>
<table class="table table-hover table-bordered" id="tableApprovedFacilityprocplanItems">
    <thead>
        <tr>
            <th>No</th>
            <th>Generic Name</th>
                <c:if test="${istopdownapproach == false}">
                <th>Facility Units</th>
                </c:if>
            <th>Monthly Need</th>
            <th>${orderperiodtype} Need</th>
            <th>Approved</th>
        </tr>
    </thead>
    <tbody>
        <% int j = 1;%>
        <% int p = 1;%>
        <c:forEach items="${approveditems}" var="a">
            <tr>
                <td><%=j++%></td>
                <td>${a.genericname}</td>
                <c:if test="${istopdownapproach == false}">
                    <td align="center">
                        <button onclick="facilityunitsapprovedcountview(${a.itemid},${orderperiodid},${facilityfinancialyearid}, '${orderperiodtype}', '${a.genericname}');"  title="View Facility Unit." class="btn btn-primary btn-sm add-to-shelf">
                            ${a.facilityunitscount} &nbsp;Unit(s)
                        </button>
                    </td>  
                </c:if>
                <td>${a.averagemonthlyconsumption}</td>
                <td><c:if test="${orderperiodtype=='Quarterly'}">${a.averagequarterconsumption}</c:if><c:if test="${orderperiodtype=='Monthly'}">${a.averageannualcomsumption} </c:if><c:if test="${orderperiodtype=='Annually'}">${a.averageannualcomsumption}</c:if></td>                   
                    <td align="center">
                        <div class="toggle-flip">
                            <label>
                                        <input value="${a.facilityprocurementplanid}" id="pappsapproved<%=p++%>" type="checkbox" checked="checked" onchange="if (this.checked) {
                                                    approvedFacilityConsolidatedProcurementPlan('approve', this.id, this.value,${orderperiodid},${facilityfinancialyearid}, '${orderperiodtype}',${istopdownapproach});
                                                } else {
                                                    approvedFacilityConsolidatedProcurementPlan('disapprove', this.id, this.value,${orderperiodid},${facilityfinancialyearid}, '${orderperiodtype}',${istopdownapproach});
                                                }"><span class="flip-indecator" style="height: 10px !important;width:  32px !important;"  data-toggle-on="Yes" data-toggle-off="No"></span>
                        </label>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<div class="row">
    <div class="col-md-12" align="right"  >
        <button class="btn btn-primary" data-dismiss="modal">
            <i class="fa fa-check-circle"></i>
            close
        </button>
    </div>
</div>
<script>
    $('#tableApprovedFacilityprocplanItems').DataTable();
    function approvedFacilityConsolidatedProcurementPlan(type, id, value, orderperiodid, facilityfinancialyearid, orderperiodtype, istopdownapproach) {
        if (type === 'disapprove') {
            $.confirm({
                title: 'Un Approved Item!',
                content: 'Are You Sure You Want To Un Approve This Item?',
                type: 'red',
                icon: 'fa fa-warning',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Yes',
                        btnClass: 'btn-red',
                        action: function () {
                            $.ajax({
                                type: 'POST',
                                data: {facilityprocurementplanid: value, type: 'disapprove'},
                                url: "facilityprocurementplanmanagement/approvefacilityconsolidatedprocurementplanitems.htm",
                                success: function (data, textStatus, jqXHR) {
                                    if (data === 'success') {
                                        ajaxSubmitData('facilityprocurementplanmanagement/facilityprocuredprocuredprocurementplansitemsview.htm', 'facilityprocuredprocuredprocurementplansitemsdiv', 'act=a&facilityfinancialyearid=' + facilityfinancialyearid + '&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&istopdownapproach=' + istopdownapproach + '&ofst=1&maxR=100&sStr=', 'GET');
                                        ajaxSubmitData('facilityprocurementplanmanagement/approvedprocurementplanitems.htm', 'approvedItemzDiv', 'act=a&orderperiodtype=' + orderperiodtype + '&orderperiodid=' + orderperiodid + '&facilityfinancialyearid=' + facilityfinancialyearid + '&&istopdownapproach=' + istopdownapproach + '&maxR=100&sStr=', 'GET');
                                    }
                                }
                            });
                        }
                    },
                    close: function () {
                        $('#' + id).prop('checked', false);
                    }
                }
            });
        } else {
        }
    }
    function facilityunitsapprovedcountview(itemid, orderperiodid, facilityfinancialyearid, orderperiodtype, genericname) {
        ajaxSubmitData('facilityprocurementplanmanagement/facilityunitsitemvaluesview.htm', 'facilityunititemvaluesviewdiv', 'act=b&facilityfinancialyearid=' + facilityfinancialyearid + '&itemid=' + itemid + '&orderperiodid=' + orderperiodid + '&orderperiodtype=' + orderperiodtype + '&genericname=' + genericname + '&maxR=100&sStr=', 'GET');
        $('#facilityunititemvaluesview').modal('show');
    }
</script>